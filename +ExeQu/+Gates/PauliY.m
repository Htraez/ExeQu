classdef PauliY < ExeQu.Gates.Unitary
    properties (Constant, Access = private)
        operator = [0 -1i; 1i 0];
    end
    methods 
        function obj = PauliY(registerLength, target)
            import ExeQu.Utils.Maths.*;
            import ExeQu.Gates.*;
            obj = obj@ExeQu.Gates.Unitary(PauliY.operator, registerLength, target);
            obj.label = 'Y';
        end
    end
end