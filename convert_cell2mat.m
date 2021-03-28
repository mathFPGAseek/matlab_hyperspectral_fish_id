%
convert_cell_2_doub = cell2mat(AccumConfusMat);

stats = confusionmatStats(convert_cell_2_doub);
sens = stats.sensitivity;
spec = stats.specificity;

debug = 1;
