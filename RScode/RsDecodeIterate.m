function [ ErrPosPolyCalc, SigmaRet ] = RsDecodeIterate( SyndromCalc )
%输出是错误位置多项式和 sigma多项式
%RSDECODEITERATE Summary of this function goes here
%   Detailed explanation goes here


%这个方法是我最开始用课件的方法，但是没有办法迭代，所以换成文献中给的方法
%ErrPosPoly = [1,11,1,0,0];%错误位置多项式应该的结果
% %首先先计算行列式的值
% ErrPosPolyCalc = [1,0,0,0,0];%初始化
% if (RsSymbolAdd(RsSymbolMul(SyndromCalc(1,2),SyndromCalc(1,2)),RsSymbolMul(SyndromCalc(1,1),SyndromCalc(1,3))) == 0)%如果是0，也就是没有错到2位，是1位错误
%     for res = 0:1:15%试根法
%         if(RsSymbolMul(SyndromCalc(1,1),res)==SyndromCalc(1,2))
%             ErrPosPolyCalc(1,2) = res;
%             break;
%         end;
%     end;
% else %是两位错误
%     %只能采用试根法
%     two_res_exist = 0; %判断是不是两个根
%     for res1 = 0:1:15
%         for res2 = 0:1:15
%             if(RsSymbolAdd(RsSymbolMul(SyndromCalc(1,2),res1),RsSymbolMul(SyndromCalc(1,1),res2))==SyndromCalc(1,3) &&RsSymbolAdd(RsSymbolMul(SyndromCalc(1,3),res1),RsSymbolMul(SyndromCalc(1,2),res2))==SyndromCalc(1,4))
%                 two_res_exist = 1; %说明有两个根
%                 ErrPosPolyCalc(1,2) = res1;
%                 ErrPosPolyCalc(1,3) = res2;
%             end;
%             if two_res_exist ==1
%                 break;
%             end;
%         end;
%         if two_res_exist ==1
%                 break;
%         end;
%     end;
% end;

%文献中给的方法,之所以是6x5而不是5x5是因为还有σ(-1)(x)需要考虑
SigmaCalc =zeros(6,5);
% sigma 应该的结果是[1 0 0 0 0 （d-1)
%                    1 0 0 0 0
%                    1 12 0 0 0
%                    1 12 0 0 0
%                    1 12 3 0 0
%                    1 11 1 0 0]

%从σ0迭代到σ4，一共迭代五次
%初始化，σ-1和σ0的系数都是[1,0,0,0,0]
SigmaCalc(1,1) = 1; 
SigmaCalc(2,1) = 1;
%这是系数，需要判断是否为0,注意这里面索引是从-1开始的，所以需要-2而不是-1
d = [1,SyndromCalc(1,1),0,0,0,0];
%阶数矩阵
Deg = [0,0,0,0,0,0];
%迭代4次分别求出来σ1到σ4
for j = 3:1:6
    if (d(1,j-1)==0)
        SigmaCalc(j,:) = SigmaCalc(j-1,:);
        %d(1,j) = d(1,j-1);
        Deg(1,j) = Deg(1,j-1);
    else
        %首先寻找符合条件的i,i<j， di!=0 且i- D(i)最大
        min_ = -10000;
        i=0;
        for s = j-2 :-1:1
            if( d(1,s)~=0 && (s-Deg(1,s)>min_) )
                min_ = s-Deg(1,s);
                i = s; 
            end
        end;
        % x^(j-i)*σ(i)(x)
        for tt = 1:1:5
            if tt+j-i >5
                break;
            end
            SigmaCalc(j,tt+j-i-1) = SigmaCalc(i,tt);
        end
        %低位补上0
        for tt = 1:1:j-i-1
            SigmaCalc(j,tt) = 0;
        end;
        %dj*di-1
        temp = RsSymbolMul(d(1,j-1),RsSymbolRev(d(1,i)));
        %dj*(di^-1)*x^(j-i)*σ(i)(x)
        for tt = 1:1:5
            SigmaCalc(j,tt) = RsSymbolAdd(SigmaCalc(j-1,tt),RsSymbolMul(temp,SigmaCalc(j,tt))); 
        end;
        %求阶数deg
        for tt = 5:-1:1
            if(SigmaCalc(j,tt)~=0)
                Deg(1,j) = tt-1; %阶数
                break;
            end
        end;
    end;
    %求dj,j=6的时候不用算
    if j==6
       break;
    end
    temp_d = SyndromCalc(1,j-1);
    for tt = 1:1:Deg(1,j)
        temp_d = RsSymbolAdd(temp_d,RsSymbolMul(SyndromCalc(1,j-1-tt),SigmaCalc(j,tt+1))); 
    end;
    d(1,j) = temp_d;
end;
%取2~6行作为迭代结果
SigmaRet = SigmaCalc(2:6,:);
%取最后一行作为错误位置多项式
ErrPosPolyCalc = SigmaCalc(6,:);
end

