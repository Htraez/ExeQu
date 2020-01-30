function unitary(self, operator, target)
    import ExeQu.Gates.*;
    U = Unitary(operator, self.quantumRegister.getSize(), target);
    operation.unitaryOperation = U;
    operation.label = U.label;
    operation.associatedQubit = [target];
    self.operationQueue = [self.operationQueue operation];
end