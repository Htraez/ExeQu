function sdag(self, target)
    import ExeQu.Gates.*;
    sdag = Sdag(self.quantumRegister.getSize(), target);
    operation.unitaryOperation = sdag;
    operation.label = sdag.label;
    operation.associatedQubit = [target];
    self.add(operation);
end