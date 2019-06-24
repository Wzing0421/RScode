function [isSuc, errorframenum, errorbitnum] = Decode_MinSumBeta( rcode, H_index, H_index_len, H_var, H_var_len, u, v, H_ldpc, LDPCEnCode, b )
%DECODE Summary of this function goes here
%   Detailed explanation goes here

%H_index, H_index_len, H_var, H_var_len, u, v
%H_index(i,j) 表示第i个校验节点参与的第j个节点的位置索引
%H_var(i,j)表示第i个变量节点参与的第j个校验方程的位置索引
    isSuc = 0;
    Vpan = zeros(1,2016);
    u0 = rcode; %u0表示初始的置信度
    for iter = 1:1:30%外层迭代30次
        for ii = 1:1:2016 %对每个变量节点进行计算
            %计算vi->j，只需要从H_var得到所有边的关系
            %u是一个1008x2016的矩阵，v是一个2016x1008的矩阵
            
            for jj = 1:1:H_var_len(ii,1)%每个变量节点连出来这么多线
                
                v(ii,H_var(ii,jj)) = u0(1,ii);
                for tt = 1:1:H_var_len(ii,1)%每个变量节点计算一个循环
                    if tt == jj %对应k!=j的条件
                        continue;
                    end
                    %v(ii,jj) = v(ii,jj) + u(H_var(ii,tt),findIndex(ii,H_var(ii,tt),H_index, H_index_len));
                    v(ii,H_var(ii,jj)) = v(ii,H_var(ii,jj)) + u(H_var(ii,tt),ii);
                end
                
            end
        
        end
        %第一部分结束，v(ii,jj)表示的是ii变量节点给第jj条索引的v值，注意校验节点对应的是H_var(ii,jj)
        %开始第二部分
        for ii = 1:1:1008
            for jj = 1:1:H_index_len(ii,1)
                minv = 1000000;
                sig = 1;
                for tt = 1:1:H_index_len(ii,1)
                    if tt == jj
                        continue;
                    end
                    sig = sig * getsymbol(v(H_index(ii,tt),ii)); %确定符号
                    if minv > abs(v(H_index(ii,tt),ii))
                        minv = abs(v(H_index(ii,tt),ii));
                    end
                end
                
                u(ii,H_index(ii,jj)) = sig * getbigger(minv - b, 0) ;               
            end
        end
        
        %第三步，判决
        Vpan(1,:) = 0;
        for ii = 1:1:2016
            Vpan(1,ii) = u0(1,ii);
            for jj = 1:1:H_var_len(ii,1)
                Vpan(1,ii) = Vpan(1,ii) + u(H_var(ii,jj),ii);
            end
            if Vpan(1,ii)<0
                Vpan(1,ii) = 1;
            else
                Vpan(1,ii) = 0;
            end
        end
        
        %统计是否有错误
        judge = zeros(1,1008);
        if(mod(Vpan * H_ldpc',2) == judge)
            isSuc = 1; %正确了，跳出循环
            break;
        end        
    end
    
    if isSuc == 1 %没错误
        errorframenum = 0;
        errorbitnum = 0;
    else
        errorframenum = 1;
        errorbitnum = 0;
        for ii = 1009:1:2016
            if(Vpan(1,ii)~=LDPCEnCode(1,ii))
                errorbitnum = errorbitnum + 1;
            end
        end
    end
end

function ret = getbigger(a,b) %获得两个数中较大的
    if a >= b
        ret = a;
    else
        ret = b;
    end
end

function ret = getsymbol(a) %获得正负值
    if a >= 0
        ret = 1;
    else
        ret = -1;
    end
end

