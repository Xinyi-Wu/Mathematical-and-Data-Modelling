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
err = zeros(n_iter, n_del);

% iterate experiment
for i=1:n_iter
    for j=1:(n_del+1)
        [a,b,err(i,j)] = mypca3(x, tau, Ab, Di, Indi, del_k(j));
    end
end

plot(del_k,mean(err),'b-','Linewidth',2);
xlabel('Number of Reduation on Rank: \Delta k'); ylabel('Error');
grid on
