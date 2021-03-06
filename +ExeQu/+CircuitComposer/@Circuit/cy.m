function cy(self, ctrl, target)
    import ExeQu.Gates.*;
    
    Y = PauliY();
    CY = ControlledUnitary(Y, self.quantumRegister.getSize(), [ctrl], target);
    
    operation.unitaryOperation = CY;
    operation.label = CY.label;
    operation.associatedQubit = [ctrl target];
    self.add(operation);
end