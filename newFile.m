import ExeQu.CircuitComposer.*;
import ExeQu.Gates.*;
circuit = Circuit(15,10);
%include "qelib1.inc"
%gate abc a,b,c { CX a,b; U ( pi/2,pi/2,pi/2 )  c;}
%gate ryy ( theta,phi )  a,b { U ( theta,phi,0 )  a; x b,a; }
%ryy ( pi/2,pi/2 )  q[1],q[0];
%creg c2[5];
%x q[0],q[1];
circuit.u3(1,pi/2,0,0);
circuit.cnot(1,2);
circuit.u3(1,pi/2,pi/2,pi/2);
circuit.u3(2,pi/6,pi/4,0);
circuit.cnot(1,2);
%abc q[1],q[2],q[3];
%CX q[2],q1[0];
%CX q,q1;
%U ( pi/2,pi/2,pi/2 )  q[4];
circuit.measure(3,10);
%measure q->c1;
%comment line
