function contourProbReg(X, theta, y)

figure
gscatter(X(:,1),X(:,2),y);
hold on
xlabel('X1');
ylabel('X2');
xvector = linspace(-3,3,100);
[X1,X2] = meshgrid(xvector, xvector);
z = theta(1,:)+theta(2,:)*X1+theta(3,:)*X2;

z = sigmoid(z);


contour(X1, X2,z, 'ShowText','on');

