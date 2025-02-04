close all
clc

%Video params
videoName = 'video.avi';
% videoName = strcat(['video-ltis-order1-',...
%     num2str(inputFreq,'%.1f'),...
%     'hz.avi']);
% videoName = strcat(['video-ltis-order2-',...
%     num2str(inputFreq,'%.2f'),...
%     'hz.avi']);
% videoName = strcat(['video-singleloop-',...
%     num2str(inputFreq,'%.1f'),...
%     'hz.avi']);
% videoName = strcat(['video-sym-butterfly-',...
%     num2str(inputFreq,'%.1f'),...
%     'hz.avi']);
% videoName = strcat(['video-asym-butterfly-',...
%     num2str(inputFreq,'%.1f'),...
%     'hz.avi']);
frameSkip = 10;
videoXOrig = 100;
videoYOrig = 70;
videoWidth = 720;
videoHeight = 480;

%Plot params
loopLineColor = [0, 0.4470, 0.7410];
outputLineColor = [0.6350, 0.0780, 0.1840];
inputLineColor = [0.4660, 0.6740, 0.1880];
inputLimFactor = 0.1;
inputTicks = linspace(dataHandler.inputMin, dataHandler.inputMax, 5);
inputTickFactor = 1; %1200;
inputTickOffset = 0;
outputLimFactor = 0.2;
outputTicks = linspace(dataHandler.outputMin, dataHandler.outputMax, 5);
outputTickFactor = 1; %600;
outputTickOffset = 0; %1000;
timeTicks = linspace(0,dataHandler.timeSeq(end),4);
timeTickFactor = 1;
timeTickOffset = 0;
lineWidth = 1.5;
markerSize = 5;

%Create figure and initial subplot for loop
fig = figure;
set(fig, 'Color', [0.85 0.85 0.85])
set(fig,'units','pixels','position',[videoXOrig, videoYOrig,...
    videoWidth+videoXOrig, videoHeight+videoYOrig])
loopSubHandler = subplot(2,2,1);
loopPlot = plot(loopSubHandler, dataHandler.inputSeq(1), dataHandler.outputSeq(1),...
    'LineWidth', lineWidth, 'MarkerSize', markerSize,...
    'color', loopLineColor);
xlabel(loopSubHandler, 'u(t)', 'fontsize', 11);
ylabel(loopSubHandler, 'y(t)', 'fontsize', 11);
xticks(loopSubHandler, inputTicks)
yticks(loopSubHandler, outputTicks)
xticklabels(loopSubHandler,...
    strtrim(cellstr(num2str(inputTicks'*inputTickFactor + inputTickOffset, '%.1f'))))
yticklabels(loopSubHandler,...
    strtrim(cellstr(num2str(outputTicks'*outputTickFactor + outputTickOffset, '%.1f'))))
xlim(loopSubHandler, [dataHandler.inputMin-dataHandler.inputAmp*inputLimFactor,...
    dataHandler.inputMax+dataHandler.inputAmp*inputLimFactor])
ylim(loopSubHandler, [dataHandler.outputMin-dataHandler.outputAmp*outputLimFactor,...
    dataHandler.outputMax+dataHandler.outputAmp*outputLimFactor])
grid on;
hold on;
axis on;

%Create figure and initial subplot for output
outputSubHandler = subplot(2,2,2);
outputPlot = plot(outputSubHandler, 0, dataHandler.outputSeq(1),...
    'LineWidth', lineWidth, 'MarkerSize', markerSize,...
    'color', outputLineColor);
xlabel(outputSubHandler, 't (sec)', 'fontsize', 11);
ylabel(outputSubHandler, 'y(t)', 'fontsize', 11);
xticks(outputSubHandler, timeTicks)
yticks(outputSubHandler, outputTicks)
xticklabels(outputSubHandler,...
    strtrim(cellstr(num2str(timeTicks'*timeTickFactor + timeTickOffset, '%.1f'))))
yticklabels(outputSubHandler,...
    strtrim(cellstr(num2str(outputTicks'*outputTickFactor + outputTickOffset, '%.1f'))))
xlim(outputSubHandler, [0, dataHandler.timeSeq(end)])
ylim(outputSubHandler, [dataHandler.outputMin-dataHandler.outputAmp*outputLimFactor,...
    dataHandler.outputMax+dataHandler.outputAmp*outputLimFactor])
grid on;
hold on;
axis on;

%Create figure and initial subplot for input
inputSubHandler = subplot(2,2,3);
inputPlot = plot(inputSubHandler, dataHandler.inputSeq(1), 0,...
    'LineWidth', lineWidth, 'MarkerSize', markerSize,...
    'color', inputLineColor);
xlabel(inputSubHandler, 'u(t)', 'fontsize', 11);
ylabel(inputSubHandler, 't (sec)', 'fontsize', 11);
xticks(inputSubHandler, inputTicks)
yticks(inputSubHandler, timeTicks)
xticklabels(inputSubHandler,...
    strtrim(cellstr(num2str(inputTicks'*inputTickFactor + inputTickOffset, '%.1f'))))
yticklabels(inputSubHandler,...
    strtrim(cellstr(num2str(timeTicks'*timeTickFactor + timeTickOffset, '%.1f'))))
xlim(inputSubHandler, [dataHandler.inputMin-dataHandler.inputAmp*inputLimFactor,...
    dataHandler.inputMax+dataHandler.inputAmp*inputLimFactor])
ylim(inputSubHandler, [0, dataHandler.timeSeq(end)])
set(inputSubHandler, 'Ydir', 'reverse')
grid on;
hold on;
axis on;

%Create video writer
videoWriter = VideoWriter(videoName);
open(videoWriter);

%Create frames with input sequence
for i=1:dataHandler.sampleLength
    set(loopPlot,'XData',[get(loopPlot,'XData') dataHandler.inputSeq(i)],...
        'YData',[get(loopPlot,'YData') dataHandler.outputSeq(i)])
    set(outputPlot,'XData',[get(outputPlot,'XData') dataHandler.timeSeq(i)],...
        'YData',[get(outputPlot,'YData') dataHandler.outputSeq(i)])
    set(inputPlot,'XData',[get(inputPlot,'XData') dataHandler.inputSeq(i)],...
        'YData',[get(inputPlot,'YData') dataHandler.timeSeq(i)])
    if(mod(i,frameSkip)==0 || i==1)
        drawnow
        frame = getframe(fig);
        writeVideo(videoWriter, frame);
    end
end

close(videoWriter);