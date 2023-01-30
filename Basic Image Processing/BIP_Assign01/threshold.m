function [TH] = threshold(IMG, level)
for i=1:size(IMG,1)
        for j=1:size(IMG,2)
            if IMG(i,j) < level
                TH(i,j)= 0;
            else
                TH(i,j)= 1;
            end
        end
end
