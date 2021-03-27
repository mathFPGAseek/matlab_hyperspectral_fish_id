function [done,sens,spec] = fusion_calc_aoc(AccumConfusMat)

done = 0;

stats = confusionmatStats(AccumConfusMat);
sens = stats.sensitivity;
spec = stats.specificity;

done = 1;













%% For Generating  AUC/ROC
%{
str1 = 'AUC/ROC for';

class = fish_name
debug = 1;
cell_array = []
% convert to cell array and concatenate N experiments
% to be able to match the confusion matrix that generated
% our accuracy

for i = 1 : num_fish
   cell_array{end+1} = class(i,:)
end 



debug = 1;
switch mode
    case 1
        str3 = 'Fluorescent Spectroscopy';
    case 2
        str3 = 'VS-NIR Spectroscopy';
    case 3
        str3 = 'SWIR Spectroscopy';
    otherwise
        warning('Unexpected Spectroscopy mode');
end

switch window_dim
    case 5
        str4 = 'w/ 5x5 window';
    case 10
        str4 = 'w /10x10 window';
    otherwise
        warning('Unexpected window size');
end

if (show_roc == 1)
   for i = 1 : num_fish
    
     str2 = cell_array{i};
     Y = sens(i); % True Positive Rate
     X = 1- spec(i); % False Positive Rate
     plot(X,Y)
     xlabel = ('False Positive Rate')
     ylabel = ('True Positive Rate')
     
     title([str1 ' ' str2 str3 str4])

     
   end
end
debug = 1;
%}
end % function