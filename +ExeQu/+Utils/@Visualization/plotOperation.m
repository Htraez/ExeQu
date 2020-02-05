function plotOperation(op)
    import ExeQu.Utils.*;
    global n_element;
    
    check = lower(op.label);
    margin_line_x=1;
    disp(check)
    
    % Counting number of element in each line
    n_element(op.associatedQubit) = max(n_element(op.associatedQubit) + 1);
    pos_x = 3 + max((margin_line_x*n_element(op.associatedQubit)) + n_element(op.associatedQubit));
    
    if check=="x"|| check=="y" || check=="z" || check=="h"
        pos_y = -2*(op.associatedQubit(1));
        % pos_x,pos_y is a center of rectangle
        
        start_x = pos_x-0.5;
        start_y = pos_y-0.5;
        % start_x,start_y is left-bottom angle of rectangle
        
        rectangle('Position',[start_x start_y 1 1],'FaceColor',[1 1 1]); 
        axis([0 inf -inf 0]);
        text(start_x+0.4,start_y+0.5,upper(check));
        % create gate
        
    elseif check=="cnot"
%         n_element=[1 1 1 0 0];
        distance = op.associatedQubit(2)-op.associatedQubit(1);
        pos_y = -2*(op.associatedQubit(1));
        % distance is length of cnot-line 
        % pos_x,pos_y is position cnot-line
        yline=[pos_y pos_y-(2*distance)];
        line([pos_x(1) pos_x(1)],yline);                        %//edit pos_x(1-2)
    
        r = 0.15;
        c = [pos_x(1) pos_y];
        % radius and center of small circle 
        % position of small circle.It means ctrl
        
        pos = [c-r 2*r 2*r];
        rectangle('Position',pos,'Curvature',[1 1], 'FaceColor', [0.3010 0.7450 0.9330], 'Edgecolor','none')
        % create small circle
        
        r = 0.3;
        c = [pos_x(1) pos_y-(2*distance)];
        % radius and center of big circle 
        % position of big circle.It means target
        
        pos = [c-r 2*r 2*r];
        rectangle('Position',pos,'Curvature',[1 1], 'FaceColor', [0.3010 0.7450 0.9330], 'Edgecolor','none')
        % create big circle
        
        yline=[pos_y-(2*distance)+0.2 pos_y-(2*distance)-0.2];
        line([pos_x(1) pos_x(1)],yline);
        xline=[pos_x(1)-0.2 pos_x(1)+0.2];
        line(xline,[pos_y-(2*distance) pos_y-(2*distance)]);
        % debug line missing
        
    elseif check=="cy" || check=="cz" || check=="controlled-u"
%         n_element=[2 2 0 0 0];
        pos_y = -2*(op.associatedQubit(1));
        % pos_x,pos_y is a center of rectangle
        
        start_x = pos_x-0.5;
        start_y = pos_y-0.5;
        % start_x,start_y is left-bottom angle of rectangle
        
        distance = op.associatedQubit(2)-op.associatedQubit(1);
        yline=[pos_y pos_y-(2*distance)];
        line([pos_x(1) pos_x(1)],yline);                        %//edit
        r = 0.15;
        c = [pos_x(1) pos_y];
        % radius and center of small circle 
        % position of small circle.It means ctrl
        
        pos = [c-r 2*r 2*r];
        rectangle('Position',pos,'Curvature',[1 1], 'FaceColor', [0.3010 0.7450 0.9330], 'Edgecolor','none')
        % create small circle
        
        rectangle('Position',[start_x(1) start_y-(2*distance) 1 1],'FaceColor',[1 1 1]);
        axis([0 inf -inf 0]);
        % crate gate
        
        if check=="controlled-u"
           check="u";
        elseif check=="cy"
           check="y";
        elseif check=="cz"
           check="z";
        end
        text(start_x(1)+0.4,start_y+0.5-(2*distance),upper(check));
        % debug text
        
    elseif check=="controlled-controlled-y" || check=="controlled-controlled-u" || check=="multiple controlled-u" || check=="multiple controlled-y" || check=="multiple controlled-z"
        L = max(op.associatedQubit)-min(op.associatedQubit);
%         n_element=[4 4 4 4 4];
        pos_y = -2*min(op.associatedQubit);
        % pos_x,pos_y is position line
        
        yline=[pos_y pos_y-(2*L)];
        line([pos_x(1) pos_x(1)],yline);                        %//edit pos_x(1-2)
        
        start_x = pos_x-0.5;
        % start_x is left-bottom angle of rectangle
        
        for a = 1:1:length(op.associatedQubit)
            r = 0.15;
            c = [pos_x(1) -(op.associatedQubit(a)*2)];
            % radius and center of small circle 
            % position of small circle.It means ctrl
        
            pos = [c-r 2*r 2*r];
            rectangle('Position',pos,'Curvature',[1 1], 'FaceColor', [0.3010 0.7450 0.9330], 'Edgecolor','none')
            % create small circle
            if a == length(op.associatedQubit)
            	rectangle('Position',[start_x(1) -(2*op.associatedQubit(a))-0.5 1 1],'FaceColor',[1 1 1]);
                axis([0 inf -inf 0]);
                % crate gate
                if check=="controlled-controlled-u"
                    check="u";
                elseif check=="controlled-controlled-y"
                    check="y";
                elseif check=="multiple controlled-u"
                    check="u";
                elseif check=="multiple controlled-y"
                    check="y";
                elseif check=="multiple controlled-z"
                    check="z";
                end
            end
        end
        text(start_x(1)+0.4,-(2*op.associatedQubit(a)),upper(check));
        % debug text
        
    elseif check=="toffoli" || check=="multiple control toffoli"
        L = max(op.associatedQubit)-min(op.associatedQubit);
%         n_element=[3 3 3 3 3];
        pos_y = -2*min(op.associatedQubit);
        % pos_x,pos_y is position ccnot-line
        
        yline=[pos_y pos_y-(2*L)];
        line([pos_x(1) pos_x(1)],yline);                        %//edit pos_x(1-2)
        
        for a = 1:1:length(op.associatedQubit)
            r = 0.15;
            c = [pos_x(1) -(op.associatedQubit(a)*2)];
            % radius and center of small circle 
            % position of small circle.It means ctrl
        
            pos = [c-r 2*r 2*r];
            rectangle('Position',pos,'Curvature',[1 1], 'FaceColor', [0.3010 0.7450 0.9330], 'Edgecolor','none')
            % create small circle
            
            if a == length(op.associatedQubit)
                r = 0.3;
                c = [pos_x(1) -(2*op.associatedQubit(a))];
                % radius and center of big circle 
                % position of big circle.It means target
        
                pos = [c-r 2*r 2*r];
                rectangle('Position',pos,'Curvature',[1 1], 'FaceColor', [0.3010 0.7450 0.9330], 'Edgecolor','none')
                % create big circle
                
                yline=[-(2*op.associatedQubit(a))+0.2 -(2*op.associatedQubit(a))-0.2];
                line([pos_x(1) pos_x(1)],yline);
                xline=[pos_x(1)-0.2 pos_x(1)+0.2];
                line(xline,[-(2*op.associatedQubit(a)) -(2*op.associatedQubit(a))]);
                % debug line missing
        
            end
        end
    end
end