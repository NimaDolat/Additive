function K = CovFunc(A, B, scale, bw)
D = pdist2(A,B).^2;
if any(any(D<0))
    D(D<0) = 0;
end
K = scale * exp(-0.5*D/bw^2);
end