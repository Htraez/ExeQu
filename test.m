
import ExeQu.CircuitComposer.*
import ExeQu.Gates.*
import ExeQu.Utils.*


circuit = Circuit(2, 3)

circuit.x(1)
circuit.h(2)
circuit.measure(1, 1)
circuit.measure(2, 2)
% circuit.cnot(2, 1)
% circuit.cy(1, 2)
% circuit.ccnot(1, 2, 3)
%circuit.unitary([0 1; 1 0], 2)


%circuit.draw()
circuit.peekOperations()
result = circuit.execute();
result.getCount();
result.plotHistogram();
