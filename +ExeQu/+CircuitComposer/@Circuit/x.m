function x(self, target)
    import ExeQu.Gates.*;
    X = PauliX(self.quantumRegister.getSize(), target);
    operation.unitaryOperation = X;
    operation.label = X.label;
    operation.associatedQubit = [target];
    self.operationQueue = [self.operationQueue operation];
end