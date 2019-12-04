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
            end
            
            ctrl = sort(ctrl);
            U = U.toMatrice();
            
            I = eye(2);
            one = [0 0; 0 1];
            zero = [1 0; 0 0];
            
            [U_row, U_col] = size(U);
%             U_row must = to U_col = 2
%             and U must be unitary
            
            one = [0 0; 0 1];
            zero = [1 0; 0 0];
            
%             Scope down
            scope = min([ctrl target]) - 1;
            s_ctrl = ctrl - scope;
            s_target = target - scope;
            
            n_bit = max([s_ctrl s_target]);
            operator = zeros(2^n_bit);
            
            temp = zeros(1, n_bit);
            temp(s_ctrl) = 1;
          
            sets = {0, [0 1]};
            combsets = sets(temp + 1);
            [combsets{:}] = ndgrid(combsets{:});
            combsets = reshape(cat(numel(temp)+1, combsets{:}), [], numel(temp));
            
            [n_combination, ~] = size(combsets);
            
            for i = 1:n_combination
                t = cell(1, n_bit);
                t(1:n_bit) = {I};
                
                for c = s_ctrl
                    if combsets(i, c) == 1
                        t(c) = {one};
                    else
                        t(c) = {zero};
                    end
                end
                if combsets(i, s_ctrl) == 1 % if all control is 1
                    t(s_target) = {U}; % set target to U
                end
                celldisp(t)
                operator = operator + tensor(t);
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
%             obj.toMatrice()
        end
    end
end