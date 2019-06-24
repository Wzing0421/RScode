function [ ret ] = RsSymbolMul( mul1, mul2 )
%RSSYMBOLMUL Summary of this function goes here
%   Detailed explanation goes here

%从一个十进制数转到本源元的方幂表示，这个数字代表本源元的方幂
int2benyuanyuan = [0,1,4,2,8,5,10,3,14,9,7,6,13,11,12];
%从本原元的方幂表示变成十进制数，这是对应关系，注意本原元方幂是从0开始的，索引需要加1
benyuanyuan2int = [1,2,4,8,3,6,12,11,5,10,7,14,15,13,9];

%判断输入是否合法，这个0有待商榷
if (mul1 >15 || mul1 <0)
    disp('invalid input mul1!\n');
    return ;
end;
if (mul2 >15 || mul2 <0)
    disp('invalid input mul2!\n');
    return;
end;

 % 输入是0的情况，这是我为了之后的编码电路的简便加的
if (mul1 ==0 || mul2 == 0)
    ret =  0;
else % 正常情况
    fangmi = mod(int2benyuanyuan(1,mul1) + int2benyuanyuan(1,mul2),15);
    ret = benyuanyuan2int(1, fangmi+1);
end;

end


