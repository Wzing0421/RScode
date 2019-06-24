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
