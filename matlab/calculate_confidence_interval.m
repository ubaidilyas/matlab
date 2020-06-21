function [data_mean , lower_end, upper_end] = calculate_confidence_interval(sample_mean_data, confidence_level)

    format long g
    data_mean = sum(sample_mean_data)/length(sample_mean_data);
    disp(data_mean)
    
    diff_square_sum = 0.0;
    for n = 1 : length(sample_mean_data)
        diff_square_sum = diff_square_sum + ( (sample_mean_data(n) - data_mean) * (sample_mean_data(n) - data_mean) );
    end
    
    sample_variance = diff_square_sum / (length(sample_mean_data) - 1);
    
    % disp(sqrt(sample_variance))
    
    if length(sample_mean_data) < 30
       %disp ('data size less than 30. Use t-distribution to calculate the confidence interval.') 
       df = length(sample_mean_data)- 1;
       alpha_level = (1-confidence_level)/2;
       t_score = tinv(1-alpha_level,df);
       % disp(t_score)
       x = (t_score * sqrt(sample_variance)) ; 
       x = x / sqrt(length(sample_mean_data));
       lower_end = data_mean -x ;
       disp(lower_end)
       upper_end = data_mean + x;
        disp(upper_end)
       
        
    elseif length(sample_mean_data) >= 30
       disp ('data size greater than 30. Use normal distribution to calculate the confidence interval.') 
       alpha_level = (1-confidence_level)/2;
       z_score = norminv(1-alpha_level);
       % disp(z_score)
       x = (z_score * sqrt(sample_variance)) ; 
       x = x / sqrt(length(sample_mean_data));
       lower_end = data_mean -x ;
       upper_end = data_mean + x;
            
        
    end
    
    
    
    


end