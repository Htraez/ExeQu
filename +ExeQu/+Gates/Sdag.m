classdef Sdag < ExeQu.Gates.Unitary
    properties (Constant, Access = private)
        operator = [1 0; 0 -1i];
    end
    methods 
        function obj = Sdag(varargin)
            % S-dagger => Conjugate Transposed form of S gate
            % obj = Sdag()
            % obj = Sdag(registerLength, target)
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
            
            obj = obj@ExeQu.Gates.Unitary(Sdag.operator, registerLength, target);
            obj.label = 'Sdag';
        end
    end
end