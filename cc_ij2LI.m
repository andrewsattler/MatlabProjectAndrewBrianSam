function [linearindex_positions] = cc_ij2LI(initial_formation,marcher_i_positions,marcher_j_positions)
%convert i j subscripts to linear index

linearindex_positions = sub2ind(size(initial_formation),marcher_i_positions,marcher_j_positions);

end

