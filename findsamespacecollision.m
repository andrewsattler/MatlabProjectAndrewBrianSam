function [C,ia,ic] = findsamespacecollision(linearindex_positions)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
for currentcolumn = 1:size(linearindex_positions,2)
    
    uniqueofcurrentcolumn = unique(linearindex_positions(:,currentcolumn));
    countOfcurrentcolumn = hist(linearindex_positions(:,currentcolumn),uniqueofcurrentcolumn);
    indexofRepeatedValue = (countOfcurrentcolumn~=1);
    repeatedValues = uniqueofcurrentcolumn(indexofRepeatedValue);
    numberOfAppearancesOfRepeatedValues = countOfcurrentcolumn(indexofRepeatedValue);
    
end

end

