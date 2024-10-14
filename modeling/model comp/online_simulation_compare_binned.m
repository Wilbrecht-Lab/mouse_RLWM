function data_model = online_simulation_compare_binned(data, param)
% This function is used to visualize the online simulation of
% a model compared to actual mice data.
% Can output the simulated dataset if needed for other analysis.

% calculate mice performance
perf = cell_to_mat(data.r);
perf_binned = bin_data(data);
m_perf = nanmean(perf_binned);
se_perf = nanse(perf_binned);
num_trial = length(m_perf);

% online comparison
data_model = online_simulation_correction(data, param);
perf_model = cell_to_mat(data_model.r); 
perf_model_binned = bin_data(data_model);
m_perf_model = nanmean(perf_model_binned);
se_perf_model = nanse(perf_model_binned);

num_trial=6;
figure; hold on;
shadedErrorBar(25*(1:num_trial), m_perf(1:num_trial), se_perf(1:num_trial), 'lineprops', '-r')
shadedErrorBar(25*(1:num_trial), m_perf_model(1:num_trial), se_perf_model(1:num_trial), 'lineprops', '-g')
legend({'mice', 'model'});
title('online');

end

function perf_binned = bin_data(data)
perf = cell_to_mat(data.r);
stim = cell_to_mat_prime(data.s);
for k=1:size(perf,1)
    P=[];
    for s=1:max(stim)
        X = perf(k,stim(k,:)==s);
        for i = 1:floor(length(X)/25)
            P(s,i)=nanmean(X((i-1)*25+1:i*25));
        end
    end
    perf_binned(k,:)= [nanmean(P) nan(1,25-length(nanmean(P)))];
end
end