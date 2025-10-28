%% Example ChevyGeneticOnline
%
% This script plots the objective function of the Chevyychev Function 2
% (has multiple peaks)
% Using student solutions from the Genetic algorithm run in Excel
% 
% ChevyChev Function taken from https://www.chebfun.org/docs/guide/guide12.html
% Student solutions from https://docs.google.com/spreadsheets/d/1HrinIg7Jr20wQv2IKfQsFs6CRJ9JaeoyVLd-YMBER2Q/edit?gid=0#gid=0
% on worksheet "GeneticFormattedForInputToMatlab"
%
% The Problem:
% Maximize Z = 3*(1-x).^2.*exp(-(x.^2) - (y+1).^2) ... 
%   - 10*(x/5 - x.^3 - y.^5).*exp(-x.^2-y.^2) ... 
%   - 1/3*exp(-(x+1).^2 - y.^2)
% s.t.
% -3 <= x <= 3
% -3 <= y <= 3
%
% David E. Rosenberg
% October 28, 2025
% CEE 6410
%
% The task is students will solve the Excel version of the problem using
% different starnting points to explore the "optimal" solution.



%% Paste in Student solutions from https://docs.google.com/spreadsheets/d/1HrinIg7Jr20wQv2IKfQsFs6CRJ9JaeoyVLd-YMBER2Q/edit?gid=0#gid=0
% on worksheet "GeneticFormattedForInputToMatlab"

xPaths = [ 
0	0	1.284	0.012	3.59	;
2	2	-0.009	1.581	8.11	;
-0.5	-0.5	-0.009	1.581	8.11	;
1	1	-0.009	1.582	8.11	;
-1	-1	-0.011	1.583	8.11	;
3	3	1.281	-0.004	3.59	;
-3	-3	-0.009	1.581	8.11	;
3	0	-0.456	-0.627	3.77	;
2.9	-1	0.083	1.587	8.10	;
];

%Calculate the objective function for the start point. Add as new column
xPaths = [xPaths  3*(1-xPaths(:,1)).^2.*exp(-(xPaths(:,1).^2) - (xPaths(:,2)+1).^2) ... 
   - 10*(xPaths(:,1)/5 - xPaths(:,1).^3 - xPaths(:,2).^5).*exp(-xPaths(:,1).^2-xPaths(:,2).^2) ... 
   - 1/3*exp(-(xPaths(:,1)+1).^2 - xPaths(:,2).^2)];


%% Paste in student solutions from Google Sheet GeneticProgramming to draw Final Solution points
% https://docs.google.com/spreadsheets/d/1HrinIg7Jr20wQv2IKfQsFs6CRJ9JaeoyVLd-YMBER2Q/edit#gid=947363793

xEvolutionarySolutions = xPaths;

%Find the number of rows in the solutions matrix
nRows = size(xEvolutionarySolutions,1);
%Create a zero vector
newColumn = ones(nRows, 1);
%Add the zero vector to the matrix becaouse this script wants 6 columns
xEvolutionarySolutions = [newColumn xEvolutionarySolutions];

%cell array of Names to go with each solution
sNames = {
'David Convg=0.1; Mutate=0.05; PopSize=10'
'BBB Convg=0.01; Mutate=0.005; PopSize=100'
'AAA Convg=0.1; Mutate=0.5; PopSize=64'
'BBB Convg=0.05; Mutate=0.1; PopSize=25'
'AAA Convg=0.05; Mutate=0.1; PopSize=25'
'BBB Convg=0.002; Mutate=0.0000001; PopSize=5'
'AAA Convg=0.001; Mutate=0.000001; PopSize=10'
'BBB Convg=0.05; Mutate=0.05; PopSize=15'
'AAA Convg=0.1; Mutate=0.05; PopSize=10' };



%Create a grid and calculate of the objective function on it
xPts = [-3:.1:3];
[xMesh,yMesh] = meshgrid(xPts,xPts);
z = 3*(1-xMesh).^2.*exp(-(xMesh.^2) - (yMesh+1).^2) ... 
   - 10*(xMesh/5 - xMesh.^3 - yMesh.^5).*exp(-xMesh.^2-yMesh.^2) ... 
   - 1/3*exp(-(xMesh+1).^2 - yMesh.^2);

%% Figure 1 Objective Function as contour lines - no student solutions
%Create the plot and annotate it
[h,cons] = contour(xMesh,yMesh,z,[-10:1:10]); %,'showtext','on', 'labelspacing',1000);
clabel(h);
hold on

%Plot solutions
%plot(xGradPath(:,1),xGradPath(:,2),'LineWidth',3,'Color','Blue','marker','x','markersize',12);

set(gca,'fontsize',18,'xLim',[-3 3],'yLim',[-3 3]);
xlabel('X');
ylabel('Y');

set(gca,'xtick',[-3:1:3],'xticklabel',[-3:1:3])
set(gca,'ytick',[-3:1:3],'yticklabel',[-3:1:3])
set(cons,'labelspacing',1);

%Label the constraints
%annotation('textbox',[0.6 0.65 0.175 0.05],'String','Constraint 1','FitBoxToText','off');

grid on

hold off

%% Figure 2: 3-d surface plot without student solutions
figure
meshc(xMesh,yMesh,z)
hold on

set(gca,'fontsize',18,'xLim',[-3 3],'yLim',[-3 3]);
xlabel('X');
ylabel('Y');

set(gca,'xtick',[-3:1:3],'xticklabel',[-3:1:3])
set(gca,'ytick',[-3:1:3],'yticklabel',[-3:1:3])
set(cons,'labelspacing',1);

%%Figure 3: 3-d surface plot with student solution paths, algorithm
%%parameters at start point, and marker at optimum solution
figure
meshc(xMesh,yMesh,z)
hold on

set(gca,'fontsize',18,'xLim',[-3 3],'yLim',[-3 3]);
xlabel('X');
ylabel('Y');

%Plot the student solutions
for i = 1:size(xPaths,1)
    xToPlot = [xPaths(i,1) xPaths(i,2) xPaths(i,6);
               xPaths(i,3) xPaths(i,4) xPaths(i,5)];
    plot3(xToPlot(:,1),xToPlot(:,2),xToPlot(:,3),'LineWidth',3,'Color','Black','marker','none','markersize',12);
    % Plot final (optimal) solution as a marker
    plot3(xEvolutionarySolutions(i,4),xEvolutionarySolutions(i,5),xEvolutionarySolutions(i,6),'h','Color','Black','markersize',15,'markerfacecolor','black');

end    

%Plot student names and parameters at start point
text(xEvolutionarySolutions(:,2)+0.2,xEvolutionarySolutions(:,3),xEvolutionarySolutions(:,7),sNames);
% Plot final solution points as markers
%Add student solutions
%plot3(xEvolutionarySolutions(:,4),xEvolutionarySolutions(:,5),xEvolutionarySolutions(:,6),'h','Color','Black','markersize',15,'markerfacecolor','black');

set(gca,'xtick',[-3:1:3],'xticklabel',[-3:1:3])
set(gca,'ytick',[-3:1:3],'yticklabel',[-3:1:3])
set(cons,'labelspacing',1);

%% Figure 4: #d surface plot with student evolutionary solutions as markers
figure
meshc(xMesh,yMesh,z)
hold on

set(gca,'fontsize',18,'xLim',[-3 3],'yLim',[-3 3]);
xlabel('X');
ylabel('Y');

%Add student solutions
plot3(xEvolutionarySolutions(:,4),xEvolutionarySolutions(:,5),xEvolutionarySolutions(:,6),'h','Color','Black','markersize',15,'markerfacecolor','black');
%Label the points with student names  
%text(xEvolutionarySolutions(:,4)+0.2,xEvolutionarySolutions(:,5),xEvolutionarySolutions(:,6),sNames);
text(xEvolutionarySolutions(:,2)+0.2,xEvolutionarySolutions(:,3),xEvolutionarySolutions(:,7),sNames);

set(gca,'xtick',[-3:1:3],'xticklabel',[-3:1:3])
set(gca,'ytick',[-3:1:3],'yticklabel',[-3:1:3])
set(cons,'labelspacing',1);