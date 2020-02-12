classdef T < ExeQu.Gates.Unitary
    properties (Constant, Access = private)
        operator = [1 0; 0 exp(1i*pi/4)];
    end
    methods 
        function obj = T(registerLength, target)
            import ExeQu.Utils.Maths.*;
            import ExeQu.Gates.*;
            obj = obj@ExeQu.Gates.Unitary(T.operator, registerLength, target);
            obj.label = 'T';
        end
    end
end