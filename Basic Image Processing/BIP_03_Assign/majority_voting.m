function OUT = majority_voting(IN, w_dia)
    OUT = zeros(size(IN));  % declaring the ouput 
    for x = 1:w_dia:size(IN,1)  % Iterating throught the input image
        for y = 1:w_dia:size(IN, 2)
            start__x = x; % declaring the x start
            start__y = y; % declaring the y start
            end__x = min(x + w_dia-1, size(IN, 1));  % declaring the x end
            end__y = min(y + w_dia-1, size(IN, 2));  % declaring the y end
            selected_window = IN(start__x:end__x, start__y:end__y);  % selecting values in a particular window
            major_value = mode(selected_window, 'all');  % calculating the mode value in the selected window
            OUT(start__x:end__x, start__y:end__y) = major_value;  %replacing all the values with mode value
        end
    end
end
