% Read data
x = readmatrix('D:\University of Bristol\Second Semester\Mathematical and Data Modeling\experiment\return.csv');
x = x(:,2:end);

% Set initial variables
tau = 0.1;
Ab = 2;
Di = 2;
Indi = 2;
del_r = 5;  
r = 0:1:del_r;
n_iter = 60;
err = zeros(n_iter, del_r);

% iterate experiment
for i=1:n_iter
    for j=1:(del_r+1)
        [ER_svd, err,err(i,j)] = mypca3(x, tau, Ab, Di, Indi, r(j));
    end
end

plot(r,mean(err),'b-','Linewidth',2);
xlabel('Number of Reduation on Rank r'); ylabel('Error');
grid on