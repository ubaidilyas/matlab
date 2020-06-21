function [h,p,st] = chi_square_test(data,distribution,alpha, NParams)
    pd = fitdist(data, distribution);
    
   
	[h,p,st] = chi2gof(data,  'CDF' , pd, 'NParams', NParams, 'Alpha', alpha);
end