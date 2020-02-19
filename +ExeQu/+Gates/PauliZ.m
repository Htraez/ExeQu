classdef PauliZ < ExeQu.Gates.Unitary
    properties (Constant, Access = private)
        operator = [1 0; 0 -1];
    end
    methods 
        function obj = PauliZ(varargin)
            % obj = PauliZ()
            % obj = PauliZ(registerLength, target)
            
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
            
            obj = obj@ExeQu.Gates.Unitary(PauliZ.operator, registerLength, target);
            obj.label = 'Z';
        end
    end
end