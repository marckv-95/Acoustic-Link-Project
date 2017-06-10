tx_bits = csvread('tmp_txbits.csv')';
rx_bits = new_x;
[k, check, BER] = calculateBER(rx_bits, tx_bits) 