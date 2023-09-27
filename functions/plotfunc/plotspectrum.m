function plotspectrum(signal, Fs)
%PLOTSPECTRUM Plots the time-frequency analysis, signal, and Fourier transform of a signal.
%   PLOTSPECTRUM(SIGNAL, FS) plots the time-frequency representation of the
%   input SIGNAL, the SIGNAL itself, and its Fourier transform with a given
%   sampling frequency FS.
limit = 100000;
if numel(signal) > limit
    signal = signal(1:limit);
end
% Define the number of scales for the CWT
numScales = 128; % Number of scales for the wavelet transform

% Define the wavelet type (you can choose different types)
wavelet = 'morl';

% Compute the continuous wavelet transform (CWT)
scales = 1:numScales;
coeffs = cwt(signal, scales, wavelet);

% Create a time vector
t = (0:length(signal)-1) / Fs;

% Create a logarithmic frequency axis for the wavelet transform
freqs = scal2frq(scales, wavelet, 1/Fs);
logFreqs = log10(freqs);

% Compute the Fourier transform
N = length(signal);
f = (-N/2:N/2-1) * Fs / N;
fourier = fftshift(fft(signal));

% Create a figure with subplots
figure;

% Subplot 1: Signal
subplot(2, 4, [1, 2]);
plot(t, signal, 'b', 'LineWidth', 1.2);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Subplot 2: Fourier Transform
subplot(2, 4, [5, 6]);
plot(f, abs(fourier), 'r', 'LineWidth', 1.2);
title('Fourier Transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
grid on;

% Subplot 3: Wavelet Transform
subplot(2, 4, [3, 4, 7, 8]);
imagesc(t, logFreqs, abs(coeffs));
set(gca, 'YDir', 'normal');
colormap('jet');
title('Continuous Wavelet Transform');
xlabel('Time (s)');
ylabel('Log Frequency (Hz)');
colorbar;

end
