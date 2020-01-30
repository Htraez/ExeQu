function cz(self, ctrl, target)
    import ExeQu.Gates.*;
    
    Z = PauliZ(1, 1);
    CZ = ControlledUnitary(Z, self.quantumRegister.getSize(), [ctrl], target);
    
    operation.unitaryOperation = CZ;
    operation.label = CZ.label;
    operation.associatedQubit = [ctrl target];
    self.operationQueue = [self.operationQueue operation];
    
end