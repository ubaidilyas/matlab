function [] = draw_results()
    sample_throughput_mean = zeros(3, 1);
    confidence_interval_upper_end = zeros(3, 1);
    confidence_interval_lower_end = zeros(3, 1);
   
   sample_mean_data = [ 689289.80481046, 689289.80481046, 689289.80481046, 689289.80481046, 689289.80481046, 689289.80481046, 689289.80481046, 689289.80481046, 689307.4729237, 689289.80481046 ];
   [sample_throughput_mean(1), confidence_interval_lower_end(1), confidence_interval_upper_end(1)] = calculate_confidence_interval(sample_mean_data, 0.95);
   
 %  sample_mean_data = [808352.94673941, 783543.7490079, 831385.05836424, 796329.33760879, 731513.29225051, 822453.51641875, 871516.83230864, 745252.04410739, 941775.5182467, 950542.26592416];
 %  [sample_throughput_mean(2), confidence_interval_lower_end(2), confidence_interval_upper_end(2)] = calculate_confidence_interval(sample_mean_data, 0.95);
%   
%   sample_mean_data = [875695.35225163,870508.81065253, 874454.40133887,868920.19975071,863073.15787805,871949.10003004,849515.4903774,842889.21863293,880923.46323265,842866.96028653];
%   [sample_throughput_mean(3), confidence_interval_lower_end(3), confidence_interval_upper_end(3)] =calculate_confidence_interval(sample_mean_data, 0.95);

   
   
   
   
    %sample_mean_data = [689289.80481046, 689289.80481046, 689289.80481046,689289.80481046,689289.80481046,689289.80481046,689289.80481046,689289.80481046,689307.4729237,689289.80481046,689289.80481046,689289.80481046,689289.80481046,528256.5563147,689289.80481046,689289.80481046,689289.80481046,363532.1469686,689289.80481046,689289.80481046,689289.80481046,689289.80481046,345403.50865869,417860.85732115,689289.80481046,689289.80481046,689289.80481046,343015.11593956,689289.80481046,379367.9692304];
    %[sample_throughput_mean(1), confidence_interval_lower_end(1), confidence_interval_upper_end(1)] = calculate_confidence_interval(sample_mean_data, 0.95);
    
  
   %sample_mean_data = [808352.94673941,783543.7490079,831385.05836424,796329.33760879,731513.29225051,822453.51641875,871516.83230864,745252.04410739,941775.5182467,950542.26592416,930459.95593289,917174.12263586,872206.76799438,903618.34905014,897877.99904617,964948.94685384,872817.79828831,831998.73786123,924512.26238788,939023.96970789,934354.33451317,709534.70672162,916385.85251911,836083.29248509,826756.16585196,771240.92755758,762089.57153454,772089.06205622,913621.32838317,814555.86391256];
   %[sample_throughput_mean(2), confidence_interval_lower_end(2), confidence_interval_upper_end(2)] = calculate_confidence_interval(sample_mean_data, 0.95);
    
   %sample_mean_data = [875695.35225163,870508.81065253,874454.40133887,868920.19975071,863073.15787805,871949.10003004,849515.4903774,842889.21863293,880923.46323265,842866.96028653,871541.0549993,806522.67274315,879464.05474004,863931.15073982,851175.65299253,885676.38305983,864035.92175806,893045.03556315,862953.80932292,884178.3997938,874387.89883071,863125.93262749,891788.47316383,881620.05657396,861205.65654515,871148.56712691,868229.22282559,889943.7041828,900302.0160717,877208.66809008];
   %[sample_throughput_mean(3), confidence_interval_lower_end(3), confidence_interval_upper_end(3)] =calculate_confidence_interval(sample_mean_data, 0.95);
 
  % X = categorical({'sim time 10s','sim time 100s','sim time 1000s'});
   
  % X = reordercats(X,{'sim time 10s','sim time 100s','sim time 1000s'});
  
  % bar(1:1:3,sample_throughput_mean);
  
  c = 1:3;
  
  confidence_interval_width = zeros(3,1);
   for n = 1 : length(sample_throughput_mean)
       confidence_interval_width(n) = (confidence_interval_upper_end(n) -  confidence_interval_lower_end(n) )/ 2;
   end
  
  figH = figure;
  axes1 = axes;
  title('Confidence Intervals (sample size = 10)'); xlabel('simulation duration'); ylabel('average throughput');
  hold on
  
  for i = 1:3
    bar(c(i),sample_throughput_mean(i),0.2);
    
  end
  
  errH1 = errorbar(1,sample_throughput_mean(1),confidence_interval_width(1),'.','Color','y');
  errH2 = errorbar(2,sample_throughput_mean(2),confidence_interval_width(2),'.','Color','r');
  errH3 = errorbar(3,sample_throughput_mean(3),confidence_interval_width(3),'.','Color','b');
  
  errH1.LineWidth = 1.5;
  errH2.LineWidth = 1.5;
  errH3.LineWidth = 1.5;
  
 
  set(axes1,'XTick',[1 2 3],'XTickLabel',...
    {'sim time 10s','sim time 100s','sim time 1000s'});
  

   
   
  
  
   % bar(X,sample_throughput_mean);
   % hold on
   
   

   
   
   
   % errorbar(X, sample_throughput_mean, confidence_interval_width);
   
   % hold off






end