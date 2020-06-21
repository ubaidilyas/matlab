function [packet_count_data,  bins, obsCounts, n, h, p, st] = chi_square_test_poisson_distribution(filename)
    % [packet_count_data,  bins, obsCounts, n, h, p, st] = chi_square_test_poisson_distribution('D:\Parhai\Masters\2nd-Semester\Simulation_LL\a-team-4\usman\result.csv')
    data = csvread(filename, 1, 0);
    interval_size=0.2;
    current_interval_min_time = 0.0;
    current_interval_max_time = 0.2;
    interval_packet_count = 0;
    packet_count_data = [];
    interval_no=1;
    for n = 1 : length(data)
        if  data(n,1) <= current_interval_max_time && data(n,1) > current_interval_min_time
            interval_packet_count = interval_packet_count + 1;
        elseif data(n,1) > current_interval_max_time
            packet_count_data(interval_no, 1) = current_interval_min_time;
            packet_count_data(interval_no, 2) = current_interval_max_time;
            packet_count_data(interval_no, 3) = interval_packet_count;
            interval_no = interval_no + 1;
            current_interval_max_time = current_interval_max_time + interval_size; 
            current_interval_min_time = current_interval_min_time + interval_size;
            while current_interval_max_time < data(n,1)
                packet_count_data(interval_no, 1) = current_interval_min_time;
                packet_count_data(interval_no, 2) = current_interval_max_time;
                packet_count_data(interval_no, 3) = 0;
                interval_no = interval_no + 1;
                current_interval_max_time = current_interval_max_time + interval_size; 
                current_interval_min_time = current_interval_min_time + interval_size;
            end
            interval_packet_count = 1;
        end
    end
    packet_count_data(interval_no, 1) = current_interval_min_time;
    packet_count_data(interval_no, 2) = current_interval_max_time;
    packet_count_data(interval_no, 3) = interval_packet_count;
    bins = unique(packet_count_data(:, 3)');
    obs_counts_size = max(bins);
    bins = 0:max(bins);
    obsCounts = zeros(obs_counts_size+1,1);
    for i = 1 : length(packet_count_data)
        obsCounts(packet_count_data(i,3)+1) = obsCounts(packet_count_data(i,3)+1) + 1;
    end
    obsCounts = obsCounts';
    disp(bins);
    disp(obsCounts);
    tiledlayout(2,1);
    nexttile
    bar(bins,obsCounts)
    title('Sample data')
    n = sum(obsCounts);
    pd = fitdist(bins','Poisson','Frequency',obsCounts');
    nexttile
    y = pdf(pd,bins);
    bar(bins,y);
    title('Fitted distribution')
    expCounts = n * pdf(pd,bins);
    [h,p,st] = chi2gof(bins,'Ctrs',bins,...
                        'Frequency',obsCounts, ...
                        'Expected',expCounts,...
                        'NParams',1, 'Alpha',0.01);
end