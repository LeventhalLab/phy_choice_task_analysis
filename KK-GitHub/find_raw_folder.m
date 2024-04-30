function rat_data_folder = find_raw_folder(root_dir, session_info)

    % date_string = string(session_info.date, 'yyyyMMdd');
    date_string = session_info.date;
    %search_string = fullfile(root_dir, session_info.ratID, [session_info.ratID '-rawdata'], strcat(session_info.ratID, '_', date_string, session_info.session_letter), strcat(session_info.ratID, '_ChStandard_', date_string, '_*'));
    search_string = fullfile(root_dir, session_info.ratID, [session_info.ratID '-rawdata'], strcat(session_info.ratID, '_', date_string, session_info.session_letter), strcat(session_info.ratID, '_', session_info.level{1}, '*', '_', date_string, '_*'));
    valid_folders = dir(search_string);

    rat_data_folder = fullfile(valid_folders.folder, valid_folders.name);

end
