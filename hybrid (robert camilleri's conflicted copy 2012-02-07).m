function varargout = hybrid(varargin)
% HYBRID MATLAB code for hybrid.fig
%      HYBRID, by itself, creates a novice HYBRID or raises the existing
%      singleton*.
%
%      H = HYBRID returns the handle to a novice HYBRID or the handle to
%      the existing singleton*.
%
%      HYBRID('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HYBRID.M with the given input arguments.
%
%      HYBRID('Property','Value',...) creates a novice HYBRID or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hybrid_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hybrid_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hybrid

% Last Modified by GUIDE v2.5 02-Dec-2011 15:41:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hybrid_OpeningFcn, ...
                   'gui_OutputFcn',  @hybrid_OutputFcn, ...
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


% --- Executes just before hybrid is made visible.
function hybrid_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hybrid (see VARARGIN)

% Choose default command line output for hybrid
handles.output = hObject;

global SPD
global VP
global PS
global EP
global MP
global T
global VR
global SET

%setting up SPD
SCC=SPD(1)-1;
smmtcategories = {'Mini' 'Super Mini' 'Lower Medium' 'Upper Medium' 'Executive' 'Luxury Saloon' 'Specialists Sports' 'Dual Purpose' 'MPV'};
bestselling = {'Hyundai i10' 'Ford Fiesta' 'Ford Focus' 'BMW 3 Series' 'Mercedes-Benz C Class' 'Mercedes-Benz S Class' 'Volkswagen Scirocco' 'Honda CR-V' 'Vauxhall Zafira'};

set(handles.smmttext,'string',smmtcategories{SCC});
set(handles.bestsellingtext,'string',bestselling{SCC});
guidata(hObject, handles);

set(handles.hybridtype,'SelectionChangeFcn',@hybridtype_SelectionChangeFcn)
set(handles.enginetype,'SelectionChangeFcn',@enginetype_SelectionChangeFcn)
set(handles.fueltype,'SelectionChangeFcn',@fueltype_SelectionChangeFcn)
set(handles.regentype,'SelectionChangeFcn',@regentype_SelectionChangeFcn)

%setting up VP
if (SET(1)>0)
set(handles.drag,'string',VP(1));
set(handles.frontalarea, 'string',VP(2));
set(handles.weight, 'string',VP(3));
set(handles.wheeldrive, 'string',VP(4));
set(handles.tyrediam, 'string',VP(5));
set(handles.tyreroll, 'string',VP(6));    
else 
set(handles.drag, 'string','0');
set(handles.frontalarea, 'string','0');
set(handles.weight, 'string','0');
set(handles.wheeldrive, 'string','0');
set(handles.tyrediam, 'string','0');
set(handles.tyreroll, 'string','0');
end

%Setting up PS
if(SET(1)>0)
ht=PS(1)
if ht==1
    set(handles.series,'value',1);
elseif ht==2
    set(handles.dual,'value',1);
elseif ht==3
    set(handles.plugin,'value',1);
end  
    if PS(2)==1
         set(handles.ice,'value',1);
    else
        set(handles.fuelcell,'value',1);
        set(handles.enginesize,'string','0');
        set(handles.enginesize,'visible','off');
        set(handles.etorque,'string','0');
        set(handles.etorque,'visible','off');
        set(handles.epower,'string','0');
        set(handles.epower,'visible','off');
        set(handles.text67,'visible','off');
        set(handles.text68,'visible','off');
        set(handles.text69,'visible','off');
        set(handles.text37,'visible','off');
        set(handles.text40,'visible','off');
        set(handles.text41,'visible','off');
        set(handles.enginedefault,'visible','off');
        set(handles.enginereset,'visible','off');
        set(handles.engineadvanced,'visible','off');
    end
        if PS(3)==1
            set(handles.petrol,'value',1);
        else
            set(handles.diesel,'value',1);
        end
            if PS(4)==1
                set(handles.turbocharged,'value',1);
            else
            end
end


%setting up EP
if(SET(1)>0)
    set(handles.enginesize,'string',EP(1));
    set(handles.etorque,'string', EP(2));
    set(handles.epower,'string', EP(3));
else 
end
ft=get(handles.petrol,'value');
e=get(handles.enginesize,'string');
es=str2num(e);

guidata(hObject, handles);

%setting up MP
if(SET(1)>0)
    set(handles.mpower,'string',MP(1));
    set(handles.mtorque,'string',MP(2));
    set(handles.meffy,'string',MP(3));
else
end

%setting up T

%setting up range (VR(1))
if(SET(1)>0)
    set(handles.range,'string',VR(1));
else
end

%setting up regenerative
if ((SET(1)>0)&&(VR(2)>0))
    set(handles.regen,'value',1);
    set(handles.eregen,'Visible','on');
    set(handles.mregen, 'Visible', 'on');
    set(handles.regeneffy,'Visible', 'on');
    set(handles.regendefault,'Visible', 'on');
    set(handles.regenadvanced,'Visible', 'on');
    set(handles.text58,'Visible', 'on');
    set(handles.text57,'Visible', 'on');
    set(handles.regeneffy,'string',VR(3));
else
end

% UIWAIT makes hybrid wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hybrid_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

axes(handles.axes1); % this is used to set focus on the axes currently in use

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%top control buttons
function loadhybrid_Callback(hObject, eventdata, handles)
%allow the user to choose which settings to load
[filename, pathname] = uigetfile('*.fig', 'Choose the GUI settings file to load');

%construct the path name of the file to be loaded
loadDataName = fullfile(pathname,filename);

%this is the gui that will be closed once we load the new settings
hybrid = gcf;  

%load the settings, which creates a new gui
hgload(loadDataName); 

%closes the old gui
close(hybrid);


function savehybrid_Callback(hObject, eventdata, handles)
%allow the user to specify where to save the settings file
[filename,pathname] = uiputfile('save_hybrid','Save your GUI settings');

if pathname == 0 %if the user pressed cancelled, then we exit this callback
    return
end

%construct the path name of the save location
saveDataName = fullfile(pathname,filename); 

%saves the gui data
hgsave(saveDataName);


function helphybrid_Callback(hObject, eventdata, handles)
mhh=msgbox('Hybrid Parameters allows you to set all the parameters that affect the performance of a vehicle.  Following your choice of SMMT category, you can now either set default values, taken from the 2009 best selling vehicle in that category or set your own','HYBRID Parameters help')
       set( mhh, 'color', [ 0.9 0.9 .9 ] )

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%vehicle parameters control    


function defaultvehicle_Callback(hObject, eventdata, handles)
global SPD;
SCC=SPD(1)-1;

%values for 9 vehicle segments taken from ovem3
Cd = [0.32 0.32 0.32 0.27 0.25 0.26 0.34 0.32 0.31];  
Af = [1.97 2.04 2.05 2.17 2.05 2.21 2.14 2.44 2.45];
glider_mass = [925 966 1327 1515 1575 1970 1318 1647 1613];
wheel_drive = [2 2 2 2 2 2 2 2 4]; % check with justin 
tyre_dia_in=[14 16 16 17 16 17 17 17 16]; %in
Crr= [0.0085 0.0099 0.0106 .0096 .0096 .0096 .0096 .0096 .0096];

checkboxStatus = get(handles.defaultvehicle,'Value');
if(checkboxStatus)
    %if box is checked, 
set(handles.drag,'string',Cd(SCC));
set(handles.frontalarea,'string',Af(SCC));
set(handles.weight,'string',glider_mass(SCC));
set(handles.wheeldrive,'string',wheel_drive(SCC));
set(handles.tyrediam,'string',tyre_dia_in(SCC));
set(handles.tyreroll,'string',Crr(SCC));

else
    %if box is unchecked, text is set to 0
set(handles.drag, 'string','0');
set(handles.frontalarea, 'string','0');
set(handles.weight, 'string','0');
set(handles.wheeldrive, 'string','0');
set(handles.tyrediam, 'string','0');
set(handles.tyreroll, 'string','0');

end
guidata(hObject, handles);

function resetvehicle_Callback(hObject, eventdata, handles)
set(handles.drag,'string','0');
set(handles.frontalarea, 'string','0');
set(handles.weight, 'string','0');
set(handles.wheeldrive, 'string','0');
set(handles.tyrediam, 'string','0');
set(handles.tyreroll, 'string','0');
guidata(hObject, handles);

function advancedvehicle_Callback(hObject, eventdata, handles)
madv=msgbox('Sorry, the advanced feature is still inactive','advanced');
    set( madv, 'color', [ 0.9 0.9 .9 ] )
    
%%%%%%%%%%%%%%%%%%%%%%%
%vehicle parameters

function drag_Callback(hObject, eventdata, handles)
dc = get(handles.drag,'String');%get the string for the editText component
dc = str2num(dc);%convert from string to number if possible, otherwise returns empty
if (isempty(dc) || dc < 0 || dc > 0.4)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.drag,'String','0');
    mdc=msgbox('please set the drag coefficient to a value between 0 and 0.4','drag coefficient');
    set( mdc, 'color', [ 0.9 0.9 .9 ] );
end
guidata(hObject, handles);

function drag_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function frontalarea_Callback(hObject, eventdata, handles)
ifa = get(handles.frontalarea,'String');%get the string for the editText component
ifa = str2num(ifa);%convert from string to number if possible, otherwise returns empty
if (isempty(ifa) || ifa < 0 || ifa > 3)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.frontalarea,'String','0');
    mifa=msgbox('please set the frontal area to a value between 0 and 3 ','frontal area');
    set( mifa, 'color', [ 0.9 0.9 .9 ] );
end

function frontalarea_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function weight_Callback(hObject, eventdata, handles)
w = get(handles.weight,'String');%get the string for the editText component
w = str2num(w);%convert from string to number if possible, otherwise returns empty
if (isempty(w) || w < 0)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.weight,'String','0');
    mw=msgbox('please set the kerb weight to a number greater than 0','kerb weight');
    set( mw, 'color', [ 0.9 0.9 .9 ] );
end

function weight_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function wheeldrive_Callback(hObject, eventdata, handles)
wd = get(handles.wheeldrive,'String');%get the string for the editText component
wd = str2num(wd);%convert from string to number if possible, otherwise returns empty
if (isempty(wd) || wd ~= 2 || wd ~=4 )  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.wheeldrive,'String','2');
    mwd=msgbox('please set the wheel drive to 2 or 4','wheel drive');
    set( mwd, 'color', [ 0.9 0.9 .9 ] );
end

function wheeldrive_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function tyrediam_Callback(hObject, eventdata, handles)
td = get(handles.tyrediam,'String');%get the string for the editText component
td = str2num(td);%convert from string to number if possible, otherwise returns empty
if (isempty(td) || td < 14 || td > 17)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.tyrediam,'String','0');
    mtd=msgbox('please set the tyre diameter between 14" and 17"','tyre diameter');
    set( mtd, 'color', [ 0.9 0.9 .9 ] );
end

function tyrediam_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function tyreroll_Callback(hObject, eventdata, handles)
tr = get(handles.tyreroll,'String');%get the string for the editText component
tr = str2num(tr);%convert from string to number if possible, otherwise returns empty
if (isempty(tr) || tr < 0 || tr > 0.02)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.tyreroll,'String','0');
    mtr=msgbox('please set the tyre rolling resistance between 0 and 0.02','tyre roll resistance');
    set( mtr, 'color', [ 0.9 0.9 .9 ] );
end

function tyreroll_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%power source
function hybridtype_SelectionChangeFcn(hObject, eventdata)
 handles=guidata(hObject);
%global PS 
%HT=[1 2 3]
switch get(eventdata.NewValue,'Tag');   % Get Tag of selected object
case 'series'
set(handles.ice,'visible','off');
set(handles.fuelcell,'visible','on');
    otherwise
        set(handles.ice,'visible','on');
set(handles.fuelcell,'visible','off');
end
guidata(hObject, handles);
handles=guidata(hObject);

function enginetype_SelectionChangeFcn(hObject, eventdata)
    handles=guidata(hObject);
switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
    case 'ice'
        set(handles.fueltype,'visible','on');
        set(handles.petrol,'value',0);
        set(handles.diesel,'value',0);
        set(handles.turbocharged,'visible','on');
        set(handles.turbocharged,'value',0);   
        set(handles.enginesize,'string','0');
        set(handles.enginesize,'visible','on');
        set(handles.etorque,'string','0');
        set(handles.etorque,'visible','on');
        set(handles.epower,'string','0');
        set(handles.epower,'visible','on');
        set(handles.text67,'visible','on');
        set(handles.text68,'visible','on');
        set(handles.text69,'visible','on');
        set(handles.text37,'visible','on');
        set(handles.text40,'visible','on');
        set(handles.text41,'visible','on');
        set(handles.enginedefault,'visible','on');
        set(handles.enginereset,'visible','on');
        set(handles.engineadvanced,'visible','on');
    otherwise
        set(handles.fueltype,'visible','off');  
        set(handles.petrol,'value',0);
        set(handles.diesel,'value',0);
        set(handles.turbocharged,'visible','off');
        set(handles.turbocharged,'value',0);   
        set(handles.enginesize,'string','0');
        set(handles.enginesize,'visible','off');
        set(handles.etorque,'string','0');
        set(handles.etorque,'visible','off');
        set(handles.epower,'string','0');
        set(handles.epower,'visible','off');
        set(handles.text67,'visible','off');
        set(handles.text68,'visible','off');
        set(handles.text69,'visible','off');
        set(handles.text37,'visible','off');
        set(handles.text40,'visible','off');
        set(handles.text41,'visible','off');
        set(handles.enginedefault,'visible','off');
        set(handles.enginereset,'visible','off');
        set(handles.engineadvanced,'visible','off');
end
guidata(hObject, handles);
handles=guidata(hObject);

function fueltype_SelectionChangeFcn(hObject, eventdata)
    handles=guidata(hObject);

switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
    case 'diesel'
      set(handles.turbocharged,'Visible','on');
      set(handles.turbocharged,'value',1);
    otherwise
        set(handles.turbocharged,'Visible','off');
        set(handles.turbocharged,'value',0);
end

ft=get(handles.petrol,'value');
e=get(handles.enginesize,'string');
es=str2num(e);

if (ft==1)
    if(es>0)
    et=(99.129*es - 9.5001);
    ep=(61.027*es - 12.571);
    elseif(es==0)
        et=0;
        ep=0;
    end
elseif(ft==0)
    if(es>0)
    et=(152.78*es^1.0215);
    ep=(81.128*es - 33.592);
    elseif(es==0)
        et=0;
        ep=0;
    end
end

set(handles.etorque,'string',et)
set(handles.epower,'string',ep)

guidata(hObject, handles);

function turbocharged_Callback(hObject, eventdata, handles)
ft=get(handles.petrol,'value');
tc=get(handles.turbocharged,'value');
if(ft==0||tc==0)
    mdntc=msgbox('Sorry, non turocharged diesel cannot be simulated','advanced');
    set( mdntc, 'color', [ 0.9 0.9 .9 ] );
    set(handles.turbocharged,'value',1);
else
end
handles=guidata(hObject);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%motor parameters

%motor controls

function mtradvanced_Callback(hObject, eventdata, handles)
madv=msgbox('Sorry, the advanced feature is still inactive','advanced');
    set( madv, 'color', [ 0.9 0.9 .9 ] )
    
function mtrreset_Callback(hObject, eventdata, handles)
set(handles.mtorque, 'string', '0')
set(handles.mpower, 'string', '0')
set(handles.meffy, 'string', '0')
guidata(hObject, handles);


function mtrdefault_Callback(hObject, eventdata, handles)
md=get(handles.mtrdefault,'value');
if(md==1)
    set(handles.mpower,'string','550'); 
    set(handles.mtorque,'string',(num2str((550*1000)/(471))));
    set(handles.meffy,'string','95');
else
    set(handles.mpower,'string','0'); 
    set(handles.mtorque,'string','0');
    set(handles.meffy,'string','0');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
%motor UI

function mpower_Callback(hObject, eventdata, handles)
mp1 = get(handles.mpower,'String');%get the string for the editText component
mp = str2num(mp1);
if (isempty(mp) || mp < 0 || mp> 1000)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.mpower,'String','0');
    mtr1=msgbox('please set the motor speed between 0 and 1000','motor speed');
    set( mtr1, 'color', [ 0.9 0.9 .9 ] );
else
    set(handles.mtorque,'string',((mp*1000)/(471)));
    set(handles.meffy,'string','95');
end

%mp1=get(handles.mpower,'string');
%mp=str2num(mp1);



function mpower_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%engine parameters

%engine control buttons

function enginedefault_Callback(hObject, eventdata, handles)
global SPD;
SCC=SPD(1)-1;
default_esize = [1.1 1.4 2.0 3.25 2.0 3.2 2.0 2.2 1.9];
engine_torque = [98 125 185 400 360 500 280 350 280];
engine_power = [49 70.5 104.4 145 99.9 149.9 154.7 110 92];

checkboxStatus = get(handles.enginedefault,'Value');
et=get(handles.ice,'value');
ft1=get(handles.petrol,'value');
ft2=get(handles.diesel,'value');
if (checkboxStatus)
    if((et==1)&&(ft1==1||ft2==1))
    set(handles.enginesize, 'string', default_esize(SCC));
    set(handles.etorque,'string',engine_torque(SCC));
    set(handles.epower,'string',engine_power(SCC));
    else
    md=msgbox('Please select an Engine Type and Fuel Type, prior to selecting the default Engine Parameter','Default Engine Parameter');
    set( md, 'color', [ 0.9 0.9 .9 ] )
    set(handles.enginedefault,'value',0);
    end
else   
%set(handles.enginesize, 'string', '0');
%set(handles.etorque,'string','0');
%set(handles.epower,'string','0');
%end

e=get(handles.enginesize,'string');
es=str2num(e);
ft=get(handles.petrol,'value');
if (ft==1)
    if(es>0)
    et=(99.129*es - 9.5001);
    ep=(61.027*es - 12.571);
    set(handles.etorque,'string',et);
    set(handles.epower,'string',ep);
    elseif(es==0)
        et=0;
        ep=0;
        set(handles.etorque,'string',et);
    set(handles.epower,'string',ep);
    end
elseif(ft==0)
    if(es>0)
    et=(152.78*es^1.0215);
    ep=(81.128*es - 33.592);
    set(handles.etorque,'string',et);
    set(handles.epower,'string',ep);
    elseif(es==0)
        et=0;
        ep=0;
        set(handles.etorque,'string',et);
    set(handles.epower,'string',ep);
    end    
end
end


function enginereset_Callback(hObject, eventdata, handles)
set(handles.enginesize, 'string', '0');
set(handles.etorque,'string','0');
set(handles.epower,'string','0');


function engineadvanced_Callback(hObject, eventdata, handles)
madv=msgbox('Sorry, the advanced feature is still inactive','advanced');
    set( madv, 'color', [ 0.9 0.9 .9 ] )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%engine parameters

function enginesize_Callback(hObject, eventdata, handles)
global SPD
t=SPD(1);
e=get(handles.enginesize,'string');
es=str2num(e);
if(t==2)
    if (isempty(es) || es > 1.1)  
    set(handles.enginesize,'String','0');
    set(handles.etorque,'string','0');
    set(handles.epower,'string','0');
    met=msgbox('the engine size for a Mini Smmt Category type vehicle cannot be greater than 1.1','engine size');
    set( met, 'color', [ 0.9 0.9 .9 ] );
    end
elseif(t==3)
    if (isempty(es) || es<1 || es > 1.4)  
    set(handles.enginesize,'String','0');
    set(handles.etorque,'string','0');
    set(handles.epower,'string','0');
    met=msgbox('the engine size for a Supermini Smmt Category type vehicle should be between 1 and 1.4','engine size');
    set( met, 'color', [ 0.9 0.9 .9 ] );
    end
elseif(t==4)
    if (isempty(es) || es<1.3 || es > 2.0)  
    set(handles.enginesize,'String','0');
    set(handles.etorque,'string','0');
    set(handles.epower,'string','0');
    met=msgbox('the engine size for a Lower Medium Smmt Category type vehicle should be between 1.3 and 2.0','engine size');
    set( met, 'color', [ 0.9 0.9 .9 ] );
    end
elseif(t==5)
    if (isempty(es) || es<1.6 || es > 2.8)  
    set(handles.enginesize,'String','0');
    set(handles.etorque,'string','0');
    set(handles.epower,'string','0');
    met=msgbox('the engine size for an Upper Medium Smmt Category type vehicle should be between 1.6 and 3.0','engine size');
    set( met, 'color', [ 0.9 0.9 .9 ] );
    end
elseif(t==6)
    if (isempty(es) || es<2 || es > 3.5)  
    set(handles.enginesize,'String','0');
    set(handles.etorque,'string','0');
    set(handles.epower,'string','0');
    met=msgbox('the engine size for an Executive Smmt Category type vehicle should be between 2 and 3.5','engine size');
    set( met, 'color', [ 0.9 0.9 .9 ] );
    end
elseif(t==7)
    if (isempty(es) || es < 3.5)  
    set(handles.enginesize,'String','0');
    set(handles.etorque,'string','0');
    set(handles.epower,'string','0');
    met=msgbox('the engine size for a Luxury Smmt Category type vehicle should be larger than 3.5','engine size');
    set( met, 'color', [ 0.9 0.9 .9 ] );
    end
else
end  

ft=get(handles.petrol,'value')
if (ft==1)
    if(es>0)
    et=(99.129*es - 9.5001);
    ep=(61.027*es - 12.571);
    elseif(es==0)
        et=0;
        ep=0;
    end
elseif(ft==0)
    if(es>0)
    et=(152.78*es^1.0215);
    ep=(81.128*es - 33.592);
    elseif(es==0)
        et=0;
        ep=0;
    end
end

set(handles.etorque,'string',et)
set(handles.epower,'string',ep)
    

function enginesize_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%range


function rangedefault_Callback(hObject, eventdata, handles)
%global ht
%ht1=str2num(ht)
checkboxStatus = get(handles.rangedefault,'Value');
s=get(handles.series,'value');
d=get(handles.dual,'value');
p=get(handles.plugin,'value');

%ht=get(handles.hybridtype,'value')
if ((checkboxStatus)&&(s==1))
    set(handles.range, 'string','3.8')
elseif ((checkboxStatus)&&(d==1))
    set(handles.range, 'string','3.8')
elseif ((checkboxStatus)&&(p==1))
    set(handles.range,'string','50')
else
    set(handles.range,'string','0')
    mrngdef=msgbox('Please select a Hybrid type','All Electric Range');
    set( mrngdef, 'color', [ 0.9 0.9 .9 ] );
end

function range_Callback(hObject, eventdata, handles)
rng1=get(handles.range,'string');
rng=str2num(rng1);
    if (isempty(rng) || rng < 0)  
    set(handles.enginesize,'String','0');
    met=msgbox('the Range should be greater than 0','All Eectric Range');
    set( met, 'color', [ 0.9 0.9 .9 ] );
    end

function range_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%regen control

function regentype_SelectionChangeFcn(hObject, eventdata)
    handles=guidata(hObject);
switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
    case 'eregen'
        dr=get(handles.regendefault,'value');
        mr=get(handles.mregen,'value');
        er=get(handles.eregen,'value');
        if(dr==1 && er==1 && mr==0)
        set(handles.regeneffy,'string','90')
        elseif(dr==1 && er==0 && mr==1)
        set(handles.regeneffy,'string','80')
        else
        end
    otherwise
        dr=get(handles.regendefault,'value');
        mr=get(handles.mregen,'value');
        er=get(handles.eregen,'value');
        if(dr==1 && er==1 && mr==0)
        set(handles.regeneffy,'string','90')
        elseif(dr==1 && er==0 && mr==1)
        set(handles.regeneffy,'string','80')
        else
        end
end


function regendefault_Callback(hObject, eventdata, handles)
dr=get(handles.regendefault,'value');
er=get(handles.eregen,'value');
mr=get(handles.mregen,'value');
if((er==0)&&(mr==0))
    madv=msgbox('Please select between electric or mechanical regen','Default Regen Error');
    set( madv, 'color', [ 0.9 0.9 .9 ] )
    
    set(handles.regendefault,'value',0);
    
elseif dr==1 && ((er==1)&&(mr==0))
        set(handles.regeneffy,'string','90') %assum mregen is 80% effy
    elseif dr==1 && ((er==0)&&(mr==1))
        set(handles.regeneffy,'string','80') %assum mregen is 80% effy
    else
    end
guidata(hObject, handles);

function regenadvanced_Callback(hObject, eventdata, handles)
madv=msgbox('Sorry, the advanced feature is still inactive','advanced');
    set( madv, 'color', [ 0.9 0.9 .9 ] )

function regeneffy_Callback(hObject, eventdata, handles)
re1=get(handles.regeneffy,'string');
re=str2num(re1)
if (isempty(re) || re<0 || re > 100)  
    met=msgbox('the regenerative efficiency value should be between 0 and 100','regenerative efficiency');
    set( met, 'color', [ 0.9 0.9 .9 ] );
else
end

function regeneffy_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function regen_Callback(hObject, eventdata, handles)
r=get(handles.regen,'Value')   % Get Value of selected object
if r==1
      set(handles.eregen,'Visible','on');
      set(handles.mregen, 'Visible', 'on');
      set(handles.regeneffy,'Visible', 'on');
      set(handles.regendefault,'Visible', 'on');
      set(handles.regenadvanced,'Visible', 'on');
      set(handles.text58,'Visible', 'on');
      set(handles.text57,'Visible', 'on');
else
      set(handles.eregen,'Visible','off');
      set(handles.mregen, 'Visible', 'off');
      set(handles.regeneffy,'Visible', 'off');
      set(handles.regendefault,'Visible', 'off');
      set(handles.regenadvanced,'Visible', 'off');
      set(handles.text58,'Visible', 'off');
      set(handles.text57,'Visible', 'off');
end





%hybrid main controls
 

function cancel_button_Callback(hObject, eventdata, handles)
global VP
global PS
global EP
global T
global VR
global MP
global SET
VP=[0 0 0 0 0 0]; % rests all the global variables on cancel
PS=[0 0 0 0];
EP=[0 0 0];
MP=[0 0 0];
T=[0 0 0 0 0 0];
VR=[0 0];
SET=[0];
  close();


function hybridset_Callback(hObject, eventdata, handles)
global SPD
global VP
global PS
global EP
global MP
global T
global VR
global SET

dc1=get(handles.drag, 'string');
dc=str2num(dc1);
fa1=get(handles.frontalarea, 'string');
fa=str2num(fa1);
kw1=get(handles.weight, 'string');
kw=str2num(kw1);
wd1=get(handles.wheeldrive, 'string');
wd=str2num(wd1);
td1=get(handles.tyrediam, 'string');
td=str2num(td1);
tr1=get(handles.tyreroll, 'string');
tr=str2num(tr1);
VP=[dc fa kw wd td tr];

%global HT%1=series hybrid, 2=dual hybrid, 3=plugin hybrid
%ht=PS(1);
ht1=get(handles.series,'value');
ht2=get(handles.dual,'value');
ht3=get(handles.plugin,'value');
if (ht1==1&&ht2==0&&ht3==0)
    ht=1
elseif (ht1==0&&ht2==1&&ht3==0)
    ht=2
elseif(ht1==0&&ht2==0&&ht3==1)
    ht=3
end
eb=get(handles.ice,'value'); %1=ice, 0=fuelcell, 2=electric motor, 3=ice
eb1=get(handles.fuelcell,'value'); %used below in if condition to check that user selected one of these!
ft=get(handles.petrol,'value'); %1=petrol, 0=diesel, 2=electric,
ft1=get(handles.diesel,'value'); %used below in if condition to check that user selected one of these!
tc=get(handles.turbocharged,'value');%1=turbocharged, 0=not turbocharged, 2=electric
PS=[ht eb ft tc];

es1=get(handles.enginesize, 'string');
es=str2num(es1);
et1=get(handles.etorque, 'string');
et=str2num(et1);
ep1=get(handles.epower, 'string');
ep=str2num(ep1);
EP=[es et ep];

mp1=get(handles.mpower,'string');
mp=str2num(mp1);
mt1=get(handles.mtorque,'string');
mt=str2num(mt1);
me1=get(handles.meffy,'string');
me=str2num(me1);
MP=[mp mt me];


%CVT is chosen and default is automatic
SCC=SPD(1)-1;
top_gear_ratio = [.72 .76 .77 .84 .83 .73 .92 .64 .61];
final_drive_ratio = [4.6 4.06 3.56 2.35 2.47 2.82 3.14 4.11 3.65];
tgr = top_gear_ratio (SCC);
fgr = final_drive_ratio(SCC);
T=[0 100 tgr fgr 95 100];

rng1=get(handles.range,'string');
rng=str2num(rng1);
reg=get(handles.regen,'value');
ref1=get(handles.regeneffy,'string');
ref=str2num(ref1);
VR=[rng reg ref];

if(VP(1)==0||VP(2)==0||VP(3)==0||VP(4)==0||VP(5)==0||VP(6)==0)
    mvperror=msgbox('Please note that the Vehicle Parameters could not be set to 0','Error Set Parameters');
    set( mvperror, 'color', [ 0.9 0.9 .9 ] )
elseif (eb==0 && eb1==0)
    meterror=msgbox('Please note that an engine type needs to be selected','Error Set Parameters');
    set( metperror, 'color', [ 0.9 0.9 .9 ] )
elseif (eb==1 && ft==0 && ft1==0)
    mfterror=msgbox('Please note that a fuel type needs to be selected','Error Set Parameters');
    set( mfterror, 'color', [ 0.9 0.9 .9 ] )
elseif (MP(1)==0||MP(2)==0||MP(3)==0)
    mperror=msgbox('Please note that the Motor Parameters could not be set to 0','Error Set Parameters');
    set( mvperror, 'color', [ 0.9 0.9 .9 ] )
elseif ((PS(2)==1)&&(EP(1)==0||EP(2)==0||EP(3)==0))
     mcperror=msgbox('Please note that the Engine Parameters could not be set to 0','Error Set Parameters');
    set( mcperror, 'color', [ 0.9 0.9 .9 ] )
elseif (VR(1)==0)
    mrerror=msgbox('Please note that the range of the vehicle could not be set to 0','Error Set Parameters');
    set( mrerror, 'color', [ 0.9 0.9 .9 ] )
elseif ((VR(2)>0) && (VR(3)==0))
    regerror=msgbox('Please note that the regeneration could not be set to 0','Error Set Parameters');
    set( mrerror, 'color', [ 0.9 0.9 .9 ] )
else
    SET=[1]
close()
end


function curious_Callback(hObject, eventdata, handles)
hybrid_curious_fact()
