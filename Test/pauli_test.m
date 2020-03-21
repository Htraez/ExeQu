% Test Gates Class
current_prj_path = fullfile(pwd, '..');
addpath(current_prj_path)
import ExeQu.*;

% preconditions
tensor = @Utils.Maths.tensor;
I = eye(2);
test_x = [0 1; 1 0];
test_y = [0 -1i; 1i 0];
test_z = [1 0; 0 -1];

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
