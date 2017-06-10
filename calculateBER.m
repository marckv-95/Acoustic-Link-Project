function [k, check, BER] = calculateBER(rx_bits, tx_bits)
  k = length(rx_bits);
  check = zeros(0,k);
  for i=1:k % could use vectorized operations,
    try
      check(i) = ( rx_bits(i)==tx_bits(i) ); %but this allows checking for
    catch
      sprintf('Not enough TX_bits!'); % mismatched vectors.
      break;
    end
  end
  BER = 100 * sum(~check)/k; % bit error rate as a percentage!
end
