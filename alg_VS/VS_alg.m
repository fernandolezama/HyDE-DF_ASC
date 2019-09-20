function [Fit_and_p,FVr_bestmemit, fitMaxVector, Best_otherInfo] = ...
    VS_alg(vsParameters,otherParameters,low_habitat_limit,up_habitat_limit)


% Algorithm parameters
psize = vsParameters.psize; %number of neighborhood solutions
MaxItr = vsParameters.MaxItr; %max. number of iterations
itr = MaxItr; % iteration counter



%Function parameters
%func = callFunction(47); %get the function struct for [1...50] functions
objfun = otherParameters.objfun; % function to be optimized
dim = otherParameters.dim; %dimension of the problem
lowerlimit =  otherParameters.lowerlimit; %lower limit of the problem
upperlimit = otherParameters.upperlimit ; %upper limit of the problem


Mu = 0.5 * (upperlimit + lowerlimit) * ones(1,dim); %initial center of the circle

gmin = inf; %fitness of the global min

x = 0.1; % x = 0.1 for gammaincinv(x,a) function
ginv = (1/x)*gammaincinv(x,1); % initially a = 1

r = ginv * ((upperlimit - lowerlimit) / 2); % initial radius of the circle

count = 1; %itr counter

while (itr)
    
    %create candidate solutions within the circle by using gaussian
    %distribution with standard deviation r and center Mu
%     C = -r + 2*r * rand(psize,dim); %A uniform distribution can also be used to create candidate solutions
    C = r.*randn(psize,dim);
    Cs = bsxfun(@plus, C, Mu); %candidate solutions
    
    %limit the variables
    Cs(Cs < lowerlimit) =  rand*(upperlimit - lowerlimit) + lowerlimit;
    Cs(Cs > upperlimit) =  rand*(upperlimit - lowerlimit) + lowerlimit;
    
    % Evaluate the candidate solutions
    ObjVal = feval(objfun,Cs);
    
    fmin = min(ObjVal); % minimum fitness value
    MinFitInd = find(ObjVal == fmin); % find the min. fitness index
    
    if numel(MinFitInd) > 1
        MinFitInd = MinFitInd(1); % if more than one solution keep one of them
    end
    
    itrBest = Cs(MinFitInd,1:dim); %iteration best
    
    if fmin < gmin
        gmin = fmin; % fitness of the best solution found so far
        gbest = itrBest; %best solution found so far
    end
    
    %print the best fitness value found so far
    %fprintf('Iter=%d ObjVal=%g\n',count, gmin);
    
    gmin_vect(count)=gmin;
    
    Mu = gbest; %center is always shifted to the best solution found so far
    
    itr = itr - 1;
    count = count + 1; %itr counter
    
    %radius decrement process
    a = itr / MaxItr; % a value for gammaincinv function
    a_par(count)=a;
    
    ginv = (1/x)*gammaincinv(x,a); % compute the new ginv value
    ginv_par(count)=ginv;
    r = ginv * ((upperlimit - lowerlimit) / 2); %decrease the radius
    r_par(count)=r;
end

Fit_and_p=gmin;
FVr_bestmemit=gbest;
fitMaxVector= gmin_vect;
Best_otherInfo=0;




