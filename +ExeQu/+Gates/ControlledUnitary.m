classdef ControlledUnitary < ExeQu.Gates.Unitary
    methods 
        function obj = ControlledUnitary(U, registerLength, ctrl, target)
            import ExeQu.Utils.Maths.*;
            
            identifier = 'ControlledUnitary:ParameterError';
%             Validate Parameter
            if target > registerLength
                throw(MException(identifier,"Target is out of circuit range"))
            elseif max(ctrl) > registerLength
                throw(MException(identifier,"Control is out of circuit range"))
            elseif length(ctrl) > registerLength-1
                throw(MException(identifier,"Too many control bits"))
            elseif max(ctrl) > target
                throw(MException(identifier,"Not support control > target configutation"))
            end
            ctrl = sort(ctrl);
            U = U.toMatrice();
            
            I = [1 0; 0 1];
            
            [U_row, U_col] = size(U);
%             U_row must = to U_col and U must be unitary
            operator_dim = target - min(ctrl) + 1;
            operator = zeros(2^operator_dim);
            
            i = min(ctrl);
            j = 1;
            
            if operator_dim == length(ctrl) + 1
                operator = eye(2^operator_dim);
                operator(2^operator_dim - (U_row-1):2^operator_dim, 2^operator_dim - (U_row-1):2^operator_dim) = U;
            else
                for index = 2^operator_dim:-(U_row):1
                    if(j <= length(ctrl) && i == ctrl(j))

                        disp("Inspecting ["+(index - (U_row-1))+":"+index+"]")
                        operator(index - (U_row-1):index, index - (U_row-1):index) = U;
                        j = j + 1;

                    else
                        operator(index - (U_row-1):index, index - (U_row-1):index) = I;
                    end
                    i = i + 1;
                end
            end

            switch length(ctrl)
                case 1
                    label = 'CNOT';
                case 2
                    label = 'CCNOT';
                otherwise
                    label = 'MCT';
            end
            
            obj = obj@ExeQu.Gates.Unitary(operator, registerLength, [ctrl target], label);
            obj.toMatrice()
        end
    end
end