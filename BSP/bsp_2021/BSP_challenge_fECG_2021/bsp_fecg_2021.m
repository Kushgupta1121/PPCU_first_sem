function     [fetal_QRSAnn_est,QT_Interval]=bsp_fecg_2021(tm,ecgs,Fs)

ecgs_filt=zeros(size(ecgs));
fetal_peak=[];

%Butterworth bandpass Filtering the ECG Signal
for i = 1:size(ecgs,2)
start = 8/(Fs/2);
stop = 45/(Fs/2); 
[b,a]= butter(3, [start , stop], 'bandpass');
ecgs_filt(:,i)=filtfilt(b,a,ecgs(:,i));
%ecgs_filt(:,i)=pantom(ecgs(:,i),Fs); Trying the pan-tompkins algorithm to
%detect the maternal QRS and fetal QRS but due to time constraint couldn't complete the implementation 
end

mecg=ecgs_filt(:,1);%ecgs(:,1); % 

[min_vol,min_loc]=findpeaks(abs(mecg),'MinPeakDistance',Fs*0.6); % Detecting Maternal Peaks

%disp(min_vol(1:2));
%disp(min_loc(1:2));

M=0.07*Fs; % window size to cut_out a RR Maternal part in the ECG signal, as RR maternal part contains fetal QRS.
ecg =  ecgs_filt(:, 2);
for i=1:length(min_loc)-1  % iterating over all the detected peaks to find FECG.
cut_ecg = ecg(min_loc(i)+M:min_loc(i+1)-M);  % Cutting out RR window from the ECG signal.
%disp(3*mean(abs(cut_ecg)));
max_abs=max(abs(cut_ecg));  % calculating max of abs value of cutted ECG
min_abs=min(abs(cut_ecg)); % calculating min of abs value of cutted ECG
val=0.5*(max_abs-min_abs); % defining MinPeak prominence values, tried to find the optimum value for prominence peak but using a wide range of values.

[peakval, peakloc] = findpeaks(abs(cut_ecg),"MinPeakProminence",2.5*mean(abs(cut_ecg)),"MinPeakDistance",0.2*Fs); % tried a variety of values to find the optimal values for MinPeakDistance 0.2*Fs gave good results.
peakloc = min_loc(i)+M+peakloc ; % storing detected fetal peaks
fetal_peak = [fetal_peak, peakloc']; %appending Fetal peaks in a array
end

fetal_QRSAnn_est=fetal_peak; %Returning Fetal peak values.


t=(0:1/Fs:(length(mecg)-1)/Fs)';
QT_Interval=(t(fetal_peak(2:end))-t(fetal_peak(1:end-1)));

%plot_ecgs(Fs,ecgs_filt,fetal_QRSAnn_est,QT_Interval);





