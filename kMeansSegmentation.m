function [segmented_mask] = kMeansSegmentation(image)
    % Преобразование изображения в оттенки серого
    gray_image = rgb2gray(image);
    
    % Сегментация методом k-средних
    num_clusters = 3; % Количество кластеров
    segmented_image = imsegkmeans(gray_image, num_clusters);
    
    % Преобразование сегментированного изображения в RGB для лучшего отображения
    
    segmentedImage = label2rgb(segmented_image);
    segmented_mask = imbinarize(rgb2gray(segmentedImage));

    % Сохранение сегментированного изображения в папку проекта
    projectFolder = pwd;
    fileName = 'segmented_image.png'; 
    filePath = fullfile(projectFolder, fileName); 

    % Сохранение сегментированного изображения в формате PNG
    imwrite(segmentedImage, filePath);
end