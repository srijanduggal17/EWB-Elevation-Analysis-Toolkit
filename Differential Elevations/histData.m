function [] = histData(elevationData)
%Plots a histogram of the region's elevation data
%   The purpose of this is to see if you are missing data from a specific
%   region

% Separates each column into appropriate variabels
longData  = elevationData(:,1);
latData = elevationData(:,2);

% Creates a frequency table of the latitude and longitude data
longTable = tabulate(longData);
latTable = tabulate(latData);

% Creates a figure with two subplots
figure(102)
subplot(1,2,1)

% Plots the values against the # of times they occur
plot(longTable(:,1), longTable(:,2))
title('Longitude Frequencies')
subplot(1,2,2)
plot(latTable(:,1), latTable(:,2))
title('Latitude Frequencies')
end