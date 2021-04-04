% Read data
x = readmatrix('D:\University of Bristol\Second Semester\Mathematical and Data Modeling\experiment\return.csv');
x = x(:,2:end);
tau = 1;

% iterate experiment
Ab = 3;
Re = 3;
delta = 0;
n = 30;
iter = 1:1:n;
err = [];
for i=1:n
    err(:,i) = mysvd_pca(x, tau, Ab, Re, delta);
end

plot(iter,err(1,:),'b-',iter,err(2,:),'k-','Linewidth',2);
%title('error')
xlabel('iteration'); ylabel('error');
legend('svd','pca')
