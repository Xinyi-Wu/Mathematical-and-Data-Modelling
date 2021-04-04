% Read data
x = readmatrix('D:\University of Bristol\Second Semester\Mathematical and Data Modeling\experiment\return.csv');
x = x(:,2:end);

% Set initial variables
tau = 0.1;
Ab = 20;
Di = 20;
del_k = 2;
n_iter = 60;
n_Indi = 40;
Indi = 1:1:n_Indi;

% iterate experiment
ER_svd = [];
mean_ER = [];
err = [];
mean_err = [];
for j = 1:n_Indi
    for i = 1:n_iter
        [ER_svd(:,i), err(:,i), err_all] = mysvd3(x, tau, Ab, Di, Indi(j), del_k);
    end
    mean_ER(:,j) = mean(ER_svd');
    mean_err(:,j) = mean(err');
end
for i = 1:size(x,2)
    plot(Indi,mean_ER(i,:),'Linewidth',2);
    hold on;
end
xlabel('Number of Indirect Relative Views'); ylabel('Expected Return');
legend('Asset 1','Asset 2','Asset 3','Asset 4','Asset 5','Asset 6','Asset 7');

hold off
for i = 1:size(x,2)
    plot(Indi,mean_err(i,:),'Linewidth',2);
    hold on;
end
xlabel('Number of Indirect Relative Views'); ylabel('Error');
legend('Asset 1','Asset 2','Asset 3','Asset 4','Asset 5','Asset 6','Asset 7');