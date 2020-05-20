OPENQASM 2.0;
gate x a { U(pi,0,pi) a; }
gate h a { U(pi/2,0,pi) a; }
qreg q[3];
creg c[2];
h q[0];
h q[1];
x q[2];
h q[2];
CX q[1],q[2];
CX q[0],q[2];
h q[0];
h q[1];
measure q[0] -> c[0];
measure q[1] -> c[1];