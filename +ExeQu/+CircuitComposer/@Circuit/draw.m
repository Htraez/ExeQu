function draw(self)
    import ExeQu.Utils.*;
    %qreg = self.quantumRegister;
    %op= self.operationQueue;
    Visualization.plotCircuit(self.quantumRegister);
    for operation = self.operationQueue
        %operationQueue is cell array, operation is now {operation struct}
        Visualization.plotOperation(operation{:}); %Use {:} to get the struct inside cell array
    end
end