% function[out]=isChoiceStandard(folder_contents,strng)
% out=0;ii=1;
% while  out == 0 && ii<=length(folder_contents) 
%     out=strfind(folder_contents(ii).name,strng);ii=ii+1; %option to start with ii=3 to skip . and .. in folder_contents
%     if isempty(out);out=0;end
%     if sum(out)>0;out=1;end
% end

function [out] = isChoiceStandard(folder_contents, strng1, strng2)
    out = 0;ii = 1;
    while out == 0 && ii <= length(folder_contents)
        out1 = strfind(folder_contents(ii).name, strng1);
        out2 = strfind(folder_contents(ii).name, strng2);

        if ~isempty(out1) || ~isempty(out2)
            out = 1;
        end

        ii = ii + 1;
    end
end