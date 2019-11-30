classdef ControlledUnitary < ExeQu.Gates.Unitary
    methods 
        function obj = ControlledUnitary(U, registerLength, ctrl, target)
            import ExeQu.Utils.Maths.*;
            
            [r, c] = size(U);
            if r ~= c || r < 2 || c < 2
                throw("Dimension of Unitary is invalid")
            end
            I = [1 0; 0 1];
            
            dim = registerLength - (registerLength - min(ctrl));
            
            ctrlU = eye(dim);
            if length(ctrl) == 1
                iter = 1;
                last = 0;
                for ctrl = sort(ctrl)
                    if(last - ctrl == 1)
                    last = ctrl;
                end
                for index = dim:-r:1
                    if(ctrlList(iter))
                    ctrlU(index-r, index) = U;
                end
            end
            
            obj = obj@ExeQu.Gates.Unitary(operator, registerLength, target, 'Z');
        end
    end
end