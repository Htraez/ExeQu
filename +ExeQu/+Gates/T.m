classdef T < ExeQu.Gates.Unitary
    properties (Constant, Access = private)
        operator = [1 0; 0 exp(1i*pi/4)];
    end
    methods 
        function obj = T(varargin)
            % obj = T()
            % obj = T(registerLength, target)
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
            
            obj = obj@ExeQu.Gates.Unitary(T.operator, registerLength, target);
            obj.label = 'T';
        end
    end
end