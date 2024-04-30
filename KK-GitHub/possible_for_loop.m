% For loop to go through all Choice Task rat data and generate psth and
% rasters based on selected trial features and characteristics
% Inputs: 
% trial feature: selected trial feature (Features: correct, incorrect,
% moveright, moveleft, cuedleft, cuedright, falsestart) input to
% import_all_data function line and RAT_SESSION_UNITMAME
% event_name: selected event (Events: cueOn, centerIn, centerOut, tone,
% sideIn, sideOut, foodclick, foodRetrieval) input to import_all_data
% function line and RAT_SESSION_UNITMAME
root_dir = 'X:/Neuro-Leventhal/data/ChoiceTask';
a = dir('X:\Neuro-Leventhal\data\ChoiceTask\R0*');

ratID = cell(length(a),1); %generate cell for ratIDs
for b = 1:length(a)
    ratID{b} = a(b).name;
end
      
all_ses = cellfun(@(ratID) fullfile('X:\Neuro-Leventhal\data\ChoiceTask', ratID, [ratID '-rawdata']), ratID, 'UniformOutput', false);

dir_ses = cellfun(@(ses_path) dir([ses_path, filesep, 'R*']), all_ses, 'UniformOutput', false);
 
    for c = 1:numel(dir_ses)
        % Access the current struct
        current_struct = dir_ses{c};

        % Check if the current element is a struct
        if isstruct(current_struct)
            for d = 1:numel(current_struct)
                % Access the folder paths field within the struct
                folder_paths = fullfile(current_struct(d).folder, current_struct(d).name);

                % Check if the folder path is a character array and exists as a directory
                if exist(folder_paths, 'dir') == 7
                    % List the contents of the directory
                    folder_contents = dir(folder_paths);

                    %checking if choice standard is present then running if yes
                    [out] = isChoiceStandard(folder_contents, 'Ch*', 'Testing');
                    if out == 1
                        pattern = '^(R\d+)_([0-9]+)([a-zA-Z])$'; % Matches 'R' followed by digits, underscore, digits, and a single letter
                        possible_levels = {'Easy', 'Standard', 'Advanced', 'Testing', 'VE'}; % establish possible test levels

                        tokens = regexp(current_struct(d).name, pattern, 'tokens');

                        if ~isempty(tokens)
                            % Extract the matched tokens
                            session_info.ratID = tokens{1}{1}; % Prefix 'R0413'
                            session_info.date = tokens{1}{2}; % Date part '20210726'
                            session_info.session_letter = tokens{1}{3}; % Suffix 'a'
                            session_info.level = {};
                            for e = 1:numel(folder_contents)
                                for f = 1:numel(possible_levels)
                                    if contains(folder_contents(e).name, possible_levels{f})
                                        session_info.level{end+1} = possible_levels{f};
                                    end
                                end
                            end

                            [date_string, trial_folders, folder_list, folder_names, intan_folder, intan_data, digital_data, nexData, both_log_files, log_file, logData, trials, logConflict, isConflict, isConflictOnly, boxLogConflict] = ChoiceTask_Intan_Function(root_dir, session_info);

                            %add in nested for loop for trialfeatures and event names
                            if ~isempty(intan_data)
                                [spikeStruct, clu, st, unique_clusters, numSpks, cluster_spikes, valid_trials, valid_trial_flags, ts] = import_all_data(intan_folder, trials, 'correct', 'foodRetrieval');

                                if ~isempty(cluster_spikes)
                                    for g = 1:size(cluster_spikes, 1)
                                        % [spikeTimes, psth, bins,binWidthInSeconds,psthHz, numRows, zscoredpsth, rasterX, rasterY, spikeCounts] = psthRasterAndCounts(spikeTimes, eventTimes, window, psthBinSize);
                                        [spikeTimes, psth, bins,binWidthInSeconds,psthHz, numRows, zscoredpsth, rasterX, rasterY, spikeCounts] = psthRasterAndCounts(cluster_spikes(g, :)', ts, [-3 3], 0.05);

                                        RAT_SESSION_UNITNAME = strcat(session_info.ratID, '_', session_info.date, '_', session_info.session_letter, '_', 'correct', '_', 'foodRetrieval', num2str(unique_clusters(g))); %establishing label for output
                                        StackPSTHandRaster(bins, psth, rasterX, rasterY, RAT_SESSION_UNITNAME);

                                    end
                                else
                                end
                            else
                            end
                        else
                        end
                    end
                end
            end
        end
    end
