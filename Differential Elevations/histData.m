function [] = histData(elevationData)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
longData  = elevationData(:,1);
latData = elevationData(:,2);
elevData = elevationData(:,3);

longTable = tabulate(longData)
latTable = tabulate(latData)

figure(101)
subplot(1,2,1)
plot(longTable(:,1), longTable(:,2))
title('Longitude Frequencies')
subplot(1,2,2)
plot(latTable(:,1), latTable(:,2))
title('Latitude Frequencies')


% uniqueLat = unique(latData);
% for count1 = 1:length(uniqueLat)
%     LatCount(count1) = sum(latData == uniqueLat(count1));
%     
% end
% 
% uniqueLat = unique(latData);
% for count1 = 1:length(uniqueLat)
%     LatCount(count1) = sum(latData == uniqueLat(count1));
%     
% end

end

