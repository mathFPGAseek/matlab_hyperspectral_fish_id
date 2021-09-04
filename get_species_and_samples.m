% To get all the species and corresponding fish species
clc
load('../source_tables/tbl_FL.mat');

file_destination = '../species_and_samples.csv';

% For all the unique fish species
% Key is species name and value is array of corresponding samples
fish_species = containers.Map('KeyType','char','ValueType','any');

% Fluorescence size: 91646 x 71
I = table2cell(tbl_FL);
vox_len = size(I,1); % 91646

% Assumption: caseID of the table is sorted
for i=1:vox_len
    % If species exists
    % name_and_order = I{i,3}+'_'+I{i,4};
    name_and_order = I{i,3};
    if (strcmp(name_and_order, ""))
        name_and_order = "(Empty string)";
    end
    if (isKey(fish_species, name_and_order))
        fish_array = fish_species(name_and_order);
        if (~strcmp(fish_array{end}, I{i,1}))
            fish_array{end+1} = I{i,1};
        end
        fish_species(name_and_order) = fish_array;
    else
        fish_species(name_and_order) = {I{i,1}};
    end
end

% Get all the fish species names
fish_names = keys(fish_species);

% Create array to output
fish_species_table = {};
fish_species_table{1,1}='DNA Name';
fish_species_table{1,2}='caseIDs';

for i=1:length(fish_names)
    name = fish_names{i};
    disp(name);
    
    samples = fish_species(name);
    for j=1:length(samples)
        disp(samples{j});
    end
    disp('------------');
    
    % For the cell array
    fish_species_table{i+1,1} = name;
    for j=1:length(samples)
        fish_species_table{i+1,j+1}=samples{j};
    end
end

% Write to file
writecell(fish_species_table, file_destination);
