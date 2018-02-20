function x = GetRandomData(n, mu1, mu2, sigma1, sigma2 )

mu = [mu1;mu2];
sigma = [sigma1^2, sigma1*sigma2; sigma1*sigma2, sigma2^2];

r = mvnrnd(mu, sigma, n);
plot(r(:,1), r(:,2), '+');
