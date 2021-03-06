function controlledU(self, U, ctrls, target)
    import ExeQu.Gates.*;

    if strfind(class(U), 'function_handle') == 1   
        try
            U = U(1, 1);
        catch MX
            throw(MException('controlledU:ParameterError', "Invalid unitary at 1st argument. Only support 1-qubit gate"))
        end
    elseif class(U) == "char" || class(U) == "string"
        switch U
            case "x"
                U = PauliX();
            case "y"
                U = PauliY();
            case "z"
                U = PauliZ();
            otherwise
                throw(MException('controlledU:ParameterError', "Invalid unitary at 1st argument. Unknown gate specified"))
        end
    elseif class(U) == "struct" && isfield(U, 'unitaryOperation')
        U = U.unitaryOperation;
        [row, column] = size(U.toMatrice());
        if row > 2 || column > 2
            throw(MException('controlledU:ParameterError', "Invalid unitary at 1st argument. Only support 1-qubit gate"))
        end
    elseif isa(U, 'ExeQu.Gates.Unitary')
        [row, column] = size(U);
        if row > 2 || column > 2
            throw(MException('controlledU:ParameterError', "Invalid unitary at 1st argument. Only support 1-qubit gate"))
        end
    else
        throw(MException('controlledU:ParameterError', "Invalid unitary at 1st argument."))
    end
    
    CU = ControlledUnitary(U, self.quantumRegister.getSize(), ctrls, target);
    
    operation.unitaryOperation = CU;
    operation.U = U;
    operation.label = CU.label;
    operation.associatedQubit = [ctrls target];
    self.add(operation);
end