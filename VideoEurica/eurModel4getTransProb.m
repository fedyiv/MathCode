function [ p ] = eurModel4getTransProb(videoFileName,frames)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


video=mmreader(videoFileName);

if(max(frames)>video.numberOfFrames)
    error('Out of video file')
end

m=video.Width/8;
n=video.Height/8;

mat=zeros(m,n);

frame=read(video,frames(1));
oldmat=(eurModel4getMat(frame(:,:,1)))';

k=0;
pk=0;
q=m*n;

tic;
for i=frames(2:numel(frames))
    
    frame=read(video,i);
    
    mat=(eurModel4getMat(frame(:,:,1)))';
    
    
    St=0;
    for j=1:m
        for l=1:n
            if(oldmat(j,l)==mat(j,l))
                St=St+1;
            end            
        end
    end
    
    pi=St/q;
    pk=pk+pi;
    

    k=k+1;
    
    oldmat=mat;
    
    if(mod(k,100)==0)
        disp(['Frame ' num2str(k) ' from ' num2str(numel(frames)) ' Pcur=  ' num2str(pk/k) ' Elapsed time' num2str(toc)]);
    end

end

p=pk/k;

end

