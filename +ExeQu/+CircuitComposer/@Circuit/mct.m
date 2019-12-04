function mct(self, ctrls, target)
    import ExeQu.Gates.*;
    
    if length(ctrls) < 3
        warning("You're adding Multiple Controlled-Not gate with number of control lower than 3, please consider using CNOT or CCNOT instead");
    end
    
    X = PauliX(self.quantumRegister.getSize(), target);
    MCT = ControlledUnitary(X, self.quantumRegister.getSize(), [ctrls], target);
    
    operation.unitaryOperation = MCT;
    operation.label = MCT.label;
    operation.associatedQubit = [ctrls target];
    self.operationQueue = [self.operationQueue operation];
end
