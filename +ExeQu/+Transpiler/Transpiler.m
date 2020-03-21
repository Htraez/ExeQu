classdef Transpiler
    properties
        text;
        allCmd;
        correctCmd;
        
        qregName = [];
        cregName = [];
        
        noOfQreg = [];
        noOfCreg = [];

        result = [];
        
    end
    
    methods
        function self = convert(self,inFileName, outFileName)
            self = self.readFile(inFileName);
            self = self.seperateCommand(self.text);
            self = self.translate(self.allCmd);
            self.writeFile(self.result,outFileName);
        end
    end
    
    methods(Access=private)
        function self = readFile(self,inFileName)
            fileID = fopen(inFileName,'r');
            formatSpec = '%c';
            self.text = fscanf(fileID, formatSpec);
        end
        
        function self = seperateCommand(self,text)
            text = strrep(text,'{',';begin;');
            text = strrep(text,'}',';end;');
            self.allCmd = strsplit(text,{';','\n'});
            self.allCmd = strtrim(self.allCmd);
        end
        
        function self = checkQASMSyntax(self,cmd)
            
            self.correctCmd = {};
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
            elseif startsWith(cmd,'cx ')
                tmp = strrep(cmd,',',' , ');
                tmp = strsplit(tmp,' ');
                tmp = strtrim(tmp);
                if strcmp(tmp{1},'cx') && strcmp(tmp{3},',')
                    
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
            elseif startsWith(cmd,'//')
                self.correctCmd{1} = cmd;
                return;
            end
            
            if isempty(self.correctCmd)
                disp('Bad line of code skip...')
            end
            
        end
        
        function writeFile(~,textToWirte, outFileName)
            fileID = fopen(outFileName,'w');
            for k=1:length(textToWirte)
                if ~strcmp(textToWirte{k},"")
                   fprintf(fileID,'%s\n',textToWirte{k});
                end
            end
        end
        
        function self = translate(self,codes)
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
                    self.correctCmd{1} = "qreg";
                end
                 if ~isempty(self.correctCmd)
                     tmp = self.correctCmd;
                      if strcmp(tmp{1},'OPENQASM')
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
                      elseif strcmp(tmp{1},'cx')
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
                              self.result{k} = "";
                              for j = 0: stop-1
                                  q = start_qreg+j;
                                  q2 = start_qreg2+j;
                                  if j~=stop-1
                                      self.result{k} = self.result{k}+"circuit.cnot("+q+","+q2+");"+newline;
                                  else
                                      self.result{k} = self.result{k}+"circuit.cnot("+q+","+q2+");";
                                  end
                              end
                              
                          else
                              self.result{k} = strcat('circuit.cnot(',tmp{3},',',tmp{5},');');
                          end
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
                              for j = 0: stop-1
                                  q = start_qreg+j;
                                  c = start_creg+j;
                                  if j~=stop-1
                                      self.result{k} = self.result{k}+"circuit.measure("+q+","+c+");"+newline;
                                  else
                                      self.result{k} = self.result{k}+"circuit.measure("+q+","+c+");";
                                  end
                              end
                              
                          else
                              self.result{k} = strcat('circuit.measure(',tmp{3},',',tmp{5},');');
                          end
                      elseif strcmp(tmp{1},'qreg')
                          self.result{k} = "";
                      end
                 end
            end
        end
        
    end
    
end

