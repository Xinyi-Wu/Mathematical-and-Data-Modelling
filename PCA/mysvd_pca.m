function [err] = mysvd_pca(x, tau, Ab, Re, delta)
% MYSVD_PCA  Comparison the error between SVD and PCA in Black-Litterman
% Model
%
% Usage: [err] = mysvd_pca(x, tau, Ab, Re, delta)
%        PCA can be only used in the case of N>=K
%
% Inputs: x = experimental data
%         tau = parameter
%         Ab = number of absolute views
%         Re = number of relative views
%         del_k = number of reduation on sigular
%
% Output: err = 2-by-1 matrix for error in svd and pca seperately

% set initial invariables
N = size(x,2);          % number of asset
K = Ab + Re;            % number of views
index_K = randperm(K);  % get the randomly-selected indices
P = zeros(K,N);
for i=1:Ab
    index_N = randperm(N);
    P(index_K(i),index_N(1))=1;
end
for i=(Ab+1):K
    index_N = randperm(N);
    P(index_K(i),index_N(1))=0.5;
    P(index_K(i),index_N(2))=-0.5;
end
Q = 0.1*rand(K,1);      % control range in [0,0.1]
Pi = mean(x); Pi = Pi';
Sigma = cov(x);
Sigma_inv = inv(Sigma);
Omiga = diag(diag(P*(tau*Sigma)*P'));
Omiga_inv = diag(1./diag(Omiga));

% svd for left-matrix without error
[U,S,V] = svd(Sigma_inv/tau + P'*Omiga_inv*P);

% pca
coe = pca(P');
coe_inv = inv(coe);
P_pca = P'*coe;
for i=1:delta
    P_pca(:,end-delta+1) = 0;
end
Omiga_pca = coe_inv*Omiga_inv*coe_inv';
Q_pca = coe'*Q;
P_hat = P_pca*Omiga_pca*P_pca';
Q_hat = P_pca*Omiga_pca*Q_pca;

% svd for left-matrix without error
[U,S,V] = svd(Sigma_inv/tau + P'*Omiga_inv*P);
S_inv_app = diag(1./diag(S));
for i=1:delta
    S_inv_app(i,i) = 0;
end

% calculate ER (left matrix is reversible)
ER_svd = V*diag(1./diag(S))*U'*((Sigma_inv/tau)*Pi + P'*Omiga_inv*Q);
ER_pca = inv(Sigma_inv/tau + P_hat)*((Sigma_inv/tau)*Pi + Q_hat);
ER_theo = inv(Sigma_inv/tau + P'*Omiga_inv*P)*((Sigma_inv/tau)*Pi + P'*Omiga_inv*Q);
err = norm(ER_theo-ER_svd);
err(end+1,1) = norm(ER_pca-ER_theo);
end
