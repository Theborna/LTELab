classdef AudioFactory
    methods (Static)
        function [digitalData, fs] = audioToDigital(audioFilePath, bitrate)
            disp(audioFilePath);
            % Read the audio file
            [audio, fs] = audioread(audioFilePath);
            
            % Calculate the number of quantization levels based on bitrate
            numLevels = 2^bitrate;
            
            % Quantize the audio data
            quantizedAudio = round((audio + 1) * (numLevels - 1) / 2);
            
            % Convert quantized audio to binary digital data
            digitalData = de2bi(quantizedAudio, bitrate, 'left-msb');
            digitalData = reshape(digitalData', 1, [])';
        end
        
        function audioFilePath = digitalToAudio(digitalData, fs, bitrate, outputFilePath)
            % Reshape digital data into groups of 'bitrate' bits
            digitalData = reshape(digitalData, bitrate, [])';
            
            % Convert binary digital data to decimal values
            quantizedAudio = bi2de(digitalData, 'left-msb');
            
            % Normalize quantized audio to the range [-1, 1]
            audio = (2 * quantizedAudio / (2^bitrate - 1)) - 1;
            
            % Write audio to file
            audiowrite(outputFilePath, audio, fs);
            
            % Return the path to the generated audio file
            audioFilePath = outputFilePath;
        end

        function [digitalData, fs] = downSample(digitalData, fs, targetFs)
            % DOWNSAMPLE Downsamples digital audio data to a target sampling rate.
            %   [DIGITALDATA, FS] = DOWNSAMPLE(DIGITALDATA, FS, TARGETFS) downsamples
            %   the input DIGITALDATA sampled at a rate FS to a new sampling rate TARGETFS.
            
            % Check if the target sampling rate is lower than or equal to the original rate
            if targetFs >= fs
                % If targetFs is not lower, return the original data and sampling rate
                return;
            end
        
            % Calculate the resampling factor as an integer
            resampleFactor = fs / targetFs;
            resampleFactor = floor(resampleFactor);
        
            % Use MATLAB's resample function to perform downsampling
            digitalData = resample(digitalData, 1, resampleFactor);
        
            % Update the sampling rate
            fs = fs / resampleFactor;
        end

    end
end
