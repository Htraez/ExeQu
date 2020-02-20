function draw(self)
    import ExeQu.Utils.*;
    global n_element
    n_element = zeros(1, self.quantumRegister.n_qubits);
    %qreg = self.quantumRegister;
    %op= self.operationQueue;
    n = setFigure();
    
    clf;
    panelA=uipanel('Parent', n);
    panelB=uipanel('Parent', panelA);
    set(panelA,'Position',[0 0 0.95 1]);
    set(panelB,'Position',[0 -1 1 2]);

    set(gca,'Parent',panelB);
    % (start width, start height, zoom width, zoom height)
    vScroll = uicontrol('Style','Slider','Parent',1,...
      'Units','normalized','Position',[0.95 0 0.05 1],...
      'Value',1,'Callback',{@slider_callback1,panelB});
    hScroll = uicontrol('Style','Slider','Parent',1,...
      'Units','normalized','Position',[0 0.95 1 0.05],...
      'Value',0,'Callback',{@slider_callback2,panelB});
    % (start width scrollbar,start height scrollbar,size width scrollbar,size height scrollbar)
    %axes('parent',hpanel,'outerposition',[.25 0 .5 1])
    
    %debug position scrollbar
%    hpanel=uipanel('position',[0 0 1 1]);
%    hscrollbar=uicontrol('style','slider','units','normalized','position',[0 0 1 .05],'callback',@hscroll_Callback);
%    axes('parent',hpanel)
    
    Visualization.plotCircuit(self.quantumRegister,self.maxLength);
    for operation = self.operationQueue
        %operationQueue is cell array, operation is now {operation struct}
        Visualization.plotOperation(operation{:}); %Use {:} to get the struct inside cell array
    end
    
    %plot_circuit(5)
    function slider_callback1(src, eventdata, arg1)
        val = get(src,'Value');
        pos = get(arg1,'Position');
        pos(2) = -val;
        set(arg1,'Position',pos)
    end
    function slider_callback2(src, eventdata, arg1)
        val = get(src,'Value');
        pos = get(arg1,'Position');
        pos(1) = -val;
        set(arg1,'Position',pos)
    end
end