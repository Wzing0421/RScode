function [ retpoly ] = RsPolyMul( poly1, poly2 )
%RSPOLYMUL Summary of this function goes here
%   Detailed explanation goes here

len1 = length(poly1);
len2 = length(poly2);
retpoly = zeros(1, max(len1,len2));

%多项式相乘是卷积
%这里面默认是1x11 和1x11相乘
for ii = 1:1:11%我在这里面默认输入是1x6，输出是1x11的
    rec = 0;
    for tt = 1:1:min(ii,6)%从第一维的角度来看第二维防止越界
        if ii-tt>5 
            continue;
        end;
        rec = RsSymbolAdd(rec , RsSymbolMul(poly1(1,tt),poly2(1,ii-tt+1))); 
    end;
    retpoly(1,ii) = rec;
end;

end

