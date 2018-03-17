clear
clc

% Reads the CSV file with data and then calls the plotting function
rawElevData = csvread('largerregion.csv',1,0);
% findDiffElev(rawElevData);
% output = findDiffElev(rawElevData);
histData(rawElevData);