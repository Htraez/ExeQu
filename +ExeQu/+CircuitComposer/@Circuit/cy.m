function cy(self, ctrl, target)
    import ExeQu.Gates.*;
    
    Y = PauliY(1, 1);
    CY = ControlledUnitary(Y, self.quantumRegister.getSize(), [ctrl], target);
    
    operation.unitaryOperation = CY;
    operation.label = CY.label;
    operation.associatedQubit = [ctrl target];
    self.operationQueue = [self.operationQueue operation];
    
end