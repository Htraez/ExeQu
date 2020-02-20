function tdag(self, target)
    import ExeQu.Gates.*;
    tdag = Tdag(self.quantumRegister.getSize(), target);
    operation.unitaryOperation = tdag;
    operation.label = tdag.label;
    operation.associatedQubit = [target];
    self.add(operation);
end