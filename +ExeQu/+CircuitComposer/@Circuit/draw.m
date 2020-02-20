function draw(self)
    import ExeQu.Utils.*;
    global n_element
    n_element = zeros(1, self.quantumRegister.n_qubits);
    %qreg = self.quantumRegister;
    %op= self.operationQueue;
    n = setFigure();
    
    clf;
    
    panelA=uipanel('Parent', n);
    set(panelA,'Position',[0 0 0.95 1]);

    set(gca,'Parent',panelA);
    %set(gca,'ActivePositionProperty','position');
    
    % (start width, start height, zoom width, zoom height)
    
    vScroll = uicontrol('Style','Slider','Parent',1,...
      'Units','normalized','Position',[0.95 0 0.05 1],...
      'Value',0.5,'Callback',{@slider_callback1,gca});

    hScroll = uicontrol('Style','Slider','Parent',1,...
      'Units','normalized','Position',[0 0.95 1 0.05],...
      'Value',0,'Callback',{@slider_callback2,gca});
    zoomInBtn = uicontrol('Style','pushbutton','Parent',1,...
      'Units','normalized','Position',[0 0 0.1 0.05], ...
      'String','Zoom In','Callback',{@zoomIn_callback,gca,vScroll,hScroll});
    zoomOutBtn = uicontrol('Style','pushbutton','Parent',1,...
      'Units','normalized','Position',[0.1 0 0.1 0.05], ...
      'String','Zoom Out','Callback',{@zoomOut_callback,gca,vScroll,hScroll});
    % (start width scrollbar,start height scrollbar,size width scrollbar,size height scrollbar)
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
    
    
    gcaSize = get(gca, 'Position')
    set(gca, 'Position', [0 0 gcaSize(3) gcaSize(4)])
    %InSet = get(gca, 'TightInset');
    %set(gca, 'Position', [InSet(1:2), 1-InSet(1)-InSet(3), 1-InSet(2)-InSet(4)]);
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

    function zoomIn_callback(src, event, target, vscroll, hscroll)
        get(axes)
        magnitude = 2;
        vVal = get(vscroll, 'Value')
        hVal = get(hscroll, 'Value')
        pos = get(target, 'Position')
        
        pos = [pos(1) pos(2) pos(3)*magnitude pos(4)*magnitude];
        set(target, 'Position', pos);
        get(gca, 'OuterPosition')
    end
    
    function zoomOut_callback(src, event, target, vscroll, hscroll)
        magnitude = 2;
        vVal = get(vscroll, 'Value');
        hVal = get(hscroll, 'Value');
        pos = get(target, 'Position')
        pos = [pos(1) pos(2) pos(3)/magnitude pos(4)/magnitude];
        if pos(3) <= 0
            pos(3) = 0;
        end
        if pos(4) <= 0
            pos(4) = 0;
        end
        set(target, 'Position', pos);
        get(gca, 'OuterPosition')
    end
end