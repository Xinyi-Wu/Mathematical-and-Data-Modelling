% Read data
x = readmatrix('D:\University of Bristol\Second Semester\Mathematical and Data Modeling\experiment\return.csv');
x = x(:,2:end);

% Set initial variables
tau = 0.1;
Ab = 20;
del_k = 0:1:5;
n_iter = 60;
n_Di = 40;
Di = 1:1:n_Di;
Indi = 20;
err_all = [];

% iterate experiment
for t=1:length(del_k)
    for i=1:n_iter
        for j=1:n_Ab
            [ER_svd, err, err_all] = mysvd3(x, tau, Ab, Di(j), Indi, del_k(t));
        end
    end
plot(Di,mean(err_all),'Linewidth',2);
hold on;
end
xlabel('Number of Relative Views'); ylabel('Error');
legend('\Delta k=0','\Delta k=1','\Delta k=2','\Delta k=3','\Delta k=4','\Delta k=5');
