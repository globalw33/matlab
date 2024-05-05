function [segmented_mask] = watershedSegmentation(image)
    % Преобразование изображения в оттенки серого
    grayImage = rgb2gray(image);
    
    % Примение сегментации на основе градиента
    gradientImage = imgradient(grayImage);
    
    % Измение изображения градиента, чтобы создать изображение маркера.
    markerImage = imextendedmin(gradientImage, 15);
    
    % Подавление региональных минимумов за пределами интересующей области
    imposedImage = imimposemin(gradientImage, markerImage);
    
    % Выполнение сегментации водораздела
    segmentedImage = label2rgb(watershed(imposedImage));
    segmented_mask = imbinarize(segmentedImage);

    % Сохранение сегментированного изображения в папку проекта
    projectFolder = pwd; 
    fileName = 'segmented_image.png'; 
    filePath = fullfile(projectFolder, fileName); 

    % Сохранение сегментированного изображения в формате PNG
    imwrite(segmentedImage, filePath);
end

