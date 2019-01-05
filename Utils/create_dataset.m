function [data, big_ship_count] = create_dataset(csvFilePath, newPath, datasetPath, allImgNum, originImgSize, trainImgSize, shipThresh)
%CREATE_DATASET create dataset for training and save it into ship_detection_dataset.mat
%   data: training data
    input_file = fopen(csvFilePath);
    line = fgetl(input_file);
    line = fgetl(input_file)
    img_count = 0;
    big_ship_count = 0;
    data.vehicleTrainingData = [];

    while ischar(line) && big_ship_count < allImgNum
        line = strsplit(line,',');
        img_name = line(1);
        img_count = img_count + 1;
        mask = strsplit(string(line(2)),' ');
        rle = zeros(1, length(mask));
        if size(mask) <= 1

        else
            for i = 1:length(mask)
                rle(i) = str2num(mask(i));
            end
            bbox = rle_to_bbox(rle, originImgSize, shipThresh);
            if bbox ~= -1
                fprintf("process img num is: %d/(%d) \n", big_ship_count + 1, allImgNum)
                big_ship_count = big_ship_count + 1;
                img_path = strcat(datasetPath,string(img_name));
                img = imread(char(img_path));
                new_image = img;
                new_image = imresize(new_image, trainImgSize);
                %bbox = ceil(bbox*228/768);
                bbox(1) = floor(bbox(1)*trainImgSize(1)/originImgSize(1));
                bbox(2) = floor(bbox(2)*trainImgSize(2)/originImgSize(2));
                bbox(3) = floor(bbox(3)*trainImgSize(1)/originImgSize(1));
                bbox(4) = floor(bbox(4)*trainImgSize(2)/originImgSize(2));
                new_image_name = char(strcat(newPath, string(big_ship_count), '.jpg'));
                imwrite(new_image, new_image_name);
                data.vehicleTrainingData = cat(1, data.vehicleTrainingData, table({new_image_name}, {bbox}));
            end 

        end
        line = fgetl(input_file);
    %    pause(0.1)
    end
    data.vehicleTrainingData.Properties.VariableNames = {'imageFileName','Ship'}
    save(fullfile('.','ship_detection_dataset.mat'), 'data');
end

