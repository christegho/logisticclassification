function [theta, logLik] = trainLogClass(X, y, numIter, alpha, lambda)
m = size(X, 1);
n = size(X, 2);

% Add ones to the X data matrix
X = [ones(m, 1) X];
% Set Initial theta
theta = zeros(n + 1, 1); 
logLik = zeros(numIter,1);
grad = zeros(size(theta));

for k = 1:numIter
  z = X*theta;  
  h=sigmoid(z);
  
  logLik(k)= computeLogLik(h, y, z);
  
  %compute gradient
  grad = (X'*(y-h))/m - lambda*theta/m;
  theta += alpha*grad;
  
end

