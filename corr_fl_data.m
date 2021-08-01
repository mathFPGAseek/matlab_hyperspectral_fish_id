%----------------------------------------------------------------------
% filename: corr_fl_data.m
% author: rbd
% date: 7-31-21
% Description: Experiments with 51 A
%------------------
% Good :  
% Look nominal : Figures 1,2,3,4; { 142(1)/156(9)/051(13)/201(39)}
%------------------
% Potential Bad :
% Look nominal:  Figures 5,9,15,20
% Look mediocre: Figures 7,11,13,14,18:
% Look poor: Figures 6,8,10,12,16,17,19
%
%----------------------------------------------------------------------
close all
clear

tic
% Good Correlation
S142Test = load('../All_FL/FL_Test/USDAS142.csv');
S142Train = load('../All_FL/FL_Train/USDAS142.csv');
S142 = vertcat(S142Test,S142Train);
len = size(S142,1);
x = 1:len;
y = 1:len;
S142 = S142';
[R142,pval142] = corr(S142,S142); % correlate
figure 
surf(R142,'LineStyle','none')

S156Test = load('../All_FL/FL_Test/USDAS156.csv');
S156Train = load('../All_FL/FL_Train/USDAS156.csv');
S156 = vertcat(S156Test,S156Train);
len = size(S156,1);
x = 1:len;
y = 1:len;
S156 = S156';
[R156,pval156] = corr(S156,S156); % correlate
figure 
surf(R156,'LineStyle','none')

S051Test = load('../All_FL/FL_Test/USDAS051.csv');
S051Train = load('../All_FL/FL_Train/USDAS051.csv');
S051 = vertcat(S051Test,S051Train);
len = size(S051,1);
x = 1:len;
y = 1:len;
S051 = S051';
[R051,pval051] = corr(S051,S051); % correlate
figure 
surf(R051,'LineStyle','none')

S201Test = load('../All_FL/FL_Test/USDAS201.csv');
S201Train = load('../All_FL/FL_Train/USDAS201.csv');
S201 = vertcat(S201Test,S201Train);
len = size(S201,1);
x = 1:len;
y = 1:len;
S201 = S201';
[R201,pval201] = corr(S201,S201); % correlate
figure 
surf(R201,'LineStyle','none')


% Possibly Bad Correlation
S143Test = load('../All_FL/FL_Test/USDAS143.csv');
S143Train = load('../All_FL/FL_Train/USDAS143.csv');
S143 = vertcat(S143Test,S143Train);
len = size(S143,1);
x = 1:len;
y = 1:len;
S143 = S143';
[R143,pval143] = corr(S143,S143); % correlate
figure 
surf(R143,'LineStyle','none')

S146Test = load('../All_FL/FL_Test/USDAS146.csv');
S146Train = load('../All_FL/FL_Train/USDAS146.csv');
S146 = vertcat(S146Test,S146Train);
len = size(S146,1);
x = 1:len;
y = 1:len;
S146 = S146';
[R146,pval146] = corr(S146,S146); % correlate
figure 
surf(R146,'LineStyle','none')

S147Test = load('../All_FL/FL_Test/USDAS147.csv');
S147Train = load('../All_FL/FL_Train/USDAS147.csv');
S147 = vertcat(S147Test,S147Train);
len = size(S147,1);
x = 1:len;
y = 1:len;
S147 = S147';
[R147,pval147] = corr(S147,S147); % correlate
figure 
surf(R147,'LineStyle','none')

S053Test = load('../All_FL/FL_Test/USDAS053.csv');
S053Train = load('../All_FL/FL_Train/USDAS053.csv');
S053 = vertcat(S053Test,S053Train);
len = size(S053,1);
x = 1:len;
y = 1:len;
S053 = S053';
[R053,pval053] = corr(S053,S053); % correlate
figure 
surf(R053,'LineStyle','none')

S081Test = load('../All_FL/FL_Test/USDAS081.csv');
S081Train = load('../All_FL/FL_Train/USDAS081.csv');
S081 = vertcat(S081Test,S081Train);
len = size(S081,1);
x = 1:len;
y = 1:len;
S081 = S081';
[R081,pval081] = corr(S081,S081); % correlate
figure 
surf(R081,'LineStyle','none')

S082Test = load('../All_FL/FL_Test/USDAS082.csv');
S082Train = load('../All_FL/FL_Train/USDAS082.csv');
S082 = vertcat(S082Test,S082Train);
len = size(S082,1);
x = 1:len;
y = 1:len;
S082 = S082';
[R082,pval082] = corr(S082,S082); % correlate
figure 
surf(R082,'LineStyle','none')

S083Test = load('../All_FL/FL_Test/USDAS083.csv');
S083Train = load('../All_FL/FL_Train/USDAS083.csv');
S083 = vertcat(S083Test,S083Train);
len = size(S083,1);
x = 1:len;
y = 1:len;
S083 = S083';
[R083,pval083] = corr(S083,S083); % correlate
figure 
surf(R083,'LineStyle','none')

S089Test = load('../All_FL/FL_Test/USDAS089.csv');
S089Train = load('../All_FL/FL_Train/USDAS089.csv');
S089 = vertcat(S089Test,S089Train);
len = size(S089,1);
x = 1:len;
y = 1:len;
S089 = S089';
[R089,pval089] = corr(S089,S089); % correlate
figure 
surf(R089,'LineStyle','none')

S105Test = load('../All_FL/FL_Test/USDAS105.csv');
S105Train = load('../All_FL/FL_Train/USDAS105.csv');
S105 = vertcat(S105Test,S105Train);
len = size(S105,1);
x = 1:len;
y = 1:len;
S105 = S105';
[R105,pval105] = corr(S105,S105); % correlate
figure 
surf(R105,'LineStyle','none')

S161Test = load('../All_FL/FL_Test/USDAS161.csv');
S161Train = load('../All_FL/FL_Train/USDAS161.csv');
S161 = vertcat(S161Test,S161Train);
len = size(S161,1);
x = 1:len;
y = 1:len;
S161 = S161';
[R161,pval161] = corr(S161,S161); % correlate
figure 
surf(R161,'LineStyle','none')

S209Test = load('../All_FL/FL_Test/USDAS209.csv');
S209Train = load('../All_FL/FL_Train/USDAS209.csv');
S209 = vertcat(S209Test,S209Train);
len = size(S209,1);
x = 1:len;
y = 1:len;
S209 = S209';
[R209,pval209] = corr(S209,S209); % correlate
figure 
surf(R209,'LineStyle','none')

S217Test = load('../All_FL/FL_Test/USDAS217.csv');
S217Train = load('../All_FL/FL_Train/USDAS217.csv');
S217 = vertcat(S217Test,S217Train);
len = size(S217,1);
x = 1:len;
y = 1:len;
S217 = S217';
[R217,pval217] = corr(S217,S217); % correlate
figure 
surf(R217,'LineStyle','none')

S221Test = load('../All_FL/FL_Test/USDAS221.csv');
S221Train = load('../All_FL/FL_Train/USDAS221.csv');
S221 = vertcat(S221Test,S221Train);
len = size(S221,1);
x = 1:len;
y = 1:len;
S221 = S221';
[R221,pval221] = corr(S221,S221); % correlate
figure 
surf(R221,'LineStyle','none')

S253Test = load('../All_FL/FL_Test/USDAS253.csv');
S253Train = load('../All_FL/FL_Train/USDAS253.csv');
S253 = vertcat(S253Test,S253Train);
len = size(S253,1);
x = 1:len;
y = 1:len;
S253 = S253';
[R253,pval253] = corr(S253,S253); % correlate
figure 
surf(R253,'LineStyle','none')

S257Test = load('../All_FL/FL_Test/USDAS257.csv');
S257Train = load('../All_FL/FL_Train/USDAS257.csv');
S257 = vertcat(S257Test,S257Train);
len = size(S257,1);
x = 1:len;
y = 1:len;
S257 = S257';
[R257,pval257] = corr(S257,S257); % correlate
figure 
surf(R257,'LineStyle','none')

S273Test = load('../All_FL/FL_Test/USDAS273.csv');
S273Train = load('../All_FL/FL_Train/USDAS273.csv');
S273 = vertcat(S273Test,S273Train);
len = size(S273,1);
x = 1:len;
y = 1:len;
S273 = S273';
[R273,pval273] = corr(S273,S273); % correlate
figure 
surf(R273,'LineStyle','none')

toc

debug = 1;


