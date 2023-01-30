function H = laws_kernel(k)

if not (1<=k && k<= 9) % to check the value of K in range [1,9]
    error('Error in K, the value does not lies in the range[1,9]')
end
L= 1/6 * [1; 2; 1]; % Initalization of L
E= 1/2 * [1; 0; -1]; % Initalization of E
S= 1/2 * [1; -2; 1];   % Initalization of S

%defining laws_kernel

if k == 1
    H = L*L';
elseif k == 2
    H = L*E';
elseif k == 3
    H = L*S';
elseif k == 4
    H = E*L';
elseif k == 5
    H = E*E';
elseif k == 6
    H = E*S';
elseif k == 7
    H = S*L';
elseif k == 8
    H = S*E';
elseif k == 9
    H = S*S';
end
end


