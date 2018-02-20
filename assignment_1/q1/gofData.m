function gofData(filename)

data = dlmread(filename, ',');
[h,p] = chi2gof(data); % defaults to 5% signification

if h == 0
    fprintf("Null Hypothesis NOT rejected with p-value: %d\n", p);
else
    fprintf("Null Hypothesis rejected with p-value: %d\n", p);
end