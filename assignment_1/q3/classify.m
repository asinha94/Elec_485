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
end
