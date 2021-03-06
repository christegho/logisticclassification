function contourProb(X, theta, y, trainXOriginal, rbf)

figure
gscatter(X(:,1),X(:,2),y);
hold on
xlabel('X1');
ylabel('X2');

X1 = -3:1:3;
X2 = -3:1:3;

[Z1, Z2] = meshgrid(X1,X2);

for k = 1:size(X1,2)
        for l = 1:size(X2,2)
            xvec = getRBF(trainXOriginal,[X1(k) X2(l) 1],rbf);
	    xvec = [ones(size(xvec,1), 1) xvec];
            Z(l,k) =  sigmoid(xvec*theta);
        end
end
contour(Z1,Z2,Z, 'ShowText','on');


