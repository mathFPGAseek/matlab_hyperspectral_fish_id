% debug
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

I_fill = zeros(40,40,2);

debug = 1;
%points = 9; don't define here

spectra_index = {};
spectra_values = {};

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
    
    % Calculate the centroid of each fish
    [x_avg,y_avg] = calcCentroid(x_loc_mat,y_loc_mat);
    
    figure
    scatter(x_loc_mat,y_loc_mat,'filled')
    
    % Collect points aroung centroid
    [x_valid,y_valid] = collectPoints(x_avg,y_avg,x_loc_mat,y_loc_mat)
    
    % Gather indices around centroid
     %if err == 0
        [output,output_count] = formMatrixCentroid(x_valid,y_valid,x_loc_mat,y_loc_mat);
     %else
     %    disp('Error, Did not get enough valid samples');
     %end
     
     
     debug = 1;
        
     % collect spectra index
     for i = 1 : output_count
         spectra_index{end+1} = sample_fish{output(i)};
     end
     
     % collect spectra 
     for j = 1 : output_count
      temp = spectra_index{j};   
      spectra_values{end+1} = I{temp,10};
     end
     
     debug = 1;
     
     spectra_values_mat = double(cell2mat(spectra_values));
     %collect spectra of two fish to correlate
     % hackey way
     if m == 1
        I_sample1_spectra(:) = spectra_values_mat;
     else
        I_sample2_spectra(:) = spectra_values_mat;
     end
             
    debug = 1;
 
    % clear for loop
    spectra_index = {};
    spectra_values = {};
  
end % fish fillets
debug = 1;
% reshape for correlation
I_sample2_spectra_padded
[c,lags] = xcorr(I_sample1_spectra,I_sample2_spectra,0,'normalized') % correlate
debug = 1;
figure 
stem(lags,c)

debug = 1;

%--------------------------------------------------------------------------
%% Funtions
%--------------------------------------------------------------------------
function [ output_matrix_1, out_matrix_2] = reshapeMatrix(input_array_1,input_array_2)

    len_1 = size(input_array_1,2);
    len_2 = size(input_array_2,2);

    min_len = min(len_1,lenn_2);

    switch min_len
        
        case 9:15
            %??? Need to truncate values
            output_matrix_1 = reshape(input_array_1,[3,3]);
            output_matrix_2 = reshape(input_array_2,[3,3]);
 
        case 16:24
            output_matrix_1 = reshape(input_array_1,[4,4]);
            output_matrix_2 = reshape(input_array_2,[4,4]);
            
        otherwise 
            disp('Error')
    
    end




end

function[output_index,output_index_count] = formMatrixCentroid(x_valid,y_valid,x_loc_mat,y_loc_mat)

length = size(x_valid,2);
valid_index = {};
 for k = 1 : length
    x_index_valid = x_valid{k};
    y_index_valid = y_valid{k};
    
    x_index_loc_mat = find(x_index_valid == x_loc_mat);
    y_index_loc_mat = find(y_index_valid == y_loc_mat);
    
    x_index_loc_mat_size = size(x_index_loc_mat,2);
    y_index_loc_mat_size = size(y_index_loc_mat,2);
    
    
    for i = 1 : x_index_loc_mat_size
        for j = 1 : y_index_loc_mat_size
            if x_index_loc_mat(i) == y_index_loc_mat(j)
                debug = 1;
                valid_index{end+1} = x_index_loc_mat(i);
                debug = 1;
            end
        end
    end
    
   debug = 1;
 end
 valid_index_mat = cell2mat(valid_index);
 output_index = valid_index_mat;
 output_index_count = size(output_index,2);
 debug = 1;
end

function[x_avg,y_avg] = calcCentroid(x_loc,y_loc)
    % Decr: This computes a standard centroid
    len_x = size(x_loc,2);
    len_y = size(y_loc,2);
    x_avg = (sum(x_loc))/len_x;
    y_avg = (sum(y_loc))/len_y;

end

function[x_valid,y_valid] = collectPoints(xavg,yavg,x_loc_mat,y_loc_mat)
   % Decr: This function collects points starting in the 
   % upper left hand corner of a center point and then 
   % creates a 5x5 gird and sweeps across it(grid) trying
   % to collect atleast 9 valid points
   
   %points_valid = 9; % Don't need grab as many valid as you can in 5x5
   % Define grid points
   grid_points = 25;
   length = size(x_loc_mat,2);
   
    xavg_int = round(xavg);
    yavg_int = round(yavg);
    
    % start point of a 5x5 square around centriod - Upper left hand
    i_center = xavg_int;
    j_center = yavg_int;
    
    x_valid = {};
    y_valid = {};
    % Define grid
    i_incr = [ -2 -1 0 1 2  ...
               -2 -1 0 1 2  ...
               -2 -1 0 1 2  ...
               -2 -1 0 1 2  ...
               -2 -1 0 1 2];

           
    j_incr = [2 2 2 2 2 ...
              1 1 1 1 1 ...
              0 0 0 0 0 ...
              -1 -1 -1 -1 -1 ...
              -2 -2 -2 -2 -2];
           
    incr_index = 0;
    k = 0;
    debug_count = 0;
    %while  k < 9
    while incr_index < grid_points
          incr_index = incr_index + 1;
          i = i_center + i_incr(incr_index);
          j = j_center + j_incr(incr_index);
        
          index_x = find(i == x_loc_mat);
          index_y = find(j == y_loc_mat);
          x_not_empty = ~(isempty(index_x));
          y_not_empty = ~(isempty(index_y));
          % debug
          if (( i == 16) && ( j == 29))
              debug = 1;
          end
          if (x_not_empty & y_not_empty)
              x_valid{end+1} = i;
              y_valid{end+1} = j;
              %k = k + 1; Don't need
          end
          debug_count = debug_count + 1;
          debug = 1;
          
    end      
              
    debug = 1;
    %end
    %{
    if k < 9
        err = 1;
    else 
        err = 0;
    end
    %}
    % Given x_valid and y_valid find the corresponding  index that
    % matches x_valid to x_loc_mat and y_valid to y_loc_mat
    % these indexs contain the index of our table that containts
    % our spectra
    %{
    for m = 1 : points_valid
        index_little_array_x = x_valid{m};
        index_little_array_y = y_valid{m};
        for n = 1: length
            index_big_array_x = find(index_little_array_x  == x_loc_mat);
            index_big_array_y = find(index_little_array_y  == y_loc_mat);
            if 
     %}   

end
