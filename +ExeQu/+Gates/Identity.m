classdef Identity < ExeQu.Gates.Unitary
    methods 
        function obj = Identity(registerLength, target)
            import ExeQu.Utils.Maths.*;
            operator = eye(2);
            obj = obj@ExeQu.Gates.Unitary(operator, registerLength, target, 'I');
        end
    end
end