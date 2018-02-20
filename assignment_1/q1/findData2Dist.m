function findData2Dist(filename)

data = dlmread(filename, ',');
yyaxis right;
histogram(data);
% It looks like an Exponential

[mu,~] = expfit(transpose(data));
x = 0:0.1:max(data);
y = exppdf(x,mu);

yyaxis left
plot(x,y, 'LineWidth', 5);
% The similarity is uncanny

% chi-squared goodness of fit test on exponential
pd = fitdist(transpose(data), 'exp');
[h,p] = chi2gof(data,'CDF',pd);
if h == 0
    fprintf("Null Hypothesis NOT rejected with p=%d", p);
else
    fprintf("Null Hypothesis rejected at default p=0.05\n");
end
    
