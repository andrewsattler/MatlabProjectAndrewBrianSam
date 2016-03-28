function [valid, valid_inst, msg] = cbl_check_inst(f1, f2, inst, max_beats)
%
% Check whether the array of instructions inst is valid enough.
%
% CBL_CHECK_INST(f1, f2, inst, max_beats): check whether the array of
% instructions inst is valid enough to be able to show the visualizer.
%
% Input argument(s):
%
% - f1: initial formation array.
%
% - f2: target formation array.
%
% - inst: array of instructions.
%
% - max_beats: maximum number of beats available for the transition.
%
% Output argument(s) if the array of instructions is valid enough:
%
% - valid: true.
%
% - valid_inst: 1 by nb struct array (where nb is the number of marchers
% involved in the transition) with fields i_target, j_target, direction,
% and wait. Each value in valid_inst is a logical that it true if and only
% the corresponding value in inst is valid.
%
% - msg: empty character string.
%
% Output argument(s) if the array of instructions is not valid:
%
% - valid: false.
%
% - valid_inst: empty struct array.
%
% - msg: character string that describes the issue.

valid = false;
valid_inst = [];

% The formation array must be of class struct
if ~strcmp(class(inst), 'struct')
    msg = sprintf(['The array of instructions must be of class struct, ', ...
        'but your input is of class %s.'], class(inst));
    return
end

% The array of instructions must be of size 1 by nb
[valid_local, msg_local, nr, nc, nb] = cbl_check_formations(f1, f2);
s = size(inst);
if ~isequal(s, [1, nb])
    msg = sprintf('%dx', s);
    msg = sprintf(['There are %d marchers in the formation arrays, so ', ...
        'the array of instructions must be a 1x%d struct array, but ', ...
        'your input is a %s struct array.'], nb, nb, msg(1:end-1));
    return
end

% The array of instructions must have the fields defined in fields_req
fields_req = {'i_target'; 'j_target'; 'direction'; 'wait'};
fields = fieldnames(inst);
if ~all(ismember(fields_req, fields))
    msg1 = sprintf('%s, ', fields_req{:});
    msg2 = sprintf('%s, ', fields{:});
    msg = sprintf(['The array of instructions must have the following ', ...
        'fields: (%s), but your input has the following fields: (%s)'], ...
        msg1(1:end-2), msg2(1:end-2));
    return
end

% What follow are additional checks that result into warnings, not errors

% Check whether there are extra fields in the array of instructions
extra_fields = fields(~ismember(fields, fields_req));
if numel(extra_fields) ~= 0
    msg = sprintf('%s, ', extra_fields{:});
    fprintf(['WARNING: The following fields in your array of ', ...
        'instructions are superfluous: (%s). You should remove them.\n'], ...
        msg(1:end-2))
end

% Check the validity of each field for each marcher
check_int_min = @(x, m) (strcmp(class(x), 'double') && ...
    isequal(size(x), [1, 1]) && rem(x, 1) == 0 && x >= m);

for ib = 1:nb

    % Check i_target
    i_target = inst(ib).i_target;
    valid_inst(ib).i_target = check_int_min(i_target, 1);
    if ~valid_inst(ib).i_target
        fprintf(['WARNING: Instruction (field i_target) for marcher %d ', ...
            'is not valid.\n'], ib);
    end

    % Check j_target
    j_target = inst(ib).j_target;
    valid_inst(ib).j_target = check_int_min(j_target, 1);
    if ~valid_inst(ib).j_target
        fprintf(['WARNING: Instruction (field j_target) for marcher %d ', ...
            'is not valid.\n'], ib);
    end

    % Check direction
    direction = inst(ib).direction;
    valid_inst(ib).direction = strcmp(class(direction), 'char') && ...
        (strcmp(direction, '.') || ...
        strcmp(direction, 'N') || strcmp(direction, 'S') || ...
        strcmp(direction, 'E') || strcmp(direction, 'W') || ...
        strcmp(direction, 'NE') || strcmp(direction, 'EN') || ...
        strcmp(direction, 'NW') || strcmp(direction, 'WN') || ...
        strcmp(direction, 'SE') || strcmp(direction, 'ES') || ...
        strcmp(direction, 'SW') || strcmp(direction, 'WS'));
    if ~valid_inst(ib).direction
        fprintf(['WARNING: Instruction (field direction) for marcher %d ', ...
            'is not valid.\n'], ib);
    end

    % Check wait
    wait = inst(ib).wait;
    valid_inst(ib).wait = check_int_min(wait, 0) && rem(wait, 2) == 0 && ...
        wait <= max_beats;
    if ~valid_inst(ib).wait
        fprintf(['WARNING: Instruction (field wait) for marcher %d is ', ...
            'not valid.\n'], ib);
    end

    if valid_inst(ib).i_target && valid_inst(ib).j_target

        % Is the target in the grid?
        if i_target > nr || j_target > nc

            fprintf(['WARNING: The target (%d, %d) assigned to marcher ', ...
                '%d is outside of the grid.\n'], i_target, j_target, ib)

        % Is the target an actual target location in the target formation?
        elseif f2(i_target, j_target) ~= 1

        fprintf(['WARNING: The target (%d, %d) assigned to marcher %d is ', ...
            'not a target location in the target formation.\n'], i_target, ...
            j_target, ib)
        end

        % Does the direction point towards the target location?
        [i_marcher, j_marcher] = ind2sub([nr, nc], find(f1 == ib));
        same_row = i_marcher == i_target;
        same_col = j_marcher == j_target;
        if same_row && same_col
            answer = strcmp(direction, '.');
        elseif same_row
            answer = strcmp(direction, 'N') && j_target > j_marcher || ...
                strcmp(direction, 'S') && j_target < j_marcher;
        elseif same_col
            answer = strcmp(direction, 'E') && i_target > i_marcher || ...
                strcmp(direction, 'W') && i_target < i_marcher;
        elseif strcmp(direction, 'NE') || strcmp(direction, 'EN')
            answer = i_target > i_marcher && j_target > j_marcher;
        elseif strcmp(direction, 'NW') || strcmp(direction, 'WN')
            answer = i_target < i_marcher && j_target > j_marcher;
        elseif strcmp(direction, 'SE') || strcmp(direction, 'ES')
            answer = i_target > i_marcher && j_target < j_marcher;
        elseif strcmp(direction, 'SW') || strcmp(direction, 'WS')
            answer = i_target < i_marcher && j_target < j_marcher;
        else
            answer = false;
        end
        if ~answer
            fprintf(['WARNING: Marcher %d cannot reach their target (%d, ', ...
                '%d) from their initial position (%d, %d) by following ', ...
                'their assigned direction: %s.\n'], ib, i_target, j_target, ...
                i_marcher, j_marcher, direction)
        end

        % Can the marcher cover the distance to their target location in
        % the allowed number of beats?
        if valid_inst(ib).wait
            d = abs(j_marcher - j_target) + abs(i_marcher - i_target);
            if d > (max_beats - wait)/2
                fprintf(['WARNING: Marcher %d cannot reach their ', ...
                    'target (%d, %d) from their initial position (%d, ', ...
                    '%d) in %d beats or less after waiting for %d beats ', ...
                    '(they need to travel a distance of %d).\n'], ib, ...
                    i_target, j_target, i_marcher, j_marcher, max_beats, ...
                    wait, d)
            end
        end

    end

end

% If we reach this point, then the array of instructions is valid
valid = true;
msg = '';

end
