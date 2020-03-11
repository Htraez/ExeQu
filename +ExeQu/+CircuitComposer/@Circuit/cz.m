function cz(self, ctrl, target)
    import ExeQu.Gates.*;
    
    Z = PauliZ();
    CZ = ControlledUnitary(Z, self.quantumRegister.getSize(), [ctrl], target);
    
    operation.unitaryOperation = CZ;
    operation.label = CZ.label;
    operation.associatedQubit = [ctrl target];
    self.add(operation);
end