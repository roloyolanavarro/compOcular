function [H, pValue, W] = swtest2(x, alpha)

siz = size(x);

if (nargin >= 2) && ~isempty(alpha)
   if ~isscalar(alpha)
      error(' Significance level ''Alpha'' must be a scalar.');
   end
   if (alpha <= 0 || alpha >= 1)
      error(' Significance level ''Alpha'' must be between 0 and 1.'); 
   end
else
   alpha  =  0.05;
end

for i = 1:siz(2)
    
    [H(i) pValue(i) W(i)] = swtest(x(:,i),alpha);
    
end
