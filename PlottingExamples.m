%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Avery Rock, UC Berkeley Mechanical Engineering, avery_rock@berkeley.edu
% Modified for ME C201 / MATSCI 286, Spring 2020. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Plotting Examples
% Run each section one by one below for examples of how we are expecting
% plots to look for reports. Please follow the saving instructions at the
% bottom to generate plots that are easy to read and follow.

save_images = 1; % set this to 1 to save outputs
output_folder = "./output_images";

if save_images &&  ~(isfolder(output_folder))
    mkdir(output_folder);
end

%% Basic Plotting Hygiene
% Always run close all before your code to ensure nothing is
% overwritten or replotted on. If you do not do this, you may be overrun
% with figure windows or spend time manually closing windows.

close all % close all open figures
clc % clear command window

%% Example 1D line plot
% All plots should be easy to interpret. Your plots should always include:
% 1) A descriptive title for the contents of the graph.
% 2) Labels for all axes, with units if applicable.
% 3) Formatting choices such that the data presented can be understood.

t = linspace(0, 2, 100);
d = .5*(-9.81)*t.^2; % use .^p to perform element-wise power on array

figure("name", "freefall")  % Generate new named figure for plot
plot(t, d, 'LineWidth', 3) % use 'LineWidth' attribute to increase line
% thickness. Makes plot lines a lot easier to see

title('Freefall of Object From Rest') % Always include title, axis labels with units for any plot
xlabel('time (s)')
ylabel('height (m)')
set(gca,'FontSize', 26); % Use this command to increase text size on plot

axis tight % make axis crop out any dead space

x0 = 0; y0 = 0; width = 800; height = 500;
set(gcf,'units','pixels','position',[x0,y0,width,height]) % use this command to set the exact size and position of your figure

%% Example scatter plot
% When data are not a series but a set of discrete points, use scatter() or specify a
% non-connected marker style to generate markers instead of lines connecting
% points together. Note that there are many marker types, see matlab online documentation for
% details. Also use 'MarkerSize' attribute to increase size of markers for clarity.

h = normrnd(30, 10, [1000, 1]);
d = normrnd(20, 7.5, [1000, 1]);

I = and(h > 0, d > 0); h = h(I); d = d(I); % only keep positive data

figure("name", "pumpkins");
plot(h, d, '.','Markersize', 15, 'Color', [1 .5 .2])

title('Pumpkin Dimensions')
xlabel('Height (cm)')
ylabel('Diameter (cm)')
set(gca,'FontSize', 26); % Use this command to increase text size on plot

x0 = 0; y0 = 0; width = 800; height = 500;

set(gcf,'units','pixels','position',[x0,y0,width,height]) % use this command to set the exact size and position of your figure

%% Example 1D line plot with multiple lines
% When comparing several plots with significant overlap, use different line
% types to make your graphs legible. This is especially helpful
% if you are printing in black and white and have no way to differentiate
% colors. Notice second two lines were made dashed lines because Matlab
% plots lines on top of one another in the order they are plotted. You can
% also do tricks like stagger line widths so that the bottom trend can be
% seen even though it is under the other lines. Use formatting choices to
% improve plot clarity. When a plot has multiple lines, you MUST include a legend to
% differentiate the lines from one another. Some tricks for making clear
% legends. Use the below syntax with the attributes 'Interpreter','Latex'
% in order to place math text directly in your plots. Note this also works
% with titles and axis labels. Also, use the 'location' attribute to move
% your legend to a location which covers the least amount of your data. You
% can also click drag the location of your legend after it has been plotted
% to move it away from covering the data.

t = linspace(0, 2*pi, 100);

p1 = sin(t).*exp(-t/15); % use .* to perform element-wise multiplication between arrays
p2 = sin(t).*exp(-t/20);
p3 = sin(t).*exp(-t/25);

figure("name", "blaster");
plot(t,p1,':', 'Color', [0 0 0], 'LineWidth',3)
hold on % use hold on to allow additional data to be added to the same axes
plot(t,p2,'-.','Color', [.5 .5 .5],'LineWidth',3)
plot(t,p3,'--','Color', [.7 .7 .7],'LineWidth',3)

title('Blaster Voltage')
xlabel('t (ms)')
ylabel('Voltage (MV)')

legend({'$e^{\frac{-t}{15}}$ decay','$e^{\frac{-t}{20}}$ decay',...
    '$e^{\frac{-t}{25}}$ decay'},'Interpreter','latex','location','northeast')

set(gca,'FontSize',26); % Use this command to increase text size on plot

x0 = 0; y0 = 0; width = 800; height = 500;
set(gcf,'units','pixels','position',[x0,y0,width,height]) % use this command to set the exact size and position of your figure

%% Programmatically defined legends
% Sometimes, it is a hassle to manually type out the legend entries,
% particularly if there are a large or potentially varying number of plots
% required. Let's say you wanted to produce two subplots showing the value
% and derivatives of x^d, for several values of d that depended on previous
% code outputs that you were actively debugging.

d_array = [1, 2, 3, 5, 7, 9];

labels = cell(numel(d_array), 1); % programatically define labels for plots using cell array of strings

for i = 1:numel(d_array)
    labels{i} = sprintf('f(x) = x^{%d}', d_array(i));
    % read about the use of string formatting and specifiers here:
    % https://www.mathworks.com/help/matlab/matlab_prog/formatting-strings.html
end

x = linspace(0, 1, 1000)'; % array of x values should be a column vector for element-wise power and plotting to work easily
y = x.^(d_array);
dy = (x.^(d_array - 1)).*(d_array);

figure("name", "polynomials");
subplot(1, 2, 1)
plot(x, y, 'LineWidth', 1);
title("Powers of x")
xlabel("x")
ylabel("f(x)")
legend(labels, 'location', 'northwest')

subplot(1, 2, 2)
plot(x, dy, 'LineWidth', 1);
title("Derivatives of Powers of x")
xlabel("x")
ylabel("df/dx")
legend(labels, 'location', 'northwest')

x0 = 0; y0 = 0; width = 800; height = 500;
set(gcf,'units','pixels','position',[x0,y0,width,height]) % use this command to set the exact size and position of your figure

%% Nonlinear scaling
% When your data spans several orders of magnitude, it is often hard to see
% everything at the same time with linear scaling. This will come up very
% often with genetic algorithm convergence plots. To make sure that the
% entire history can be read on the same plot, use nonlinear scaling.
% Depending on your data and the features you want to show, scaling can
% have a significant impact on what your plots look like. For this data,
% semilogy produces the most easily understandable plots since the
% y data spans several orders of magnitude by the x data does not. Pick the
% type of scaling that shows your data best.

x = linspace(0,10,1E6) + eps;
y = (2 +  sin(2*pi*x)).* exp(-x); % eps = machine precision value. You cannot plot zero on log scale because log(0) is not defined.

figure("name", "scaling");
subplot(2, 2, 1)
plot(x,y,'LineWidth',1)
title('plot(x, y): ok');
xlabel('x')
ylabel('y')
set(gca, 'FontSize', 12)

subplot(2, 2, 2)
semilogx(x,y,'LineWidth',1)
title('semilogx(x, y): unintelligible')
xlabel('x')
ylabel('y')
set(gca, 'FontSize', 12)

subplot(2, 2, 3)
semilogy(x,y,'LineWidth',1)
title('semilogy(x, y): great')
xlabel('x')
ylabel('y')
set(gca, 'FontSize', 12)

subplot(2, 2, 4)
loglog(x, y, 'LineWidth',1)
title('loglog(x, y): unintelligible')
xlabel('x')
ylabel('y')
set(gca, 'FontSize', 12)

x0 = 0; y0 = 0; width = 800; height = 500;
set(gcf,'units','pixels','position',[x0,y0,width,height]) % use this command to set the exact size and position of your figure

%% How to save your plots as images

% For saving your plot as an image to be uploaded to your report, do NOT
% simply take a screenshot of your figures.

% Instead, when you generate your figure, increase the figure window size
% to fit your whole computer screen or until you are happy with the overall appearance,
% move legends around (or move the perspective view for 3D plots) manually such that the data is clearly
% shown. Then, go to file > Save As, change the format of the image to .png
% and save the file under the path of your choosing.

% You can also have this done automatically (and potentially repeatedly)
% using the builtin functions saveas() or print(), as used below

% For a concise explanation of why you should save figures as
% .png files and NOT as .jpg files, please see the following link:
% https://www.labnol.org/software/tutorials/jpeg-vs-png-image-quality-or-bandwidth/5385/

all_figures = findobj('type', 'figure');
try
    for i = 1:numel(all_figures)
        print(all_figures(i), sprintf("%s/%s.png", output_folder, all_figures(i).Name), "-dpng", "-r300");
    end
catch
    fprintf("Did not save images.\n\n")
end

