
clear all
close all

load D10.dat
load D4.dat
load D1.dat
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
plot(0,0,'rx')
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
h_legend=legend('10-cell group');
set(h_legend,'FontSize',16);
set(gca,'FontSize',16);
hold off

subplot(3,2,3);
G=A(81:160,:);
axis([0 17 4 100])
hold on
plot(0,0,'go')
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
h_legend=legend('4-cell group');
set(h_legend,'FontSize',16);
set(gca,'FontSize',16);
hold off

B=A(161:240,:);
subplot(3,2,5);
axis([0 17 4 100])
hold on
plot(0,0,'b+')
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
h_legend=legend('1-cell group');
set(h_legend,'FontSize',16);
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


%%%%%%%%%%%% growth rate vs area
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

% subplot(2,2,3)
% U=csvread('grwithsd.csv');
% hold on
% plot(0,0,'r',0,0,'b');
% errorbar(U(:,1)+0.4,U(:,2),U(:,3),'r')
% errorbar(U(:,1),U(:,4),U(:,5),'b')
% xlabel('cell area')
% ylabel('growth rate')
% axis([5 80 -0.1 1.5])
% h_legend=legend('10-cell group','1-cell group');
% set(h_legend,'FontSize',16);
% set(gca,'FontSize',16)
% 
% for i=1:13
%     n1=i*2500;
%     n2=n1+2500;
%     clear K10 K1
%     c=1;
%     d=1;
%     for j=1:80
%         for k=1:22
%             if T10(j,k)>n1 && T10(j,k)<n2
%                 K10(c)=T10(j,k+1)/T10(j,k)-1;
%                 c=c+1;
%             end
%             if T1(j,k)>n1 && T1(j,k)<n2
%                 K1(d)=T1(j,k+1)/T1(j,k)-1;
%                 d=d+1;
%             end
%         end
%     end
%     M10(i)=mean(K10);
%     SD10(i)=std(K10);
%     M1(i)=mean(K1);
%     SD1(i)=std(K1);
% end
% 
% he=3750:2500:33750;
% he2=he+200;
% 
% subplot(2,2,4)
% hold on
% plot(0,0,'r',0,0,'b');
% errorbar(he2,M10,SD10,'r')
% errorbar(he,M1,SD1,'b')
% axis([2500 40000 -0.1 1.5])
% xlabel('cell number')
% ylabel('growth rate')
% set(gca,'FontSize',16)


%%%%%%%%%%%%% growth curve
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
set(h_legend,'FontSize',14);
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
ylabel('cell area in logarithm')
axis([0 23 5 90])
h_legend=legend('10-cell group','4-cell group','1-cell group');
set(h_legend,'FontSize',14);
set(gca,'FontSize',16)
yticks([10 20 40 80])

subplot(2,2,4)
semilogy(0,0,'r',0,0,'g',0,0,'b',4:23,T10(:,4:23),'r',4:23,T4(:,4:23),'g',...
    4:23,T1(:,4:23),'b');
title('simulation')
xlabel('time (day)')
ylabel('cell number in logarithm')
axis([0 23 2500 45000])
set(gca,'FontSize',16)
yticks([5000 10000 20000 40000])


%%%%%%%%%%%%%% extra
% figure(4)
% set(gcf, 'Position',  [100, 100, 1300, 500])
% subplot(1,2,1);
% 
% R=A(1:80,:);
% axis([0 17 4 100])
% hold on
% plot(0,0,'rx',0,0,'go',0,0,'b+')
% for i=1:80
%     for j=2:20
%         if R(i,j)>5
%             t=log(5/R(i,j-1))/log(R(i,j)/R(i,j-1));
%             %subplot(2,1,1);
%             plot(0,5,'rx-',1-t+(0:20-j),R(i,j:20),'rx-');
%             set(gca, 'YScale', 'log');
%             yticks([5 10 20 40 80]);
%             break;
%         end
%     end
% end
% %title('experimental')
% xlabel({'time (day) after'; 'reaching cell area 5'},'FontSize',36)
% ylabel('cell area')
% %h_legend=legend('10-cell group','4-cell group','1-cell group');
% %set(h_legend,'FontSize',16);
% set(gca,'FontSize',16);
% hold off
% 
% 
% 
% B=A(161:240,:);
% subplot(1,2,2);
% axis([0 17 4 100])
% hold on
% for i=1:80
%     for j=1:20
%         if B(i,j)>5
%             t=log(5/B(i,j-1))/log(B(i,j)/B(i,j-1));
%             %subplot(3,2,5);
%             plot(0,5,'b+-',1-t+(0:20-j),B(i,j:20),'b+-');
%             set(gca, 'YScale', 'log');
%             yticks([5 10 20 40 80]);
%             break;
%         end
%     end
% end  
% xlabel({'time (day) after'; 'reaching cell area 5'},'FontSize',36)
% ylabel('cell area')
% set(gca,'FontSize',16);
% hold off