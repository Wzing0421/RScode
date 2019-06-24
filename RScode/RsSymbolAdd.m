function [ ret ] = RsSymbolAdd( add1, add2 )% “+”号 的前后两个操作数
%RSSYMBOLADD Summary of this function goes here
%   Detailed explanation goes here

%if the input num is valid
if (add1<0 || add1 >15)
    disp('invalid add1!');
    return;
end
if (add2<0 || add2 >15)
    disp('invalid add2!');
    return;
end

%change the dec input to binary
bin1 = zeros(1,4);
bin2 = zeros(1,4);
for ii = 3:-1:0
    if add1 >= 2^ii
        bin1(1,4-ii)=1;
        add1 = add1-2^ii;
    end;
    if add2 >= 2^ii
        bin2(1,4-ii)=1;
        add2 = add2-2^ii;
    end;
end
res = bitxor(bin1,bin2);
temp = 0;
for ii = 4:-1:1
    if res(1,ii) ==1
        temp = temp + 2^(4-ii);
    end;
end
ret = temp;
end

