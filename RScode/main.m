error_framerate = zeros(1,5);
error_symbolrate = zeros(1,5);
itertimes = 1000000;
for EbN0 = 0:2:8
    
    %错误帧数量
    error_framenum = 0;
    %错误比特数量
    error_symbolnum = 0;
    
    for framenum = 1:1:itertimes

        %产生随机序列
        Input = ceil(rand(1,11)*16)-1;
        %将11位信息序列编码成15位
        RsEnCode = RsEncode(Input);
        %将其转换成2进制符号,RsTrans是一个60位的2进制符号串
        RsTrans = zeros(1,60);
        for ii = 1:1:15
            RsTrans(1,4*ii-3:4*ii) = dec2bin(RsEnCode(1,ii));
        end;

        %BPSK调制
        RsSend = 1-2*RsTrans;
        %经过RsChannel信道加噪声,SNR = EbN0+10lg(22/15);
        RsRecv = awgn(RsSend,EbN0+1.663);
        %信道接收之后要进行判决
        for ii = 1:1:60
            if RsRecv(1,ii) <0
                RsRecv(1,ii) = 1;
            else
                RsRecv(1,ii) = 0;
            end
        end
        %判决之后先从二进制转换成十进制
        NoisedRsCode = zeros(1,15);
        for ii = 1:1:15
            NoisedRsCode(1,ii) = bin2dec(RsRecv(1,4*ii-3:4*ii));
        end
        %计算伴随式
        SyndromCalc = RsDecodeCalcSynd(NoisedRsCode);
        %伴随式为0说明没有错误就可以直接输出了
        error_exist=0;
        for ii = 1:1:length(SyndromCalc)
            if(SyndromCalc(1,ii)~=0)
                error_exist = 1;
                break;
            end
        end

        if (error_exist ==0)
            output = NoisedRsCode(1,5:15);
        else
            %否则就需要首先massey迭代法计算错误位置多项式
            [ErrPosPolyCalc, SigmaCalc] = RsDecodeIterate(SyndromCalc);
            %错误多项式求根
            RootCalc = RsDecodeRoot(ErrPosPolyCalc);
            %这里可能出现没有根的情况，可以从最大似然概率的角度分析
            if (RootCalc(1,1)==-1)
                output = NoisedRsCode(1,5:15);
            else
                %forney计算出错误位置和错误数值
                [ErrorValueCalc, ErrorPositionCalc] = RsDecodeForney(SyndromCalc, ErrPosPolyCalc, RootCalc);
                %计算出来之后在错误位置再将它加回去修正错误
                for ii = 1:1:length(ErrorPositionCalc)
                    NoisedRsCode(1,ErrorPositionCalc(1,ii)+1) = RsSymbolAdd(NoisedRsCode(1,ErrorPositionCalc(1,ii)+1),ErrorValueCalc(1,ii));
                end
                %获得最终输出结果，是11位信息位
                output = NoisedRsCode(1,5:15);
            end;
        end;
        %统计错误帧数量和错误比特数量
        frame_error = 0;
        for ii = 1:1:11
            if(Input(1,ii)~=output(1,ii))
                error_symbolnum = error_symbolnum +1;%错误数量加一
                frame_error = 1;%帧有错误
            end
        end;
        if (frame_error == 1)
            error_framenum = error_framenum +1;
        end;
    end;
    
    error_framerate(1,EbN0/2+1) = error_framenum/itertimes;
    error_symbolrate(1,EbN0/2+1) = error_symbolnum/(itertimes*11);
    
end
x = 0:2:8;
semilogy(x,error_framerate,'-*r', x,error_symbolrate,'-ob' );
title ('RsCode Performace');
xlabel('Eb/N0'); 
ylabel('误符号率/误帧率');
legend('Error Frame Ratio','Error Symbol Ratio');
grid on;
%semilogy(x,error_symbolrate,'b');






