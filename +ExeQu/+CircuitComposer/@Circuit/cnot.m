function cnot(self, ctrl, target)
    import ExeQu.Gates.*;
    
    X = PauliX(1, 1);
    CNOT = ControlledUnitary(X, self.quantumRegister.getSize(), [ctrl], target);
    CNOT.toMatrice()
    
    operation.unitaryOperation = CNOT;
    operation.label = CNOT.label;
    operation.associatedQubit = [ctrl target];
    self.add(operation);
end