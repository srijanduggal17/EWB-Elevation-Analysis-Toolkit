clear
clc

rawElevData = csvread('largerregion.csv',1,0);
output = elevationProcesserEWB(rawElevData);