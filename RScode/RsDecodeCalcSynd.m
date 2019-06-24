function [ SyndromCalc ] = RsDecodeCalcSynd( NoisedRsCode )
%RSDECODECALCSYND Summary of this function goes here
%   Detailed explanation goes here

%从本原元的方幂表示变成十进制数，这是对应关系，注意本原元方幂是从0开始的，索引需要加1
benyuanyuan2int = [1,2,4,8,3,6,12,11,5,10,7,14,15,13,9];

%注意它的错误位置是以0开始的，伴随式最终计算结果是[12,15,15,12]
%接收矩阵是[1,0,2,9,0,1,2,3,4,5,6,7,8,9,4];

%伴随多项式有4位
SyndromCalc = zeros(1,4);
for ii = 1:1:4
    %每一位都是加和的形式
    for tt = 1:1:15
        mi = mod(ii*(tt-1),15);
        %方幂转换成十进制数
        intnum = benyuanyuan2int(1,mi+1);
        %十进制数和系数相乘
        mul_res = RsSymbolMul(NoisedRsCode(1,tt),intnum);
        %乘之后求和
        SyndromCalc(1,ii) = RsSymbolAdd(SyndromCalc(1,ii),mul_res);
    end;
end;
end

