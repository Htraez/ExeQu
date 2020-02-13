classdef PauliX < ExeQu.Gates.Unitary
    properties (Constant, Access = private)
        operator = [0 1; 1 0];
    end
    methods 
        function obj = PauliX(varargin)
            % obj = PauliX()
            % obj = PauliX(registerLength, target)
            
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
            
            obj = obj@ExeQu.Gates.Unitary(PauliX.operator, registerLength, target);
            obj.label = 'X';
        end
    end
end