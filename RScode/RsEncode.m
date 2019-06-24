function [ RsEnCode ] = RsEncode( input )
%RSENCODE Summary of this function goes here
%   Detailed explanation goes here

RsEnCode = zeros(1,15);
for ii = 5:1:15%高11位直接输出
    RsEnCode(1,ii) = input(1,ii-4);
end;
%寄存器取余数，本原多项式p(x) = x^4 + x + 1

%定义一个4位寄存器
reg = zeros(1,4);
%生成多项式的系数
g = [7,8,12,13,1];
for ii = 11:-1:1
    %输入的反馈
    rev = RsSymbolAdd(reg(1,4),input(1,ii));%g4系数是1就不用乘了
    %循环移位相加
    for tt = 4:-1:2
        reg(1,tt) = RsSymbolAdd(RsSymbolMul(g(1,tt),rev), reg(1,tt-1));
    end;
    reg(1,1) = RsSymbolMul(g(1,1),rev);
end;

%将寄存器数字的输出
for ii = 1:1:4
    RsEnCode(1,ii) = reg(1,ii);
end;
end

