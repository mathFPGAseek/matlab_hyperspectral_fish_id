D = {};
%---- First column----%
% write cell array into cell array columns
for i = 1 : 46
    k = (i*3)-2;
    col1 = C{k};
    col2 = C{k+1};
    col3 = C{k+2};
    D{i,1} = col1;
    D{i,2} = col2;
    D{i,3} = col3;

end

debug = 1;
% Take out text
D_no_text = {};
for i = 1 : 46
    for j = 1 : 3
        text_substring = D{i,j};
        no_text_substring = text_substring(5:end);
        D_no_text{i,j} = no_text_substring;
    end
end

debug = 1;
        