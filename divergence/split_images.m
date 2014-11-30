function [  ] = split_images(directorySource,directorySG,ext,L)
%Splitting each image in the folder directorySource to blocks , by dividing
%height and withd by L
list=eurModel3getFiles(directorySource,ext);

N=numel(list);


for i=1:N

    disp(['Image ' list{i} ' is being processed'])
    im=imread(list{i});
    
    [m,n]=size(im);
    
    m=m/L;
    n=n/L;
    
    for j=1:L
        for k=1:L
            im1=im(1+(j-1)*m:j*m,1+(k-1)*n:k*n);
            [fp ,fn, fe]=fileparts(list{i});
            imwrite(im1,[directorySG fn '_' num2str(j) '_' num2str(k) '.' ext],ext);
        end
    end
    
end
end
