function [output] = visualizationScript

    % Reads the CSV file with data and then calls the plotting function
    rawElevData = csvread('finalelevdata2.csv',1,0);
    output = findDiffElev(rawElevData);
    
end