clear;clc;close all
% Author: Fernando Lezama, GECAD/ISEP 2019
% Description:	
%% This function is used to retrieve the values required to perform the Wilcoxon test as used in SWEVO2019 paper
% 
% Please cite the following work when using HyDE-DF
% * Lezama et. al: HyDE-DF: A novel self-adaptive version of differential evolution for numerical optimization. Swarm and evolutionary computation. 2019
% * Lezama et. al: Hybrid-adaptive differential evolution with decay function (HyDE-DF) applied to the 100-digit challenge competition on single objective numerical optimization. In Proceedings of the Genetic and Evolutionary Computation Conference Companion (GECCO '19). 2019 DOI: https://doi.org/10.1145/3319619.3326747
% * Lezama et. al: A New Hybrid-Adaptive Differential Evolution for a Smart Grid Application Under Uncertainty. In IEEE Congress on Evolutionary Computation (CEC '19) (pp. 1-8). IEEE. 2018


addpath('Functions') 

 for alg_test=1:5

FUNCanalysis=50;
for j=1:FUNCanalysis

FN=j
%Function parameters
 
if alg_test==1
    filename=['Results_ABCka/funct_'  num2str(FN)];
end
if alg_test==2
   filename=['Results_Vortex/funct_'  num2str(FN)];
end
if alg_test==3
   filename=['Results_DE/funct_'  num2str(FN)];
end
if alg_test==4
   filename=['Results_HyDE/funct_'  num2str(FN)];
end
if alg_test==5
   filename=['Results_HyDEDF/funct_'  num2str(FN)];
end

load(filename,'ResDB')
 
 for i=1:30
     if ResDB(i).Fit_and_p>0 && ResDB(i).Fit_and_p<1e-16
     Values(i,j)=0;
     else
       Values(i,j) =  ResDB(i).Fit_and_p;
     end
     
      if ResDB(i).fitVector(1,100)>0 && ResDB(i).fitVector(1,100)<1e-16
      V_100(i,j)=0;
      else
      V_100(i,j)=ResDB(i).fitVector(1,100);
      end
      
       if ResDB(i).fitVector(1,1000)>0 && ResDB(i).fitVector(1,1000)<1e-16
       V_1000(i,j)=0;
       else
        V_1000(i,j)=ResDB(i).fitVector(1,1000);
       end
       
        if ResDB(i).fitVector(1,10000)>0 && ResDB(i).fitVector(1,10000)<1e-16
        V_10000(i,j)=0;
        else
        V_10000(i,j)=ResDB(i).fitVector(1,10000);
        end
 end
    
 res(1:4,j)=[min(Values(:,j));max(Values(:,j));mean(Values(:,j));std(Values(:,j))];
 res_100(1:4,j)=[min(V_100(:,j));max(V_100(:,j));mean(V_100(:,j));std(V_100(:,j))];
 res_1000(1:4,j)=[min(V_1000(:,j));max(V_1000(:,j));mean(V_1000(:,j));std(V_1000(:,j))];
 res_10000(1:4,j)=[min(V_10000(:,j));max(V_10000(:,j));mean(V_10000(:,j));std(V_10000(:,j))];


%% End of MH Optimization

end

filename = 'Wilcox.xlsx';
if alg_test==1
    Sheetname='ABCka';
     Sheetname100=[Sheetname '100it'];
      Sheetname1000=[Sheetname '1000it'];
       Sheetname10000=[Sheetname '10000it'];
end
if alg_test==2
   Sheetname='Vortex';
      Sheetname100=[Sheetname '100it'];
      Sheetname1000=[Sheetname '1000it'];
       Sheetname10000=[Sheetname '10000it'];
end
if alg_test==3
   Sheetname='DE';
      Sheetname100=[Sheetname '100it'];
      Sheetname1000=[Sheetname '1000it'];
       Sheetname10000=[Sheetname '10000it'];
end
if alg_test==4
   Sheetname='HyDE';
      Sheetname100=[Sheetname '100it'];
      Sheetname1000=[Sheetname '1000it'];
       Sheetname10000=[Sheetname '10000it'];
end
if alg_test==5
   Sheetname='HyDEDF';
      Sheetname100=[Sheetname '100it'];
      Sheetname1000=[Sheetname '1000it'];
       Sheetname10000=[Sheetname '10000it'];
end

xlswrite(filename,[Values;res],Sheetname,'B2')
xlswrite(filename,[V_100;res_100],Sheetname100,'B2')
xlswrite(filename,[V_1000;res_1000],Sheetname1000,'B2')
xlswrite(filename,[V_10000;res_10000],Sheetname10000,'B2')

 
end


