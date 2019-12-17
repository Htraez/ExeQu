function plotOperation(op)
    import ExeQu.Utils.*;
    check = lower(op.label);
    margin_line_x=1;
    if check=="x"|| check=="y" || check=="z" || check=="h"
        n_element=[0 0 0 0 0];
        pos_x = 3 + (margin_line_x*n_element(op.associatedQubit)) + n_element(op.associatedQubit);
        pos_y = -2*(op.associatedQubit(1));

        start_x = pos_x-0.5;
        start_y = pos_y-0.5;
        rectangle('Position',[start_x start_y 1 1],'FaceColor',[1 1 1]); % box
        axis([0 inf -inf 0]);
        text(start_x+0.4,start_y+0.5,upper(check));
    elseif check=="cnot"
        n_element=[1 1 0 0 0];
        distance = op.associatedQubit(2)-op.associatedQubit(1);
        pos_x = 3 + (margin_line_x*n_element(op.associatedQubit)) + n_element(op.associatedQubit);
        pos_y = -2*(op.associatedQubit(1));
        yline=[pos_y pos_y-(2*distance)];
        line([pos_x(1) pos_x(1)],yline);                        %//edit pos_x(1-2)
    
        r = 0.15;                                               %// radius
        c = [pos_x(1) pos_y];                                   %// center Small

        pos = [c-r 2*r 2*r];
        rectangle('Position',pos,'Curvature',[1 1], 'FaceColor', [0.3010 0.7450 0.9330], 'Edgecolor','none')
    
        r = 0.3;                                                %// radius
        c = [pos_x(1) pos_y-(2*distance)];                      %// center Big

        pos = [c-r 2*r 2*r];
        rectangle('Position',pos,'Curvature',[1 1], 'FaceColor', [0.3010 0.7450 0.9330], 'Edgecolor','none')
    
        yline=[pos_y-(2*distance)+0.2 pos_y-(2*distance)-0.2];
        line([pos_x(1) pos_x(1)],yline);
    
        xline=[pos_x(1)-0.2 pos_x(1)+0.2];
        line(xline,[pos_y-(2*distance) pos_y-(2*distance)]);
    elseif check=="cy" || check=="cz" || check=="controlled-u"
        n_element=[2 2 0 0 0];
        pos_x = 3 + (margin_line_x*n_element(op.associatedQubit)) + n_element(op.associatedQubit);
        pos_y = -2*(op.associatedQubit(1));

        start_x = pos_x-0.5;
        start_y = pos_y-0.5;
        
        distance = op.associatedQubit(2)-op.associatedQubit(1);
        yline=[pos_y pos_y-(2*distance)];
        line([pos_x(1) pos_x(1)],yline);                        %//edit
        r = 0.15;                                               %// radius
        c = [pos_x(1) pos_y];                                   %// center Small

        pos = [c-r 2*r 2*r];
        rectangle('Position',pos,'Curvature',[1 1], 'FaceColor', [0.3010 0.7450 0.9330], 'Edgecolor','none')
        rectangle('Position',[start_x(1) start_y-(2*distance) 1 1],'FaceColor',[1 1 1]); % box
        axis([0 inf -inf 0]);
        if check=="controlled-u"
            check="u";
        end
        text(start_x(1)+0.3,start_y+0.5-(2*distance),upper(check));
    %elseif check=="toffoli" || check=="multiple control toffoli"
    %L=length(op.associatedQubit);
    %disp(op.associatedQubit)
    %n_element=[3 3 0 0 0];
    %distance = op.associatedQubit(2)-op.associatedQubit(1);
    %pos_x = 3 + (margin_line_x*n_element(op.associatedQubit)) + n_element(op.associatedQubit);
    %pos_y = -2*(op.associatedQubit(1));

    end
end