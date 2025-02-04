classdef DataPlotter < handle
    
    properties (Constant)
        labelTextSize = 14
        tickTextSize = 14
    end
   
    methods(Static)
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function fig = plotInputPeriod(dataHandler)
            fig = figure; 
            hold on; 
            grid off;
            
            dataHandler.circShiftInputMinMax();

            T1=1;
            T2=max([dataHandler.maxInputPeakIdx(1),1]);
            if( ~isempty(dataHandler.minInputPeakIdx) )
                T3=dataHandler.minInputPeakIdx(1);
            else
                T3=dataHandler.sampleLength;
            end
            
            plotHandler1=plot(T1:T2,dataHandler.inputSeq(T1:T2),'b');
            plotHandler2=plot(T2:T3,dataHandler.inputSeq(T2:T3),'g');

            lw=1.3;
            set(plotHandler1,'linewidth',lw);
            set(plotHandler2,'linewidth',lw);
            set(plotHandler1,'color',[0 0 0]);
            set(plotHandler2,'color',[0 0 0]);
            set(plotHandler1,'linestyle','-');
            set(plotHandler2,'linestyle','--');

            legend({'$u(t)\ |\ t_1 \leq t < t_2$';...
                    '$u(t)\ |\ t_2 \leq t < t_3$'},...
                    'interpreter','latex');
            xlabel('$t$','fontsize',DataPlotter.labelTextSize,'interpreter','latex');
            ylabel('$u(t)$','interpreter','latex',...
                'fontsize',DataPlotter.labelTextSize,'Rotation',0,'Position',[-T3*0.30 0 0]);
            set(gca,'XTick',[T1,T2,T3],...
                'XTickLabel',{'$t_1$','$t_2$','$t_1 + T$'},...
                'fontsize',DataPlotter.tickTextSize,...
                'TickLabelInterpreter','latex');
            set(gca,'YTick',[dataHandler.inputMin,dataHandler.inputMax],...
                'YTickLabel',{'$u_{min}$','$u_{max}$'},...
                'fontsize',DataPlotter.tickTextSize,...
                'TickLabelInterpreter','latex');
 
            axis([T1-T3*0.2,...
                T3+T3*0.2,...
                dataHandler.inputMin-0.2*dataHandler.inputAmp,...
                dataHandler.inputMax+0.2*dataHandler.inputAmp]);
        end
        
        function fig = plotOutputPeriod(dataHandler)
            fig = figure;
            hold on; 
            grid off;
            
            dataHandler.circShiftInputMinMax();

            T1=1;
            T2=max([dataHandler.maxInputPeakIdx(1),1]);
            if( ~isempty(dataHandler.minInputPeakIdx) )
                T3=dataHandler.minInputPeakIdx(1);
            else
                T3=dataHandler.sampleLength;
            end
            
            plotHandler1=plot(T1:T2,dataHandler.outputSeq(T1:T2),'b');
            plotHandler2=plot(T2:T3,dataHandler.outputSeq(T2:T3),'g');

            lw=1.3;
            set(plotHandler1,'linewidth',lw);
            set(plotHandler2,'linewidth',lw);
            set(plotHandler1,'color',[0 0 0]);
            set(plotHandler2,'color',[0 0 0]);
            set(plotHandler1,'linestyle','-');
            set(plotHandler2,'linestyle','--');

            legend({'$\mathcal{P}(u,L_0)(t)\ |\ t_1 \leq t < t_2$';...
                    '$\mathcal{P}(u,L_0)(t)\ |\ t_2 \leq t < t_3$'},'interpreter','latex');
            xlabel('$t$','fontsize',DataPlotter.labelTextSize,'interpreter','latex');
            ylabel('$\mathcal{P}(u,L_0)(t)$','interpreter','latex',...
                'fontsize',DataPlotter.labelTextSize,'Rotation',0,'Position',[-T3*0.315 0 0]);
            set(gca,'XTick',[T1,T2,T3],...
                'XTickLabel',{'$t_1$','$t_2$','$t_1 + T$'},...
                'fontsize',DataPlotter.tickTextSize,...
                'TickLabelInterpreter','latex');
            set(gca,'YTick',[],'YTickLabel',{},...
                'fontsize',DataPlotter.tickTextSize,...
                'TickLabelInterpreter','latex');
            
            axis([T1-T3*0.2,...
                T3+T3*0.2,...
                dataHandler.outputMin-0.2*dataHandler.outputAmp,...
                dataHandler.outputMax+0.2*dataHandler.outputAmp]);
        end
        
        function fig = plotLoopPeriod(dataHandler)
            fig = figure;
            hold on; 
            grid off;
            
            dataHandler.circShiftInputMinMax();

            T1=1;
            T2=max([dataHandler.maxInputPeakIdx(1),1]);
            if( ~isempty(dataHandler.minInputPeakIdx) )
                T3=dataHandler.minInputPeakIdx(1);
            else
                T3=dataHandler.sampleLength;
            end
            
            plotHandler1=plot(dataHandler.inputSeq(T1:T2),dataHandler.outputSeq(T1:T2),'b');
            plotHandler2=plot(dataHandler.inputSeq(T2:T3),dataHandler.outputSeq(T2:T3),'g');

            lw=1.3;
            set(plotHandler1,'linewidth',lw);
            set(plotHandler2,'linewidth',lw);
            set(plotHandler1,'color',[0 0 0]);
            set(plotHandler2,'color',[0 0 0]);
            set(plotHandler1,'linestyle','-');
            set(plotHandler2,'linestyle','--');

            legend({'$\mathcal{P}(u,L_0)(t)\ |\ t_1 \leq t < t_2$';...
                    '$\mathcal{P}(u,L_0)(t)\ |\ t_2 \leq t < t_3$'},'interpreter','latex');
            xlabel('$u(t)$','fontsize',DataPlotter.labelTextSize,'interpreter','latex');
            ylabel('$\mathcal{P}(u,L_0)(t)$','interpreter','latex',...
                'fontsize',DataPlotter.labelTextSize,'Rotation',0,'Position',...
                [1.125*(dataHandler.inputMin-0.245*dataHandler.inputAmp) 0 0]);
            set(gca,'XTick',[dataHandler.inputMin,dataHandler.inputMax],...
                'XTickLabel',{'$u_{min}$','$u_{max}$'},...
                'fontsize',DataPlotter.tickTextSize,...
                'TickLabelInterpreter','latex');
            set(gca,'YTick',[],'YTickLabel',{},...
                'fontsize',DataPlotter.tickTextSize,...
                'TickLabelInterpreter','latex');
            
            axis([dataHandler.inputMin-0.2*dataHandler.inputAmp,...
                dataHandler.inputMax+0.2*dataHandler.inputAmp,...
                dataHandler.outputMin-0.2*dataHandler.outputAmp,...
                dataHandler.outputMax+0.2*dataHandler.outputAmp]);
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function fig = plotWeightFunc(weightFunc, inputGrid)  
            fig = figure;
            hold on; 
            grid off;
            
            % Everything outside Preisach domain to NaN
            gridLength = length(inputGrid);
            for i=1:gridLength
                ii = gridLength-i+1; %index inversion for rows
                for j=1:gridLength
                    if( inputGrid(j)>inputGrid(ii) ) 
                        weightFunc(i,j) = NaN;
                    end
                end
            end
            
            stdDevColorFactor = 2.2;    
            avgColorFactor = 3.5;

            posMu = max(weightFunc,0);
            posNnz = nnz(posMu);
            posAvg = sum(sum(posMu))/posNnz;
            posOnes = spones(posMu);
            posStdDev = sqrt(sum(sum( (posMu - posAvg.*posOnes).^2 ))/posNnz);
            
            negMu = min(weightFunc,0);
            negNnz = nnz(negMu);
            negAvg = sum(sum(negMu))/negNnz;
            negOnes = spones(negMu);
            negStdDev = sqrt(sum(sum( (negMu - negAvg.*negOnes).^2 ))/negNnz);

            maxStdDev = nanmax([posStdDev, negStdDev]);
            maxAvg = nanmax([abs(posAvg), abs(negAvg)]);

            [xMesh, yMesh] = meshgrid(inputGrid, fliplr(inputGrid));
            surf(xMesh, yMesh, weightFunc, 'edgecolor', 'none');
            xlim([inputGrid(1) inputGrid(end)]);
            ylim([inputGrid(1) inputGrid(end)]);

            caxis([-stdDevColorFactor*maxStdDev, stdDevColorFactor*maxStdDev]);

            colorbar
            colormap jet
            shading interp
            view([0 90])
            
            xlabel('$\beta$',...
                'interpreter','latex',...
                'fontsize',DataPlotter.labelTextSize);
            ylabel('$\alpha$',...
                'interpreter','latex',...
                'fontsize',DataPlotter.labelTextSize,...
                'Rotation',0);
            set(gca,'XTick',[inputGrid(1) inputGrid(end)],...
                'XTickLabel',{'$-\beta_1$','$\beta_1$'},...
                'fontsize',DataPlotter.tickTextSize,...
                'TickLabelInterpreter','latex');
            set(gca,'YTick',[inputGrid(1) inputGrid(end)],...
                'YTickLabel',{'$-\beta_1$','$\beta_1$'},...
                'fontsize',DataPlotter.tickTextSize,...
                'TickLabelInterpreter','latex');
            set(get(gca,'YLabel'),...
                'Position',get(get(gca,'Ylabel'),'Position')+[-0.065 -0.05 0]);
            
            axis square;
            grid off;
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function fig = plotInput(dataHandler)
            fig = figure;
            hold on; 
            grid off;

            T1=1;
            T2=dataHandler.sampleLength/2;
            T3=dataHandler.sampleLength;
            
            plotHandler=plot(dataHandler.indexesSeq,dataHandler.inputSeq,'b');

            lw=1.3;
            set(plotHandler,'linewidth',lw);
            set(plotHandler,'color',[0 0 0]);
            set(plotHandler,'linestyle','-');

            xlabel('t','fontsize',11);
            ylabel('u(t)','fontsize',11,'Rotation',0,'Position',...
                [-dataHandler.sampleLength*0.3 0 0]);
            set(gca,'XTick',[],'XTickLabel',{},'fontsize',10);
            set(gca,'YTick',[dataHandler.inputMin,dataHandler.inputMax],...
                'YTickLabel',{'u_{min}','u_{max}'},'fontsize',10);
 
            axis([-dataHandler.sampleLength*0.2,...
                dataHandler.sampleLength*1.2,...
                dataHandler.inputMin-0.2*dataHandler.inputAmp,...
                dataHandler.inputMax+0.2*dataHandler.inputAmp]);
        end
        
        function fig = plotOutput(dataHandler)
            fig = figure;
            hold on; 
            grid off;
            
            plotHandler=plot(dataHandler.indexesSeq,dataHandler.outputSeq,'b');

            lw=1.3;
            set(plotHandler,'linewidth',lw);
            set(plotHandler,'color',[0 0 0]);
            set(plotHandler,'linestyle','-');

            xlabel('t','fontsize',11);
            ylabel('y(t)','fontsize',11,'Rotation',0,'Position',...
                [-dataHandler.sampleLength*0.3 0 0]);
            set(gca,'XTick',[],'XTickLabel',{},'fontsize',10);
            set(gca,'YTick',[],'YTickLabel',{},'fontsize',10);
            
            axis([-dataHandler.sampleLength*0.2,...
                dataHandler.sampleLength*1.2,...
                dataHandler.outputMin-0.2*dataHandler.outputAmp,...
                dataHandler.outputMax+0.2*dataHandler.outputAmp]);
        end
        
        function fig = plotLoop(dataHandler)
            fig = figure;
            hold on; 
            grid off;
            
            plotHandler=plot(dataHandler.inputSeq, dataHandler.outputSeq,'b');

            lw=1.3;
            set(plotHandler,'linewidth',lw);
            set(plotHandler,'color',[0 0 0]);
            set(plotHandler,'linestyle','-');
            
            xlabel('u(t)','fontsize',11);
            ylabel('y(t)','fontsize',11,'Rotation',0,'Position',...
                [(dataHandler.inputMin-0.375*dataHandler.inputAmp) 0 0]);
            set(gca,'XTick',[dataHandler.inputMin,dataHandler.inputMax],...
                'XTickLabel',{'u_{min}','u_{max}'},'fontsize',10);
            set(gca,'YTick',[],'YTickLabel',{},'fontsize',10);
            
            axis([dataHandler.inputMin-0.2*dataHandler.inputAmp,...
                dataHandler.inputMax+0.2*dataHandler.inputAmp,...
                dataHandler.outputMin-0.2*dataHandler.outputAmp,...
                dataHandler.outputMax+0.2*dataHandler.outputAmp]);
        end
        
    end
    
end