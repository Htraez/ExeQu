import ExeQu.CircuitComposer.*;


elapsed_time = 0;
visualize_time = 0;
for i = 1:5
    [e_t, v_t] = grover();
    elapsed_time = elapsed_time + e_t;
    visualize_time = visualize_time + v_t;
end

elapsed_time/5
visualize_time/5