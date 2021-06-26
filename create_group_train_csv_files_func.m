%----------------------------------------------------------------------
% filename: create_group_train_csv_files_func.m
% author: rbd
% 3/7/21 
% descr: group train files and name same as test
% Theory of Operation:
% The two for loops control the main flow of processing. The first for 
% loop will parse the entire table for the length of the cell C, which
% is our list of all fish that are to be trained. This variable, "i" then
% becomes C{i} or the filets that we are looking for in our table. After 
% that control passes over to the j for loop, and we will parse the
% first column of the entire spectroscopy table looking for our fish
% species, identified as C{i}. We will now start to accumulate all of the
% spectra, and for IR, the locations into an array. When we have parsed the
% first column for our fish of interest C{i}, we will now write that out
% to a specified file in a specified directory.
%---------------------------------------------------------------------
function [ done] = create_group_train_csv_files_func(T,...
                   dir_data_file,dir_loc_file,dir_count_file,count_file_name,...
                   B,C,spectra_low_col,spectra_high_col,group,norm,flag_loc)
               
done = 0;

% Load Table
%load(table);
%T = table_train_VIS;

T_cell = table2cell(T);

% Constant Strings
output_ae_test_directory     =  dir_data_file;
output_ae_test_loc_directory =  dir_loc_file;
output_ae_test_count     =  dir_count_file;
vs_train_count           =  count_file_name;
spacer_string = '.....';


len_B = size(B);
len_B = len_B(2);


% How many of each species
len_col = size(T_cell);
len_col = len_col(1);

len_species = size(C);
len_species = len_species(2);

% Initialize
temp_cell_matrix = {}; % temporary copy of one sample
temp_matrix = [];
temp_acc_matrix = [];
temp_cell_loc_matrix = {}; % temporary copy of one sample
temp_loc_matrix = [];
temp_acc_loc_matrix = [];
count = 0;

temp_group_matrix = [];
temp_group_loc_matrix = [];
m = 0; % for grouping
p = 0; % To display grouping count

for i = 1 : len_species
    for j = 1 : len_col
        contents = T_cell{j,1};
        if contents == C{i}
            count = count + 1;
            for k = spectra_low_col : spectra_high_col 
              temp_cell_matrix{end + 1} = T_cell{j,k};
            end 
            temp_matrix = [temp_cell_matrix{:}];
            temp_acc_matrix = cat(1,temp_acc_matrix,temp_matrix);
            temp_cell_matrix = {};
            if flag_loc == 1
                for q = spectra_high_col+1 : spectra_high_col+2
                    temp_cell_loc_matrix{end + 1} = T_cell{j,q};
                end
                temp_loc_matrix = [temp_cell_loc_matrix{:}];
                temp_acc_loc_matrix = cat(1,temp_acc_loc_matrix,temp_loc_matrix);
                temp_cell_loc_matrix = {};
            end
        end
    end
    % Acc mult subjects
    if m <= group
        temp_group_matrix     = cat(1,temp_group_matrix,temp_acc_matrix);
        if flag_loc == 1
             temp_group_loc_matrix = cat(1,temp_group_loc_matrix,temp_acc_loc_matrix);
        end
        m = m + 1;
        
        message = [' Group subject' C{i} ];
        disp(message);
        
        if m == group % m should not exceed 3     
           p = p + 1;
           
           message_count = [ spacer_string ' ' num2str(p) ' / ' num2str(len_B)];
           disp(message_count);
           %message_done  = [ 'Completed grouping'];
           %disp(spacer_string);
           %disp(spacer_string);
           
           if norm == 1
              [temp_group_matrix] = normalize(temp_group_matrix);
           end 
        
           % Write Test file
           n = i/group; % to group with same name as test for classification
           save_ae_in_data(output_ae_test_directory,B{n},temp_group_matrix)
           temp_group_matrix = [];
           
           if flag_loc == 1
               save_ae_in_data(output_ae_test_loc_directory,B{n},temp_group_loc_matrix)
               temp_group_loc_matrix = [];
           end
        
           m = 0; % init grouping index
    
        end
       
    end    
    temp_acc_loc_matrix = [];
    temp_acc_matrix = [];
    Count_for_species(i) = count;
    count = 0;
end
% Write counts for each species 
save_ae_in_data(output_ae_test_count,vs_train_count,Count_for_species)

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
