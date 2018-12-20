
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab program to read in MET FSS data & plot them
% This program read in many files, which is of the type such as
% grid_stat_1kmReenWRF_120000L_20140925_180000V_nbrcnt.txt
% Each individual file is for one lead time only.
% By reading a list of those files, we should be able to plot a time series
% of the FSS scores
%
% THIS PROGRAM IS FOR MET V5.2
% The other program is for V4.1
% BUT the useful info, i.e., the column number for FSS, etc are the same!!
% Therefore, basically there is no change to this MATlab program for read
%
% Input foer the program:
% (1) first create a text file contains all the names of txt file
%     with the first line of the text file to be the number of files.
%     The file name is always input_nbrcnt_file_names.txt
% (2) number of neighborhood size and number of DBZ thresholds
%     NX and NY, which is assigned inside this program
% (3) the neighborehood size and DBZ threshold you want to plot,
%     which is also specified inside this program
%     For example, DBZ_thres = 20, NB_size = 10 (means 10X10 km*km)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%  Huaqing Cai, Sep 2018  %%%%% 

%%% This is for making the final plots of FFS scores for overlay %%%%%
%%% Only the Y-axis scale for FSS and BIAS are changed compared to NON-final version %%%%%%
%%% Only 20 DBZ threshold was used  %%%%


clearvars;

% The input parameters are:
% [1] number of thresholds: NX
% [2] number of scales: NY
% [3] MET output file name list: input_nbrcnt_file_names.txt
% [4] plotting threshold: DBZ_thres
% [5] plotting neighborhood size: NB_size

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The numner of thresholds NX and number of scales NY 
% have to be given in the program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NX = 8;
NY = 25;

% assign DBZ threshold and neighborhood size
DBZ_thres = 20;
NB_size = 11;

% data directory where input_nbrcnt_file_names.txt and all nbrcnt text file
% are located

%%%%%%%%%% For Radar DA experiment 181015B %%%%%%%%%%
%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181015B_v52/';
%experiment = '181015B';

%%%%%%%%%% For Radar DA experiment 181015E %%%%%%%%%%
%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181015E_v52/';
%experiment = '181015E';

%%%%%%%%%% For Radar DA experiment 181016B %%%%%%%%%%
%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181016B_v52/';
%experiment = '181016B';

%%%%%%%%%% For Radar DA experiment 181016E %%%%%%%%%%
%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181016E_v52/';
%experiment = '181016E';

%%%%%%%%%% For Radar DA experiment 181016F %%%%%%%%%%
%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181016F_v52/';
%experiment = '181016F';


%%%%%%%%%% For Radar DA experiment 181005B %%%%%%%%%%
%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181005B_v52/';
%experiment = '181005B';

%%%%%%%%%% For Radar DA experiment 181005D %%%%%%%%%%
%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181005D_v52/';
%experiment = '181005D';


%%%%%%%%%% For Radar DA experiment 180801B %%%%%%%%%%
%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_180801B_v52/';
%experiment = '180801B';

%%%%%%%%%% For Radar DA experiment 180918B %%%%%%%%%%
%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_180918B_v52/';
%experiment = '180918B';

%%%%%%%%%% For Radar DA experiment 180720B %%%%%%%%%%
%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_180720B_v52/';
%experiment = '180720B';

%%%%%%%%%% For Radar DA experiment 180831B %%%%%%%%%%
%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_180831B_v52/';
%experiment = '180831B';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% EXperiment 181201  %%%%%%%%%%%%%%%%%%
%%%%%% For radar DA experiments for AMS annual meeting  %%%%%
%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181201A_v52/';
%experiment = '181201A';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181201B_v52/';
%experiment = '181201B';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181201C_v52/';
%experiment = '181201C';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181201D_v52/';
%experiment = '181201D';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181201E_v52/';
%experiment = '181201E';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181201F_v52/';
%experiment = '181201F';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181201G_v52/';
%experiment = '181201G';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181201H_v52/';
%experiment = '181201H';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181201I_v52/';
%experiment = '181201I';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181201J_v52/';
%experiment = '181201J';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181201K_v52/';
%experiment = '181201K';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181201L_v52/';
%experiment = '181201L';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Experiment 181204    %%%%%%%%%%%%%%%%%%
%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181204A_v52/';
%experiment = '181204A';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181204B_v52/';
%experiment = '181204B';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181204C_v52/';
%experiment = '181204C';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181204D_v52/';
%experiment = '181204D';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181204E_v52/';
%experiment = '181204E';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181204F_v52/';
%experiment = '181204F';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181204G_v52/';
%experiment = '181204G';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181204H_v52/';
%experiment = '181204H';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181204I_v52/';
%experiment = '181204I';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181204J_v52/';
%experiment = '181204J';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181204K_v52/';
%experiment = '181204K';

%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_181204L_v52/';
%experiment = '181204L';




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% For NO Radar DA experiment 180619B %%%%%%%%%%
%data_dir = '/home/caihq/RADEX2018/FSS/data/MET_GridStat/results_m3o3_180619B_v52/';
%experiment = '180619B';




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Open the file contains file names to be read
% 
fid = fopen([data_dir,'input_nbrcnt_file_names.txt'],'r');

% read the number of files
nfile = fscanf(fid,'%d');
for k = 1:nfile

% read in the file name
linein=fgets(fid);
[dat,count] = textscan(linein, '%s');
fname = dat{1}{1};  % get the file name from input file

%fname = fscanf(fid,'%s\n'); % fscanf won't work since it reads in the
% whole file, not a singel line as we waanted

% produce the input file name 
fname_read = [data_dir,fname];


done_file_flag = 0;   % set the flag for indicating if this file is read

% open the file to read
fid1 = fopen(fname_read,'r');

% skip the first line from nbr count file, since it is the header
linein=fgets(fid1);

% initialize line counter kk, which is the number of line that have been read
kk = 0;  

for j = 1: NY   % scale loop
  for i= 1:NX  % threshold loop, which changes first !
    linein=fgets(fid1);
    if (linein==-1)
        disp('Hit end of file')
        break
    end
    
    kk = kk+1;  % counter of number of lines read
    
    % read in the whole string, pick out the string you want
    % string is deliminated by space
    % dat{1} is the first string, dat{2} is the second, etc
    % The string skipped is %*s, the string read is %s
    % We read in 4 parameters for now: 
    % (1) Lead Time:           dat{1} = 'HHMMSS'           %% Column 3
    % (2) Neighborhood Size:   dat{2} = '1'                %% Column 16
    % (3) Thresholds:          dat{3} = '>=265.000'        %% Column 17
    % (4) FSS:                 dat{4} =  '1.00000'         %% Column 26
    % (5) F_RATE:              dat{5} = '0.0020185'        %% Column 35
    % (6) O_RATE:              dat{6} = '0.14265'          %% Column 38
    % 
    
    [dat,count] = textscan(linein, '%*s %*s %s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %s %s %*s %*s %*s %*s %*s %*s %*s %*s %s %*s %*s %*s %*s %*s %*s %*s %*s %s %*s %*s %s') ;     
    
    % manipulate the string for proper lead time by get rid of zeros after
    % MM, that is, keep HHMM
    
    
    LTIME_HH = str2double(dat{1}{1}(1:2));  % get lead time HH
    LTIME_MM = str2double(dat{1}{1}(3:4));  % get lead time MM
    LTIME = LTIME_HH + LTIME_MM/60;         % convert MM to HH
    
    scale = sqrt(str2double(dat{2}{1}));  % Scale is square root of neighborehood size, which was read into the program as dat{2}
    thres = str2double(strrep(dat{3}{1},'>=','')); % get rid of '>=' in front of 265.000
    FSS = str2double(dat{4}{1});
    f_rate = str2double(dat{5}{1});
    o_rate = str2double(dat{6}{1});
    
   
    %pause;
      
    % check if this line of data is the correct DBZ_thres and NB_size
    if thres == DBZ_thres && scale == NB_size
        % Check if read is right
        display(kk);
        display(LTIME);
        %display(scale);
        %display(thres);
        display(FSS);
        %display(f_rate);
        %display(o_rate);
    
        %pause;
       
       x_leadtime(k) = LTIME;  % matlab suggesting pre-allocating arrays, but the final size of array
       y_fss(k) = FSS;         % has to be known before pre-allocate the arry, otherwise arrays will
       y_f_rate(k) = f_rate;   % have some zeros in them, which cause issues for plotting!!!
       y_o_rate(k) = o_rate;
       y_bias(k) = f_rate/o_rate;
       done_file_flag =1;   % flag for done with a file
       fclose(fid1);   % The data for this file is read, so you must close this file!!!
       break;    % get out of the singel file loop, go to next file since this one is done
       
    end
    
   end     % End of threshold FOR loop for a particular file
   
   % check if this file is done
   if done_file_flag == 1
      break;  % break ouf of the scale FOR loop
   end
   
   
 end       % End of scale FOR loop for a particular file
 
 
end        % End of read all files loop

fclose(fid);

    
% Start make plots

%%%%%%%%%%%%% FSS plots for one singel forecast lead time  %%%%%%%%%%%%%%%%%
figure(1)
box on;
hold on;
yyaxis left   % plot on the left y-axis
line(x_leadtime,y_fss,'Color','red','LineStyle','-','LineWidth',2);  % solid
line(x_leadtime,y_f_rate, 'Color','blue','LineStyle','--','LineWidth',2); % dashed
line(x_leadtime,y_o_rate, 'Color','green','LineStyle','--','LineWidth',2); % dotted
 
axis([0 12 0 0.8]);
title(['FFS ',experiment, ' ',num2str(DBZ_thres),' dBZ ',num2str(NB_size),' Grid Square'],'fontsize',14,'fontweight','bold');
xlabel('Lead Time (hr)');
ylabel('FSS, F/O Rate');

set(gca,'XTick',0:1:12);  % set the tick
set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8','9','10','11','12'}); 

%set(gca,'XTick',0:2:24);  % set the tick
%set(gca,'XTickLabel',{'0','2','4','6','8','10','12','14','16','18','20','22','24'}); 


set(gca,'YTick',0:0.1:0.8);  % set the Y tick
set(gca,'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8'}); 
%set(gca,'YTick',0:0.1:0.5);  % set the Y tick
%set(gca,'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5'}); 

% plot on the right Y-axis for bias
yyaxis right
axis([0 12 0 1.5]);
line(x_leadtime,y_bias,'Color','black','LineStyle','-','LineWidth', 2);  % solid
ylabel('Bias');
set(gca,'YTick',0:0.25:1.50);  % set the Y tick
set(gca,'YTickLabel',{'0','0.25','0.50','0.75','1.00','1.25','1.50'}); 

% Put legends on
legend('FSS','F-RATE', 'O-RATE','BIAS'); 

jpgfile=['FSS-bias-time-series-Radar-DA-DBZ',num2str(DBZ_thres),'-NB',num2str(NB_size),'_',experiment '.jpg'];
print (1,'-djpeg95','-r100', jpgfile);

epsfile=['FSS-bias-time-series-Radar-DA-DBZ',num2str(DBZ_thres),'-NB',num2str(NB_size),'_',experiment '.eps'];
print (1, '-depsc2', epsfile);
pause; 
close(1)




