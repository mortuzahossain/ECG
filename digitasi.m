
ld=0.00635;%faktor penyesuaian amplitudo dengan mm;

% ld=0.0483;%dengan mm 600dpi
target1R = 0 ;
%R = k;%(:,:,1);
matches1 = k == target1R ;
[x1, y1] = find(matches1);
 
DATA =[y1, x1];
sementara = unique(DATA,'rows');

lsementara = length(sementara);
jj = 1;
for ii = 1 : lsementara
    if ii > 1
        if sementara(ii, 1) == sementara(ii - 1, 1)
            continue
        end
    end
    if ii < lsementara
        if sementara(ii, 1) == sementara(ii + 1, 1)
            sementara2(jj,1) = sementara(ii, 1);
            sementara2(jj,2) = max(sementara(ii, 2),sementara(ii + 1, 2));
        else
            sementara2(jj, 1) = sementara(ii, 1);
            sementara2(jj, 2) = sementara(ii, 2);
        end
    else
            sementara2(jj, 1) = sementara(ii, 1);
            sementara2(jj, 2) = sementara(ii, 2);
    end
    jj = jj + 1;
end

HASIL_AKHIRAVF=sementara2(:,2);
HASIL_AKHIRAVF=(HASIL_AKHIRAVF)*ld;
maksim=max(HASIL_AKHIRAVF);
minim=min(HASIL_AKHIRAVF);
media=median((HASIL_AKHIRAVF));
HASIL_AKHIRAVF=HASIL_AKHIRAVF-media;
TG=maksim-minim;
fs=23;
%fs=1%400;%figure(3)
figure, plot([0:length(HASIL_AKHIRAVF)-1]/fs,HASIL_AKHIRAVF);
grid on
PJ=length(HASIL_AKHIRAVF)/fs;
xlabel('Periode (mm)');
ylabel('Amplitude (mm)');
datacursormode on 
peak=findpeaks(HASIL_AKHIRAVF,'SortStr','descend');
%title('Plot')
csvwrite('test.dat',HASIL_AKHIRAVF);
%plot(peak)
figure,findpeaks(HASIL_AKHIRAVF,'MinPeakHeight',mean(HASIL_AKHIRAVF),'MinPeakDistance',60);
