% debug
clc
load('../source_tables/tbl_FL.mat');

fish_fillets = {'USDAS257','USDAS258'};

I = table2cell(tbl_Fluorescence);
debug = 1;
vox_len = size(I,1);
debug = 1;

I_fill = zeros(40,40,2);

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
end % fish fillets
debug = 1;
    
xc2 = xcorr2(I_fill(:,:,1) ,I_fill(:,:,2) );
figure 
surf(xc2,'LineStyle','none')
title('Fish xcorr2 func')
debug = 1;
