import ExeQu.Gates.*;
import ExeQu.CircuitComposer.*;

circuit = Circuit(5, 3);

for i = 1:100
    circuit.h(1)
end
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
circuit.measure(1, 1)
circuit.measure(2, 2)
circuit.measure(3, 3)
%% circuit.cnot(2, 1)
%circuit.ccnot(2, 5, 3)
circuit.unitary([0 1; 1 0], 2);
circuit.draw();
circuit.getMaxLength()
%circuit.peekOperations()
%result = circuit.execute(2000);
%result;
%result.getCount();
%result.plotHistogram();
