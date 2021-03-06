function logLik = computeLogLik(h, y, z)
m = size(y, 1);
  %compute log likelihood
  u = p = log(h);
  v = q = log(ones(size(y))-h);
  
u(p==-inf) = 0;
u+=z.*(p==inf);

v(q==-inf) = 0;
v+=-z.*(q==-inf);
  
logLik = sum(y.*u+(ones(size(y))-y).*v)/m;
