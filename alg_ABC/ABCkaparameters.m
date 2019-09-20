% Author:           Rainer Storn, Ken Price, Arnold Neumaier, Jim Van Zandt
% Modified by FLC \GECAD 04/winter/2017

%abcParameters.psize= 50; % population in DE
%abcParameters.MaxItr= 5e5; % number of max iterations/gen


%/* Control Parameters of ABC algorithm*/
abckaParameters.NP=50; %/* The number of colony size (employed bees+onlooker bees)*/
%abckaParameters.FoodNumber=NP/2; %/*The number of food sources equals the half of the colony size*/
%abckaParameters.limit=100; %/*A food source which could not be improved through "limit" trials is abandoned by its employed bee*/
abckaParameters.maxCycle=5e5; %/*The number of cycles for foraging {a stopping criteria}*/


% 
% 
% abckaParameters.MaxIt=5e5;              % Maximum Number of Iterations
% abckaParameters.nPop=25;               % Population Size (Colony Size)
% 
% %nOnlooker=nPop;         % Number of Onlooker Bees
% 
% %L=round(0.6*nVar*nPop); % Abandonment Limit Parameter (Trial Limit)
% 
% abckaParameters.a=1;                    % Acceleration Coefficient Upper Bound


%vsParameters.I_strategy   = 1; %DE strategy

%vsParameters.I_bnd_constr = 1; %Using bound constraints 
% 1 repair to the lower or upper violated bound 
% 2 rand value in the allowed range
% 3 bounce back


