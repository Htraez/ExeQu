function draw(self)
    import ExeQu.Utils.*;
    %qreg = self.quantumRegister;
    %op= self.operationQueue;
    Visualization.plotCircuit(self.quantumRegister);
    for operation = self.operationQueue
        Visualization.plotOperation(operation);
    end
end