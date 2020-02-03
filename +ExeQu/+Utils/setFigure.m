function figureID = setFigure(varargin)
    persistent n_figure
    if nargin > 0
        flag = varargin{1};
        if strfind(flag, "clear") >= 0
            clf;
            n_figure = 0;
            return;
        end
    end

    if isempty(n_figure)
        n_figure = 1;
    else
        n_figure = n_figure + 1;
    end
    figureID = n_figure;
end