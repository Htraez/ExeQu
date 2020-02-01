function plotHistogram(count, shots)
    import ExeQu.Utils.*;
    figure(setFigure());
    bar(cell2mat(values(count))/shots)
    set(gca,'XTick', 1:length(keys(count)))
    set(gca,'xticklabel', keys(count))
end