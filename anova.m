clear all
close all
load A.dat

x=[];
y=[];
for i=1:80
    for j=1:19
        if A(i,j)>5 && A(i,j)<50
            x = [x, A(i,j+1)/A(i,j)-1];
            y(end+1)='A';
        end
    end
end
for i=81:160
    for j=1:19
        if A(i,j)>5 && A(i,j)<50
            x = [x, A(i,j+1)/A(i,j)-1];
            y(end+1)='B';
        end
    end
end
for i=161:240
    for j=1:19
        if A(i,j)>5 && A(i,j)<50
            x = [x, A(i,j+1)/A(i,j)-1];
            y(end+1)='C';
        end
    end
end
[p,tbl,stats] = anova1(x,y);