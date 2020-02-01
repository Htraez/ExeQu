function mt = mtimes(varargin)
    inputs = {};
    mt = [];
    for i = 1:nargin
        arg = varargin{i};
        if isobject(arg)
            if ismethod(arg,'toMatrice')
                inputs{i} = arg.toMatrice();
            elseif ismethod(arg,'getState')
                inputs{i} = arg.getState();
            end
        else
            inputs{i} = arg;
        end
    end
    
    for obj = inputs
        if isempty(mt) 
            mt = obj{:};
        	continue   
        end
        mt = mt * obj{:};
    end
end