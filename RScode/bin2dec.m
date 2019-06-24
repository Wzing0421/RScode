function [ dec ] = bin2dec( bin )
%BIN2DEC Summary of this function goes here
%   Detailed explanation goes here
dec = 0;
for ii = 1:1:4
    if (bin(1,ii)~=0)
        dec = dec + 2^(4-ii);
    end
end

end

