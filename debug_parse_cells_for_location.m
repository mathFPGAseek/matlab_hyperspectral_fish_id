%
%
% XYLocResultsTest 1x2 cell {[X] [Y] 'sample'} { '1 or 0'}

%{
temp4 =  XYLocResultsTest{1}(1)
temp5 =  XYLocResultsTest{1}{1}
temp6 =  XYLocResultsTest{1}{1}{1}
temp7 =  XYLocResultsTest{1}{1}{2}
temp8 =  XYLocResultsTest{1}{1}{3}
temp9 =  XYLocResultsTest{1}{2}

debug = 1;
%}
% 
xloc = {};
yloc = {}
correct = {};
match_sample = 'USDAS185';
% Parse cell strucutre for fish to be plotted
for i = 1 : 51000
    if (XYLocResultsTest{i}{1}{3} == match_sample)
        xloc{end+1} = XYLocResultsTest{i}{1}{1};
        yloc{end+1} = XYLocResultsTest{i}{1}{2};
        correct{end+1} =  XYLocResultsTest{i}{2};
    end
    
end
debug = 1;
% Put cells into an array
%xloc_mat = cell2mat(xloc);
%yloc_mat = cell2mat(yloc);
x_ok_loc  = {};
y_ok_loc  = {};
x_nok_loc = {};
y_nok_loc = {};
for i = 1:1000
    if( correct{i} == '1')
        x_ok_loc{end+1} = xloc{i};
        y_ok_loc{end+1} = yloc{i};
    else
        x_nok_loc{end+1} = xloc{i};
        y_nok_loc{end+1} = yloc{i};
        
    end
end
debug = 1;
% Put cells into an array
x_ok_loc_mat = cell2mat(x_ok_loc);
y_ok_loc_mat = cell2mat(y_ok_loc);

x_nok_loc_mat = cell2mat(x_nok_loc);
y_nok_loc_mat = cell2mat(y_nok_loc);

debug = 1;
% plot results
scatter(x_ok_loc_mat,y_ok_loc_mat,'filled')
%set(gca,'YDir','reverse')
hold
scatter(x_nok_loc_mat,y_nok_loc_mat)
set(gca,'YDir','reverse')


debug = 1;
% Debug
%x_ok_coord = find(x_ok_loc_mat == 10)
%y_ok_coord = find(y_ok_loc_mat == 30)
x_nok_coord = find(x_nok_loc_mat == 10)
y_nok_coord = find(y_nok_loc_mat == 30)

debug = 1;


