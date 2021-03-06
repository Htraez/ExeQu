classdef ControlledUnitary < ExeQu.Gates.Unitary
    properties (Constant, Access = private)
        one = [0 0; 0 1];
        zero = [1 0; 0 0];
    end
    properties (Access = private)
        ctrl
        target
        uType
    end
    methods 
        function obj = ControlledUnitary(U, registerLength, ctrl, target)
            import ExeQu.Utils.Maths.*;
            import ExeQu.Gates.*;
            
            [U_row, U_col] = size(U);
            
            identifier = 'ControlledUnitary:ParameterError';
%             Validate Parameter
            if target > registerLength
                throw(MException(identifier,"Target is out of circuit's qubit range"))
            elseif sum(ismember(target, ctrl)) > 0
                throw(MException(identifier,"One qubit can not be control and target at the same time"))
            elseif max(ctrl) > registerLength
                throw(MException(identifier,"Control is out of circuit's qubit range"))
            elseif length(ctrl) > registerLength-1
                throw(MException(identifier,"Too many control bits"))
            elseif ~isUnitary(U.toMatrice())
                throw(MException(identifier,"1st argument is not a valid unitary matrix"))
            elseif U_row > 2
                throw(MException(identifier,"Only U of size 2x2 is supported, found "+U_row+"x"+U_col))
            end
            
            ctrl = sort(ctrl);
            switch U.getLabel()
                case 'X'
                    U_label = "NOT";
                case 'Y'
                    U_label = "Y";
                case 'Z'
                    U_label = "Z";
                otherwise
                    U_label = "U";
            end
            U = U.toMatrice();
            
            I = eye(2);
            
%             Scope down
            scope = min([ctrl target]) - 1; % Check the least bit involved 
            s_ctrl = ctrl - scope; % Scale down to start from 1
            s_target = target - scope; % Scale down to start from 1
            
            n_bit = max([s_ctrl s_target]); % Number of bit covered by this gate
            operator = zeros(2^n_bit); 
            % Create empty operator matrix 
            % (this will hold the last result of operation matrix)
            
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
                        t(c) = {ControlledUnitary.one};
                    else
                        t(c) = {ControlledUnitary.zero};
                    end
                end
                if combsets(i, s_ctrl) == 1 % if all control is 1
                    t(s_target) = {U}; % set target to U
                end
%                  celldisp(t)
%                  tensor(t)
%                  operator
                operator = operator + tensor(t);
            end
            
            switch length(ctrl)
                case 1
                    if isequal(U_label, "U")
                        label = "Controlled-"+U_label;
                    else
                        label = "C"+U_label;
                    end
                case 2
                    if isequal(U_label, "NOT")
                        label = "Toffoli";
                    else 
                        label = "Controlled-controlled-"+U_label;
                    end
                otherwise
                    if isequal(U_label, "NOT")
                        label = "Multiple Control Toffoli";
                    else 
                        label = "Multiple Controlled-"+U_label;
                    end
            end
            
            obj = obj@ExeQu.Gates.Unitary(operator, registerLength, [ctrl target]);
            obj.label = label;
            obj.ctrl = ctrl;
            obj.target = target;
            obj.uType = U_label;
        end
        
        uType = getUType(self);
        ctrl = getControl(self);
        target = getTarget(self);
    end
end