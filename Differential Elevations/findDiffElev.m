function [sortedElevationData] = findDiffElev(elevationData, refZero)
sprintf('It begins')

% Label each column of the CSV
longData  = elevationData(:,1);
latData = elevationData(:,2);
elevData = elevationData(:,3);
sprintf('Data Separated')

% Scale the dimensions of the plot to a square
% lowestElev = min(elevData)
lowestElev = refZero;
highestElev = max(elevData);
sprintf('Min and Max Elevations found')

% Converts elevation points to differential points
elevData = elevData - lowestElev;
sprintf('Elevation transformed to differential')

% Find elevation axis endpoints
axisLow = min(elevData);
axisHigh = max(elevData);
sprintf('Axis Endpoints Found')

% Get latitude and longitude axis values
latVal  = unique(latData);
longVal = unique(longData);
sprintf('Unique latitudes and longitudes found') 

% Scale axes such that left and right halves of axes are accurate
latDiff = range(latVal);
longDiff = range(longVal);
latHalf = min(latVal) + .5 .* latDiff;
longHalf = min(longVal) + .5 .* longDiff;
scaleValue = max([longDiff, latDiff]);
latDim = [(latHalf - (.5 .* scaleValue)) (latHalf + (.5 .* scaleValue))];
longDim = [(longHalf - (.5 .* scaleValue)) (longHalf + (.5 .* scaleValue))];
sprintf('Scale Made')

% Convert from degrees to meters
averageLat = mean(latVal);
latValMeters = 111.19.*latVal.*1000;
longValMeters = (pi./180).*longVal.*cosd(averageLat).*6371.*1000;
sprintf('Latitudes and longitudes converted from degrees meters') 

% Find meters from edge of region
latValMeters = latValMeters - min(latValMeters);
longValMeters = longValMeters - min(longValMeters);
sprintf('Meters axis values found') 

% Creates blank table for region
sortedElevationData = NaN(length(latVal),length(longVal));

% Create subregion boundaries
latinmin = min(latVal);
latinmax = max(latVal);
longinmin = min(longVal);
longinmax = max(longVal);

% % Input subregion points -> later will be GUI function
% latinmin = 2.315;
% latinmax = 2.323;
% longinmin = 33.245;
% longinmax = 33.253;
sprintf('Range for latitudes and longitudes found') 

% t4lat = 2.3196;
% t4long = 33.2488;
% label = 'T4';

% Create mask for subregion
latmask = latVal >= latinmin & latVal <= latinmax;
longmask = longVal >= longinmin & longVal <= longinmax;
sprintf('Subregion Mask Created')

% Populate the table with the elevation data
lengthLatVal = length(latVal);
lengthLongVal = length(longVal);
for latCount = 1:lengthLatVal
    for longCount = 1:lengthLongVal
        locInd = [latData == latVal(latCount) & longData == longVal(longCount)];
        if sum(locInd) > 0
            sortedElevationData(latCount, longCount) = elevData(locInd);
        end
    end
    percentage = (latCount ./ lengthLatVal) * 100;
    sprintf('Percentage: %.2f', percentage)
end
sprintf('Elevation Data Sorted')

% Surface plot in degrees
pointLableHeight = 15; %Distance from point to label

figure(101)
surf(longVal(longmask),latVal(latmask),sortedElevationData(latmask, longmask))
figure(gcf)
xlim([min(longVal(longmask)) max(longVal(longmask))])
ylim([min(latVal(latmask)) max(latVal(latmask))])
zlim([(axisLow) (axisHigh + pointLableHeight)])
xlabel('Longitude (deg)')
ylabel('Latitude (deg)')
zlabel('Elevation (meters)')
sprintf('Figure Made')

% Figure settings
% view(0,90);
% axis equal;
shading interp;
colorbar;

% Plot key points
hold on
choice = 'DMS';
plotTap('../Plots and Data/MajorPoints.xlsx', latVal, longVal, sortedElevationData, choice, true, 'blue', 'o');
plotPoints('../Plots and Data/Data Files/InCountryElev.xlsx', latVal, longVal, sortedElevationData, choice, true, 'red', 'o');
hold off
end


