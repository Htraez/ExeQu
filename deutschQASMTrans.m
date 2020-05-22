import ExeQu.CircuitComposer.*;
import ExeQu.Gates.*;
circuit = Circuit(3,2);
circuit.u3(1,pi/2,0,pi);
circuit.u3(2,pi/2,0,pi);
circuit.u3(3,pi,0,pi);
circuit.u3(3,pi/2,0,pi);
circuit.cnot(2,3);
circuit.cnot(1,3);
circuit.u3(1,pi/2,0,pi);
circuit.u3(2,pi/2,0,pi);
circuit.measure(1,1);
circuit.measure(2,2);
%auto generate when circuit was created
circuit.draw();
result = circuit.execute(1024);
result.plotHistogram();
