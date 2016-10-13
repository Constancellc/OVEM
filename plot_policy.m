function varargout = plot_policy(varargin)
% PLOT_POLICY MATLAB code for plot_policy.fig
%      PLOT_POLICY, by itself, creates a novice PLOT_POLICY or raises the existing
%      singleton*.
%
%      H = PLOT_POLICY returns the handle to a novice PLOT_POLICY or the handle to
%      the existing singleton*.
%
%      PLOT_POLICY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_POLICY.M with the given input arguments.
%
%      PLOT_POLICY('Property','Value',...) creates a novice PLOT_POLICY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_policy_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_policy_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plot_policy

% Last Modified by GUIDE v2.5 12-Jan-2012 18:09:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_policy_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_policy_OutputFcn, ...
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


% --- Executes just before plot_policy is made visible.
function plot_policy_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_policy (see VARARGIN)
set(handles.plotgroup,'SelectionChangeFcn',@plotgroup_SelectionChangeFcn);
% Update handles structure
guidata(hObject, handles);






% --- Outputs from this function are returned to the command line.
function varargout = plot_policy_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1); % this is used to set focus on the axes currently in use
axes(handles.axes4);

global TIME
global OUT1
global OUT2

time=TIME;
out_no_policy=OUT1;
out=OUT2;

plot(time(:,1),out(:,1),'k-','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,2:end),out(:,2:end),'-','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
%title('Technology diffusion based on high investment into low carbon vehicles and evolving consumer choice due to increasing engine efficiency and lower carbon emissions')
xlabel('Years')
ylabel('Total number of vehicles per technology')
hold off






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%gui top buttons

function close_Callback(hObject, eventdata, handles)
%closes the old gui
close();



function saveplot_Callback(hObject, eventdata, handles)

%allow the user to specify where to save the settings file
[filename,pathname] = uiputfile('save_policy_results','Save Policy Results');

if pathname == 0 %if the user pressed cancelled, then we exit this callback
    return
end

%construct the path name of the save location
saveDataName = fullfile(pathname,filename); 

%saves the gui data
hgsave(saveDataName);



function plotgroup_SelectionChangeFcn(hObject, eventdata)
handles=guidata(hObject);
global TIME
global OUT1
global OUT2
global YEAR
global PROBTOT
global PROBTOTWP
time=TIME;
out_no_policy=OUT1;
out=OUT2;
year_num=YEAR;
prob_tot_no_policy=PROBTOT;
prob_tot_with_policy=PROBTOTWP;


v1=get(handles.wp,'value');
v2=get(handles.wop,'value');

switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
    case 'md'
        
if(v1==1 && v2==0)
plot(time(:,1),out(:,1),'k-','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,2:end),out(:,2:end),'-','MarkerSize',8,'LineWidth',2)
legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
%title('Technology diffusion based on high investment into low carbon vehicles and evolving consumer choice due to increasing engine efficiency and lower carbon emissions')
xlabel('Years')
ylabel('Total number of vehicles per technology')
hold off
    
 elseif(v1==0 && v2==1)
plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
%title('Technology diffusion based on high investment into low carbon vehicles and evolving consumer choice due to increasing engine efficiency and lower carbon emissions')
xlabel('Years')
ylabel('Total number of vehicles per technology')
hold off

elseif (v1==1 && v2==1)
    plot(time(:,1),out(:,1),'k-','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,2:end),out(:,2:end),'-','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
%title('Technology diffusion based on high investment into low carbon vehicles and evolving consumer choice due to increasing engine efficiency and lower carbon emissions')
xlabel('Years')
ylabel('Total number of vehicles per technology')
hold off
else
end
    otherwise
      if(v1==1 && v2==0)
        plot(year_num,prob_tot_with_policy,'-','MarkerSize',8,'LineWidth',2)
        legend('Petrol','Diesel','Hybrid','Plugin Hybrid','Battery Electric','Fuel cell')
xlabel('Time')
ylabel('Probability')

      elseif(v1==0 && v2==1)
plot(year_num,prob_tot_no_policy,'--','MarkerSize',8,'LineWidth',2)
legend('Petrol','Diesel','Hybrid','Plugin Hybrid','Battery Electric','Fuel cell')
xlabel('Time')
ylabel('Probability')

      elseif (v1==1 && v2==1)
          plot(year_num,prob_tot_with_policy,'-','MarkerSize',8,'LineWidth',2)
          hold on
          plot(year_num,prob_tot_no_policy,'--','MarkerSize',8,'LineWidth',2)
          legend('Petrol','Diesel','Hybrid','Plugin Hybrid','Battery Electric','Fuel cell')
          xlabel('Time')
          ylabel('Probability')
          hold off
      end

end
guidata(hObject, handles);



function md_Callback(hObject, eventdata, handles)
%vm1=get(handles.md,'value');
%vm2=get(handles.cp,'value');
%if(vm1==1 && vm2==0)
%    set(handles.wp,'visible','on');
%    set(handles.wop,'visible','on');
%elseif (vm1==0 && vm2==1)
%    set(handles.wp,'visible','off');
%    set(handles.wop,'visible','off');
%else
%end


function cp_Callback(hObject, eventdata, handles)
%vm1=get(handles.md,'value');
%vm2=get(handles.cp,'value');
%if(vm1==1 && vm2==0)
%    set(handles.wp,'visible','on');
%    set(handles.wop,'visible','on');
%elseif (vm1==0 && vm2==1)
%    set(handles.wp,'visible','off');
%    set(handles.wop,'visible','off');
%else
%end

function wp_Callback(hObject, eventdata, handles)
global TIME
global OUT1
global OUT2
global YEAR
global PROBTOT
global PROBTOTWP
time=TIME;
out_no_policy=OUT1;
out=OUT2;
year_num=YEAR;
prob_tot_no_policy=PROBTOT;
prob_tot_with_policy=PROBTOTWP;



v1=get(handles.wp,'value');
v2=get(handles.wop,'value');
v3=get(handles.md,'value');
v4=get(handles.cp,'value');

if (v3==1 && v4==0)
    
if(v1==1 && v2==0)
plot(time(:,1),out(:,1),'k-','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,2:end),out(:,2:end),'-','MarkerSize',8,'LineWidth',2)
legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
%title('Technology diffusion based on high investment into low carbon vehicles and evolving consumer choice due to increasing engine efficiency and lower carbon emissions')
xlabel('Years')
ylabel('Total number of vehicles per technology')
hold off
    
 elseif(v1==0 && v2==1)
plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
%title('Technology diffusion based on high investment into low carbon vehicles and evolving consumer choice due to increasing engine efficiency and lower carbon emissions')
xlabel('Years')
ylabel('Total number of vehicles per technology')
hold off

elseif (v1==1 && v2==1)
    plot(time(:,1),out(:,1),'k-','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,2:end),out(:,2:end),'-','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
%title('Technology diffusion based on high investment into low carbon vehicles and evolving consumer choice due to increasing engine efficiency and lower carbon emissions')
xlabel('Years')
ylabel('Total number of vehicles per technology')
hold off
else
end

elseif (v3==0 && v4==1)
      if(v1==1 && v2==0)
        plot(year_num,prob_tot_with_policy,'-','MarkerSize',8,'LineWidth',2)
        legend('Petrol','Diesel','Hybrid','Plugin Hybrid','Battery Electric','Fuel cell')
xlabel('Time')
ylabel('Probability')

      elseif(v1==0 && v2==1)
plot(year_num,prob_tot_no_policy,'--','MarkerSize',8,'LineWidth',2)
legend('Petrol','Diesel','Hybrid','Plugin Hybrid','Battery Electric','Fuel cell')
xlabel('Time')
ylabel('Probability')

      elseif (v1==1 && v2==1)
          plot(year_num,prob_tot_with_policy,'-','MarkerSize',8,'LineWidth',2)
          hold on
          plot(year_num,prob_tot_no_policy,'--','MarkerSize',8,'LineWidth',2)
          legend('Petrol','Diesel','Hybrid','Plugin Hybrid','Battery Electric','Fuel cell')
          xlabel('Time')
          ylabel('Probability')
          hold off
      end
end  


function wop_Callback(hObject, eventdata, handles)
global TIME
global OUT1
global OUT2
global YEAR
global PROBTOT
global PROBTOTWP
time=TIME;
out_no_policy=OUT1;
out=OUT2;
year_num=YEAR;
prob_tot_no_policy=PROBTOT;
prob_tot_with_policy=PROBTOTWP;

v1=get(handles.wp,'value');
v2=get(handles.wop,'value');
v3=get(handles.md,'value');
v4=get(handles.cp,'value');

if (v3==1 && v4==0)
    
if(v1==1 && v2==0)
plot(time(:,1),out(:,1),'k-','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,2:end),out(:,2:end),'-','MarkerSize',8,'LineWidth',2)
legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
%title('Technology diffusion based on high investment into low carbon vehicles and evolving consumer choice due to increasing engine efficiency and lower carbon emissions')
xlabel('Years')
ylabel('Total number of vehicles per technology')
hold off
    
 elseif(v1==0 && v2==1)
plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
%title('Technology diffusion based on high investment into low carbon vehicles and evolving consumer choice due to increasing engine efficiency and lower carbon emissions')
xlabel('Years')
ylabel('Total number of vehicles per technology')
hold off

elseif (v1==1 && v2==1)
    plot(time(:,1),out(:,1),'k-','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,2:end),out(:,2:end),'-','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
hold on
plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
%title('Technology diffusion based on high investment into low carbon vehicles and evolving consumer choice due to increasing engine efficiency and lower carbon emissions')
xlabel('Years')
ylabel('Total number of vehicles per technology')
hold off
else
end

elseif (v3==0 && v4==1)
      if(v1==1 && v2==0)
        plot(year_num,prob_tot_with_policy,'-','MarkerSize',8,'LineWidth',2)
        legend('Petrol','Diesel','Hybrid','Plugin Hybrid','Battery Electric','Fuel cell')
xlabel('Time')
ylabel('Probability')

      elseif(v1==0 && v2==1)
plot(year_num,prob_tot_no_policy,'--','MarkerSize',8,'LineWidth',2)
legend('Petrol','Diesel','Hybrid','Plugin Hybrid','Battery Electric','Fuel cell')
xlabel('Time')
ylabel('Probability')

      elseif (v1==1 && v2==1)
          plot(year_num,prob_tot_with_policy,'-','MarkerSize',8,'LineWidth',2)
          hold on
          plot(year_num,prob_tot_no_policy,'--','MarkerSize',8,'LineWidth',2)
          legend('Petrol','Diesel','Hybrid','Plugin Hybrid','Battery Electric','Fuel cell')
          xlabel('Time')
          ylabel('Probability')
          hold off
      end
end  
