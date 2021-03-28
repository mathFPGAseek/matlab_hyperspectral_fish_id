%----------------------------------------------------------------------
% filename: create_group_train_test_csv_files.m
% author: rbd
% 3/27/21 
% descr: auto create train and test extracted from tables
% Run #34D 
%---------------------------------------------------------------------
% Test 
B = {'USDAS142','USDAS143','USDAS144','USDAS145','USDAS146', ...
     'USDAS147','USDAS148','USDAS152','USDAS156','USDAS160', ...
     'USDAS172','USDAS176','USDAS051','USDAS052','USDAS053', ...
     'USDAS055','USDAS056','USDAS057','USDAS058','USDAS060', ...
     'USDAS081','USDAS082','USDAS083','USDAS084','USDAS085', ...
     'USDAS086','USDAS087','USDAS088','USDAS089','USDAS090', ...
     'USDAS102','USDAS105','USDAS166','USDAS178'};
 
 % Train to be grouped
C = {'USDAS135','USDAS128','USDAS142', ...
     'USDAS122','USDAS129','USDAS136', ...
     'USDAS123','USDAS130','USDAS137', ...
     'USDAS124','USDAS131','USDAS138', ...
     'USDAS125','USDAS132','USDAS139', ...
     'USDAS126','USDAS133','USDAS140', ...
     'USDAS127','USDAS134','USDAS141', ...
     'USDAS149','USDAS150','USDAS151', ...
     'USDAS153','USDAS154','USDAS155', ...
     'USDAS157','USDAS158','USDAS159', ...
     'USDAS169','USDAS170','USDAS171', ...
     'USDAS173','USDAS174','USDAS175', ...
     'USDAS041','USDAS041','USDAS031', ...
     'USDAS042','USDAS042','USDAS032', ...
     'USDAS043','USDAS043','USDAS033', ...    
     'USDAS045','USDAS045','USDAS035', ...
     'USDAS046','USDAS046','USDAS036', ...
     'USDAS047','USDAS047','USDAS037', ...
     'USDAS048','USDAS048','USDAS038', ...
     'USDAS050','USDAS050','USDAS040', ...    
     'USDAS071','USDAS071','USDAS061', ...
     'USDAS072','USDAS072','USDAS062', ...
     'USDAS073','USDAS073','USDAS063', ...
     'USDAS074','USDAS074','USDAS064', ...
     'USDAS075','USDAS075','USDAS065', ...   
     'USDAS076','USDAS076','USDAS066', ...
     'USDAS077','USDAS077','USDAS067', ...
     'USDAS078','USDAS078','USDAS068', ...
     'USDAS079','USDAS079','USDAS069', ...
     'USDAS080','USDAS080','USDAS070', ...   
     'USDAS101','USDAS101','USDAS098', ...
     'USDAS106','USDAS106','USDAS094', ...
     'USDAS167','USDAS167','USDAS165', ...
     'USDAS179','USDAS179','USDAS177'}; % Note repeated 'USDAS184' & 'USDAS183'

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
load('../tables_with_single_split/tbl_vis.mat');
T                         = tbl_vis;
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
load('../tables_with_single_split/tbl_SWIR.mat');
T                         = tbl_SWIR;
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
load('../tables_with_single_split/tbl_FL.mat');
T                         = tbl_Fluorescence;
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
load('../tables_with_single_split/tbl_vis.mat');
T                         = tbl_vis;
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
load('../tables_with_single_split/tbl_SWIR.mat');
T                         = tbl_SWIR;
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
load('../tables_with_single_split/tbl_FL.mat');
T                         = tbl_Fluorescence;
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
               
