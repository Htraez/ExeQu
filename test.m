
import ExeQu.CircuitComposer.*
import ExeQu.Gates.*
import ExeQu.Utils.*

circuit = Circuit(3, 3);

circuit.h(2)
circuit.cnot(1, 2)
circuit.ccnot(1, 2, 3)

circuit.measure(1, 1)
circuit.measure(2, 2)
circuit.measure(3, 3)

circuit.draw();
% circuit.peekOperations()
result = circuit.execute(2000);
result;
result.getCount();
result.plotHistogram();
