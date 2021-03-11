import scipy.special


class FDistribution:
    def __init__(self, nu_1, nu_2):
        self.nu_1 = nu_1
        self.nu_2 = nu_2

    def pdf_factory(self):
        numerator = ((self.nu_1 / self.nu_2) ** (self.nu_1 / 2)) * scipy.special.factorial(
            (self.nu_1 + self.nu_2) / 2)
        denominator = scipy.special.factorial(self.nu_1 / 2) * scipy.special.factorial(self.nu_2 / 2)
        const = numerator / denominator

        def pdf(x):
            return (const * (x ** (self.nu_1 / 2 - 1))) / \
                   ((1 + x * self.nu_1 / self.nu_2) ** ((self.nu_1 + self.nu_2) / 2))

        return pdf
