%this module is to generate H matrix(1008 x 2016)
%save the real H matrix as "H_ldpc"

z = 56; %块的大小是56x56
load Matrix(2016,1008)Block56.mat
%这个是真正的LDPC码的校验矩阵，维度是1008x2016
H_ldpc = zeros(1008,2016);
for ii = 1:1:18
    for jj = 1:1:36
        %对于每一个元素，都对对应的元素块进行处理
        if (H_block(ii,jj)~=0) %等于0就不用处理了
            bias = H_block(ii,jj);%这是偏置
            start_l = 56*(ii-1);%行起始坐标
            start_c = 56*(jj-1);%列起始坐标
            for tt = 1:1:56
                if bias >56
                    bias = 1;
                end
                H_ldpc(start_l + tt , start_c + bias)=1;
                bias = bias +1;
            end
        end
    end
end
H_ldpc(1,1008)=0;%这是特殊情况

%之后是产生Hs转置
Hs = H_ldpc(:,1009:2016);
%保存的是Hs的转置
Hst = Hs';
save('H_ldpc','H_ldpc');
save('Hst','Hst');

%这是用于生成H_index 和H_index_len
load H_ldpc.mat
H_index = zeros(1008,8);%这个存储的是H矩阵每一行的为1的索引
H_index_len = zeros(1008,1); %这个存储的是H矩阵每一行为1的索引的个数
maxx = -1;
for ii = 1:1:1008
    cnt = 0;
    for jj = 1:1:2016        
        if(H_ldpc(ii,jj)==1)
            cnt = cnt +1;
            H_index(ii,cnt) = jj;
        end
    end
    H_index_len(ii,1) = cnt;
end
save('H_index','H_index');
save('H_index_len','H_index_len');
