function [marcher_i_positions,marcher_j_positions] = ...
    cc_ijpositions(instructions, allfoundrowinorder, allfoundcolumninorder,...
    max_beats, n_bandmembers)
%Identify Collisions
%   Detailed explanation goes here

% get print out of linear index of marcher at everypoint in  

%               beat1   beat2   beat3
%bandmember1    pos1    pos2    pos3
%bandmember2    pos4    pos5    pos5
%bandmember3    pos8    pos8    pos8
marcher_i_positions = zeros([n_bandmembers,max_beats]);
marcher_j_positions = zeros([n_bandmembers,max_beats]);

%add initial conditions
marcher_i_positions(:,1) = allfoundrowinorder;
marcher_j_positions(:,1) = allfoundcolumninorder;


for current_beat = 2:max_beats
    for current_bandmember = 1:n_bandmembers
        
        i_marcher = marcher_i_positions(current_bandmember,current_beat-1);
        j_marcher = marcher_j_positions(current_bandmember,current_beat-1);
        i_target = instructions(current_bandmember).i_target;
        j_target = instructions(current_bandmember).j_target;
        
        switch instructions(current_bandmember).direction
            case '.'
                %do nothing
            case 'N'
                if j_target > j_marcher
                    j_marcher = j_marcher + 1;
                    %i_marcher = i_marcher;
                end
            case 'S'
                if j_target < j_marcher
                    j_marcher = j_marcher - 1;
                    %i_marcher = i_marcher;
                end
            case 'E'
                if i_target > i_marcher
                    i_marcher = i_marcher + 1;
                    %j_marcher = j_marcher;
                end
            case 'W'
                if i_target < i_marcher
                    i_marcher = i_marcher - 1;
                    %j_marcher = j_marcher;
                end
            case 'NE'
                if j_target > j_marcher
                    j_marcher = j_marcher + 1;
                    %i_marcher = i_marcehr;
                elseif i_target > i_marcher
                    i_marcher = i_marcher + 1;
                    %j_marcher = j_marcher;
                end
            case 'EN'
                if i_target > i_marcher
                    i_marcher = i_marcher + 1;
                    %j_marcher = j_marcher;
                elseif j_target > j_marcher
                    j_marcher = j_marcher + 1;
                    %i_marcher = i_marcher;
                end
            case 'NW'
                if j_target > j_marcher
                    j_marcher = j_marcher + 1;
                    %i_marcher = i_marcher;
                elseif i_target < i_marcher
                    i_marcher = i_marcher - 1;
                    %j_marcher = j_marcher;
                end
            case 'WN'
                if i_target < i_marcher
                    i_marcher = i_marcher - 1;
                    %j_marcher = j_marcher;
                elseif j_target > j_marcher
                    j_marcher = j_marcher + 1;
                    %i_marcher = i_marcher;
                end
            case 'SE'
                if j_target < j_marcher
                    j_marcher = j_marcher - 1;
                    %i_marcher = i_marcher;
                elseif i_target > i_marcher
                    i_marcher = i_marcher + 1;
                    %j_marcher = j_marcher;
                end
            case 'ES'
                if i_target > i_marcher
                    i_marcher = i_marcher + 1;
                    %j_marcher = j_marcher;
                elseif j_target < j_marcher
                    j_marcher = j_marcher - 1;
                    %i_marcher = i_marcher;
                end
            case 'SW'
                if j_target < j_marcher
                    j_marcher = j_marcher - 1;
                    %i_marcher = i_marcher;
                elseif i_target < i_marcher
                    i_marcher = i_marcher - 1;
                    %j_marcher = j_marcher;
                end
            case 'WS'
                if i_target < i_marcher
                    i_marcher = i_marcher - 1;
                    %j_marcher = j_marcher;
                elseif j_target < j_marcher
                    j_marcher = j_marcher - 1;
                    %i_marcher = i_marcher;
                end
            otherwise
                fprintf(['WARNING: BUG.\n'])
        end
        marcher_i_positions(current_bandmember,current_beat) = i_marcher;
        marcher_j_positions(current_bandmember,current_beat) = j_marcher;
    end
end

end

