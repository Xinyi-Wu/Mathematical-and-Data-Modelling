% Read data
x = readmatrix('D:\University of Bristol\Second Semester\Mathematical and Data Modeling\experiment\return.csv');
% x = x(:,2:end);

% Set initial variables
tau = 0.1;
Di = 1;
Indi = 1;
del_k = 2;           % note that del_k cannot greater than number of asset
n_iter = 60;
n_Ab = 4;
Ab = 0:1:n_Ab;

% iterate experiment
ER_svd = [];
mean_ER = [];
for j = 1:length(Ab)
    for i = 1:n_iter
        [ ER_svd(:,i),err, err_all] = mypca3(x, tau,Ab(j), Di, Indi, del_k);
    end
    mean_ER(:,j) = mean(ER_svd');
end
for i = 1:size(x,2)
    plot(Ab,mean_ER(i,:),'Linewidth',2);
    hold on;
end
xlabel('Number of Absolute Views'); ylabel('Expected Return');
legend('Asset 1','Asset 2','Asset 3','Asset 4','Asset 5','Asset 6','Asset 7');