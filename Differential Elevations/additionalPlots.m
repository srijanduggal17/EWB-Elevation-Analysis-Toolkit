
% % Surface plot in meters
% figure(102)
% surf(longValMeters,latValMeters,sortedElevationData)
% figure(gcf)
% zlim([(axisLow) (axisHigh)])
% xlabel('Latitude (meters)')
% ylabel('Longitude (meters)')
% zlabel('Elevation (meters)')
% 
% colorbar
% 
% hold on
% choice = 'DMS';
% [latIndicies, longIndicies, elevations] = plotTap(latVal, longVal, sortedElevationData, choice);
% hold off

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