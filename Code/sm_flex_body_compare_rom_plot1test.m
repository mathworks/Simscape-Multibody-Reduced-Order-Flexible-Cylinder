% Code to plot simulation results from sm_flex_body_compare_rom
%% Plot Description:
%
% Plot results of flexible body test.
%
% Copyright 2021 The MathWorks, Inc.

% Generate simulation results if they don't exist
if(~exist('out','var'))
    fprintf("No simulation results available.\nRunning the model to generate results...");
    out = sim('compareFlexibleCylinders');
    fprintf('Done\n');
end

if (~sum(contains(out.who,'logsout_flex_body')))
    error("Expected SignalLoggingName to be 'logsout_flex_body'")
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sm_flex_body_compare_rom', 'var') || ...
        ~isgraphics(h1_sm_flex_body_compare_rom, 'figure')
    h1_sm_flex_body_compare_rom = figure('Name', 'sm_flex_body_compare_rom');
end
figure(h1_sm_flex_body_compare_rom)
clf(h1_sm_flex_body_compare_rom)

%temp_colororder = get(gca,'defaultAxesColorOrder');

logsout_compare_rom = out.get('logsout_flex_body');

% Get simulation results
simlog_flexB  = logsout_compare_rom.get('Flexible Beam Solution');
simlog_rom    = logsout_compare_rom.get('ROM Solution');
simlog_input  = logsout_compare_rom.get('Load');
simlog_analy  = logsout_compare_rom.get('Analytical');

% Plot results
switch ValidationTest 
    case ValidationType.BENDING
        measVar = 'z'; inpTitle = 'Vertical Force';      inLabel = 'Force (N)';
        inpVar = 'fz'; outTitle = 'Vertical Deflection'; outLabel = 'Defl. (m)';
        analyVar = 'none';
        legendArr = {'Flexible Beam','ROM'};
    case ValidationType.TENSION
        measVar = 'x'; inpTitle = 'Longitudinal Force'; inLabel = 'Force (N)';
        inpVar = 'fx'; outTitle = 'Length Deflection';  outLabel = 'Defl. (m)';
        analyVar = 'Tension';
        legendArr = {'Flexible Beam','ROM','Analytical'};
    case ValidationType.TORSION
        measVar = 'q'; inpTitle = 'Longitudinal Torque';   inLabel = 'Torque (N*m)';
        inpVar = 'tx'; outTitle = 'Rotational Deflection'; outLabel = 'Defl. (rad)';
        analyVar = 'Torsion';
        legendArr = {'Flexible Beam','ROM','Analytical'};
end

%plot the loading condition on one subplot
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_input.Values.(inpVar).Time, simlog_input.Values.(inpVar).Data, 'LineWidth', 1,'Color','k')
grid on
title(inpTitle)
ylabel(inLabel)

%plot the responses and the analytical solution on another subplot
simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_flexB.Values.(measVar).Time, simlog_flexB.Values.(measVar).Data, 'LineWidth', 1)
hold on
plot(simlog_rom.Values.(measVar).Time, simlog_rom.Values.(measVar).Data, 'LineWidth', 1)    
if(~strcmp(analyVar,'none'))
   plot(simlog_rom.Values.(measVar).Time([1 end]), simlog_analy.Values.(analyVar).Data(end)*[1 1], 'k--', 'LineWidth', 1)
end
hold off
grid on
title(outTitle)
ylabel(outLabel)
xlabel('Time (s)')

linkaxes(simlog_handles, 'x')

%add a legend
legend(legendArr,'Location','southeast')

% Remove temporary variables
clear simlog_t simlog_handles

