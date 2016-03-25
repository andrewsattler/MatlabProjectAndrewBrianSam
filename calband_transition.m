function [instructions] = calband_transition(initial_formation, target_formation, max_beats)
% This function is a template to help you get started with your project
% Note that you should change the function and file name to
%   calband_transition for your submissions, as specified in the project guidelines pdf.
% Also note that this function satisfies all the basic requirements for the
%   problem as well as demonstrating appropriate commenting techniques.
% On that note, as you progress in the assignment, remember to check back 
%   that you are still meeting these basic requirements, as it is easy to lose
%   the fundementals as you get more entrenched in a complex problem.

load('sample_transitions.mat')

% Finds the number of bandmembers by adding up all the 1s in the target
n_bandmembers = sum(sum(target_formation));

% Makes a structure with the appropriate fields (without any actual data)
% and copies it nb times to get a 1 x nb array of structs
instructions = struct('i_target',[],'j_target',[],'wait',[],'direction',[]);
instructions = repmat(instructions,1,n_bandmembers);

% This code finds the i and j indices of each target location and stores
% them in i and j, respectively (note that i and j are not used as of yet!)
[i,j] = find(target_formation);

% Now it is up to you to figure out how to use the information provided
% to fill out the instructions struct array with appropriate values!



% find specific location of every band member up to the total number of
% band members
% put their i and j values in two column arrays
[allfoundrowinorder,allfoundcolumninorder] = findcurrentlocationofbandmembers(initial_formation, n_bandmembers);
%Q: do they output the right values?
%A: it works! it outputs the indices of all of the band members in order
%test
allfoundrowinorder;
allfoundcolumninorder;
%

%create array of all of the distances from each band member to each spot
%           spot1   spot2   spot3
%person1    a       d       g
%person2    b       e       h
%person3    c       f       i
[matrixofdistances] = findmatrixofdistances(i,j,allfoundrowinorder,allfoundcolumninorder);

%above this line WORKS WELL and outputs a matrix as described above


%*************************************************
%START gale shapely method
%*************************************************
[N, person_pref, spot_pref] = findprefs(matrixofdistances);

%gs spots propose
[personnumber, spotnumber] = findminimumpivotsgs1(N, person_pref, spot_pref);

%gs person proposes
[personnumber, spotnumber] = findminimumpivotsgs(N, person_pref, spot_pref);
%*************************************************
%END gale shapely method
%*************************************************



%function above works well on small number of band members. haven't yet
%found why it doesn't assign directions to some marchers in bigger
%transitions

%*************************************************
%START maxout method
%*************************************************
%create a matrix of minimum pivots
%[matrixofminimumpivots] = findminimumpivotsviamaxout(matrixofdistances)

%col# = spot# --- row# = person#
%here are pairings
%not needed if using gs algorithm
%[personnumber,spotnumber] = find(matrixofminimumpivots);
%*************************************************
%START maxout method
%*************************************************


%*************************************************
%START hungarian algorithm method
%*************************************************
[spotnumber,~] = munkres(matrixofdistances);
personnumber = rot90([1:N],3);

%THIS ONE WORKS BEST SO FAR
%not written by me!....damnit check out the wikipedia page though
%*************************************************
%END hungarian algorithm method
%*************************************************


%put i_target and j_target into struct
[instructions] = assignijtargetstostruct(instructions,personnumber,spotnumber,i,j);

%maintain positions

%find and assign direction
[instructions] = findandassigndirection(instructions, n_bandmembers,allfoundrowinorder,allfoundcolumninorder);

% now for the hard part
% we need to make a collision checker

%then when we have found the collisions
%we need to make a fucntion to 1. add wait time 2. reorder directions or 3.
%switch destinations



%%delete this eventually
n = n_bandmembers;
for currentindex = 1:n
    instructions(currentindex).wait = 0;
end
%end delete

%*************************************************
%Collision Checker
%*************************************************
%find i and j positions at each beat
[marcher_i_positions,marcher_j_positions] = cc_ijpositions(instructions, allfoundrowinorder, allfoundcolumninorder);
%ij position to linear index
[linearindex_positions] = cc_ij2LI(initial_formation,marcher_i_positions,marcher_j_positions);

%separate collision checker in multiple sections



%
end