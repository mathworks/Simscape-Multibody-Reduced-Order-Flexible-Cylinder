%Copyright 2021 The MathWorks, Inc.
%% Data for beam with circular cross-section
L = 1; %m
r = 0.05; %m
nu = 0.33; %poisson's ration
E = 70e9; %Pa
rho = 2700; %kg/m^3
Beta = 0.0001; %Damping coefficient

ValidationTest = ValidationType.BENDING;

%% Load in ROM generated from PDE Toolbox
%This ROM was created from "Components\Cylinder.stl" using the PDE Toolbox
%functions from the PDE toolbox. See this example for details on this:
% https://www.mathworks.com/help/physmod/sm/ug/model-excavator-dipper-arm.html
% 
% If you have a license for the PDE Toolbox, you can reproduce this
% generated ROM using the script named "generate_cylinder_ROM"
S = load("ROMs\PDE_ROM.mat");
cyl.P = S.cyl.P;
cyl.K = S.cyl.K(1:12,1:12);    %no dynamic modes
cyl.M = S.cyl.M(1:12,1:12);    %no dynamic modes


%% Clear intermediate variable
clear S 
