classdef Identity < ExeQu.Gates.Unitary
    properties (Constant, Access = private)
        operator = eye(2);
    end
    methods 
        function obj = Identity(varargin)
            % obj = Identity()
            % obj = Identity(registerLength, target)
            
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
            
            obj = obj@ExeQu.Gates.Unitary(Identity.operator, registerLength, target);
            obj.label = 'I';
        end
    end
end