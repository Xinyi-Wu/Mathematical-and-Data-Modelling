function [ER_pca, err, err_all] = mypca3(x,tau, Ab, Di, Indi, r)
% MYPCA3  Apply PCA to matrix P in Black-Litterman formula for
% approximating expected returns and output its error considering three
% types of views including indirect relative view
%
% Usage: [err] = mypca3(x,tau, Ab, Di, Indi, r)
%        PCA can be only used in the case of N>=K
%
% Inputs: x = experimental data
%         tau = parameter
%         Ab = number of absolute views
%         Di = number of direct relative views
%         Indi = number of indirect relative vies
%         r = number of reduation on principal components
%
% Output: ER_pca = expected return approximated by PCA
%         err = error from SVD approximation for each asset
%         err_all = error computed by Euclidean norm of 'err'

% set initial invariables
N = size(x,2);          % number of asset
K = Ab + Di + Indi;
index_K = randperm(K);  % get the randomly-selected indices
P = zeros(K,N);
for i=1:Ab
    index_N = randperm(N);
    P(index_K(i),index_N(1))=1;
end
for i=(Ab+1):K
    index_N = randperm(N);
    P(index_K(i),index_N(1)) = 1;
    P(index_K(i),index_N(2)) = -1;
end
for i = (Ab + Di + 1):K
    index_N = randperm(N);
    P(index_K(i),index_N(1)) = -1;
    P(index_K(i),index_N(2)) = 0.5;
    P(index_K(i),index_N(3)) = 0.5;
end
Q = 0.1*rand(K,1);      % control range in [0,0.1]
Pi = mean(x); Pi = Pi';
Sigma = cov(x);
Sigma_inv = inv(Sigma);
Omiga = diag(diag(P*(tau*Sigma)*P'));
Omiga_inv = diag(1./diag(Omiga));

% pca
coe = pca(P');
coe_inv = inv(coe);
P_pca = P'*coe;
for i=1:r
    P_pca(:,end-r+1) = 0;
end
Omiga_pca = coe_inv*Omiga_inv*coe_inv';
Q_pca = coe'*Q;
P_hat = P_pca*Omiga_pca*P_pca';
Q_hat = P_pca*Omiga_pca*Q_pca;

% calculate ER (left matrix is reversible)
ER_pca = inv(Sigma_inv/tau + P_hat)*((Sigma_inv/tau)*Pi + Q_hat);
ER_theo = inv(Sigma_inv/tau + P'*Omiga_inv*P)*((Sigma_inv/tau)*Pi + P'*Omiga_inv*Q);
err = abs(ER_pca-ER_theo);
err_all = norm(err);

end