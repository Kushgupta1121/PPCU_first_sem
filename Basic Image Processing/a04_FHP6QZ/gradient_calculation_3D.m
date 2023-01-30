%function for 3D-gradient calculation
function G_t= gradient_calculation_3D(Img,n,RGN)
if n==1
    G_t=Img-RGN(:,:,2);
elseif n==9
    G_t=Img-RGN(:,:,8);
else
    G_t=RGN(:,:,n+1)-RGN(:,:,n-1);
end

end
