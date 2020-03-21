classdef U3 < ExeQu.Gates.Unitary
    methods (Static)
        function op = getOperator(theta, phi, lambda)
            a = cos(theta/2);
            b = -exp(1i * lambda) * sin(theta/2);
            c = exp(1i * phi) * sin(theta/2);
            d = exp(1i * (lambda + phi)) * cos(theta/2);
            op = [a b; c d];
        end
    end
    methods 
        function obj = U3(varargin)
            % obj = U3(theta, phi, lambda)
            % obj = U3(registerLength, target, theta, phi, lambda)
            import ExeQu.Utils.Maths.*;
            import ExeQu.Gates.*;
            
            % Verify parameter
            if nargin == 5
                [registerLength, target] = varargin{1:2};
                [theta, phi, lambda] = varargin{3:5};
            elseif nargin == 3
                registerLength = 1;
                target = [];
                [theta, phi, lambda] = varargin{1:3};
            end
            
            operator = U3.getOperator(theta, phi, lambda);
            obj = obj@ExeQu.Gates.Unitary(operator, registerLength, target);
            obj.label = 'U3';
        end
    end
end