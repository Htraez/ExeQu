function ccnot(self, ctrl1, ctrl2, target)
    import ExeQu.Gates.*;
    
    X = PauliX(self.quantumRegister.getSize(), target);
    CCNOT = ControlledUnitary(X, self.quantumRegister.getSize(), [ctrl1 ctrl2], target);
    
    operation.unitaryOperation = CCNOT;
    operation.label = CCNOT.label;
    operation.associatedQubit = [ctrl1 ctrl2 target];
    self.operationQueue = [self.operationQueue operation];
end