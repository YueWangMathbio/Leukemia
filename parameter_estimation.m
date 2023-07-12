close all
clear all


% find initial type distribution
load A.dat
x=0;
y=0;
z=0;
hth=0.55;
for i=161:240

    gr=0;
    nog=0;
    for j=1:19
        if A(i,j)>5 && A(i,j)<20
            nog=nog+1;
            gr=gr+A(i,j+1)/A(i,j)-1;
        end
    end
    if nog>0
        if gr/nog>hth
            x=x+1;
        else
            y=y+1;
        end
    end
end
z=80-x-y;
fast_ratio=x/80
moderate_ratio=y/80
slow_ratio=z/80

% find r3 for the correct extinction rate
x=0.4:0.01:0.6;
r3=38;
d=0.01;
n=21;
cumu=0;
for i=1:n
    if x(i)/r3<d
        cumu=cumu+1;
    else
        cumu=cumu+d*r3/x(i);
    end
end
extinction_rate=cumu/n

% count cell number, from day 5 or day 6
% 164: 10, 19, 40, 101, 184
% 169 (from day 5): 8, 14, 28, 57, 127, 256
% 171: 12, 29, 74, 189
% 172: 12, 31, 59, 172
% 173: 15, 34, 91, 245
% 185 (from day 5): 6, 14, 35, 85, 171
% 188: 11, 24, 51, 114, 223
% 190 (from day 5): 8, 18, 56, 105, 255
% 191: 11, 29, 75, 185
% 193 (from day 5): 8, 16, 45, 103, 232

% [[0.69, 0.28], [0.43, 0.0], [0.59, 0.0], [0.79, 0.2], [0.62, 0.0], [0.51, 0.04], [0.43, 0.0], [0.72, 0.2], [0.58, 0.0], [0.51, 0.0]]




