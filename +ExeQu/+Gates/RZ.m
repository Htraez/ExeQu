classdef RZ < ExeQu.Gates.Unitary
    properties (Access = private)
        theta
    end
    methods (Static, Access = private)
        function op = getOperator(theta)
            % Theta must be radian
            op = [exp(-1i*theta/2) 0; ...
                    0 exp(1i*theta/2)];
        end
    end
    methods 
        function obj = RZ(registerLength, target, theta)
            import ExeQu.Utils.Maths.*;
            import ExeQu.Gates.*;
            operator = RZ.getOperator(theta);
            obj = obj@ExeQu.Gates.Unitary(operator, registerLength, target);
            obj.label = 'Rz';
            obj.theta = theta;
        end
        
        function theta = getTheta(self)
            theta = self.theta;
        end
    end
end