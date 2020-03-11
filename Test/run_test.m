result = runtests('unitary_test.m');
rt = table(result)
result = runtests('hadamard_test.m');
rt = table(result)
result = runtests('pauli_test.m');
rt = table(result)
result = runtests('rxryrz_test.m');
rt = table(result)