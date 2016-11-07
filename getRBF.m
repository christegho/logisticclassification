function rbfX = getRBF(X_basis,X,l)
for m = 1:size(X_basis,1)
        sum = (X(:, 1) - X_basis(m, 1)).^2 + (X(:, 2) - X_basis(m, 2)).^2;
        rbfX(:,m) = exp(-(1/(2*l^2))*sum);
end 
