import ExeQu.CircuitComposer.*;

elapsed_times = containers.Map('KeyType','char','ValueType','double');
visualize_times = containers.Map('KeyType','char','ValueType','double');
for step = [3 4 5 6 7 8 9 10 11 12]
    elapsed_time = 0;
    visualize_time = 0;
    for i = 1:5
        [e_t, v_t] = deutsch_balance(step, 2);
        elapsed_time = elapsed_time + e_t;
        visualize_time = visualize_time + v_t;
    end

    elapsed_times(string(step)) = elapsed_time/5;
    visualize_times(string(step)) = visualize_time/5;
end

fid=fopen('ml_deutsch_balance_elapsed.json','w');
fprintf(fid, jsonencode(elapsed_times)); 
fid=fopen('ml_deutsch_balance_visualize.json','w');
fprintf(fid, jsonencode(visualize_times)); 