clear;clc;close all

addpath('Functions') 
addpath('alg_ABC')

ABCkaparameters

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
%[lowerB,upperB] = setVariablesBounds(caseStudyData,otherParameters);

lowerB=lowerlimit*ones(1,otherParameters.dim);
upperB=upperlimit *ones(1,otherParameters.dim);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Call the MH for optimizationclear 
noRuns = 30; % Number of trials here
ResDB=struc([]);
    parfor iRuns=1:noRuns %Number of trails
        tOpt=tic;
        rand('state',sum(noRuns*100*clock))% ensure stochastic indpt trials
              [ResDB(iRuns).Fit_and_p, ...
              ResDB(iRuns).sol, ...
              ResDB(iRuns).fitVector] =...
              ABCka_alg(abckaParameters,otherParameters,lowerB,upperB);
         
       ResDB(iRuns).tOpt=toc(tOpt); % time of each trial
       iRuns
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Save the results and stats
%        Save_results
    end
tTotalTime=toc(tTotalTime); %Total time

filename=['Results_ABCka/funct_'  num2str(FN)];
save(filename)
 
for i=1:noRuns
    Values(i)=  ResDB(i).Fit_and_p;
end

alf=1:3:3*50;
Summary(alf(FN):alf(FN)+2,1)=[mean(Values);std(Values);min(Values) ];

%% End of MH Optimization
end

  save('Results_ABCka/TableI','Summary')
