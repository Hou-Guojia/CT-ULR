%% Contour and texture preservation underwater image restoration via low-rank regularizations
%% Qing Yu, Guojia Hou*, Weidong Zhang, Baoxiang Huang, and Zhenkuan Pan
%% Accepted by Expert Systems With Applications, 2024, DOI: https://doi.org/10.1016/j.eswa.2024.125549.

%All experiments are performed in the MATLAB R2019b environment on a Windows 11 OS with Intel i5-8500T CPU 2.10GHz and 8GB RAM.
%This code runs on several versions Matlab included 2014/2016/2018/2019/2020

close all;clear all;clc;
%addpath utils
addpath ./utils
%% single image
% tic;
% image_path = 'Images/test1.png';
% img = imread(image_path);
% [~, image_name, image_ext] = fileparts(image_path);
% I = CT_ULR(img);
% toc;
% figure;imshow(I);
%% batch run
% Path
script_path = fileparts(mfilename('fullpath'));
img_path = fullfile(script_path, 'Images/');
save_dir = fullfile(script_path, 'Results/');
%% Load the image
fprintf('Starting\n');
ext = {'*.jpeg','*.jpg','*.png','*.pgm', '*.tif','*.bmp'};
img_path_list = [];
img_path_list_ = [];
for i = 1: length(ext)
    img_path_list_ = dir([img_path, ext{i}]);
    img_path_list = [img_path_list;img_path_list_];
end
img_num = length(img_path_list);
fprintf('img_num: %d\n', img_num);
if img_num > 0
    for i = 1: img_num
        img_name = img_path_list(i).name;
        fprintf('%d %s\n',i,strcat(img_path, img_name));
        % Read Image
        cell_str = strsplit(img_name, '.');
        name = cell_str{1, 1};
        type = cell_str{1, 2};
        image = imread(strcat(img_path,img_name));
        % Restore and save the image.
        img = CT_ULR(image);
        imwrite(uint8(img*256.0), [save_dir, name, '_CT-ULR.', type]);
    end
end
fprintf('Finished\n');