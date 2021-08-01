%----------------------------------------------------------------------
% filename: corr_data.m
% author: rbd
% date: 7-31-21
%----------------------------------------------------------------------
close all
clear

debug = 1;

% Good Correlation
S142Test = load('../All_FL/FL_Test/USDAS142.csv');
S142Train = load('../All_FL/FL_Train/USDAS142.csv');
S142 = vertcat(S142Test,S142Train);
x = 1:60;
y = 1:60;
[R142,pval142] = corr(S142,S142); % correlate
figure 
surf(R142)

% Possibly Bad Correlation
S143Test = load('../All_FL/FL_Test/USDAS143.csv');
S143Train = load('../All_FL/FL_Train/USDAS143.csv');
S143 = vertcat(S143Test,S143Train);
x = 1:60;
y = 1:60;
[R143,pval143] = corr(S143,S143); % correlate
figure
surf(R143)

S146Test = load('../All_FL/FL_Test/USDAS146.csv');
S146Train = load('../All_FL/FL_Train/USDAS146.csv');
S146 = vertcat(S146Test,S146Train);
x = 1:60;
y = 1:60;
[R146,pval146] = corr(S146,S146); % correlate
figure 
surf(R146)

S147Test = load('../All_FL/FL_Test/USDAS147.csv');
S147Train = load('../All_FL/FL_Train/USDAS147.csv');
S147 = vertcat(S147Test,S147Train);
x = 1:60;
y = 1:60;
[R147,pval147] = corr(S147,S147); % correlate
figure 
surf(R147)

S53Test = load('../All_FL/FL_Test/USDAS053.csv');
S53Train = load('../All_FL/FL_Train/USDAS053.csv');
S53 = vertcat(S53Test,S53Train);
x = 1:60;
y = 1:60;
[R53,pval53] = corr(S53,S53); % correlate
figure 
surf(R53)

S81Test = load('../All_FL/FL_Test/USDAS081.csv');
S81Train = load('../All_FL/FL_Train/USDAS081.csv');
S81 = vertcat(S81Test,S81Train);
x = 1:60;
y = 1:60;
[R81,pval81] = corr(S81,S81); % correlate
figure 
surf(R81)

S82Test = load('../All_FL/FL_Test/USDAS082.csv');
S82Train = load('../All_FL/FL_Train/USDAS082.csv');
S82 = vertcat(S82Test,S82Train);
x = 1:60;
y = 1:60;
[R82,pval82] = corr(S82,S82); % correlate
figure 
surf(R82)

S83Test = load('../All_FL/FL_Test/USDAS083.csv');
S83Train = load('../All_FL/FL_Train/USDAS083.csv');
S83 = vertcat(S83Test,S83Train);
x = 1:60;
y = 1:60;
[R83,pval83] = corr(S83,S83); % correlate
figure 
surf(R83)

S89Test = load('../All_FL/FL_Test/USDAS089.csv');
S89Train = load('../All_FL/FL_Train/USDAS089.csv');
S89 = vertcat(S89Test,S89Train);
x = 1:60;
y = 1:60;
[R89,pval89] = corr(S89,S89); % correlate
figure 
surf(R89)

% Debug
test = rand(940,60);
x = 1:60;
y = 1:60;
[Rtest,pvaltest] = corr(test,test); % correlate
figure 
surf(Rtest)

debug = 1;

 

