function density = getDensity(self)
    import ExeQu.CircuitComposer.*
    density = self.state * self.state';
end