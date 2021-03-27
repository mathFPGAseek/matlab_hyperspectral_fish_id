
%----------------------------------------------------------------------
% filename: create_test_csv_files_func.m
% author: rbd
% 3/7/21 
% descr: extract from table to generate csv files.
%---------------------------------------------------------------------
function [ done] = create_test_csv_files_func(T,...
                   dir_data_file,dir_count_file,count_file_name,...
                   B,spectra_low_col,spectra_high_col,norm)
               
done = 0;

% Load Table  
%load('../tables/table_test_vis.mat');
%T = table_test_VIS;

T_cell = table2cell(T);

% Constant Strings
output_ae_test_directory =  dir_data_file;
output_ae_test_count     =  dir_count_file;
vs_test_count            =  count_file_name;

% Find unique species
%debug = 1;
%T_cell_Transpose = T_cell';
%T_sample = (T_cell_Transpose(1,:));
%debug = 1;
%C = unique(T_sample);
%debug = 1;

% How many of each species

len_col = size(T_cell);
len_col = len_col(1);

len_species = size(B);
len_species = len_species(2);

% Initialize
temp_cell_matrix = {}; % temporary copy of one sample
temp_matrix = [];
temp_acc_matrix = [];
count = 0;

Count_for_species = zeros(1,len_species);

count = 0;
for i = 1 : len_species
    for j = 1 : len_col
        contents = T_cell{j,1};
        if contents == B{i}
            count = count + 1;
        end
    end
    Count_for_species(i) = count;
    count = 0;
end


count = 0;
for i = 1 : len_species
    
    debug = 1;
    if i == 12
       debug_trigger = 1;
    end
    debug = 1;
    %tic
    for j = 1 : len_col
        contents = T_cell{j,1};
        if j == 2227
            debug_trigger = 1;
        end
        if contents == B{i}
            count = count + 1;
            for k = spectra_low_col : spectra_high_col % For VIS
              temp_cell_matrix{end + 1} = T_cell{j,k};
            end
        
            %temp_matrix     = cell2mat(temp_cell_matrix);
            temp_matrix = [temp_cell_matrix{:}];
            temp_acc_matrix = cat(1,temp_acc_matrix,temp_matrix);
            temp_cell_matrix = {};
        end
    end
    %toc
    
     if norm == 1
          [temp_acc_matrix] = normalize(temp_acc_matrix);
     end 
    % Write Test file
    save_ae_in_data(output_ae_test_directory,B{i},temp_acc_matrix)
    temp_acc_matrix = [];
    Count_for_species(i) = count;
    count = 0;
end
% Write counts for each species 
save_ae_in_data(output_ae_test_count,vs_test_count,Count_for_species)

done = 1;

%%--------------------------------------
%% Functions
%%--------------------------------------

 function[normal_data] =  normalize(data)
 
    min_data = min(data,[],'all');
    max_data = max(data,[],'all');
    
    normal_data = (data - min_data)/(max_data -min_data);
    
 end
    
 function save_ae_in_data(output_ae_test_directory,recording,data_test)
 
    % Output AE Test Data
    output_ae_test_file = ([output_ae_test_directory filesep recording '.csv']);
    fid2 = fopen(output_ae_test_file,'w');
    dlmwrite( output_ae_test_file,data_test,'delimiter',',','-append','precision',4);
    fclose(fid2);
 
end



end
