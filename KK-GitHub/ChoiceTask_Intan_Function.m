function [date_string, trial_folders, folder_list, folder_names, intan_folder, intan_data, digital_data, nexData, both_log_files, log_file, logData, trials, logConflict, isConflict, isConflictOnly, boxLogConflict] = ChoiceTask_Intan_Function(root_dir, session_info)

%Converting ChoiceTask_Intan_Workflow into a function
%    Inputs:
%       root_dir = ''X:/Neuro-Leventhal/data/ChoiceTask' as of 2/8/2024
% Session info - generated within for loop but follows structure below:
%         session_info.level = 'ChoiceStandard';
%         session_info.ratID = 'R0XXX';
%         session_info.date = datetime(YYYY, MM, DD);
%         session_info.session_letter = 'a' (a/b/c/d);
%   Outputs:
% path to session raw data folder - intan_folder, struct of trials within
% session - trials


% date_string = string(session_info.date, 'yyyyMMdd');
date_string = session_info.date;

%Finds path to session data folder which holds needed files
trial_folders = fullfile(root_dir, session_info.ratID, [session_info.ratID '-rawdata'], strcat(session_info.ratID, '_', date_string, session_info.session_letter));
folder_list = dir(trial_folders);
folder_list = folder_list([folder_list.isdir]);
folder_names = {folder_list.name};
for u = 1:numel(folder_names)
   currentFolder = fullfile(trial_folders, folder_names{u});    % Check if the folder name contains the specific word
    if contains(folder_names{u}, session_info.level{1})
        intan_folder = currentFolder;
    end
end

intan_data = read_Intan_RHD2000_file_DL(fullfile(intan_folder, 'info.rhd'));

digital_data = readIntanDigitalFile(fullfile(intan_folder,'digitalin.dat'));

if ~isempty(intan_data)
nexData = intan2nex(fullfile(intan_folder,'digitalin.dat'), fullfile(intan_folder,'analogin.dat'), intan_data); 

both_log_files = fullfile(root_dir, session_info.ratID, [session_info.ratID '-rawdata'], strcat(session_info.ratID, '_', date_string, session_info.session_letter), strcat(session_info.ratID, '_', date_string, '_*.log'));
both_log_files = dir(both_log_files);
log_file = both_log_files(~contains({both_log_files.name}, '_old'));
log_file = fullfile(log_file.folder,log_file.name);

logData = readLogData(log_file); 

%generates trial struct
trials = createTrialsStruct_simpleChoice_Intan(logData, nexData);

   if ~isempty(trials)
        logConflict = vertcat(trials.logConflict);
        isConflict = vertcat(logConflict.isConflict); % Returns isConflict in a logical array of isConflict fields
        isConflictOnly = find(isConflict); % Pulls out indices of actual fields with error
        boxLogConflict = vertcat(logConflict.boxLogConflicts); % Returns boxConflict in workspace with fields for outcome, RT, MT, pretone, centerNP sideNP
    else
        logConflict = [];
        isConflict = [];
        isConflictOnly = []; 
        boxLogConflict = [];
    return;
   end
else
        nexData = [];
        both_log_files = [];
        log_file = [];
        logData = [];
        trials = [];
        logConflict = [];
        isConflict = [];
        isConflictOnly = []; 
        boxLogConflict = [];
    return;
end
end