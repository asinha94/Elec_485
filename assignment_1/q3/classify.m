function classify(filename) 

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
        mu = [mean(pd1), mean(pd1)];
        Cov = cov(d1,d2);
    end

[mu1, Cov1] = GetMeanAndVariance(class1);
[mu2, Cov2] = GetMeanAndVariance(class2);
[mu3, Cov3] = GetMeanAndVariance(class3);


    function class = findClass(x)
        d1 = mahal(x, class1);
        d2= mahal(x, class2);
        d3 = mahal(x, class3);
        min_mahal = min([d1,d2,d3]);
        class = find([d1, d2, d3] == min_mahal, 1);
    end
% Test Mahalnobis distance
x1 = [10,2];
fprintf("X1 is in Class %d\n", findClass(x1));
x2 = [-3,4];
fprintf("X1 is in Class %d\n", findClass(x2));
x3 = [2,2];
fprintf("X1 is in Class %d\n", findClass(x3));
x4 = [5,-7];
fprintf("X1 is in Class %d\n", findClass(x4));
end
