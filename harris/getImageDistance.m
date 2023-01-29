function [dist] = getImageDistance(hist1, histSet, method)
% list of vectors with pdis2
% 'euclidean' or 'chi2'
%feature matrix passed in will be size = [n K]
% feature vector is stored as 1 x K
%https://octave.sourceforge.io/statistics/function/pdist2.html
%https://www.google.com/search?client=safari&rls=en&q=chi+method+compute+distance&ie=UTF-8&oe=UTF-8


if strcmp(method, 'chi2')
	pdist2 (hist1, histSet, 'chisq'); % return an [1 n] matrix
elseif strcmp(method, 'euclidean')
	pdist2 (hist1, histSet); % default
end 
  

end