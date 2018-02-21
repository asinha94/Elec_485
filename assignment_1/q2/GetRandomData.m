function GetRandomData(n, mu1, mu2, sigma1, sigma2, ro)

mu = [mu1;mu2];
sigma = [sigma1^2, ro*sigma1*sigma2; ro*sigma1*sigma2, sigma2^2];

r = mvnrnd(mu, sigma, n);

plot(r(:,1), r(:,2), '+');
axis equal;
hold on

%% Plot Eliipses
avg = mean(r);
X0 = bsxfun(@minus,r,avg);

for stdev = 1:3                    
    conf = 2*normcdf(stdev)-1;     
    scale = chi2inv(conf,2);     

    Cov = cov(X0) * scale;
    [V,D] = eig(Cov);

    t = linspace(0,2*pi,100);
    e = [cos(t) ; sin(t)];        %# unit circle
    VV = V*sqrt(D);               %# scale eigenvectors
    e = bsxfun(@plus, VV*e, avg'); %#' project circle back to orig space

    %# plot cov and major/minor axes
    plot(e(1,:), e(2,:), 'Color','k');
end
    