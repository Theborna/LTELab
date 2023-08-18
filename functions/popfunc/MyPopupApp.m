classdef MyPopupApp < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = private)
        UIFigure          matlab.ui.Figure
        GenerateButton    matlab.ui.control.Button
        SNRSliderLabel    matlab.ui.control.Label
        SNRSlider         matlab.ui.control.Slider
        BERLabel          matlab.ui.control.Label
        BERValue          matlab.ui.control.Label
        SignalAxes        matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % Initialize components or variables here
        end

        % Button pushed function: GenerateButton
        function GenerateButtonPushed(app, ~)
            modulator = comm.QPSKModulator();
            demodulator = comm.QPSKDemodulator();
            SNRdB = app.SNRSlider.Value;
            
            data = randi([0 1], 1000, 1);
            modulatedData = modulator(data);
            noisyData = awgn(modulatedData, SNRdB, 'measured');
            demodulatedData = demodulator(noisyData);
            
            BER = sum(data ~= demodulatedData) / length(data);
            app.BERValue.Text = sprintf('BER: %.4f', BER);
            
            plot(app.SignalAxes, real(noisyData), imag(noisyData), '.');
            xlabel(app.SignalAxes, 'I');
            ylabel(app.SignalAxes, 'Q');
            title(app.SignalAxes, 'Noisy QPSK Signal');
        end

        % Value changed function: SNRSlider
        function SNRSliderValueChanged(app, ~)
            value = app.SNRSlider.Value;
            app.SNRSliderLabel.Text = sprintf('SNR (dB): %.1f', value);
        end
    end

    % App initialization and construction
    methods (Access = private)
        function createComponents(app)
            % Create UIFigure
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'LTE 4G Simulation App';

            % Create GenerateButton
            app.GenerateButton = uibutton(app.UIFigure, 'push');
            app.GenerateButton.ButtonPushedFcn = createCallbackFcn(app, @GenerateButtonPushed, true);
            app.GenerateButton.Position = [280 40 75 22];
            app.GenerateButton.Text = 'Generate';

            % Create SNRSliderLabel
            app.SNRSliderLabel = uilabel(app.UIFigure);
            app.SNRSliderLabel.HorizontalAlignment = 'right';
            app.SNRSliderLabel.Position = [160 68 56 22];
            app.SNRSliderLabel.Text = 'SNR (dB):';

            % Create SNRSlider
            app.SNRSlider = uislider(app.UIFigure);
            app.SNRSlider.Limits = [-10 20];
            app.SNRSlider.MajorTicks = [-10 -5 0 5 10 15 20];
            app.SNRSlider.MajorTickLabels = {'-10', '-5', '0', '5', '10', '15', '20'};
            app.SNRSlider.ValueChangedFcn = createCallbackFcn(app, @SNRSliderValueChanged, true);
            app.SNRSlider.Position = [229 77 200 3];
            app.SNRSlider.Value = 10;

            % Create BERLabel
            app.BERLabel = uilabel(app.UIFigure);
            app.BERLabel.Position = [230 120 55 22];
            app.BERLabel.Text = 'Bit Error Rate:';

            % Create BERValue
            app.BERValue = uilabel(app.UIFigure);
            app.BERValue.Position = [295 120 100 22];
            app.BERValue.Text = '0.0000';

            % Create SignalAxes
            app.SignalAxes = uiaxes(app.UIFigure);
            title(app.SignalAxes, 'Noisy QPSK Signal');
            xlabel(app.SignalAxes, 'I');
            ylabel(app.SignalAxes, 'Q');
            app.SignalAxes.Position = [40 170 560 280];
        end
    end

    methods (Access = public)

        % Construct app
        function app = MyPopupApp

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end
    end
end
