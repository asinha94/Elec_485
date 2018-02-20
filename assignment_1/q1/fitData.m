function fitData(filename)

data = dlmread(filename, ',');
% Make historgam
yyaxis left;
histogram(data)

% Fit data to guassian and plot with y-axis on right
data_t = transpose(data);
pd = fitdist(data_t, 'normal');
x = 0:0.1:max(data);
y = pdf(pd, x);
yyaxis right
plot(x,y, 'LineWidth', 2);