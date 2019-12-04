# Project ExeQu
### Quantum Gates and Circuit Simulator in MATLAB

ExeQu is a `MATLAB` toolbox designed to provide quantum programming enthusiats a tool for creating quantum circuit as well as simulating it result.

## Installation

ExeQu is currently under development. You can clone ExeQu using [remote url](https://github.com/Htraez/ExeQu.git)

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
## Quantum Gates

A quantum gate could be added to a circuit using methods defined in the `Circuit`. Right now there several of them available as shown below.

Suppose a circuit instantiate using this code 

```matlab
circuit = Circuit(2, 2);
```

| Gates          | Name         | Syntax                    |
| -------------- |:------------:| -------------------------:|
| ![alt text][x] | Pauli-x Gate | circuit.x(`target_qubit`) |
| ![alt text][y] | Pauli-y Gate | circuit.y(`target_qubit`) |
| ![alt text][z] | Pauli-z Gate | circuit.z(`target_qubit`) |

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)

[x]: https://s3.us-south.cloud-object-storage.appdomain.cloud/strapi/c51de67e35e3428b85cb383834263479x.png "Pauli X"
[y]: https://s3.us-south.cloud-object-storage.appdomain.cloud/strapi/1fe22994647245299d2c257958d14562y.png "Pauli Y"
[z]: https://s3.us-south.cloud-object-storage.appdomain.cloud/strapi/3c02d82e71984f0884ee1b5e798674edz.png "Pauli Z"
