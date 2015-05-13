function [ ] =ModelQ68(N,h0,h1,blockType,L,y,Fs,FileName,Smoothing)


tic;

Np=numel(L);

pErrR=zeros(size(L));
pErrExp=zeros(size(L));
pErrHann=zeros(size(L));
pErrHamm=zeros(size(L));

FileName=[FileName num2str(N)];

for i=1:Np

  
 %   pErrR(i)=ModelQ67b(N,y,Fs,L(i),floor(2*(N/L(i))),'none',2,h0,h1,FileName,Smoothing);
  
 %   pErrExp(i)=ModelQ67b(N,y,Fs,L(i),floor(2*(N/L(i))),'exp',2,h0,h1,FileName,Smoothing);
  
    pErrHann(i)=ModelQ67b(N,y,Fs,L(i),floor(2*(N/L(i))),'hann',2,h0,h1,FileName,Smoothing);
  
 %   pErrHamm(i)=ModelQ67b(N,y,Fs,L(i),floor(2*(N/L(i))),'hamm',2,h0,h1,FileName,Smoothing);
    
    if (mod(i,2)==0)
        disp(['i= ' num2str(i) ' From ' num2str(Np) ' Ellapsed Time'  num2str(toc)]);
    end

end

%Title= ['L' 'pErrR' 'pErrExp' 'pErrHann' 'pErrHamm'];
%Table=[L' pErrR' pErrExp' pErrHann' pErrHamm']
Table=[L'  pErrHann']


%fid = fopen(['d:\\work\\M56' num2str(N) '.txt'], 'wt');
%fprintf(fid, 'L \t pErrR \t pErrExp \t pErrHann \t pErrHamm \n');
%fprintf(fid, '%8.5f \t %8.5f \t %8.5f \t %8.5f \t %8.5f\n', Table');
%fclose(fid);

end

