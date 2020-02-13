% Test Gates Class
import ExeQu.*;

% preconditions
tensor = @Utils.Maths.tensor;
I = eye(2);
test_x = [0 1; 1 0];
test_y = [0 -1i; 1i 0];
test_z = [1 0; 0 -1];
test_xy = tensor(test_x, test_y);
test_h = 1/sqrt(2) * [1 1; 1 -1];
theta1 = 0;
theta2 = (1/2)*pi;
theta3 = 2*pi;

%% Gate: Independent Unitary
act = Gates.Unitary(test_x).toMatrice();
exp = [0 1; 1 0];
assert(isequal(act, exp))

%% Gate: 1bit Unitary in Circuit (Basic)
act = Gates.Unitary(test_x, 1, 1).toMatrice();
exp = [0 1; 1 0];
assert(isequal(act, exp))

%% Gate: 1bit Unitary in 2bit Circuit (act on 1st bit)
act = Gates.Unitary(test_x, 2, 1).toMatrice();
exp = tensor([0 1; 1 0], I);
assert(isequal(act, exp))

%% Gate: 1bit Unitary in 2bit Circuit (act on 2nd bit)
act = Gates.Unitary(test_x, 2, 2).toMatrice();
exp = tensor(I,[0 1; 1 0]);
assert(isequal(act, exp))

%% Gate: 2bit Unitary in 2bit Circuit
act = Gates.Unitary(test_xy, 2, [1, 2]).toMatrice();
exp = tensor(test_x, test_y);
assert(isequal(act, exp))

%% Gate: 2bit Unitary in 3bit Circuit
act = Gates.Unitary(test_xy, 3, [1, 2]).toMatrice();
exp = tensor(test_x, test_y, I);
assert(isequal(act, exp))

%% Gate: 2bit Unitary in 3bit Circuit (Omit first bit)
act = Gates.Unitary(test_xy, 3, [2, 3]).toMatrice();
exp = tensor(I, test_x, test_y);
assert(isequal(act, exp))

%% Gate: Independent Hadamard
act = Gates.Hadamard().toMatrice();
exp = test_h;
assert(isequal(act, exp))

%% Gate: Hadamard in 1bit Circuit
act = Gates.Hadamard(1, 1).toMatrice();
exp = test_h;
assert(isequal(act, exp))

%% Gate: Hadamard in 2bit Circuit
act = Gates.Hadamard(2, 1).toMatrice();
exp = tensor(test_h, I);
assert(isequal(act, exp))

%% Gate: Hadamard in 2bit Circuit (Omit 1st bit)
act = Gates.Hadamard(2, 2).toMatrice();
exp = tensor(I, test_h);
assert(isequal(act, exp))

%% Gate: Independent PauliX
act = Gates.PauliX().toMatrice();
exp = test_x;
assert(isequal(act, exp))

%% Gate: PauliX in 1bit Circuit
act = Gates.PauliX(1, 1).toMatrice();
exp = test_x;
assert(isequal(act, exp))

%% Gate: PauliX in 2bit Circuit
act = Gates.PauliX(2, 1).toMatrice();
exp = tensor(test_x, I);
assert(isequal(act, exp))

%% Gate: PauliX in 2bit Circuit (Omit 1st bit)
act = Gates.PauliX(2, 2).toMatrice();
exp = tensor(I, test_x);
assert(isequal(act, exp))

%% Gate: Independent PauliY
act = Gates.PauliY().toMatrice();
exp = test_y;
assert(isequal(act, exp))

%% Gate: PauliY in 1bit Circuit
act = Gates.PauliY(1, 1).toMatrice();
exp = test_y;
assert(isequal(act, exp))

%% Gate: PauliY in 2bit Circuit
act = Gates.PauliY(2, 1).toMatrice();
exp = tensor(test_y, I);
assert(isequal(act, exp))

%% Gate: PauliY in 2bit Circuit (Omit 1st bit)
act = Gates.PauliY(2, 2).toMatrice();
exp = tensor(I, test_y);
assert(isequal(act, exp))

%% Gate: Independent PauliZ
act = Gates.PauliZ().toMatrice();
exp = test_z;
assert(isequal(act, exp))

%% Gate: PauliZ in 1bit Circuit
act = Gates.PauliZ(1, 1).toMatrice();
exp = test_z;
assert(isequal(act, exp))

%% Gate: PauliZ in 2bit Circuit
act = Gates.PauliZ(2, 1).toMatrice();
exp = tensor(test_z, I);
assert(isequal(act, exp))

%% Gate: PauliZ in 2bit Circuit (Omit 1st bit)
act = Gates.PauliZ(2, 2).toMatrice();
exp = tensor(I, test_z);
assert(isequal(act, exp))

%% Gate: Independent RX
act = Gates.RX(theta1).toMatrice();
exp = exp_rx(theta1);
assert(isequal(act, exp))
act = Gates.RX(theta2).toMatrice();
exp = exp_rx(theta2);
assert(isequal(act, exp))
act = Gates.RX(theta3).toMatrice();
exp = exp_rx(theta3);
assert(isequal(act, exp))

%% Gate: RX in 1bit Circuit
act = Gates.RX(1, 1, theta1).toMatrice();
exp = exp_rx(theta1);
assert(isequal(act, exp))
act = Gates.RX(1, 1, theta2).toMatrice();
exp = exp_rx(theta2);
assert(isequal(act, exp))
act = Gates.RX(1, 1, theta3).toMatrice();
exp = exp_rx(theta3);
assert(isequal(act, exp))

%% Gate: RX in 2bit Circuit
act = Gates.RX(2, 1, theta1).toMatrice();
exp = tensor(exp_rx(theta1), I);
assert(isequal(act, exp))
act = Gates.RX(2, 1, theta2).toMatrice();
exp = tensor(exp_rx(theta2), I);
assert(isequal(act, exp))
act = Gates.RX(2, 1, theta3).toMatrice();
exp = tensor(exp_rx(theta3), I);
assert(isequal(act, exp))

%% Gate: RX in 2bit Circuit (Omit 1st bit)
act = Gates.RX(2, 2, theta1).toMatrice();
exp = tensor(I, exp_rx(theta1));
assert(isequal(act, exp))
act = Gates.RX(2, 2, theta2).toMatrice();
exp = tensor(I, exp_rx(theta2));
assert(isequal(act, exp))
act = Gates.RX(2, 2, theta3).toMatrice();
exp = tensor(I, exp_rx(theta3));
assert(isequal(act, exp))

%% Gate: Independent RY
act = Gates.RY(theta1).toMatrice();
exp = exp_ry(theta1);
assert(isequal(act, exp))
act = Gates.RY(theta2).toMatrice();
exp = exp_ry(theta2);
assert(isequal(act, exp))
act = Gates.RY(theta3).toMatrice();
exp = exp_ry(theta3);
assert(isequal(act, exp))

%% Gate: RY in 1bit Circuit
act = Gates.RY(1, 1, theta1).toMatrice();
exp = exp_ry(theta1);
assert(isequal(act, exp))
act = Gates.RY(1, 1, theta2).toMatrice();
exp = exp_ry(theta2);
assert(isequal(act, exp))
act = Gates.RY(1, 1, theta3).toMatrice();
exp = exp_ry(theta3);
assert(isequal(act, exp))

%% Gate: RY in 2bit Circuit
act = Gates.RY(2, 1, theta1).toMatrice();
exp = tensor(exp_ry(theta1), I);
assert(isequal(act, exp))
act = Gates.RY(2, 1, theta2).toMatrice();
exp = tensor(exp_ry(theta2), I);
assert(isequal(act, exp))
act = Gates.RY(2, 1, theta3).toMatrice();
exp = tensor(exp_ry(theta3), I);
assert(isequal(act, exp))

%% Gate: RY in 2bit Circuit (Omit 1st bit)
act = Gates.RY(2, 2, theta1).toMatrice();
exp = tensor(I, exp_ry(theta1));
assert(isequal(act, exp))
act = Gates.RY(2, 2, theta2).toMatrice();
exp = tensor(I, exp_ry(theta2));
assert(isequal(act, exp))
act = Gates.RY(2, 2, theta3).toMatrice();
exp = tensor(I, exp_ry(theta3));
assert(isequal(act, exp))

% Function definitions
function test_rx = exp_rx(theta)
    test_rx = [cos(theta/2) -1i*sin(theta/2); -1i*sin(theta/2) cos(theta/2)];
end
function test_ry = exp_ry(theta)
    test_ry = [cos(theta/2) -sin(theta/2); sin(theta/2) cos(theta/2)];
end
function test_rz = exp_rz(theta)
    test_rz = [exp(-1i*theta/2) 0; 0 exp(1i*theta/2)];
end