function [label1, label2] = main(radioButtonClicked)
    image = imread('img.jpg');

    disp(radioButtonClicked);

    switch radioButtonClicked
    case 'к-средних'
        [segmented_mask] = kMeansSegmentation(image);
    case 'водораздел'
        [segmented_mask] = watershedSegmentation(image);
    case 'адаптивная бинаризация'
        [segmented_mask] = adaptiveBinarization(image);
    end
    
    % Преобразование изображений в двоичные маски
    original_mask = imbinarize(rgb2gray(image));
    
    % Вычисление пересечения и объединения масок
    intersection = original_mask & segmented_mask;
    union = original_mask | segmented_mask;
    
    % Вычисление метрик
    jaccard_index = sum(intersection(:)) / sum(union(:));
    dice_coefficient = 2 * sum(intersection(:)) / (sum(original_mask(:)) + sum(segmented_mask(:)));
    
    label1 = num2str(jaccard_index);
    label2 = num2str(dice_coefficient);

    % Вычисление дискретного расстояния Фреше от каждого пикселя
    distanceMapOriginal = bwdist(original_mask);
    distanceMapSegmented = bwdist(segmented_mask);
    
    distanceMapOriginal = im2uint8(distanceMapOriginal);
    distanceMapSegmented = im2uint8(distanceMapSegmented);

    distanceMapOriginal_rgb = cat(3, distanceMapOriginal, distanceMapOriginal, distanceMapOriginal);
    distanceMapSegmented_rgb = cat(3, distanceMapSegmented, distanceMapSegmented, distanceMapSegmented);

    distanceMapSegmented_rgb = distanceMapSegmented_rgb(:,:,1:3);

    % Сохранение сегментированного изображения в папку проекта
    projectFolder = pwd;
    fileName = 'Discrete_Frechet_Distance_Map_for_Original_Image.png'; % Имя файла для сохранения
    filePath = fullfile(projectFolder, fileName); % Полный путь к файлу

    % Сохраняем сегментированное изображение в формате PNG
    imwrite(distanceMapOriginal_rgb, filePath);

    % Сохранение сегментированного изображения в папку проекта
    fileName = 'Discrete_Frechet_Distance_Map_for_Segmented_Image.png'; % Имя файла для сохранения
    filePath = fullfile(projectFolder, fileName); % Полный путь к файлу

    % Сохранение сегментированного изображения в формате PNG
    imwrite(distanceMapSegmented_rgb, filePath);
end

