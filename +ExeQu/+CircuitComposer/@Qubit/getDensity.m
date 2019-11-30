function dense = getDensity(self)
    persistent bra

    bra = self.getBra();
    dense = self.state * bra;
end