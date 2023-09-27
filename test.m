% % % M = 8;
% % % modulator = @(x)(pskmod(x,M,'InputType','bit'));
% % % demodulator = @(x)(pskdemod(x,M,'OutputType','bit'));
% % % SNRdB = 20;
% % % 
% % % data = 0:(M-1);
% % % data = int2bit(data, log2(M));
% % % data = reshape(data, [log2(M)*M 1]);
% % % data = randi([0 1], 30, 1);
% % % modulatedData = modulator(data);
% % % noisyData = awgn(modulatedData, SNRdB, 'measured');
% % % demodulatedData = demodulator(noisyData);
% % % 
% % % BER = sum(data ~= demodulatedData) / length(data);
% % % 
% % % % scatterplot(noisyData);
% % % % title('Noisy QPSK Signal');
% % % 
% % % bps = 1;
% % % carrier = 2;
% % % 
% % % fs = 50 * carrier;
% % % L = fs / bps;
% % % signal = repelem(modulatedData, L);
% % % signal = reshape(signal, [L*numel(modulatedData) 1]);
% % % t = (1:numel(signal))' / fs;
% % % carrier_sig = exp(1i * 2* pi * carrier * t);
% % % signal = signal .* carrier_sig;
% % % 
% % % plot(t, real(signal))
% % % 
% % % 
% obj = lte;
% obj.modulationOrder;
% bits = log2(obj.modulationOrder);
% k = floor(numel(obj.data)/bits) * bits;
% cut = obj.data(1:k);
% obj.modulatedData = obj.modulator(cut);

% bitrate = 10;
% audioFilePath = 'resources/clean_speech_signal.wav';
% % Read the audio file
% [audio, fs] = audioread(audioFilePath);
% 
% % Calculate the number of quantization levels based on bitrate
% numLevels = 2^bitrate;
% 
% % Quantize the audio data
% quantizedAudio = round((audio + 1) * (numLevels - 1) / 2);
% 
% % Convert quantized audio to binary digital data
% digitalData = de2bi(quantizedAudio, bitrate, 'left-msb');
% digitalData = reshape(digitalData', 1, []);
% 
% outputFilePath = 'resources/recieved_clean_speech.wav';
% 
% % Reshape digital data into groups of 'bitrate' bits
% digitalData = reshape(digitalData, bitrate, [])';
% 
% % Convert binary digital data to decimal values
% quantizedAudio = bi2de(digitalData, 'left-msb');
% 
% % Normalize quantized audio to the range [-1, 1]
% audio = (2 * quantizedAudio / (2^bitrate - 1)) - 1;
% 
% % Write audio to file
% audiowrite(outputFilePath, audio, fs);
% 
% % Return the path to the generated audio file
% audioFilePath = outputFilePath;
% [signal , fs] = lte.getSignal();
% downsampleFactor = 10;
% signal = downsample(signal, downsampleFactor);
% fs = fs / downsampleFactor;
% plotspectrum(signal, fs);
n = 15; % Codeword length
k = 11; % Message length
data = randi([0 1], 10 * k,1);
numel(data)
encData = encode(data,n,k,'hamming/binary');
errLoc = randerr(1,10 * n);
encData = mod(encData + errLoc',2);
decData = decode(encData,n,k,'hamming/binary');
numerr = biterr(data,decData)