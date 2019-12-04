function plotOperation(op)
    import ExeQu.Utils.*;
    check = op.label;
    if check=="X"|| check=="Y" || check=="Z" || check=="H"
        margin_line_x=1;
        n_element=[0 0 0 0 0];
        pos_x = 3 + (margin_line_x*n_element(op.associatedQubit)) + n_element(op.associatedQubit);
        pos_y = -2*(op.associatedQubit(1));
        %disp(pos_y);
        start_x = pos_x-0.5;
        start_y = pos_y-0.5;
        rectangle('Position',[start_x start_y 1 1],'FaceColor',[1 1 1]); % box
        axis([0 inf -inf 0]);
        text(start_x+0.4,start_y+0.5,check);
    elseif check=="CNOT"
        margin_line_x=1;
        n_element=[1 1 0 0 0];
        %disp(op);
        distance = op.associatedQubit(2)-op.associatedQubit(1);
        pos_x = 3 + (margin_line_x*n_element(op.associatedQubit)) + n_element(op.associatedQubit);
        pos_y = -2*(op.associatedQubit(1));
        disp("pos_x");
        disp(pos_x);
        
        yline=[pos_y pos_y-(2*distance)];
        line([pos_x(1) pos_x(1)],yline);            %//edit
    
        r = 0.15;                        %// radius
        c = [pos_x(1) pos_y];                    %// center Small

        pos = [c-r 2*r 2*r];
        rectangle('Position',pos,'Curvature',[1 1], 'FaceColor', [0.3010 0.7450 0.9330], 'Edgecolor','none')
    
        r = 0.3;                        %// radius
        c = [pos_x(1) pos_y-(2*distance)];                    %// center Big

        pos = [c-r 2*r 2*r];
        rectangle('Position',pos,'Curvature',[1 1], 'FaceColor', [0.3010 0.7450 0.9330], 'Edgecolor','none')
    
        yline=[pos_y-(2*distance)+0.2 pos_y-(2*distance)-0.2];
        line([pos_x(1) pos_x(1)],yline);
    
        xline=[pos_x(1)-0.2 pos_x(1)+0.2];
        line(xline,[pos_y-(2*distance) pos_y-(2*distance)]);
    end
end