function [expected, variance] = gp_Pred(X, l2, sigf2, test, alpha, L)
    k1 = getCov(test', X, l2, sigf2);
    expected = k1*alpha;
    v = L\k1';
    k2 = getCov(test', test', l2, sigf2);
    variance = k2 - v'*v;
end