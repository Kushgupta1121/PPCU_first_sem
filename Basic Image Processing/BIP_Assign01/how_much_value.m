function num_value = how_much_value(d_rad,a)

value=0; l=1; vsum=[]; cent=[]; v_cent=0;
  % to count the value of coins
                
                figure(5);
           if   (d_rad < 123) && (d_rad >113) || (d_rad < 103) && (d_rad >102)
                     value = 200;
               subplot(4,4,l); imshow(a);title(['HUF:', num2str(value)]);
               l=l+1;
               vsum=[vsum;value];
           
           elseif (d_rad < 110) && (d_rad >108) || (d_rad < 73) && (d_rad >71)
                     value = 100;
               subplot(4,4,l); imshow(a);title(['HUF:', num2str(value)]);
               l=l+1;
               vsum=[vsum;value];

           elseif (d_rad < 95) && (d_rad >93)
                     value = 50;
               subplot(4,4,l); imshow(a);title(['HUF:', num2str(value)]);
               l=l+1;
               vsum=[vsum;value];

           elseif (d_rad < 140) && (d_rad >138) || (d_rad < 102) && (d_rad >101)
                     value = 20;
               subplot(4,4,l); imshow(a);title(['HUF:', num2str(value)]);
               l=l+1;
               vsum=[vsum;value];

           elseif (d_rad < 105) && (d_rad >104) 
                     value = 10;
               subplot(4,4,l); imshow(a);title(['HUF:', num2str(value)]);
               l=l+1;
               vsum=[vsum;value];

           elseif (d_rad < 72) && (d_rad >69)
                     v_cent = 5;
                     cent=[cent;v_cent];
               subplot(4,4,l); imshow(a);title(['Cent:', num2str(cent)]);
               l=l+1;

           elseif (d_rad < 45) && (d_rad >40)
                     v_cent = 2;
                     cent=[cent;v_cent];
               subplot(4,4,l); imshow(a);title(['Cent:', num2str(cent)]);
               l=l+1;

           end
num_value = [vsum,cent];

end