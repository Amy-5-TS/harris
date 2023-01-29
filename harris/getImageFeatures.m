function [ h ] = getImageFeatures(wordMap, dictionarySize)


% wordMap, H x W is size, each integer is a cluster center
%h(i) should be equal to the number of times visual word i occurred in the word map
%getImageFeatures return a histogram on wordMap of size K = dictionarySize

wordMap = reshape (wordMap,[], 1);
% tabulate only range to the biggest in wordMap
h = tabulate(wordMap);
h = h(:, 3);
if size(wordMap,1) < dictionarySize
    h = [h; zeros(dictionarySize-size(wordMap,1),1)];
end

% in percentage

end