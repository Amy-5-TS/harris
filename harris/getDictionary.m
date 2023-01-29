function [dictionary] = getDictionary(imgPaths, alpha, K, method)
T = size(imgPaths, 2);
%T = 1; % test case 1
%T = 50; % test case 2
filterBank = createFilterBank();
n = size(filterBank, 1);
k = 0.05;


%% 
pixelResponses = zeros(alpha*T, 3*n); % [50 * T, 3n]
    % % test case for image index 34 -> wrong case
    %  s = cell2mat(imgPaths(1, 34));
    %     path = {'../data/', s};
    %     disp('check from 34 onwards');
    %     disp(cell2mat(path));
    %     I = imread(cell2mat(path));
    %     disp(size(I));
    %      filterResponses = extractFilterResponses(I, filterBank); % [H × W × 3n]
    
    %% Harris, file already there
    if strcmp(method, 'harris') == 1
        if isfile('../matlab/dictionaryHarris.mat')
             % File exists.
             %%update the pixel responses with the now_responses
             load ('../matlab/dictionaryHarris.mat','now_Responses');
             pixelResponses(1:size(now_Responses,1), :)  = now_Responses;
             index = size(now_Responses)/alpha;

             %% go throuhg the remaining pictures
            for i = index: T
                %For each and every training image, load it and apply the filter bank to it.
                s = cell2mat(imgPaths(1, i));
                path = {'../data/', s};
                %disp({path});
                I = imread(cell2mat(path));
                if ndims(I) ~= 3
                    I = double(cat(3,I,I,I));
                end

                %apply filters on
                filterResponses = extractFilterResponses(I, filterBank); % [H × W × 3n]

                % in total 3n pictures, each picture of size H x W
                % giving the selected points
                points = zeros(alpha, 2); % points size: [alpha x 2]
                 points = getHarrisPoints(I, alpha, k); 
                % verified to be legit

                %remember to check if all != 0
                % get the filter responses for the index stored in [points]
                % should be in a matrix [3n 1]
                % first 2 dimensions corrresponds to the index of target pixel
                pts = zeros(alpha, 3*n);% selcted points for this picture
                % 需要找到每个像素在不同滤镜下的值， 总共alpha*T（T张图片）个像素
                %每个图象共alpha个像素， 对应alpha*3n, 3n because n filter, and each picture has 3
                %dimensions

                for j = 1:alpha %every pixel's corresponds value (in total 60 (60 filters))
                    pts(j, :) = filterResponses(points(j, 1), points(j, 2), :);
                end
                % each row corresponds to a single pixel's respons under different filters
                pixelResponses((1+(i-1)*alpha):(alpha+(i-1)*alpha), :) = pts(:, :);
                now_Responses = pixelResponses(1:(alpha+(i-1)*alpha), :);

                %% every 10 pictures, save
                if mod(i,10) == 0 % update the dictionary every 100 data sets, in case the program fails, also sav ethe fiter responses
                    disp("harris, revious file loaded, update every 10, now: ");
                    disp(i);
                    disp(" and the expected row # of now_Responses i :");
                    disp((alpha+(i-1)*alpha));
                    [ ~ , dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');
                    save('dictionaryHarris.mat','dictionary','filterBank','now_Responses','pixelResponses');

                end
                disp(i);
            end

         %%    Harris. no previous files
        else % the file does not exists
            disp("no previous file detected");
            for i = 1: T
                %For each and every training image, load it and apply the filter bank to it.
                s = cell2mat(imgPaths(1, i));
                path = {'../data/', s};
                %disp({path});
                I = imread(cell2mat(path));
                if ndims(I) ~= 3
                    I = double(cat(3,I,I,I));
                end

                %apply filters on
                filterResponses = extractFilterResponses(I, filterBank); % [H × W × 3n]

                % in total 3n pictures, each picture of size H x W
                % giving the selected points
                points = zeros(alpha, 2); % points size: [alpha x 2]
                points = getHarrisPoints(I, alpha, k); 
                % verified to be legit

                %remember to check if all != 0
                % get the filter responses for the index stored in [points]
                % should be in a matrix [3n 1]
                % first 2 dimensions corrresponds to the index of target pixel
                pts = zeros(alpha, 3*n);% selcted points for this picture
                % 需要找到每个像素在不同滤镜下的值， 总共alpha*T（T张图片）个像素
                %每个图象共alpha个像素， 对应alpha*3n, 3n because n filter, and each picture has 3
                %dimensions
                for j = 1:alpha %every pixel's corresponds value (in total 60 (60 filters))
                    pts(j, :) = filterResponses(points(j, 1), points(j, 2), :);
                end

                % each row corresponds to a single pixel's respons under different filters
                pixelResponses((1+(i-1)*alpha):(alpha+(i-1)*alpha), :) = pts(:, :);
                now_Responses = pixelResponses(1:(alpha+(i-1)*alpha), :);
                 if mod(i,10) ==0
                    disp("harris, no previoous files detected, update every 10, now: ");
                    disp(i);
                    disp(" and the expected row # of now_Responses i :");
                    disp((alpha+(i-1)*alpha));
                    [ ~ , dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');
                    save('dictionaryHarris.mat','dictionary','filterBank','now_Responses','pixelResponses');
                end
                disp(i);
            end
        end
    %% random 
        elseif strcmp(method, 'random') == 1
        if isfile('../matlab/dictionaryRandom.mat')
             % File exists.
             %%update the pixel responses with the now_responses
             load ('../matlab/dictionaryRandom.mat','now_Responses');
             pixelResponses(1:size(now_Responses,1), :)  = now_Responses;
             index = size(now_Responses)/alpha;

             %% go throuhg the remaining pictures
            for i = index: T
            %For each and every training image, load it and apply the filter bank to it.
            s = cell2mat(imgPaths(1, i));
            path = {'../data/', s};
            %disp({path});
            I = imread(cell2mat(path));
            if ndims(I) ~= 3
                I = double(cat(3,I,I,I));
            end

            %apply filters on
            filterResponses = extractFilterResponses(I, filterBank); % [H × W × 3n]

            % in total 3n pictures, each picture of size H x W
            % giving the selected points
            points = zeros(alpha, 2); % points size: [alpha x 2]
            points = getRandomPoints(I, alpha);

            % verified to be legit

            %remember to check if all != 0
            % get the filter responses for the index stored in [points]
            % should be in a matrix [3n 1]
            % first 2 dimensions corrresponds to the index of target pixel
            pts = zeros(alpha, 3*n);% selcted points for this picture
            % 需要找到每个像素在不同滤镜下的值， 总共alpha*T（T张图片）个像素
            %每个图象共alpha个像素， 对应alpha*3n, 3n because n filter, and each picture has 3
            %dimensions

            for j = 1:alpha %every pixel's corresponds value (in total 60 (60 filters))
                pts(j, :) = filterResponses(points(j, 1), points(j, 2), :);
            end
            % each row corresponds to a single pixel's respons under different filters
            pixelResponses((1+(i-1)*alpha):(alpha+(i-1)*alpha), :) = pts(:, :);
            now_Responses = pixelResponses(1:(alpha+(i-1)*alpha), :);

            %% every 10 pictures, save
            if mod(i,10) == 0 % update the dictionary every 100 data sets, in case the program fails, also sav ethe fiter responses
                disp("random, previous file detected, update every 10, now: ");
                disp(i);
                disp(" and the expected row # of now_Responses i :");
                disp((alpha+(i-1)*alpha));
                [ ~ , dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');
                save('dictionaryRandom.mat','dictionary','filterBank','now_Responses','pixelResponses');

            end
            disp(i);
        end

         %%    random. no previous files
        else % the file does not exists
        for i = 1: T
            %For each and every training image, load it and apply the filter bank to it.
            s = cell2mat(imgPaths(1, i));
            path = {'../data/', s};
            %disp({path});
            I = imread(cell2mat(path));
            if ndims(I) ~= 3
                I = double(cat(3,I,I,I));
            end

            %apply filters on
            filterResponses = extractFilterResponses(I, filterBank); % [H × W × 3n]

            % in total 3n pictures, each picture of size H x W
            % giving the selected points
            points = zeros(alpha, 2); % points size: [alpha x 2]
            points = getRandomPoints(I, alpha);

            % verified to be legit

            %remember to check if all != 0
            % get the filter responses for the index stored in [points]
            % should be in a matrix [3n 1]
            % first 2 dimensions corrresponds to the index of target pixel
            pts = zeros(alpha, 3*n);% selcted points for this picture
            % 需要找到每个像素在不同滤镜下的值， 总共alpha*T（T张图片）个像素
            %每个图象共alpha个像素， 对应alpha*3n, 3n because n filter, and each picture has 3
            %dimensions
            for j = 1:alpha %every pixel's corresponds value (in total 60 (60 filters))
                pts(j, :) = filterResponses(points(j, 1), points(j, 2), :);
            end

            % each row corresponds to a single pixel's respons under different filters
            pixelResponses((1+(i-1)*alpha):(alpha+(i-1)*alpha), :) = pts(:, :);
            now_Responses = pixelResponses(1:(alpha+(i-1)*alpha), :);
             if mod(i,10) ==0
                disp("random, no previous file deteted, update every 10, now: ");
                disp(i);
                disp(" and the expected row # of now_Responses i :");
                disp((alpha+(i-1)*alpha));
                [ ~ , dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');
                save('dictionaryRandom.mat','dictionary','filterBank','now_Responses','pixelResponses');
             end
           disp(i);
        end
      
    
        end
    end
    disp("finish once, device survives, now compute all and return to test1_3, no need to save the pixelResonses now");
    [ ~ , dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');
end