classdef ltelab_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                matlab.ui.Figure
        FileMenu                matlab.ui.container.Menu
        ImportdataMenu          matlab.ui.container.Menu
        MatlabArrayMenu         matlab.ui.container.Menu
        AsciifloatfileMenu      matlab.ui.container.Menu
        RandomdataMenu          matlab.ui.container.Menu
        LoadexistingsetMenu     matlab.ui.container.Menu
        QuitMenu                matlab.ui.container.Menu
        EditMenu                matlab.ui.container.Menu
        ToolsMenu               matlab.ui.container.Menu
        PlotMenu                matlab.ui.container.Menu
        DatasetsMenu            matlab.ui.container.Menu
        HelpMenu                matlab.ui.container.Menu
        AboutLTELabMenu         matlab.ui.container.Menu
        LTELabTutorialMenu      matlab.ui.container.Menu
        EmailtheLTELabteamMenu  matlab.ui.container.Menu
        GridLayout              matlab.ui.container.GridLayout
        HeaderLabel             matlab.ui.control.Label
    end

    
    properties (Access = private)
        LTE % Description
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Menu selected function: RandomdataMenu
        function cb_importrandomdata(app, event)
            pop_importrandomdata
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.3294 0.7686 0.8196];
            app.UIFigure.Position = [100 100 661 492];
            app.UIFigure.Name = 'MATLAB App';

            % Create FileMenu
            app.FileMenu = uimenu(app.UIFigure);
            app.FileMenu.Text = 'File';

            % Create ImportdataMenu
            app.ImportdataMenu = uimenu(app.FileMenu);
            app.ImportdataMenu.Text = 'Import data';

            % Create MatlabArrayMenu
            app.MatlabArrayMenu = uimenu(app.ImportdataMenu);
            app.MatlabArrayMenu.Text = 'Matlab Array';

            % Create AsciifloatfileMenu
            app.AsciifloatfileMenu = uimenu(app.ImportdataMenu);
            app.AsciifloatfileMenu.Text = 'Ascii/float file';

            % Create RandomdataMenu
            app.RandomdataMenu = uimenu(app.ImportdataMenu);
            app.RandomdataMenu.MenuSelectedFcn = createCallbackFcn(app, @cb_importrandomdata, true);
            app.RandomdataMenu.Text = 'Random data';

            % Create LoadexistingsetMenu
            app.LoadexistingsetMenu = uimenu(app.FileMenu);
            app.LoadexistingsetMenu.Text = 'Load existing set';

            % Create QuitMenu
            app.QuitMenu = uimenu(app.FileMenu);
            app.QuitMenu.Text = 'Quit';

            % Create EditMenu
            app.EditMenu = uimenu(app.UIFigure);
            app.EditMenu.Enable = 'off';
            app.EditMenu.Text = 'Edit';

            % Create ToolsMenu
            app.ToolsMenu = uimenu(app.UIFigure);
            app.ToolsMenu.Enable = 'off';
            app.ToolsMenu.Text = 'Tools';

            % Create PlotMenu
            app.PlotMenu = uimenu(app.UIFigure);
            app.PlotMenu.Enable = 'off';
            app.PlotMenu.Text = 'Plot';

            % Create DatasetsMenu
            app.DatasetsMenu = uimenu(app.UIFigure);
            app.DatasetsMenu.Text = 'Datasets';

            % Create HelpMenu
            app.HelpMenu = uimenu(app.UIFigure);
            app.HelpMenu.Text = 'Help';

            % Create AboutLTELabMenu
            app.AboutLTELabMenu = uimenu(app.HelpMenu);
            app.AboutLTELabMenu.Text = 'About LTELab';

            % Create LTELabTutorialMenu
            app.LTELabTutorialMenu = uimenu(app.HelpMenu);
            app.LTELabTutorialMenu.Text = 'LTELab Tutorial';

            % Create EmailtheLTELabteamMenu
            app.EmailtheLTELabteamMenu = uimenu(app.HelpMenu);
            app.EmailtheLTELabteamMenu.Text = 'Email the LTELab team';

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {'1x', '4x', '1x'};
            app.GridLayout.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x'};
            app.GridLayout.BackgroundColor = [0.3294 0.7686 0.8196];

            % Create HeaderLabel
            app.HeaderLabel = uilabel(app.GridLayout);
            app.HeaderLabel.FontSize = 24;
            app.HeaderLabel.FontWeight = 'bold';
            app.HeaderLabel.FontColor = [1 1 1];
            app.HeaderLabel.Layout.Row = 1;
            app.HeaderLabel.Layout.Column = 2;
            app.HeaderLabel.Text = 'Header';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = ltelab_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

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