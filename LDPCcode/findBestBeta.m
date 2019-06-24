%此函数用于寻找最佳的α值
load H_index.mat;
load H_index_len.mat;
load Hst.mat;
load H_ldpc.mat;
load H_var.mat;
load H_var_len.mat

error_framerate = zeros(1,11);
error_bitrate = zeros(5,11);
error_limit = [50,30,15,5];

%snr = [-2.4, -2.2, -2.0, -1.8, -1.6]; %信噪比设置为-2
iter = 0;
for snr = -2.4 : 0.2 : -1.6
    iter = iter + 1;
for b = 0:0.1:1
    
    %错误帧数量
    totalerror_framenum = 0;
    %错误比特数量
    totalerror_bitnum = 0;
    lp = 0; %记录总的循环次数
    while 1
        lp = lp+1;
        %产生随机序列1x1008
        Input = ceil(rand(1,1008)*2)-1;
        %将1x1008位信息序列编码成1x2016位
        LDPCEnCode = Encode(Input,Hst);

        %BPSK调制
        LDPCSend = 1-2*LDPCEnCode;
        %经过RsChannel信道加噪声,SNR = EbN0+10lg(2);
        LDPCRecv = awgn(LDPCSend,snr+3);
       
        
        %接收之后的第一步，初始化,获得初始的软信息
        y_snr = 10^(snr/10);
        LDPCRecv = 4 * LDPCRecv * y_snr;
        
        u = zeros(1008,2016);
        v = zeros(2016,1008);
        [isSuc, errorframenum, errorbitnum] = Decode_MinSumBeta( LDPCRecv, H_index, H_index_len, H_var, H_var_len, u, v, H_ldpc, LDPCEnCode, b );
        
        totalerror_framenum = totalerror_framenum + errorframenum;
        totalerror_bitnum = totalerror_bitnum + errorbitnum;
        
        if(isSuc ==0) %译码中出现了错误
            fprintf('第 %d 帧出现了错误！\n',lp);
            fprintf('snr = %d 错误帧数 ：%d\n', snr,totalerror_framenum);
            fprintf('snr = %d 错误比特数 ：%d\n', snr,totalerror_bitnum);
        else
            fprintf('第 %d 帧没出现错误！\n',lp);
            fprintf('snr = %d 错误帧数 ：%d\n', snr,totalerror_framenum);
            fprintf('snr = %d 错误比特数 ：%d\n', snr,totalerror_bitnum);
        end
        
        %循环退出的判决条件
        if(totalerror_framenum > 100) 
            break;
        end
        
    end
    
    %error_framerate(1,snr+5) = totalerror_framenum/lp;
    error_bitrate(iter,round(10 * b + 1)) = totalerror_bitnum/(lp*1008);%只需要计算误码率
    
end
end
%画图
figure(1);
x = 0:0.1:1;
plot( x,error_bitrate(1,:),'-r', x,error_bitrate(2,:),'-g',x,error_bitrate(3,:),'-b',x,error_bitrate(4,:),'-y',x,error_bitrate(5,:),'-k');

title ('LDPC different β code Performace');
xlabel('β的值'); 
ylabel('BER');
legend('snr = -2.4dB','snr = -2.2dB', 'snr = -2.0dB', 'snr = -1.8dB', 'snr = -1.6dB');
grid on;
%semilogy(x,error_symbolrate,'b');



