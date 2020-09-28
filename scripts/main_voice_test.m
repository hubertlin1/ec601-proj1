% Used to record voice, generate spectrogram image, and compare with all
% reference images to determine the closest match; executes the action
% mapped to that command

 % runs continously until user force stops script
while true
    fs = 11025; % sample rate

    fprintf('Press any key to start recording...\n');
    % create the recorder, 8 bits, 1 channel
    recorder = audiorecorder(fs,8,1);
    pause; % press any key when ready to record voice
    fprintf('Recording...\n');
    % record 2 seconds of data
    recordblocking(recorder,2);
    % get the samples
    x = getaudiodata(recorder);
    fprintf('Finished recording.\n');

    filename = 'command.wav'; % name of file you want to save as
    audiowrite(filename,x,fs); % write data to wav file named above
    pause(1);
    [s1,fs1] = audioread('command.wav'); % read data from previous wav file
    s1 = s1(find(s1>0,1):end);
    pause(1);
    window = hamming(32); 
    [S,F,T,P] = spectrogram(s1, window, [], 32); % generate spectrogram
    % turn figure visibility off to avoid popping up every time we record
    f = figure('visible', 'off');
    surf(T,F,10*log10(P),'edgecolor','none');
    xlim([0,1000]);
    ylim([0,3]);
    view(0,90);
    xlabel('Time');
    ylabel('Frequency');
    saveas(gcf,'command.png'); % save spectrogram as image

    command = imread('command.png'); % read the previously saved image

    chrome = imread('chrome.png'); % read reference image 1
    resA = immse(command,chrome)

    excel = imread('excel.png'); % read reference image 2
    resB = immse(command,excel)
    
    powerpoint = imread('powerpoint.png'); % read reference image 2
    resC = immse(command,powerpoint)

    % compare results and pick smallest one; execute that command
    if(resA<resB && resA<resC)
        system('start chrome'); % opens up new chrome browser page
    end
    if(resB<resA && resB<resC)
        system('start excel'); % opens new notepad file
    end
    if(resC<resA && resC<resB)
        system('start powerpnt'); % opens new notepad file
    end
end
