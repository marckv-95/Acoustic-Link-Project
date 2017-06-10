%% Plot Results
figure(1);
subplot(221)
plot(find_pilot);
title('Magnitude of Greatest Correlation for Pilot Signal');
subplot(222)
plot(find_wake);
title('Magnitude of Greatest Correlation for Wake Signal');

subplot(223)
plot(left_channel,'b');
title('Original Signal with Pilot and Wake');

subplot(224)
plot(received_array_2);
title('Received Array without Pilot');

