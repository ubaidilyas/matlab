function [randomnumbersvector]=rng(seed,number)

randomnumbersvector = zeros(1,number);
cyclelength=2147483647;
d_i1=seed;
format longG
for index=1:number
  randomnumber=mod(16807*d_i1,cyclelength);
%  ramdomnumber=floor(16807*d_i1/cyclelength);
%  randomnumber=(((16807*d_i1)/cyclelength)-(floor((16807*d_i1)/cyclelength)))*cyclelength;
 %  randomnumber1=((16807*d_i1)-(floor((16807*d_i1)/cyclelength)));
 %  display(randomnumber1);
 d_i1=randomnumber;
   randomnumbersvector(1,index)=d_i1;
end


end