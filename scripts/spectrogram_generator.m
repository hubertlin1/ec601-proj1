window = hamming(32); % set up hamming window
% create spectrogram using wav file, hamming window, 50% overlap, and 64 fft points
[S,F,T,P] = spectrogram(s1, window, [], 32);
surf(T,F,10*log10(P),'edgecolor','none'); % generate spectrogram plot
xlim([0,1000]);
ylim([0,3]);
view(0,90);
xlabel('Time');
ylabel('Frequency');
% saves the figure generated as an image
% change name to save different spectrograms as different images for unique commands
saveas(gcf,'chrome.png')