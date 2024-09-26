% This script is used to test all the scatterplots of regression
% coefficients for mice vs. simulated data

% Need to be run jointly with reg_compare to get the session-wise
% regression coefficients first.

figure; 
for i=1:5
    subplot(2,5,i)
scatter(regression_coeff_repeat_mice(:, i), regression_coeff_repeat_sim(:, i),'k'); refline(1, 0);
lsline
xlabel('mice')
ylabel('sim')
set(gca,'fontsize',14)
subplot(2,5,5+i)
scatter(regression_coeff_reward_mice(:, i), regression_coeff_reward_sim(:, i),'k'); refline(1, 0);
lsline
xlabel('mice')
ylabel('sim')
set(gca,'fontsize',14)
end

% figure; scatter(regression_coeff_repeat_mice(:, 2), regression_coeff_repeat_sim(:, 2)); refline(1, 0);
% figure; scatter(regression_coeff_repeat_mice(:, 3), regression_coeff_repeat_sim(:, 3)); refline(1, 0);
% figure; scatter(regression_coeff_repeat_mice(:, 4), regression_coeff_repeat_sim(:, 4)); refline(1, 0);
% figure; scatter(regression_coeff_repeat_mice(:, 5), regression_coeff_repeat_sim(:, 5)); refline(1, 0);
% 
% figure; scatter(regression_coeff_reward_mice(:, 1), regression_coeff_reward_sim(:, 1)); refline(1, 0);
% figure; scatter(regression_coeff_reward_mice(:, 2), regression_coeff_reward_sim(:, 2)); refline(1, 0);
% figure; scatter(regression_coeff_reward_mice(:, 3), regression_coeff_reward_sim(:, 3)); refline(1, 0);
% figure; scatter(regression_coeff_reward_mice(:, 4), regression_coeff_reward_sim(:, 4)); refline(1, 0);
% figure; scatter(regression_coeff_reward_mice(:, 5), regression_coeff_reward_sim(:, 5)); refline(1, 0);