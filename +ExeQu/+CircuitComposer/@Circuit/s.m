function s(self, target)
    import ExeQu.Gates.*;
    s = S(self.quantumRegister.getSize(), target);
    operation.unitaryOperation = s;
    operation.label = s.label;
    operation.associatedQubit = [target];
    self.add(operation);
end