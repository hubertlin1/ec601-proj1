% Used to record and save reference wav files for commands

fs = 11025; % sample rate

fprintf('Press any key to start recording...\n');
% create the recorder, 8 bit, 1 channel
recorder = audiorecorder(fs,8,1);
pause; % wait til key is pressed to start recording
fprintf('Recording...\n');
% record 2 seconds of data, holds control til recording complete
recordblocking(recorder,2);
% get the samples
x = getaudiodata(recorder);
fprintf('Finished recording.\n');

filename = 'powerpoint.wav'; % name of file data will be written to
audiowrite(filename,x,fs); % write to wav file named above

sound(x,fs); % playback recorded sound for verification