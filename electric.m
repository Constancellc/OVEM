function varargout = electric(varargin)

% I'M CONFUSED ABOUT MOTOR EFFICIENY, DON'T WE FIND IT FROM THE EFFICIENCY
% MAP? PLUS I CAN'T FIND FIGURES ONLINE --> THERE ISN'T ONE VALUE?

% ELECTRIC MATLAB code for electric.fig
%      ELECTRIC, by itself, creates a novice ELECTRIC or raises the existing
%      singleton*.
%
%      H = ELECTRIC returns the handle to a novice ELECTRIC or the handle to
%      the existing singleton*.
%
%      ELECTRIC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ELECTRIC.M with the given input arguments.
%
%      ELECTRIC('Property','Value',...) creates a novice ELECTRIC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before electric_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to electric_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help electric

% Last Modified by GUIDE v2.5 21-Oct-2016 16:20:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @electric_OpeningFcn, ...
                   'gui_OutputFcn',  @electric_OutputFcn, ...
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


% --- Executes just before electric is made visible.
function electric_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to electric (see VARARGIN)

% Choose default command line output for electric
handles.output = hObject;


global SPD;
SCC=SPD(1)-1;
smmtcategories = {'Mini' 'Super Mini' 'Lower Medium' 'Upper Medium' 'Executive' 'Luxury Saloon' 'Specialists Sports' 'Dual Purpose' 'MPV'};
bestselling = {'Hyundai i10' 'Ford Fiesta' 'Ford Focus' 'BMW 3 Series' 'Mercedes-Benz C Class' 'Mercedes-Benz S Class' 'Volkswagen Scirocco' 'Honda CR-V' 'Vauxhall Zafira'};

set(handles.smmttext,'string',smmtcategories{SCC});
set(handles.bestsellingtext,'string',bestselling{SCC});

set(handles.regentype,'SelectionChangeFcn',@regentype_SelectionChangeFcn)


global VP
set(handles.drag,'string',VP(1));
set(handles.frontalarea, 'string',VP(2));
set(handles.weight, 'string',VP(3));
set(handles.wheeldrive, 'string',VP(4));
set(handles.tyrediam, 'string',VP(5));
set(handles.tyreroll, 'string',VP(6));    

global VR
set(handles.range,'string',VR(1));

global MP
set(handles.mpower,'string',MP(1));
set(handles.mtorque,'string',MP(2));
set(handles.meffy,'string',MP(3));

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
6: motor power
7: range
8: regen. efficiency
9: motor torque
10: motor efficiency
%}
lower = [0,0,0,14,0,0,0,0,0,0];
higher = [0.4,3,Inf,17,0.02,1000,Inf,100,Inf,100];
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = electric_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

axes(handles.axes1); % this is used to set focus on the axes currently in use

global SPD; % set car picture depending on which smmt category chosen in vmod1
picture = {'1.tiff' '2.tiff' '3.tiff' '4.tiff' '5.tiff' '6.tiff' '7.tiff' '8.tiff' '9.tiff'};
axes(handles.axes3);
imshow(picture{SPD(1)-1});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%top buttons


function saveev_Callback(hObject, eventdata, handles)
%allow the user to specify where to save the settings file
[filename,pathname] = uiputfile('save_ev','Save your GUI settings');

if pathname == 0 %if the user pressed cancelled, then we exit this callback
    return
end

%construct the path name of the save location
saveDataName = fullfile(pathname,filename); 

%saves the gui data
hgsave(saveDataName);


function loadev_Callback(hObject, eventdata, handles)
%allow the user to choose which settings to load
[filename, pathname] = uigetfile('*.fig', 'Choose the GUI settings file to load');

%construct the path name of the file to be loaded
loadDataName = fullfile(pathname,filename);

%this is the gui that will be closed once we load the new settings
ev = gcf;  

%load the settings, which creates a new gui
hgload(loadDataName); 

%closes the old gui
close(ev);


function helpev_Callback(hObject, eventdata, handles)
txt = ['EV Parameters allows you to set all the parameters that '...
    'affect the performance of a vehicle.  Following your choice of '...
    'SMMT category, you can now either set default values, taken from '...
    'the 2009 best selling vehicle in that category or set your own'];
mevh=msgbox(txt,'EV Parameters help');
set( mevh, 'color', [ 0.9 0.9 .9 ] )


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%vehicle control 

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
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set vehicle parameters

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


function drag_Callback(hObject, eventdata, handles)
generic(handles.drag,1,'drag coefficient');
guidata(hObject, handles);

function drag_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frontalarea_Callback(hObject, eventdata, handles)
generic(handles.frontalarea,2,'frontal area');

function frontalarea_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function weight_Callback(hObject, eventdata, handles)
generic(handles.weight,3,'kerb weight');

function weight_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%motor


function mpower_Callback(hObject, eventdata, handles)
generic(handles.mpower,6,'motor power');


function mpower_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mtorque_Callback(hObject, eventdata, handles)
generic(handles.mtorque,9,'motor torque');


% --- Executes during object creation, after setting all properties.
function mtorque_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% hObject    handle to mtorque (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


function meffy_Callback(hObject, eventdata, handles)
generic(handles.meffy,10,'motor efficiency');
 

% --- Executes during object creation, after setting all properties.
function meffy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to meffy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%motor controls

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

function mtrreset_Callback(hObject, eventdata, handles)
set(handles.mtorque, 'string', '0')
set(handles.mpower, 'string', '0')
set(handles.meffy, 'string', '0')
guidata(hObject, handles);

function mtradvanced_Callback(hObject, eventdata, handles)
madv=msgbox('Sorry, the advanced feature is still inactive','advanced');
    set( madv, 'color', [ 0.9 0.9 .9 ] )



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%vehicle range

function range_Callback(hObject, eventdata, handles)
generic(handles.range,7,'range');
guidata(hObject, handles);

function range_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rangedefault_Callback(hObject, eventdata, handles)
rd=get(handles.rangedefault,'value');
if(rd==1)
    set(handles.range,'string','100');
else
    set(handles.range,'string','0');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%regen control

function regen_Callback(hObject, eventdata, handles)
r=get(handles.regen,'Value');   % Get Value of selected object
if r==1;
      set(handles.eregen,'Visible','on');
      set(handles.mregen, 'Visible', 'on');
      set(handles.regeneffy,'Visible', 'on');
      set(handles.defaultregen,'Visible', 'on');
      set(handles.advancedregen,'Visible', 'on');
      set(handles.text60,'Visible', 'on');
      set(handles.text61,'Visible', 'on');
      
else
      set(handles.eregen,'Visible','off');
      set(handles.eregen,'value',0);
      set(handles.mregen, 'Visible', 'off');
      set(handles.mregen,'value',0);
      set(handles.regeneffy,'Visible', 'off');
      set(handles.defaultregen,'Visible', 'off');
      set(handles.advancedregen,'Visible', 'off');
      set(handles.text60,'Visible', 'off');
      set(handles.text61,'Visible', 'off');
end



function regentype_SelectionChangeFcn(hObject, eventdata)
    handles=guidata(hObject);
switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
    case 'eregen'
        dr=get(handles.defaultregen,'value');
        mr=get(handles.mregen,'value');
        er=get(handles.eregen,'value');
        if(dr==1 && er==1 && mr==0)
        set(handles.regeneffy,'string','90')
        elseif(dr==1 && er==0 && mr==1)
        set(handles.regeneffy,'string','80')
        else
        end
    otherwise
        dr=get(handles.defaultregen,'value');
        mr=get(handles.mregen,'value');
        er=get(handles.eregen,'value');
        if(dr==1 && er==1 && mr==0)
        set(handles.regeneffy,'string','90')
        elseif(dr==1 && er==0 && mr==1)
        set(handles.regeneffy,'string','80')
        else
        end
end


function defaultregen_Callback(hObject, eventdata, handles)
dr=get(handles.defaultregen,'value');
er=get(handles.eregen,'value');
mr=get(handles.mregen,'value');
if((er==0)&&(mr==0))
    madv=msgbox('Please select between electric or mechanical regen','Default Regen Error');
    set( madv, 'color', [ 0.9 0.9 .9 ] )
    
    set(handles.defaultregen,'value',0);
    
elseif dr==1 && ((er==1)&&(mr==0))
        set(handles.regeneffy,'string','90') %assum mregen is 80% effy
    elseif dr==1 && ((er==0)&&(mr==1))
        set(handles.regeneffy,'string','80') %assum mregen is 80% effy
    else
    end
guidata(hObject, handles);


function advancedregen_Callback(hObject, eventdata, handles)
madv=msgbox('Sorry, the advanced feature is still inactive','advanced');
    set( madv, 'color', [ 0.9 0.9 .9 ] )

function eregen_Callback(hObject, eventdata, handles)


function mregen_Callback(hObject, eventdata, handles)


function regeneffy_Callback(hObject, eventdata, handles)
generic(handles.regeneffy,8,'regeneration efficiency');


    
function regeneffy_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ev main control
function setev_Callback(hObject, eventdata, handles)
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

PS=[2 2 2 2];

EP=[0 2 2];

mp=get(handles.mpower,'string');        % motor power
mp=str2double(mp);
mt=get(handles.mtorque,'string');       % motor torque
mt=str2double(mt);
me=get(handles.meffy,'string');         % motor efficiency
me=str2double(me);

MP=[mp mt me];

T=[2 2 2 2 2 2]; 

rng=get(handles.range,'string');        % range
rng=str2double(rng);
reg=get(handles.regen,'value');         % regen? (0/1) 
ref=get(handles.regeneffy,'string');    % regen efficiency
ref=str2double(ref);

VR=[rng reg ref];

if(VP(1)==0||VP(2)==0||VP(3)==0||VP(4)==0||VP(5)==0||VP(6)==0)
    mvperror=msgbox('Please note that none of the Vehicle Parameters could be set to 0','Error Set Parameters');
    set( mvperror, 'color', [ 0.9 0.9 .9 ] )
elseif (VR(1)==0)
    mrerror=msgbox('Please note that the range of the vehicle could not be set to 0','Error Set Parameters');
    set( mrerror, 'color', [ 0.9 0.9 .9 ] )
elseif (MP(1)==0||MP(2)==0||MP(3)==0)
    mperror=msgbox('Please note that none of the Motor Parameters could be set to 0','Error Set Parameters');
    set( mvperror, 'color', [ 0.9 0.9 .9 ] )
else
    SET=[1];
close();
end


function Cancel_button_Callback(hObject, eventdata, handles)
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


