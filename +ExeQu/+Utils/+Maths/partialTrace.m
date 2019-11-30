function result = partialTrace(matrix, target)
    [row, column] = size(matrix);
    if(row == column && row == 4)
        if(row < 2) 
            result = matrix;
            return
        end
        if(~ismember(target, 1:2))
            throw(MException("Invalid target for partial trace"));
        end
        index = [];
        if(target == 1)
            index = [1 3];
        elseif(target == 2)
            index = [1 2];
        end
        
        r = 1;
        for i = index
            c = 1;
            for j = index
                if(target == 1)
                    group = {matrix(i, j) matrix(i, j+1); matrix(i+1, j) matrix(i+1, j+1)};
                elseif (target == 2)
                    group = {matrix(i, j) matrix(i, j+2); matrix(i+2, j) matrix(i+2, j+2)};
                end
                group = cell2mat(group);
                result(r, c) = trace(group);
                c = c+1;
            end
            r = r+1;
        end
    else
        throw(MException("Invalid Input to partialTrace()"));
    end
end