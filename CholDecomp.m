function L = CholDecomp(Cov, sign2)
%sign2 is the noise variance e.g 0.01
%y is the vector of observed values pg 19 of Rasmussen's book
sM = size(Cov,1);
L = chol(Cov+diag(sign2*ones(sM,1)), 'lower');
end