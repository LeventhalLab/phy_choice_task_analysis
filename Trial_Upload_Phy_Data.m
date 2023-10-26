clear all; close all; clc;
addpath('X:/Neuro-Leventhal/data/ChoiceTask/GitHub/npy-matlab-master/npy-matlab')

% spike_times = readNPY('X:/Neuro-Leventhal/data/ChoiceTask/R0493/R0493-rawdata/R0493_20230718a/R0493_ChoiceStandard_20230718_230718_170309/spike_times.npy');

rootdir = 'X:/Neuro-Leventhal/data/ChoiceTask';
ratID = 'R0493';
trialDate = '20230718'; %Trial date is assumed to have form YYYYMMDDa, if different will need to change strcat

result = find_data(rootdir, ratID, trialDate);
disp(result)
dir(result);

spike_subfolder = readNPY(result);

function rat_data_folder = find_data(root_dir, ratID, trialDate)
addpath(genpath(strcat('X:/Neuro-Leventhal/data/ChoiceTask/', ratID,'/', strcat(ratID, '-rawdata'), '/', strcat(ratID, '_', trialDate, 'a'))))
rat_data_folder = strcat(root_dir, '/', ratID, '/', strcat(ratID, '-rawdata'), '/', strcat(ratID, '_', trialDate, 'a'), '/', strcat(ratID, '_', 'ChoiceStandard_', trialDate, '_*'), '/','spike_times.npy');
end

% spike_subfolder = strcat(result, spike_ts);

% if exist(spike_times, "file")
%     spike_times = readNPY(result);
% else
%     error('The file does not esist.', result);
% end
%spike_ts = 'spike_times.npy';