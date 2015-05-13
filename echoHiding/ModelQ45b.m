function  D = ModelQ45b(h1,h2,N1,N2,dN)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
tic;

[~, lh1]=size(h1);



Np=floor((N2-N1)/dN)+1;


h1=[h1 zeros(1,N1)];


D=zeros(1,Np);

for i=1:Np
    
    ch1=cceps(h1);
   
    D(i)=sum((ch1.^2));
    
    
%    if((i==99-N1+1)||(i==198-N1+1)||(i==210-N1+1))
 %       hh=figure();
  %      subplot(2,1,1);
   %     plot(h1);
    %    subplot(2,1,2);
     %   plot(ch1);
 %       title([ 'i  = ' num2str(N1+dN*(i-1))  ' Вид ИХ и ее кепстра ' ]);
  %      print(hh,'-dpng',['d:\\work\\ModelQ45_' num2str(i)]);
        
        
 %   end
    
    
    h1=[h1 zeros(1,dN)];
    
    
    if (mod(i,100)==0)
     disp(['i= ' num2str(i) ' From ' num2str(Np) ' Ellapsed Time'  num2str(toc)]);
    end
    
end

hh=figure();

N=N1:dN:N2;

plot(N,D);

 grid on;
 title(' Cумма квадратов кепстра ИХ ');
 print(hh,'-dpng',['d:\\work\\ModelQ45_R']);



end

