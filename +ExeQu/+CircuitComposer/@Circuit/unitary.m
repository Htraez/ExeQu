function unitary(self, operator, ctrls, target)
    import ExeQu.Gates.*;
    U = Unitary(operator, self.quantumRegister.getSize(), target);
    operation.unitaryOperation = X;
    operation.label = X.label;
    operation.associatedQubit = [target];
    self.operationQueue = [self.operationQueue operation];
end