classdef Transpiler
    properties
        qregName = [];
        cregName = [];
    end
    
    methods
        function convert(self,inFileName, outFileName)
            text = self.readFile(inFileName);
            allCmd = self.seperateCommand(text);
            self.writeFile(allCmd, outFileName);
        end
    end
    
    methods(Access=private)
        function text = readFile(~,inFileName)
            fileID = fopen(inFileName,'r');
            formatSpec = '%c';
            text = fscanf(fileID, formatSpec);
        end
        
        function allCmd = seperateCommand(~,text)
            text = strrep(text,'{',';begin;');
            text = strrep(text,'}',';end;');
            allCmd = strsplit(text,{';','\n'});
            allCmd = strtrim(allCmd);
        end
        
        function correctCmd = checkQASMSyntax(self,cmd)
            
            correctCmd = {};
            
            if startsWith(cmd,'OPENQASM ')
                tmp = strsplit(cmd,{' '});
                tmp = strtrim(tmp);
                if( strcmp(tmp{1},'OPENQASM ') && strcmp(tmp{2},'2.0') )
                    correctCmd = tmp;
                end
            elseif startsWith(cmd,'include ')
                tmp = strsplit(cmd,{'"'});
                tmp = strtrim(tmp);
                if( strcmp(tmp{1},'include') && startsWith(tmp{2},'"') && endsWith(tmp{2},'"') )
                    correctCmd = tmp;
                end
            elseif startsWith(cmd,'qreg ')
                tmp = strsplit(cmd,' ');
                tmp = strtrim(tmp);
                if strcmp(tmp{1},'qreg')
                    qreg = strrep(tmp{2},'[',' [ ');
                    qreg = strrep(qreg,']',' ] ');
                    qreg = strsplit(qreg,{'[',']'});
                    qreg = strtrim(qreg);
                    if strcmp(qreg{2},'[') && strcmp(qreg{4},']')
                        pattern = {'1','2','3','4','5','6','7','8','9','0'};
                        if ( ~isnan(str2double(qreg{3}))) && ( ~startsWith(qreg{1},pattern) )
                            qregNo = length(self.qregName);
                            self.qregName{qregNo+1} = qreg{1};
                            tmp = strrep(cmd,'[',' [ ');
                            tmp = strrep(tmp,']',' ] ');
                            tmp = strsplit(tmp,{' ','[',']'});
                            tmp = strtrim(tmp);
                            correctCmd = tmp;
                        end
                    end
                end
            elseif startsWith(cmd,'creg ')
                tmp = strsplit(cmd,' ');
                tmp = strtrim(tmp);
                if strcmp(tmp{1},'creg')
                    creg = strrep(tmp{2},'[',' [ ');
                    creg = strrep(creg,']',' ] ');
                    creg = strsplit(creg,{'[',']'});
                    creg = strtrim(creg);
                    if strcmp(creg{2},'[') && strcmp(creg{4},']')
                        pattern = {'1','2','3','4','5','6','7','8','9','0'};
                        if ( ~isnan(str2double(creg{3}))) && ( ~startsWith(creg{1},pattern) )
                            cregNo = length(self.cregName);
                            self.cregName{cregNo+1} = creg{1};
                            tmp = strrep(cmd,'[',' [ ');
                            tmp = strrep(tmp,']',' ] ');
                            tmp = strsplit(tmp,{' ','[',']'});
                            tmp = strtrim(tmp);
                            correctCmd = tmp;
                        end
                    end
                end
            elseif startsWith(cmd,'cx ')
                tmp = strrep(cmd,',',' , ');
                tmp = strsplit(tmp,' ');
                tmp = strtrim(tmp);
                if strcmp(tmp{1},'cx') && strcmp(tmp{3},',')
                
                end
            elseif startsWith(cmd,'measure ')
                disp('measure');
            elseif startsWith(cmd,'//')
                correctCmd = cmd;
                return;
            end
            
            if isempty(correctCmd)
                disp('Bad line of code skip...')
            end
            
        end
        
        function writeFile(~,textToWirte, outFileName)
            fileID = fopen(outFileName,'w');
            for k=1:length(textToWirte)
                fprintf(fileID,'%s\n',textToWirte{k});
            end
        end
        
        function translate(self,codes)
            for k=1:length(codes)
                correctCmd = checkQASMSyntax(code);
                if isempty(correctCmd)
                    
                end
            end
        end
        
    end
    
end

