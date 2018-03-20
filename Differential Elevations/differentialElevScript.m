function [] = differentialElevScript()

% Reads the CSV file with data and then calls the plotting function
rawElevData = csvread('../Plots and Data/Data Files/OlooLargerRegion.csv',1,0);
findDiffElev(rawElevData, 1041.5571);
% histData(rawElevData);

end