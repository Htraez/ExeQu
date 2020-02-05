function setFigure() 
    global n_figure
    
    if isempty(n_figure)
        n_figure = 1;
    else
        n_figure = n_figure + 1;
    end     
    figure(n_figure);
end