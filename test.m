clc
clear
fileID = fopen("QASMTest2.qinc",'r');
formatSpec = '%c';
tmp = fscanf(fileID, formatSpec);

allCmd = strsplit(tmp,'\n');
allCmd = strtrim(allCmd);
re = allCmd';


for i= 1 : length(re)
    if ~startsWith(re{i},'//') && ~startsWith(re{i},'gate')
        re{i} = regexprep(re{i},';','');
    end
end

gateName = [];
gatePara = [];
gateDetail = [];
        
tmp = strrep(re{1},'}','');
tmp = strtrim(tmp);
tmp = strsplit(tmp,{'{',';'});
tmp(cellfun('isempty',tmp)) = [];

if contains(tmp{1},'(')
    
else
    tmp{1} = strtrim(tmp{1});
    gateCreate = strsplit(tmp{1},{' ',','});
    %gateCreate(cellfun('isempty',gateCreate)) = [];
    gateName{1} = gateCreate{2};
    gatePara{1} = length(gateCreate)-2;
    gateDetail{1} = "";
    for i = 2:length(tmp)
        gateDetail{1} = gateDetail{1}+tmp{i}+";";
    end
    
end


tmp2 = strrep(re{2},'}','');
tmp2 = strtrim(tmp2);
tmp2 = strsplit(tmp2,{'{',';'});
tmp2(cellfun('isempty',tmp2)) = [];

if contains(tmp2{1},'(')
    disp('(')
end


