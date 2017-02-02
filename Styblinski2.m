function sty = Styblinski2( query )
query = 10*(query-0.5);
sty = (sum(query.^4)-16*sum(query.^2)+5*sum(query))/2; %max is -234.9966
sty = sty/60;
end