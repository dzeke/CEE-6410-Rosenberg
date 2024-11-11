%% Example ChevyLocalOptimums
%
% This script plots the objective function of the Chevyychev Function 2
% (has multiple peaks)
% Function taken from https://www.chebfun.org/docs/guide/guide12.html
%
%The Problem:
% Maximize Z = 3*(1-x).^2.*exp(-(x.^2) - (y+1).^2) ... 
%   - 10*(x/5 - x.^3 - y.^5).*exp(-x.^2-y.^2) ... 
%   - 1/3*exp(-(x+1).^2 - y.^2)
% s.t.
% -3 <= x <= 3
% -3 <= y <= 3
%
% David E. Rosenberg
% October 4, 2020
% CEE 6410
%
% The task is students will solve the GAMS version of the problem using
% different starnting points to explore the "optimal" solution.



%% Paste in student solutions from Google Sheet GAMS-CONOPT(gradient) to draw a path from start to finish
% https://docs.google.com/spreadsheets/d/1HrinIg7Jr20wQv2IKfQsFs6CRJ9JaeoyVLd-YMBER2Q/edit#gid=0


xPaths = [ 
-2	-2	-3	-3	-9.60E-05	;
-2	-2	-3	-3	-9.60E-05	;
1	1	-0.009	1.581	8.106	;
2	-1	-0.009	1.581	8.106	;
0	0	-0.114	-0.504	2.0816	;
-1.5	-1.5	-3	-3	-9.60E-05	;
0	0	-0.114	-0.504	2.0816	;
1.571	2.718	-0.009	1.581	8.106	;
-2	2	-0.009	1.581	8.106	;
0	-2	-3	-3	9.60E-05	;
0	1.5	-0.009	1.581	8.106	;
3	2	-0.0088	1.581	8.1061	;
0	-2	-3	-3	9.60E-05	;
];

xPaths = [
    -2	-2	-3	-3	-9.60E-05	;
-1	-1	-0.114	-0.504	2.082	;
0.55	0.55	1.268	0.036	3.445	;
1.618	-1.618	1.2678	0.0362	3.4446	;
-1.618	1.618	-0.0088	1.5814	8.11E+00	;
2.99	-2.99	3	-3	-8.72E-05	;
2.5	-2.5	-0.008	1.5814	-8.72E-05	;
0	1.5	-0.008	1.5814	8.106	;
-2.99	2.99	-0.009	1.581	8.106	;
-1.618	-1.618	-3	-3	-0.0001	;
1.618	1.618	-0.0088	1.5814	8.1061	;
-1.75	1.75	-0.0088	1.5814	8.11E+00	;
1.5	-1.5	-0.0088	1.5814	8.106	;
-2.6	0.8	-0.009	1.581	8.106	;
0.1	2.9	-0.009	1.581	8.106	;
-1.45	-1.45	-3	-3	-9.60E-05	;
1.75	1.75	-0.009	1.581	8.106	;
1.5	1	1.268	0.036	3.445	;
-2.8	0	-0.09	1.581	8.106	;
0	3	-0.0088	1.5814	8.1061	;
0	0	-0.1136	-0.5042	2.0816	;
0.55	1	-0.009	1.581	8.106	;
1	-2	3	-3	-8.72E-05	;
2097152	2097152	-0.0088	1.5814	8.1061	;
-0.55	-1	-0.009	1.581	8.106	;
0	0	-0.114	-0.504	2.082	;
-2097152	-2097152	-3	-3	-0.0001	;
2097152	-2097152	3	-3	-0.0001	;
-1.5	0.2	-0.009	1.581	8.106	;
-0.5	-0.25	-0.1136	-0.5042	2.0816	;
-2.5	0.5	-0.008	1.5814	8.1061	;
]

%Calculate the objective function for the start point. Add as new column
xPaths = [xPaths  3*(1-xPaths(:,1)).^2.*exp(-(xPaths(:,1).^2) - (xPaths(:,2)+1).^2) ... 
   - 10*(xPaths(:,1)/5 - xPaths(:,1).^3 - xPaths(:,2).^5).*exp(-xPaths(:,1).^2-xPaths(:,2).^2) ... 
   - 1/3*exp(-(xPaths(:,1)+1).^2 - xPaths(:,2).^2)];


%cell array of Names to go with each solution

%Create a grid and calculate of the objective function on it
xPts = [-3:.1:3];
[xMesh,yMesh] = meshgrid(xPts,xPts);
z = 3*(1-xMesh).^2.*exp(-(xMesh.^2) - (yMesh+1).^2) ... 
   - 10*(xMesh/5 - xMesh.^3 - yMesh.^5).*exp(-xMesh.^2-yMesh.^2) ... 
   - 1/3*exp(-(xMesh+1).^2 - yMesh.^2);

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

%3-d surface plot without student solutions
figure
meshc(xMesh,yMesh,z)
hold on

set(gca,'fontsize',18,'xLim',[-3 3],'yLim',[-3 3]);
xlabel('X');
ylabel('Y');

set(gca,'xtick',[-3:1:3],'xticklabel',[-3:1:3])
set(gca,'ytick',[-3:1:3],'yticklabel',[-3:1:3])
set(cons,'labelspacing',1);

%3-d surface plot with student solution paths
figure
meshc(xMesh,yMesh,z)
hold on

set(gca,'fontsize',18,'xLim',[-3 3],'yLim',[-3 3]);
xlabel('X');
ylabel('Y');

%Plot the student solutions
for i = 1:size(xPaths,1)
    xToPlot = [xPaths(i,1) xPaths(i,2) xPaths(i,3);
               xPaths(i,4) xPaths(i,5) xPaths(i,6)];
    %Line from start to end
    plot3(xToPlot(:,1),xToPlot(:,2),xToPlot(:,3),'LineWidth',3,'Color','Black','marker','none','markersize',6);
    %Marker at end
    plot3(xToPlot(2,1),xToPlot(2,2),xToPlot(2,3),'LineWidth',3,'Color','Black','marker','o','markersize',8);
    
end    

set(gca,'xtick',[-3:1:3],'xticklabel',[-3:1:3])
set(gca,'ytick',[-3:1:3],'yticklabel',[-3:1:3])
set(cons,'labelspacing',1);

%3-d surface plot with student evolutionary solutions
figure
meshc(xMesh,yMesh,z)
hold on

set(gca,'fontsize',18,'xLim',[-3 3],'yLim',[-3 3]);
xlabel('X');
ylabel('Y');

%Add student solutions

%% Paste in student solutions from Google Sheet GeneticProgramming to draw Final Solution points
% https://docs.google.com/spreadsheets/d/1HrinIg7Jr20wQv2IKfQsFs6CRJ9JaeoyVLd-YMBER2Q/edit#gid=947363793

xEvolutionarySolutions = [
0	0	1	0.5	10	2.000	2.000	10.00		;
-2	-2	0.5	0.7	5	0.000	0.500	6.00		;
];

%Calculate the objective function for the start point. Add as new column
xEvolutionarySolutions = [xEvolutionarySolutions  3*(1-xEvolutionarySolutions(:,1)).^2.*exp(-(xEvolutionarySolutions(:,1).^2) - (xEvolutionarySolutions(:,2)+1).^2) ... 
   - 10*(xEvolutionarySolutions(:,1)/5 - xEvolutionarySolutions(:,1).^3 - xEvolutionarySolutions(:,2).^5).*exp(-xEvolutionarySolutions(:,1).^2-xEvolutionarySolutions(:,2).^2) ... 
   - 1/3*exp(-(xEvolutionarySolutions(:,1)+1).^2 - xEvolutionarySolutions(:,2).^2)];

%Plot the student evolutionary solutions
for i = 1:size(xEvolutionarySolutions,1)
    xToPlot = [xEvolutaionarySolutions(i,1) xEvolutaionarySolutions(i,2) xEvolutionarySolutions(i,9);
               xEvolutaionarySolutions(i,6) xEvolutaionarySolutions(i,7) xEvolutaionarySolutions(i,8)];
    %Line from start to end
    plot3(xToPlot(:,1),xToPlot(:,2),xToPlot(:,3),'LineWidth',3,'Color','Black','marker','none','markersize',15);
    %Marker at end
    plot3(xToPlot(2,1),xToPlot(2,2),xToPlot(2,3),'LineWidth',3,'Color','Black','marker','o','markersize',8);
    %text(xEvolutionarySolutions(:,6)+0.2,xEvolutionarySolutions(:,7),xEvolutionarySolutions(:,8),xEvolutaionarySolutions(i,9));
end


%plot3(xEvolutionarySolutions(:,4),xEvolutionarySolutions(:,5),xEvolutionarySolutions(:,6),'h','Color','Black','markersize',15,'markerfacecolor','black');
%Label the points with student names  


set(gca,'xtick',[-3:1:3],'xticklabel',[-3:1:3])
set(gca,'ytick',[-3:1:3],'yticklabel',[-3:1:3])
set(cons,'labelspacing',1);

