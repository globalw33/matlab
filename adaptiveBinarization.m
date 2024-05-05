function [segmented_mask] = adaptiveBinarization(image)
    gray_image = rgb2gray(image);
    
    % Адаптивная бинаризация
    segmentedImage = imbinarize(gray_image, 'adaptive', 'Sensitivity', 0.6);
    segmented_mask = segmentedImage;

    % Преобразование бинарного изображения в RGB-формат
    segmented_image_rgb = cat(3, segmentedImage, segmentedImage, segmentedImage) * 255; % Умножение на 255, чтобы привести к типу uint8

    % Сохранение сегментированного изображения в папку проекта
    projectFolder = pwd;
    fileName = 'segmented_image.png';
    filePath = fullfile(projectFolder, fileName);

    % Сохранение сегментированного изображения в формате PNG
    imwrite(segmented_image_rgb, filePath);
end