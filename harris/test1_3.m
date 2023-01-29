%           all_labels: [1×1491 double]
%       all_imagenames: {1×1491 cell}
%              mapping: {1×8 cell}
%         train_labels: [1×1331 double]
%     train_imagenames: {1×1331 cell}
%          test_labels: [1×160 double]
%      test_imagenames: {1×160 cell}

load('../data/traintest.mat ');
% get alpha points for each image
alpha = 50;
K = 100; % K means function
filterBank = createFilterBank();
% %% test case, try to save only one pcicture's mat 
% method1 = 'harris';
% % calling it, modify further
% [harris_dictionary] = getDictionary(all_imagenames, alpha, K, method1);%save it to .mat
% save('dictionaryHarris_test2_T50.mat','harris_dictionary','filterBank');
% 
%  method2 = 'random';
% [random_dictionary] = getDictionary(all_imagenames, alpha, K, method2);
% save('dictionaryRandom_test2_T50.mat','random_dictionary','filterBank');

%% save the random dictionary
method2 = 'random';
disp(size(train_imagenames));
[random_dictionary] = getDictionary(train_imagenames, alpha, K, method2);
save('dictionaryRandom.mat','random_dictionary','filterBank');

%% save the harris_dictionary
method1 = 'harris';
[harris_dictionary] = getDictionary(train_imagenames, alpha, K, method1);%save it to .mat
save('dictionaryHarris.mat','harris_dictionary','filterBank');

