classdef ModulatorFactory
    methods (Static)
        function modulator = createModulator(type, inputType, varargin)
            switch type
                case 'PSK'
                    order = varargin{1};
                    modulator = @(data) pskmod(data, order, 0, 'InputType', inputType);
                case 'QAM'
                    order = varargin{1};
                    modulator = @(data) qammod(data, order, 'gray', 'InputType', inputType);
                case 'ASK'
                    modulator = @(data) data / max(max(data), 1);
                case 'FSK'
                    order = varargin{1};
                    modulator = @(data) fskmod(data, order, 'InputType', inputType);
                case 'APSK'
                    if numel(varargin) < 2
                        error('Specify alpha values and modulation order for APSK');
                    end
                    order = varargin{1};
                    radii = varargin{2};
                    modulator = @(data) apskmod(data, order, radii, 'InputType', inputType);
                otherwise
                    error('Invalid modulation type');
            end
        end
        
        function demodulator = createDemodulator(type, outputType, varargin)
            switch type
                case 'PSK'
                    order = varargin{1};
                    demodulator = @(modulatedData) pskdemod(modulatedData, order, 0,'OutputType', outputType);
                case 'QAM'
                    order = varargin{1};
                    demodulator = @(modulatedData) qamdemod(modulatedData, order, 'gray','OutputType', outputType);
                case 'ASK'
                    demodulator = @(modulatedData) modulatedData / min(data); % TODO FIX
                case 'FSK'
                    order = varargin{1};
                    demodulator = @(modulatedData) fskdemod(modulatedData, order,'OutputType', outputType);
                case 'APSK'
                    if numel(varargin) < 2
                        error('Specify alpha values and modulation order for APSK');
                    end
                    order = varargin{1};
                    radii = varargin{2};
                    demodulator = @(modulatedData) apskdemod(modulatedData, order, radii,'OutputType', outputType);
                otherwise
                    error('Invalid modulation type');
            end
        end
    end
end
