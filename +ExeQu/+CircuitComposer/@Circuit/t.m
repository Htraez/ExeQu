function t(self, target)
    import ExeQu.Gates.*;
    t = T(self.quantumRegister.getSize(), target);
    operation.unitaryOperation = t;
    operation.label = t.label;
    operation.associatedQubit = [target];
    self.add(operation);
end