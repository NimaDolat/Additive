function ei = MEI(test,X,l2,sigf2,alpha,L,opt)
[mean_y, var_y] = gp_Pred(X, l2, sigf2, test, alpha, L);
if var_y == 0
    ei = 0;
else
    u = (mean_y - opt - 0.01*var_y)/sqrt(var_y);
    ei = sqrt(var_y)*(u*normcdf(u)+normpdf(u));
end
ei=-ei;%since DIRECT gets the min
end