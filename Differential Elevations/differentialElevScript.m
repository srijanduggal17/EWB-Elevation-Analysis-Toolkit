function [] = differentialElevScript()

% Reads the CSV file with data and then calls the plotting function
rawElevData = csvread('../Plots and Data/Data Files/OlooRegion.csv',1,0);

% histData(rawElevData);
findDiffElev(rawElevData, 1041.5571);
end