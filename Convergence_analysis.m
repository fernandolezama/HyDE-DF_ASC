% Author: Fernando Lezama, GECAD/ISEP 2019
% Description:	
%% This function is used to plot convergence of algorithms after tests as used in SWEVO2019 paper
% Please cite the following work when using HyDE-DF
% * Lezama et. al: HyDE-DF: A novel self-adaptive version of differential evolution for numerical optimization. Swarm and evolutionary computation. 2019
% * Lezama et. al: Hybrid-adaptive differential evolution with decay function (HyDE-DF) applied to the 100-digit challenge competition on single objective numerical optimization. In Proceedings of the Genetic and Evolutionary Computation Conference Companion (GECCO '19). 2019 DOI: https://doi.org/10.1145/3319619.3326747
% * Lezama et. al: A New Hybrid-Adaptive Differential Evolution for a Smart Grid Application Under Uncertainty. In IEEE Congress on Evolutionary Computation (CEC '19) (pp. 1-8). IEEE. 2018

clear; clc; close all

addpath('Functions') 
addpath('alg_ABC','alg_VS','alg_DE','alg_HyDEDF')

Convergency=zeros(30,500000,5);
for alg_test=1:5
    

FN=5; %Select the function you want to plot

switch alg_test
    case 1
        filename=['Results_ABCka/funct_'  num2str(FN)];
    case 2
        filename=['Results_Vortex/funct_'  num2str(FN)];
    case 3
        filename=['Results_DE/funct_'  num2str(FN)];
    case 4
        filename=['Results_HyDE/funct_'  num2str(FN)];
    case 5
        filename=['Results_HyDEDF/funct_'  num2str(FN)];
end
    
load(filename,'ResDB')
 
for i=1:30
    Convergency(i,:,alg_test)=  ResDB(i).fitVector;
end

to_plot(alg_test,:)= mean(Convergency(:,:,alg_test));

%% End of MH Optimization
end

semilogy(to_plot')
legend('ABC','VS','DE','HyDE','HyDE-DF')
xlabel('Iterations')
ylabel('Fitness')

filename_fig=['Fig_Convergence/Function_' num2str(FN) '.fig']; %The resulting figure is saved here
savefig(filename_fig)


