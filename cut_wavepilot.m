% match filter to remove wake and pilot signals

filename = uigetfile({'*.wav'},'Select Your Recording');
[audio_array,fs] = audioread(filename);

%fs = 22050; % audacity default sample rate
% audio_array = x;
% Get length of recording
N = length(audio_array(:,1)) ;
t =  0 : 1/fs : N/fs - 1/fs;
f_pilot = 3000;
f_wake = 4000;
% Take only left channel of the recording
left_channel = audio_array(:,1);
left_length = length(left_channel);

%% Find pilot
pilot_finder = sawtooth_gen(f_pilot); % make the pilot sawtooth
pilot_length = length(pilot_finder);
find_pilot = xcorr(left_channel,pilot_finder); % finding xtrema for similarity
find_pilot_length = length(find_pilot); % length of xcorr for pilot finder
[~, pilot_index] = max(abs(find_pilot));   % find max xcorr / max value ommited
pilot_index = pilot_index - N + 1; % actual position in the left array
%% Remove pilot
received_array_1 = left_channel(pilot_index+pilot_length:end);

%% Find Wake 
wake_finder = sawtooth_gen(f_wake);
wake_length = length(wake_finder); %need length in order to delete/cut later
find_wake = xcorr(received_array_1, wake_finder);
find_wake_length = length(find_wake); %length of full xcorr
[~, wake_index] = max(abs(find_wake));   % find max xcorr / max value ommited
N = length(received_array_1);

if( wake_length > N)
    wake_index_final = wake_index - wake_length;
else
    wake_index_final = wake_index - N + 1; % actual position in the left array
end
% Remove Wake
received_array_2 = received_array_1(1:wake_index_final-1);



