classdef PauliZ < ExeQu.Gates.Unitary
    properties (Constant, Access = private)
        operator = [1 0; 0 -1];
    end
    methods 
        function obj = PauliZ(registerLength, target)
            import ExeQu.Utils.Maths.*;
            import ExeQu.Gates.*;
            obj = obj@ExeQu.Gates.Unitary(PauliZ.operator, registerLength, target);
            obj.label = 'Z';
        end
    end
end