function [] = plotPoints(filename, latArr, longArr, sortedElevationData, choice, boollabel, color, symbol)
figure(gcf)

% hold on

[~,~,raw] = xlsread(filename);
[rows, ~] = size(raw);

choice = upper(choice);

latIndicies = [];
longIndicies = [];
elevations = [];
label = {};

pointLableHeight = 15;
labelOffset = .00025;


switch choice
    case 'DD'
%             latValue = 
%             longValue = 
    case 'DMS'
        for x = 2:rows
            valueLat = raw{x,2};
            valueLong = raw{x,3};
            rawElevs = raw{x,6};
            
            label = [label; raw{x, 1}];

            [degreesLat,remain] = strtok(valueLat, char(176));
            degreesLat = str2num(degreesLat);
            [minutesLat,remain] = strtok(remain(2:end), '''');
            minutesLat = str2num(minutesLat);
            secondsLat = strtok(remain(2:end), '"');
            secondsLat = str2num(secondsLat);
            %
            [degreesLong,remain] = strtok(valueLong, char(176));
            degreesLong = str2num(degreesLong);
            [minutesLong,remain] = strtok(remain(2:end), '''');
            minutesLong = str2num(minutesLong);
            secondsLong = strtok(remain(2:end), '"');
            secondsLong = str2num(secondsLong);

            latValue = degreesLat + minutesLat./60 + secondsLat./3600;
            longValue = degreesLong + minutesLong./60 + secondsLong./3600;

            latIndicies = [latIndicies latValue];
            longIndicies = [longIndicies longValue];
            elevations = [elevations rawElevs];


        end
    otherwise
        error('Please enter a valid choice option (''DMS'' or ''DD'')');
end

[nearestlatind, ~] = dsearchn(latArr,latIndicies(1));
[nearestlongind, ~] = dsearchn(longArr, longIndicies(1));
referenceElev = sortedElevationData(nearestlatind, nearestlongind);

elevDiff = referenceElev - elevations(1);
elevations = elevations + elevDiff;

scatter3(longIndicies, latIndicies, elevations, 150, color, 'filled');

if boollabel
    scatter3(longIndicies, latIndicies, elevations + pointLableHeight, 150, symbol, color, 'filled');
    for i = 1:length(longIndicies)
        if isnan(label{i})
            vislabel = [num2str(elevations(i),4) 'm'];
        else
            vislabel = [label(i) [num2str(elevations(i),4) 'm']];
        end
        text(longIndicies(i) + labelOffset, latIndicies(i), elevations(i) + 15, vislabel , 'fontsize', 14, 'color', 'black', 'BackgroundColor', 'white', 'EdgeColor', 'black');
        line([longIndicies(i), longIndicies(i)],[latIndicies(i), latIndicies(i)],[elevations(i), elevations(i) + pointLableHeight], 'LineWidth', 4, 'Color', color);
    end
end
end
