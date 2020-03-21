function o2c(circuit, operations)
    % Map operation to circuit
    for operation = operations
        operation = operation{:};
        label = lower(operation.label);
        if ismember(label, ...
                ['x', 'y', 'z', 'h', 's', 't', 'sdag', 'tdag', 'i'])
            circuit.(label)(operation.associatedQubit);
        elseif ismember(label, ...
                ['rx', 'ry', 'rz'])
            circuit.(label)(operation.associatedQubit, operation.unitaryOperation.getTheta());
        elseif ismember(label, ...
                ["cnot", "cy", "cz", "multiple control toffoli"])
            if isequal(label, "multiple control toffoli")
                label = "mct";
            end
            ctrls = operation.associatedQubit(1:length(operation.associatedQubit)-1);
            target = operation.associatedQubit(length(operation.associatedQubit));
            circuit.(label)(ctrls, target);
        elseif isequal(label, "toffoli")
            label = "ccnot";
            ctrls = operation.associatedQubit(1:length(operation.associatedQubit)-1);
            target = operation.associatedQubit(length(operation.associatedQubit));
            circuit.(label)(ctrls(1), ctrls(2), target);
        elseif ismember(label, ...
                ["controlled-u", ...
                    "controlled-controlled-y", ...
                    "controlled-controlled-z", ...
                    "controlled-controlled-u", ...
                    "multiple controlled-y", ...
                    "multiple controlled-z", ...
                    "multiple controlled-u"])
            U = operation.U;
            ctrls = operation.associatedQubit(1:length(operation.associatedQubit)-1);
            target = operation.associatedQubit(length(operation.associatedQubit));
            circuit.controlledU(U, ctrls, target);
        elseif isequal(label, "measurement")
            target = operation.associatedQubit;
            dest = operation.measurementOperation.getDestination();
            basis = operation.measurementOperation.getBasis();
            circuit.measure(target, dest, basis);
        else %if isequal(label, "u")
            U = operation.U;
            circuit.unitary(U, operation.associatedQubit);
        end
    end
    
end