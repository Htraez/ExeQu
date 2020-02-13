function result = tensor(varargin)
    import ExeQu.Utils.Maths.*
    varargin;
    if(nargin > 1)
        result = tensor(varargin);
    else
        matrices = varargin{1};
        result = num2cell(matrices{1});
        for iter = 2:length(matrices)
            matrix = matrices{iter};
            [row_len, col_len] = size(result);
            for i = 1:row_len
                for j = 1:col_len
                    result{i, j} = result{i, j} * matrix;
                end
            end
            result = cell2mat(result);
            result = num2cell(result);
        end
        result = cell2mat(result);
    end
end