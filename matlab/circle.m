function average(x,y,r)
mean; 
xp=r*cos(ang);
yp=r*sin(ang);
plot(x+xp,y+yp);
hold on
rvalues=rand(1,1000);
rvalues=(sqrt(rvalues))*r;
avalues=rand(1,1000);
avalues=avalues*2*pi;
xvalues=rvalues.*cos(avalues);
yvalues=rvalues.*sin(avalues);
plot(x+xvalues,y+yvalues,'x');
hold off
end