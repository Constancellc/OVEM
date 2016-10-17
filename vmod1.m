% general user interface for vehicle modelling
% created: 15 November 2011
% author: Robert Camilleri
%
% modified: XX October 2016
% by: Constance Crozier
%
% defining global Output Variables: global SPD
%                                   global VP
%                                   global PS
%                                   global EP
%                                   global MP
%                                   global T
%                                   global VR
%                                   global SET
%
% global SPD , defined in vmod
% SPD=[S P D]  
% S=SMMT Category   2=m, 3=sm, 4=lm, 5=um, 6=e, 7=ls, 8=ss, 9=dp, 10=mpv
% P=powertrain      2=ice, 3=hybrid, 4=ev
% D=drivecycle      2=artemis, 3=NEDC, 4=EPA, 5=Japan
%
% global VP , vehicle parameters, defined in ice or electric or hybrid.
% VP=[dc fa kw wd td tr]
% dc=drag
% fa=frontal area
% kw=weight
% wd=wheel drive
% td=tyre diameter
% tr=tyre rolling resistance
%
% global PS, power source, defined in ice or electric or hybrid.
% PS=[ht et ft tc]
% ht=hybrid type, 1=series, 2=dual, 3=plugin,  EV or ICE set to 0
% et=engine type (fuel cell or IC), in IC set to 3, in EV set to 2
% ft=fuel type, 1=petrol, 0=diesel, 2=EV
% tc=turbocharged, 1=tc, 0=not tc, 2=EV
% 
% global EP, engine parameters
% EP=[es et ep]
% es=engine size, in EV set to 2
% et=engien torque, in EV set to 2
% ep=engine power, in EV set to 2
%
% global MP, electric motor parameters
% MP=[mp mt me]
% mp=motor power, in IC set to 3
% mt=motor torque, in IC set to 3
% me=motor efficiency, in IC set to 3
%
% global T, transmission
% T=[gbt gbs tgr fgr gbe axe]
% gbt=gearbox type
% gbs=gearbox speed
% tgr=top gear ratio
% fgr=final gear ratio
% gbe=gearbox efficiency
% axe=axle efficiency
%
% global VR, vehicle range parameters
% VR=[rng reg ref]
% rng=user desired range
% reg=makes use of regeneration or not
% ref=regeneration efficiency




function varargout = vmod1(varargin)
% VMOD1 MATLAB code for vmod1.fig
%      VMOD1, by itself, creates a novice VMOD1 or raises the existing
%      singleton*.
%
%      H = VMOD1 returns the handle to a novice VMOD1 or the handle to
%      the existing singleton*.
%
%      VMOD1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VMOD1.M with the given input arguments.
%
%      VMOD1('Property','Value',...) creates a novice VMOD1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vmod1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vmod1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to helpvmod vmod1

% Last Modified by GUIDE v2.5 09-Feb-2012 23:25:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vmod1_OpeningFcn, ...
                   'gui_OutputFcn',  @vmod1_OutputFcn, ...
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


% --- Executes just before vmod1 is made visible.
function vmod1_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vmod1 (see VARARGIN)
%   
global SPD
set(handles.smmt,'value',SPD(1))
set(handles.powertrain,'value',SPD(2))
set(handles.drivecycle,'value',SPD(3))

% surely unecessary
%{
if ((SPD(1)>1)&&(SPD(2)>1)&&(SPD(3)>1))
else
    s
    set(handles.smmt,'value',1);
set(handles.powertrain,'value',1);
set(handles.drivecycle,'value',1);
S = get(handles.smmt,'value');
P = get(handles.powertrain,'value');
D = get(handles.drivecycle,'value');
SPD=[S P D];

%}


global SET
global VP
global PS
global EP
global T
global VR
global MP
    

% Update handles structure
handles.output = hObject;
guidata(hObject, handles);




% --- Outputs from this function are returned to the command line.
function varargout = vmod1_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;

axes(handles.axes1); % this is used to set focus on the axes currently in use


%%%%%%%%%%%%%%%%%%%%%%%%%%
%top gui buttons

function aboutvmod_Callback(hObject, eventdata, handles)
mvm1=msgbox('Vehicle Modelling is a part of OVeM+.  In it you can create a model of the vehicle you are interested in by sizing the various components', 'about Vehicle Modelling');
set( mvm1, 'color', [ 0.9 0.9 .9 ] )

function helpvmod_Callback(hObject, eventdata, handles)
mvm2=msgbox('Choose an SMMT Category and a Power Train and press "Set Parameters".  This will then take you to the part where you can set the performance of the critical components of the vehicle.  After you set the components choose a drive cycle and press "GO!" to simulate the vehicle performance','help Vehicle Modelling')
set( mvm2, 'color', [ 0.9 0.9 .9 ] )

function home_Callback(hObject, eventdata, handles)
global OVEM31
OVEM31=0;
handles.output = hObject;
guidata(hObject, handles);
close();
ovemplus




%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
function smmt_Callback(hObject, eventdata, handles)
     global SPD
     SPD(1)=get(handles.smmt,'value');
     
handles.output = hObject;
guidata(hObject, handles);


 function smmt_CreateFcn(hObject, ~, ~)
 %Hint: popupmenu controls usually have a white background on Windows.
 %      See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function powertrain_Callback(hObject, eventdata, handles)
    global SPD
    SPD(2) = get(handles.powertrain,'value');

handles.output = hObject;
guidata(hObject, handles);
    
function powertrain_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    
 
function setvmod_Callback(hObject, eventdata, handles);
% Checks that the SMMT and powertrain have been set then call the relevant
% subgui
global SPD
if((SPD(1)==1)||(SPD(2)==1))
    mvm5=msgbox('please fill in the SMMT Categories and the Power Train');
    set( mvm5, 'color', [ 0.9 0.9 .9 ] );
elseif SPD(2)==2
      ice(); %call the sub gui
elseif SPD(2)==3
      hybrid();
elseif SPD(2)==4
      electric();
end


function drivecycle_Callback(hObject, eventdata, handles)
handles.output = hObject;
guidata(hObject, handles);

function drivecycle_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function govmod_Callback(hObject, eventdata, handles)
global SPD
global VP 
global PS
global EP
global MP
global T
global VR
global SET
global OVEM31
global OUT

% Is this necessary?
S = get(handles.smmt,'value');
P = get(handles.powertrain,'value');
D = get(handles.drivecycle,'value');
SPD=[S P D];

SCC=SPD(1)-1;
smmtcategories = {'Mini' 'Super Mini' 'Lower Medium' 'Upper Medium' 'Executive' 'Luxury Saloon' 'Specialists Sports' 'Dual Purpose' 'MPV'};
bestselling = {'Hyundai i10' 'Ford Fiesta' 'Ford Focus' 'BMW 3 Series' 'Mercedes-Benz C Class' 'Mercedes-Benz S Class' 'Volkswagen Scirocco' 'Honda CR-V' 'Vauxhall Zafira'};
SPC=SPD(2)-1;
powertrain = {'ICE' 'Hybrid' 'Electric'};
SDC=SPD(3)-1;
drivecycle = {'NEDC' 'Artemis' 'FUDS' 'NYCC' 'US06' 'US HWFET' 'US EPA'};

sp=SET(1);

if (((SPD(1)==1) || (SPD(2)==1) || (SPD(3)==1)) || (SET(1)==0))
    mcat=msgbox('please set all parameters first');
       set( mcat, 'color', [ 0.9 0.9 .9 ] );
else
    h = waitbar(0,'Calculating. Please wait...');
    steps = 100;
    
    ovem31();
    
    for step = 1:steps
        waitbar(step / steps);
    end
    close(h);

    %a=SPD
    %b=VP
    %c=PS
    %d=EP
    %e=MP
    %f=T
    %g=VR
    %mcat=msgbox('talk to justin!','talk to justin!');
    %   set( mcat, 'color', [ 0.9 0.9 .9 ] )
    %para1 justins software
end

if OVEM31(1)==1
    % Display the result fields
    set(handles.pp,'visible','on')
    set(handles.pp1,'visible','on')
    set(handles.pp2,'visible','on')
    set(handles.fc,'visible','on')
    set(handles.fc1,'visible','on')
    set(handles.fc2,'visible','on')
    set(handles.ce,'visible','on')
    set(handles.ce1,'visible','on')
    set(handles.ce2,'visible','on')
    set(handles.fcwtw,'visible','on')
    set(handles.fcwtw1,'visible','on')
    set(handles.fcwtw2,'visible','on')
    set(handles.cewtw,'visible','on')
    set(handles.cewtw1,'visible','on')
    set(handles.cewtw2,'visible','on')
    set(handles.ec,'visible','on')
    set(handles.ec1,'visible','on')
    set(handles.ec2,'visible','on')
    set(handles.smmt1,'visible','on')
    set(handles.smmt2,'visible','on')
    set(handles.bestselling1,'visible','on')
    set(handles.bestselling2,'visible','on')
    set(handles.powertrain1,'visible','on')
    set(handles.powertrain2,'visible','on')
    set(handles.drivecycle1,'visible','on')
    set(handles.drivecycle2,'visible','on')
    
    if (SPD(2)==3||SPD(2)==4);
        set(handles.bc,'visible','on')
        set(handles.bc1,'visible','on')
        set(handles.bc2,'visible','on')
    elseif (SPD(2)==2);
        set(handles.bc,'visible','off')
        set(handles.bc1,'visible','off')
        set(handles.bc2,'visible','off')
    end
    
    % And fill them with the returned values
    set(handles.pp1,'string',OUT(1))
    set(handles.fc1,'string',OUT(2))
    set(handles.ce1,'string',OUT(3))
    set(handles.fcwtw1,'string',OUT(4))
    set(handles.cewtw1,'string',OUT(5))
    set(handles.ec1,'string',OUT(6))
    set(handles.bc1,'string',OUT(7))
    set(handles.smmt2,'string',smmtcategories(SCC))
    set(handles.bestselling2,'string',bestselling(SCC))
    set(handles.powertrain2,'string',powertrain(SPC))
    set(handles.drivecycle2,'string',drivecycle(SDC))
else
    set(handles.pp,'visible','off')
    set(handles.pp1,'visible','off')
    set(handles.pp2,'visible','off')
    set(handles.fc,'visible','off')
    set(handles.fc1,'visible','off')
    set(handles.fc2,'visible','off')
    set(handles.ce,'visible','off')
    set(handles.ce1,'visible','off')
    set(handles.ce2,'visible','off')
    set(handles.fcwtw,'visible','off')
    set(handles.fcwtw1,'visible','off')
    set(handles.fcwtw2,'visible','off')
    set(handles.cewtw,'visible','off')
    set(handles.cewtw1,'visible','off')
    set(handles.cewtw2,'visible','off')
    set(handles.ec,'visible','off')
    set(handles.ec1,'visible','off')
    set(handles.ec2,'visible','off')
    set(handles.bc,'visible','off')
    set(handles.bc1,'visible','off')
    set(handles.bc2,'visible','off')
end

handles.output = hObject;
guidata(hObject, handles);
