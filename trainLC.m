function [theta] = trainLC(X, y, maxIter)
%ONEVSALL trains multiple logistic regression classifiers and returns all
%the classifiers in a matrix all_theta, where the i-th row of all_theta 
%corresponds to the classifier for label i
%   [all_theta] = ONEVSALL(X, y, num_labels, lambda) trains num_labels
%   logisitc regression classifiers and returns each of these classifiers
%   in a matrix all_theta, where the i-th row of all_theta corresponds 
%   to the classifier for label i

% Some useful variables
m = size(X, 1);
n = size(X, 2);

% Add ones to the X data matrix
X = [ones(m, 1) X];
% Set Initial theta
initial_theta = zeros(n + 1, 1); 
    
% Set options for fminunc
options = optimset('GradObj', 'on', 'MaxIter', maxIter);
 
% Run fmincg to obtain the optimal theta
% This function will return theta and the cost 
[theta] = ...
 fmincg (@(t)(lcLogLikFunction(t, X, y)), ...
              initial_theta, options);







% =========================================================================


end
