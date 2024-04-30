session_info.level = {};
for i = 1:numel(folder_contents)
    for j = 1:numel(possible_levels)
        if contains(folder_contents(i).name, possible_levels{j})
            session_info.level{end+1} = possible_levels{j};
        end
    end
end

