classdef PauliX < ExeQu.Gates.Unitary
    properties (Constant, Access = private)
        operator = [0 1; 1 0];
    end
    methods 
        function obj = PauliX(registerLength, target)
            import ExeQu.Utils.Maths.*;
            import ExeQu.Gates.*;
            obj = obj@ExeQu.Gates.Unitary(PauliX.operator, registerLength, target);
            obj.label = 'X';
        end
    end
end