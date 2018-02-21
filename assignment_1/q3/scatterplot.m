function scatterplot(filename)

data = importdata(filename, ' ');
cols = size(data);

class1 = [];
class2 = [];
class3 = [];

for idx = 1:cols(1)
    class = data(idx, 3);
    if class == 1
        class1 = cat(1,class1, data(idx,1:2));
    elseif class == 2
        class2 = cat(1,class2, data(idx,1:2)); 
    else
        class3 = cat(1,class3, data(idx,1:2));
    end
end

    function [mu Cov] = GetMeanAndVariance(class)
        d1 = class(:,1);
        d2 = class(:,2);
        pd1 = fitdist(d1, 'normal');
        pd2 = fitdist(d2, 'normal');
        mu = [mean(pd1)];
        Cov = cov(d1,d2);
    end

[mu1, Cov1] = GetMeanAndVariance(class1);
[mu2, Cov2] = GetMeanAndVariance(class2);
[mu3, Cov3] = GetMeanAndVariance(class3);


for i = 1:3
    if i == 1
        r = class1;
        sigma = Cov1;
    elseif i == 2
        r = class2;
        sigma = Cov2;
    else
        r = class3;
        sigma = Cov3;
    end
    
    
    plot(r(:,1), r(:,2), '+');
    hold on
    axis equal;
    xlim([-6 6])
    ylim([-10 14])
    
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
        hold on
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
        smallest_eigenval = max(eigenval(:,2));
        smallest_eigenvec = eigenvec(:,2);
    else
        smallest_eigenval = max(eigenval(:,1));
        smallest_eigenvec = eigenvec(1,:);
    end

    %% Plot the eigenvectors
    quiver(X0, Y0, largest_eigenvec(1)*sqrt(largest_eigenval), largest_eigenvec(2)*sqrt(largest_eigenval), '-m', 'LineWidth',2);
    quiver(X0, Y0, smallest_eigenvec(1)*sqrt(smallest_eigenval), smallest_eigenvec(2)*sqrt(smallest_eigenval), '-g', 'LineWidth',2);
end

line12 = [mean(class1);mean(class2)];
line13 = [mean(class1);mean(class3)];
line23 = [mean(class3);mean(class2)];

plot(line12(:,1), line12(:,2), 'LineWidth', 2, 'Color', 'g');
plot(line13(:,1),line13(:,2), 'LineWidth', 2, 'Color', 'g');
plot(line23(:,1), line23(:,2), 'LineWidth', 2, 'Color', 'g');

end