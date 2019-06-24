function [ RootCalc ] = RsDecodeRoot( ErrPosPolyCalc )

%我现在只考虑了错误两个和1个的情况，如果没有错误怎么办？
%现在再增加一种情况，就是无解，我用RootCalc=[-1]表示
%RSDECODEROOT Summary of this function goes here
%   Detailed explanation goes here
%不一定是一处错误还是两处错误还是没有错误，需要看一下错误位置这个矩阵除了1位置还有几个非零位置就有几个错的位数，解法是试根法

RootCalc=[-1,0];
if (ErrPosPolyCalc(1,3)~=0)%第三个位置不是0，这说明有两个错误
    %试根法
    cnt = 1;
    for ii = 1:1:15
        if(add(1,RsSymbolMul(ErrPosPolyCalc(1,2),ii),mul(ErrPosPolyCalc(1,3),ii,ii))==0)
            RootCalc(1,cnt) = ii;
            cnt = cnt+1;
            if (cnt==3)%找到两个根了
                break;
            end;
        end
    end;
elseif (ErrPosPolyCalc(1,2)~=0)%第二个位置不是0这说明有1个错误
    %试根法
    cnt = 1;
    for ii = 1:1:15
        if(RsSymbolAdd(1,RsSymbolMul(ErrPosPolyCalc(1,2),ii))==0)
            RootCalc(1,cnt) = ii;
            cnt = cnt+1;
            if (cnt==2)%找到两个根了
                break;
            end;
        end
    end;
end;

if (RootCalc(1,2) == 0)%这说明只有一个根
    RootCalc = RootCalc(:,1:1);%只取第一个元素
end
end

function [ret] = mul(input1, input2, input3)
    temp = RsSymbolMul(input1, input2);
    ret = RsSymbolMul(temp,input3);
end
function [ret] = add(input1, input2, input3)
    temp = RsSymbolAdd(input1, input2);
    ret = RsSymbolAdd(temp,input3);
end