function [wordMap] = getVisualWords(I, filterbank, dictionary)
% for a singe image
% getVisualWords map each pixel in image I to its closest word in dictionary.
% in eacch dictionary, each clustering center will become a visual work, the whole set is the dictionary of visual words

[H, W, ~] = size(I);
if ndims(I) ~= 3
	I = double(cat(3,I,I,I));
end

filterResponses = extractFilterResponses(I, filterbank); % the filter response for each pixel
filterResponses = reshape(filterResponses ,H*W,[]);

%% 
%https://octave.sourceforge.io/statistics/function/pdist2.html
% in wordmap, (H x W) -> each integer corresponds to a cluster center in dictionary 
%the dictionary has K words, each word has #=3n features
if size (dictionary, 1) ==1
    dictionary = struct2array(dictionary);
end
	dist = pdist2(filterResponses, dictionary,'euclidean'); % H*W x cluster #
	[~,col_vector] = min(dist, [], 2);
	wordMap = reshape(col_vector, H, W);


end