% Read data
x = readmatrix('D:\University of Bristol\Second Semester\Mathematical and Data Modeling\experiment\return.csv');
x = x(:,2:end);

% Set initial variables
tau = 0.1;
Ab = 20;
del_k = 2;
n_iter = 60;
n_Di = 40;
Di = 1:1:n_Di;
Indi = 20;

% iterate experiment
ER_svd = [];
mean_ER = [];
for j = 1:n_Di
    for i = 1:n_iter
        [ER_svd(:,i), err, err_all] = mysvd3(x, tau, Ab, Di(j), Indi, del_k);
    end
    mean_ER(:,j) = mean(ER_svd');
end
for i = 1:size(x,2)
    plot(Di,mean_ER(i,:),'Linewidth',2);
    hold on;
end
xlabel('Number of Direct Relative Views'); ylabel('Error');
legend('Asset 1','Asset 2','Asset 3','Asset 4','Asset 5','Asset 6','Asset 7');
