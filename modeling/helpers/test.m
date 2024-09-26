% Script for testing various things quickly

[x, n] = histcounts(BIC_a0bp, 0:0.001:0.2);
[x_sim, n_sim] = histcounts(samples_all_sim.alpha_positive_lin, 0:0.001:0.2);

figure; hold on
histogram('BinEdges', n, 'BinCounts', x)
histogram('BinEdges', n_sim, 'BinCounts', x_sim)
legend({'generate', 'recover'})
set(gca,'TickDir','out');