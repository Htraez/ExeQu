classdef Hadamard < ExeQu.Gates.Unitary
    methods 
        function obj = Hadamard(varargin)
            % obj = Hadamard()
            % obj = Hadamard(registerLength, target)
            import ExeQu.Utils.Maths.*;
            
            % Verify parameter
            if nargin == 2
                registerLength = varargin{1};
                target = varargin{2};
            elseif nargin == 0
                registerLength = 1;
                target = [];
            end
            
            operator = (1/sqrt(2))*[1 1; 1 -1];
            obj = obj@ExeQu.Gates.Unitary(operator, registerLength, target, 'H');
        end
    end
end