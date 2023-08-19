classdef LTE_dataframe
    %LTE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = public)
        data
        fs
        history
        name
    end
    
    methods
        function obj = LTE_dataframe()
            %LTE Construct an instance of this class
            %   Detailed explanation goes here
            obj.history = {};
            obj = obj.setData([]);
            obj.fs = 200;
            obj.name = '';
        end

        function lte = setData(lte, data)
            lte.data = data;
            lte.history{end+1} = data;
        end 
    end
end

