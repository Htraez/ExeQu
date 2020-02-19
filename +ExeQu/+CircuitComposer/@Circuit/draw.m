function draw(self)
    import ExeQu.Utils.*;
    global n_element
    n_element = zeros(1, self.quantumRegister.n_qubits);
    %qreg = self.quantumRegister;
    %op= self.operationQueue;
    setFigure();
    
    clf;
    
    hpanel=uipanel('position',[0 .05 2 .95]);
    % (start weight, start height, zoom weight, zoom height)
    hscrollbar=uicontrol('style','slider','units','normalized','position',[0 0 1 .05],'callback',@hscroll_Callback);
    % (start weight scrollbar,start height scrollbar,size weight scrollbar,size height scrollbar)
    axes('parent',hpanel)
    %axes('parent',hpanel,'outerposition',[.25 0 .5 1])
    
    %debug position scrollbar
%    hpanel=uipanel('position',[0 0 1 1]);
%    hscrollbar=uicontrol('style','slider','units','normalized','position',[0 0 1 .05],'callback',@hscroll_Callback);
%    axes('parent',hpanel)

    Visualization.plotCircuit(self.quantumRegister);
    for operation = self.operationQueue
        %operationQueue is cell array, operation is now {operation struct}
        Visualization.plotOperation(operation{:}); %Use {:} to get the struct inside cell array
    end
    
    %plot_circuit(5)
    function hscroll_Callback(src,evt)
        set(hpanel,'position',[-get(src,'value') 0.05 2 .95])
    end
end