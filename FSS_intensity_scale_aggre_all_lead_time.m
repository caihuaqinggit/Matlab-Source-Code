%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab program to read in MET FSS data & plot them
% This program read in one file such as
% stat_analysis_Kwaj_WRF_No_radar_DA.txt
% Which is aggregated FSS scores for all the lead time
% Each line is for a singel dbz threshold and neighborhood size
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%  Huaqing Cai, Aug 2018 %%%%% 


clearvars;
% The input parameters are:
% [1] number of thresholds: NX
% [2] number of scales: NY
% [3] MET output file name: stat_analysis_Kwaj_WRF_No_radar_DA.txt

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The numner of thresholds NX and number of scales NY 
% have to be given in the program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NX = 8;
NY = 25;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization of arrays 

%xp = zeros(1,NX);
%yp = zeros(1,NY);
%zp = zeros(NY,NX);

% The parameters read from the MET output file are:
% [1] thresholds in DBZ
% [2] scales or neighborhood size in km NY
% [3] FSS score for a particular threshold and neighborhood 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Open file for read

% Reen WRF Simulations

% NO Radar DA
fid=fopen('/home/caihq/RADEX2018/FSS/data/MET_GridStat/stat_analysis_180619B_KwajFSS_No_radar_DA.txt','r');

% with radar DA
%fid=fopen('/home/caihq/RADEX2018/FSS/data/MET_GridStat/stat_analysis_180720B_KwajFSS_with_radar_DA.txt','r');


for j = 1: NY   % scale loop
 for i= 1:NX  % threshold loop, which changes first !


k=0;

% while loop to read in all the data
  for kk = 1:4   % here each (i,j) pair have 4 lines to read, thus 1:4
    linein=fgets(fid);
    if (linein==-1)
        disp('Hit end of file')
        break
    end
    
    k=k+1;  % counter of number of lines read
    
    %TEST
    %disp(k);
    
    % First pick up the correct string to read
    % if it is the size/threshold line, then:
    if length(linein) > 1
       if linein(1:8) == 'JOB_LIST'
        
          % read in the whole string, pick out the part you want
          % string is deliminated by space
          % dat{1} is the first string, dat{2} is the second, etc
          % The string skipped is %*s, the string read is %s
          % We read in 2 parameters for now: 
          %
          % (1) Neighborhood Size:   dat{1} = '1'                %% Column 7
          % (2) Thresholds:          dat{2} = '>=5.0'        %% Column 9
          % 
          [dat,count] = textscan(linein, '%*s %*s %*s %*s %*s %*s %s %*s %s %*[^\n]');
          scale = sqrt(str2double(dat{1}{1}));  % Scale is square root of neighborehood size, which was read into the program as dat{1}
          thres = str2double(strrep(dat{2}{1},'>=','')); % get rid of '>=' in front of 265.000
    
          % assign thres and scale to arrays
          %xp(NX+1-i) = thres;
          xp(i) = thres;
          yp(j) = scale;
       end      % end of read in the size/threhold line identified by "JOB_LIST"
    
       % read the FSS score line starting with "  NBRCNT"
       if linein(1:8) == '  NBRCNT' 
          % read in the whole string, pick out the part you want
          % string is deliminated by space
          % dat{1} is the first string, dat{2} is the second, etc
          % The string skipped is %*s, the string read is %s
          % We read in 1 parameters for now: 
          % (1) FSS:                 dat{1} =  '1.00000'         %% Column 6
          % 
    
          [dat,count] = textscan(linein, '%*s %*s %*s %*s %*s %s %*[^\n]'); 
          FSS = str2double(dat{1}{1});
       
          % assign FSS to array
          zp(j,i) = FSS; % Why need to reverse i,j here?
          
       end      % end of read in FSS score line identified by "  NBRCNT"
    
    end    % end of if block for NONE empty line
   end     % end of for loop for reading the 4 lines
   
   % Check if read is right
    display(k);
    display(scale);
    display(thres);
    display(FSS);
    
    %pause;
    
 end       % end of threshold loop
end        % end of scale loop (outer loop)

   %%% END of read file  %%%%%%
    
 
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
clevels = 0:0.01:1.0; % contour levels 
contourf(XP,YP,ZPC,clevels,'ShowText', 'on');

%axis([5 40 1 25]);
axis([5 40 1 50]);
title(['Fractions Skill Scores:','All Lead Time'],'fontsize',14,'fontweight','bold');
xlabel('DBZ Threshold');
ylabel('Spatial Scales (grids)');

set(gca,'XTick',5:5:40);  % set the tick
set(gca,'XTickLabel',{'5','10','15','20','25','30','35','40'}); 
%set(gca,'YTick',1:2:49);  % set the Y tick
%set(gca,'YTickLabel',{'1','3','5','7','9','11','13','15','17','19','21','23','25','27','29','31','33','35','37','39','41','43','45','47','49'}); 

%set(gca,'YTick',1:2:50);  % set the Y tick
set(gca,'YTick',5:5:50);  % set the Y tick
set(gca,'YTickLabel',{'5','10','15','20','25','30','35','40','45','50'}); 

jpgfile=['FSS-', 'All-Hr.jpg'];
print (1,'-djpeg95','-r100', jpgfile);

epsfile=['FSS-', 'All-Hr.eps'];
print (1, '-depsc2', epsfile);

pause; 
close(1)




