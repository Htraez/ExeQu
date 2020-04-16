function cnot(self, ctrl, target)
    import ExeQu.Gates.*;
    
    X = PauliX();
    CNOT = ControlledUnitary(X, self.quantumRegister.getSize(), [ctrl], target);
    
    operation.unitaryOperation = CNOT;
    operation.label = CNOT.label;
    operation.associatedQubit = [ctrl target];
    self.add(operation);
end