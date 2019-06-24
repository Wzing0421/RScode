function [ retpoly ] = RsPolySub( poly1, poly2 )
%RSPOLYSUB Summary of this function goes here
%   Detailed explanation goes here

len1 = length(poly1);
len2 = length(poly2);
%长度不等的多项式其实也是能加的
len = max(len1,len2);
retpoly = zeros(1,len);
for ii = 1:1:min(len1,len2)
    retpoly(1,ii) = RsSymbolAdd(poly1(1,ii), poly2(1,ii));
end

if len1 < len2
    for ii = len1 +1 :1 : len2
        retpoly(1,ii) = poly2(1,ii);
    end;
end;
if len1 > len2
    for ii = len2+1:1:len1
        retpoly(1,ii) = poly1(1,ii);
    end;
end;
end

