classdef Identity < ExeQu.Gates.Unitary
    properties (Constant, Access = private)
        operator = eye(2);
    end
    methods 
        function obj = Identity(registerLength, target)
            import ExeQu.Utils.Maths.*;
            import ExeQu.Gates.*;
            obj = obj@ExeQu.Gates.Unitary(Identity.operator, registerLength, target);
            obj.label = 'I';
        end
    end
end