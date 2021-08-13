% debug
% We are trying to correlate spectrum of two fish
clc
close all
load('../source_tables/tbl_FL.mat');

fish_fillets = {'USDAS156','USDAS153'}; % #9  Very Good in Hossein's   
%fish_fillets  = {'USDAS082','USDAS072'}; % #22 Marginal in Hossein's
%fish_fillets = {'USDAS257','USDAS258'}; % #50 Poor in Hossein's

I = table2cell(tbl_Fluorescence);
debug = 1;
vox_len = size(I,1);
debug = 1;

%I_fill = zeros(40,40,2);
 I_fillet_array = {};
 
 I_fillet_cell_matrix = {};
 
debug = 1;

for m = 1: 2
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
   
   I_fillet_single_matrix = cell2mat(I_fillet_cell_matrix); 
   
   I_fillet_single_matrix_group(:,:,m) =  I_fillet_single_matrix;
   
   debug = 1;
   
   I_fillet_cell_matrix = {};
    %{
    % collect sample fish location
    loc_len = size(sample_fish,2);
    x_loc = {};
    y_loc = {};
    for i = 1 : loc_len
        vox_soi_idx = sample_fish{i};
        x_loc{end+1} = I{vox_soi_idx,70};
        y_loc{end+1} = I{vox_soi_idx,71};
    end

    debug = 1;
    %
    x_loc_mat = cell2mat(x_loc);
    y_loc_mat = cell2mat(y_loc);

    figure
    scatter(x_loc_mat,y_loc_mat,'filled')

    debug = 1;
    % Fill-in; Assume 40*40
    %I_fill = zeros(40,40);
    debug = 1;
    %tic
    for i = 1 :40
        for j = 1 :40
            for k = 1 : loc_len
                recall_idx = sample_fish{k};
                if ( (  I{recall_idx,70}  == i ) && (  I{recall_idx,71} == j  )  )
                    I_fill(i,j,m) = I{recall_idx,10};
                end
           
            end
        end
    end
    %toc
    debug = 1;
    %}
end % fish fillets
debug = 1;
    
crr = xcorr2(I_fill(:,:,1) ,I_fill(:,:,2));
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
text(snd*1.05,ssr,'Maximum')
debug = 1;
