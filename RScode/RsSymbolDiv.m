function [ ret ] = RsSymbolDiv( div1, div2 )
%RSSYMBOLDIV Summary of this function goes here
%   Detailed explanation goes here

%从一个十进制数转到本源元的方幂表示，这个数字代表本源元的方幂
int2benyuanyuan = [0,1,4,2,8,5,10,3,14,9,7,6,13,11,12];
%从本原元的方幂表示变成十进制数，这是对应关系，注意本原元方幂是从0开始的，索引需要加1
benyuanyuan2int = [1,2,4,8,3,6,12,11,5,10,7,14,15,13,9];

%判断输入是否合法
if (div1 >15 || div1 <=0)
    disp('invalid input div1!\n');
    return ;
end;
if (div2 >15 || div2 <=0)
    disp('invalid input div2!\n');
    return;
end;

%除法相当于把除数取倒数然后和被除数相乘
fangmi_divider = int2benyuanyuan(1,div2);
if fangmi_divider ~=0 %0的时候不需要取倒数
    fangmi_divider = 15 - fangmi_divider;
end;
dividernow = benyuanyuan2int(1, fangmi_divider+1);
fangmi = mod(int2benyuanyuan(1,div1) + int2benyuanyuan(1,dividernow),15);
ret = benyuanyuan2int(1, fangmi+1);

end

