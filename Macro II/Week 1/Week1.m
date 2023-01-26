%% Please enter below the path where you have all your .csv files.
path = 'C:\Users\couqu\OneDrive\Bureau\GitHub QEM\QEM\Macro II\Week 1\';
GDP = readtable(strcat(path,'1.1.5.csv'));
Employee = readtable(strcat(path,'1.12.csv'));
FixedAssets = readtable(strcat(path,'1.1.csv'));
Depreciation = readtable(strcat(path,'1.3.csv'));
PriceIndex = readtable(strcat(path,'1.1.4.csv'));
TimeWorked = readtable(strcat(path,'6.9.csv'));



% 1.2.3
AdjustementGDP = sum((table2array(Employee([11,21,23,27],3:end))));
AdjustementGDP 
% 1.2.4
NetGDP = table2array(GDP(3,3:end)) - AdjustementGDP;
Ratio = table2array(Employee(4,3:end))./NetGDP;
subplot(4,3,1)
plot(1960:2021,Ratio)
title("Ratio CDE/NetGDP")
averageCEG = sum(Ratio)/(2021-1960)
% 1.2.5
Kt = table2array(FixedAssets(2,3:end));
%Kt1 = table2array(FixedAssets(2,4:end));
%deltaK = Kt;
gdp = table2array(GDP(3,3:end));
%gdp1 = table2array(GDP(3,4:end));
%deltaGDP = gdp;
subplot(4,3,2)
plot(1960:2021,Kt./gdp)
title("Capital-Output-Ratio")
AverageCOR = (sum((Kt./gdp)))/length(Kt)
%1.2.6
capitalStock = table2array(FixedAssets(2,3:end));
capitalDepreciation = table2array(Depreciation(3,3:end));
RateDepreciation = 1 - ((capitalStock - capitalDepreciation)./capitalStock);
subplot(4,3,3)
plot(1960:2021,RateDepreciation)
title("Capital rate depreciation")
averdelta = sum(RateDepreciation)/length(RateDepreciation)
%1.2.7
GDPDeflator = table2array(PriceIndex(3,3:end));
DeflatedGDP = (GDPDeflator + capitalStock)./(table2array(PriceIndex(9,3:end)));
Lt = transpose(table2array(TimeWorked(1:end,2)));
Alpha = 1 - Ratio;
Ktr = table2array(Depreciation(3,3:end));
Ytr = GDPDeflator;
At = ((Ytr./(Ktr.^(Alpha))).^(1./(1-Alpha)))./Lt;
GrowthAt = (At(2:end)-At(1:end-1))./At(2:end);
subplot(4,3,4)
plot(1961:2021,GrowthAt)
title("Growth rate At")
avergegr = sum(At)/length(At)
%1.2.8
GrowthLt = table2array(TimeWorked(1:end-1,2));
GrowthLt1 = table2array(TimeWorked(2:end,2));
GrowthRateLt = (GrowthLt1 - GrowthLt)./GrowthLt1;
subplot(4,3,5)
plot(1961:2021,GrowthRateLt)
title("Growth rate Lt")
avergengr = sum(GrowthRateLt)/length(GrowthRateLt)
%1.2.9

sstar = 0.2;
sgr = 1-averageCEG;
%% 10 
den =(0.01*avergengr+0.01*avergegr +averdelta);
kstar = (sstar/den)^(1/averageCEG);
k0 = 0.1*kstar;
%%% kt+1 = 0.2*kt^alpha +(1-delta)kt *(1/(1+n)(1+g))
kts=[];
kts(1,1)=k0;
den2 = (1+avergegr*0.01)*(1+avergengr*0.01);

for i=1:62
kts(1,i+1) = (1/den2)*(sstar*(kts(1,i))^(1-averageCEG)+(1-averdelta)*kts(1,i));
end
subplot(4,3,6)
plot(kts);
title("simulated kt, for k0 = 0.1");
xlabel ('Time');
ylabel('kt')
%%
kts2=[];
k1 = 2*kstar;
kts2(1,1)=k1;
for i=1:62
kts2(1,i+1) = (1/den2)*(sstar*(kts2(1,i))^(1-averageCEG)+(1-averdelta)*kts2(1,i));
end
subplot(4,3,7)
plot(kts2);
title("simulated kt for k0 = 0.2");
xlabel ('Time');
ylabel('kt');
%% yt = kt ^alpha
yt = zeros(1,63);
for i = 1:63
yt(1,i) = kts(1,i)^(1-averageCEG);
end
subplot(4,3,8)
plot(yt);
title("simulated yt for k0 = 0.1");
xlabel ('Time');
ylabel('yt');
%% yt = kt ^alpha
yt2 = zeros(1,63);
for i = 1:63
yt2(1,i) = kts2(1,i)^(1-averageCEG);
end
subplot(4,3,9)
plot(yt2);
title("simulated yt for k0 = 0.2");
xlabel ('Time');
ylabel('yt');
%% ct = yt - syt
ct=zeros(1,63);
for i = 1:63
ct(1,i) = yt(1,i)*(1-sstar);
end
subplot(4,3,10)
plot(ct);
title("simulated ct for k0 = 0.1");
xlabel ('Time');
ylabel('ct');
%% 
ct2=zeros(1,63);
for i = 1:63
ct2(1,i) = yt2(1,i)*(1-sstar);
end
subplot(4,3,11)
plot(ct2);
title("simulated ct for k0=0.2");
xlabel ('Time');
ylabel('ct');

