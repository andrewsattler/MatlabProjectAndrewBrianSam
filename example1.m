% Example - 
% The ith element of the output is the man who will be matched to the ith
% woman. 

N = 4;                      % Number of men/women

person_pref = zeros(N,N);      % Preference order for the men
spot_pref = zeros(N,N);    % Preference order for the women


person_pref = [4 1 2 3; 2 3 1 4; 2 4 3 1; 3 1 4 2];
spot_pref = [4 1 3 2; 1 3 2 4; 1 2 3 4; 4 1 3 2];

stablematch = galeshapley(N, person_pref, spot_pref)
