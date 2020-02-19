classdef S < ExeQu.Gates.Unitary
    properties (Constant, Access = private)
        operator = [1 0; 0 1i];
    end
    methods 
        function obj = S(varargin)
            % obj = S()
            % obj = S(registerLength, target)
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
            
            obj = obj@ExeQu.Gates.Unitary(S.operator, registerLength, target);
            obj.label = 'S';
        end
    end
end