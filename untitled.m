% read file
fileID = fopen('QASMTest.qinc','r');
formatSpec = '%c';
A = fscanf(fileID,formatSpec);

% seperate cmd
A = strrep(A,'{',';begin;');
A = strrep(A,'}',';end;');
test = strsplit(A,{';','\n'});
test = strtrim(test);

% check syntax
fileID = fopen('qwerty2.m','w');
correctCmd = cell(size(test));
for k=1:length(test)
    cmd = strsplit(test{k},' ');
    for j=1:length(cmd)
        fprintf(fileID,'%s\n',cmd{j});
    end
    fprintf(fileID,'\n');
end

% write file
fileID = fopen('qwerty.m','w');
for k=1:length(test)
    fprintf(fileID,'%s\n',test{k});
end