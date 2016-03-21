function [matrixofminimumpivots] = findminimumpivotsviamaxout(matrixofdistances)
%create a matrix of minimum pivots
%this method takes out the max values one by one

matrixofminimums = matrixofdistances;
matrixofminimumpivots = zeros(size(matrixofdistances));
n = length(matrixofdistances);
%keep track of minimums

%take care of 0 distances
matrixofdistances(matrixofdistances==0) = .1;


while length(find(matrixofminimumpivots)) ~= n
    %max of each column
    [maxcols, rowindexofmax] = max(matrixofminimums);
    %max of those column maxes
    [maxmax, colindexofmaxmax] = max(maxcols);

    %column of max value
    maxvaluecolumn = matrixofminimums(:,colindexofmaxmax(1));
    %row of max value
    maxvaluerow = matrixofminimums(rowindexofmax(colindexofmaxmax),:);
    
    
    if sum(isnan(maxvaluecolumn)) == length(maxvaluecolumn)-1 || sum(isnan(maxvaluerow)) == length(maxvaluerow)-1
        %record location of this pivot
        matrixofminimumpivots(rowindexofmax(colindexofmaxmax),colindexofmaxmax(1)) = matrixofdistances(rowindexofmax(colindexofmaxmax),colindexofmaxmax(1))
        %set row and col to NaN
            %set all of row and all of col of mimimum val to NaN
        matrixofminimums(:,colindexofmaxmax(1)) = NaN;
        matrixofminimums(rowindexofmax(colindexofmaxmax(1)),:) = NaN;
    else 
        %operate algorithm for reducing maximums
        %set the maxmax to NaN
        matrixofminimums(rowindexofmax(colindexofmaxmax),colindexofmaxmax(1)) = NaN;
    end
    

    %set minmin val to Inf from NaN
%    matrixofminimumpivots(rowindexofmax(colindexofmaxmax),colindexofmaxmax(1)) = matrixofdistances(rowindexofmax(colindexofmaxmax),colindexofmaxmax(1));
end



end



