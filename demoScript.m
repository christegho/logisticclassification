function demoScript()
clear all;
close all;
clc;
warning('off');
load('classification.mat');

%plot X and classes
gscatter(X(:,1),X(:,2),y);

%Divide targets into 2 sets using random indices
testInd = randi(1000,200,1);
trainInd = 1:1000;
trainInd(testInd) = 0;
trainInd = trainInd(trainInd!=0);

testX = X(testInd,:);
trainX = X(trainInd,:);
testy = y(testInd,:);
trainy = y(trainInd,:);

[theta, logLik] = trainLogClass(trainX, trainy, 100, 2, 0);
theta
trainlogLik = logLik(100)
trainLik = exp(logLik(100))
figure
plot(logLik);
xlabel('iterations');
ylabel('log likelihood');

% Add ones to the X data matrix
testX = [ones(size(testX, 1), 1) testX];

testh=sigmoid(testX*theta);
contourProbReg(X, theta, y);

trueanswers = sum((testh>0.5)==testy)

%likelihood for test data
m = size(testX, 1)
testLogLik = sum(testy.*log(testh)+(ones(size(testy))-testy).*log(ones(size(testy))-testh))/m
testLik = exp(testLogLik)

%confusion matrix
printf('---confusion matrix - rates----\n');
printf('');
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
printf('');
tp = sum(indexTestPos)
fp = sum(indexTestNeg)
fn = lengthTestPos-tp
tn = lengthTestNeg-fp 


printf('-----------------\n');

%determine best learning rate
lr = 0.1:0.5:4;
logLik = zeros(30,lr);
for k = 1: length(lr)
[theta, logLik(:,k)] = trainLogClass(trainX, trainy, 30, k, 0);
end
figure
plot(logLik);
b = strread(num2str(lr),'%s');
legend(b);

%compute ROC curve
threshold = 0:0.05:1;

trueanswers = sum((testh>threshold)==testy)/length(testy);
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
plot(tp,fp);
xlabel('false positive rate');
ylabel('true positive rate');
title("ROC");
ROCArea = trapz(fp, tp)
%verification
%theta1 = trainLC(trainX,trainy,200);
%h=sigmoid(testX*theta1);
%trueanswersfminc = sum((h>0.5)==testy)


printf('\n--------------PART2-------------\n');
printf('-------------PART2-------------\n');
printf('-------------PART2-------------\n');
fprintf('');



% Add ones to the X data matrix

%X = [ones(m, 1) X];

%--------------PART2-------------
printf('\n RBF 1 Lambda: 1\n');
classifyRBF(testInd,trainInd,X,y,1,2500,.1,0)

printf('\n RBF .1 Lambda=0\n');
classifyRBF(testInd,trainInd,X,y,.1,2500,1.2,0)

printf('\n RBF .01 Lambda=0\n');
classifyRBF(testInd,trainInd,X,y,0.01,3000,4,0)

%--------------PART3-------------
printf('\n--------------PART3-------------\n');
printf('-------------PART3-------------\n');
printf('\n RBF 1 Lambda: 1\n');
classifyRBF(testInd,trainInd,X,y,1,3500,.1,.0005)

printf('\n RBF .1 Lambda: 1\n');
classifyRBF(testInd,trainInd,X,y,.1,3500,1.2,.0005)

printf('\n RBF .01 Lambda: 1\n');
classifyRBF(testInd,trainInd,X,y,0.01,3500,4,.0005)
end



