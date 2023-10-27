clear all; close all; clc;
addpath('X:/Neuro-Leventhal/data/ChoiceTask/GitHub/npy-matlab-master/npy-matlab')

% spike_times = readNPY('X:/Neuro-Leventhal/data/ChoiceTask/R0493/R0493-rawdata/R0493_20230718a/R0493_ChoiceStandard_20230718_230718_170309/spike_times.npy');

session_info.level = 'ChoiceStandard';
session_info.ratID = 'R0493';
session_info.date = datetime(2023, 7, 18);

rootdir = 'X:/Neuro-Leventhal/data/ChoiceTask';

rdf = find_data(rootdir, session_info);



spikes_name = fullfile(rdf, 'spike_times.npy');
spike_times = readNPY(spikes_name);
spike_clusters = readNPY(fullfile(rdf, 'spike_clusters.npy'));
function rat_data_folder = find_data(root_dir, session_info)

    date_string = string(session_info.date, 'yyyyMMdd');
    search_string = fullfile(root_dir, session_info.ratID, [session_info.ratID '-rawdata'], strcat(session_info.ratID, '_', date_string, 'a'), strcat(session_info.ratID, '_ChoiceStandard_', date_string, '_*'));

    valid_folders = dir(search_string);

    rat_data_folder = fullfile(valid_folders.folder, valid_folders.name);

end




