classdef pop_importrandomdata < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        GridLayout                      matlab.ui.container.GridLayout
        NameEditField                   matlab.ui.control.EditField
        NameEditFieldLabel              matlab.ui.control.Label
        GridLayout2                     matlab.ui.container.GridLayout
        OkButton                        matlab.ui.control.Button
        CancelButton                    matlab.ui.control.Button
        NumberofchannelsSpinner         matlab.ui.control.Spinner
        NumberofchannelsSpinnerLabel    matlab.ui.control.Label
        SignaldurationsecSpinner        matlab.ui.control.Spinner
        SignaldurationsecSpinnerLabel   matlab.ui.control.Label
        Starttime0defaultSpinner        matlab.ui.control.Spinner
        StarttimeLabel                  matlab.ui.control.Label
        DatasamplingrateHzSpinner       matlab.ui.control.Spinner
        DatasamplingrateHzSpinnerLabel  matlab.ui.control.Label
        ModulationorderSpinner          matlab.ui.control.Spinner
        ModulationorderSpinnerLabel     matlab.ui.control.Label
    end

    
    properties (Access = private)
        CallingApp          ltelab
        LTE                 LTE_dataframe
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, CallingApp, LTE)
            app.CallingApp = CallingApp;
            app.LTE = LTE;
        end

        % Button pushed function: OkButton
        function cb_ok(app, event)
            fs = app.DatasamplingrateHzSpinner.Value;
            order = app.ModulationorderSpinner.Value;
            % start = app.Starttime0defaultSpinner.Value;
            duration = app.SignaldurationsecSpinner.Value;
            % channels = app.NumberofchannelsSpinner.Value;
            data = randi([0, order-1], duration*fs, 1);
            app.LTE = app.LTE.setData(data);
            app.LTE.fs = fs;
            app.LTE.name = app.NameEditField.Value;
            % update LTE from main app
            app.CallingApp.updateLTE(app.LTE);
            app.CallingApp.setToolbarState("on","on","on");
            delete(app);
        end

        % Button pushed function: CancelButton
        function cb_close(app, event)
            delete(app);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.3294 0.7686 0.8196];
            app.UIFigure.Position = [100 100 653 348];
            app.UIFigure.Name = 'MATLAB App';

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {'0x', '4x', '2x'};
            app.GridLayout.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x'};
            app.GridLayout.Padding = [50 20 50 20];
            app.GridLayout.BackgroundColor = [0.3294 0.7686 0.8196];

            % Create ModulationorderSpinnerLabel
            app.ModulationorderSpinnerLabel = uilabel(app.GridLayout);
            app.ModulationorderSpinnerLabel.FontSize = 18;
            app.ModulationorderSpinnerLabel.FontWeight = 'bold';
            app.ModulationorderSpinnerLabel.FontColor = [1 1 1];
            app.ModulationorderSpinnerLabel.Layout.Row = 2;
            app.ModulationorderSpinnerLabel.Layout.Column = 2;
            app.ModulationorderSpinnerLabel.Text = 'Modulation order';

            % Create ModulationorderSpinner
            app.ModulationorderSpinner = uispinner(app.GridLayout);
            app.ModulationorderSpinner.Limits = [0 Inf];
            app.ModulationorderSpinner.ValueDisplayFormat = '%.0f';
            app.ModulationorderSpinner.HorizontalAlignment = 'center';
            app.ModulationorderSpinner.FontWeight = 'bold';
            app.ModulationorderSpinner.Layout.Row = 2;
            app.ModulationorderSpinner.Layout.Column = 3;

            % Create DatasamplingrateHzSpinnerLabel
            app.DatasamplingrateHzSpinnerLabel = uilabel(app.GridLayout);
            app.DatasamplingrateHzSpinnerLabel.FontSize = 18;
            app.DatasamplingrateHzSpinnerLabel.FontWeight = 'bold';
            app.DatasamplingrateHzSpinnerLabel.FontColor = [1 1 1];
            app.DatasamplingrateHzSpinnerLabel.Layout.Row = 3;
            app.DatasamplingrateHzSpinnerLabel.Layout.Column = 2;
            app.DatasamplingrateHzSpinnerLabel.Text = 'Data sampling rate (Hz)';

            % Create DatasamplingrateHzSpinner
            app.DatasamplingrateHzSpinner = uispinner(app.GridLayout);
            app.DatasamplingrateHzSpinner.Limits = [0 Inf];
            app.DatasamplingrateHzSpinner.ValueDisplayFormat = '%.0f';
            app.DatasamplingrateHzSpinner.HorizontalAlignment = 'center';
            app.DatasamplingrateHzSpinner.FontWeight = 'bold';
            app.DatasamplingrateHzSpinner.Layout.Row = 3;
            app.DatasamplingrateHzSpinner.Layout.Column = 3;

            % Create StarttimeLabel
            app.StarttimeLabel = uilabel(app.GridLayout);
            app.StarttimeLabel.FontSize = 18;
            app.StarttimeLabel.FontColor = [1 1 1];
            app.StarttimeLabel.Layout.Row = 4;
            app.StarttimeLabel.Layout.Column = 2;
            app.StarttimeLabel.Text = 'Start time (0 -> default)';

            % Create Starttime0defaultSpinner
            app.Starttime0defaultSpinner = uispinner(app.GridLayout);
            app.Starttime0defaultSpinner.Limits = [0 Inf];
            app.Starttime0defaultSpinner.ValueDisplayFormat = '%.0f';
            app.Starttime0defaultSpinner.HorizontalAlignment = 'center';
            app.Starttime0defaultSpinner.FontWeight = 'bold';
            app.Starttime0defaultSpinner.Layout.Row = 4;
            app.Starttime0defaultSpinner.Layout.Column = 3;

            % Create SignaldurationsecSpinnerLabel
            app.SignaldurationsecSpinnerLabel = uilabel(app.GridLayout);
            app.SignaldurationsecSpinnerLabel.FontSize = 18;
            app.SignaldurationsecSpinnerLabel.FontColor = [1 1 1];
            app.SignaldurationsecSpinnerLabel.Layout.Row = 5;
            app.SignaldurationsecSpinnerLabel.Layout.Column = 2;
            app.SignaldurationsecSpinnerLabel.Text = 'Signal duration (sec)';

            % Create SignaldurationsecSpinner
            app.SignaldurationsecSpinner = uispinner(app.GridLayout);
            app.SignaldurationsecSpinner.Limits = [0 Inf];
            app.SignaldurationsecSpinner.ValueDisplayFormat = '%.0f';
            app.SignaldurationsecSpinner.HorizontalAlignment = 'center';
            app.SignaldurationsecSpinner.FontWeight = 'bold';
            app.SignaldurationsecSpinner.Layout.Row = 5;
            app.SignaldurationsecSpinner.Layout.Column = 3;

            % Create NumberofchannelsSpinnerLabel
            app.NumberofchannelsSpinnerLabel = uilabel(app.GridLayout);
            app.NumberofchannelsSpinnerLabel.FontSize = 18;
            app.NumberofchannelsSpinnerLabel.FontWeight = 'bold';
            app.NumberofchannelsSpinnerLabel.FontColor = [1 1 1];
            app.NumberofchannelsSpinnerLabel.Layout.Row = 6;
            app.NumberofchannelsSpinnerLabel.Layout.Column = 2;
            app.NumberofchannelsSpinnerLabel.Text = 'Number of channels';

            % Create NumberofchannelsSpinner
            app.NumberofchannelsSpinner = uispinner(app.GridLayout);
            app.NumberofchannelsSpinner.Limits = [1 Inf];
            app.NumberofchannelsSpinner.ValueDisplayFormat = '%.0f';
            app.NumberofchannelsSpinner.HorizontalAlignment = 'center';
            app.NumberofchannelsSpinner.FontWeight = 'bold';
            app.NumberofchannelsSpinner.Layout.Row = 6;
            app.NumberofchannelsSpinner.Layout.Column = 3;
            app.NumberofchannelsSpinner.Value = 1;

            % Create GridLayout2
            app.GridLayout2 = uigridlayout(app.GridLayout);
            app.GridLayout2.RowHeight = {'1x'};
            app.GridLayout2.Padding = [0 0 0 0];
            app.GridLayout2.Layout.Row = 8;
            app.GridLayout2.Layout.Column = 3;
            app.GridLayout2.BackgroundColor = [0.3294 0.7686 0.8196];

            % Create CancelButton
            app.CancelButton = uibutton(app.GridLayout2, 'push');
            app.CancelButton.ButtonPushedFcn = createCallbackFcn(app, @cb_close, true);
            app.CancelButton.Layout.Row = 1;
            app.CancelButton.Layout.Column = 1;
            app.CancelButton.Text = 'Cancel';

            % Create OkButton
            app.OkButton = uibutton(app.GridLayout2, 'push');
            app.OkButton.ButtonPushedFcn = createCallbackFcn(app, @cb_ok, true);
            app.OkButton.Layout.Row = 1;
            app.OkButton.Layout.Column = 2;
            app.OkButton.Text = 'Ok';

            % Create NameEditFieldLabel
            app.NameEditFieldLabel = uilabel(app.GridLayout);
            app.NameEditFieldLabel.FontSize = 18;
            app.NameEditFieldLabel.FontWeight = 'bold';
            app.NameEditFieldLabel.FontColor = [1 1 1];
            app.NameEditFieldLabel.Layout.Row = 1;
            app.NameEditFieldLabel.Layout.Column = 2;
            app.NameEditFieldLabel.Text = 'Name';

            % Create NameEditField
            app.NameEditField = uieditfield(app.GridLayout, 'text');
            app.NameEditField.CharacterLimits = [0 24];
            app.NameEditField.HorizontalAlignment = 'center';
            app.NameEditField.FontSize = 18;
            app.NameEditField.Placeholder = 'rnd';
            app.NameEditField.Layout.Row = 1;
            app.NameEditField.Layout.Column = 3;

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = pop_importrandomdata(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end