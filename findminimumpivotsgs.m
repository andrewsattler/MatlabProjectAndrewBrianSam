function [stablematches] = findminimumpivotsgs(N, person_pref, spot_pref)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%---------GALE - SHAPLEY ALGORITHM (person proposes) --------%
person_free = zeros(N,1);
spot_suitor = zeros(N,N);
spot_partner = zeros(N,1);
rank = zeros(N,N);


for i = 1:N
    for j = 1:N
        for k = 1:N
        if(spot_pref(i,k) == j)
            rank(i,j) = k;
        end
        end
    end
end

while (min(spot_partner) == 0)
    for i = 1:N
        if (person_free(i,1) == 0)
            next = find(person_pref(i,:) > 0, 1);
            spot_suitor(person_pref(i,next),i) = i;
            person_pref(i,next) = 0;
        end
    end
    for i = 1:N
        for j = 1:N
            if(spot_suitor(i,j) ~= 0)
                if(spot_partner(i,1) == 0)
                    spot_partner(i,1) = spot_suitor(i,j);
                    person_free(j,1) = 1;
                end
                if(spot_partner(i,1) ~= 0)
                if(rank(i,spot_suitor(i,j)) < rank(i,spot_partner(i,1)))
                    person_free(spot_partner(i,1),1) = 0;
                    spot_partner(i,1) = spot_suitor(i,j);
                    person_free(j,1) = 1;
                    
                end
                end
            end
        end
    end
end

stablematch = spot_partner;

end

