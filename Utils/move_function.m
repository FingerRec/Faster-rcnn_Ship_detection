function [dataMat] = move_function(csvFilePath, datasetPath, newPath)
    %MOVE_FUNCTION 此处显示有关此函数的摘要
    %   此处显示详细说明
    input_file = fopen(csvFilePath);
    line = fgetl(input_file);
    img_count = 0;
    data.vehicleTrainingData = [];
    while ischar(line)
        line = strsplit(line,',');  
        % Get image name and read image
        name = strsplit(string(line{1}),'/');
        image_path = char(datasetPath + name(3));
        class = str2double(line(6));
        box = [];
        for i=1:4
            box(i) = floor(str2num(char(line(i+1))) / 3.368);
        end
        box2 = [box(2), box(1), box(4) - box(2), box(3) - box(1)];
        if class == 1
            img_count = img_count + 1;
            image = imread(image_path);
            new_image = imresize(image, [228, 228]);
            new_image_name = char(strcat(newPath, string(img_count), '.jpg'));
            imwrite(new_image, new_image_name)
            data.vehicleTrainingData = cat(1, data.vehicleTrainingData, table({new_image_name}, {box2}));
        end
        line = fgetl(input_file);
    end
    dataMat = data
    save(fullfile('.','ship_detection_small.mat'), 'data');
end

