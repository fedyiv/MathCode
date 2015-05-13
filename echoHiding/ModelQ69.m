function [ ] =ModelQ69(N,h0,h1,blockType,L,y,Fs,FileName,Smoothing)


tic;

Np=numel(L);

pErrR=zeros(size(L));
pErrExp=zeros(size(L));
pErrHann=zeros(size(L));
pErrHamm=zeros(size(L));

FileName=[FileName num2str(N)];

for i=1:Np

   % [pErrR(i) ~]=Model40b(Ngsh,h0,h1,L(i),blockType,'none',NExp,floor(2*(Ngsh/L(i))));
    pErrR(i)=ModelQ66b(N,y,L(i),floor(2*(N/L(i))),'none',2,h0,h1,FileName,Fs,Smoothing);
    %[pErrExp(i) ~]=Model40b(Ngsh,h0,h1,L(i),blockType,'exp',NExp,floor(2*(Ngsh/L(i))));
    pErrExp(i)=ModelQ66b(N,y,L(i),floor(2*(N/L(i))),'exp',2,h0,h1,FileName,Fs,Smoothing);
    %[pErrHann(i) ~]=Model40b(Ngsh,h0,h1,L(i),blockType,'hann',NExp,floor(2*(Ngsh/L(i))));
    pErrHann(i)=ModelQ66b(N,y,L(i),floor(2*(N/L(i))),'hann',2,h0,h1,FileName,Fs,Smoothing);
    %[pErrHamm(i) ~]=Model40b(Ngsh,h0,h1,L(i),blockType,'hamm',NExp,floor(2*(Ngsh/L(i))));
    pErrHamm(i)=ModelQ66b(N,y,L(i),floor(2*(N/L(i))),'hamm',2,h0,h1,FileName,Fs,Smoothing);
    
    if (mod(i,2)==0)
        disp(['i= ' num2str(i) ' From ' num2str(Np) ' Ellapsed Time'  num2str(toc)]);
    end

end

Title= ['L' 'pErrR' 'pErrExp' 'pErrHann' 'pErrHamm'];
Table=[L' pErrR' pErrExp' pErrHann' pErrHamm']

%save(['d:\\work\\M56' num2str(NExp) '.txt'],'Title','-ascii','-tabs');
%save(['d:\\work\\M56' num2str(NExp) '.txt'],'Table','-append','-ascii','-tabs');
%xlswrite(['d:\\work\\M56' num2str(NExp) '.xls'],'Table');

fid = fopen(['d:\\work\\M56' num2str(N) '.txt'], 'wt');
fprintf(fid, 'L \t pErrR \t pErrExp \t pErrHann \t pErrHamm \n');
fprintf(fid, '%8.5f \t %8.5f \t %8.5f \t %8.5f \t %8.5f\n', Table');
fclose(fid);

end

