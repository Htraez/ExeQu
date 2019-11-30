classdef PauliX < ExeQu.Gates.Unitary
    methods 
        function obj = PauliX(registerLength, target)
            import ExeQu.Utils.Maths.*;
            operator = [0 1; 1 0];
            obj = obj@ExeQu.Gates.Unitary(operator, registerLength, target, 'X');
        end
    end
end