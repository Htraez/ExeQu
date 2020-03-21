function ccnot(self, ctrl1, ctrl2, target)
    import ExeQu.Gates.*;
    
    X = PauliX();
    CCNOT = ControlledUnitary(X, self.quantumRegister.getSize(), [ctrl1 ctrl2], target);
    
    operation.unitaryOperation = CCNOT;
    operation.label = CCNOT.label;
    operation.associatedQubit = [ctrl1 ctrl2 target];
    self.add(operation);
end