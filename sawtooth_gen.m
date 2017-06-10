%sawtooth generator 

function [sawtooth_array] = sawtooth_gen(freq)
time = 5; %seconds
dt = 1/freq;
t= 0:dt:time-dt;
sawtooth_array = sawtooth(2*pi*t);
end
