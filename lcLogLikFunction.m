function [logLik, grad] = lcLogLikFunction(theta, X, y)
%LRCOSTFUNCTION Compute cost and gradient for logistic regression with 
%regularization
%   J = LRCOSTFUNCTION(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
logLik = 0;
grad = zeros(size(theta));



h=sigmoid(X*theta);
grad = (X'*(h-y))/m;
logLik = -sum(y.*log(h)+(ones(size(y))-y).*log(ones(size(y))-h))/m;

grad = grad(:);

end
