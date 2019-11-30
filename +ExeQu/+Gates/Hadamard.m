classdef Hadamard < ExeQu.Gates.Unitary
    methods 
        function obj = Hadamard(registerLength, target)
            import ExeQu.Utils.Maths.*;
            operator = (1/sqrt(2))*[1 1; 1 -1];
            obj = obj@ExeQu.Gates.Unitary(operator, registerLength, target, 'H');
        end
    end
end