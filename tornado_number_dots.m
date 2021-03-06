% matlab program to read in tornado data
% sort them according to F scale, and plot them as dots, not contours

% This is for all years

% Instead of count the number of tornadoes in a certain box as the contour
% plots required, here we just plot each tornado initial position as a dot

% Therefore, no sorting is necessary in this program!!!

%%%  Huaqing Cai, July 2015  %%%%% 
%%% Modified by Huaqing Cai, Dec 2016  %%%%

clear all;

% set the year and month range and domain 
% from 1950 to 2015 inclusive
% from Jan to Dec inclusive

year1 = 1950;
year2 = 2015;   % expand to year 2015
% Here we use March-September
month1 = 3;
month2 = 9;

% For March-September
%month1 = 1;
%month2 = 12;


% Domain defined with Lon, Lat at low-left and upper-right conner
% low-left corner (lon1, lat1), upper-right (lon2,lat2)
lon1 = -130;
lon2 = -60;
lat1 = 25;
lat2 = 50;

% lat-lon square for counting number of tornadoes, unit in degree
dlat = 1;
dlon = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Open file for read

fid=fopen('/home/caihq/Cao/DEC2016/Actual_tornadoes.txt','r');

i=0;
j=0;
k=0;
% Initialize counters for F0, F1, ...
    i0 = 0;
    i1 = 0;
    i2 = 0;
    i3 = 0;
    i4 = 0;
    i5 = 0;
    
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
    
    if (year >= year1 && year <= year2 && month >= month1 && month <= month2)   % Check year and month range
                   
        %%%%%%%% Check for each F scale  %%%%%%%%%%%%
        if fscale == 0
           i0 = i0+1;
           x0(i0) = lon;
           y0(i0) = lat;
        elseif fscale == 1
           i1 = i1+1;
           x1(i1) = lon;
           y1(i1) = lat;
        elseif fscale == 2
           i2 = i2+1;
           x2(i2) = lon;
           y2(i2) = lat;
        elseif fscale == 3
           i3 = i3+1;
           x3(i3) = lon;
           y3(i3) = lat;
        elseif fscale == 4
           i4 = i4+1;
           x4(i4) = lon;
           y4(i4) = lat;
        elseif fscale == 5
           i5 = i5+1;
           x5(i5) = lon;
           y5(i5) = lat;
        end        %%%% End of check F scale IF block
    
    end     % End of check time
          
    
end     % end of read each lines of the file loop
    

% Start make plots

%%%%%%%%%%%%% Number of F0 plots  %%%%%%%%%%%%%%%%%
figure(1)
box on;
hold on;
a = 5;    %% Specify marker size
scatter(x0,y0,a,'.')   %%% Specify marker symbol, '.' for a point

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
a = 5;    %% Specify marker size
scatter(x1,y1,a,'o', 'filled')   %%% Specify marker symbol: 'o' for circle

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
a = 5;    %% Specify marker size
scatter(x2,y2,a,'*')   %%% Specify marker symbol: '*' for star

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
a = 5;    %% Specify marker size as 140
scatter(x3,y3,a,'+')   %%% Specify marker symbol: '+' for plus size

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
a = 5;    %% Specify marker size
scatter(x4,y4,a,'s')   %%% Specify marker symbol: 's' for square

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
a = 5;    %% Specify marker size
scatter(x5,y5,a,'d')   %%% Specify marker symbol: 'd' for diamond

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



