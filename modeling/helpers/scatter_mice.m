function scatter_mice(x, y, animal, ylimit, xname, yname)
%SCATTER_MICE draws the relationship between x and y considering animal
%identity

[~, ~, animal] = unique(animal); % change animal from code-names (strings) to number index
num_animal = max(animal);

figure; hold on;
for a = 1:num_animal
    animal_idx = find(animal == a);
    plot(x(animal_idx), y(animal_idx), '.--', 'LineWidth', 1.5, 'MarkerSize', 30);
end

xlim([min(x) - 5, max(x) + 5])
ylim([ylimit(1), ylimit(2)])
xlabel(xname)
ylabel(yname)

p1 = polyfit(x, y, 1); % linear fit
x1 = (min(x) - 5):0.01:(max(x) + 5); 
y1 = polyval(p1, x1); % generate fitted line
m1 = fitglm(x, y, 'linear');
rsquare1 = m1.Rsquared.Adjusted;
plot(x1, y1, 'LineWidth', 3.5, 'Color', [0 0 0]);
disp(rsquare1)

set(gca,'TickDir','out');