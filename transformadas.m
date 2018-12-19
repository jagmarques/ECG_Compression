function [aftercomp_DCT, aftercomp_FFT, aftercomp_DST]=transformadas(sig)
    END=length(sig);
    x=sig(1:end,1);     %Time   
    y=sig(1:end,1);     %ECG data #1
    y2=y ;              %temp variable
    temp=y;
    disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
    TS=x(2)-x(1)
    Freq=1/TS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %DCT Compression
    %
    disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
    disp('DCT Compression');
    dcty=dct(y);       %Discrete Cosin Transform of ECG 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    dcty1=dcty;
    for index = 1:1:END
        if (dcty(index)<.22)&(dcty(index)>-0.22)
            dcty1(index)=0;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    aftercomp_DCT=idct(dcty1);
    figure('Name','DCT COMPRESSION')
    plot(aftercomp_DCT)
    error_DCT=y-aftercomp_DCT;
    PRD_DCT=sqrt(sum(error_DCT.^2)/sum(y.^2))
    figure('Name','DCT ERROR')
    plot(error_DCT),pause(5)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %FFT Comperession 
    disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
    disp('FFT Compression .'); 
    ffty=fft(y);       %FFT Transform of ECG   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ffty1=ffty;
    for index = 1:1:END
        if (abs(ffty(index))<25)&(abs(ffty(index))>-25)
            ffty1(index)=0;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    aftercomp_FFT=ifft(ffty1);
    figure('Name','FFT COMPRESSION')
    plot(aftercomp_FFT)
    error_FFT=y-aftercomp_FFT;
    PRD_FFT=sqrt(abs(sum(error_FFT.^2)/sum(y.^2)))
    figure('Name','FFT ERROR')
    plot(abs(error_FFT)), pause(5)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %DST Compression
    disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
    disp('DST Compression .')
    dsty=dst(y);       %Discrete Sin Transform of ECG  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    dsty1=dsty;
    for index = 1:1:END
        if (dsty(index)<15)&(dsty(index)>-15)
            dsty1(index)=0;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    aftercomp_DST=idst(dsty1);
    figure('Name','DST COMPRESSION')
    plot(aftercomp_DST)
    error_DST=y-aftercomp_DST;
    PRD_DST=sqrt(sum(error_DST.^2)/sum(y.^2))
    figure('Name','DST ERROR')
    plot(error_DST), pause(5)
    
end