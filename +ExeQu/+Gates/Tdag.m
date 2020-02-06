classdef Tdag < ExeQu.Gates.Unitary
    properties (Constant, Access = private)
        operator = [1 0; 0 exp(-1i*pi/4)];
    end
    methods 
        function obj = Tdag(registerLength, target)
            % T-dagger => Conjugate Transposed form of T gate
            import ExeQu.Utils.Maths.*;
            import ExeQu.Gates.*;
            obj = obj@ExeQu.Gates.Unitary(Tdag.operator, registerLength, target);
            obj.label = 'Tdag';
        end
    end
end