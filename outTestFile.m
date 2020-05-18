import ExeQu.CircuitComposer.*;
import ExeQu.Gates.*;
circuit = Circuit(5,5);
circuit.u3(5,pi,0,pi);
circuit.cnot(3,4);
circuit.u3(5,pi,pi/2,pi/2);
circuit.barrier(1,5);
%comment
circuit.measure(1,1);
circuit.measure(2,2);
circuit.measure(3,3);
circuit.measure(4,4);
circuit.measure(5,5);
%auto generate when circuit was created
circuit.draw();
result = circuit.execute(1024);
result.plotHistogram();
