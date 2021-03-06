function barrier(self, varargin)
    % barrier() <- from top to bottom
    % barrier(from, to) <- specific range
    
    if nargin >= 3
        from = varargin{1};
        to = varargin{2};
    elseif nargin == 1
        from = 1;
        to = self.quantumRegister.getSize();
    else
        identifier = 'Barrier:ParameterError';
        throw(MException(identifier,"Must specify both args or none"))
    end
    
    operation.label = 'barrier';
    operation.associatedQubit = sort([from to]);
    self.add(operation);
end