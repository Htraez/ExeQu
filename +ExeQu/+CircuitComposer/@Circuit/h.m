function h(self, target)
    import ExeQu.Gates.*;
    persistent H
    H = Hadamard(self.quantumRegister.getSize(), target);
    operation.unitaryOperation = H;
    operation.label = H.label;
    operation.associatedQubit = [target];
    self.add(operation);
end