function peekOperationQueue(self)
    op_struct = self.operationQueue;
    
    iter = 1;
    for i = op_struct
        disp("Operation #"+iter);
        disp("Label: "+i.label);
        disp("Act On: ["+i.associatedQubit+"]");
        disp(i.unitaryOperation.toMatrice);
        iter = iter + 1;
    end
    
end