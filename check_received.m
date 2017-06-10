% Transform Received into 1 and 0
close all
% zero bit frequency is 200
% one bit frequency is 1200
% pause bit frequency is 700

check_array = received_array_2; % this can be changed into function input
length_received = length(received_array_2); % this will be redone for now it goes with other script
fs = 96000; % sampling frequency will also be input
t = 0:1/fs:0.1; % keep this since our length will stay
window_length = length(t); % window length for computing block fft

NFFT = 5000000;
k_1 = -NFFT/2:(NFFT/2-1); % set fft shift x axis
f_1 = (k_1.*fs)./NFFT;

bit_0 = 200;
bit_1 = 1200;
bit_2 = 700;
i = 1;

for( j =  1 : window_length : length_received - 4*window_length )
    current_fft = abs( fftshift ( fft( check_array( j : j + window_length ) , NFFT ) ) );
    [max_magnitude, max_index] = max(current_fft);
    max_frequency = f_1(max_index);
    bit_check_0 = abs ( abs( max_frequency) - bit_0);
    bit_check_1 = abs ( abs( max_frequency) - bit_1);
    bit_check_2 = abs ( abs( max_frequency) - bit_2);
    if( bit_check_0 < 50 )
        new_x(i) = 0;
        i = i + 1;
    elseif (bit_check_1 < 50)
        new_x(i) = 1;
        i = i + 1;
    end
end

m = csvread('tmp_txbits.csv')' ;


figure(1);
hold on
plot(f_1, current_fft);
plot(f_1(max_index), current_fft(max_index), 'r*');
xlim( [-1500 , 1500] ) ;
title('Frequency of Current Window','FontSize', 16);
xlabel('Frequencies','FontSize', 15);
ylabel('Magnitude','FontSize', 15);
hold off