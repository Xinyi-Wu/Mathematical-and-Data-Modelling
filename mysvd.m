function [ER_svd, err, err_all] = mysvd(x, tau, Ab, Re, del_k)
% MYSVD  Apply SVD to the left matrix in Black-Litterman formula for
% approximating expected returns and output its error
%
% Usage: [ER_svd, err, err_all] = mysvd(x, tau, Ab, Re, del_k)
%
% Inputs: x = experimental data
%         tau = parameter
%         Ab = number of absolute views
%         Re = number of relative views
%         del_k = number of reduation on sigular
%
% Output: ER_svd = expected return approximated by SVD
%         err = error from SVD approximation for each asset
%         err_all = error computed by Euclidean norm of 'err'

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
    P(index_K(i),index_N(1)) = 1;
    P(index_K(i),index_N(2)) = -1;
end
Q = 0.1*rand(K,1);      % control range in [0,0.1]
Pi = mean(x); Pi = Pi';
Sigma = cov(x);
Sigma_inv = inv(Sigma);
Omiga = diag(diag(P*(tau*Sigma)*P'));
Omiga_inv = diag(1./diag(Omiga));

% svd for left-matrix without error
[U,S,V] = svd(Sigma_inv/tau + P'*Omiga_inv*P);
S_inv_app = diag(1./diag(S));
for i=1:del_k
    S_inv_app(i,i) = 0;
end

% calculate approximated expected returns (left matrix is reversible)
ER_svd = V*S_inv_app*U'*((Sigma_inv/tau)*Pi + P'*Omiga_inv*Q);
ER_theo = inv(Sigma_inv/tau + P'*Omiga_inv*P)*...
    ((Sigma_inv/tau)*Pi + P'*Omiga_inv*Q);
err = abs(ER_theo-ER_svd);
err_all = norm(err);

end

