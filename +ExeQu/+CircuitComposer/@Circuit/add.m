function add(self, operation)
    if ~isfield(operation, "unitaryOperation") ...
            || ~isfield(operation, "associatedQubit") ...
            || ~isfield(operation, "label")
        throw(MException('Add:ParameterError', "1st argument is not a valid operation"))
    end    
    self.operationQueue = [self.operationQueue operation];
end