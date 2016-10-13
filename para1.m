function varargout = para1(varargin)
% PARA1 MATLAB code for para1.fig
%      PARA1, by itself, creates a new PARA1 or raises the existing
%      singleton*.
%
%      H = PARA1 returns the handle to a new PARA1 or the handle to
%      the existing singleton*.
%
%      PARA1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARA1.M with the given input arguments.
%
%      PARA1('Property','Value',...) creates a new PARA1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before para1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to para1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help para1

% Last Modified by GUIDE v2.5 10-Feb-2012 16:00:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @para1_OpeningFcn, ...
                   'gui_OutputFcn',  @para1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before para1 is made visible.
function para1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to para1 (see VARARGIN)



% Choose default command line output for para1
handles.output = hObject;




% Update handles structure
guidata(hObject, handles);

% UIWAIT makes para1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = para1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

axes(handles.axes1); % this is used to set focus on the axes currently in use
axes(handles.axes5); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%top 4 buttons 

function aboutpara_Callback(hObject, eventdata, handles)
mp1=msgbox('this is parametric analysis', 'parametric analysis');
set( mp1, 'color', [ 0.9 0.9 .9 ] )


function helppara_Callback(hObject, eventdata, handles)
mp2=msgbox('Choose a Vehicle Parameter and input the values by which you would like to change this parameter.  Press GO! to run the simulations.  Choose which values to plot to investigate the effect of this parameter', 'help!');
set( mp2, 'color', [ 0.9 0.9 .9 ] )


function saveplot_Callback(hObject, eventdata, handles)
%allow the user to specify where to save the settings file
[filename,pathname] = uiputfile('save_results','Save Results');

if pathname == 0 %if the user pressed cancelled, then we exit this callback
    return
end

%construct the path name of the save location
saveDataName = fullfile(pathname,filename); 

%saves the gui data
hgsave(saveDataName);



function home_Callback(hObject, eventdata, handles)
global OVEM_31OK
OVEM_31OK(1)=[0]

handles.output = hObject;
guidata(hObject, handles);
close();
ovemplus

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function drivecycle_Callback(hObject, eventdata, handles)
global SPD
SPD(3) = get(handles.drivecycle,'value')

if SPD(3)==1
dc=msgbox('Please select a drive cycle', 'Drivecycle');
set( dc, 'color', [ 0.9 0.9 .9 ] )
set(handles.gocompare,'visible','off')
else
set(handles.gocompare,'visible','on')
end

function drivecycle_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%vehicle compare
function gocompare_Callback(hObject, eventdata, handles)
global SPD
global OVEM_31OK       
OVEM_31=0;

SPD(3) = get(handles.drivecycle,'value')

if SPD(3)==1
    dc=msgbox('Please select a drive cycle', 'Drivecycle');
set( dc, 'color', [ 0.9 0.9 .9 ] )
else
ovem_31();   
end

if OVEM_31OK(1)==1
    mchoose=msgbox('vehicle Sweep Done! Please select from the comparison options.','Vehicle Comparison');
    set( mchoose, 'color', [ 0.9 0.9 .9 ] )
    set(handles.comparesame,'visible','on');
    %set(handles.fordifferent,'visible','on');
    set(handles.compare_text,'visible','on');
    %set(handles.fordifferent_text,'visible','on');
else
    set(handles.compare_text,'visible','off');
    %set(handles.fordifferent_text,'visible','off');
    set(handles.comparesame,'visible','off');
    %set(handles.fordifferent,'visible','off');
    %set(handles.constant,'visible','off');
    %set(handles.fordifferent,'visible','off');
    set(handles.plotycompare,'visible','off')
    set(handles.plot,'visible','off')
end


function comparesame_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function comparesame_Callback(hObject, eventdata, handles)
cs=get(handles.comparesame,'value');
if(cs==2)
    set(handles.fordifferent_text,'visible','on');
    set(handles.fordifferent,'visible','on');
    set(handles.fordifferent,'string','Powertrain');
    set(handles.smmt_text,'visible','on');
    set(handles.smmt,'visible','on');
    set(handles.pwrtrain_text,'visible','off');
    set(handles.pwrtrain,'visible','off');
   
elseif(cs==3);
    set(handles.fordifferent_text,'visible','on');
    set(handles.fordifferent,'visible','on');
    set(handles.fordifferent,'string','SMMT Category');
    set(handles.smmt_text,'visible','off');
    set(handles.smmt,'visible','off');
    set(handles.pwrtrain_text,'visible','on');
    set(handles.pwrtrain,'visible','on');

else
    set(handles.fordifferent_text,'visible','off');
    set(handles.fordifferent,'visible','off');
    set(handles.smmt_text,'visible','off');
    set(handles.smmt,'visible','off');
    set(handles.pwrtrain_text,'visible','off');
    set(handles.pwrtrain,'visible','off');
    
end

function smmt_Callback(hObject, eventdata, handles)
global SSC
SPD(1)=get(handles.smmt,'value')
SSC=SPD(1)-1

if(SPD(1)>1);
    set(handles.ploty,'visible','on');
    set(handles.ploty_text,'visible','on');
    set(handles.plot,'visible','on');
else
    set(handles.ploty,'visible','off');
    set(handles.ploty_text,'visible','off');
    set(handles.plot,'visible','off');
end

function smmt_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pwrtrain_Callback(hObject, eventdata, handles)
global PWT
PWR=get(handles.pwrtrain,'value')
PWT=PWR-1

if(PWR>1);
    set(handles.ploty,'visible','on');
    set(handles.ploty_text,'visible','on');
     set(handles.plot,'visible','on');
else
    set(handles.ploty,'visible','off');
    set(handles.ploty_text,'visible','off');
     set(handles.plot,'visible','off');
end

function pwrtrain_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% function fordifferent_Callback(hObject, eventdata, handles)
% cs=get(handles.comparesame,'value');
% fd=get(handles.fordifferent,'value');
% if(cs==2&&fd==3)||(cs==3&&fd==2);
%     set(handles.constant,'visible','on');
%     set(handles.fordifferent,'visible','on');
%     set(handles.fordifferent,'string','Drivecycle');
%     set(handles.plotycompare,'visible','on');
%     set(handles.plot,'visible','on');
% else
%     set(handles.constant,'visible','off');
%     set(handles.fordifferent,'visible','off');
%     set(handles.plotycompare,'visible','off');
%     set(handles.plot,'visible','off');
% end
% 
% 
% function fordifferent_CreateFcn(hObject, eventdata, handles)
% 
% % Hint: popupmenu controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%results

function ploty_Callback(hObject, eventdata, handles)


function ploty_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end    



function plot_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function plot_Callback(hObject, eventdata, handles)
global SSC
global PWT
global MJKM
global GHGKM
global NCC
global MJKMWTW
global GHGKMWTW

ttw=get(handles.TTW,'value');
wtw=get(handles.WTW,'value');
cs=get(handles.comparesame,'value');
py=get(handles.ploty,'value');
if (ttw==1 && wtw==0);
    a=1;
elseif (ttw==0 && wtw==1);
    a=2;
elseif (ttw==1 && wtw==1);
    a=3;
elseif (ttw==0 && wtw==0);
    a=0;
end

if  (cs==2) ;%same SMMT Category, Different powertrain
    if py==1;
     pchoose=msgbox('please select a value from the plot y-axis','Error Plot y-axis');
    set( pchoose, 'color', [ 0.9 0.9 .9 ] )

    elseif py==2 && a(1)==1;
        PLOTX=MJKM(SSC,:);
        set(handles.TTW,'visible','on');
        set(handles.WTW,'visible','on');
     set(handles.axes5,'visible','on');
        bar(PLOTX);
    %    set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
     set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
   xlabel('Powertrain');
    elseif py==2 && a(1)==2;
        PLOTX=MJKMWTW(SSC,:);
        set(handles.TTW,'visible','on');
        set(handles.WTW,'visible','on');
             set(handles.axes5,'visible','on');
        bar(PLOTX);
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');
    elseif py==2 && a(1)==3;
        NEWBARMJ=MJKMWTW-MJKM;
        STACKMJ=[MJKM(SSC,1) NEWBARMJ(SSC,1);MJKM(SSC,2) NEWBARMJ(SSC,2);MJKM(SSC,3) ...
            NEWBARMJ(SSC,3);MJKM(SSC,4) NEWBARMJ(SSC,4);MJKM(SSC,5) NEWBARMJ(SSC,5);MJKM(SSC,6) NEWBARMJ(SSC,6)];
        set(handles.TTW,'visible','on');
        set(handles.WTW,'visible','on');
             set(handles.axes5,'visible','on');
        bar(STACKMJ,'stack');
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');
       legend('TTW','WTW-TTW');
    elseif py==3 && a(1)==1;
        PLOTX=GHGKM(SSC,:);
        set(handles.TTW,'visible','on');
        set(handles.WTW,'visible','on');
             set(handles.axes5,'visible','on');
        bar(PLOTX);
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');
    elseif py==3 && a(1)==2;
        PLOTX=GHGKMWTW(SSC,:);
        set(handles.TTW,'visible','on');
        set(handles.WTW,'visible','on');
             set(handles.axes5,'visible','on');
        bar(PLOTX);
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');
    elseif py==3 && a(1)==3;
        NEWBARGHG=GHGKMWTW-GHGKM;
        STACKGHG=[GHGKM(SSC,1) NEWBARGHG(SSC,1);GHGKM(SSC,2) NEWBARGHG(SSC,2);GHGKM(SSC,3) NEWBARGHG(SSC,3);GHGKM(SSC,4) NEWBARGHG(SSC,4);GHGKM(SSC,5) NEWBARGHG(SSC,5);GHGKM(SSC,6) NEWBARGHG(SSC,6)];
        set(handles.TTW,'visible','on');
        set(handles.WTW,'visible','on');
             set(handles.axes5,'visible','on');
        bar(STACKGHG,'stack');
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');    
       legend('TTW','WTW-TTW');
    elseif py==4 && (a(1)==1||a(1)==2||a(1)==3)
        PLOTX=NCC(SSC,:);
        set(handles.TTW,'visible','off');
        set(handles.WTW,'visible','off');
             set(handles.axes5,'visible','on');
        bar(PLOTX);
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');
    else
    end 
        
elseif (cs==3) ; %same powertrain, different smmt category
    if py==1;
     pchoose=msgbox('please select a value from the plot y-axis','Error Plot y-axis');
    set( pchoose, 'color', [ 0.9 0.9 .9 ] )
    elseif py==2 && a(1)==1;
        PLOTX=MJKM(:,PWT);
        set(handles.TTW,'visible','on');
        set(handles.WTW,'visible','on');
             set(handles.axes5,'visible','on');
        bar(PLOTX);
        set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);
        %set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
    elseif py==2 && a(1)==2;
        PLOTX=MJKMWTW(:,PWT);
        set(handles.TTW,'visible','on');
        set(handles.WTW,'visible','on');
             set(handles.axes5,'visible','on');
        bar(PLOTX);
        %set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
    elseif py==2 && a(1)==3;
        NEWBARMJ=MJKMWTW-MJKM;
        STACKMJ=[MJKM(1,PWT) NEWBARMJ(1,PWT);MJKM(2,PWT) NEWBARMJ(2,PWT);MJKM(3,PWT) NEWBARMJ(3,PWT);MJKM(4,PWT) NEWBARMJ(4,PWT);MJKM(5,PWT) NEWBARMJ(5,PWT);MJKM(6,PWT) NEWBARMJ(6,PWT);MJKM(7,PWT) NEWBARMJ(7,PWT);MJKM(8,PWT) NEWBARMJ(8,PWT);MJKM(9,PWT) NEWBARMJ(9,PWT)];
        set(handles.TTW,'visible','on');
        set(handles.WTW,'visible','on');     
        set(handles.axes5,'visible','on');
        bar(STACKMJ,'stack');
        %set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
        legend('TTW','WTW-TTW');
    elseif py==3 && a(1)==1;
        PLOTX=GHGKM(:,PWT);
        set(handles.TTW,'visible','on');
        set(handles.WTW,'visible','on');
             set(handles.axes5,'visible','on');
        bar(PLOTX);
        %set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);

        xlabel('SMMT Category');
    elseif py==3 && a(1)==2;
        PLOTX=GHGKMWTW(:,PWT);
        set(handles.TTW,'visible','on');
        set(handles.WTW,'visible','on');
             set(handles.axes5,'visible','on');
        bar(PLOTX);
        %set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);

        xlabel('SMMT Category');
    elseif py==3 && a(1)==3;
        NEWBARGHG=GHGKMWTW-GHGKM;
        STACKGHG=[GHGKM(1,PWT) NEWBARGHG(1,PWT);GHGKM(2,PWT) NEWBARGHG(2,PWT);GHGKM(3,PWT) NEWBARGHG(3,PWT);GHGKM(4,PWT) NEWBARGHG(4,PWT);GHGKM(5,PWT) NEWBARGHG(5,PWT);GHGKM(6,PWT) NEWBARGHG(6,PWT);GHGKM(7,PWT) NEWBARGHG(7,PWT);GHGKM(8,PWT) NEWBARGHG(8,PWT);GHGKM(9,PWT) NEWBARGHG(9,PWT)];
        set(handles.TTW,'visible','on');
        set(handles.WTW,'visible','on');     
        set(handles.axes5,'visible','on');
        bar(STACKGHG,'stack');
        %set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
        legend('TTW','WTW-TTW');
    elseif py==4 && (a(1)==1||a(1)==2||a(1)==3);
        PLOTX=NCC(:,PWT);
        set(handles.TTW,'visible','off');
        set(handles.WTW,'visible','off');     
        set(handles.axes5,'visible','on');
        bar(PLOTX);
        %set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
    else
    end     
end



y={'Energy Consumption [MJ/100 km]' 'Greenhouse Gas [g CO2/km]' 'Capital Cost [� x 10,000]'}; 

if py==2;
    ylabel(y{(py-1)});
elseif py==3;
    ylabel(y{(py-1)});
    elseif py==4;
    ylabel(y{(py-1)});
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TTW or WTW

function TTW_Callback(hObject, eventdata, handles)
ttw=get(handles.TTW,'value');
wtw=get(handles.WTW,'value');
cs=get(handles.comparesame,'value');
py=get(handles.ploty,'value');

if (ttw==1 && wtw==0);
    a=1;
elseif (ttw==0 && wtw==1);
    a=2;
elseif (ttw==1 && wtw==1);
    a=3;
elseif (ttw==0 && wtw==0);
    a=0;
end

global MJKM
global GHGKM
global NCC
global MJKMWTW
global GHGKMWTW
global SSC
global PWT

%NEWBARMJ=MJKMWTW-MJKM
%NEWBARGHG=GHGKMWTW-GHGKM
%STACKMJ=[MJKM NEWBARMJ]
%STACKGHG=[GHGKM NEWBARGHG]

% plotting the chart
if  (cs==2) ;%same SMMT Category, Different powertrain
    if py==2 && a(1)==1;
        PLOTX=MJKM(SSC,:);
     set(handles.axes5,'visible','on');
        bar(PLOTX);
    %    set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
     set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
   xlabel('Powertrain');
    elseif py==2 && a(1)==2;
        PLOTX=MJKMWTW(SSC,:);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');
    elseif py==2 && a(1)==3;
        NEWBARMJ=MJKMWTW-MJKM;
        STACKMJ=[MJKM(SSC,1) NEWBARMJ(SSC,1);MJKM(SSC,2) NEWBARMJ(SSC,2);MJKM(SSC,3) ...
            NEWBARMJ(SSC,3);MJKM(SSC,4) NEWBARMJ(SSC,4);MJKM(SSC,5) NEWBARMJ(SSC,5);MJKM(SSC,6) NEWBARMJ(SSC,6)];
        bar(STACKMJ,'stack');
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');
       legend('TTW','WTW-TTW');
    elseif py==3 && a(1)==1;
        PLOTX=GHGKM(SSC,:);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');
    elseif py==3 && a(1)==2;
        PLOTX=GHGKMWTW(SSC,:);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');
    elseif py==3 && a(1)==3;
        NEWBARGHG=GHGKMWTW-GHGKM;
        STACKGHG=[GHGKM(SSC,1) NEWBARGHG(SSC,1);GHGKM(SSC,2) NEWBARGHG(SSC,2);GHGKM(SSC,3) NEWBARGHG(SSC,3);GHGKM(SSC,4) NEWBARGHG(SSC,4);GHGKM(SSC,5) NEWBARGHG(SSC,5);GHGKM(SSC,6) NEWBARGHG(SSC,6)];
        bar(STACKGHG,'stack');
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');    
       legend('TTW','WTW-TTW');
    elseif py==4 && (a(1)==1||a(1)==2||a(1)==3)
        PLOTX=NCC(SSC,:);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');
    else
    end 
        
elseif (cs==3) ; %same powertrain, different smmt category
    if py==2 && a(1)==1;
        PLOTX=MJKM(:,PWT);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
        set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);
        %set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
    elseif py==2 && a(1)==2;
        PLOTX=MJKMWTW(:,PWT);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
        %set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);

        xlabel('SMMT Category');
    elseif py==2 && a(1)==3;
        NEWBARMJ=MJKMWTW-MJKM;
        STACKMJ=[MJKM(1,PWT) NEWBARMJ(1,PWT);MJKM(2,PWT) NEWBARMJ(2,PWT);MJKM(3,PWT) NEWBARMJ(3,PWT);MJKM(4,PWT) NEWBARMJ(4,PWT);MJKM(5,PWT) NEWBARMJ(5,PWT);MJKM(6,PWT) NEWBARMJ(6,PWT);MJKM(7,PWT) NEWBARMJ(7,PWT);MJKM(8,PWT) NEWBARMJ(8,PWT);MJKM(9,PWT) NEWBARMJ(9,PWT)];
             set(handles.axes5,'visible','on');
        bar(STACKMJ,'stack');
        %set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
        legend('TTW','WTW-TTW');
    elseif py==3 && a(1)==1;
        PLOTX=GHGKM(:,PWT);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
        %set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);

        xlabel('SMMT Category');
    elseif py==3 && a(1)==2;
        PLOTX=GHGKMWTW(:,PWT);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
        %set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);

        xlabel('SMMT Category');
    elseif py==3 && a(1)==3;
        NEWBARGHG=GHGKMWTW-GHGKM;
        STACKGHG=[GHGKM(1,PWT) NEWBARGHG(1,PWT);GHGKM(2,PWT) NEWBARGHG(2,PWT);GHGKM(3,PWT) NEWBARGHG(3,PWT);GHGKM(4,PWT) NEWBARGHG(4,PWT);GHGKM(5,PWT) NEWBARGHG(5,PWT);GHGKM(6,PWT) NEWBARGHG(6,PWT);GHGKM(7,PWT) NEWBARGHG(7,PWT);GHGKM(8,PWT) NEWBARGHG(8,PWT);GHGKM(9,PWT) NEWBARGHG(9,PWT)];
             set(handles.axes5,'visible','on');
        bar(STACKGHG,'stack');
        %set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
        legend('TTW','WTW-TTW');
    elseif py==4 && (a(1)==1||a(1)==2||a(1)==3);
        PLOTX=NCC(:,PWT);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
        %set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
    else
    end     
end

y={'Energy Consumption [MJ/100 km]' 'Greenhouse Gas [g CO2/km]' 'Capital Cost [� x 10,000]'}; 

if py==2;
    ylabel(y{(py-1)});
elseif py==3;
    ylabel(y{(py-1)});
    elseif py==4;
    ylabel(y{(py-1)});
end



function WTW_Callback(hObject, eventdata, handles)
ttw=get(handles.TTW,'value');
wtw=get(handles.WTW,'value');
cs=get(handles.comparesame,'value');
py=get(handles.ploty,'value');

if (ttw==1 && wtw==0)
    a=1;
elseif (ttw==0 && wtw==1)
    a=2;
elseif (ttw==1 && wtw==1)
    a=3;
elseif (ttw==0 && wtw==0)
    a=0;
    %ttwmsg=msgbox('Please select TTW and-or WTW', 'TTW and/or WTW');
    %set( ttwmsg, 'color', [ 0.9 0.9 .9 ] )
end


global MJKM
global GHGKM
global NCC
global MJKMWTW
global GHGKMWTW
global SSC
global PWT

%plotting the chart
if  (cs==2) ;%same SMMT Category, Different powertrain
    if py==2 && a(1)==1;
        PLOTX=MJKM(SSC,:);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');
    elseif py==2 && a(1)==2;
        PLOTX=MJKMWTW(SSC,:);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');
    elseif py==2 && a(1)==3;
        NEWBARMJ=MJKMWTW-MJKM;
        STACKMJ=[MJKM(SSC,1) NEWBARMJ(SSC,1);MJKM(SSC,2) NEWBARMJ(SSC,2);MJKM(SSC,3) NEWBARMJ(SSC,3);MJKM(SSC,4) NEWBARMJ(SSC,4);MJKM(SSC,5) NEWBARMJ(SSC,5);MJKM(SSC,6) NEWBARMJ(SSC,6)];
            set(handles.axes5,'visible','on');
        bar(STACKMJ,'stack');
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');
       legend('TTW','WTW-TTW');
    elseif py==3 && a(1)==1;
        PLOTX=GHGKM(SSC,:);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');
    elseif py==3 && a(1)==2;
        PLOTX=GHGKMWTW(SSC,:);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');
    elseif py==3 && a(1)==3;
        NEWBARGHG=GHGKMWTW-GHGKM;
        STACKGHG=[GHGKM(SSC,1) NEWBARGHG(SSC,1);GHGKM(SSC,2) NEWBARGHG(SSC,2);GHGKM(SSC,3) NEWBARGHG(SSC,3);GHGKM(SSC,4) NEWBARGHG(SSC,4);GHGKM(SSC,5) NEWBARGHG(SSC,5);GHGKM(SSC,6) NEWBARGHG(SSC,6)];
             set(handles.axes5,'visible','on');
        bar(STACKGHG,'stack');
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');   
       legend('TTW','WTW-TTW');
    elseif py==4 && (a(1)==1||a(1)==2||a(1)==3);
        PLOTX=NCC(SSC,:);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
%        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
 set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',10);
       xlabel('Powertrain');
    else
    end 
        
elseif (cs==3) ; %same powertrain, different smmt category
    if py==2 && a(1)==1;
        PLOTX=MJKM(:,PWT);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
        %set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);

        xlabel('SMMT Category');
    elseif py==2 && a(1)==2;
        PLOTX=MJKMWTW(:,PWT);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
        %set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);

        xlabel('SMMT Category');
    elseif py==2 && a(1)==3;
        NEWBARMJ=MJKMWTW-MJKM;
        STACKMJ=[MJKM(1,PWT) NEWBARMJ(1,PWT);MJKM(2,PWT) NEWBARMJ(2,PWT);MJKM(3,PWT) NEWBARMJ(3,PWT);MJKM(4,PWT) NEWBARMJ(4,PWT);MJKM(5,PWT) NEWBARMJ(5,PWT);MJKM(6,PWT) NEWBARMJ(6,PWT);MJKM(7,PWT) NEWBARMJ(7,PWT);MJKM(8,PWT) NEWBARMJ(8,PWT);MJKM(9,PWT) NEWBARMJ(9,PWT)];
            set(handles.axes5,'visible','on');
        bar(STACKMJ,'stack');
%        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
 set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);
       xlabel('SMMT Category');
       legend('TTW','WTW-TTW');
    elseif py==3 && a(1)==1;
        PLOTX=GHGKM(:,PWT);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
 %       set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
  set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);
      xlabel('SMMT Category');
    elseif py==3 && a(1)==2;
        PLOTX=GHGKMWTW(:,PWT);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
%        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
    elseif py==3 && a(1)==3;
        NEWBARGHG=GHGKMWTW-GHGKM;
        STACKGHG=[GHGKM(1,PWT) NEWBARGHG(1,PWT);GHGKM(2,PWT) NEWBARGHG(2,PWT);GHGKM(3,PWT) NEWBARGHG(3,PWT);GHGKM(4,PWT) NEWBARGHG(4,PWT);GHGKM(5,PWT) NEWBARGHG(5,PWT);GHGKM(6,PWT) NEWBARGHG(6,PWT);GHGKM(7,PWT) NEWBARGHG(7,PWT);GHGKM(8,PWT) NEWBARGHG(8,PWT);GHGKM(9,PWT) NEWBARGHG(9,PWT)];
             set(handles.axes5,'visible','on');
        bar(STACKGHG,'stack');
%        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
 set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);
       xlabel('SMMT Category');
       legend('TTW','WTW-TTW');
    elseif py==4 && (a(1)==1||a(1)==2||a(1)==3);
        PLOTX=NCC(:,PWT);
             set(handles.axes5,'visible','on');
        bar(PLOTX);
%        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
 set(gca,'XTickLabel',{'M' 'SM' 'LM' 'UM' 'E' 'LS' 'SS' 'DP' 'MPV'},'FontSize',9);
       xlabel('SMMT Category');
    else
    end     
end

y={'Energy Consumption [MJ/100 km]' 'Greenhouse Gas [g CO2/km]' 'Capital Cost [� x 10,000]'}; 

if py==2;
    ylabel(y{(py-1)});
elseif py==3;
    ylabel(y{(py-1)});
    elseif py==4;
    ylabel(y{(py-1)});
end
