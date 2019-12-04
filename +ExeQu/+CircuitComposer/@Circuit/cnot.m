function cnot(self, ctrl, target)
    import ExeQu.Gates.*;
    
    X = PauliX(self.quantumRegister.getSize(), target);
    CNOT = ControlledUnitary(X, self.quantumRegister.getSize(), [ctrl], target);
    
    operation.unitaryOperation = CNOT;
    operation.label = CNOT.label;
    operation.associatedQubit = [ctrl target];
    self.operationQueue = [self.operationQueue operation];
end