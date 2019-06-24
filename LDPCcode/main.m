load H_index.mat;
load H_index_len.mat;
load Hst.mat;
load H_ldpc.mat;
load H_var.mat;
load H_var_len.mat

error_framerate = zeros(1,7);
error_bitrate = zeros(1,7);
error_limit = [50,40,30,20,10,10,5];

%itertimes = 30;%���ѭ������30�ξͽ���
for snr = -4:0.5:-1
    
    %����֡����
    totalerror_framenum = 0;
    %�����������
    totalerror_bitnum = 0;
    lp = 0; %��¼�ܵ�ѭ������
    while 1
        lp = lp+1;
        %�����������1x1008
        Input = ceil(rand(1,1008)*2)-1;
        %��1x1008λ��Ϣ���б����1x2016λ
        LDPCEnCode = Encode(Input,Hst);

        %BPSK����
        LDPCSend = 1-2*LDPCEnCode;
        %����RsChannel�ŵ�������,SNR = EbN0+10lg(2);
        LDPCRecv = awgn(LDPCSend,snr+3);
       
        
        %����֮��ĵ�һ������ʼ��,��ó�ʼ������Ϣ
        y_snr = 10^(snr/10);
        LDPCRecv = 4 * LDPCRecv * y_snr;
        
        u = zeros(1008,2016);
        v = zeros(2016,1008);
        %��һ���㷨���ͻ��㷨
        %[isSuc, errorframenum, errorbitnum] = Decode_SumMul( LDPCRecv, H_index, H_index_len, H_var, H_var_len, u, v, H_ldpc, LDPCEnCode, 0.5 );
        %�ڶ����㷨����С���㷨���͵������㷨����൱�����æ�=1
        %[isSuc, errorframenum, errorbitnum] = Decode_MinSum( LDPCRecv, H_index, H_index_len, H_var, H_var_len, u, v, H_ldpc, LDPCEnCode, 1 );
        %�������㷨����һ����С���㷨����������Ϊ0.7
        %[isSuc, errorframenum, errorbitnum] = Decode_MinSum( LDPCRecv, H_index, H_index_len, H_var, H_var_len, u, v, H_ldpc, LDPCEnCode, 0.7 );
        %�������㷨��ƫ����С���㷨����������Ϊ0.5
        [isSuc, errorframenum, errorbitnum] = Decode_MinSumBeta( LDPCRecv, H_index, H_index_len, H_var, H_var_len, u, v, H_ldpc, LDPCEnCode, 0.5 );
        
        totalerror_framenum = totalerror_framenum + errorframenum;
        totalerror_bitnum = totalerror_bitnum + errorbitnum;
        
        if(isSuc ==0) %�����г����˴���
            fprintf('�� %d ֡�����˴���\n',lp);
            fprintf('snr = %d ����֡�� ��%d\n', snr,totalerror_framenum);
            fprintf('snr = %d ��������� ��%d\n', snr,totalerror_bitnum);
        else
            fprintf('�� %d ֡û���ִ���\n',lp);
            fprintf('snr = %d ����֡�� ��%d\n', snr,totalerror_framenum);
            fprintf('snr = %d ��������� ��%d\n', snr,totalerror_bitnum);
        end
        
        %ѭ���˳����о�����
        if(totalerror_framenum > error_limit(1,round(2 * snr + 9))) 
            break;
        end
        
    end
    
    error_framerate(1,round(2 * snr + 9)) = totalerror_framenum/lp;
    error_bitrate(1,round(2 * snr + 9)) = totalerror_bitnum/(lp*1008);
    
end

%��������ʺ������ʴ洢����
save('MinSum_biasBeta_error_framerate','error_framerate')
save('MinSum_biasBeta_error_bitrate','error_bitrate')
x = -1:0.5:2;
semilogy(x,error_framerate,'-*r', x,error_bitrate,'-ob' );
title ('LDPCCode Performace');
xlabel('Eb/N0'); 
ylabel('�������/��֡��');
legend('Error Frame Ratio','Error Symbol Ratio');
grid on;



