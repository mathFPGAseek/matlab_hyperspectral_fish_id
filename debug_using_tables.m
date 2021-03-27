% Descr:
% 1. Gets unique species by subject number
% 2. Samples for species

% Load Table  

load('../tables_with_single_split/table_test_vis.mat');
T = table_test_VIS;

%load('../tables_with_single_split/table_train_vis.mat');
%T = table_train_VIS;



T_cell = table2cell(T);


% Find unique species
debug = 1;
T_cell_Transpose = T_cell';
T_sample = (T_cell_Transpose(1,:));
debug = 1;
C = unique(T_sample);
debug = 1;

% How many of each species

len_col = size(T_cell);
len_col = len_col(1);

len_species = size(C);
len_species = len_species(2);

Count_for_species = zeros(1,len_species);

count = 0;
for i = 1 : len_species
    for j = 1 : len_col
        contents = T_cell{j,1};
        if contents == C{i}
            count = count + 1;
        end
    end
    Count_for_species(i) = count;
    count = 0;
end

debug = 1;

%






%{
function [data_train,data_test] = extract_csv_data(filename)

     T = readtable(filename);    
    
     T_cell = table2cell(T);
     T_matrix = cell2mat(T_cell(:,2));
     length_matrix = length(T_matrix);
     size_of_train = fix(.80*length_matrix);
     start_index = size_of_train+1;
     train_table = T(1:size_of_train,:);
     test_table  = T(start_index:end,:);

     train_cell = table2cell(train_table);
     test_cell  = table2cell(test_table);

     train_matrix = cell2mat(train_cell);
     test_matrix  = cell2mat(test_cell);
    
    try
        data_train   = train_matrix;
        data_test    = test_matrix;
    catch ex
        rethrow(ex);
    end

 end
%}