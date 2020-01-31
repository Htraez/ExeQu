function z(self, target)
    import ExeQu.Gates.*;
    Z = PauliZ(self.quantumRegister.getSize(), target);
    operation.unitaryOperation = Z;
    operation.label = Z.label;
    operation.associatedQubit = [target];
    self.operationQueue = [self.operationQueue operation];
end