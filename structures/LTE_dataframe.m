classdef LTE_dataframe
    % TODO: massive overhaul
    
    properties (Access = public)
        data
        numchannels
        fs
        history
        path
        name
        modulator
        channel
        modulationOrder
    end
    
    methods
        function obj = LTE_dataframe()
            %LTE Construct an instance of this class
            %   Detailed explanation goes here
            obj.history = {};
            obj = obj.setData([], 0);
            obj.fs = 200;
            obj.numchannels = 1;
            obj.name = '';
            obj.path = '-';
            obj.channel = NaN(1);
        end

        function lte = setData(lte, data, modulationOrder)
            lte.data = data;
            lte.history{end+1} = data;
            lte.modulationOrder = modulationOrder;
        end 
    end
end

