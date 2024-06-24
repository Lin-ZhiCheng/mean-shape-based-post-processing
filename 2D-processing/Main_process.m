clc
clear
%% this script is to realize the 2-D post-processing in 
    % paper 
    % 'Loss, post-processing and standard architecture improvements of liver
    % deep learning segmentation from Computed Tomography and magnetic resonance '
%%
%

% model prediction results
% prediction files should be save in .png files in a folder
% in each .png dile, different label denotes different class
pred_path  = ['....................'];
pred_dir = dir(pred_path);

% make the catalogue to save the processed images
mkdir(['......................'])

% pred img in 3d
% create a matrix to save label value
pred = zeros(256,256,(length(pred_dir)-2)); % [256,256,num_slice]
for i = 3:(size(pred_dir,1))
    str_pred = [pred_path, pred_dir(i).name];
    pred(:,:,i-2) = imread(str_pred);
end

% divide individual muscle into different dim
pred_individual = uint8(zeros(256,256,size(pred,3),25));

for i =1:25
    for xx = 1:256
        for yy = 1:256
            for zz = 1:size(pred,3)
                if (pred(xx,yy,zz)==i)
                    pred_individual(xx,yy,zz,i) = 1; % label value save to be 1
                end
            end
        end
    end
end
%
% from the start to end go through all slices
final_save_image = uint8(zeros(256,256,size(pred,3)));

for i_z = 1:size(pred_individual,3)
    for i_class = 1:25
        if (ismember(1,pred_individual(:,:,i_z,i_class))==1)

            image = pred_individual(:,:,i_z,i_class); % [256,256]
            % 1 erosion
            SE = strel('disk',3);
            image = imerode(image,SE);
            % 2 bwlabel
            image = bwlabel(image,8);
            % 3 to keep the largest area
            % 
            stats = regionprops(image,'Area');
            [b,index]=sort([stats.Area],'descend');
            if length(stats)<1
                bw=image;
            else
                bw=ismember(image,index(1:1));
            end
            image = bw;
            % 4 dilation
            image = imdilate(image,SE);
            % 5 fill holes
            image = imfill(image,'holes');
            % 6 Smoothedges conv2D
            w = 5; % window size
            kernel = ones(w)/(w^2);
            blurryImage = conv2(single(image),kernel,'same');
            binaryImage = blurryImage>0.5;

            %
            image = binaryImage;

            for aa = 1:256
                for bb = 1:256
                    if (image(aa,bb)==1)
                        final_save_image(aa,bb,i_z) = i_class;
                    end
                end
            end
        end     
    end
end

%% save
% save the post-processed images to files
for i = 1:size(final_save_image,3)
    if ((i)<10)
        imwrite(uint8(final_save_image(:,:,i)),['./test_on_',MCXX,'/',Model_name,'/',Model_name,'_',loo_indx,'/Unet_',loo_indx,'_with_2D_post_process/',MCXX,'_S1_post_000',num2str(i),'.png']);
    end
    
    if ((i)>=10)&&((i)<=99)
        imwrite(uint8(final_save_image(:,:,i)),['./test_on_',MCXX,'/',Model_name,'/',Model_name,'_',loo_indx,'/Unet_',loo_indx,'_with_2D_post_process/',MCXX,'_S1_post_00',num2str(i),'.png']);

    end
    
    if ((i)>=100)&&((i)<=999)
        imwrite(uint8(final_save_image(:,:,i)),['./test_on_',MCXX,'/',Model_name,'/',Model_name,'_',loo_indx,'/Unet_',loo_indx,'_with_2D_post_process/',MCXX,'_S1_post_0',num2str(i),'.png']);

    end
    
    if ((i)>=1000)
        imwrite(uint8(final_save_image(:,:,i)),['./test_on_',MCXX,'/',Model_name,'/',Model_name,'_',loo_indx,'/Unet_',loo_indx,'_with_2D_post_process/',MCXX,'_S1_post_',num2str(i),'.png']);

    end
end














