% Run all test cases
result = runtests('unitary_test.m');
rt = table(result)
result = runtests('hadamard_test.m');
rt = table(result)
result = runtests('pauli_test.m');
rt = table(result)
result = runtests('rxryrz_test.m');
rt = table(result)
result = runtests('cu_test.m');
rt = table(result)
result = runtests('ccu_test.m');
rt = table(result)
result = runtests('qubit_test.m');
rt = table(result)
result = runtests('qreg_test.m');
rt = table(result)
result = runtests('measure_op_test.m');
rt = table(result)