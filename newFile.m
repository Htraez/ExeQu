OPENQASM 2.0
include "qelib1.inc"
qreg q[5]
creg c[5]
gate cH a,b
begin
h b
sdg b
cx a,b
h b
t b
cx a,b
t b
h b
s b
x b
s a
end
//qwerty
if (c==0)
x q[1]

