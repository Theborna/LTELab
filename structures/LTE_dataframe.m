classdef LTE_dataframe
    % TODO: massive overhaul
    
    properties (Access = public)
        data
        numchannels
        bps
        carrierFreq
        history
        path
        name
        modulator
        demodulator
        modulatedData
        receivedData
        channel
        modulationOrder
        fs
        messageLen
        codeLen
    end
    
    methods
        function obj = LTE_dataframe()
            %LTE Construct an instance of this class
            %   Detailed explanation goes here
            obj.history = {};
            obj = obj.setData([], 0);
            obj.bps = 200;
            obj.numchannels = 1;
            obj.name = '';
            obj.path = '-';
            obj.channel = {};
            obj.modulatedData = NaN(1);
            obj.receivedData = NaN(1);
            obj.fs = 44100;
            obj.messageLen = 11;
            obj.codeLen = 15;
        end
        
        function obj = modulate(obj)
            bits = log2(obj.modulationOrder);
            k = floor(numel(obj.data)/bits) * bits;
            cut = obj.data(1:k);
            obj.modulatedData = obj.modulator(cut);
        end

        function obj = demodulate(obj)
            obj.receivedData = obj.demodulator(obj.modulatedData);
            obj.receivedData(end:numel(obj.data)) = 0;
        end

        function obj = encode(obj)
            obj.data = encode(obj.data,15,11,'hamming/binary');
        end

        function obj = decode(obj)
            obj.receivedData = decode(obj.receivedData,15,11,...
                'hamming/binary');
        end

        function lte = setData(lte, data, bps)
%             l = numel(data);
%             data = data(1:(floor(l/obj.messageLen)*lte.messageLen));
            lte.data = data;
            lte.history{end+1} = data;
            lte.bps = bps;
        end 

        function lte = applyChannel(lte)
            for i = 1:numel(lte.channel)
                lte.modulatedData = lte.channel{i}(lte.modulatedData);
            end
        end

        function lte = addChannel(lte, channel)
            lte.channel{end+1} = channel;
        end

        function lte = setCarrierFreq(lte, carrier)
            lte.carrierFreq = max(carrier, lte.bps); % fix 
        end

        function [signal, fs] = getSignal(lte)
            carrier = lte.carrierFreq;
            fs = 50 * carrier;
            L = fs / lte.bps;
            L = round(L);
            signal = repelem(lte.modulatedData, L);
            signal = reshape(signal, [L*numel(lte.modulatedData) 1]);
            t = (1:numel(signal))' / fs;
            carrier_sig = exp(1i * 2* pi * carrier * t);
            signal = signal .* carrier_sig;
        end
    end
end

