function [dataMat] = create_data_matrix(csvFilePath, datasetPath)
    %READ_DATA read data from .csv file and convert it to mat
    %   data:image_net
    input_file = fopen(csvFilePath);
    line = fgetl(input_file);
    %data.imageFilename = [];
    %data.vehicle = []
    data.vehicleTrainingData = []
    while ischar(line)
        line = strsplit(line,',');
        % Get image name and read image
        name = strsplit(string(line{1}),'/');
        image_path = char(datasetPath + name(3));
        %box = str2num(char(line(2:5)))
        box = [];
        for i=1:4
            box(i) = str2num(char(line(i+1)));
        end
           
        class = str2double(line(6));
        if class == 1
            %data.imageFilename = cat(1, data.imageFilename, image_path);
            %data.vehicle = cat(1, data.vehicle, box);
            %box_pos = '[' + string(box(1)) + ',' + string(box(2))  + ',' + string(box(3)) + ',' + string(box(4)) + ']'
            data.vehicleTrainingData = cat(1, data.vehicleTrainingData, table({image_path}, {box}));
        end
        line = fgetl(input_file);
    end
    dataMat = data
    save(fullfile('.','ship_detection_small.mat'), 'data');
end

