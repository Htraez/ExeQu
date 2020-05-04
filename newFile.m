import ExeQu.CircuitComposer.*;
import ExeQu.Gates.*;
circuit = Circuit(15,10);
%include "qelib1.inc"
%gate abc a,b,c { CX a,b; U ( pi/2,pi/2,pi/2 )  c;}
%gate xx a,b { U ( pi/2,0,0 )  a ; x b,a ; yy ( pi/6,pi/4 )  b,a;}
circuit.u3(2,pi/6,pi/4,0);
circuit.cnot(2,1);
circuit.u3(2,pi/2,pi/2,pi/2);
circuit.u3(2,pi/3,pi/5,0);
circuit.cnot(1,2);
%creg c2[5];
%x q[0],q[1];
%xx q[0],q[1];
%abc q[1],q[2],q[3];
%CX q[2],q1[0];
%CX q,q1;
%U ( pi/2,pi/2,pi/2 )  q[4];
%measure q[2]->c1[4];
%measure q->c1;
%comment line
