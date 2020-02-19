classdef Transpiler
    
    methods
        function convert(self,inFileName, outFileName)
            text = self.readFile(inFileName);
            allCmd = self.seperateCommand(text);
            correctCmd = self.checkSyntax(allCmd);
            self.writeFile(correctCmd, outFileName);
        end
    end
    
    methods(Access=private)
        function text = readFile(self,inFileName)
            fileID = fopen(inFileName,'r');
            formatSpec = '%c';
            text = fscanf(fileID, formatSpec);
        end
        
        function allCmd = seperateCommand(self,text)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            text = strrep(text,'{',';begin;');
            text = strrep(text,'}',';end;');
            allCmd = strsplit(text,{';','\n'});
            allCmd = strtrim(allCmd);
        end
        
        function correctCmd = checkSyntax(self,allCmd)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            correctCmd = cell(size(allcmd));
            for k=1:length(allCmd)
                cmd = strsplit(allCmd{k},' ');
                if length(cmd)==2
                    if strcmp(cmd{1},'qreg')
                        disp('qreg');
                    elseif strcmp(cmd{1},'creg')
                        disp('creg'); 
                    elseif strcmp(cmd{1},'OPENQASM') && strcmp(cmd{1},'2.0')
                        disp('OPENQASM');
                    elseif strcmp(cmd{1},'measure')
                        disp('measure');
                    elseif strcmp(cmd{1},'cx')
                        disp('cx');
                    elseif strcmp(cmd{1},'include')
                        disp('include');
                    elseif strcmp(cmd{1},'reset')
                        disp('reset');
                    elseif startsWith(cmd{1},'//')
                        disp('comment');
                    end
                end
                correctCmd{k} = allCmd{k};
            end
        end
        
        function writeFile(self,textToWirte, outFileName)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            fileID = fopen(outFileName,'w');
            for k=1:length(textToWirte)
                fprintf(fileID,'%s\n',textToWirte{k});
            end
        end
        
        function translate(self,codes)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            for k=1:length(codes)
                disp(codes{k})
            end
        end
    end
    
end

