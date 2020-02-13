import ExeQu.Gates.*;
import ExeQu.CircuitComposer.*;



circuit = Circuit(1, 1);
circuit.measure(1, 1);
circuit.draw();
circuit.peekOperations()
%result = circuit.execute(2000);
%result;
%result.getCount();
%result.plotHistogram();
