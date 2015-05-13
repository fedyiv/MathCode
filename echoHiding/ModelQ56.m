function [ ] =ModelQ56(Ngsh,h0,h1,blockType,L,NExp)


tic;

Np=numel(L);

pErrR=zeros(size(L));
pErrExp=zeros(size(L));
pErrHann=zeros(size(L));
pErrHamm=zeros(size(L));

for i=1:Np

    [pErrR(i) ~]=Model40b(Ngsh,h0,h1,L(i),blockType,'none',NExp,floor(2*(Ngsh/L(i))));
    [pErrExp(i) ~]=Model40b(Ngsh,h0,h1,L(i),blockType,'exp',NExp,floor(2*(Ngsh/L(i))));
    [pErrHann(i) ~]=Model40b(Ngsh,h0,h1,L(i),blockType,'hann',NExp,floor(2*(Ngsh/L(i))));
    [pErrHamm(i) ~]=Model40b(Ngsh,h0,h1,L(i),blockType,'hamm',NExp,floor(2*(Ngsh/L(i))));
    
    if (mod(i,2)==0)
        disp(['i= ' num2str(i) ' From ' num2str(Np) ' Ellapsed Time'  num2str(toc)]);
    end

end

Title= ['L' 'pErrR' 'pErrExp' 'pErrHann' 'pErrHamm'];
Table=[L' pErrR' pErrExp' pErrHann' pErrHamm']

%save(['d:\\work\\M56' num2str(NExp) '.txt'],'Title','-ascii','-tabs');
%save(['d:\\work\\M56' num2str(NExp) '.txt'],'Table','-append','-ascii','-tabs');
%xlswrite(['d:\\work\\M56' num2str(NExp) '.xls'],'Table');

fid = fopen(['d:\\work\\M56' num2str(NExp) '.txt'], 'wt');
fprintf(fid, 'L \t pErrR \t pErrExp \t pErrHann \t pErrHamm \n');
fprintf(fid, '%8.5f \t %8.5f \t %8.5f \t %8.5f \t %8.5f\n', Table');
fclose(fid);

end

