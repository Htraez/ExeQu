% Test Gates Class
current_prj_path = fullfile(pwd, '..');
addpath(current_prj_path)
import ExeQu.*;

% preconditions
tensor = @Utils.Maths.tensor;
I = eye(2);
theta1 = 0;
theta2 = (1/2)*pi;
theta3 = 2*pi;

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