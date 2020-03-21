classdef PauliY < ExeQu.Gates.Unitary
    properties (Constant, Access = private)
        operator = [0 -1i; 1i 0];
    end
    methods 
        function obj = PauliY(varargin)
            % obj = PauliY()
            % obj = PauliY(registerLength, target)
            
            import ExeQu.Utils.Maths.*;
            import ExeQu.Gates.*;
            
            % Verify parameter
            if nargin == 2
                registerLength = varargin{1};
                target = varargin{2};
            elseif nargin == 0
                registerLength = 1;
                target = [];
            end
            
            obj = obj@ExeQu.Gates.Unitary(PauliY.operator, registerLength, target);
            obj.label = 'Y';
        end
    end
end