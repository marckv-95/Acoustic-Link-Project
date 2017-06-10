function [tx_bits] = genBinaryBits(k)
  tx_bits = rand(k,1) > 0.5;
  fileID = fopen('tmp_txbits.csv','w');
  fprintf(fileID,'%1f \n',tx_bits);
  fclose(fileID); 
end

% %% AT TRANSMITTER:
% [tx_bits] = genBinaryBits(10);
%
% %% AT RECEIVER:
% [rx_bits] = randomBinaryPerturbation(tx_bits); % just for testing..
% tx_bits = csvread('tmp_txbits.csv');
% [k, check, BER] = calculateBER(rx_bits, tx_bits)
% f = figure(); hold all;
% plot(tx_bits,'Color','g','LineWidth',5);
% plot(rx_bits,'Color','b','LineWidth',3);
% legend({'Transmitted', 'Received'}); title(strcat('BER:',num2str(BER)));
