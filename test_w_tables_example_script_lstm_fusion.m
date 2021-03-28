%----------------------------------------------------------------------
% filename: test_w_tables_example_script_ltsm_fusion.m
% author: rbd
% 3/20/21 
% descr: Classify with LSTM Neural Net.
%---------------------------------------------------------------------
% Define input  train data.
cell_fish_train_directory = {'../All_FL/FL_Train',...
                             '../All_IR/IR_Train',...
                             '../All_VS/VS_Train'};
                   
 cell_fish_test_directory = {'../All_FL/FL_Test',...
                             '../All_IR/IR_Test',...
                             '../All_VS/VS_Test'};
%------------------------
%% Process Parameters 
%------------------------
fusion = 0; % Single: fusion = 0; Multi: fusion = 1;
mode   = 1; % FL = 1; SWIR = 2; VS-NIR = 3; Fusion = 3( used for testing)

window_dim = 10; % 10x10 window for outliers
Experiments = 1;
%define_all_table_package;
num_random_train_vectors_per_fish = 40; % use x100 random samples
num_random_test_vectors_per_fish = 10;  % use x100 random samples


%^^^^^^^^^^^^^^^^^^^^^^
% Functions 
%~~~~~~~~~~~~~~~~~~~~~
aoc           =    1;   %   ON/Fusion   = 1; On/Single =  0; skip = -1 
box_plot      =   -1;   %   ON/mult exp = 1; On/Single =  0; skip = -1 

%------------------------
%% Classify lstm_fusion_classifier
%------------------------
AccumConfusMat = [];
rand_seed_set = [ 55 60 65 70];
show_confusion = 1;


  for i = 1 : Experiments 
      rand_seed = rand_seed_set(i);
     if fusion == 1 
          [done,total_accuracy,ConfusMat] = lstm_fusion_classifier(mode,rand_seed ...
                                           ,cell_fish_train_directory ...
                                           ,cell_fish_test_directory ...
                                           ,num_fish,M,show_confusion ...
                                           ,num_random_train_vectors_per_fish ...
                                           ,num_random_test_vectors_per_fish)
                                       
     else
           [done,total_accuracy,ConfusMat] = lstm_single_classifier(mode,rand_seed ...
                                           ,cell_fish_train_directory ...
                                           ,cell_fish_test_directory ...
                                           ,num_fish,M,show_confusion ...
                                           ,num_random_train_vectors_per_fish ...
                                           ,num_random_test_vectors_per_fish)
     end
         
      AccumConfusMat{end+1} = ConfusMat; % For multiple homogenous(same spec tests)
  end

debug = 1;


%------------------------
%% Calculate AOC,FP,and FN by Spectroscopy mode
%------------------------
%
if aoc == 1
     show_roc = 0;
    [done,sens,spec] = fusion_calc_aoc(AccumConfusMat);
    debug = 1;
elseif aoc == 0
    [done,sens,spec] = single_calc_aoc(mode);
    debug = 1;
    
else
    null = 0;
end

%------------------------
%% Generate Box plot by spectroscopy mode
%------------------------
%??? fix boxplot
if box_plot == 1
    debug = 1;

    [done] = boxPlotFish(fish_name,Experiments,AccumConfusMat,num_fish,mode,window_dim,box_plot);
    debug = 1;
elseif box_plot == 0
    [done] = boxPlotFish(fish_name,Experiments,AccumConfusMat,num_fish,mode,window_dim,box_plot);
    null = 0;
end
debug = 1;
%------------------------
%% Calc Specificity and sensitivity
%------------------------
%stats = confusionmatStats(ConfusMat);
%debug = 1;

