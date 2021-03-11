from scipy.special import factorial as gamma
from scipy.special import yn as bessel_2
import numpy as np


class KDistribution:
    def __init__(self, mu, alpha, beta):
        self.mu = mu
        self.alpha = alpha
        self.beta = beta
        self.pdf = self.pdf_factory()

    def pdf_factory(self):
        sum_alpha_beta = self.alpha + self.beta
        product = self.alpha * self.beta
        difference = self.alpha - self.beta
        const = 2 / (gamma(self.alpha) * gamma(self.beta)) * ((product / self.mu) ** (sum_alpha_beta / 2))

        def pdf(x):
            return const * x ** (sum_alpha_beta / 2 - 1) * bessel_2(difference, s * np.sqrt(product * x / self.mu))

        return pdf
