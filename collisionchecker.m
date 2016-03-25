function [  ] = collisionchecker(instructions)
%Identify Collisions
%   Detailed explanation goes here

% get print out oflinear index of marcher at everypoint in time

%               beat1   beat2   beat3
%bandmember1    pos1    pos2    pos3
%bandmember2    pos4    pos5    pos5
%bandmember3    pos8    pos8    pos8

marcher_positions = zeros([maxbeats,n_bandmembers]);

%need to add initial positions

for current_beat = 1:max_beats
    for current_bandmember = 1:n_bandmembers
        i_marcher =
        j_marcher =
        i_target = inst(current_bandmember).i_target
        j_target = inst(current_bandmember).j_target
        switch inst(current_bandmember).direction
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
    end
end

end

