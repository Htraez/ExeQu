function s(self, target)
    import ExeQu.Gates.*;
    s = S(self.quantumRegister.getSize(), target);
    % rotate 90 degree in z
    operation.unitaryOperation = s;
    operation.label = s.label;
    operation.associatedQubit = [target];
    self.add(operation);
end