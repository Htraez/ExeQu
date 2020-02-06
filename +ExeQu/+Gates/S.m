classdef S < ExeQu.Gates.Unitary
    properties (Constant, Access = private)
        operator = [1 0; 0 1i];
    end
    methods 
        function obj = S(registerLength, target)
            import ExeQu.Utils.Maths.*;
            import ExeQu.Gates.*;
            obj = obj@ExeQu.Gates.Unitary(S.operator, registerLength, target);
            obj.label = 'S';
        end
    end
end