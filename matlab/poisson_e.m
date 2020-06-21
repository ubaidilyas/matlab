function p_e = poisson_e(bins,occurance)
fx = (bins.*occurance);
mean=sum(fx)/sum(occurance);
e_l=exp(-mean);
p_r = (e_l*(mean.^bins)./factorial(bins));
p_e=sum(occurance).*p_r;
end
