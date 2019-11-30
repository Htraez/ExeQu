classdef PauliZ < ExeQu.Gates.Unitary
    methods 
        function obj = PauliZ(registerLength, target)
            import ExeQu.Utils.Maths.*;
            operator = [1 0; 0 -1];
            obj = obj@ExeQu.Gates.Unitary(operator, registerLength, target, 'Z');
        end
    end
end