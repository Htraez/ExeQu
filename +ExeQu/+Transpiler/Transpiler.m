classdef Transpiler
    properties
        text;
        allCmd;
        
        newAllCmd = [];
        
        tmpCmd = [];
        
        correctCmd;
        correctGate;
        correctQubit;
        
        qregName = [];
        cregName = [];
        
        noOfQreg = [];
        noOfCreg = [];
        
        gateName = [];
        gateArgs = [];
        gatePara = [];
        gateDetail = [];

        result = [];
        errorCmd = 0;
        
    end
    
    methods
        function self = convert(self,inFileName, outFileName)
            self = self.readFile(inFileName);
            self = self.seperateCommand(self.text);
            if self.errorCmd == 1
                disp("command syntax error");
                return;
            end
            self = self.translate(self.allCmd);
            if self.errorCmd == 1
                disp("command syntax error");
                return;
            end
            self.writeFile(self.result,outFileName);
        end
    end
    
    methods(Access=private)
        function self = readFile(self,inFileName)
            fileID = fopen(inFileName,'r');
            formatSpec = '%c';
            self.text = fscanf(fileID, formatSpec);
        end
        
%         function self = seperateCommand(self,text)
%             text = strrep(text,'{',';begin;');
%             text = strrep(text,'}',';end;');
%             self.allCmd = strsplit(text,{';','\n'});
%             self.allCmd = strtrim(self.allCmd);
%         end
        
        function self = seperateCommand(self,text)
            self.allCmd = strsplit(text,'\n');
            self.allCmd = strtrim(self.allCmd);
            for i= 1 : length(self.allCmd)
                if ~startsWith(self.allCmd{i},'//') && ~startsWith(self.allCmd{i},'gate')
                    if endsWith(self.allCmd{i},';')
                        self.allCmd{i} = regexprep(self.allCmd{i},';','');
                    else
                        self.errorCmd = 1;
                        disp("error on command "+self.allCmd{i});
                    end
                end
                if startsWith(self.allCmd{i},'gate')
                    if ~endsWith(self.allCmd{i},'}') || ~contains(self.allCmd{i},'{')
                        self.errorCmd = 1;
                        disp("error on command "+self.allCmd{i});
                    end
                end
            end
            self.allCmd = strtrim(self.allCmd);
        end
        
        function self = checkQregSyntax(self,qu)
            pass = 0;
            for i = 1 :length(qu)
                if contains(qu{i},{'[',']'})
                    tmp  = strsplit(qu{i},{'[',']'});
                    tmp(cellfun('isempty',tmp)) = [];
                    for j = 1 : length(self.qregName)
                        if strcmp(tmp{1},self.qregName{j}) && ( str2double(tmp{2}) <= str2double(self.noOfQreg{j}))
                            pass = pass+1;
                            break;
                        end
                    end
                else
                    for j = 1 : length(self.qregName)
                        if strcmp(qu{i},self.qregName{j})
                            pass = pass+1;
                            break;
                        end
                    end
                end
            end
            
            if pass == length(qu)
                self.correctQubit = pass;
            else
                self.correctQubit = 0;
            end
        end
        
        function self = checkGateSyntax(self,gate)
            self.correctGate = [];
            cmd = strrep(gate,'(',' ( ');
            cmd = strrep(cmd,')',' ) ');
            cmd = strtrim(cmd);
            if startsWith(cmd,'CX ')
                tmp = strsplit(cmd,{' ',','});
                if length(tmp)==3
                 self.correctGate = tmp;
                end
            elseif startsWith(cmd,'U ')
                tmp = strsplit(cmd,{' ',',','(',')'});
                if length(tmp)==5
                 self.correctGate = tmp;
                end
            else
                tmp = strsplit(cmd,{' ',','});
                if contains(cmd,{'(',')'})
                    openBra  = 0;
                    closeBra  = 0;
                    for i = 1 : length(tmp)
                        if strcmp(tmp{i},'(')
                            openBra = i;
                        elseif strcmp(tmp{i},')')
                            closeBra = i;
                            break;
                        end
                    end
                    noOfPara = closeBra-openBra-1;
                    tmp = strsplit(cmd,{' ',',','(',')'});
                    for i = 1 : length(self.gateName)
                        if strcmp(tmp{1},self.gateName{i})
                            if self.gatePara{i}==noOfPara && self.gateArgs{i}==(length(tmp)-1-noOfPara)
                                self.correctGate = tmp;
                                break;
                            end
                        end
                    end
                else
                    for i = 1 : length(self.gateName)
                        if strcmp(tmp{1},self.gateName{i})
                            if self.gateArgs{i}==(length(tmp)-1)
                                self.correctGate = tmp;
                                break;
                            end
                        end
                    end
                end
            end
        end
        
        function self = getParaTotal(self,cmd)
            openBra  = 0;
            closeBra  = 0;
            for i = 1 : length(cmd)
                if strcmp(cmd{i},'(')
                    openBra = i;
                elseif strcmp(cmd{i},')')
                    closeBra = i;
                    break;
                end
            end
            self.gatePara{length(self.gatePara)+1} = closeBra-openBra-1;
        end
        
        function self = checkQASMSyntax(self,cmd)
            self.correctCmd = {};
            cmd = strrep(cmd,'(',' ( ');
            cmd = strrep(cmd,')',' ) ');
            if startsWith(cmd,'OPENQASM ')
                tmp = strsplit(cmd,' ');
                tmp = strtrim(tmp);
                if( strcmp(tmp{1},'OPENQASM') && strcmp(tmp{2},'2.0') )
                    self.correctCmd = tmp;
                end
            elseif startsWith(cmd,'include ')
                tmp = strsplit(cmd,' ');
                tmp = strtrim(tmp);
                if( strcmp(tmp{1},'include') && startsWith(tmp{2},'"') && endsWith(tmp{2},'"') )
                    self.correctCmd = tmp;
                end
            elseif startsWith(cmd,'qreg ')
                tmp = strsplit(cmd,' ');
                tmp = strtrim(tmp);
                if strcmp(tmp{1},'qreg')
                    qreg = strrep(tmp{2},'[',' [ ');
                    qreg = strrep(qreg,']',' ] ');
                    qreg = strsplit(qreg,' ');
                    qreg = strtrim(qreg);
                    if strcmp(qreg{2},'[') && strcmp(qreg{4},']')
                        pattern = {'1','2','3','4','5','6','7','8','9','0'};
                        if ( ~isnan(str2double(qreg{3}))) && ( ~startsWith(qreg{1},pattern) )
                            qregNo = length(self.qregName);
                            self.qregName{qregNo+1} = qreg{1};
                            self.noOfQreg{qregNo+1} = qreg{3};
                            tmp = strrep(cmd,'[',' [ ');
                            tmp = strrep(tmp,']',' ] ');
                            tmp = strsplit(tmp,{' ','[',']'});
                            tmp = strtrim(tmp);
                            self.correctCmd = tmp;
                        end
                    end
                end
            elseif startsWith(cmd,'creg ')
                tmp = strsplit(cmd,' ');
                tmp = strtrim(tmp);
                if strcmp(tmp{1},'creg')
                    creg = strrep(tmp{2},'[',' [ ');
                    creg = strrep(creg,']',' ] ');
                    creg = strsplit(creg,' ');
                    creg = strtrim(creg);
                    if strcmp(creg{2},'[') && strcmp(creg{4},']')
                        pattern = {'1','2','3','4','5','6','7','8','9','0'};
                        if ( ~isnan(str2double(creg{3}))) && ( ~startsWith(creg{1},pattern) )
                            cregNo = length(self.cregName);
                            self.cregName{cregNo+1} = creg{1};
                            self.noOfCreg{cregNo+1} = creg{3};
                            tmp = strrep(cmd,'[',' [ ');
                            tmp = strrep(tmp,']',' ] ');
                            tmp = strsplit(tmp,{' ','[',']'});
                            tmp = strtrim(tmp);
                            self.correctCmd = tmp;
                        end
                    end
                end
            elseif startsWith(cmd,'CX ')
                tmp = strrep(cmd,',',' , ');
                tmp = strsplit(tmp,' ');
                tmp = strtrim(tmp);
                if strcmp(tmp{1},'CX') && strcmp(tmp{3},',')
                    
                    if ( ~isempty(strfind(tmp{2},'[')) ) && ( ~isempty(strfind(tmp{2},']')) ) && ( ~isempty(strfind(tmp{4},'[')) ) && ( ~isempty(strfind(tmp{4},']')) )
                        keep=0;
                        qb = strrep(tmp{2},'[',' [ ');
                        qb = strrep(qb,']',' ] ');
                        qb = strsplit(qb,' ');
                        qb = strtrim(qb);
                        if strcmp(qb{2},'[') && strcmp(qb{4},']')
                            for i=1:length(self.qregName)
                                if (strcmp(qb{1},self.qregName{i}))
                                    if ( ~isnan(str2double(qb{3})) )
                                        keep = keep+1;
                                    end
                                end
                            end
                        end
                        qb = strrep(tmp{4},'[',' [ ');
                        qb = strrep(qb,']',' ] ');
                        qb = strsplit(qb,' ');
                        qb = strtrim(qb);
                        if strcmp(qb{2},'[') && strcmp(qb{4},']')
                            for i=1:length(self.qregName)
                                if (strcmp(qb{1},self.qregName{i}))
                                    if ( ~isnan(str2double(qb{3})) )
                                        keep = keep+1;
                                    end
                                end
                            end
                        end
                        if(keep==2)
                            tmp = strrep(cmd,',',' , ');
                            tmp = strrep(tmp,'[',' [ ');
                            tmp = strrep(tmp,']',' ] ');
                            tmp = strsplit(tmp,{',',' ','[',']'});
                            tmp = strtrim(tmp);
                            self.correctCmd=tmp;
                        end
                        
                    else
                        for i = 1:length(self.qregName)
                            if (strcmp(tmp{2},self.qregName{i}))
                                for j = 1:length(self.qregName)
                                    if (strcmp(tmp{4},self.qregName{j}))
                                        if ( str2double(self.noOfQreg{i}) <= str2double(self.noOfQreg{j}))
                                            tmp = strrep(cmd,',',' , ');
                                            tmp = strsplit(tmp,{' ',','});
                                            tmp = strtrim(tmp);
                                            self.correctCmd = tmp;
                                            break;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif startsWith(cmd,'measure ')
                tmp = strrep(cmd,'->',' -> ');
                tmp = strsplit(tmp,' ');
                tmp = strtrim(tmp);
                if strcmp(tmp{1},'measure') && strcmp(tmp{3},'->')
                    if ( ~isempty(strfind(tmp{2},'[')) ) && ( ~isempty(strfind(tmp{2},']')) ) && ( ~isempty(strfind(tmp{4},'[')) ) && ( ~isempty(strfind(tmp{4},']')) )
                        keep=0;
                        qb = strrep(tmp{2},'[',' [ ');
                        qb = strrep(qb,']',' ] ');
                        qb = strsplit(qb,' ');
                        qb = strtrim(qb);
                        if strcmp(qb{2},'[') && strcmp(qb{4},']')
                            for i=1:length(self.qregName)
                                if (strcmp(qb{1},self.qregName{i}))
                                    if ( ~isnan(str2double(qb{3})) )
                                        keep = keep+1;
                                    end
                                end
                            end
                        end
                        cb = strrep(tmp{4},'[',' [ ');
                        cb = strrep(cb,']',' ] ');
                        cb = strsplit(cb,' ');
                        cb = strtrim(cb);
                        if strcmp(cb{2},'[') && strcmp(cb{4},']')
                            for i=1:length(self.cregName)
                                if (strcmp(cb{1},self.cregName{i}))
                                    if ( ~isnan(str2double(cb{3})) )
                                        keep = keep+1;
                                    end
                                end
                            end
                        end
                        if(keep==2)
                            tmp = strrep(cmd,'->',' -> ');
                            tmp = strrep(tmp,'[',' [ ');
                            tmp = strrep(tmp,']',' ] ');
                            tmp = strsplit(tmp,{'->',' ','[',']'});
                            tmp = strtrim(tmp);
                            self.correctCmd=tmp;
                        end
                    else
                        for i = 1:length(self.qregName)
                            if (strcmp(tmp{2},self.qregName{i}))
                                for j = 1:length(self.cregName)
                                    if (strcmp(tmp{4},self.cregName{j}))
                                        if ( str2double(self.noOfQreg{i}) <= str2double(self.noOfCreg{j}))
                                            tmp = strrep(cmd,'->',' -> ');
                                            tmp = strsplit(tmp,{' ','->'});
                                            tmp = strtrim(tmp);
                                            self.correctCmd = tmp;
                                            break;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif startsWith(cmd,'U ')
                tmp =  strsplit(cmd,{'(',')',' ', '[' ,']', ','});
                if length(tmp)==5
                    if(~isempty(str2num(tmp{2}))) && (~isempty(str2num(tmp{3}))) && (~isempty(str2num(tmp{4}))) 
                        for i = 1:length(self.qregName)
                            if (strcmp(tmp{5},self.qregName{i}))
                                self.correctCmd = tmp;
                            end
                        end
                    end
                else
                    if(~isempty(str2num(tmp{2}))) && (~isempty(str2num(tmp{3}))) && (~isempty(str2num(tmp{4}))) && (~isempty(str2num(tmp{6})))
                    
                        for i = 1:length(self.qregName)
                            if (strcmp(tmp{5},self.qregName{i}))
                                if ( str2double(self.noOfQreg{i}) >= str2double(tmp{6}))
                                    self.correctCmd = tmp;
                                end
                            end
                        end
                
                    end
                end
                
            elseif startsWith(cmd,'//')
                self.correctCmd{1} = cmd;
                return;
                
            elseif startsWith(cmd,'gate ')
                tmp = strrep(cmd,'}','');
                tmp = strtrim(tmp);
                tmp = strsplit(tmp,{'{',';'});
                tmp(cellfun('isempty',tmp)) = [];

                if contains(tmp{1},{'(',')'}) %new gate with parameter
                    tmp{1} = strtrim(tmp{1});
                    gateCreate = strsplit(tmp{1},{' ',','});
                    dup = 0;
                    if ~isempty(self.gateName)
                        for i = 1 : length(self.gateName)
                            if strcmp(gateCreate{2},self.gateName{1})
                                dup = 1;
                            end
                        end
                    end
                    error = 0;
                    if dup == 0
                        self.gateName{length(self.gateName)+1} = gateCreate{2};
                        self = self.getParaTotal(gateCreate);
                        self.gateArgs{length(self.gateArgs)+1} = length(gateCreate)-4-self.gatePara{length(self.gatePara)};
                        gateTmp=cell(1,length(tmp)-1);
                        index = length(self.gateDetail)+1;
                        count = 0;
                        for i = 2:length(tmp)
                            self = self.checkGateSyntax(tmp{i});
                            if ~isempty(self.correctGate)
                                count = count+1;
                                if strcmp(self.correctGate{1},'CX')
                                    for k = 2:3
                                        for j = self.gatePara{length(self.gatePara)}+5:length(gateCreate)
                                            if strcmp(gateCreate{j},self.correctGate{k})
                                                self.correctGate{k}=num2str(j-(self.gatePara{length(self.gatePara)}+4));
                                            end
                                        end
                                    end
                                    gateTmp{count} = self.correctGate{1}+" "+self.correctGate{2}+" "+self.correctGate{3};
                                elseif strcmp(self.correctGate{1},'U')
                                    for j = self.gatePara{length(self.gatePara)}+5:length(gateCreate)
                                        if strcmp(gateCreate{j},self.correctGate{5})
                                            self.correctGate{5}=num2str(j-(self.gatePara{index}+4));
                                        end
                                    end
                                    for j = 4:length(gateCreate)-self.gateArgs{index}
                                        if strcmp(gateCreate{j},self.correctGate{2})
                                            self.correctGate{2}=char(j-3+96);
                                        end
                                        if strcmp(gateCreate{j},self.correctGate{3})
                                            self.correctGate{3}=char(j-3+96);
                                        end
                                        if strcmp(gateCreate{j},self.correctGate{4})
                                            self.correctGate{4}=char(j-3+96);
                                        end
                                    end
                                    gateTmp{count} = self.correctGate{1}+" "+self.correctGate{2}+" "+self.correctGate{3}+" "+self.correctGate{4}+" "+self.correctGate{5};
                                else % new gate with parameter call another gate
                                    for j = 1 : length(self.gateName)
                                        if startsWith(self.correctGate{1},self.gateName{j})
                                            if self.gatePara{j} == 0 %ref gate no para
                                                tmpGateDetail = self.gateDetail{j};
                                                for x = 1 : length(tmpGateDetail)
                                                    count = count+1;
                                                    tmpGate2 = strsplit(tmpGateDetail{x},' ');
                                                    if strcmp(tmpGate2{1},'CX')
                                                        qubitNoforSwap = 0;
                                                        for a = 2:length(self.correctGate)
                                                            qubitNoforSwap = qubitNoforSwap+1;
                                                            for b = 2:3
                                                                if strcmp(num2str(qubitNoforSwap),tmpGate2{b})
                                                                    tmpGate2{b}=self.correctGate{a};
                                                                end
                                                            end
                                                        end
                                                        for a = 2:3
                                                            for b = 5+self.gatePara{index}:length(gateCreate)
                                                                if strcmp(gateCreate{b},tmpGate2{a})
                                                                    tmpGate2{a}=num2str(b-(self.gatePara{index}+4));
                                                                end
                                                            end
                                                        end
                                                        gateTmp{count} = tmpGate2{1}+" "+tmpGate2{2}+" "+tmpGate2{3};
                                                    elseif strcmp(tmpGate2{1},'U')
                                                        qubitNoforSwap=0;
                                                        for a = 2:length(self.correctGate)
                                                            qubitNoforSwap = qubitNoforSwap+1;
                                                            if strcmp(num2str(qubitNoforSwap),tmpGate2{5})
                                                                tmpGate2{5}=self.correctGate{a};
                                                            end
                                                        end
                                                        
                                                        for b = 5+self.gatePara{index}:length(gateCreate)
                                                            if strcmp(gateCreate{b},tmpGate2{5})
                                                                tmpGate2{5}=num2str(b-(self.gatePara{index}+4));
                                                            end
                                                        end
                                                        gateTmp{count} = tmpGate2{1}+" "+ tmpGate2{2}+" "+ tmpGate2{3}+" "+ tmpGate2{4}+" "+ tmpGate2{5};
                                                    end
                                                end
                                            else %ref gate have para
                                                tmpGateDetail = self.gateDetail{j};
                                                for x = 1 : length(tmpGateDetail)
                                                    count = count+1;
                                                    tmpGate2 = strsplit(tmpGateDetail{x},' ');
                                                    correctGateParaNo = self.gatePara{j};
                                                    if strcmp(tmpGate2{1},'CX')
                                                        qubitNoforSwap = 0;    
                                                        for c = 2+correctGateParaNo:length(self.correctGate)
                                                            qubitNoforSwap = qubitNoforSwap + 1;
                                                            for b = 2 : 3
                                                                if strcmp(num2str(qubitNoforSwap),tmpGate2{b})
                                                                    tmpGate2{b}=self.correctGate{c};
                                                                end
                                                            end
                                                        end
                                                        
                                                        for a = 2:3
                                                            for b = 5+self.gatePara{index}:length(gateCreate)
                                                                if strcmp(gateCreate{b},tmpGate2{a})
                                                                    tmpGate2{a}=num2str(b-(self.gatePara{index}+4));
                                                                end
                                                            end
                                                        end
                                                        
                                                        gateTmp{count} = tmpGate2{1}+" "+tmpGate2{2}+" "+tmpGate2{3};
                                                    elseif strcmp(tmpGate2{1},'U')
                                                        qubitNoforSwap = 0;    
                                                        for c = 2+correctGateParaNo:length(self.correctGate)
                                                            qubitNoforSwap = qubitNoforSwap + 1;
                                                            if strcmp(num2str(qubitNoforSwap),tmpGate2{5})
                                                                tmpGate2{5}=self.correctGate{c};
                                                            end
                                                        end
                                                        paraNoforSwap = 0;
                                                        for c = 2 : 2+correctGateParaNo-1
                                                            paraNoforSwap = paraNoforSwap + 1;
                                                            for b  = 2:4
                                                                if strcmp(char(paraNoforSwap+96),tmpGate2{b})
                                                                    tmpGate2{b}=self.correctGate{c};
                                                                end
                                                            end
                                                        end
                                                        for b = 5+self.gatePara{index}:length(gateCreate)
                                                            if strcmp(gateCreate{b},tmpGate2{5})
                                                                tmpGate2{5}=num2str(b-(self.gatePara{index}+4));
                                                            end
                                                        end
                                                        for b = 4:3+self.gatePara{index}
                                                            for c = 2:4
                                                                if strcmp(gateCreate{b},tmpGate2{c})
                                                                    tmpGate2{c}=char(b-3+96);
                                                                end
                                                            end
                                                        end
                                                        gateTmp{count} = tmpGate2{1}+" "+ tmpGate2{2}+" "+ tmpGate2{3}+" "+ tmpGate2{4}+" "+ tmpGate2{5};
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                error = 1;
                                break;
                            end
                        end
                        if error == 0
                            self.correctCmd{1} = "gate"; 
                            gateTmp(cellfun('isempty',gateTmp)) = [];
                            self.gateDetail{index} = gateTmp;
                        end
                    end
                else %new gate no parameter
                    tmp{1} = strtrim(tmp{1});
                    gateCreate = strsplit(tmp{1},{' ',','});
                    dup = 0;
                    if ~isempty(self.gateName)
                        for i = 1 : length(self.gateName)
                            if strcmp(gateCreate{2},self.gateName{1})
                                dup = 1;
                            end
                        end
                    end
                    error = 0;
                    if dup == 0
                        self.gateName{length(self.gateName)+1} = gateCreate{2};
                        self.gateArgs{length(self.gateArgs)+1} = length(gateCreate)-2;
                        self.gatePara{length(self.gatePara)+1} = 0;
                        gateTmp=cell(1,length(tmp)-1);
                        index = length(self.gateDetail)+1;
                        count = 0;
                        for i = 2:length(tmp)
                            self = self.checkGateSyntax(tmp{i});
                            if ~isempty(self.correctGate)
                                count = count+1;
                                if strcmp(self.correctGate{1},'CX')
                                    for k = 2:3
                                        for j = 3:length(gateCreate)
                                            if strcmp(gateCreate{j},self.correctGate{k})
                                                self.correctGate{k}=num2str(j-2);
                                            end
                                        end
                                    end
                                    gateTmp{count} = self.correctGate{1}+" "+self.correctGate{2}+" "+self.correctGate{3};
                                elseif strcmp(self.correctGate{1},'U')
                                    for j = 3:length(gateCreate)
                                        if strcmp(gateCreate{j},self.correctGate{5})
                                            self.correctGate{5}=num2str(j-2);
                                        end
                                    end
                                    gateTmp{count} = self.correctGate{1}+" "+self.correctGate{2}+" "+self.correctGate{3}+" "+self.correctGate{4}+" "+self.correctGate{5};
                                else % new gate no parameter call created gate
                                    for j = 1 : length(self.gateName)
                                        if startsWith(self.correctGate{1},self.gateName{j})
                                            if self.gatePara{j} == 0 %that ref gate no parameter
                                                tmpGateDetail = self.gateDetail{j};
                                                for x = 1 : length(tmpGateDetail)
                                                    count = count+1;
                                                    tmpGate2 = strsplit(tmpGateDetail{x},' ');
                                                    if strcmp(tmpGate2{1},'CX')
                                                        qubitNoforSwap = 0;
                                                        for a = 2:length(self.correctGate)
                                                            qubitNoforSwap = qubitNoforSwap+1;
                                                            for b = 2:3
                                                                if strcmp(num2str(qubitNoforSwap),tmpGate2{b})
                                                                    tmpGate2{b}=self.correctGate{a};
                                                                end
                                                            end
                                                        end
                                                        for a = 2:3
                                                            for b = 3:length(gateCreate)
                                                                if strcmp(gateCreate{b},tmpGate2{a})
                                                                    tmpGate2{a}=num2str(b-2);
                                                                end
                                                            end
                                                        end
                                                        gateTmp{count} = tmpGate2{1}+" "+tmpGate2{2}+" "+tmpGate2{3};
                    
                                                    elseif strcmp(tmpGate2{1},'U')
                                                        qubitNoforSwap=0;
                                                        for a = 2:length(self.correctGate)
                                                            qubitNoforSwap = qubitNoforSwap+1;
                                                            if strcmp(num2str(qubitNoforSwap),tmpGate2{5})
                                                                tmpGate2{5}=self.correctGate{a};
                                                            end
                                                        end
                                                        for b = 3:length(gateCreate)
                                                            if strcmp(gateCreate{b},tmpGate2{5})
                                                                tmpGate2{5}=num2str(b-2);
                                                            end
                                                        end
                                                        gateTmp{count} = tmpGate2{1}+" "+ tmpGate2{2}+" "+ tmpGate2{3}+" "+ tmpGate2{4}+" "+ tmpGate2{5};
                                                    end
                                                end
                                            else %that ref gate have parameter
                                                tmpGateDetail = self.gateDetail{j};
                                                correctGateParaNo = self.gatePara{j};
                                                for x = 1 : length(tmpGateDetail)
                                                    count = count+1;
                                                    tmpGate2 = strsplit(tmpGateDetail{x},' ');
                                                    if strcmp(tmpGate2{1},'CX')
                                                        qubitNoforSwap = 0;    
                                                        for c = 2+correctGateParaNo:length(self.correctGate)
                                                            qubitNoforSwap = qubitNoforSwap + 1;
                                                            for b = 2 : 3
                                                                if strcmp(num2str(qubitNoforSwap),tmpGate2{b})
                                                                    tmpGate2{b}=self.correctGate{c};
                                                                end
                                                            end
                                                        end
                                                        
                                                        for a = 2:3
                                                            for b = 3:length(gateCreate)
                                                                if strcmp(gateCreate{b},tmpGate2{a})
                                                                    tmpGate2{a}=num2str(b-2);
                                                                end
                                                            end
                                                        end
                                                        gateTmp{count} = tmpGate2{1}+" "+tmpGate2{2}+" "+tmpGate2{3};
                                                    elseif strcmp(tmpGate2{1},'U')
                                                        qubitNoforSwap = 0;    
                                                        for c = 2+correctGateParaNo:length(self.correctGate)
                                                            qubitNoforSwap = qubitNoforSwap + 1;
                                                            if strcmp(num2str(qubitNoforSwap),tmpGate2{5})
                                                                tmpGate2{5}=self.correctGate{c};
                                                            end
                                                        end
                                                        paraNoforSwap = 0;
                                                        for c = 2 : 2+correctGateParaNo-1
                                                            paraNoforSwap = paraNoforSwap + 1;
                                                            for b  = 2:4
                                                                if strcmp(char(paraNoforSwap+96),tmpGate2{b})
                                                                    tmpGate2{b}=self.correctGate{c};
                                                                end
                                                            end
                                                        end
                                                        for b = 3:length(gateCreate)
                                                            if strcmp(gateCreate{b},tmpGate2{5})
                                                                tmpGate2{5}=num2str(b-2);
                                                            end
                                                        end
                                                        gateTmp{count} = tmpGate2{1}+" "+ tmpGate2{2}+" "+ tmpGate2{3}+" "+ tmpGate2{4}+" "+ tmpGate2{5};
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                error = 1;
                                break;
                            end
                        end
                        if error == 0
                            self.correctCmd{1} = "gate"; 
                            gateTmp(cellfun('isempty',gateTmp)) = [];
                            self.gateDetail{index} = gateTmp;
                        end
                    end
                    
                end
            else
                for i = 1 : length(self.gateName)
                    if startsWith(cmd,self.gateName{i})
                        if self.gatePara{i} == 0 
                            tmp = strsplit(cmd,{' ',','});
                            qu = tmp(2:length(tmp));
                            self = self.checkQregSyntax(qu);
                            if self.correctQubit ~= 0 && self.gateArgs{i}==length(qu)
                                self.correctCmd = tmp;
                            end
                        else
                            tmp = strsplit(cmd,{' ',',','(',')'});
                            qu = tmp(2+self.gatePara{i}:length(tmp));
                            self = self.checkQregSyntax(qu);
                            if self.correctQubit ~= 0 && self.gateArgs{i}==length(qu)
                                self.correctCmd = tmp;
                            end
                        end
                    end
                end
            end
            
            if isempty(self.correctCmd)
                disp('Bad line of code skip...')
                disp(cmd)
            end
            
        end
        
        function writeFile(~,textToWirte, outFileName)
            fileID = fopen(outFileName,'w');
            textToWirte(cellfun('isempty',textToWirte)) = [];
            for k=1:length(textToWirte)
                if ~strcmp(textToWirte{k},"")
                   fprintf(fileID,'%s\n',textToWirte{k});
                end
            end
        end
        
        function self = translateCX(self,tmp,k)
            if(length(tmp)==3)
                  start_qreg = 0;
                  for no = 1: length(self.qregName)

                      if strcmp(tmp{2},self.qregName{no})
                          stop = str2double(self.noOfQreg{no});
                          break;
                      end
                      start_qreg = start_qreg + str2double(self.noOfQreg{no});
                  end

                  start_qreg2 = 0;
                  for no = 1: length(self.qregName)

                      if strcmp(tmp{3},self.qregName{no})

                          break;
                      end
                      start_qreg2 = start_qreg2 + str2double(self.noOfQreg{no});
                  end
                  
                  for j = 1: stop
                      q = start_qreg+j;
                      q2 = start_qreg2+j;
                      if j~=stop
                          self.result{k} = self.result{k}+"circuit.cnot("+q+","+q2+");"+newline;
                      else
                          self.result{k} = self.result{k}+"circuit.cnot("+q+","+q2+");";
                      end
                  end

             else
                  qreg1 = 0;
                  for no = 1: length(self.qregName)
                      if strcmp(tmp{2},self.qregName{no})
                          qreg1 = qreg1 + str2double(tmp{3}) + 1;
                          break;
                      end
                      qreg1 = qreg1 + str2double(self.noOfQreg{no});
                  end
                  qreg2 = 0 ;
                  for no = 1: length(self.qregName)
                      if strcmp(tmp{4},self.qregName{no})
                          qreg2 = qreg2 + str2double(tmp{5}) + 1;
                          break;
                      end
                      qreg2 = qreg2 + str2double(self.noOfQreg{no});
                  end
                  self.result{k} = self.result{k}+"circuit.cnot("+qreg1+","+qreg2+");";
             end
        end
        
        function self = translateU(self,tmp,k)
              if length(tmp)==5
                  start_qreg = 0;
                  for no = 1: length(self.qregName)
                      if strcmp(tmp{5},self.qregName{no})
                          stop = str2double(self.noOfQreg{no});
                          break;
                      end
                      start_qreg = start_qreg + str2double(self.noOfQreg{no});
                  end

                  for j = 1: stop
                      q = start_qreg+j;
                      if j~=stop
                          self.result{k} = self.result{k}+"circuit.u3("+q+","+tmp{2}+","+tmp{3}+","+tmp{4}+");"+newline;
                      else
                          self.result{k} = self.result{k}+"circuit.u3("+q+","+tmp{2}+","+tmp{3}+","+tmp{4}+");";
                      end
                  end

              else
                  qreg = 0;
                  for no = 1: length(self.qregName)
                      if strcmp(tmp{5},self.qregName{no})
                          qreg = qreg + str2double(tmp{6}) + 1;
                          break;
                      end
                      qreg = qreg + str2double(self.noOfQreg{no});
                  end
                  self.result{k} = self.result{k}+"circuit.u3("+qreg+","+tmp{2}+","+tmp{3}+","+tmp{4}+");";
              end
        end
        
        function self = translateInclude(self,cmd)
            self.tmpCmd = [];
            tmp2 = strsplit(cmd,'"');
            fileID = fopen(tmp2{2},'r');
            formatSpec = '%c';
            tmp3 = fscanf(fileID, formatSpec);
            self.tmpCmd = strsplit(tmp3,'\n');
            self.tmpCmd = strtrim(self.tmpCmd);
            for j= 1 : length(self.tmpCmd)
                if ~startsWith(self.tmpCmd{j},'//') && ~startsWith(self.tmpCmd{j},'gate')
                    if endsWith(self.tmpCmd{j},';')
                        self.tmpCmd{j} = regexprep(self.tmpCmd{j},';','');
                    else
                        self.errorCmd = 1;
                        disp("error on command "+self.tmpCmd{j});
                        return;
                    end
                end
                if startsWith(self.tmpCmd{j},'gate')
                    if ~endsWith(self.tmpCmd{j},'}') || ~contains(self.tmpCmd{j},'{')
                        self.errorCmd = 1;
                        disp("error on command "+self.tmpCmd{j});
                        return;
                    end
                end
            end
            self.tmpCmd = strtrim(self.tmpCmd);
        end
        
        function self = translate(self,codes)
            haveInclude = 1;
            while haveInclude == 1
                haveInclude = 0;
                for i = 1 : length(codes)
                    if startsWith(codes{i},'include ')
                        haveInclude = 1;
                        self = self.checkQASMSyntax(codes{i});
                        if ~isempty(self.correctCmd)
                            self = self.translateInclude(codes{i});
                            if self.errorCmd == 1
                                return;
                            end
                            if ~isempty(self.tmpCmd)
                                if isempty(self.newAllCmd)
                                    self.newAllCmd = [codes(1:i-1) self.tmpCmd codes(i+1:end)];
                                else
                                    for a = 1 : length(self.newAllCmd)
                                        if strcmp(self.newAllCmd{a},codes{i})
                                            self.newAllCmd = [self.newAllCmd(1:a-1) self.tmpCmd  self.newAllCmd(a+1:end) ];
                                            break;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                codes = self.newAllCmd;
            end
            
            
            
            for a = 1:length(codes)
                if startsWith(codes{a},'qreg') || startsWith(codes{a},'creg') 
                    self = self.checkQASMSyntax(codes{a});
                    
                end
            end
            for k=1:length(codes)
                if ~startsWith(codes{k},'qreg') && ~startsWith(codes{k},'creg') 
                    self = self.checkQASMSyntax(codes{k});
                else
                    self.correctCmd = [];
                    self.correctCmd{1} = "reg";
                end
                if k == 1
                    if ~isempty(self.correctCmd) && strcmp(self.correctCmd{1},'OPENQASM')
                        
                    else
                        disp("OPENQASM 2.0 must be on first line of code");
                        self.errorCmd = 1;
                        return;
                    end
                end
                 if ~isempty(self.correctCmd)
                     tmp = self.correctCmd;
                      if strcmp(tmp{1},'OPENQASM')
                          if k ~= 1 
                              disp("OPENQASM 2.0 must be on first line of code and no duplicate");
                              self.errorCmd = 1;
                              return;
                          end
                          self.result{k} = "import ExeQu.CircuitComposer.*;"+newline+"import ExeQu.Gates.*;";
                          
                          if ~isempty(self.qregName)
                              qreg=0;
                              for no = 1: length(self.qregName) 
                                  qreg = qreg + str2double(self.noOfQreg{no});
                              end
                              if isempty(self.cregName)
                                  self.result{k} = self.result{k}+newline+"circuit = Circuit("+qreg+","+qreg+");";
                              else
                                  creg=0;
                                  for no = 1: length(self.cregName) 
                                      creg = creg + str2double(self.noOfCreg{no});
                                  end
                                  self.result{k} = self.result{k}+newline+"circuit = Circuit("+qreg+","+creg+");";
                              end
                          end
                          
                      elseif strcmp(tmp{1},'include')
                          self.result{k} = strcat('%',tmp{1}," ",tmp{2});
                      elseif startsWith(tmp{1},'//') 
                          self.result{k} = strrep(tmp{1},'//','%');
                      elseif strcmp(tmp{1},'CX')
                          self.result{k} = "";
                          self = self.translateCX(tmp,k);
                      elseif strcmp(tmp{1},'measure')   
                          if(length(tmp)==3)
                              start_qreg = 0;
                              for no = 1: length(self.qregName)
                                  if strcmp(tmp{2},self.qregName{no})
                                      stop = str2double(self.noOfQreg{no});
                                      break;
                                  end
                                  start_qreg = start_qreg + str2double(self.noOfQreg{no});
                              end
                              
                              start_creg = 0;
                              for no = 1: length(self.cregName)
                                  
                                  if strcmp(tmp{3},self.cregName{no})
                                      
                                      break;
                                  end
                                  start_creg = start_creg + str2double(self.noOfCreg{no});
                              end
                              self.result{k} = "";
                              for j = 1: stop
                                  q = start_qreg+j;
                                  c = start_creg+j;
                                  if j~=stop
                                      self.result{k} = self.result{k}+"circuit.measure("+q+","+c+");"+newline;
                                  else
                                      self.result{k} = self.result{k}+"circuit.measure("+q+","+c+");";
                                  end
                              end
                              
                          else
                              qreg = 0;
                              for no = 1: length(self.qregName)
                                  if strcmp(tmp{2},self.qregName{no})
                                      qreg = qreg + str2double(tmp{3}) + 1;
                                      break;
                                  end
                                  qreg = qreg + str2double(self.noOfQreg{no});
                              end
                              creg = 0 ;
                              for no = 1: length(self.cregName)
                                  if strcmp(tmp{4},self.cregName{no})
                                      creg = creg + str2double(tmp{5}) + 1;
                                      break;
                                  end
                                  creg = creg + str2double(self.noOfCreg{no});
                              end
                              self.result{k} = "circuit.measure("+qreg+","+creg+");";
                          end
                      elseif strcmp(tmp{1},'reg')
                          self.result{k} = "";
                      elseif strcmp(tmp{1},'U')
                          self.result{k} = "";
                          self = self.translateU(tmp,k);
                      elseif strcmp(tmp{1},'gate')
                          self.result{k} = [];
                      else
                          for i = 1 : length(self.gateName)
                                if startsWith(tmp{1},self.gateName{i})
                                    if self.gatePara{i} == 0 
                                        quNo = 0;
                                        gateCall = self.gateDetail{i};
                                        for j = 2:length(tmp)
                                            quNo = quNo+1;
                                            for z = 1 : length(gateCall)
                                                tmpGate = strsplit(gateCall{z},' ') ;
                                                if strcmp(tmpGate{1},'CX')
                                                    if strcmp(tmpGate{2},num2str(quNo))
                                                        tmpGate{2}=tmp{j};
                                                        gateCall{z} = tmpGate{1}+" "+tmpGate{2}+" "+tmpGate{3};
                                                    end
                                                    if strcmp(tmpGate{3},num2str(quNo))
                                                        tmpGate{3}=tmp{j};
                                                        gateCall{z} = tmpGate{1}+" "+tmpGate{2}+" "+tmpGate{3};
                                                    end
                                                elseif strcmp(tmpGate{1},'U')
                                                    if strcmp(tmpGate{5},num2str(quNo))
                                                        tmpGate{5}=tmp{j};
                                                        gateCall{z} = tmpGate{1}+" "+tmpGate{2}+" "+tmpGate{3}+" "+tmpGate{4}+" "+tmpGate{5};
                                                    end
                                                end
                                            end
                                        end
                                        
                                        self.result{k}="";
                                        for j = 1 : length(gateCall)
                                            tmpGate = strsplit(gateCall{j},{' ','[',']'}) ;
                                            if strcmp(tmpGate{1},'CX')
                                                self = self.translateCX(tmpGate,k);
                                            elseif strcmp(tmpGate{1},'U')
                                                self = self.translateU(tmpGate,k);
                                            end
                                            if j~=length(gateCall)
                                                self.result{k}=self.result{k}+newline;
                                            end
                                        end
                                       
                                    else
                                        quNo = 0;
                                        paraNo = 0;
                                        gateCall = self.gateDetail{i};
                                        for j = 2 : 1+self.gatePara{i}
                                            paraNo = paraNo+1;
                                            for z = 1 : length(gateCall)
                                                tmpGate = strsplit(gateCall{z},' ') ;
                                                if strcmp(tmpGate{1},'U')
                                                    if strcmp(tmpGate{2},char(paraNo+96))
                                                        tmpGate{2}=tmp{j};
                                                        gateCall{z} = tmpGate{1}+" "+tmpGate{2}+" "+tmpGate{3}+" "+tmpGate{4}+" "+tmpGate{5};
                                                    end
                                                    if strcmp(tmpGate{3},char(paraNo+96))
                                                        tmpGate{3}=tmp{j};
                                                        gateCall{z} = tmpGate{1}+" "+tmpGate{2}+" "+tmpGate{3}+" "+tmpGate{4}+" "+tmpGate{5};
                                                    end
                                                    if strcmp(tmpGate{4},char(paraNo+96))
                                                        tmpGate{4}=tmp{j};
                                                        gateCall{z} = tmpGate{1}+" "+tmpGate{2}+" "+tmpGate{3}+" "+tmpGate{4}+" "+tmpGate{5};
                                                    end
                                                end
                                            end
                                        end
                                        for j = 2+self.gatePara{i}:length(tmp)
                                            quNo = quNo+1;
                                            for z = 1 : length(gateCall)
                                                tmpGate = strsplit(gateCall{z},' ') ;
                                                if strcmp(tmpGate{1},'CX')
                                                    if strcmp(tmpGate{2},num2str(quNo))
                                                        tmpGate{2}=tmp{j};
                                                        gateCall{z} = tmpGate{1}+" "+tmpGate{2}+" "+tmpGate{3};
                                                    end
                                                    if strcmp(tmpGate{3},num2str(quNo))
                                                        tmpGate{3}=tmp{j};
                                                        gateCall{z} = tmpGate{1}+" "+tmpGate{2}+" "+tmpGate{3};
                                                    end
                                                elseif strcmp(tmpGate{1},'U')
                                                    if strcmp(tmpGate{5},num2str(quNo))
                                                        tmpGate{5}=tmp{j};
                                                        gateCall{z} = tmpGate{1}+" "+tmpGate{2}+" "+tmpGate{3}+" "+tmpGate{4}+" "+tmpGate{5};
                                                    end
                                                end
                                            end
                                        end
                                        
                                        self.result{k}="";
                                        for j = 1 : length(gateCall)
                                            tmpGate = strsplit(gateCall{j},{' ','[',']'}) ;
                                            if strcmp(tmpGate{1},'CX')
                                                self = self.translateCX(tmpGate,k);
                                            elseif strcmp(tmpGate{1},'U')
                                                self = self.translateU(tmpGate,k);
                                            end
                                            if j~=length(gateCall)
                                                self.result{k}=self.result{k}+newline;
                                            end
                                        end
                                    end
                                end
                          end
                      end
                 end
            end
        end
        
    end
    
end

