function [ bin1 ] = dec2bin( dec )
%DEC2BIN Summary of this function goes here
%   Detailed explanation goes here
%change the dec input to binary
bin1 = zeros(1,4);
for ii = 3:-1:0
    if dec >= 2^ii
        bin1(1,4-ii)=1;
        dec = dec-2^ii;
    end;
end

end

