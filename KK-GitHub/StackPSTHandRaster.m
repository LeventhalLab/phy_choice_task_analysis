% Script to stack psth and raster onto one figure
% Inputs:
% bins, psth, rasterX, rasterY all outputs from psthRasterAndCounts
% function. RAT_SESSION_UNITNAME generated in for loop to label output 
% Have to add in selected path to save outputs to, selected y and x axis
% limits and titles
function[]=StackPSTHandRaster(bins, psth, rasterX, rasterY, RAT_SESSION_UNITNAME)
figure;

% Replace underscores with spaces in the title
title_text = strrep(RAT_SESSION_UNITNAME, '_', ' ');

sgtitle(title_text);

subplot(4, 4, [2,3,6,7]);
plot(bins,psth);
xlim([-3 3]);
ylabel('Hz')
xticks([]);

subplot(4,4,[10,11,14,15]);
plot(rasterX, rasterY,'k.');
xlim([-3 3]);
ylabel('Trials')
xlabel('Time (sec)')

% Save figure
fig_path = 'H:\PSTH_and_Rasters\Correct_SideIn';
if ~exist(fig_path, 'dir')
    mkdir(fig_path);
end
saveas(gcf, fullfile(fig_path, [RAT_SESSION_UNITNAME, '.png']));
close(gcf);


