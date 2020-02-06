classdef Sdag < ExeQu.Gates.Unitary
    properties (Constant, Access = private)
        operator = [1 0; 0 -1i];
    end
    methods 
        function obj = Sdag(registerLength, target)
            % S-dagger => Conjugate Transposed form of S gate
            import ExeQu.Utils.Maths.*;
            import ExeQu.Gates.*;
            obj = obj@ExeQu.Gates.Unitary(Sdag.operator, registerLength, target);
            obj.label = 'Sdag';
        end
    end
end