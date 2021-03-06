function classifyRBF(testInd,trainInd, X, y, rbf, iter, lr, lambda)
printf('\n--------------rbf-------------\n');
rbf
testX = X(testInd,:);
trainXOriginal = X(trainInd,:);
testy = y(testInd,:);
trainy = y(trainInd,:);

testX = getRBF(trainXOriginal,testX,rbf);
trainX = getRBF(trainXOriginal, trainXOriginal, rbf);

m = size(X, 1);
testX = [ones(size(testX,1), 1) testX];

originalX = X;


%verification
%theta = trainLC(trainX,trainy,iter);
%h=sigmoid(testX*theta);
%trueanswersfminc = sum((h>0.5)==testy)

%with own class

[theta, logLik] = trainLogClass(trainX, trainy, iter, lr, lambda);
trainlogLik = logLik(iter)
trainLik = exp(logLik(iter))

figure
plot(logLik);
xlabel('iterations');
ylabel('likelihood');

contourProb(originalX, theta, y, trainXOriginal, rbf);

testz= testX*theta;
testh=sigmoid(testz);

%likelihood for test data
m = size(testX, 1)
testLogLik = computeLogLik(testh, testy, testz)
testLik = exp(testLogLik)

trueanswers = sum((testh>0.5)==testy)


%confusion matrix
printf('---confusion matrix - rates----\n');
printf('\n');
predictions = testh>0.5;
indexTestPos = predictions(find(testy));
indexTestNeg = predictions(find(~testy));
lengthTestPos = length(find(testy));
lengthTestNeg = length(find(~testy));
tp = sum(indexTestPos)/lengthTestPos
fp = sum(indexTestNeg)/lengthTestNeg
fn = 1-tp
tn = 1-fp 

printf('---confusion matrix----\n');
printf('\n');
tp = sum(indexTestPos)
fp = sum(indexTestNeg)
fn = lengthTestPos-tp
tn = lengthTestNeg-fp 


printf('-----------------\n');

%compute ROC curve
threshold = 0:0.05:1;

trueanswers = sum((testh>threshold)==testy);
%figure 
%plot(threshold,trueanswers);
%xlabel('threshold');
%ylabel('%rate of sum of true positives and true negatives');

tp = zeros(size(threshold));
fp = zeros(size(threshold));

predictions = testh>threshold;

for k = 1:length(threshold)
  indexTestPos = predictions(:,k)(find(testy));
  indexTestNeg = predictions(:,k)(find(~testy));
  tp(k) = sum(indexTestPos)/length(find(testy));
  fp(k) = sum(indexTestNeg)/length(find(~testy));

end
figure
plot(fp,tp);
xlabel('false positive rate');
ylabel('true positive rate');
ROCArea = trapz(fp, tp)

end
