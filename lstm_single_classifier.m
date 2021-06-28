%--------------------------------------------------------------------
% file_name: lstm_single_classifier.m
% author: rbd
% initial data: 3/28/21
% School/class: Univ of North Dakota /Fall 2020 EE999
% Advisors: Dr. Vasefi, Dr. Tavakolian, Dr. Akhbardeh
% Project: Fish ID
% Grant: NOAA
% Description: Classify by select number of fish; No fusion
% .
%--------------------------------------------------------------------
function [done,total_accuracy,ConfusMat] = lstm_single_classifier(mode,rand_seed ...
                                           ,cell_fish_train_directory ...
                                           ,cell_fish_test_directory ...
                                           ,cell_fish_loc_directory ...
                                           ,num_fish,M,show_confusion ...
                                           ,num_random_train_vectors_per_fish ...
                                           ,num_random_test_vectors_per_fish ...
                                           ,flag_loc )
done = 0;


%num_random_train_vectors_per_fish = 40;
size_of_random_train_vectors      = 50;

%num_random_test_vectors_per_fish = 10;
size_of_random_test_vectors      = 50;

input_files = {};

% Choose Spectroscopy amd Train method
input_directory = cell_fish_train_directory{mode} % ANy mode can be used for this line of code
    for f = dir(input_directory)'
        if exist(fullfile(input_directory, f.name), 'file') == 2 && f.name(1) ~= '.' && all(f.name(end - 2 : end) == 'csv')
            input_files{end + 1} = f.name;
        end
    end

total_accuracy = zeros(1,num_fish);

num_files = num_fish
   
   % Randomize fish to analyze
   [input_files_shuffled] = rand_input_files(input_files,rand_seed);  

   % DEBUG TEMPORARY!!
TRAIN = 1;
if TRAIN
%%--------------------------------------
%% Training 
%%--------------------------------------
    input_classify_data  = {};
    input_classify_label = {};   

   disp(' Begin input of CSV files for Classification...')

         input_directory = cell_fish_train_directory{mode}; 
        %input_directory_fl = cell_fish_train_directory{1}; % FL
        %input_directory_ir = cell_fish_train_directory{2}; % IR
        %input_directory_vs = cell_fish_train_directory{3}; % VS
   
   
   for i = 1:num_files
        disp(['  ',num2str(i), '/', num2str(num_files), '...'])
        file_tmp = strsplit(input_files_shuffled{i},'.');    

        tmp_input_file = fullfile(input_directory, file_tmp{1});    
        tmp_input_file2 = strcat(tmp_input_file, '.',file_tmp{2});    
        [data_spec]   = extract_csv_data(tmp_input_file2);
        
        %tmp_input_file_fl = fullfile(input_directory_fl, file_tmp{1});    
        %tmp_input_file2_fl = strcat(tmp_input_file_fl, '.',file_tmp{2});    
        %[data_fl]   = extract_csv_data(tmp_input_file2_fl);
        
        %tmp_input_file_ir = fullfile(input_directory_ir, file_tmp{1});    
        %tmp_input_file2_ir = strcat(tmp_input_file_ir, '.',file_tmp{2});    
        %[data_ir]   = extract_csv_data(tmp_input_file2_ir);
        
        %tmp_input_file_vs = fullfile(input_directory_vs, file_tmp{1});    
        %tmp_input_file2_vs = strcat(tmp_input_file_vs, '.',file_tmp{2});    
        %[data_vs]   = extract_csv_data(tmp_input_file2_vs);
        
        % Find length of rows
        data_row_size = size(data_spec);
        data_row_size = data_row_size(1);
        
        %fl_row_size = size(data_fl);
        %fl_row_size = fl_row_size(1);
        %ir_row_size = size(data_ir);
        %ir_row_size = ir_row_size (1);
        %vs_row_size = size(data_vs);
        %vs_row_size = vs_row_size(1);
        
        rng_index = 0;
        random_temp_array        = {};
        random_temp_array_trans  = {};
        random_temp_array_label  = {};
        
        % Find length of cols % This is our feature size
        data_col_size = size(data_spec);
        data_col_size = data_col_size(2);
        
        %fl_col_size = size(data_fl);
        %fl_col_size = fl_col_size(2);
        %ir_col_size = size(data_ir);
        %ir_col_size = ir_col_size (2);
        %vs_col_size = size(data_vs);
        %vs_col_size = vs_col_size(2);
        
        feature_random_mix_size = data_col_size; 
        %feature_random_mix_size = fl_col_size + ir_col_size + vs_col_size;             
       
        for i2 = 1 : num_random_train_vectors_per_fish
            % Shuffle rows of matrices
            rng(rng_index);          
            random_data = data_spec(randperm(size(data_spec, 1)), :);
            
            %rng(rng_index);          
            %random_fl = data_fl(randperm(size(data_fl, 1)), :);
            %rng(rng_index);
            %random_ir = data_ir(randperm(size(data_ir, 1)), :);
            %rng(rng_index);
           % random_vs = data_vs(randperm(size(data_vs, 1)), :);
            
            % Build vector for this randomization
            for i1 = 1 : size_of_random_train_vectors               
                random_temp_array_data = random_data(i1,:);
                
                %random_temp_array_fl = random_fl(i1,:);
                %random_temp_array_ir = random_ir(i1,:);
                %random_temp_array_vs = random_vs(i1,:);
                
                random_temp_array = random_temp_array_data;
                %random_temp_array = [ random_temp_array_fl random_temp_array_ir random_temp_array_vs];
                input_classify_data{end+1} = random_temp_array';
            end
            label = M(file_tmp{1});
     
            for j = 1 : size_of_random_train_vectors
                input_classify_label{end+1} = label;
            end 
            rng_index = rng_index + 1;
            i2 = i2 + 1;
        end
             
   end % end num_of files loop
      
   % randomize data and labels

   [rand_data, rand_label] = rand_data_label(input_classify_data,input_classify_label); 
  
   rand_label_array        = cell2mat(rand_label);
   
   cell_data_label         = rand_data;
   XTrain                  = cell_data_label';
   category_rand_label     = categorical(rand_label_array);
   YTrain                  = category_rand_label';
   
   debug = 1;
   
   inputSize = feature_random_mix_size;
   
   numHiddenUnits = 100;
   %numClasses = 8;
   numClasses = num_files;

   layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]

   debug = 1;
 
   maxEpochs = 20;
   miniBatchSize = 27;

   options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu', ...
    'GradientThreshold',1, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest', ...
    'Shuffle','never', ...
    'Verbose',0, ...
    'Plots','training-progress');
  
   debug = 1;
   tic
   net = trainNetwork(XTrain,YTrain,layers,options);
   toc
   
   debug = 1;
   
%end   % This is end for loop for train only
% debug = 1;
end % debug skip train
%%--------------------------------------
%% Testing
%%--------------------------------------

    input_classify_data  = {};
    input_classify_label = {};
    
    input_classify_loc_data  = {};
    
    disp(' Begin input of CSV files for Testing of Classification...')

    input_directory = cell_fish_test_directory{mode};
    if flag_loc == 1
        input_loc_directory = cell_fish_loc_directory{mode};
    end
    
   
   for i = 1:num_files
     disp(['  ',num2str(i), '/', num2str(num_files), '...'])
     file_tmp = strsplit(input_files_shuffled{i},'.');     
        
            tmp_input_file = fullfile(input_directory, file_tmp{1});    
            tmp_input_file2 = strcat(tmp_input_file, '.',file_tmp{2});    
            [data_spec]   = extract_csv_data(tmp_input_file2);
            
            if flag_loc == 1
                tmp_input_loc_file = fullfile(input_loc_directory, file_tmp{1});    
                tmp_input_loc_file2 = strcat(tmp_input_loc_file, '.',file_tmp{2});    
                [data_loc_spec]   = extract_csv_data(tmp_input_loc_file2);         
            end
            
            %tmp_input_file_fl = fullfile(input_directory_fl, file_tmp{1});    
            %tmp_input_file2_fl = strcat(tmp_input_file_fl, '.',file_tmp{2});    
            %[data_fl]   = extract_csv_data(tmp_input_file2_fl);
        
            %tmp_input_file_ir = fullfile(input_directory_ir, file_tmp{1});    
            %tmp_input_file2_ir = strcat(tmp_input_file_ir, '.',file_tmp{2});    
            %[data_ir]   = extract_csv_data(tmp_input_file2_ir);
        
            %tmp_input_file_vs = fullfile(input_directory_vs, file_tmp{1});    
            %tmp_input_file2_vs = strcat(tmp_input_file_vs, '.',file_tmp{2});    
            %[data_vs]   = extract_csv_data(tmp_input_file2_vs);
        
            % Find length of rows
            data_row_size = size(data_spec);
            data_row_size = data_row_size(1);
            
            %fl_row_size = size(data_fl);
            %fl_row_size = fl_row_size(1);
            %ir_row_size = size(data_ir);
            %ir_row_size = ir_row_size (1);
            %vs_row_size = size(data_vs);
            %vs_row_size = vs_row_size(1);
        
            rng_index = 0;
            random_temp_array        = {};
            random_temp_array_trans  = {};
            random_temp_array_label  = {};
        
            % Find length of cols % This is our feature size
            data_col_size = size(data_spec);
            data_col_size = data_col_size(2);
            
            %fl_col_size = size(data_fl);
            %fl_col_size = fl_col_size(2);
            %ir_col_size = size(data_ir);
            %ir_col_size = ir_col_size (2);
            %vs_col_size = size(data_vs);
            %vs_col_size = vs_col_size(2);
        
            feature_random_mix_size = data_col_size;
            %feature_random_mix_size = fl_col_size + ir_col_size + vs_col_size;
        

            for i2 = 1 : num_random_test_vectors_per_fish
                 % Shuffle rows of matrices
                 rng(rng_index);
                 random_data = data_spec(randperm(size(data_spec, 1)), :);
                 
                 if flag_loc == 1
                    random_loc_data = data_loc_spec(randperm(size(data_loc_spec, 1)), :); 
                 end
                     
                 %rng(rng_index);
                 %random_fl = data_fl(randperm(size(data_fl, 1)), :);
                 %rng(rng_index);
                 %random_ir = data_ir(randperm(size(data_ir, 1)), :);
                 %rng(rng_index);
                 %random_vs = data_vs(randperm(size(data_vs, 1)), :);
                 % Build vector for this randomization
                 for i1 = 1 : size_of_random_test_vectors
                   random_temp_array_data = random_data(i1,:);
                   %random_temp_array_fl = random_fl(i1,:);
                   %random_temp_array_ir = random_ir(i1,:);
                   %random_temp_array_vs = random_vs(i1,:);
                   random_temp_array = random_temp_array_data;
                   %random_temp_array = [ random_temp_array_fl random_temp_array_ir random_temp_array_vs];
                   input_classify_data{end+1} = random_temp_array';
                   
                   if flag_loc == 1
                       random_temp_array_loc_data = random_loc_data(i1,:);
                       random_temp_loc_array = random_temp_array_loc_data;                     
                       input_classify_loc_data{end+1} = random_temp_loc_array';
                   end
                 end
                 label = M(file_tmp{1});
     
                 for j = 1 : size_of_random_test_vectors
                    input_classify_label{end+1} = label;
                 end 
                 rng_index = rng_index + 1;
                 i2 = i2 + 1;
            end
             
   end % end for:  num_of files loop
   
     
   % randomize data and labels
   [rand_data, rand_label] = rand_data_label(input_classify_data,input_classify_label);  
    if flag_loc == 1
      [rand_loc_data, rand_dummy_label] = rand_data_label(input_classify_loc_data,input_classify_label); 
    end
        
   rand_label_array        = cell2mat(rand_label);
   
   cell_data_label         = rand_data;
   XTest                   = cell_data_label';
   category_rand_label     = categorical(rand_label_array);
   YTest                   = category_rand_label';
   
   debug = 1;

   miniBatchSize = 27;
  
   debug = 1;


   
   [YPred,scores_test] = classify(net,XTest, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest');
    
   
   acc = sum(YPred == YTest)./numel(YTest)
   debug = 1;
   
   total_accuracy(num_files) = acc;
   


debug = 1;
done = 1;

ConfusMat  = confusionmat(YTest,YPred);
if show_confusion == 1
    cm = confusionchart(YTest,YPred);
 
end 

%%--------------------------------------
%% Functions
%%--------------------------------------
function save_wt_data(cell_fish_train_directory,WtVector,mode)
    
   substring1 = cell_fish_train_directory{mode};
   
   substring2 = substring1(1:end-5);
   
   slash_string = '/';

   output_score_directory = strcat(substring2,'Class_Weights');
  
   switch mode
    case 1
        substring3              = 'FL_weights';
    case 2
        substring3              = 'SWIR_weights'; 
    case 3
        substring3              = 'VS_NIR_weights';
   end     
 
    % Output Score Data
    output_weight_file = ([output_score_directory slash_string substring3 '.csv']);
    fid1 = fopen(output_weight_file,'w');
    dlmwrite( output_weight_file,WtVector,'delimiter',',','-append','precision',4);
    fclose(fid1);

end
function save_scores_data(cell_fish_train_directory,scores_train,mode,select)
    
   substring1 = cell_fish_train_directory{mode};
   
   substring2 = substring1(1:end-5);
   
   slash_string = '/';
   
   switch select
       case 1 
          output_score_directory = strcat(substring2,'Class_Fusion');
       case 2
          output_score_directory = strcat(substring2,'Class_Predict');
       case 3
          output_score_directory = strcat(substring2,'Class_True');
       case 4
          output_score_directory = strcat(substring2,'Class_Test_Scores');
       case 5
          output_score_directory = strcat(substring2,'Class_Test_Predict');
       case 6
          output_score_directory = strcat(substring2,'Class_Test_True');
   end
   
   switch mode
    case 1
        substring3              = 'FL_scores';
    case 2
        substring3              = 'SWIR_scores'; 
    case 3
        substring3              = 'VS_NIR_scores';
   end     
 
    % Output Score Data
    output_score_file = ([output_score_directory slash_string substring3 '.csv']);
    fid1 = fopen(output_score_file,'w');
    dlmwrite( output_score_file,scores_train,'delimiter',',','-append','precision',4);
    fclose(fid1);

end

function [rand_out] = rand_input_files(input_files,rand_seed)
    rng(rand_seed);
    input_files_shuffled = randperm(numel(input_files));
    size_array = size(input_files_shuffled);
    size_array = size_array(2);
    rand_cell_array = {};
    for i = 1 :size_array
    	rand_cell_array{end+1} = input_files{input_files_shuffled(i)};
    end
    debug = 1;
    try
        rand_out = rand_cell_array;
    catch ext
        rethrow(ext);
    end
end

function [ rand_data, rand_label] = rand_data_label(input_classify_data,...
                                                    input_classify_label)
                                                
   rand_classify_input_data = {};
   rand_classify_input_label = {};
   dim_array       = size(input_classify_data);
   col_dim_array   = dim_array(2); 
   
   % randomize data entires
   rng(1);
   shuff_array = reshape(randperm(col_dim_array),1,col_dim_array);
   
   debug = 1; 
   
   % rebuild cell array with randomized list 
   for i = 1 : col_dim_array
       index = shuff_array(i);
       rand_classify_input_data{end+1} = input_classify_data{index};
   end
   
   % randomize label entries
   rng(1);
   shuff_array = reshape(randperm(col_dim_array),1,col_dim_array);
   
   for i = 1 : col_dim_array
       index = shuff_array(i);
       rand_classify_input_label{end+1} = input_classify_label{index};
   end
   
   debug = 1;
                                                  
   try
       rand_data = rand_classify_input_data;
       rand_label = rand_classify_input_label;
   catch ext
       rethrow(ex);
   end
   
end


% Repeat three steps above for test data
function [features] = extract_features(data,show_auto_error)

X = data;
autoenc = trainAutoencoder(X);

features_ext = autoenc.EncoderWeights;

try 
    features = features_ext;
    
catch ext
    rethrow(ex);
end


if show_auto_error == 1
    XReconstructed = predict(autoenc,X);
    mseError = mse(X-XReconstructed);

    figure(1);
    plot(data_train,'r.');
    hold on
    plot(XReconstructed,'go');
end

end


 function [data] = extract_csv_data(filename)
     % quirk of usingreadtable; Works with intuitively
     % with 2 colums; So if you use this with a category
     % true label, the csv file needs to have the categories
     % in the first column and a "dummy" second column to work correctly
     T = readtable(filename);    
     T_cell = table2cell(T);
     T_matrix = cell2mat(T_cell(:,2));
     length_matrix = length(T_matrix);

     data_table = T(1:length_matrix,:);

     data_cell  = table2cell(data_table);

     data_matrix = cell2mat(data_cell);

    
    try
        data   = data_matrix;

    catch ex
        rethrow(ex);
    end

 end

end
