% Read data
x = readmatrix('D:\University of Bristol\Second Semester\Mathematical and Data Modeling\experiment\return.csv');
x = x(:,2:end);

% Set initial variables
tau = 0.1;
Di = 20;
Indi = 20;
del_k = 2;
n_iter = 60;
n_Ab = 40;
Ab = 1:1:n_Ab;

% iterate experiment
err = [];
mean_err = [];
for j = 1:n_Ab
    for i = 1:n_iter
        [ER_svd, err(:,i), err_all] = mysvd3(x, tau, Ab(j), Di, Indi, del_k);
    end
    mean_err(:,j) = mean(err');
end
for i = 1:size(x,2)
    plot(Ab,mean_err(i,:),'Linewidth',2);
    hold on;
end
xlabel('Number of Absolute Views'); ylabel('Error');
legend('Asset 1','Asset 2','Asset 3','Asset 4','Asset 5','Asset 6','Asset 7');