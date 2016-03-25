function [personnumber, spotnumber] = findminimumpivotsgs1(N, spot_pref1, person_pref1)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%---------GALE - SHAPLEY ALGORITHM (person proposes) --------%
spot_free1 = zeros(N,1);
person_suitor = zeros(N,N);
person_partner = zeros(N,1);
rank = zeros(N,N);


for i = 1:N
    for j = 1:N
        for k = 1:N
        if(person_pref1(i,k) == j)
            rank(i,j) = k;
        end
        end
    end
end

while (min(person_partner) == 0)
    for i = 1:N
        if (spot_free1(i,1) == 0)
            next = find(spot_pref1(i,:) > 0, 1);
            person_suitor(spot_pref1(i,next),i) = i;
            spot_pref1(i,next) = 0;
        end
    end
    for i = 1:N
        for j = 1:N
            if(person_suitor(i,j) ~= 0)
                if(person_partner(i,1) == 0)
                    person_partner(i,1) = person_suitor(i,j);
                    spot_free1(j,1) = 1;
                end
                if(person_partner(i,1) ~= 0)
                if(rank(i,person_suitor(i,j)) < rank(i,person_partner(i,1)))
                    spot_free1(person_partner(i,1),1) = 0;
                    person_partner(i,1) = person_suitor(i,j);
                    spot_free1(j,1) = 1;
                    
                end
                end
            end
        end
    end
end
spotnumber = rot90([1:N],3);
personnumber = person_partner;

end

