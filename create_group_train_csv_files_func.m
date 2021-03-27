%----------------------------------------------------------------------
% filename: create_group_train_csv_files_func.m
% author: rbd
% 3/7/21 
% descr: group train files and name same as test
%---------------------------------------------------------------------
function [ done] = create_group_train_csv_files_func(T,...
                   dir_data_file,dir_count_file,count_file_name,...
                   B,C,spectra_low_col,spectra_high_col,group,norm)
               
done = 0;

% Load Table
%load(table);
%T = table_train_VIS;

T_cell = table2cell(T);

% Constant Strings
output_ae_test_directory =  dir_data_file;
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
count = 0;

temp_group_matrix = [];
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
            %temp_matrix     = cell2mat(temp_cell_matrix);
            temp_matrix = [temp_cell_matrix{:}];
            temp_acc_matrix = cat(1,temp_acc_matrix,temp_matrix);
            temp_cell_matrix = {};
        end
    end
    % Acc mult subjects
    if m <= group
        temp_group_matrix = cat(1,temp_group_matrix,temp_acc_matrix);
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
        
           m = 0; % init grouping index
    
        end
       
    end    
    
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
