% Author: Fernando Lezama, GECAD/ISEP 2019
%% Description:	Main code to run experiments using DE, HyDE and HyDE-DF as used in SWEVO2019 paper
% 
% Please cite the following work when using HyDE-DF
% * Lezama et. al: HyDE-DF: A novel self-adaptive version of differential evolution for numerical optimization. Swarm and evolutionary computation. 2019
% * Lezama et. al: Hybrid-adaptive differential evolution with decay function (HyDE-DF) applied to the 100-digit challenge competition on single objective numerical optimization. In Proceedings of the Genetic and Evolutionary Computation Conference Companion (GECCO '19). 2019 DOI: https://doi.org/10.1145/3319619.3326747
% * Lezama et. al: A New Hybrid-Adaptive Differential Evolution for a Smart Grid Application Under Uncertainty. In IEEE Congress on Evolutionary Computation (CEC '19) (pp. 1-8). IEEE. 2018

clear; clc; close all
addpath('Functions') 

for alg_test=1:3

    addpath('alg_HyDEDF')

% Algorithm parameters
DEparameters

if alg_test==1 %HyDE-DF
    deParameters.I_strategy=3;
    deParameters.I_strategyVersion=2;
    deParameters.I_itermax= 5e5;

    deParameters.I_NP=50;
    deParameters.F_weight=0.5;
    deParameters.F_CR=0.9;
end

if alg_test==2 %HyDE
    deParameters.I_strategy=3;
    deParameters.I_strategyVersion=3;
    deParameters.I_itermax= 5e5;

    deParameters.I_NP=50;
    deParameters.F_weight=0.5;
    deParameters.F_CR=0.9;  
end

if alg_test==3 %DE
    deParameters.I_strategy=1;
    deParameters.I_itermax= 5e5;

    deParameters.I_NP=50;
    deParameters.F_weight=0.5;
    deParameters.F_CR=0.9;  
end

FUNCanalysis=50;
for j=1:FUNCanalysis

FN=j
%Function parameters
func = callFunction(FN); %get the function struct for [1...50] functions
otherParameters.objfun = func.name; % function to be optimized
otherParameters.dim = func.dim; %dimension of the problem
otherParameters.lowerlimit =  func.lowerlimit; %lower limit of the problem
otherParameters.upperlimit = func.upperlimit; %upper limit of the problem
lowerlimit =  func.lowerlimit; %lower limit of the problem
upperlimit = func.upperlimit; %upper limit of the problem

tTotalTime=tic;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Set lower/upper bounds of variables 
lowerB=lowerlimit*ones(1,otherParameters.dim);
upperB=upperlimit *ones(1,otherParameters.dim);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Call the MH for optimizationclear 
noRuns = 30; % Number of trials here
ResDB=struc([]);

    for iRuns=1:noRuns %Use normal for if parfor is not available
    % parfor iRuns=1:noRuns %Number of trails
        tOpt=tic;
        rand('state',sum(noRuns*100*clock))% ensure stochastic indpt trials
           
        [ResDB(iRuns).Fit_and_p, ...
         ResDB(iRuns).sol, ...
         ResDB(iRuns).fitVector] =...
         HyDE(deParameters,otherParameters,lowerB,upperB);

         ResDB(iRuns).tOpt=toc(tOpt); % time of each trial
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
tTotalTime=toc(tTotalTime); %Total time

%% Saving the results to the folder
if alg_test==1
    filename=['Results_HyDEDF/funct_'  num2str(FN)];
end
if alg_test==2
   filename=['Results_HyDE/funct_'  num2str(FN)];
end
if alg_test==3
   filename=['Results_DE/funct_'  num2str(FN)];
end
save(filename)
 
 
for i=1:noRuns
    Values(i)=  ResDB(i).Fit_and_p;
end
alf=1:3:3*50;
Summary(alf(FN):alf(FN)+2,1)=[mean(Values);std(Values);min(Values) ]; %Format of the table presented in the paper
%% End of MH Optimization

end

if alg_test==1
  save('Results_HyDEDF/TableI','Summary')
end
if alg_test==2
   filename=['Results_HyDE/funct_'  num2str(FN)];
end
if alg_test==3
  save('Results_DE/TableI','Summary')
end

end

