% Set the sample rate and duration for recording
Fs = 44100; % Sample rate (Hz)
duration = 5; % Duration of each recording (seconds)

% Create audio recorder objects for both signals
recObj1 = audiorecorder(Fs, 16, 1);
recObj2 = audiorecorder(Fs, 16, 1);

% Record the first audio signal
disp('Start speaking for signal 1.');
recordblocking(recObj1, duration);
disp('End of Recording for signal 1.');

% Record the second audio signal
disp('Start speaking for signal 2.');
recordblocking(recObj2, duration);
disp('End of Recording for signal 2.');

% Get the recorded audio data for both signals
audioData1 = getaudiodata(recObj1);
audioData2 = getaudiodata(recObj2);

% Compute the FFT of each signal
L = length(audioData1);
Y1 = fft(audioData1);
f1 = Fs*(0:(L/2))/L; % Frequency axis for signal 1

L = length(audioData2);
Y2 = fft(audioData2);
f2 = Fs*(0:(L/2))/L; % Frequency axis for signal 2

% Compute the cosine similarity between the two spectra
cosine_similarity = dot(abs(Y1), abs(Y2)) / (norm(Y1) * norm(Y2));

% Compute the Pearson correlation coefficient between the two spectra
corr_coef = corrcoef(abs(Y1), abs(Y2));
pearson_similarity = corr_coef(1, 2);

% Plot the audio waveforms
t1 = (0:length(audioData1)-1) / Fs;
t2 = (0:length(audioData2)-1) / Fs;
figure;
subplot(2, 2, 1);
plot(t1, audioData1);
xlabel('Time (s)');
ylabel('Amplitude');
title('Signal 1 - Audio Waveform');

subplot(2, 2, 2);
plot(t2, audioData2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Signal 2 - Audio Waveform');

% Plot the frequency spectra
subplot(2, 2, 3);
plot(f1, abs(Y1(1:L/2+1)));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Signal 1 - Frequency Spectrum');

subplot(2, 2, 4);
plot(f2, abs(Y2(1:L/2+1)));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Signal 2 - Frequency Spectrum');

% Print the similarity measures
disp(['Cosine Similarity: ', num2str(cosine_similarity)]);
disp(['Pearson Correlation Coefficient: ', num2str(pearson_similarity)]);
