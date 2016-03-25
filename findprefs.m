function [N, person_pref, spot_pref] = findprefs(matrixofdistances)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[B1 person_pref] = sort(matrixofdistances,2);
[B2 spot_pref] = sort(matrixofdistances,1);
N = length(person_pref);
end

