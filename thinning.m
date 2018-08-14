function [ k ] = thinning( imbwaa )
%UNTITLED Summary of this function goes here;
%   Detailed explanation goes here
img= imbwaa;
img=bwmorph(img,'shrink',2.5);
imshow(img);
k = ~img;

end

