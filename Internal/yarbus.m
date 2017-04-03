function I = yarbus(image,xy,color,varargin)

    if nargin > 3
        thickness = varargin{1};
    else
        thickness = 1;
    end

    I = image;
    imsize = size(image);
    fxy = floor(xy);
    valid = ~(fxy(:,1)+thickness>imsize(2)|fxy(:,1)-thickness<1|fxy(:,2)+thickness>imsize(1) ...
            |fxy(:,2)-thickness<1|isnan(fxy(:,1))|isnan(fxy(:,2)));
    
    for i = 1:length(xy)-1
        if valid(i)
            I(fxy(i,2),fxy(i,1),:) = color;
            
            if valid(i+1)
                I = drawlineN(I,fxy(i,end:-1:1),fxy(i+1,end:-1:1),color,thickness);
            end
        end
    end

end