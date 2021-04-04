% Read data
x = readmatrix('D:\University of Bristol\Second Semester\Mathematical and Data Modeling\experiment\return.csv');
x = x(:,2:end);

% Set initial variables
tau = 0.1;
Ab = 2;
Di = 2;
Indi = 2;
n_del = size(x,2)-2;  
del_k = 0:1:n_del;
n_iter = 60;

% iterate experiment

ER = [];
mean_ER = [];
err =[];
mean_err = [];
for j = 1:length(del_k)
    for i = 1:n_iter
        [ER(:,i), err(:,i), err_all] = mypca3(x, tau, Ab, Di, Indi, del_k(j));
    end
    mean_ER(:,j) = mean(ER');
    mean_err(:,j) = mean(err');
end
for i = 1:size(x,2)
    plot(del_k,mean_ER(i,:),'Linewidth',2);
    hold on;
end
legend('Asset 1','Asset 2','Asset 3','Asset 4','Asset 5','Asset 6','Asset 7');
xlabel('Number of Reduation on Rank'); ylabel('Expected Return');

hold off
for i = 1:size(x,2)
    plot(del_k,mean_err(i,:),'Linewidth',2);
    hold on;
end
legend('Asset 1','Asset 2','Asset 3','Asset 4','Asset 5','Asset 6','Asset 7');
xlabel('Number of Reduation on Rank'); ylabel('Error');
