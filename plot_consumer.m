function varargout = plot_consumer(varargin)
% PLOT_CONSUMER MATLAB code for plot_consumer.fig
%      PLOT_CONSUMER, by itself, creates a novice PLOT_CONSUMER or raises the existing
%      singleton*.
%
%      H = PLOT_CONSUMER returns the handle to a novice PLOT_CONSUMER or the handle to
%      the existing singleton*.
%
%      PLOT_CONSUMER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_CONSUMER.M with the given input arguments.
%
%      PLOT_CONSUMER('Property','Value',...) creates a novice PLOT_CONSUMER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_consumer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_consumer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plot_consumer

% Last Modified by GUIDE v2.5 27-Mar-2012 21:40:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_consumer_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_consumer_OutputFcn, ...
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


% --- Executes just before plot_consumer is made visible.
function plot_consumer_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_consumer (see VARARGIN)







% --- Outputs from this function are returned to the command line.
function varargout = plot_consumer_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1); % this is used to set focus on the axes currently in use
axes(handles.axes4);

global PROBTOT

PLOTX=PROBTOT(1,:);
bar(PLOTX)
set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',12);
xlabel('Powertrain');
ylabel('Probability');

% global PROBTOT_WP;
% 
% prob_tot_no_policy = PROBTOT;
% prob_tot_with_policy = PROBTOT_WP;
% plot(year_num,prob_tot_with_policy,'-','MarkerSize',8,'LineWidth',2)
%  hold on
%  plot(year_num,prob_tot_no_policy,'--','MarkerSize',8,'LineWidth',2)
%  legend('Petrol','Diesel','Hybrid','Plugin Hybrid','Battery Electric','Fuel cell')
%  xlabel('Time')
%  ylabel('Probability')
%  hold off





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%gui top buttons

function close_Callback(hObject, eventdata, handles)
%closes the old gui
close();



function saveplot_Callback(hObject, eventdata, handles)
c1=get(handles.cp,'value');
c2=get(handles.md,'value');

if(c1==1 && c2==0)
%allow the user to specify where to save the settings file
[filename,pathname] = uiputfile('save_consumer_probability_results','Save Consumer Probability Results');

if pathname == 0 %if the user pressed cancelled, then we exit this callback
    return
end

%construct the path name of the save location
saveDataName = fullfile(pathname,filename); 

%saves the gui data
hgsave(saveDataName);
elseif (c1==0 && c2==1)
    %allow the user to specify where to save the settings file
[filename,pathname] = uiputfile('save_market_diffusion_results','Save Market Diffusion Results');

if pathname == 0 %if the user pressed cancelled, then we exit this callback
    return
end

%construct the path name of the save location
saveDataName = fullfile(pathname,filename); 

%saves the gui data
hgsave(saveDataName);
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function chart_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function chart_Callback(hObject, eventdata, handles)

global TIME
global OUT_NP
global OUT1
global YEAR
global PROBTOT
global PROBTOTWP

% global PROBTOT_ML
% global OUT_ML
% out_ml = OUT_ML;
% prob_tot_ml = PROBTOT_ML;

time=TIME;
out_no_policy=OUT_NP;
out=OUT1;
year_num=YEAR;


c=get(handles.chart,'value');
if c==1
    set(handles.with_policy,'visible', 'off');
    set(handles.without_policy,'visible', 'off');
%    set(handles.base_case,'visible', 'off');    
    
    PLOTX=PROBTOT(1,:);
    bar(PLOTX)
    set(gca,'XTickLabel',{'PET','DIE','PET HEV','PHEV','EV','FC HEV'},'FontSize',12);
    xlabel('Powertrain');
    ylabel('Probability');

elseif c==2
    set(handles.with_policy,'visible', 'on');
    set(handles.without_policy,'visible', 'on');
 %   set(handles.base_case,'visible', 'off');
    
    p1=get(handles.with_policy,'value');
    p2=get(handles.without_policy,'value');
  %  p3=get(handles.base_case,'value');


    
 if    (p1==1 && p2==0)
 plot(time(:,1),out(:,1),'k-','MarkerSize',8,'LineWidth',2)
 hold on
 plot(time(:,2:end),out(:,2:end),'-','MarkerSize',8,'LineWidth',2)
 %hold on
 %plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
 %hold on
 %plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
 legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
 xlabel('Years')
 ylabel('Total number of vehicles per technology')
 hold off 
 elseif (p1==0 && p2==1)
 %plot(time(:,1),out(:,1),'k-','MarkerSize',8,'LineWidth',2)
 %hold on
 %plot(time(:,2:end),out(:,2:end),'-','MarkerSize',8,'LineWidth',2)
 %hold on
 plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
 hold on
 plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
 legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
 xlabel('Years')
 ylabel('Total number of vehicles per technology')
 hold off  
 elseif (p1==1 && p2==1)
 plot(time(:,1),out(:,1),'k-','MarkerSize',8,'LineWidth',2)
 hold on
 plot(time(:,2:end),out(:,2:end),'-','MarkerSize',8,'LineWidth',2)
 hold on
 plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
 hold on
 plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
 legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
 xlabel('Years')
 ylabel('Total number of vehicles per technology')
 hold off  
 end
 
diff = out - out_no_policy;
figure(2)
plot(time(:,2:end),diff(:,2:end),'-','MarkerSize',8,'LineWidth',2)
hold on
legend('Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
xlabel('Years')
ylabel('Absolute change in vehicle fleet with policy intervention')
hold off

end
        
        



function with_policy_Callback(hObject, eventdata, handles)

global TIME
global OUT_NP
global OUT1
global YEAR
global PROBTOT
global PROBTOTWP
global PROBTOT_ML
global OUT_ML
out_ml = OUT_ML;
prob_tot_ml = PROBTOT_ML;
time=TIME;
out_no_policy=OUT_NP;
out=OUT1;
year_num=YEAR;

p1=get(handles.with_policy,'value');
p2=get(handles.without_policy,'value');
%p3=get(handles.base_case,'value');
    
 if (p1==0 && p2==0)
    mp=msgbox('Please note that at least one of With Policy or Without Policy has to be selected.','With/Without Policy');
    set( mp, 'color', [ 0.9 0.9 .9 ]) 
    
    set(handles.with_policy,'value',0);
    set(handles.without_policy,'value',1);
 %   set(handles.base_case,'value',1);
        
    uiwait;
    
 plot(time(:,1),out_ml(:,1),'k-','MarkerSize',8)
 hold on
 plot(time(:,2:end),out_ml(:,2:end),'-','MarkerSize',8)
 %hold on
 %plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
 %hold on
 %plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
 legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
 xlabel('Years')
 ylabel('Total number of vehicles per technology')
 hold off 
    
 elseif    (p1==1 && p2==0)
 plot(time(:,1),out(:,1),'k-','MarkerSize',8,'LineWidth',2)
 hold on
 plot(time(:,2:end),out(:,2:end),'-','MarkerSize',8,'LineWidth',2)
  hold on
 plot(time(:,1),out_ml(:,1),'k-','MarkerSize',8)
 hold on
 plot(time(:,2:end),out_ml(:,2:end),'-','MarkerSize',8)
 %hold on
 %plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
 %hold on
 %plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
 legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
 xlabel('Years')
 ylabel('Total number of vehicles per technology')
 hold off 
 elseif (p1==0 && p2==1)
 %plot(time(:,1),out(:,1),'k-','MarkerSize',8,'LineWidth',2)
 %hold on
 %plot(time(:,2:end),out(:,2:end),'-','MarkerSize',8,'LineWidth',2)
 %hold on
 plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
 hold on
 plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
  hold on
 plot(time(:,1),out_ml(:,1),'k-','MarkerSize',8)
 hold on
 plot(time(:,2:end),out_ml(:,2:end),'-','MarkerSize',8)

 legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
 xlabel('Years')
 ylabel('Total number of vehicles per technology')
 hold off  
 elseif (p1==1 && p2==1)
 plot(time(:,1),out(:,1),'k-','MarkerSize',8,'LineWidth',2)
 hold on
 plot(time(:,2:end),out(:,2:end),'-','MarkerSize',8,'LineWidth',2)
 hold on
 plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
 hold on
 plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
  hold on
 plot(time(:,1),out_ml(:,1),'k-','MarkerSize',8)
 hold on
 plot(time(:,2:end),out_ml(:,2:end),'-','MarkerSize',8)
 legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
 xlabel('Years')
 ylabel('Total number of vehicles per technology')
 hold off  
 end

function without_policy_Callback(hObject, eventdata, handles)

global TIME
global OUT_NP
global OUT1
global YEAR
global PROBTOT
global PROBTOTWP
global PROBTOT_ML
global OUT_ML
out_ml = OUT_ML;
prob_tot_ml = PROBTOT_ML;
time=TIME;
out_no_policy=OUT_NP;
%out_no_policy=PROBTOT;
out=OUT1;
%out=PROBTOTWP;
year_num=YEAR;

p1=get(handles.with_policy,'value');
p2=get(handles.without_policy,'value');
%p3=get(handles.base_case,'value');
    
 if (p1==0 && p2==0)
    mp=msgbox('Please note that at least one of With Policy or Without Policy has to be selected.','With/Without Policy');
    set( mp, 'color', [ 0.9 0.9 .9 ]) 
    
    set(handles.with_policy,'value',0);
    set(handles.without_policy,'value',1);
 %   set(handles.base_case,'value',1);
 
    uiwait;
    
 plot(time(:,1),out_ml(:,1),'k-','MarkerSize',8)
 hold on
 plot(time(:,2:end),out_ml(:,2:end),'-','MarkerSize',8)
 %hold on
 %plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
 %hold on
 %plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
 legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
 xlabel('Years')
 ylabel('Total number of vehicles per technology')
 hold off
 
 elseif    (p1==1 && p2==0)
 plot(time(:,1),out(:,1),'k-','MarkerSize',8,'LineWidth',2)
 hold on
 plot(time(:,2:end),out(:,2:end),'-','MarkerSize',8,'LineWidth',2)
  hold on
 plot(time(:,1),out_ml(:,1),'k-','MarkerSize',8)
 hold on
 plot(time(:,2:end),out_ml(:,2:end),'-','MarkerSize',8)
 %hold on
 %plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
 %hold on
 %plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
 legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
 xlabel('Years')
 ylabel('Total number of vehicles per technology')
 hold off 
 elseif (p1==0 && p2==1)
 %plot(time(:,1),out(:,1),'k-','MarkerSize',8,'LineWidth',2)
 %hold on
 %plot(time(:,2:end),out(:,2:end),'-','MarkerSize',8,'LineWidth',2)
 %hold on
  hold on
 plot(time(:,1),out_ml(:,1),'k-','MarkerSize',8)
 hold on
 plot(time(:,2:end),out_ml(:,2:end),'-','MarkerSize',8)
 hold on
 plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
 hold on
 plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
 legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
 xlabel('Years')
 ylabel('Total number of vehicles per technology')
 hold off  
 elseif (p1==1 && p2==1)
 plot(time(:,1),out(:,1),'k-','MarkerSize',8,'LineWidth',2)
 hold on
 plot(time(:,2:end),out(:,2:end),'-','MarkerSize',8,'LineWidth',2)
 hold on
 plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
 hold on
 plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
  hold on
 plot(time(:,1),out_ml(:,1),'k-','MarkerSize',8)
 hold on
 plot(time(:,2:end),out_ml(:,2:end),'-','MarkerSize',8)
 legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
 xlabel('Years')
 ylabel('Total number of vehicles per technology')
 hold off  
 end
