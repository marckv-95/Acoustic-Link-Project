function [x] = transformed_input(input_array)
fs = 96000;
t = 0:1/fs:0.1; % change to change rate

f_pilot = 3000; % pilot frequency
f_wake = 4000; % wake frequency

f_0 = 200; % zero frequency
f_1 = 1200; % one frequency
f_2 = 700;

n = length(input_array);
pilot_saw = sawtooth_gen(f_pilot);
pilot_length = length(pilot_saw);
wake_saw = sawtooth_gen(f_wake);
wake_length = length(wake_saw);

length_bit = length(t);

previous = 1;

%% make new array with spacing in between bits
new_input = zeros(1, 2*n);
for i = 1:n
    for j = 2*i-1
        for k = 2*i
            new_input(j) = input_array(i);
            new_input(k) = 2;
        end
    end
end

%% set new to zero
new_bit = zeros(1,length_bit*2*n); % setting new bit

for i = 1:2*n
    if new_input(i) == 0
        new_bit(previous:previous+length_bit-1) = cos(2*pi*f_0*t);
    elseif new_input(i) == 1
        new_bit(previous:previous+length_bit-1) = cos(2*pi*f_1*t);
    else
        new_bit(previous:previous+length_bit-1) = cos(2*pi*f_2*t);
    end
    previous = previous + length_bit;
end
new_length = length(new_bit);

%% transformed input array
x = zeros(1,pilot_length+new_length+wake_length);
x(1:pilot_length) = pilot_saw;
x(pilot_length+1:pilot_length+new_length) = new_bit;
x(pilot_length+new_length+1:pilot_length+new_length+wake_length) = wake_saw;

figure(1)
plot(x)
title('Input Sequence');
sound(x,fs)