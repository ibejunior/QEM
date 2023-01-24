path = 'C:\Users\couqu\OneDrive\Bureau\COURS QEM\S2\Macro II\Homework Week 1\';
GDP = readtable(strcat(path,'GDP.csv'));
Employee = readtable(strcat(path,'Employee.csv'));
FixedAssets = readtable(strcat(path,'Fixed assets.csv'));
Depreciation = readtable(strcat(path,'Depreciation.csv'));
PriceIndex = readtable(strcat(path,'PriceIndex.csv'));
TimeWorked = readtable(strcat(path,'TimeWorked.csv'));



% 1.2.3
AdjustementGDP = sum((table2array(Employee([11,16,23,27],3:end))));
% 1.2.4
NetGDP = table2array(GDP(3,3:end)) - AdjustementGDP;
Ratio = table2array(Employee(4,3:end))./NetGDP;
subplot(2,3,1)
plot(1960:2021,Ratio)
title("Ratio CDE/NetGDP")
AverageRatio = sum(Ratio)/(2021-1960)
% 1.2.5
Kt = table2array(FixedAssets(2,3:end-1));
Kt1 = table2array(FixedAssets(2,4:end));
deltaK = Kt1 - Kt;
gdp = table2array(GDP(3,3:end-1));
gdp1 = table2array(GDP(3,4:end));
deltaGDP = gdp1-gdp;
subplot(2,3,2)
plot(1961:2021,deltaK./deltaGDP)
title("Capital-Output-Ratio")
AverageCOR = (sum((deltaK./deltaGDP)))/60;
%1.2.6
capitalStock = table2array(FixedAssets(2,3:end));
capitalDepreciation = table2array(Depreciation(3,3:end));
RateDepreciation = ((capitalStock - capitalDepreciation)./capitalStock);
subplot(2,3,3)
plot(1960:2021,RateDepreciation)
title("Capital rate depreciation")
meanRateDepreciation = sum(RateDepreciation)/62;
%1.2.7
GDPDeflator = table2array(PriceIndex(3,3:end));
DeflatedGDP = (GDPDeflator + capitalStock)./(table2array(PriceIndex(9,3:end)));
Lt = transpose(table2array(TimeWorked(1:end,2)));
Alpha = 1 - Ratio;
Ktr = table2array(Depreciation(3,3:end));
Ytr = GDPDeflator;
At = ((Ytr./(Ktr.^(Alpha))).^(1./(1-Alpha)))./Lt;
GrowthAt = (At(2:end)-At(1:end-1))./At(2:end);
subplot(2,3,4)
plot(1961:2021,GrowthAt)
title("Growth rate At")
meanGrowthRateAt = sum(At)/length(At);
%1.2.8
GrowthLt = table2array(TimeWorked(1:end-1,2));
GrowthLt1 = table2array(TimeWorked(2:end,2));
GrowthRateLt = (GrowthLt1 - GrowthLt)./GrowthLt1;
subplot(2,3,5)
plot(1961:2021,GrowthRateLt)
title("Growth rate Lt")
meanGrowthRateLt = sum(GrowthRateLt)/length(GrowthRateLt);
%1.2.9

n = GrowthRateLt(42:end);
g = GrowthAt(42:end);
Delta = RateDepreciation(42:end);

