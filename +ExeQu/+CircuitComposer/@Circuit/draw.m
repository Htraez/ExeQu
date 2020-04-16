function draw(self)
    import ExeQu.Utils.*;
    global n_element
	global maxHeigth
	global Y_scaleInterval
	global maxLength
	global X_scaleInterval
    global start_xBottom
    global start_yBottom
    n_element = zeros(1, self.quantumRegister.n_qubits);
    %qreg = self.quantumRegister;
    %op= self.operationQueue;
    n = setFigure();
    
    clf;
    
    X_scaleInterval = 25;
    Y_scaleInterval = 20;
    panelA=uipanel('Parent', n);
    set(panelA,'Position',[0 0 0.95 1]);

    set(gca,'Parent',panelA);
    %set(gca,'ActivePositionProperty','position');
    
    % (start width, start height, zoom width, zoom height)
    maxLength=2.75*self.maxLength;
    maxHeigth=-2*self.quantumRegister.n_qubits-2.5;
    
    vScroll = uicontrol('Style','Slider','Parent',1,...
      'Units','normalized','Position',[0.95 0 0.05 1],...
      'Value',0,'Callback',{@slider_callback1,gca, maxHeigth});
    hScroll = uicontrol('Style','Slider','Parent',1,...
      'Units','normalized','Position',[0 0.95 1 0.05],...
      'Value',0,'Callback',{@slider_callback2,gca, maxLength});
    upInBtn = uicontrol('Style','pushbutton','Parent',1,...
      'Units','normalized','Position',[0.2 0 0.1 0.05], ...
      'String','Up','Callback',{@up_callback});
    downInBtn = uicontrol('Style','pushbutton','Parent',1,...
      'Units','normalized','Position',[0.3 0 0.1 0.05], ...
      'String','Down','Callback',{@down_callback});
    leftInBtn = uicontrol('Style','pushbutton','Parent',1,...
      'Units','normalized','Position',[0.4 0 0.1 0.05], ...
      'String','Left','Callback',{@left_callback});
    rightInBtn = uicontrol('Style','pushbutton','Parent',1,...
      'Units','normalized','Position',[0.5 0 0.1 0.05], ...
      'String','Right','Callback',{@right_callback});
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
    
    Visualization.plotCircuit(self.quantumRegister,self.maxLength);
    for operation = self.operationQueue
        %operationQueue is cell array, operation is now {operation struct}
        Visualization.plotOperation(operation{:}); %Use {:} to get the struct inside cell array
    end

    xl = get(gca, 'Xlim');
    set(gca, 'Xlim', [xl(1) xl(1)+X_scaleInterval])
    yl = get(gca, 'Ylim');
    set(gca, 'Ylim', [yl(2)-Y_scaleInterval yl(2)])
    %InSet = get(gca, 'TightInset');
    %set(gca, 'Position', [InSet(1:2), 1-InSet(1)-InSet(3), 1-InSet(2)-InSet(4)]);
    %plot_circuit(5)
    function slider_callback1(src, eventdata, arg1, maxHeigth)
        val = get(src,'Value');
        %pos = get(arg1,'Position')
        %pos(2) = -val;
        %set(arg1,'Position',pos)
        %arg1
        start=maxHeigth-(round(val*maxHeigth));
        if maxHeigth+20 >= 0
            if maxHeigth >= -Y_scaleInterval
                set(arg1,'Ylim',[-Y_scaleInterval 0])
            else
                val2 = get(src,'Value');
                start=maxHeigth-(round(val2*maxHeigth));
                set(arg1,'Ylim',[start start+Y_scaleInterval])
            end
            
            %set(arg1,'Ylim',[maxHeigth 0])
        else
            set(arg1,'Ylim',[start start+Y_scaleInterval])
        end
    end
    function slider_callback2(src, eventdata, arg1, maxLength)
        %old_xlim = get(gca,'Xlim')
        %old_ylim = get(gca,'Ylim')
        val = get(src,'Value');
        %pos = get(arg1,'Position')
        %pos(1) = -val
        %set(arg1,'Xlim',old_xlim-val)
        start=round(val*maxLength);
        if round(val*maxLength)>=maxLength-X_scaleInterval                  %if start+x_scale>=maxLength
            %set(arg1,'Xlim',[maxLength-X_scaleInterval maxLength])
            if maxLength <= X_scaleInterval
                set(arg1,'Xlim',[0 X_scaleInterval])
            else            
                val2 = get(src,'Value');
                start=round(val2*maxLength);
                set(arg1,'Xlim',[start start+X_scaleInterval])
            end
        else
            set(arg1,'Xlim',[start start+X_scaleInterval])
        end
    end
    function up_callback(src, event, target)
        start_yBottom = get(gca,'Ylim');
        start = start_yBottom(2);
        start = start+(Y_scaleInterval/2)
        set(gca,'Ylim',[start-Y_scaleInterval start])
    end
    function down_callback(src, event, target)
        start_yBottom = get(gca,'Ylim');
        start = start_yBottom(2);
        start = start-(Y_scaleInterval/2)
        set(gca,'Ylim',[start-Y_scaleInterval start])
    end
    function left_callback(src, event, target)
        start_xBottom = get(gca,'Xlim');
        start = start_xBottom(1);
        start = start-(X_scaleInterval/2)
        set(gca,'Xlim',[start start+X_scaleInterval])
    end
    function right_callback(src, event, target)
        start_xBottom = get(gca,'Xlim');
        start = start_xBottom(1);
        start = start+(X_scaleInterval/2)
        set(gca,'Xlim',[start start+X_scaleInterval])
    end
    function zoomIn_callback(src, event, target, ~, hscroll)
        old_xlim = get(gca,'Xlim');
        old_ylim = get(gca,'Ylim');
%       [old_xlim(1)/2 old_xlim(2)/2]
%       [old_ylim(1)/2 old_ylim(2)/2]
        set(gca, 'Xlim', [old_xlim(1)/2 old_xlim(2)/2]);
        set(gca, 'Ylim', [old_ylim(1)/2 old_ylim(2)/2]);   
        Y_scaleInterval=Y_scaleInterval/2;
        X_scaleInterval=X_scaleInterval/2;
%         get(axes)
%         magnitude = 2;
%         vVal = get(vscroll, 'Value')
%         hVal = get(hscroll, 'Value')
%         pos = get(target, 'Position')
%         
%         pos = [pos(1) 0 pos(3)*magnitude pos(4)*magnitude];
%         set(target, 'Position', pos);
%         get(gca, 'OuterPosition')
    end
    
    function zoomOut_callback(src, event, target, vscroll, hscroll)
        old_xlim = get(gca,'Xlim');
        old_ylim = get(gca,'Ylim');
        set(gca, 'Xlim', [old_xlim(1)*2 old_xlim(2)*2]);
        set(gca, 'Ylim', [old_ylim(1)*2 old_ylim(2)*2]);
        Y_scaleInterval=Y_scaleInterval*2;
        X_scaleInterval=X_scaleInterval*2;
        %set(gca, 'Ylim', [old_ylim])
%         magnitude = 2;
%         vVal = get(vscroll, 'Value');
%         hVal = get(hscroll, 'Value');
%         pos = get(target, 'Position')
%         pos = [pos(1) 0 pos(3)/magnitude pos(4)/magnitude];
%         if pos(3) <= 0
%             pos(3) = 0;
%         end
%         if pos(4) <= 0
%             pos(4) = 0;
%         end
%         set(target, 'Position', pos);
%         get(gca, 'OuterPosition')
    end
end