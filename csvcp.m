%??csv????????????
%{1}??????
%{2}???????
%{3}csv????
%{4}???????

%%2015-03-22 by coldzoo
function flag = csvcp(src_file_dir,dst_file_dir,csv_filename,jump_first_line)

    if nargin<2||nargin>4
        disp('Argument Count incorrect! ');
        flag=false;
        return;
    end
    if nargin==2
        disp('Using default csv file name filelist.csv ');
        disp('Jumping first line in the csv file');
        csv_filename='filelist.csv';
        jump_first_line=true;
    end
    
    if exist(dst_file_dir,'dir')~=7
        disp(['Destinate file folder ',dst_file_dir,' not exist,CREATING']);
        mkdir(dst_file_dir);
    end
    
     if exist(csv_filename,'file')==0
        csv_filename=[src_file_dir,'/../',csv_filename];
        if exist(csv_filename,'file')==0
            disp('Csv file not exist');
            flag=false;
            return;
        else
            disp('Using csv file near the source image folder!');
        end
     end
         
    
    fid=fopen(csv_filename,'r');
    [filelist]=textscan(fid,'%s%*[^\n]');
    filelist=filelist{1,1};
    
    if jump_first_line==true
        startindex=2;
    else
        startindex=1;
    end
    if numel(filelist)>0
        for i=startindex:numel(filelist)
            copyfile([src_file_dir,'/',filelist{i}],[dst_file_dir,'/',filelist{i}]);
            disp(['copying file: ',filelist{i}]);
        end
        flag=true;
    else
        disp('csv file content error! ');
        flag=false;
        return;
    end
    
    disp('Done!');
end