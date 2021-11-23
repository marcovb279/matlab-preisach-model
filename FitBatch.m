clear all
close all
clc

isBatch = true;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Paths to look for files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lookupPaths = [
"G:\My Drive\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT loops_dif_concentrations\PNZT_x0.47_mix";
"G:\My Drive\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT loops_dif_concentrations\PNZT_x0.48_mix";
"G:\My Drive\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT loops_dif_concentrations\PNZT_x0.465_mix";
"G:\My Drive\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT loops_dif_concentrations\PNZT_x0.475_mix";
% "G:\My Drive\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT_loops_difGrainSize\VI";
% "G:\My Drive\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT_loops_difGrainSize\VIII";
% "G:\My Drive\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT_loops_difGrainSize\IX";
% "G:\My Drive\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT_loops_difGrainSize\XIII";
% "G:\My Drive\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT_loops_difGrainSize\XIV";
"G:\Mi unidad\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT loops_dif_concentrations\PNZT_x0.47_mix";
"G:\Mi unidad\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT loops_dif_concentrations\PNZT_x0.48_mix";
"G:\Mi unidad\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT loops_dif_concentrations\PNZT_x0.465_mix";
"G:\Mi unidad\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT loops_dif_concentrations\PNZT_x0.475_mix";
% "G:\Mi unidad\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT_loops_difGrainSize\VI";
% "G:\Mi unidad\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT_loops_difGrainSize\VIII";
% "G:\Mi unidad\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT_loops_difGrainSize\IX";
% "G:\Mi unidad\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT_loops_difGrainSize\XIII";
% "G:\Mi unidad\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT_loops_difGrainSize\XIV";
];
fitMatchFilter = '';
skipFilter = '';

% skipFilter = '\';
% skipFilter = '.*difV.*';
% skipFilter = '.*(uni).*';

% CDC 2020
% fitMatchFilter = 'PNZT_x0.47_.*x3';
fitMatchFilter = 'PNZT_x0.47_.*x3.*1400V';

% Anja's plot
% fitMatchFilter = 'PNZT_x0.47_.*x3.*1200V';

% fitMatchFilter = 'PNZT_x0.47_.*x3.*1200V';
% fitMatchFilter = 'PNZT_x0.465_.*x3.*';

% fitMatchFilter = 'PNZT_.*difV.*';
% fitMatchFilter = 'PNZT_.*x3.*';
% fitMatchFilter = 'PNZT_x0.48_.*difV.*1600V';
% fitMatchFilter = 'PNZT_x0.48_.*x3.*1600V';
% fitMatchFilter = 'PNZT_x0.475_.*difV.*1200V';
% fitMatchFilter = 'PNZT_x0.475_.*x3.*1200V';
% fitMatchFilter = 'PNZT_x0.47_.*difV.*1800V';
% fitMatchFilter = 'PNZT_x0.47_.*x3.*1400V';
% fitMatchFilter = 'PNZT_x0.47_.*x3.*';
% fitMatchFilter = 'PNZT_x0.465_.*difV.*1600V';
% fitMatchFilter = 'PNZT_x0.465_.*x3.*1400V';
% fitMatchFilter = 'PNZT_x0.465_.*x3.*';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fitting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fitFileHandlers = FileHandler.lookForFiles(lookupPaths, fitMatchFilter, skipFilter);
for fhCount=1:length(fitFileHandlers)
    disp('---------------------------------------------------------------');
    fitFileHandlers(fhCount).printInfo();
    dataHandler = fitFileHandlers(fhCount).getDataHandler();

    run('./FitModel');
%     saveas(fitPlotter.loopPlaneFig  , strcat(cd, "\Fitting results\LoopPlane-"  , fitFileHandlers(fhCount).fileName, ".png") );
%     saveas(fitPlotter.inputOutputFig, strcat(cd, "\Fitting results\InputOutput-", fitFileHandlers(fhCount).fileName, ".png") );    
%     saveas(fitPlotter.loopPlaneFig  , strcat("G:\My Drive\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT loops_dif_concentrations\Fitting results\LoopPlane-"  , fitFileHandlers(fhCount).fileName, ".png") );
%     saveas(fitPlotter.inputOutputFig, strcat("G:\My Drive\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT loops_dif_concentrations\Fitting results\InputOutput-", fitFileHandlers(fhCount).fileName, ".png") );    
%     saveas(fitPlotter.loopFig  , strcat("G:\My Drive\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT loops_dif_concentrations\Fitting results\LoopPlane3x-"  , fitFileHandlers(fhCount).fileName, ".png") );
%     saveas(fitPlotter.inputOutputFig, strcat("G:\My Drive\PhD\MATLAB\Hysteresis\Results\Experimental Data\PNZT loops_dif_concentrations\Fitting results\InputOutput3x-", fitFileHandlers(fhCount).fileName, ".png") );
end
isBatch = false;