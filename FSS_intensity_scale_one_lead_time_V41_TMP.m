%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab program to read in MET FSS data & plot them
% This program read in one file such as
%  grid_stat_m3o3gsdlaps_LAX_070000L_20120207_190000V_nbrcnt.txt
% Which is only for one lead time only
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%  Huaqing Cai, Aug 2017  %%%%% 


clear all;

% The input parameters are:
% [1] number of thresholds: NX
% [2] number of scales: NY
% [3] MET output file name: *_nbrcnt.txt

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The numner of thresholds NX and number of scales NY 
% have to be given in the program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NX = 7;
NY = 9;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization of arrays 

xp = zeros(1,NX);
yp = zeros(1,NY);
zp = zeros(NY,NX);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Open file for read


fid=fopen('./grid_stat_m3o3gsdlaps_LAX_070000L_20120207_190000V_nbrcnt.txt','r');

k=0;

% skip the first lien, since it is the header
linein=fgets(fid);

% while loop to read in all the data
for j = 1: NY   % scale loop
  for i= 1:NX  % threshold loop, which changes first !
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
    % The string skipped is %*s, the string read is %s
    % We read in 4 parameters for now: 
    % (1) Lead Time:           dat{1} = 'HHMMSS'
    % (2) Neighborhood Size:   dat{2} = '1'
    % (3) Thresholds:          dat{3} = '>=265.000'
    % (4) FSS:                 dat{4} =  '1.00000'
    % 
    
    [dat,count] = textscan(linein, '%*s %*s %s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %s %s %*s %*s %*s %*s %*s %*s %*s %*s %s %*s %*s') ;     
    
    % manipulate the string for proper lead time by get rid of zeros after
    % HH
    LTIME = str2double(strrep(dat{1}{1},'0000',''));  % get rid of the zeros after HH
    scale = sqrt(str2double(dat{2}{1}));  % Scale is square root of neighborehood size, which was read into the program as dat{2}
    thres = str2double(strrep(dat{3}{1},'>=','')); % get rid of '>=' in front of 265.000
    FSS = str2double(dat{4}{1});
    
    % Check if read is right
    display(k);
    display(LTIME);
    display(scale);
    display(thres);
    display(FSS);
    
    
    %pause;
    
    % put the data into the respective xp, yp, and zp (which is FSS score)
    % arrays for plotting
    
    xp(i) = thres;
    yp(j) = scale;
    zp(j,i) = FSS; % Why need to reverse i,j here?
    
   end     % end of threshold loop
end     % End of scale loop  %%% END of read file  %%%%%%
    
 
%%%% Make a mesh for plotting  %%%%%        
[XP,YP] = meshgrid(xp,yp);   
    
%%%%% Filter/Smoothing the data for plotting using convulition filter
%Filter = [.05 .1 .05; .1 .4 .1; .05 .1 .05];

%ZPC = conv2(zp,Filter,'same');

% It seems that filter does NOT help!
% So we choose NOT filter the data 

ZPC = zp;


% Start make plots

%%%%%%%%%%%%% FSS plots for one singel forecast lead time  %%%%%%%%%%%%%%%%%
figure(1)
box on;
hold on;
clevels = 0:0.1:1.0; % contour levels 
contour(XP,YP,ZPC,clevels,'ShowText', 'on');

axis([265 295 0 18]);
title(['Fractions Skill Scores: Lead Time = ',num2str(LTIME),' Hrs'],'fontsize',14,'fontweight','bold');
xlabel('DBZ Threshold');
ylabel('Spatial Scales (grids)');

set(gca,'XTick',265:5:295);  % set the tick
set(gca,'XTickLabel',{'265','270','275','280','285','290','295'}); 
set(gca,'YTick',1:2:17);  % set the Y tick
set(gca,'YTickLabel',{'1','3','5','7','9','11','13','15','17'}); 


jpgfile=['FSS-',num2str(LTIME), 'Hr.jpg'];
print (1,'-djpeg95','-r100', jpgfile);

epsfile=['FSS-',num2str(LTIME), 'Hr.eps'];
print (1, '-depsc2', epsfile);
pause; 
close(1)




