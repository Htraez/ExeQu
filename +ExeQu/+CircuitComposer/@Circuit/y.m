function y(self, target)
    import ExeQu.Gates.*;
    Y = PauliY(self.quantumRegister.getSize(), target);
    operation.unitaryOperation = Y;
    operation.label = Y.label;
    operation.associatedQubit = [target];
    self.add(operation);
end