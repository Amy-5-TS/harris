% call batchToVisualWords
%batchToVisualWords(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%hello! I modified batchToVisualWords script because of the naming
%difference of my dictionary
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load filterbank and dictionary
load('../matlab/dictionaryHarris.mat', 'filterBank');
random = load('../matlab/dictionaryRandom.mat', 'random_dictionary');
harris = load('../matlab/dictionaryHarris.mat', 'harris_dictionary');



%% Load image 1
img1 = imread('../data/airport/sun_aewkrrhvwhkvbcix.jpg'); 

% Get Visual Words
wordMap1_random = getVisualWords(img1, filterBank, random);
wordMap1_Harris = getVisualWords(img1, filterBank, harris);



%% Load image 2
img2 = imread('../data/landscape/sun_aewjouuoxozhzmsx.jpg');

% Get Visual Words
wordMap2_random = getVisualWords(img2, filterBank, random);
wordMap2_Harris = getVisualWords(img2, filterBank, harris);



%% Load image 3
img3 = imread('../data/rainforest/sun_agcfctbkefnoasmy.jpg');

% Get Visual Words
wordMap3_random = getVisualWords(img3, filterBank, random);
wordMap3_Harris = getVisualWords(img3, filterBank, harris);


%%disp images
figure
imshow(label2rgb(wordMap1_random ));
title( 'figure1_random' );hold;

figure
imshow(label2rgb(wordMap1_Harris ));
title( 'figure1_harris' );hold;

figure
imshow(label2rgb(wordMap2_random ));
title( 'figure2_random' );hold;

figure
imshow(label2rgb(wordMap2_Harris ));
title( 'figure2_harris' );hold;

figure
imshow(label2rgb(wordMap3_random ));
title( 'figure3_random' );hold;

figure
imshow(label2rgb(wordMap3_Harris ));
title( 'figure3_harris' );hold;