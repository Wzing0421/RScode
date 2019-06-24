function [ ret ] = RsSymbolRev( rev1 )
%RSSYMBOLREV Summary of this function goes here
%   Detailed explanation goes here
%从一个十进制数转到本源元的方幂表示，这个数字代表本源元的方幂
int2benyuanyuan = [0,1,4,2,8,5,10,3,14,9,7,6,13,11,12];
%从本原元的方幂表示变成十进制数，这是对应关系，注意本原元方幂是从0开始的，索引需要加1
benyuanyuan2int = [1,2,4,8,3,6,12,11,5,10,7,14,15,13,9];

%判断输入是否合法
if (rev1 >15 || rev1 <=0)
    disp('invalid input rev1!\n');
    return ;
end;

%除法相当于把除数取倒数然后和被除数相乘
fangmi_rev = int2benyuanyuan(1,rev1);
if fangmi_rev ~=0 %0的时候不需要取倒数
    fangmi_rev = 15 - fangmi_rev;
end;
revnow = benyuanyuan2int(1, fangmi_rev+1);

ret = revnow;

end

