% debug
% We are trying to correlate spectrum of two fish
clc
close all
load('../source_tables/tbl_FL.mat');

%fish_fillets = {'USDAS156','USDAS153'}; % #9  Very Good in Hossein's   
%fish_fillets  = {'USDAS082','USDAS072'}; % #22 Marginal in Hossein's
%fish_fillets = {'USDAS257','USDAS258'}; % #50 Poor in Hossein's
%fish_fillets = {'USDAS257','USDAS259'}; % #50 Poor in Hossein's
%fish_fillets = {'USDAS257','USDAS260'}; % #50 Poor in Hossein's
%fish_fillets = {'USDAS258','USDAS259'}; % #50 Poor in Hossein's
%fish_fillets = {'USDAS258','USDAS260'}; % #50 Poor in Hossein's
fish_fillets = {'USDAS259','USDAS260'}; % #50 Poor in Hossein's

I = table2cell(tbl_Fluorescence);
debug = 1;
vox_len = size(I,1);
debug = 1;

%I_fill = zeros(40,40,2);
 I_fillet_array = {};
 
 I_fillet_cell_matrix = {};
 
debug = 1;

%for m = 1: 2
%---------------------
% Format 1st fish
%---------------------
m = 1;
    sample_fish = {};
    for i = 1: vox_len
        sample = fish_fillets{m};
        if strcmp(I{i,1},sample)
            sample_fish{end+1} = i;
        end
    end
    debug = 1;
    
   sample_vox_length = size(sample_fish,2);
   for i = 1 : sample_vox_length
       for j = 10 : 69
           I_fillet_array{end+1} = I{ sample_fish{i},j};
       end
   end
   
   debug = 1;
   
   % Put cell array into a matrix
   % Need to fix error when we try to get second fish and use reshape
   I_fillet_cell_matrix = reshape(I_fillet_array,60,sample_vox_length);
   
   debug = 1;
   
   I_fillet_1st_matrix = cell2mat(I_fillet_cell_matrix); 
   
   %I_fillet_single_matrix_group(:,:,m) =  I_fillet_single_matrix;
   
   debug = 1;
   
   I_fillet_cell_matrix = {};
   I_fillet_array = {}

%end % fish fillets
%---------------------
% Format 2nd fish
%---------------------
m = 2;
    sample_fish = {};
    for i = 1: vox_len
        sample = fish_fillets{m};
        if strcmp(I{i,1},sample)
            sample_fish{end+1} = i;
        end
    end
    debug = 1;
    
   sample_vox_length = size(sample_fish,2);
   for i = 1 : sample_vox_length
       for j = 10 : 69
           I_fillet_array{end+1} = I{ sample_fish{i},j};
       end
   end
   
   debug = 1;
   
   % Put cell array into a matrix
   % Need to fix error when we try to get second fish and use reshape
   I_fillet_cell_matrix = reshape(I_fillet_array,60,sample_vox_length);
   
   debug = 1;
   
   I_fillet_2nd_matrix = cell2mat(I_fillet_cell_matrix); 
   
   %I_fillet_single_matrix_group(:,:,m) =  I_fillet_single_matrix;
   
   debug = 1;
   
   I_fillet_cell_matrix = {};
   I_fillet_array = {}

debug = 1;
    
%crr = xcorr2(I_fill(:,:,1) ,I_fill(:,:,2));
crr   = xcorr2(I_fillet_1st_matrix ,I_fillet_2nd_matrix);
%{
figure 
surf(xc2,'LineStyle','none')
title('Fish xcorr2 func')
%}

[ssr,snd] = max(crr(:));
[ij,ji] = ind2sub(size(crr),snd);

figure
plot(crr(:))
title('Cross-Correlation')
hold on
plot(snd,ssr,'or')
hold off
%text(snd*1.05,ssr,'Maximum')
debug = 1;
