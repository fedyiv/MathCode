function [ output_args ] =autoMake( input_args )

%[y,Fs]=wavread('d:\\work\\red.wav',[40000 9000000]);
[y,Fs]=wavread('d:\\work\\red.wav',[40000 100000]);

ModelQ68(29,[1 zeros(1,3) 0.9],[1 zeros(1,7) 0.9],2,[1 2 3],y,Fs,'d:\\work\\output',0.5);
ModelQ68(37,[1 zeros(1,9) 0.9],[1 zeros(1,15) 0.9],2,[1 2 3],y,Fs,'d:\\work\\output',0.5);
ModelQ68(44,[1 zeros(1,3) 0.9],[1 zeros(1,7) 0.9],2,[1 2 3],y,Fs,'d:\\work\\output',0.5);
ModelQ68(63,[1 zeros(1,3) 0.9],[1 zeros(1,7) 0.9],2,[1 2 3 4],y,Fs,'d:\\work\\output',0.5);
ModelQ68(88,[1 zeros(1,3) 0.9],[1 zeros(1,7) 0.9],2,[1 2 3 4 5 6 7],y,Fs,'d:\\work\\output',0.5);


ModelQ68(147,[1 zeros(1,25) 0.8],[1 zeros(1,30) 0.8],2,[1 2 3 4 5 6 7],y,Fs,'d:\\work\\output',0.5);
ModelQ68(221,[1 zeros(1,25) 0.8],[1 zeros(1,30) 0.8],2,[1 2 3 4 5 6 7],y,Fs,'d:\\work\\output',0.5);
ModelQ68(294,[1 zeros(1,25) 0.8],[1 zeros(1,30) 0.8],2,[2 3 4 5 6 7 8 9],y,Fs,'d:\\work\\output',0.5);

[y,Fs]=wavread('d:\\work\\red.wav',[40000 500000]);

ModelQ68(441,[1 zeros(1,25) 0.6],[1 zeros(1,30) 0.6],2,[2 3 4 5 6 7 8 9 10],y,Fs,'d:\\work\\output',0.5);
ModelQ68(551,[1 zeros(1,25) 0.4],[1 zeros(1,30) 0.4],2,[2 3 4 5 6 7 8 9 10],y,Fs,'d:\\work\\output',0.5);

ModelQ68(689,[1 zeros(1,25) 0.4],[1 zeros(1,30) 0.4],2,[3 4 5 6 7 8 9 10 11],y,Fs,'d:\\work\\output',0.5);
ModelQ68(980,[1 zeros(1,25) 0.3],[1 zeros(1,30) 0.3],2,[3 4 5 6 7 8 9 10 11 12 13],y,Fs,'d:\\work\\output',0.5);
ModelQ68(1225,[1 zeros(1,25) 0.3],[1 zeros(1,30) 0.3],2,[3 4 5 6 7 8 9 10 11 12 13 14 15],y,Fs,'d:\\work\\output',0.5);

[y,Fs]=wavread('d:\\work\\red.wav',[40000 1000000]);


ModelQ68(2205,[1 zeros(1,25) 0.3],[1 zeros(1,30) 0.3],2,[8 9 10 11 12 13 14 15 17 19 21 23 25 27 28 30],y,Fs,'d:\\work\\output',0.5);
ModelQ68(2756,[1 zeros(1,25) 0.2],[1 zeros(1,30) 0.2],2,[8 9 10 11 12 13 14 15 17 19 21 23 25 27 28 30],y,Fs,'d:\\work\\output',0.5);
ModelQ68(4410,[1 zeros(1,77) 0.2],[1 zeros(1,85) 0.2],2,[10 11 12 13 14 15 17 19 21 23 25 27 28 30 33 35 38 40 42],y,Fs,'d:\\work\\output',0.5);
ModelQ68(11025,[1 zeros(1,98) 0.1],[1 zeros(1,108) 0.1],2,[10 11 12 13 14 15 17 19 21 23 25 27 28 30 33 35 38 40 42],y,Fs,'d:\\work\\output',0.5);
ModelQ68(22050,[1 zeros(1,98) 0.1],[1 zeros(1,108) 0.1],2,[13 14 15 17 19 21 23 25 27 28 30 33 35 38 40 42 48 54 58 62 68 76 80 84 88 90],y,Fs,'d:\\work\\output',0.5);







end

