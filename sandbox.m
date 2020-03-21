import ExeQu.Gates.*;
import ExeQu.CircuitComposer.*;

circuit = Circuit(10, 3);

circuit.x(2)    
circuit.cz(5, 3)
circuit.unitary([0 1; 1 0], [2,4]);
circuit.unitary([0 1; 1 0], [4,1]);
%circuit.cnot(4, 2)
%circuit.cnot(4, 5)
U = Unitary([0 1; 1 0]);
circuit.controlledU(U,[3,4], 5);
circuit.controlledU(U,[3,4], 2);
%circuit.cy(4, 1)
%circuit.controlledU(@PauliX,[1,2,3], 5);
%circuit.controlledU('x',[1, 4], 2);
tic
circuit.measure(1, 1)
add_measure_time1 = toc
tic
circuit.measure(2, 2)
add_measure_time2 = toc
circuit.measure(3, 3)
%% circuit.cnot(2, 1)
%circuit.ccnot(2, 5, 3)
circuit.unitary([0 1; 1 0], 2);

tic
ops = circuit.peekOperations()
ops{7}.measurementOperation
celldisp(ops)
result = circuit.execute(2000);
execute_time = toc

circuit.draw();
circuit.getMaxLength()
%result;
result.getCount();
%result.plotHistogram();
