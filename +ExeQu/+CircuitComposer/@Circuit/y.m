function y(self, target)
    import ExeQu.Gates.*;
    persistent Y
    Y = PauliY(self.quantumRegister.getSize(), target);
    operation.unitaryOperation = Y;
    operation.label = Y.label;
    operation.associatedQubit = [target];
    self.operationQueue = [self.operationQueue operation];
end