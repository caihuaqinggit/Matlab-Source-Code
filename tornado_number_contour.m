% matlab program to read in tornado data
% sort them according to F scale, and plot them

% This is for all years

%%%  Huaqing Cai, July 2015  %%%%% 

%%%% Modified by Huaqing Cai, Dec 2016 %%%%%%%

clear all;

% set the year and month range and domain 
% from 1950 to 2015 inclusive
% from Jan to Dec inclusive

%year1 = 1950;
year1 = 1980;   % Starting from when NARR data is available
year2 = 2015;
% Here we use March-September
%month1 = 3;
%month2 = 9;

% For March-September, or whole year
month1 = 1;
month2 = 12;


% Domain defined with Lon, Lat at low-left and upper-right conner
% low-left corner (lon1, lat1), upper-right (lon2,lat2)
lon1 = -130;
lon2 = -60;
lat1 = 25;
lat2 = 50;

% lat-lon square for counting number of tornadoes, unit in degree
dlat = 1;
dlon = 1;

% define the x, y coordinates for sorting, Matlab differs big/small
% letters, here the sorting grids are "dots" in the notes
% the array is M by N

x = lon1:dlon:lon2;
y = lat1:dlat:lat2;
[X, Y] = meshgrid(x,y);
M = size(X,1);   % Number of Rows
N = size(X,2);   % Number of Columns


% define the x, y coordinates for plotting (the star "*' array)
% the size of the array is M-1 by N-1

xp = lon1+dlon/2.0:dlon:lon2-dlon/2.0;
yp = lat1+dlat/2.0:dlat:lat2-dlat/2.0;
[XP,YP] = meshgrid(xp,yp);

% 
% F0, F1,.... has the same dimension as XP and YP, they are ny by nx
% iniatialize 2d array that store number of F-scale tornadoes in the square
% defined above

% For example, F0(1,1) is the totla number of tornadoes in the box defined by 
% low-left point (lon1,lat1) and upper-right point: (lon1+dlon, lat1+dlat),
% etc, etc

% declare arrays for count of tornadoes
F0 = zeros(M-1,N-1); 
F1 = zeros(M-1,N-1); 
F2 = zeros(M-1,N-1); 
F3 = zeros(M-1,N-1); 
F4 = zeros(M-1,N-1); 
F5 = zeros(M-1,N-1); 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Open file for read


fid=fopen('/home/caihq/Cao/DEC2016/Actual_tornadoes.txt','r');

i=0;
j=0;
k=0;

% while loop to read in data
while(1)
    linein=fgets(fid);
    if (linein==-1)
        disp('Hit end of file')
        break
    end
    
    k=k+1;  % counter of number of lines read
    
    %TEST
    %disp(k);
    
    % read in the whole string, pick out the string you want
    % string is deliminated by space
    % dat{1} is the first string, dat{2} is the second, etc
    % We read in 5 parameters for now: 
    % (1) Year:                dat{1} = '1950'
    % (2) Month:               dat{2} = '1'
    % (3) F Scale              dat{3} = '0'
    % (4) Start_LAT            dat{4} =  '47.35571'
    % (5) Start_LON            dat{5} = '-92.23549'
    % 
    
    [dat,count] = textscan(linein, '%*s %s %s %*s %*s %*s %*s %*s %*s %*s %s %*s %*s %*s %*s %s %s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s') ;     
    
    year = str2double(dat{1}{1});
    month = str2double(dat{2}{1});
    fscale = str2double(dat{3}{1});
    lat = str2double(dat{4}{1});
    lon = str2double(dat{5}{1});
    
    % Check if read is right
    display(k);
    %display(year);
    %display(month);
    %display(fscale);
    %display(lat);
    %display(lon);
    
    %pause;
    
    % check and sort the data into f0[x,y], f1[x,y], etc
    
    if (year >= year1 && year <= year2 && month >= month1 && month <= month2)   % Check year and month range
       for i=1:M-1        % Row loop
           for j=1:N-1    % Column loop
               if ((lon >= X(i,j) && lon < X(i, j+1)) && (lat >= Y(i,j) && lat < Y(i+1, j)))  % find a tornado within BOX (i,j) and (i+1,j+1)
                   if fscale == 0
                       F0(i,j) = F0(i,j)+1;
                   elseif fscale == 1
                       F1(i,j) = F1(i,j)+1;
                   elseif fscale == 2
                       F2(i,j) = F2(i,j)+1; 
                   elseif fscale == 3
                       F3(i,j) = F3(i,j)+1;
                   elseif fscale == 4
                       F4(i,j) = F4(i,j)+1;
                   elseif fscale == 5
                       F5(i,j) = F5(i,j)+1;
                   end
               end     % End of BOX loop
           end
       end     % End of for LOOP for the star * array
    
    end     % End of check time
    
    
        
    
end     % end of read each lines of the file loop
    
%%%%% Filter/Smoothing the data for plotting using convulition filter
Filter = [.05 .1 .05; .1 .4 .1; .05 .1 .05];

F0C = conv2(F0,Filter,'same');
F1C = conv2(F1,Filter,'same');
F2C = conv2(F2,Filter,'same');
F3C = conv2(F3,Filter,'same');
F4C = conv2(F4,Filter,'same');
F5C = conv2(F5,Filter,'same');


% Start make plots

%%%%%%%%%%%%% Number of F0 plots  %%%%%%%%%%%%%%%%%
figure(1)
box on;
hold on;
clevels = 50:50:250; % contour levels 
contour(XP,YP,F0C,clevels,'ShowText', 'on');

axis([lon1 lon2 lat1 lat2]);
title('F0 Tornadoes','fontsize',14,'fontweight','bold');
xlabel('Lon');
ylabel('Lat');

set(gca,'XTick',-130:10:-60);  % set the tick
set(gca,'XTickLabel',{'130W','120W','110W','100W','90W','80W','70W','60W'}); 
set(gca,'YTick',25:5:50);  % set the Y tick
set(gca,'YTickLabel',{'25N','30N','35N','40N','45N','50N'}); 


jpgfile='F0.jpg';
print (1,'-djpeg95','-r100', jpgfile);

epsfile='F0.eps';
print (1, '-depsc2', epsfile);
pause; 
close(1)

%%%%%%%%%%%%%%%%%%% Number of F1 plots %%%%%%%%%%%%%%%%%%%
figure(1)
box on;
hold on;
clevels = 20:20:160; % contour levels 
contour(XP,YP,F1C,clevels,'ShowText', 'on');



axis([lon1 lon2 lat1 lat2]);
title('F1 Tornadoes','fontsize',14,'fontweight','bold');
xlabel('Lon');
ylabel('Lat');

set(gca,'XTick',-130:10:-60);  % set the tick
set(gca,'XTickLabel',{'130W','120W','110W','100W','90W','80W','70W','60W'}); 
set(gca,'YTick',25:5:50);  % set the Y tick
set(gca,'YTickLabel',{'25N','30N','35N','40N','45N','50N'}); 



jpgfile='F1.jpg';
print (1,'-djpeg95','-r100', jpgfile);

epsfile='F1.eps';
print (1, '-depsc2', epsfile);

pause; 
close(1)

% Number of F2 plots
figure(1)
box on;
hold on;
clevels = 10:10:100; % contour levels 
contour(XP,YP,F2C,clevels,'ShowText', 'on');



axis([lon1 lon2 lat1 lat2]);
title('F2 Tornadoes','fontsize',14,'fontweight','bold');
xlabel('Lon');
ylabel('Lat');

set(gca,'XTick',-130:10:-60);  % set the tick
set(gca,'XTickLabel',{'130W','120W','110W','100W','90W','80W','70W','60W'}); 
set(gca,'YTick',25:5:50);  % set the Y tick
set(gca,'YTickLabel',{'25N','30N','35N','40N','45N','50N'}); 



jpgfile='F2.jpg';
print (1,'-djpeg95','-r100', jpgfile);

epsfile='F2.eps';
print (1, '-depsc2', epsfile);

pause; 
close(1)

% Number of F3 plots
figure(1)
box on;
hold on;
clevels = 5:5:25; % contour levels 
contour(XP,YP,F3C,clevels,'ShowText', 'on');


axis([lon1 lon2 lat1 lat2]);
title('F3 Tornadoes','fontsize',14,'fontweight','bold');
xlabel('Lon');
ylabel('Lat');

set(gca,'XTick',-130:10:-60);  % set the tick
set(gca,'XTickLabel',{'130W','120W','110W','100W','90W','80W','70W','60W'}); 
set(gca,'YTick',25:5:50);  % set the Y tick
set(gca,'YTickLabel',{'25N','30N','35N','40N','45N','50N'}); 


jpgfile='F3.jpg';
print (1,'-djpeg95','-r100', jpgfile);

epsfile='F3.eps';
print (1, '-depsc2', epsfile);

pause; 
close(1)

%%%%%%%%%%%% Number of F4 plots    %%%%%%%%%%%%%%%%%%%
figure(1)
box on;
hold on;
clevels = 1:2:21; % contour levels 
contour(XP,YP,F4C,clevels,'ShowText', 'on');



axis([lon1 lon2 lat1 lat2]);
title('F4 Tornadoes','fontsize',14,'fontweight','bold');
xlabel('Lon');
ylabel('Lat');

set(gca,'XTick',-130:10:-60);  % set the tick
set(gca,'XTickLabel',{'130W','120W','110W','100W','90W','80W','70W','60W'}); 
set(gca,'YTick',25:5:50);  % set the Y tick
set(gca,'YTickLabel',{'25N','30N','35N','40N','45N','50N'}); 



jpgfile='F4.jpg';
print (1,'-djpeg95','-r100', jpgfile);

epsfile='F4.eps';
print (1, '-depsc2', epsfile);

pause; 
close(1)

%%%%%%%%% Number of F5 plots %%%%%%%%%%%%

figure(1)
box on;
hold on;
clevels = 1:1:10; % contour levels 
contour(XP,YP,F5C,clevels,'ShowText', 'on');


axis([lon1 lon2 lat1 lat2]);
title('F5 Tornadoes','fontsize',14,'fontweight','bold');
xlabel('Lon');
ylabel('Lat');

set(gca,'XTick',-130:10:-60);  % set the X tick
set(gca,'XTickLabel',{'130W','120W','110W','100W','90W','80W','70W','60W'}); 
set(gca,'YTick',25:5:50);  % set the Y tick
set(gca,'YTickLabel',{'25N','30N','35N','40N','45N','50N'}); 


jpgfile='F5.jpg';
print (1,'-djpeg95','-r100', jpgfile);

epsfile='F5.eps';
print (1, '-depsc2', epsfile);

pause; 
close(1)

%%%%%%%% Number of All  %%%%%%%%%%%



