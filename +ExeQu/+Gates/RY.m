classdef RY < ExeQu.Gates.Unitary
    properties (Access = private)
        theta
    end
    methods (Static, Access = private)
        function op = getOperator(theta)
            % Theta must be radian
            op = [cos(theta/2) -sin(theta/2); ...
                    sin(theta/2) cos(theta/2)];
        end
    end
    methods 
        function obj = RY(registerLength, target, theta)
            import ExeQu.Utils.Maths.*;
            import ExeQu.Gates.*;
            operator = RY.getOperator(theta);
            obj = obj@ExeQu.Gates.Unitary(operator, registerLength, target);
            obj.label = 'Ry';
            obj.theta = theta;
        end
        
        function theta = getTheta(self)
            theta = self.theta;
        end
    end
end