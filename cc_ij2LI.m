function [linearindex_positions] = cc_ij2LI(initial_formation,marcher_i_positions,marcher_j_positions)
%convert i j subscripts to linear index

linearindex_positions = sub2ind(size(initial_formation),marcher_i_positions,marcher_j_positions);
%this works
% tested with:
    %initial_formation = zeros([4 5])
    %marcher_i_positions = [1 1 2 3;1 2 3 4;1 1 1 1];
    %marcher_j_positions = [3 3 3 3;2 2 2 2;1 2 3 4];
% result
    %linearindex_positions =
    %9     9    10    11
    %5     6     7     8
    %1     5     9    13
end


