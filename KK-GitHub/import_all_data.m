function [spikeStruct, clu, st, unique_clusters, numSpks, cluster_spikes, valid_trials, valid_trial_flags, ts] = import_all_data(intan_folder, trials, trialfeatures, event_name)
%function to pull all kilosort and intan data into matlab, generate spike
%structure, and pull desired timestamps based off selected event
% Inputs: 
% Intan folder - output from ChoiceTask Intan Function - path to session
% data folder
% trials - output from ChoiceTask Intan Function - struct of trials during
% session
% trialfeatures - selected trial feature (Features: correct, incorrect,
% moveright, moveleft, cuedleft, cuedright, falsestart)
% event_name - seclected event 
% Events - cueOn, centerIn, centerOut, tone, sideIn, sideOut, foodclick, foodRetrieval


%Loading all Kilosort Data
spikeStruct = loadKSdir(intan_folder);
if ~isempty(spikeStruct)
clu = spikeStruct.clu;
st = spikeStruct.st;

%Generate matrix with N rows for each unit's spike timestamps
[unique_clusters, numSpks, cluster_spikes] = unit_spike_activity(clu, st);

%extract trials by feature (incl. correct, wrong, moveright, moveleft, cudeleft, cuedright, falsestart) 
[valid_trials, valid_trial_flags] = extract_trials_by_features(trials, trialfeatures);

%timestames from trial
ts = ts_from_trials(valid_trials, event_name); %changed trials to valid_trials so ts_from_trials was only run on trails matching specified trial feature
%ts_without_nan = ts(~isnan(ts)); %might need to avoid NaN included
else 
    ksDir = [];
    clu = [];
    st = [];
    unique_clusters = [];
    numSpks = [];
    cluster_spikes = [];
    valid_trials = [];
    valid_trial_flags = [];
    ts = [];
end