# Project ExeQu
### Quantum Gates and Circuit Simulator in MATLAB

ExeQu is a `MATLAB` toolbox designed to provide quantum programming enthusiats a tool for creating quantum circuit as well as simulating it result.

## Installation

ExeQu is currently on development. You can clone ExeQu using [remote url](https://github.com/Htraez/ExeQu.git)

```bash
git clone https://github.com/Htraez/ExeQu.git
```

## Usage

```matlab
import ExeQu.CircuitComposer.*;
import ExeQu.Gates.*;
import ExeQu.Utils.*;

%Create new quantum circuit with 2 qubits, 2 classical bits
circuit = Circuit(2, 2); 

%Add some quantum gates
circuit.h(1); %Add hadamard gate to the first qubit
circuit.cnot(1, 2); %Add controlled-not gate to with 1st as control and 2nd as target

circuit.draw(); %Draw circuit structure
result = circuit.execute(1024); %Simulate circuit (1024 shots)
result.plotHistogram(); %Visualize result
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
