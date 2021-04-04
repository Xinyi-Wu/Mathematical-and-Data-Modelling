% Read data
x = readmatrix('D:\University of Bristol\Second Semester\Mathematical and Data Modeling\experiment\return.csv');
x = x(:,2:end);
tau = 1;

% iterate experiment
n = 30;
iter = 1:1:n;
err = zeros(2,n);
for i=1:n
    err(:,i) = mysvd_pca(x,tau,0);
end

plot(iter,err(1,:),'b-',iter,err(2,:),'k-','Linewidth',2);
%title('error')
xlabel('iteration'); ylabel('error');
legend('svd','pca')