function [sortedElevationData] = findDiffElev(elevationData)
% Label each column of the CSV
longData  = elevationData(:,1);
latData = elevationData(:,2);
elevData = elevationData(:,3);

% Scale the dimensions of the plot to a square
lowestElev = min(elevData);
highestElev = max(elevData);

elevData = elevData - lowestElev;

axisLow = min(elevData);
axisHigh = max(elevData);

latDiff = range(latData);
longDiff = range(longData);

latHalf = min(latData) + .5 .* latDiff;
longHalf = min(longData) + .5 .* longDiff;

scaleValue = max([longDiff, latDiff]);

latDim = [(latHalf - (.5 .* scaleValue)) (latHalf + (.5 .* scaleValue))];
longDim = [(longHalf - (.5 .* scaleValue)) (longHalf + (.5 .* scaleValue))];


% Gets the axis values for lat and long in degrees and meters from edge of
% region
latVal  = unique(latData);
longVal = unique(longData);

latValMeters = 111.19.*latVal.*1000;

averageLat = mean(latVal);
longValMeters = (pi./180).*longVal.*cosd(averageLat).*6371.*1000;

latValMeters = latValMeters - min(latValMeters);
longValMeters = longValMeters - min(longValMeters);

% Creates a table of undefined elements for our region
sortedElevationData = NaN(length(latVal),length(longVal));

latinmin = 2.315;
latinmax = 2.323;
longinmin = 33.245;
longinmax = 33.253;

t4lat = 2.3196;
t4long = 33.2488;
label = 'T4';

latmask = latVal >= latinmin & latVal <= latinmax;
longmask = longVal >= longinmin & longVal <= longinmax;

% Populates the table with the elevation data
for latCount = 1:length(latVal)
    for longCount = 1:length(longVal)
        locInd = [latData == latVal(latCount) & longData == longVal(longCount)];
        if sum(locInd) > 0
            sortedElevationData(latCount, longCount) = elevData(locInd);
        end
    end
end

% Surface plot in degrees
figure(101)
surf(longVal(longmask),latVal(latmask),sortedElevationData(latmask, longmask))
figure(gcf)
xlim([min(longVal(longmask)) max(longVal(longmask))])
ylim([min(latVal(latmask)) max(latVal(latmask))])
zlim([(axisLow) (axisHigh)])
xlabel('Longitude (deg)')
ylabel('Latitude (deg)')
zlabel('Elevation (meters)')

nearestlatind = dsearchn(latVal,t4lat);
nearestlongind = dsearchn(longVal, t4long);
nearestelevation = sortedElevationData(nearestlatind, nearestlongind);

hold on
t4 = scatter3(t4long, t4lat, nearestelevation, 100, 'red', 'filled');
text(t4long, t4lat, nearestelevation + 15, label);
plot3([t4long, t4long],[t4lat, t4lat],[nearestelevation, nearestelevation + 15]);
hold off

% % Surface plot in meters
% figure(102)
% surf(longValMeters,latValMeters,sortedElevationData)
% figure(gcf)
% zlim([(axisLow) (axisHigh)])
% xlabel('Latitude (meters)')
% ylabel('Longitude (meters)')
% zlabel('Elevation (meters)')
% 
% % Contour map in degrees
% figure(103)
% contour3(longVal,latVal,sortedElevationData,20)
% zlim([(axisLow) (axisHigh)])
% xlabel('Latitude (deg)')
% ylabel('Longitude (deg)')
% zlabel('Elevation (meters)')
% 
% % Contour map in meters
% figure(104)
% contour3(longValMeters,latValMeters,sortedElevationData,20)
% zlim([(axisLow) (axisHigh)])
% xlabel('Latitude (meters)')
% ylabel('Longitude (meters)')
% zlabel('Elevation (meters)')
% 
% 3D plot of raw data
% figure(105)
% plot3(longData, latData, elevData, 'ko');
% zlim([(axisLow) (axisHigh)])
% xlabel('Latitude (deg)')
% ylabel('Longitude (deg)')
% zlabel('Elevation (meters)')
% 
% hold on
% t4 = scatter3(t4long, t4lat, nearestelevation, 100, 'red', 'filled');
% hold off

% Plots we may use later
% % % figure(106)
% % % tri = delaunay(longData,latData);
% % % trisurf(tri,longData,latData,elevData)
% % % zlim([(lowestElev) (highestElev)])
% % % 
% % % ylabel('Latitude (deg)')
% % % xlabel('Longitude (deg)')
% % % zlabel('Elevation (meters)')
end


