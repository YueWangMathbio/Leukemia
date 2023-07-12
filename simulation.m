% this code simulates growth of wells with different initial cell numbers

clear all
close all

% the following 6 parameters can be adjusted in the parameter scan
p=0.4;%probability of fast growing state
p2=0.2;%probability of moderate growing state
p3=1-p-p2;%probability of slow growing state
d=0.01;%death rate. 
rr0=0.1;%range of random modifier
rr1=0.1;
rr2=0.02;
gm=0.5;%growth modifier, max gr at low population





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
        % generate initial population
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
        z0=rand()*2-1;
        z0=z0*rr0; %uniform on -0.1,0.1
        z1=rand()*2-1;
        z1=z1*rr1;
        z2=rand()*2-1;
        z2=z2*rr2;
        % modification on growth rate
        for j=2:45
            po=B(i,j-1)+B2(i,j-1)+C(i,j-1);% total cell number
            s=1-po^2/ca^2;
            s=s*gm;
            s=s+z0;
            temp=2.2;
            s=temp-temp/log(45000)*log(po);
            s2=s/1.5;
            s3=s/50;
            s=s+z0*(ca-po)/ca;
            s2=s2+z1*(ca-po)/ca;
            s3=s3+z2*(ca-po)/ca;
            if po>40000
                s=0;
                s2=0;
                s3=0;
            end
            if s>0.6
                s=0.6;
            end
            if s2>0.3
                s2=0.3;
            end
            if s3>0.01
                s3=0.01;
            end
            if s<0
                s=0;
            end
            if s2<0
                s2=0;
            end
            if s3<0
                s3=0;
            end
            if s>1-d
                s=1-d;
            end
            if s2>1-d
                s2=1-d;
            end
            if s3>1-d
                s3=1-d;
            end

            %s2=s2+z0/1.5;
            %s3=s3+z0/3;

            % finish setting growth rates
%             if i==1 && h==3
%                 disp(j)
%                 disp(s)
%                 disp(s2)
%                 disp(s3)
%                 disp(B(i,j-1))
%                 disp(B2(i,j-1))
%                 disp(C(i,j-1))
%             end
            Bp=0;
            B2p=0;
            Cp=0;
            for k=1:B(i,j-1)
                t1=rand();
                if t1>1-d %death
                    Bp=Bp-1;
                end
                if t1<s
                    Bp=Bp+1; %divide
                end
            end
            for k=1:B2(i,j-1)
                t1=rand();
                if t1>1-d %death
                    B2p=B2p-1;
                end 
                if t1<s2
                    B2p=B2p+1; %divide
                end 
            end
            for k=1:C(i,j-1)
                t1=rand();
                if t1>1-d %death
                    Cp=Cp-1;
                end 
                if t1<s3
                    Cp=Cp+1; %divide
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
    end
    if h==2
        D4=B+C+B2;
        N4=B;
        J4=B2;
        L4=C;
    end
    if h==3
        D10=B+C+B2;
        N10=B;
        J10=B2;
        L10=C;
    end
end
%plot(1:45,log(D10))
% figure(1)
% semilogy(1:45,D10,'r',1:45,D4,'g',1:45,D1,'b')
% ylim([500,50000])
% figure(2)
% plot(1:45,D10,'r',1:45,D4,'g',1:45,D1,'b')
%plot(1:45,D10)
%ylim([7,11])
%save D10.dat D10 -ascii
% output cell number of each half day for each of 80 wells
% each well starts with 10 cells
%save D4.dat D4 -ascii
% output cell number of each half day for each of 80 wells
% each well starts with 4 cells
%save D1.dat D1 -ascii
% output cell number of each half day for each of 80 wells
% each well starts with 1 cell




load A.dat

for i=1:80
    for j=1:22
        R10(i,j)=D10(i,j*2-1);
        S10(i,j)=D10(i,j*2+1)/D10(i,j*2-1)-1;
        R4(i,j)=D4(i,j*2-1);
        S4(i,j)=D4(i,j*2+1)/D4(i,j*2-1)-1;
        R1(i,j)=D1(i,j*2-1);
        S1(i,j)=D1(i,j*2+1)/D1(i,j*2-1)-1;
    end
end

for i=1:80
    for j=1:23
        T10(i,j)=D10(i,j*2-1);
        T4(i,j)=D4(i,j*2-1);       
        T1(i,j)=D1(i,j*2-1);        
    end
end

P=A(:,1:19);
Q=(A(:,2:20)-A(:,1:19))./A(:,1:19);


%%% draw the plot for growth starting from 5 area units
figure(1)
set(gcf, 'Position',  [100, 30, 1100, 1000])
subplot(3,2,1);

R=A(1:80,:);
axis([0 17 4 100])
hold on
plot(0,0,'rx',0,0,'go',0,0,'b+')
for i=1:80
    for j=2:20
        if R(i,j)>5
            t=log(5/R(i,j-1))/log(R(i,j)/R(i,j-1));
            subplot(3,2,1);
            plot(0,5,'rx-',1-t+(0:20-j),R(i,j:20),'rx-');
            set(gca, 'YScale', 'log');
            yticks([5 10 20 40 80]);
            break;
        end
    end
end
title('experimental')
xlabel({'time (day) after'; 'reaching cell area 5'},'FontSize',36)
ylabel('cell area')
h_legend=legend('10-cell group','4-cell group','1-cell group');
set(h_legend,'FontSize',16);
set(gca,'FontSize',16);
hold off

subplot(3,2,3);
G=A(81:160,:);
axis([0 17 4 100])
hold on
for i=1:80
    for j=1:20
        if G(i,j)>5
            t=log(5/G(i,j-1))/log(G(i,j)/G(i,j-1));
            subplot(3,2,3);
            plot(0,5,'go-',1-t+(0:20-j),G(i,j:20),'go-');
            set(gca, 'YScale', 'log');
            yticks([5 10 20 40 80]);
            break;
        end
    end
end
xlabel({'time (day) after'; 'reaching cell area 5'},'FontSize',36)
ylabel('cell area')
set(gca,'FontSize',16);
hold off

B=A(161:240,:);
subplot(3,2,5);
axis([0 17 4 100])
hold on
for i=1:80
    for j=1:20
        if B(i,j)>5
            t=log(5/B(i,j-1))/log(B(i,j)/B(i,j-1));
            subplot(3,2,5);
            plot(0,5,'b+-',1-t+(0:20-j),B(i,j:20),'b+-');
            set(gca, 'YScale', 'log');
            yticks([5 10 20 40 80]);
            break;
        end
    end
end  
xlabel({'time (day) after'; 'reaching cell area 5'},'FontSize',36)
ylabel('cell area')
set(gca,'FontSize',16);
hold off

subplot(3,2,2);
axis([0 17 2000 50000])
hold on
for i=1:80
    for j=2:23
        if T10(i,j)>2500
            t=log(2500/T10(i,j-1))/log(T10(i,j)/T10(i,j-1));
            subplot(3,2,2);
            plot(0,2500,'rx-',1-t+(0:23-j),T10(i,j:23),'rx-');
            set(gca, 'YScale', 'log');
            yticks([2500 5000 10000 20000 40000]);
            break;
        end
    end
end
title('simulation')
xlabel({'time (day) after reaching'; 'cell number 2500'},'FontSize',36)
ylabel('cell number')
set(gca,'FontSize',16);
hold off

subplot(3,2,4);
axis([0 17 2000 50000])
hold on
for i=1:80
    for j=2:23
        if T4(i,j)>2500
            t=log(2500/T4(i,j-1))/log(T4(i,j)/T4(i,j-1));
            subplot(3,2,4);
            plot(0,2500,'go-',1-t+(0:23-j),T4(i,j:23),'go-');
            set(gca, 'YScale', 'log');
            yticks([2500 5000 10000 20000 40000]);
            break;
        end
    end
end
xlabel({'time (day) after reaching'; 'cell number 2500'},'FontSize',36)
ylabel('cell number')
set(gca,'FontSize',16);
hold off

subplot(3,2,6);
axis([0 17 2000 50000])
hold on
for i=1:80
    for j=2:23
        if T1(i,j)>2500
            t=log(2500/T1(i,j-1))/log(T1(i,j)/T1(i,j-1));
            subplot(3,2,6);
            plot(0,2500,'b+-',1-t+(0:23-j),T1(i,j:23),'b+-');
            set(gca, 'YScale', 'log');
            yticks([2500 5000 10000 20000 40000]);
            break;
        end
    end
end
xlabel({'time (day) after reaching'; 'cell number 2500'},'FontSize',36)
ylabel('cell number')
set(gca,'FontSize',16);
hold off


%%%%%%%%%%% growth rate vs area
figure(2)
set(gcf, 'Position',  [100, 100, 1100, 450])
subplot(1,2,1)
plot(0,0,'rx',0,0,'go',0,0,'b+',P(1:80,:),Q(1:80,:),'rx',...
    P(81:160,:),Q(81:160,:),'go',P(161:240,:),Q(161:240,:),'b+')

title('experimental')
xlabel('cell area')
ylabel('growth rate')
axis([5 90 -0.2 1.5])
h_legend=legend('10-cell group','4-cell group','1-cell group');
set(h_legend,'FontSize',16);
set(gca,'FontSize',16)

subplot(1,2,2)
plot(0,0,'rx',0,0,'go',0,0,'b+',R10,S10,'rx',R4,S4,'go',R1,S1,'b+')
title('simulation')
xlabel('cell number')
ylabel('growth rate')
axis([2500 45000 -0.2 1.5])
set(gca,'FontSize',16)


%%%%%%%%%%%% growth curve
figure(3)
set(gcf, 'Position',  [100, 100, 1100, 850])
subplot(2,2,1)
plot(0,0,'r',0,0,'g',0,0,'b',4:23,A(1:80,:)','r',4:23,A(81:160,:)',...
    'g',4:23,A(161:240,:)','b')
title('experimental')
xlabel('time (day)')
ylabel('cell area')
axis([0 23 -5 90])
h_legend=legend('10-cell group','4-cell group','1-cell group');
set(h_legend,'FontSize',16);
set(gca,'FontSize',16)

subplot(2,2,2)
plot(0,0,'r',0,0,'g',0,0,'b',4:23,T10(:,4:23),'r',4:23,T4(:,4:23),'g',...
    4:23,T1(:,4:23),'b');
title('simulation')
xlabel('time (day)')
ylabel('cell number')
axis([0 23 -2500 45000])
set(gca,'FontSize',16)

subplot(2,2,3)
semilogy(0,0,'r',0,0,'g',0,0,'b',4:23,A(1:80,:)','r',4:23,A(81:160,:)',...
    'g',4:23,A(161:240,:)','b')
title('experimental')
xlabel('time (day)')
ylabel('cell area')
axis([0 23 1 90])
set(gca,'FontSize',16)

subplot(2,2,4)
semilogy(0,0,'r',0,0,'g',0,0,'b',4:23,T10(:,4:23),'r',4:23,T4(:,4:23),'g',...
    4:23,T1(:,4:23),'b');
title('simulation')
xlabel('time (day)')
ylabel('cell number')
axis([0 23 500 45000])
set(gca,'FontSize',16)

ext=0;
for i=1:80
    if T1(i,23)==0
        ext=ext+1;
    end
end
ext



