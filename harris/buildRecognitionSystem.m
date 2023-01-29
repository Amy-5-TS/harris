%           all_labels: [1×1491 double]
%       all_imagenames: {1×1491 cell}
%              mapping: {1×8 cell}
%         train_labels: [1×1331 double]
%     train_imagenames: {1×1331 cell}
%          test_labels: [1×160 double]
%      test_imagenames: {1×160 cell}


load('../data/traintest.mat');
random = load('dictionaryRandom.mat');
Harris = load('dictionaryHarris.mat');
T = size( train_imagenames, 2);

%1. dictionary: your visual word dictionary, a matrix of size K × 3n. % K is the # of clusters

%2. filterBank: filter bank used to produce the dictionary. This is a cell array of image filters.

%3. trainFeatures: T × K matrix containing all of the histograms of visual words of the T training images in the data set.

%4. trainLabels: T × 1 vector containing the labels of each training image.
trainLabels = train_labels;

%% random
% word map has been computed for each picture
trainFeatures = []; % [T x K] matrix
disp("random computing");
if isfile('../matlab/visionRandom.mat')~=1
    
    disp("random, no previous file detected");
for i = 1: T
	s = cell2mat( train_imagenames(1, i));
        path = {'../data/', s};
        I = imread(cell2mat(path));
        if ndims(I) ~= 3
            I = double(cat(3,I,I,I));
        end
	wordMap_temp = getVisualWords(I, random.filterBank, random.random_dictionary);
	K = size(random.random_dictionary,1);
	trainFeatures_temp = getImageFeatures(wordMap_temp, K);% K is the dictionary size
    trainFeatures = [trainFeatures; transpose(trainFeatures_temp) ];
    disp(i);
    if mod(i,20)==0
    dictionary = random.random_dictionary;
    filterBank = random.filterBank;
    save('visionRandom.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels', 'trainFeatures');
    end
end
else 
    disp("random, previous file exists");
    disp("reload from index: ");
    load ('../matlab/visionRandom.mat');
    index = size (trainFeatures, 1);
    disp(index);
    for i = index: T
	s = cell2mat( train_imagenames(1, i));
        path = {'../data/', s};
        I = imread(cell2mat(path));
        if ndims(I) ~= 3
            I = double(cat(3,I,I,I));
        end
	wordMap_temp = getVisualWords(I, random.filterBank, random.random_dictionary);
	K = size(random.random_dictionary,1);
	trainFeatures_temp = getImageFeatures(wordMap_temp, K);% K is the dictionary size
    trainFeatures = [trainFeatures; transpose(trainFeatures_temp) ];
    
    disp(i);
    if mod(i,20)==0
    dictionary = random.random_dictionary;
    filterBank = random.filterBank;
    save('visionRandom.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels', 'trainFeatures');
    end
    end
end
dictionary = random.random_dictionary;
trainLabels = transpose(trainLabels);
save('visionRandom.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels');





%% Harris
trainFeatures = [];
disp("Harris computing");
if isfile('../matlab/visionHarris.mat')~=1
    disp("harris, no previous file detected");
for i = 1:T
    s = cell2mat( train_imagenames(1, i));
        path = {'../data/', s};
        I = imread(cell2mat(path));
        if ndims(I) ~= 3
            I = double(cat(3,I,I,I));
        end
	wordMap_temp = getVisualWords(I, harris.filterBank, harris.harris_dictionary);
	K = size(harris.harris_dictionary,1);
	trainFeatures_temp = getImageFeatures(wordMap, K);% K is the dictionary size
    trainFeatures = [trainFeatures; transpose(trainFeatures_temp) ];
    disp(i);
    if mod(i,20)==0
        dictionary = harris.harris_dictionary;
    save('visionHarris.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels', 'trainFeatures');
    end
end
else 
    disp("harris, previous file exists");
    disp("reload from index: ");
    load ('../matlab/visionHarris.mat');
    index = size (trainFeatures, 1);
    disp(index);
    for i = index:T
    s = cell2mat( train_imagenames(1, i));
        path = {'../data/', s};
        I = imread(cell2mat(path));
        if ndims(I) ~= 3
            I = double(cat(3,I,I,I));
        end
	wordMap_temp = getVisualWords(I, harris.filterBank, harris.harris_dictionary);
	K = size(harris.harris_dictionary,1);
	trainFeatures_temp = getImageFeatures(wordMap, K);% K is the dictionary size
    trainFeatures = [trainFeatures; transpose(trainFeatures_temp) ];
    disp(i);
    if mod(i,20)==0
        dictionary = harris.harris_dictionary;
    save('visionHarris.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels', 'trainFeatures');
    end
end
end
dictionary = harris.harris_dictionary;
save('visionHarris.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels');