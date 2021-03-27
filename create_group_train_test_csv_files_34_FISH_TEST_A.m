%----------------------------------------------------------------------
% filename: create_group_train_test_csv_files.m
% author: rbd
% 3/20/21 
% descr: auto create train and test extracted from tables
% Run #34A 
%---------------------------------------------------------------------
% Test 
B = {'USDAS121','USDAS122','USDAS123','USDAS124','USDAS125', ...
     'USDAS126','USDAS127','USDAS149','USDAS153','USDAS157', ...
     'USDAS169','USDAS173','USDAS031','USDAS032','USDAS033', ...
     'USDAS035','USDAS036','USDAS037','USDAS038','USDAS040', ...
     'USDAS061','USDAS062','USDAS063','USDAS064','USDAS065', ...
     'USDAS066','USDAS067','USDAS068','USDAS069','USDAS070', ...
     'USDAS098','USDAS094','USDAS165','USDAS177'};
 
 % Train to be grouped
C = {'USDAS128','USDAS135','USDAS142', ...
     'USDAS129','USDAS136','USDAS143', ...
     'USDAS130','USDAS137','USDAS144', ...
     'USDAS131','USDAS138','USDAS145', ...
     'USDAS132','USDAS139','USDAS146', ...
     'USDAS133','USDAS140','USDAS147', ...
     'USDAS134','USDAS141','USDAS148', ...
     'USDAS150','USDAS151','USDAS152', ...
     'USDAS154','USDAS155','USDAS156', ...
     'USDAS158','USDAS159','USDAS160', ...
     'USDAS170','USDAS171','USDAS172', ...
     'USDAS174','USDAS175','USDAS176', ...
     'USDAS051','USDAS051','USDAS041', ...
     'USDAS052','USDAS052','USDAS042', ...
     'USDAS053','USDAS053','USDAS043', ...    
     'USDAS055','USDAS055','USDAS045', ...
     'USDAS056','USDAS056','USDAS046', ...
     'USDAS057','USDAS057','USDAS047', ...
     'USDAS058','USDAS058','USDAS048', ...
     'USDAS060','USDAS060','USDAS050', ...    
     'USDAS081','USDAS081','USDAS071', ...
     'USDAS082','USDAS082','USDAS072', ...
     'USDAS083','USDAS083','USDAS073', ...
     'USDAS084','USDAS084','USDAS074', ...
     'USDAS085','USDAS085','USDAS075', ...   
     'USDAS086','USDAS086','USDAS076', ...
     'USDAS087','USDAS087','USDAS077', ...
     'USDAS088','USDAS088','USDAS078', ...
     'USDAS089','USDAS089','USDAS079', ...
     'USDAS090','USDAS090','USDAS080', ...   
     'USDAS102','USDAS102','USDAS101', ...
     'USDAS105','USDAS105','USDAS106', ...
     'USDAS166','USDAS166','USDAS167', ...
     'USDAS178','USDAS178','USDAS179'}; % Note repeated 'USDAS184' & 'USDAS183'

 group                     =  3;

 
  num_fish = 34; 
         
  fish_value = [ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 ...
                 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 ...
                 31 32 33 34];

  fish_name = char('coho salmon''chinook_salmon',...
                   'sockeye_salmon','rock_fish',...
                   'pacific_halibut','pacific_cod',...
                   'sablefish','yellow_eye_rockfish',...
                   'calif_flounder','opah');
                   
  M = containers.Map(B,fish_value); 
%-------------------------------------------------------------------------
% Training              Training             Training            
%-------------------------------------------------------------------------
 
%----------------------
% Train Vis Load Table
%----------------------
load('../tables_with_single_split/table_train_vis.mat');
T                         = table_train_VIS;
dir_data_file             =  '../All_VS/VS_Train';
dir_count_file            =  '../All_VS';
count_file_name           =  'vs_train_count';
spectra_low_col           = 10;
spectra_high_col          = 134;

norm                      = 0;


[ done] = create_group_train_csv_files_func(T,...
                   dir_data_file,dir_count_file,count_file_name,...
                   B,C,spectra_low_col,spectra_high_col,group,norm);
               
disp('Done with VS Train Processing');

%----------------------
% Train IR Load Table
%----------------------
load('../tables_with_single_split/table_train_SWIR.mat');
T                         = table_train_SWIR;
dir_data_file             =  '../All_IR/IR_Train';
dir_count_file            =  '../All_IR';
count_file_name           =  'ir_train_count';
spectra_low_col           = 10;
spectra_high_col          = 125;

norm                      = 0;

[ done] = create_group_train_csv_files_func(T,...
                   dir_data_file,dir_count_file,count_file_name,...
                   B,C,spectra_low_col,spectra_high_col,group,norm);

disp('Done with IR  Train Processing');

%----------------------
% Train FL Load Table
%----------------------
load('../tables_with_single_split/table_train_FL.mat');
T                         = table_train_FL;
dir_data_file             =  '../All_FL/FL_Train';
dir_count_file            =  '../All_FL';
count_file_name           =  'fl_train_count';
spectra_low_col           = 10;
spectra_high_col          = 69;

norm                      = 1;

[ done] = create_group_train_csv_files_func(T,...
                   dir_data_file,dir_count_file,count_file_name,...
                   B,C,spectra_low_col,spectra_high_col,group,norm);
               
disp('Done with FL Train Processing');
               
debug = 1;

%-------------------------------------------------------------------------
% Testing              Testing             Testing            
%-------------------------------------------------------------------------

%----------------------
% Test Vis Load Table
%----------------------
load('../tables_with_single_split/table_test_vis.mat');
T                         = table_test_VIS;
dir_data_file             =  '../All_VS/VS_Test';
dir_count_file            =  '../All_VS';
count_file_name           =  'vs_test_count';
spectra_low_col           = 10;
spectra_high_col          = 134;

norm                      = 0;

[ done] = create_test_csv_files_func(T,...
                   dir_data_file,dir_count_file,count_file_name,...
                   B,spectra_low_col,spectra_high_col,norm);
               
disp('Done with VS Test Processing');

debug = 1;

%----------------------
% Test IR Load Table
%----------------------
load('../tables_with_single_split/table_test_SWIR.mat');
T                         = table_test_SWIR;
dir_data_file             =  '../All_IR/IR_Test';
dir_count_file            =  '../All_IR';
count_file_name           =  'ir_test_count';
spectra_low_col           = 10;
spectra_high_col          = 125;

norm                      = 0;

[ done] = create_test_csv_files_func(T,...
                   dir_data_file,dir_count_file,count_file_name,...
                   B,spectra_low_col,spectra_high_col,norm);
               
disp('Done with IR Test Processing');

debug = 1;

%----------------------
% Test FL Load Table
%----------------------
load('../tables_with_single_split/table_test_FL.mat');
T                         = table_test_FL;
dir_data_file             =  '../All_FL/FL_Test';
dir_count_file            =  '../All_FL';
count_file_name           =  'fl_test_count';
spectra_low_col           = 10;
spectra_high_col          = 69;

norm                      = 1;

[ done] = create_test_csv_files_func(T,...
                   dir_data_file,dir_count_file,count_file_name,...
                   B,spectra_low_col,spectra_high_col,norm);
               
disp('Done with FL Test Processing');

debug = 1;
               
