%% examAnalysisv2.m
% Description: Script File to analyze grades after an exam
% Instructions: Grades must in a column vector named 'grades'
% Created by: Samuel Bechara, PhD
% Last modified: 15 Feb 2021

% To use this program either...
% A) Preload a column array of grades then click run
% B) Or, start the program and it will prompt you to load a .mat file with
%    an grades array. Note: if you choose this option the .mat file
%    must be in the same directory as this script

% NOTE: You can scramble the grades so you can upload for students safely
% by using the command:
%       >> grades = grades(randperm(length(grades)))

close all

% Note: clear and clc are intentionally left out so you can re-run the program with
% different parameters multiple times without losing your data. That means
% you can test different curves back to back to see how the stats look

%% User Options & Data Analysis
fprintf('---- examAnaysis version 2.0 options ----\n')

% Load File Option
loadFileOption = input('Is your file loaded? [y]/[n] ','s');
if loadFileOption == 'n' || loadFileOption == 'N'
    clear
    file = uigetfile; % this line opens file browser
    load(file)
end

% Get Max Score for Percentages
maxScore = input('What is the maximum score? ');

% Calculate percentages. Need to do it now in case you want to remove 0's
examPercentages = grades/maxScore * 100;

% Remove Zero's Option
removeZerosOption = input('Do you want to remove zeros? [y]/[n] ','s');
if removeZerosOption == 'y' || removeZerosOption == 'Y'
    examPercentages = examPercentages(examPercentages ~= 0);
end

% Curve Grades Option
curvedGradesOption = input('Do you want to see the curved grades statistics? [y]/[n] ','s');
if curvedGradesOption == 'y' || curvedGradesOption == 'Y'
    curvedAverage = input('What is the desired average in %? ');
end

% Analyze for Letter Grades and Generate Plots
numLetterGrades = printGrades(examPercentages);
generatePlots(examPercentages,numLetterGrades,'Raw Grades');

%% Dr. Williams Curve Option
% Formula: curved grade = (raw - avg)/std * 10 + avg_you_want
if curvedGradesOption == 'y' || curvedGradesOption == 'Y'
    curvedPercentages = (grades - mean(grades))/std(grades)*...
        10+curvedAverage;
    numLettersCurved = printGrades(curvedPercentages);
    generatePlots(curvedPercentages,numLettersCurved,'Curved Grades');
    
    addPoints = curvedPercentages - examPercentages;
    
    % Display how much each row item needs to be increased
    % The table makes it easy to adjust points in Canvas or other gradebook
    curveData = table(examPercentages,curvedPercentages,addPoints);
    
    % Display Curve Stats
    fprintf('\n---- CURVE STATISTICS ----\n');
    fprintf('Mean Number of Points Added %.0f\n',mean(curveData.addPoints));
    fprintf('Median Number of Points Added %.0f\n',median(curveData.addPoints));
    fprintf('Maximum Number of Points Added %0.f\n',max(curveData.addPoints));
    fprintf('Minimum Number of Points Added %0.f\n',min(curveData.addPoints));
end 
    
%% Printing Sub-Function
function [numLetterGrades] = printGrades(percentages,printOption)

% Default to printing
if nargin == 1
    printOption = 'y';
end

stdError = std(percentages)/sqrt(length(percentages));

% create grade array with numbers at indicies cooresponding to number of
% A's, B's, etc
numLetterGrades = zeros(9,1);

% Updated to current grading scheme
for i = 1:length(percentages)
    if percentages(i) > 93
        numLetterGrades(1) = numLetterGrades(1) + 1;
    elseif percentages(i) > 90
        numLetterGrades(2) = numLetterGrades(2) + 1;
    elseif percentages(i) > 86.67
        numLetterGrades(3) = numLetterGrades(3) + 1;
    elseif percentages(i) > 83.33
        numLetterGrades(4) = numLetterGrades(4) + 1;
    elseif percentages(i) > 80
        numLetterGrades(5) = numLetterGrades(5) + 1;
    elseif percentages(i) > 76.67
        numLetterGrades(6) = numLetterGrades(6) + 1;
    elseif percentages(i) > 70
        numLetterGrades(7) = numLetterGrades(7) + 1;
    elseif percentages(i) > 60
        numLetterGrades(8) = numLetterGrades(8) + 1;
    else
        numLetterGrades(9) = numLetterGrades(9) + 1;
    end
end

if printOption == 'y'
    fprintf('\n---- EXAM STATISTICS ----\n');
    fprintf('The average grade was %.0f\n',mean(percentages))
    fprintf('The median grade was %.0f\n',median(percentages))
    fprintf('The mode grade was %.0f\n',mode(percentages))
    fprintf('The standard deviation was %.3f\n',std(percentages));
    fprintf('The standard error was %.3f\n',stdError);
    
    % Print out all grades
    fprintf("\n----- LETTER GRADES ----\n");
    fprintf("There were %.0f A's\n",numLetterGrades(1));
    fprintf("There were %.0f A-'s\n",numLetterGrades(2));
    fprintf("There were %.0f B+'s\n",numLetterGrades(3));
    fprintf("There were %.0f B's\n",numLetterGrades(4));
    fprintf("There were %.0f B-'s\n",numLetterGrades(5));
    fprintf("There were %.0f C+'s\n",numLetterGrades(6));
    fprintf("There were %.0f C's\n",numLetterGrades(7));
    fprintf("There were %.0f D's\n",numLetterGrades(8));
    fprintf("There were %.0f F's\n",numLetterGrades(9));
end
end

%% Plotting Sub-Function
function generatePlots(percentages,lettergrades,caption)
figure
nbins = 9;
subplot(1,3,1)
histfit(percentages,nbins)
title('Histogram of Raw Scores')
xlabel('Raw Grade')
ylabel('Frequency')
grid

% Second Subplot; create a normal probability plot to see if data looks normalish
subplot(1,3,2)
normplot(percentages)

% Third Subplot; create a histogram that DIRECTLY cooresponds to grade bins
subplot(1,3,3)
histogram('Categories',{'A','A-','B+','B','B-','C+','C','D','F'},...
    'BinCounts',lettergrades)
grid
title('Histogram of Grades')
xlabel('Grade from F to A')
ylabel('Frequency')

if nargin == 3
    sgtitle(caption);
end
end