%GETCATEGORIES Something
%
%   listCategories = getCategories(pattern,processedAsc) will search for a
%   pattern in each line in the processed asc matrix, this function is used
%   internally in other data extraction functions to know the space to be
%   allocated by them.
%
%   For more information in how the argument 'pattern' works or where the
%   argument processedAsc comes from:
%
%   SEE ALSO regexp processAsc
%

function listCategories = getCategories(indexes,processedAsc)
    
    for i = 1:length(indexes)
        
        cell = regexp(processedAsc(indexes(i),:),'\d+$','match');
        line=cell{1};
        listCategories(i,1) = str2num(line{1});
        
    end
    
end