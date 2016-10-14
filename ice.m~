function varargout = ice(varargin)
% ICE MATLAB code for ice.fig
%      ICE, by itself, creates a novice ICE or raises the existing
%      singleton*.
%
%      H = ICE returns the handle to a novice ICE or the handle to
%      the existing singleton*.
%
%      ICE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ICE.M with the given input arguments.
%
%      ICE('Property','Value',...) creates a novice ICE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ice_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ice_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ice

% Last Modified by GUIDE v2.5 30-Nov-2011 10:03:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ice_OpeningFcn, ...
                   'gui_OutputFcn',  @ice_OutputFcn, ...
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


% --- Executes just before ice is made visible.
function ice_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ice (see VARARGIN)

global SPD;
smmtcategories = {'Mini' 'Super Mini' 'Lower Medium' 'Upper Medium' 'Executive' 'Luxury Saloon' 'Specialists Sports' 'Dual Purpose' 'MPV'};
bestselling = {'Hyundai i10' 'Ford Fiesta' 'Ford Focus' 'BMW 3 Series' 'Mercedes-Benz C Class' 'Mercedes-Benz S Class' 'Volkswagen Scirocco' 'Honda CR-V' 'Vauxhall Zafira'};

% Adds strings containing the chosen SMMT catergory and the best selling
% model from that category to the structure
set(handles.smmttext,'string',smmtcategories{SPD(1)-1});
set(handles.bestsellingtext,'string',bestselling{SPD(1)-1});

guidata(hObject, handles);

set(handles.fuel_type,'SelectionChangeFcn',@fuel_type_SelectionChangeFcn)
set(handles.gearboxtype,'SelectionChangeFcn',@gearboxtype_SelectionChangeFcn)

global VP
set(handles.drag,'string',VP(1));
set(handles.frontalarea, 'string',VP(2));
set(handles.weight, 'string',VP(3));
set(handles.wheeldrive, 'string',VP(4));
set(handles.tyrediam, 'string',VP(5));
set(handles.tyreroll, 'string',VP(6));    

global PS

global EP
set(handles.enginesize, 'string', EP(1));
set(handles.etorque,'string', EP(2));
set(handles.epower,'string', EP(3));

global T
set(handles.gbspd, 'string', T(2));
set(handles.tgratio, 'string', T(3));
set(handles.fgratio, 'string', T(4));
set(handles.gbeffy, 'string', T(5));
set(handles.axleffy, 'string', T(6));

global VR
set(handles.range,'string',VR(1));

global MP

% This is for the lower and higher accepted parameter limits for the
% 'generic' function defined later
global lower
global higher

%{
INDEX
-----
1: drag coefficient
2: frontal area
3: kerb weight
4: tyre diameter
5: tyre roll resistance
6-11: engine size (SMMT specific) 
12: gearbox speed
13: top gear ratio
14: final gear ratio
15: gearbox efficiency
16: axle efficiency
17: range
%}
lower = [0,0,0,14,0,0,1,1.3,1.6,2,3.5,4,0,2,0,0,0];
higher = [0.4,3,Inf,17,0.02,1.1,1.4,2,3,3.5,Inf,7,1,5,100,100,Inf];

guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = ice_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1); % this is used to set focus on the axes currently in use


global SPD; % set car picture depending on which smmt category chosen in vmod1
picture = {'1.tiff' '2.tiff' '3.tiff' '4.tiff' '5.tiff' '6.tiff' '7.tiff' '8.tiff' '9.tiff'};
axes(handles.axes4);
imshow(picture{SPD(1)-1});


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%gui top buttons

function loadice_Callback(hObject, eventdata, handles)
%allow the user to choose which settings to load
[filename, pathname] = uigetfile('*.fig', 'Choose the GUI settings file to load');

%construct the path name of the file to be loaded
loadDataName = fullfile(pathname,filename);

%this is the gui that will be closed once we load the new settings
ice = gcf;  

%load the settings, which creates a new gui
hgload(loadDataName); 

%closes the old gui
close(ice);



function saveice_Callback(hObject, eventdata, handles)

%allow the user to specify where to save the settings file
[filename,pathname] = uiputfile('save_ice','Save your GUI settings');

if pathname == 0 %if the user pressed cancelled, then we exit this callback
    return
end

%construct the path name of the save location
saveDataName = fullfile(pathname,filename); 

%saves the gui data
hgsave(saveDataName);

function helpice_Callback(hObject, eventdata, handles)
txt = ['ICE Parameters allows you to set all the parameters that ' ...
    'affect the performance of a vehicle.  Following your choice of ' ...
    'SMMT category, you can now either set default values, taken from ' ...
    'the 2009 best selling vehicle in that category or set your own'];
mih=msgbox(txt,'ICE Parameters help');
set( mih, 'color', [ 0.9 0.9 .9 ] )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%vehicle control buttons

function vehicledefault_Callback(hObject, eventdata, handles)
global SPD;
SCC=SPD(1)-1;

%values for 9 vehicle segments taken from ovem3
Cd = [0.32 0.32 0.32 0.27 0.25 0.26 0.34 0.32 0.31];  
Af = [1.97 2.04 2.05 2.17 2.05 2.21 2.14 2.44 2.45];
glider_mass = [925 966 1327 1515 1575 1970 1318 1647 1613];
wheel_drive = [2 2 2 2 2 2 2 2 4]; % check with justin 
tyre_dia_in=[14 16 16 17 16 17 17 17 16]; %in
Crr= [0.0085 0.0099 0.0106 .0096 .0096 .0096 .0096 .0096 .0096];

checkboxStatus = get(handles.vehicledefault,'Value');
if(checkboxStatus)
    set(handles.drag,'string',Cd(SCC));
    set(handles.frontalarea,'string',Af(SCC));
    set(handles.weight,'string',glider_mass(SCC));
    set(handles.wheeldrive,'string',wheel_drive(SCC));
    set(handles.tyrediam,'string',tyre_dia_in(SCC));
    set(handles.tyreroll,'string',Crr(SCC));
end
guidata(hObject, handles);

% not really sure what this one does
function vehiclereset_Callback(hObject, eventdata, handles)
set(handles.drag,'string','0');
set(handles.frontalarea, 'string','0');
set(handles.weight, 'string','0');
set(handles.wheeldrive, 'string','0');
set(handles.tyrediam, 'string','0');
set(handles.tyreroll, 'string','0');
guidata(hObject, handles);

function vehicleadvanced_Callback(hObject, eventdata, handles)
madv=msgbox('Sorry, the advanced feature is still inactive','advanced');
    set( madv, 'color', [ 0.9 0.9 .9 ] )


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%vehicle values

% This is a generic function which checks that an input parameter is in a
% valid range and then sets it.
function n = generic(result,index,name)
% eg. generic(handles.drag,1,'Drag Coefficient')
global higher
global lower

n = get(result,'String');             % get the string 
n = str2double(n);                       % convert from string to number 

% If no value input, or a value not between 0 and 0.4, complain
if (isempty(n) || n < lower(index) || n > higher(index))  
    set(result,'String','0');
    txt = sprintf('Please choose a value between %d and %d'...
        ,lower(index),higher(index));
    m=msgbox(txt,name);
    set( m, 'color', [ 0.9 0.9 .9 ] );
end

% Drag Coefficient 
function drag_Callback(hObject, eventdata, handles)
generic(handles.drag,1,'drag coefficient');
guidata(hObject, handles); % This appears to be missing from the others...

function drag_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'));
    set(hObject,'BackgroundColor','white');
end

% Frontal Area
function frontalarea_Callback(hObject, eventdata, handles)
generic(handles.frontalarea,2,'frontal area');

function frontalarea_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Weight
function weight_Callback(hObject, eventdata, handles)
generic(handles.weight,3,'kerb weight');

function weight_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Number of wheel drive (2 or 4)
function wheeldrive_Callback(hObject, eventdata, handles)
wd = get(handles.wheeldrive,'String');%get the string for the editText component
wd = str2double(wd);%convert from string to number if possible, otherwise returns empty
if (isempty(wd) || ((wd~=2) && (wd~=4))) 
    set(handles.wheeldrive,'String','2');
    mwd=msgbox('Please set the wheel drive to 2 or 4','Wheel Drive');
    set(mwd,'color', [ 0.9 0.9 .9 ] );
else
end

function wheeldrive_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Tyre Diameter
function tyrediam_Callback(hObject, eventdata, handles)
generic(handles.tyrediam,4,'tyre diameter')

function tyrediam_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function tyreroll_Callback(hObject, eventdata, handles)
generic(handles.tyreroll,5,'tyre roll resistance');

function tyreroll_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%engine parameters

%engine control buttons

% Given an engine size and fuel type this sets the other two parameters
function engine_parameters(handles,es,ft)
% This function takes the inputs handles and the optional inputs of engine
% size and fuel type. Note that if you don't have the enginer size you
% can't input the fuel type

% If not given, get the fuel type
if nargin < 3
    ft = get(handles.petrol,'value');
end

% If not given, get the engine size
if nargin < 2
    es = get(handles.enginesize,'string');
    es = str2double(es);
end

% Other parameters are set dependant on fuel type
if ft==1                            % petrol
    if(es>0)
        % Not really sure where these eqs come from
        set(handles.etorque,'string',99.129*es - 9.5001);
        set(handles.epower,'string',61.027*es - 12.571);
    end
    
elseif(ft==0)                       % diesel
    if(es>0)
        % Again, where are these from?
        set(handles.etorque,'string',152.78*es^1.0215);
        set(handles.epower,'string',81.128*es - 33.592);
    end
end


% This is the default option
function enginedefault_Callback(hObject, eventdata, handles)
global SPD;

default_esize = [1.1 1.4 2.0 3.0 2.0 3.2 2.0 2.2 1.9];

checkboxStatus = get(handles.enginedefault,'Value');

if (checkboxStatus)
    % Set the following based on SMMT specific standards
    es = default_esize(SPD(1)-1);
    set(handles.enginesize, 'string', es);
    engine_parameters(handles,es)
end


function reseticeengine_Callback(hObject, eventdata, handles)
set(handles.enginesize, 'string', '0');
set(handles.etorque,'string','0');
set(handles.epower,'string','0');



function advancediceengine_Callback(hObject, eventdata, handles)
madv=msgbox('Sorry, the advanced feature is still inactive','advanced');
    set( madv, 'color', [ 0.9 0.9 .9 ] )


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%combustion user values

function fuel_type_SelectionChangeFcn(hObject, eventdata)
handles=guidata(hObject);

% If diesel chosen display option for turbocharged
switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
    case 'diesel'
        set(handles.turbocharged,'Visible','on');
        set(handles.turbocharged,'value',1);
    otherwise
        set(handles.turbocharged,'Visible','off');
        set(handles.turbocharged,'value',0);
end

engine_parameters(handles)
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

function enginesize_Callback(hObject, eventdata, handles)
global SPD
% This checks the size of the engine size is within the correct limits
% relative to the SMMT catergory, the +4 is just the offset of the
% positions of the limits in the 'lower' and 'upper' vectors
es = generic(handles.enginesize,SPD(1)+4,'enginesize');
engine_parameters(handles,es)

function enginesize_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%transmission control buttons

function gbdefault_Callback(hObject, eventdata, handles)
global SPD;

top_gear_number = [5 5 5 6 6 7 6 6 6];
top_gear_ratio = [.72 .76 .77 .84 .83 .73 .92 .64 .61];
final_drive_ratio = [4.6 4.06 3.56 2.35 2.47 2.82 3.14 4.11 3.65];

ttype=get(handles.multigear,'value');
checkboxStatus = get(handles.gbdefault,'Value');

if(ttype==1)
    if(checkboxStatus) %if multigear box is chosen and default is checked,   
        set(handles.gbspd, 'string', top_gear_number(SPD(1)-1));
        set(handles.tgratio, 'string', top_gear_ratio (SPD(1)-1));
        set(handles.fgratio, 'string', final_drive_ratio(SPD(1)-1));
        set(handles.gbeffy, 'string', '95');
        set(handles.axleffy, 'string', '100');
    end
elseif(ttype==0) %if CVT is chosen and default is automatic
        set(handles.gbspd,'string','100');
        set(handles.tgratio, 'string', top_gear_ratio (SPD(1)-1));
        set(handles.fgratio, 'string', final_drive_ratio(SPD(1)-1));
        set(handles.gbeffy, 'string', '95');
        set(handles.axleffy, 'string', '100');
end
          

function gbreset_Callback(hObject, eventdata, handles)
set(handles.gbspd, 'string', '0');
set(handles.tgratio, 'string', '0');
set(handles.fgratio, 'string', '0');
set(handles.gbeffy, 'string', '0');
set(handles.axleffy, 'string', '0');

function gbadvanced_Callback(hObject, eventdata, handles)
madv=msgbox('Sorry, the advanced feature is still inactive','advanced');
    set( madv, 'color', [ 0.9 0.9 .9 ] )

%transmission user input
function gearboxtype_SelectionChangeFcn(hObject, eventdata)
handles=guidata(hObject);

global SPD;

top_gear_number = [5 5 5 6 6 7 6 6 6];
top_gear_ratio = [.72 .76 .77 .84 .83 .73 .92 .64 .61];
final_drive_ratio = [4.6 4.06 3.56 2.35 2.47 2.82 3.14 4.11 3.65];

switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
    case 'multigear'
        set(handles.text46,'Visible','on');
        set(handles.text47,'Visible','on');
        set(handles.text50,'Visible','on');
        set(handles.text48,'Visible','on');
        set(handles.text49,'Visible','on');
        set(handles.text33,'Visible','on');
        set(handles.text27,'Visible','on');
        set(handles.gbspd,'Visible','on');
        set(handles.gbspd,'string','0');
        set(handles.tgratio,'Visible','on');
        set(handles.tgratio,'string','0');
        set(handles.fgratio,'Visible','on');
        set(handles.fgratio,'string','0');
        set(handles.gbeffy,'Visible','on');
        set(handles.gbeffy,'string','0');
        set(handles.axleffy,'Visible','on');
        set(handles.axleffy,'string','0');
        set(handles.gbdefault,'Visible','on');
        set(handles.gbreset,'Visible','on');
        set(handles.gbadvanced,'Visible','on');
    otherwise
        set(handles.text46,'Visible','off');
        set(handles.text47,'Visible','off');
        set(handles.text50,'Visible','off')
        set(handles.text48,'Visible','off');
        set(handles.text49,'Visible','off');
        set(handles.text33,'Visible','off');
        set(handles.text27,'Visible','off');
        set(handles.gbspd,'Visible','off');
        set(handles.gbspd,'string','100');
        set(handles.tgratio,'Visible','off');
        set(handles.tgratio, 'string', top_gear_ratio(SPD(1)-1));
        set(handles.fgratio,'Visible','off');
        set(handles.fgratio, 'string', final_drive_ratio(SPD(1)-1));
        set(handles.gbeffy,'Visible','off');
        set(handles.gbeffy,'string','95');
        set(handles.axleffy,'Visible','off');
        set(handles.axleffy,'string','100');
        set(handles.gbdefault,'Visible','off');
        set(handles.gbreset,'Visible','off');
        set(handles.gbadvanced,'Visible','off');
end

guidata(hObject, handles);





function gbspd_Callback(hObject, eventdata, handles)
global SPD
top_gear_ratio = [.72 .76 .77 .84 .83 .73 .92 .64 .61];
final_drive_ratio = [4.6 4.06 3.56 2.35 2.47 2.82 3.14 4.11 3.65];

gbs = generic(handles.gbspd,12,'gearbox speed');
gbt=get(handles.multigear,'value');

if (gbt==1 && gbs>0)
        set (handles.tgratio,'string',top_gear_ratio(SPD(1)-1));
        set (handles.fgratio,'string',final_drive_ratio(SPD(1)-1));
else
end

function gbspd_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function tgratio_Callback(hObject, eventdata, handles)
generic(handles.tgratio,13,'top gear ratio')


function tgratio_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fgratio_Callback(hObject, eventdata, handles)
generic(handles.fgratio,14,'final gear ratio')


function fgratio_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gbeffy_Callback(hObject, eventdata, handles)
generic(handles.gbeffy,15,'gearbox efficiency')


function gbeffy_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function axleffy_Callback(hObject, eventdata, handles)
generic(handles.axleffy,16,'axle efficiency')


function axleffy_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%range

function rangedefault_Callback(hObject, eventdata, handles)
rd=get(handles.rangedefault,'value');

if(rd==1)
    set(handles.range,'string','950');
else
    set(handles.range,'string','0');
end

function range_Callback(hObject, eventdata, handles)
generic(handles.range,17,'range')


function range_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%regen braking

%function regen_Callback(hObject, eventdata, handles)
%r=get(handles.regen,'value')
%if(r==0)
%    set(handles.text69,'visible','off')
%    set(handles.regeneffy,'visible','off')
%    set(handles.regeneffy,'value',0)
%    set(handles.text70,'visible','off')
%    set(handles.regendefault,'visible','off')
%else
%    set(handles.text69,'visible','on')
%    set(handles.regeneffy,'visible','on')
%    set(handles.regeneffy,'value',0)
%    set(handles.text70,'visible','on')
%    set(handles.regendefault,'visible','on')
%end


%function regeneffy_Callback(hObject, eventdata, handles)
%reg = get(handles.regeneffy,'String');%get the string for the editText component
%reg = str2double(reg);%convert from string to number if possible, otherwise returns empty
%if (isempty(reg) || reg < 0 || reg > 100)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
%    set(handles.regeneffy,'String','0');
%    mreg=msgbox('please set the regeneration efficiency value between 0 and 100','Regenerative Efficiency');
%    set( mreg, 'color', [ 0.9 0.9 .9 ] )
%end

%function regeneffy_CreateFcn(hObject, eventdata, handles)
%
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%    set(hObject,'BackgroundColor','white');
%end


%function regendefault_Callback(hObject, eventdata, handles)  %assume that regen in ICE is mechanical
%checkboxStatus = get(handles.regendefault,'Value');
%r=get(handles.regen,'value');
%
%if ((checkboxStatus)&&(r==1))
%set(handles.regeneffy, 'string', '85')
%else set(handles.regeneffy,'string','0')
%end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ice gui main buttons
 

function setice_Callback(hObject, eventdata, handles);
% Updates all of the global parameters

global VP
global PS
global EP
global MP
global T
global VR
global SET

dc=get(handles.drag, 'string');         % drag coefficient
dc=str2double(dc);
fa=get(handles.frontalarea, 'string');  % frontal area
fa=str2double(fa);
kw=get(handles.weight, 'string');       % kerb weight
kw=str2double(kw);                      
wd=get(handles.wheeldrive, 'string');   % no. driven wheels
wd=str2double(wd);
td=get(handles.tyrediam, 'string');     % tyre diameter
td=str2double(td);
tr=get(handles.tyreroll, 'string');     % tyre rolling resistance
tr=str2double(tr);

VP=[dc fa kw wd td tr];

%r=get(handles.regen,'value');
%regeffy=get(handles.regeneffy,'string');
%reffy=str2double(regeffy);

ft=get(handles.petrol, 'value');  % 1=petrol, 0=diesel
tc=get(handles.turbocharged,'value'); % 1=turbocharged, 0=not turbocharged

PS=[0 3 ft tc];

es=get(handles.enginesize, 'string');   % engine size
es=str2double(es);
et=get(handles.etorque, 'string');      % engine torque
et=str2double(et);
ep=get(handles.epower, 'string');       % engine power
ep=str2double(ep);

EP=[es et ep];

MP=[0 0 0];

gbt=get(handles.multigear, 'value'); % 1=multigear, 0=CVT

gbs=get(handles.gbspd, 'string');       % gearbox speed
gbs=str2double(gbs);
tgr=get(handles.tgratio, 'string');     % top gear ratio
tgr=str2double(tgr);
fgr=get(handles.fgratio, 'string');     % final gear ratio
fgr=str2double(fgr);
gbe=get(handles.gbeffy, 'string');      % gearbox efficiency
gbe=str2double(gbe);
axe=get(handles.axleffy, 'string');     % axle efficiency
axe=str2double(axe);

T=[gbt gbs tgr fgr gbe axe];

rng1=get(handles.range,'string');
rng=str2double(rng1);
%reg1=get(handles.regeneffy,'string');
%reg=str2double(reg1);
VR=[rng 0];

if(VP(1)==0||VP(2)==0||VP(3)==0||VP(4)==0||VP(5)==0||VP(6)==0)
    mvperror=msgbox('Please note that the Vehicle Parameters could not be set to 0','Error Set Parameters');
    set( mvperror, 'color', [ 0.9 0.9 .9 ] )
%elseif((r==1)&&(reffy==0))
%     mregen=msgbox('Please note that the Regenerative Effy cannot be 0 if Regenerative Braking is ON' ,'Error Regen Effy');
%    set( mregen, 'color', [ 0.9 0.9 .9 ] )
elseif (EP(1)==0)
     mcperror=msgbox('Please note that the Engine Parameters could not be set to 0','Error Set Parameters');
    set( mcperror, 'color', [ 0.9 0.9 .9 ] )
elseif (VR(1)==0)
    mrerror=msgbox('Please note that the Range of the vehicle could not be set to 0','Error Set Parameters');
    set( mrerror, 'color', [ 0.9 0.9 .9 ] )
elseif (T(2)==0||T(3)==0||T(4)==0||T(5)==0||T(6)==0)
    mterror=msgbox('Please note that the Transmission Parameters could not be set to 0','Error Set Parameters');
    set( mterror, 'color', [ 0.9 0.9 .9 ] )
else
    SET=[1];
    close();
end


function cancel_button_Callback(hObject, eventdata, handles)
global VP
global PS
global EP
global MP
global T
global VR
global SET

VP=[0 0 0 0 0 0]; % rests all the global variables on cancel
PS=[0 0 0 0];
EP=[0 0 0];
MP=[0 0 0];
T=[0 0 0 0 0 0];
VR=[0 0];
SET=[0];

close();
