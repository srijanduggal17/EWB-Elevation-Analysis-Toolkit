function [] = plotPoints(filename, latArr, longArr, sortedElevationData, choice, boollabel, color, symbol)
figure(gcf)

% Get raw data from excel file
[~,~,raw] = xlsread(filename);
[rows, ~] = size(raw);

% Find user's choice of input format
choice = upper(choice);

% Create empty arrays for later use
latIndicies = [];
longIndicies = [];
elevations = [];
label = {};

% Declare constants
pointLableHeight = 15;
labelOffset = .00025;


% Get latitudes, longitudes, and elevations for each point
switch choice
    case 'DD'
%         This case is for decimal degree input
%             latValue = 
%             longValue = 
    case 'DMS'
%       This case is for degrees, minutes, seconds input
        for x = 2:rows
%           Get latitude, longitude, elevation, and label for current point
            valueLat = raw{x,2};
            valueLong = raw{x,3};
            rawElevs = raw{x,6};
            label = [label; raw{x, 1}];

%           Separate input into degrees, minutes, seconds, using
%           appropriate character
%           Latitude
            [degreesLat,remain] = strtok(valueLat, char(176));
            degreesLat = str2num(degreesLat);
            [minutesLat,remain] = strtok(remain(2:end), '''');
            minutesLat = str2num(minutesLat);
            secondsLat = strtok(remain(2:end), '"');
            secondsLat = str2num(secondsLat);
      
%           Longitude
            [degreesLong,remain] = strtok(valueLong, char(176));
            degreesLong = str2num(degreesLong);
            [minutesLong,remain] = strtok(remain(2:end), '''');
            minutesLong = str2num(minutesLong);
            secondsLong = strtok(remain(2:end), '"');
            secondsLong = str2num(secondsLong);

%           Convert to decimal degrees  
            latValue = degreesLat + minutesLat./60 + secondsLat./3600;
            longValue = degreesLong + minutesLong./60 + secondsLong./3600;

%           Append to vector of latitudes,longitudes, and elevations
            latIndicies = [latIndicies latValue];
            longIndicies = [longIndicies longValue];
            elevations = [elevations rawElevs];
        end
    otherwise
        error('Please enter a valid choice option (''DMS'' or ''DD'')');
end

% Find the index of the nearest latitude and longitude to the first point
[nearestlatind, ~] = dsearchn(latArr,latIndicies(1));
[nearestlongind, ~] = dsearchn(longArr, longIndicies(1));

% Find actual elevation of this point
referenceElev = sortedElevationData(nearestlatind, nearestlongind);

% Find offset of inputted reference point to actual elevation
elevDiff = referenceElev - elevations(1);

% Adjust elevation of all inputted points by that offset
elevations = elevations + elevDiff;

% Plot points
scatter3(longIndicies, latIndicies, elevations, 150, color, 'filled');

% For labeling
if boollabel
%   Plot point for label
    scatter3(longIndicies, latIndicies, elevations + pointLableHeight, 150, symbol, color, 'filled');

%   Display each label
    for i = 1:length(longIndicies)
%       Make text the elevation value and label if it exists  
        if isnan(label{i})
            vislabel = [num2str(elevations(i),4) 'm'];
        else
            vislabel = [label(i) [num2str(elevations(i),4) 'm']];
        end
        
%       Plot text and lines
        text(longIndicies(i) + labelOffset, latIndicies(i), elevations(i) + 15, vislabel , 'fontsize', 14, 'color', 'black', 'BackgroundColor', 'white', 'EdgeColor', 'black');
        line([longIndicies(i), longIndicies(i)],[latIndicies(i), latIndicies(i)],[elevations(i), elevations(i) + pointLableHeight], 'LineWidth', 4, 'Color', color);
    end
end
end