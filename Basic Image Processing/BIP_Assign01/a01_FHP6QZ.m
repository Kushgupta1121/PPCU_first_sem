clear all;
clc;
close all;
image=imread("a01_FHP6QZ.jpg");
img=rgb2gray(image); % converting RGB to Gray
st_image=stretch_lin(img); % streching the image using linear stretch
th_image=threshold(st_image,105); % Image thresholding

figure(1);
subplot(2,2,1);
imshow(image);
title('Original image');
subplot(2,2,2);
imshow(th_image);
title('Thresholded binary image');

%convolution
Ker = fspecial('disk',65 );
Ker = Ker';
td_image = double(th_image);
conv_img = conv2(td_image, Ker, 'same');
figure(2)
imagesc(conv_img);
colormap(gca,'jet'); colorbar;
axis equal off;

title({'Result of Convolution'});


% Coin Detection
min_hue = 0.40;
max_hue = 0.60;
th_sat = 0.05;
th_value = 0.5;

n=1;

a = image(1:300, 1:300,:);

for i = 1:size(img,1)
    for j = 1:size(img,2)
        if conv_img(i,j) > 0.8
            a= image(i-124:i+175,j-149:j+150,:);
            b=conv_img(i-124:i+175,j-149:j+150);
            conv_img(i-124:i+175,j-149:j+150)=0;

            red = a(:,:,1); % Red channel
            green = a(:,:,2); % Green channel
            blue = a(:,:,3);% Blue channel
            for q =1:300
                for w=1:300
                    if (175 >red(q,w))&&red(q,w)>150
                        red(q,w) =red(q,w);
                    else
                        red(q,w) = 0;
                    end
                end
            end
            for q =1:300
                for w=1:300
                    if (180 >green(q,w))&& green(q,w)>100
                        green(q,w) =green(q,w);
                    else
                        green(q,w) = 0;
                    end
                end
            end
            for q =1:300
                for w=1:300
                    if (102 >blue(q,w))&&blue(q,w)>100
                        blue(q,w) =blue(q,w);
                    else
                        blue(q,w) = 0;
                    end
                end
            end

            h=[];
            s=[];
            v=[];

            coin= double(red+green+blue);
            coin_hsv = rgb2hsv(a);

            h=coin_hsv(:,:,1);
            s=coin_hsv(:,:,2);
            v=coin_hsv(:,:,3);
            coin_gray=im2gray(coin);

            coin_th = threshold(coin_gray,120);
            area=0;
            real_coin=zeros(300);
            for x = 1:300
                for y =1:300
                    if coin_th(x,y) == 1 && b(x,y) > 0.8 && s(x,y)>0.24
                        real_coin(x,y) = coin(x,y);
                        area=area+1;

                    end


                end
            end


            radius = sqrt(area/pi);
            d_rad = 2*radius;
            number =0;
            figure(4)
            if d_rad>40
                subplot(4,4,n); imshow(a);title('Coin')
                n=n+1;

            else
                subplot(4,4,n); imshow(a);title('Not Coin')
                n=n+1;
            end
            num_value=how_much_value(d_rad,a);

        end
    end
end

forints= sum(num_value(1));
cents= sum(num_value(2));
X = [' Total of  ',num2str(forints),'HUF and ',num2str(cents),'cents'];
disp(X)

