OPENQASM 2.0;
include "gate.inc";
qreg q[5];
creg c[5];
x q[0];
cx q[1],q[2];
u3(pi,pi/2,pi/2) q[3];
CX q[3],q[2];
U(pi/2,pi/2,pi/2) q[4];
barrier q;
//comment
measure q->c;