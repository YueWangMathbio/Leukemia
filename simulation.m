% this code simulates growth of wells with different initial cell numbers

clear all
close all

% the following 6 parameters can be adjusted in the parameter scan
p=0.4;%probability of fast growing state
p2=0.4;%probability of moderate growing state
p3=1-p-p2;%probability of slow growing state
d=0.01;%death rate. 
rr=0.1;%range of random modifier
gm=0.5;%growth modifier, max gr at low population



q=0.00;%transition probability from f or m to s, 0
r=0.00;%transition probability from s to f
r2=0.000;%from s to m, 0


ca=40000;%carrying capacity
n0=[1 4 10];
for h=1:3
    clear B C B2
    n=n0(h);
    for i=1:80
        s=1;
        B(i,1)=0;%number of fast (f) cell
        B2(i,1)=0;%number of moderate (m) cell
        C(i,1)=0;%number of slow (s) cell
        for j=1:n
            tte=rand();
            if tte<p
                B(i,1)=B(i,1)+1;
            else
                if tte<p+p2
                    B2(i,1)=B2(i,1)+1;
                else
                    C(i,1)=C(i,1)+1;
                end
            end
        end
        de=0;
        z0=rand()*2-1;
        z0=z0*rr; %uniform on -0.1,0.1
        for j=2:45
            po=B(i,j-1)+B2(i,j-1)+C(i,j-1);
            s=1-po^2/ca^2;
            s=s*gm;
            s=s+z0;
            if s<0
                s=0;
            end
            if s>1-d
                s=1-d;
            end
            s2=s/1.5;
            %s2=s2+z0;
            s3=s/3;
            
            
            Bp=0;
            B2p=0;
            Cp=0;
            for k=1:B(i,j-1)
                t1=rand();
                t2=rand();
                t3=rand();
                if t1<q %f to s
                    Bp=Bp-1;
                    Cp=Cp+1;
                else
                    if t1>1-d %death
                        Bp=Bp-1;
                        de=de+1;
                    else
                        if t3<s
                            Bp=Bp+1; %divide
                        end
                    end
                end
            end
            for k=1:B2(i,j-1)
                t1=rand();
                t2=rand();
                t3=rand();
                if t1<q %m to s
                    B2p=B2p-1;
                    Cp=Cp+1;
                else if t1>1-d %death
                        B2p=B2p-1;
                        de=de+1;
                    else if t3<s2
                            B2p=B2p+1; %divide
                        end
                    end
                end
            end
            for k=1:C(i,j-1)
                t1=rand();
                if t1<r%s to f
                    Bp=Bp+1;
                    Cp=Cp-1;
                else if t1>1-r2 %s to m
                        B2p=B2p+1;
                        Cp=Cp-1;
                    else if t1<0.5+d && t1>0.5
                            Cp=Cp-1;%death
                            de=de+1;
                        else
                            t3=rand();
                            if t3<s3
                                Cp=Cp+1;
                            end
                        end
                    end
                end
            end
        
            B(i,j)=B(i,j-1)+Bp;
            B2(i,j)=B2(i,j-1)+B2p;
            C(i,j)=C(i,j-1)+Cp;
        end
        
    end
    if h==1
        D1=B+C+B2;
        N1=B;
        J1=B2;
        L1=C;
        
        
    else
        if h==2
            D4=B+C+B2;
            N4=B;
            J4=B2;
            L4=C;
        else
            D10=B+C+B2;
            N10=B;
            J10=B2;
            L10=C;
        end
    end
end

save D10.dat D10 -ascii
% output cell number of each half day for each of 80 wells
% each well starts with 10 cells
save D4.dat D4 -ascii
% output cell number of each half day for each of 80 wells
% each well starts with 4 cells
save D1.dat D1 -ascii
% output cell number of each half day for each of 80 wells
% each well starts with 1 cell

