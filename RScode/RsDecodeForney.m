function [ ErrorValueCalc, ErrorPositionCalc ] = RsDecodeForney( SyndromCalc, ErrPosPolyCalc, RootCalc )

%RSDECODEFORNEY Summary of this function goes here
%   Detailed explanation goes here

%从一个十进制数转到本源元的方幂表示，这个数字代表本源元的方幂
int2benyuanyuan = [0,1,4,2,8,5,10,3,14,9,7,6,13,11,12];

%从根多项式RootCalc得到错误位置
for ii = 1:1:length(RootCalc)
    ErrorPositionCalc(1,ii) = int2benyuanyuan(1,RsSymbolRev(RootCalc(1,ii)));
end;
%sort(ErrorPositionCalc);%需要从小到大排序,我猜这个应该放在最后面

%伴随多项式和错误位置多项式相乘
MulPoly = polyMul(SyndromCalc,ErrPosPolyCalc);
%mod (x^2t),因为只有x^2t所以只要把>=2t的项都去掉就可以了
w = MulPoly(:,1:4);

%注意课件上这个Xp表示的是根[2,12]的倒数的位置[9,10]
%rootCalc本身元素是由小到大排列的，这是因为试根法的顺序就是由小到大
%RsSymbolRev(RootCalc(1,ii))这是错误位置的整数表示
for ii = 1:1:length(RootCalc)
    %计算分子w(xp-1)
    ErrorValueCalc(1,ii) = 0;
    for tt = 1:1:4
        cal = 1;
        for s = 1:1:tt-1%计算幂次
            cal = RsSymbolMul(cal,RootCalc(1,ii));
        end
        ErrorValueCalc(1,ii) = RsSymbolAdd(ErrorValueCalc(1,ii),RsSymbolMul(w(1,tt),cal));
    end;
    %计算分母
    %因为σ(x)至多只有1+ax+bx^2，求导之后只剩下a,也就是ErrPosPolyCalc(1,2)，然后求反就行了
    if (ErrPosPolyCalc(1,2)==0)
        ErrorValueCalc(1,ii) = 0; %增加错误为0的处理
    else
        ErrorValueCalc(1,ii) = RsSymbolMul(ErrorValueCalc(1,ii),RsSymbolRev(ErrPosPolyCalc(1,2)));
    end;
end
%从小到大排列
    if (length(ErrorPositionCalc)==2 && ErrorPositionCalc(1,1)>ErrorPositionCalc(1,2))
         temp = ErrorPositionCalc(1,1); ErrorPositionCalc(1,1) = ErrorPositionCalc(1,2); ErrorPositionCalc(1,2) = temp;
         temp = ErrorValueCalc(1,1);ErrorValueCalc(1,1) = ErrorValueCalc(1,2);ErrorValueCalc(1,2) = temp;
    end
end
function retpoly = polyMul(poly1, poly2)

len1 = length(poly1);
len2 = length(poly2);
retpoly = zeros(1, len1+len2-1);

%多项式相乘是卷积

for ii = 1:1:len1+len2-1
    rec = 0;
    for tt = 1:1:len1%从第一维的角度来看第二维防止越界
        if ii-tt+1>len2 
            continue;
        end;
        if ii-tt+1<=0
            continue;
        end;
        rec = RsSymbolAdd(rec , RsSymbolMul(poly1(1,tt),poly2(1,ii-tt+1))); 
    end;
    retpoly(1,ii) = rec;
end;

end
