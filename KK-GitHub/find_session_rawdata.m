function raw_data_folder = find_session_rawdata(root_dir, session_info)
% 
% INPUTS:
%   root_dir - top level data directory; next level down is a folder for
%       each rat
%   session_info - structure with the following fields:
%       ratID - string containing rat ID - e.g., "R0420"
%       level - training level - e.g. "ChoiceStandard", etc...
%       date - matlab datetime object containing the date on which the data
%           were obtained
%       session_letter - 'a', 'b', 'c', etc.
%
% OUTPUTS:
%   raw_data_folder - string containing the path to the raw data folder for
%       that session
    date_string = string(session_info.date, 'yyyyMMdd');
    search_string = fullfile(root_dir, session_info.ratID, [session_info.ratID '-rawdata'], strcat(session_info.ratID, '_', date_string, session_info.session_letter));

    valid_folders = dir(search_string);

    raw_data_folder = fullfile(valid_folders.folder, valid_folders.name);
end
