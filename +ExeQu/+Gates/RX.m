classdef RX < ExeQu.Gates.Unitary
    properties (Access = private)
        theta
    end
    methods (Static, Access = private)
        function op = getOperator(theta)
            % Theta must be radian
            op = [cos(theta/2) -1i*sin(theta/2); ...
                    -1i*sin(theta/2) cos(theta/2)];
        end
    end
    methods 
        function obj = RX(registerLength, target, theta)
            import ExeQu.Utils.Maths.*;
            import ExeQu.Gates.*;
            operator = RX.getOperator(theta);
            obj = obj@ExeQu.Gates.Unitary(operator, registerLength, target);
            obj.label = 'Rx';
            obj.theta = theta;
        end
        
        function theta = getTheta(self)
            theta = self.theta;
        end
    end
end