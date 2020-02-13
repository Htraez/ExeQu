function plotOperation(op)
    import ExeQu.CircuitComposer.*;
    import ExeQu.Utils.*;
    global n_element;
    
    check = lower(op.label);
    margin_line_x=1;
    disp(check)

%    before=(n_element)
    temp = max(n_element(min(op.associatedQubit):max(op.associatedQubit))+1);
    n_element(min(op.associatedQubit):max(op.associatedQubit))=temp;
%    after=(n_element)
    % Counting number of element in each line
    
    pos_x = 3 + ((margin_line_x*n_element(op.associatedQubit)) + n_element(op.associatedQubit));
    pos_y = -2*min(op.associatedQubit);
    L = max(op.associatedQubit)-min(op.associatedQubit);       
    yline=[pos_y pos_y-(2*L)];
    line([pos_x(1) pos_x(1)],yline);                        %//edit pos_x(1-2)
    
    if check=="x"|| check=="y" || check=="z" || check=="h"
        start_x = pos_x-0.5;
        start_y = pos_y-0.5;
        % start_x,start_y is left-bottom angle of rectangle
        
        rectangle('Position',[start_x start_y 1 1],'FaceColor',[1 1 1]); 
        axis([0 inf -inf 0]);
        text(start_x+0.4,start_y+0.5,upper(check));
        % create gate
        
    elseif check=="cy" || check=="cz" || check=="controlled-u" || check=="controlled-controlled-y" || check=="controlled-controlled-u" || check=="multiple controlled-u" || check=="multiple controlled-y" || check=="multiple controlled-z"
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
                if check=="controlled-u" || check=="controlled-controlled-u" || check=="multiple controlled-u"
                    check="u";
                elseif check=="controlled-controlled-y" || check=="multiple controlled-y"
                    check="y";
                elseif check=="multiple controlled-z"
                    check="z";
                elseif check=="cy"
                    check="y";
                elseif check=="cz"
                    check="z";
                end
            end
        end
        text(start_x(1)+0.4,-(2*op.associatedQubit(a)),upper(check));
        % debug text
        
    elseif check=="cnot" || check=="toffoli" || check=="multiple control toffoli"
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
    elseif check=="u"
        
    
    elseif check=="measurement"
    	hold on
        start_x = pos_x-0.5;
        start_y = pos_y-0.5;
        rectangle('Position',[start_x start_y 1 1],'FaceColor',[1 1 1]); 
        
        %xM = [pos_x-0.35 pos_x pos_x+0.35];
        %yM = [pos_y pos_y+0.35 pos_y];
        %xi = pos_x-0.35 : 0.01 : pos_x+0.35;
        %yi = interp1(xM,yM,xi,'spline');
        %plot(xi,yi)
        
        th = linspace( pi/2, -pi/2, 100);
        R = 0.35;
        x = R*sin(th)+pos_x;
        y = R*cos(th)+pos_y;
        plot(x,y);
        %axis equal;
        
%        xA = [0.52,0.55];
%        yA = [0.32,0.36];
%        annotation('textarrow',xA,yA);
            
%        xA = [0.52,0.52];                 
%        yA = [0.295,0.185];                 %0.15=1 axis
%        annotation('textarrow',xA,yA);
    
        if isfield(op, "measurementOperation")
            basisToShow = op.measurementOperation.getBasis();
        end
        check = basisToShow;
        text(start_x(1)+0.4,-(2*op.associatedQubit)-0.25,upper(check));
        hold off
    end
end