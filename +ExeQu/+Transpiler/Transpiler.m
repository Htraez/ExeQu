classdef Transpiler
    
    methods
        function convert(self,inFileName, outFileName)
            text = self.readFile(inFileName);
            cmd = self.seperateCommand(text);
            correctCmd = self.checkSyntax(cmd);
            self.writeFile(correctCmd, outFileName);
        end
    end
    
    methods(Access=private)
        function text = readFile(self,inFileName)
            fileID = fopen(inFileName,'r');
            formatSpec = '%c';
            text = fscanf(fileID, formatSpec);
        end
        
        function cmd = seperateCommand(self,text)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            text = strrep(text,'{',';begin;');
            text = strrep(text,'}',';end;');
            cmd = strsplit(text,{';','\n'});
            cmd = strtrim(cmd);
        end
        
        function correctCmd = checkSyntax(self,cmd)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            correctCmd = cmd;
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

