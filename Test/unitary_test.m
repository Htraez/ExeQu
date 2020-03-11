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
test_xy = tensor(test_x, test_y);

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

%% Gate: 2bit Unitary in 2bit Circuit, flip
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