function GetRandomData(n, mu1, mu2, sigma1, sigma2, ro)

mu = [mu1;mu2];
sigma = [sigma1^2, ro*sigma1*sigma2; ro*sigma1*sigma2, sigma2^2];

r = mvnrnd(mu, sigma, n);

plot(r(:,1), r(:,2), '+');
axis equal;
hold on


%% Plot Eliipses
avg = mean(r);
X = bsxfun(@minus,r,avg);

for stdev = 1:3                    
    conf = 2*normcdf(stdev)-1;     
    scale = chi2inv(conf,2);     

    Cov = cov(X) * scale;
    [V,D] = eig(Cov);

    t = linspace(0,2*pi,100);
    e = [cos(t) ; sin(t)];        %# unit circle
    VV = V*sqrt(D);               %# scale eigenvectors
    e = bsxfun(@plus, VV*e, avg'); %#' project circle back to orig space

    %# plot cov and major/minor axes
    plot(e(1,:), e(2,:), 'Color','k');
end
X0 = avg(1);
Y0 = avg(2);

[eigenvec, eigenval ] = eig(sigma);

% Get the index of the largest eigenvector
[largest_eigenvec_ind_c, r] = find(eigenval == max(max(eigenval)));
largest_eigenvec = eigenvec(:, largest_eigenvec_ind_c);

% Get the largest eigenvalue
largest_eigenval = max(max(eigenval));

% Get the smallest eigenvector and eigenvalue
if(largest_eigenvec_ind_c == 1)
    smallest_eigenval = max(eigenval(:,2))
    smallest_eigenvec = eigenvec(:,2);
else
    smallest_eigenval = max(eigenval(:,1));
    smallest_eigenvec = eigenvec(1,:);
end

%% Plot the eigenvectors
quiver(X0, Y0, largest_eigenvec(1)*sqrt(largest_eigenval), largest_eigenvec(2)*sqrt(largest_eigenval), '-m', 'LineWidth',2);
quiver(X0, Y0, smallest_eigenvec(1)*sqrt(smallest_eigenval), smallest_eigenvec(2)*sqrt(smallest_eigenval), '-g', 'LineWidth',2);

    