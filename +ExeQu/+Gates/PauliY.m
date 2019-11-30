classdef PauliY < ExeQu.Gates.Unitary
    methods 
        function obj = PauliY(registerLength, target)
            import ExeQu.Utils.Maths.*;
            operator = [0 -1i; 1i 0];
            obj = obj@ExeQu.Gates.Unitary(operator, registerLength, target, 'Y');
        end
    end
end