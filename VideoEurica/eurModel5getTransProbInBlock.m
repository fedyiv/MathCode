function [ p,psg,pm,pfa,trexp ] = eurModel5getTransProbInBlock(videoFileName,frames,threshold)
% This function opens video file specified in videoFileName, takes those
% frames which are specified in 'frames' array. And then it computes
% transitional probability(horizontal) for values in 'mat' array.
% Threshold is not used in the computing, it is used for estimating 
% pm in case t is used in steganalysis
%
%


video=mmreader(videoFileName);

if(max(frames)>video.numberOfFrames)
    error('Out of video file')
end

m=video.Width/8;
n=video.Height/8;

mat=zeros(m,n);



k=0;
pk=0;
q=m*n;
pm=0;
pfa=0;
pi=0;
psg=0;

mPcm=zeros(size(frames));
mPsg=zeros(size(frames));

tic;
for i=frames
    
    frame=read(video,i);
    
    mat=(eurModel4getMat(frame(:,:,1)))';
    matSG=round(rand(size(mat)));
    
    pi=eurModel5getTrPrStr(mat);
    piSG=eurModel5getTrPrStr(matSG);
    pk=pk+pi;
    psg=psg+piSG;
   
    
    if(pi<threshold)
        pm=pm+1;
    end
    
    if(piSG>threshold)
        pfa=pfa+1;
    end
    
    k=k+1;
    
     mPcm(k)=pi;
    mPsg(k)=piSG;
    
    if(mod(k,10)==0)
        disp(['Frame ' num2str(k) ' from ' num2str(numel(frames)) ' Pcur=' num2str(pk/k) ' Pm=' num2str(pm/k) ' Pfa=' num2str(pfa/k)  ' psg=' num2str(psg/k)  ' Elapsed time ' num2str(toc)]);
    end

end

p=pk/k;
pm=pm/k;
pfa=pfa/k;
psg=psg/k;

trexp=(psg+p)/2;


subplot(2,1,1);
hist(mPcm,0.48:0.002:0.58);

subplot(2,1,2);
hist(mPsg,0.48:0.002:0.58);

end

