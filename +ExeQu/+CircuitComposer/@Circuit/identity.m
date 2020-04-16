function identity(self, target)
    import ExeQu.Gates.*;
    I = Identity(self.quantumRegister.getSize(), target);
    operation.unitaryOperation = I;
    operation.label = I.label;
    operation.associatedQubit = [target];
    self.add(operation);
end