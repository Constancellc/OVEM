function varargout = plot_results(varargin)
% PLOT_RESULTS MATLAB code for plot_results.fig
%      PLOT_RESULTS, by itself, creates a novice PLOT_RESULTS or raises the existing
%      singleton*.
%
%      H = PLOT_RESULTS returns the handle to a novice PLOT_RESULTS or the handle to
%      the existing singleton*.
%
%      PLOT_RESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_RESULTS.M with the given input arguments.
%
%      PLOT_RESULTS('Property','Value',...) creates a novice PLOT_RESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_results_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_results_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plot_results

% Last Modified by GUIDE v2.5 11-Jan-2012 10:25:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_results_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_results_OutputFcn, ...
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


% --- Executes just before plot_results is made visible.
function plot_results_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_results (see VARARGIN)

global SPD; %SPD=[SMMT powertrain drivecycle]

SCC=SPD(1)-1;
smmtcategories = {'Mini' 'Super Mini' 'Lower Medium' 'Upper Medium' 'Executive' 'Luxury Saloon' 'Specialists Sports' 'Dual Purpose' 'MPV'};
bestselling = {'Hyundai i10' 'Ford Fiesta' 'Ford Focus' 'BMW 3 Series' 'Mercedes-Benz C Class' 'Mercedes-Benz S Class' 'Volkswagen Scirocco' 'Honda CR-V' 'Vauxhall Zafira'};
SPC=SPD(2)-1;
powertrain = {'petrol' 'diesel' 'dual hybrid' 'plugin hybrid' 'electric' 'fuel cell'};
SDC=SPD(3)-1;
drivecycle = {'NEDC' 'Artemis' 'FUDS' 'NYCC' 'US06' 'US HWFET' 'US EPA'};

global VCOMP  %23=sc,dp,cd; 32=sp,ds,cd; 22=not possible, 33=not possible
%listing what is the user choice on top
if  ((VCOMP(1)==2) && (VCOMP(2)==3)) %same category, different powertrain
    set(handles.smmt2,'string',smmtcategories{SCC}); %sets category
    set(handles.best2,'string',bestselling{SCC}); %sets best in category
    set(handles.pt2,'string','variable');
    set(handles.text93,'string',drivecycle{SDC});  %constant drive cycle as which was previously selected in vmod1
elseif ((VCOMP(1)==3) && (VCOMP(2)==2)) %same powertrain, different smmt category
    set(handles.smmt2,'string','variable'); %sets category
    %set(handles.best1,'visible','off'); %switches off best in category
    set(handles.best2,'string','variable'); %switches off best in category
    set(handles.pt2,'string',powertrain{SPC}); %sets powertrain
    set(handles.text93,'string',drivecycle{SDC}); %constant drive cycle as which was previously selected in vmod1
    xlabel('SMMT Category');
end




% --- Outputs from this function are returned to the command line.
function varargout = plot_results_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1); % this is used to set focus on the axes currently in use
axes(handles.axes4);

%showing TTW or WTW
global VCOMP
if (VCOMP(4)==2||VCOMP(4)==3)
    set(handles.TTW,'visible','on')
    set(handles.WTW,'visible','on')
else
    set(handles.TTW,'visible','off')
    set(handles.WTW,'visible','off')
end


global PLOTX

%plotting the chart
if  ((VCOMP(1)==2) && (VCOMP(2)==3)) %same SMMT Category, Different powertrain
    bar(PLOTX);
set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
xlabel('Powertrain');
    %if ttw==1
        

elseif ((VCOMP(1)==3) && (VCOMP(2)==2)) %same powertrain, different smmt category
bar(PLOTX);
set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
xlabel('SMMT Category');
end

y={'Energy Consumption [MJ/100km]' 'Greenhouse Gas [gCO2/km]' 'Capital Cost [£]'}; 

if VCOMP(4)==2
    ylabel(y{(VCOMP(4)-1)});
elseif VCOMP(4)==3
    ylabel(y{(VCOMP(4)-1)});
    elseif VCOMP(4)==4
    ylabel(y{(VCOMP(4)-1)});
end



function TTW_Callback(hObject, eventdata, handles)
ttw=get(handles.TTW,'value');
wtw=get(handles.WTW,'value');
if (ttw==1 && wtw==0)
    a=[1]
elseif (ttw==0 && wtw==1)
    a=[2]
elseif (ttw==1 && wtw==1)
    a=[3]
elseif (ttw==0 && wtw==0)
    a=[0]
    %ttwmsg=msgbox('Please select TTW and-or WTW', 'TTW and/or WTW');
    %set( ttwmsg, 'color', [ 0.9 0.9 .9 ] )
end

global VCOMP
global MJKM
global GHGKM
global NCC
global MJKMWTW
global GHGKMWTW
global SCC
global PWT

%NEWBARMJ=MJKMWTW-MJKM
%NEWBARGHG=GHGKMWTW-GHGKM
%STACKMJ=[MJKM NEWBARMJ]
%STACKGHG=[GHGKM NEWBARGHG]

%plotting the chart
if  ((VCOMP(1)==2) && (VCOMP(2)==3))%same SMMT Category, Different powertrain
    if VCOMP(4)==2 && a(1)==1
        PLOTX=MJKM(SCC,:);
        bar(PLOTX);
        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
        xlabel('Powertrain');
    elseif VCOMP(4)==2 && a(1)==2
        PLOTX=MJKMWTW(SCC,:);
        bar(PLOTX);
        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
        xlabel('Powertrain');
    elseif VCOMP(4)==2 && a(1)==3
        NEWBARMJ=MJKMWTW-MJKM;
        STACKMJ=[MJKM(SCC,1) NEWBARMJ(SCC,1);MJKM(SCC,2) NEWBARMJ(SCC,2);MJKM(SCC,3) NEWBARMJ(SCC,3);MJKM(SCC,4) NEWBARMJ(SCC,4);MJKM(SCC,5) NEWBARMJ(SCC,5);MJKM(SCC,6) NEWBARMJ(SCC,6)];
        bar(STACKMJ,'stack');
        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
        xlabel('Powertrain');
        legend('TTW','WTT')
    elseif VCOMP(4)==3 && a(1)==1
        PLOTX=GHGKM(SCC,:);
        bar(PLOTX);
        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
        xlabel('Powertrain');
    elseif VCOMP(4)==3 && a(1)==2
        PLOTX=GHGKMWTW(SCC,:);
        bar(PLOTX);
        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
        xlabel('Powertrain');
    elseif VCOMP(4)==3 && a(1)==3
        NEWBARGHG=GHGKMWTW-GHGKM;
        STACKGHG=[GHGKM(SCC,1) NEWBARGHG(SCC,1);GHGKM(SCC,2) NEWBARGHG(SCC,2);GHGKM(SCC,3) NEWBARGHG(SCC,3);GHGKM(SCC,4) NEWBARGHG(SCC,4);GHGKM(SCC,5) NEWBARGHG(SCC,5);GHGKM(SCC,6) NEWBARGHG(SCC,6)];
        bar(STACKGHG,'stack');
        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
        xlabel('Powertrain');  
        legend('TTW','WTT')
    elseif VCOMP(4)==4 && (a(1)==1||a(1)==2||a(1)==3)
        PLOTX=NCC(SCC,:);
        bar(PLOTX);
        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
        xlabel('Powertrain');
        legend('TTW','WTT')
    else
    end 
        
elseif ((VCOMP(1)==3) && (VCOMP(2)==2)) %same powertrain, different smmt category
    if VCOMP(4)==2 && a(1)==1
        PLOTX=MJKM(:,PWT);
        bar(PLOTX);
        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
    elseif VCOMP(4)==2 && a(1)==2
        PLOTX=MJKMWTW(:,PWT);
        bar(PLOTX);
        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
    elseif VCOMP(4)==2 && a(1)==3
        NEWBARMJ=MJKMWTW-MJKM;
        STACKMJ=[MJKM(1,PWT) NEWBARMJ(1,PWT);MJKM(2,PWT) NEWBARMJ(2,PWT);MJKM(3,PWT) NEWBARMJ(3,PWT);MJKM(4,PWT) NEWBARMJ(4,PWT);MJKM(5,PWT) NEWBARMJ(5,PWT);MJKM(6,PWT) NEWBARMJ(6,PWT);MJKM(7,PWT) NEWBARMJ(7,PWT);MJKM(8,PWT) NEWBARMJ(8,PWT);MJKM(9,PWT) NEWBARMJ(9,PWT)];
        bar(STACKMJ,'stack');
        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
        legend('TTW','WTT')
    elseif VCOMP(4)==3 && a(1)==1
        PLOTX=GHGKM(:,PWT);
        bar(PLOTX);
        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
    elseif VCOMP(4)==3 && a(1)==2
        PLOTX=GHGKMWTW(:,PWT);
        bar(PLOTX);
        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
    elseif VCOMP(4)==3 && a(1)==3
        NEWBARGHG=GHGKMWTW-GHGKM;
        STACKGHG=[GHGKM(1,PWT) NEWBARGHG(1,PWT);GHGKM(2,PWT) NEWBARGHG(2,PWT);GHGKM(3,PWT) NEWBARGHG(3,PWT);GHGKM(4,PWT) NEWBARGHG(4,PWT);GHGKM(5,PWT) NEWBARGHG(5,PWT);GHGKM(6,PWT) NEWBARGHG(6,PWT);GHGKM(7,PWT) NEWBARGHG(7,PWT);GHGKM(8,PWT) NEWBARGHG(8,PWT);GHGKM(9,PWT) NEWBARGHG(9,PWT)];
        bar(STACKGHG,'stack');
        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
        legend('TTW','WTT')
    elseif VCOMP(4)==4 && (a(1)==1||a(1)==2||a(1)==3)
        PLOTX=NCC(:,PWT);
        bar(PLOTX);
        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
    else
    end     
end


y={'Energy Consumption [MJ/100km]' 'Greenhouse Gas [gCO2/km]' 'Capital Cost [£]'}; 

if VCOMP(4)==2
    ylabel(y{(VCOMP(4)-1)});
elseif VCOMP(4)==3
    ylabel(y{(VCOMP(4)-1)});
    elseif VCOMP(4)==4
    ylabel(y{(VCOMP(4)-1)});
end


function WTW_Callback(hObject, eventdata, handles)
ttw=get(handles.TTW,'value');
wtw=get(handles.WTW,'value');
if (ttw==1 && wtw==0)
    a=[1]
elseif (ttw==0 && wtw==1)
    a=[2]
elseif (ttw==1 && wtw==1)
    a=[3]
elseif (ttw==0 && wtw==0)
    a=[0]
    %ttwmsg=msgbox('Please select TTW and-or WTW', 'TTW and/or WTW');
    %set( ttwmsg, 'color', [ 0.9 0.9 .9 ] )
end

global VCOMP
global MJKM
global GHGKM
global NCC
global MJKMWTW
global GHGKMWTW
global SCC
global PWT

%plotting the chart
if  ((VCOMP(1)==2) && (VCOMP(2)==3))%same SMMT Category, Different powertrain
    if VCOMP(4)==2 && a(1)==1
        PLOTX=MJKM(SCC,:);
        bar(PLOTX);
        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
        xlabel('Powertrain');
    elseif VCOMP(4)==2 && a(1)==2
        PLOTX=MJKMWTW(SCC,:);
        bar(PLOTX);
        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
        xlabel('Powertrain');
    elseif VCOMP(4)==2 && a(1)==3
        NEWBARMJ=MJKMWTW-MJKM;
        STACKMJ=[MJKM(SCC,1) NEWBARMJ(SCC,1);MJKM(SCC,2) NEWBARMJ(SCC,2);MJKM(SCC,3) NEWBARMJ(SCC,3);MJKM(SCC,4) NEWBARMJ(SCC,4);MJKM(SCC,5) NEWBARMJ(SCC,5);MJKM(SCC,6) NEWBARMJ(SCC,6)];
        bar(STACKMJ,'stack');
        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
        xlabel('Powertrain');
        legend('TTW','WTT')
    elseif VCOMP(4)==3 && a(1)==1
        PLOTX=GHGKM(SCC,:);
        bar(PLOTX);
        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
        xlabel('Powertrain');
    elseif VCOMP(4)==3 && a(1)==2
        PLOTX=GHGKMWTW(SCC,:);
        bar(PLOTX);
        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
        xlabel('Powertrain');
    elseif VCOMP(4)==3 && a(1)==3
        NEWBARGHG=GHGKMWTW-GHGKM;
        STACKGHG=[GHGKM(SCC,1) NEWBARGHG(SCC,1);GHGKM(SCC,2) NEWBARGHG(SCC,2);GHGKM(SCC,3) NEWBARGHG(SCC,3);GHGKM(SCC,4) NEWBARGHG(SCC,4);GHGKM(SCC,5) NEWBARGHG(SCC,5);GHGKM(SCC,6) NEWBARGHG(SCC,6)];
        bar(STACKGHG,'stack');
        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
        xlabel('Powertrain');   
        legend('TTW','WTT')
    elseif VCOMP(4)==4 && (a(1)==1||a(1)==2||a(1)==3)
        PLOTX=NCC(SCC,:);
        bar(PLOTX);
        set(gca,'XTickLabel',{'petrol','diesel','dual hybrid','plugin hybrid','electric','fuel cell'},'FontSize',10);
        xlabel('Powertrain');
    else
    end 
        
elseif ((VCOMP(1)==3) && (VCOMP(2)==2)) %same powertrain, different smmt category
    if VCOMP(4)==2 && a(1)==1
        PLOTX=MJKM(:,PWT);
        bar(PLOTX);
        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
    elseif VCOMP(4)==2 && a(1)==2
        PLOTX=MJKMWTW(:,PWT);
        bar(PLOTX);
        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
    elseif VCOMP(4)==2 && a(1)==3
        NEWBARMJ=MJKMWTW-MJKM;
        STACKMJ=[MJKM(1,PWT) NEWBARMJ(1,PWT);MJKM(2,PWT) NEWBARMJ(2,PWT);MJKM(3,PWT) NEWBARMJ(3,PWT);MJKM(4,PWT) NEWBARMJ(4,PWT);MJKM(5,PWT) NEWBARMJ(5,PWT);MJKM(6,PWT) NEWBARMJ(6,PWT);MJKM(7,PWT) NEWBARMJ(7,PWT);MJKM(8,PWT) NEWBARMJ(8,PWT);MJKM(9,PWT) NEWBARMJ(9,PWT)];
        bar(STACKMJ,'stack');
        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
        legend('TTW','WTT')
    elseif VCOMP(4)==3 && a(1)==1
        PLOTX=GHGKM(:,PWT);
        bar(PLOTX);
        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
    elseif VCOMP(4)==3 && a(1)==2
        PLOTX=GHGKMWTW(:,PWT);
        bar(PLOTX);
        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
    elseif VCOMP(4)==3 && a(1)==3
        NEWBARGHG=GHGKMWTW-GHGKM;
        STACKGHG=[GHGKM(1,PWT) NEWBARGHG(1,PWT);GHGKM(2,PWT) NEWBARGHG(2,PWT);GHGKM(3,PWT) NEWBARGHG(3,PWT);GHGKM(4,PWT) NEWBARGHG(4,PWT);GHGKM(5,PWT) NEWBARGHG(5,PWT);GHGKM(6,PWT) NEWBARGHG(6,PWT);GHGKM(7,PWT) NEWBARGHG(7,PWT);GHGKM(8,PWT) NEWBARGHG(8,PWT);GHGKM(9,PWT) NEWBARGHG(9,PWT)];
        bar(STACKGHG,'stack');
        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
        legend('TTW','WTT')
    elseif VCOMP(4)==4 && (a(1)==1||a(1)==2||a(1)==3)
        PLOTX=NCC(:,PWT);
        bar(PLOTX);
        set(gca,'XTickLabel',{'Mini' 'Super Mini' 'Low. Medium' 'Up. Medium' 'Executive' 'Lux. Saloon' 'Sports' 'Dual Purpose' 'MPV'},'FontSize',9);
        xlabel('SMMT Category');
    else
    end     
end

y={'Energy Consumption [MJ/100km]' 'Greenhouse Gas [gCO2/km]' 'Capital Cost [£]'}; 

if VCOMP(4)==2
    ylabel(y{(VCOMP(4)-1)});
elseif VCOMP(4)==3
    ylabel(y{(VCOMP(4)-1)});
    elseif VCOMP(4)==4
    ylabel(y{(VCOMP(4)-1)});
end










%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%gui top buttons

function close_Callback(hObject, eventdata, handles)
%closes the old gui
close();



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
