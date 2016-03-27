function [] = findsamespacecollision(linearindex_positions)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

%COULD TRY TO FIX OR TRY DIFF WAY
% for currentcolumn = 1:size(linearindex_positions,2)
%     uniqueofcurrentcolumn = unique(linearindex_positions);
%     countOfcurrentcolumn = hist(linearindex_positions,uniqueofcurrentcolumn);
%     indexofRepeatedValue = (countOfcurrentcolumn~=1);
%     repeatedValues = uniqueofcurrentcolumn(indexofRepeatedValue);
%     numberOfAppearancesOfRepeatedValues = countOfcurrentcolumn(indexofRepeatedValue);
% end

for currentcolumn = 1:size(linearindex_positions,2)
    % indices to unique values in column 3
    [val, ind] = unique(linearindex_positions(:, currentcolumn), 'rows')
    % duplicate indices
    duplicate_ind = setdiff(1:size(linearindex_positions, 1), ind)
    % duplicate values
    duplicate_value = linearindex_positions(duplicate_ind, currentcolumn)
end


end

