% Test Gates Class
current_prj_path = fullfile(pwd, '..');
addpath(current_prj_path)
import ExeQu.*;

% preconditions
tensor = @Utils.Maths.tensor;
I = eye(2);
test_h = 1/sqrt(2) * [1 1; 1 -1];

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

%% Gate: Hadamard in 3bit Circuit, act on 1st
act = Gates.Hadamard(3, 1).toMatrice();
exp = tensor(test_h, I, I);
assert(isequal(act, exp))

%% Gate: Hadamard in 3bit Circuit, act on 2nd
act = Gates.Hadamard(3, 2).toMatrice();
exp = tensor(I, test_h, I);
assert(isequal(act, exp))

%% Gate: Hadamard in 3bit Circuit, act on 3rd
act = Gates.Hadamard(3, 3).toMatrice();
exp = tensor(I, I, test_h);
assert(isequal(act, exp))