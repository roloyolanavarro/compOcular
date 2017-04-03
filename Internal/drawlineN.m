function I2 = drawlineN(I,xy1,xy2,color,varargin)

    I2 = I;
    sizes = size(I);
    
    if nargin > 4
       thickness = varargin{1}; 
    else 
        thickness = 1;
    end
    
    %still not checking if color dimension is same as I
    
    switch length(sizes)
        case 2
            N = 1;
        case 3
            N = sizes(3);
        otherwise
            error('Function drawlineN works only with 2D matrix or AxBxN');
    end
    
    for i = 1:N
        I1 = I2(:,:,1);
        color1 = color(i);
        
        ind = [];
        for j = 1:thickness
            
            shift = power(-1,mod(j,2))*floor(j/2);
            ind = [ind drawline(xy1+shift,xy2+shift,size(I1))];
            
        end
        
        I1(ind) = color1;
        I2(:,:,1) = I1;
    end
    
end