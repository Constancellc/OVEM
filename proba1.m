function varargout = proba1(varargin)
% PROBA1 MATLAB code for proba1.fig
%      PROBA1, by itself, creates a new PROBA1 or raises the existing
%      singleton*.
%
%      H = PROBA1 returns the handle to a new PROBA1 or the handle to
%      the existing singleton*.
%
%      PROBA1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROBA1.M with the given input arguments.
%
%      PROBA1('Property','Value',...) creates a new PROBA1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before proba1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to proba1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help proba1

% Last Modified by GUIDE v2.5 12-Feb-2012 17:51:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proba1_OpeningFcn, ...
                   'gui_OutputFcn',  @proba1_OutputFcn, ...
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


% --- Executes just before proba1 is made visible.
function proba1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to proba1 (see VARARGIN)

% Choose default command line output for proba1
handles.output = hObject;


guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = proba1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.output;



%%%%%%%%%%%%%%%%%%%%%%%%%%
%top gui buttons

function aboutproba_Callback(hObject, eventdata, handles)
mpr1=msgbox('Probability Analysis is a part of OVeM+ which allows to look at the wider picture of road transport.  Through Probability Analysis, the choice of the consumer is taken into consideration, and their effects on the future of transportation is analysed.','about Probability Analysis')
set( mpr1, 'color', [ 0.9 0.9 .9 ] )


function helpproba_Callback(hObject, eventdata, handles)
mpr2=msgbox('Probability Analysis allows to model the market and the diffusion of different types of vehicles, based on the user choices and legislation. After selecting between Consumer options or Legislation, please fill in the requried data and set a year. Press Go! and a fleet simulation is run, showing how the Consumer choices or Legislation will affect the fleet diffusion','Probability Analysis help');
set( mpr2, 'color', [ 0.9 0.9 .9 ] )


function Home_Callback(hObject, eventdata, handles)
handles.output = hObject;
guidata(hObject, handles);
close();
ovemplus



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%consumer preference

function preferences(handles,i,name)
% i - index: 1=price, 2=running cost, 3=performance, 4=range, 5=emissions
% and 6=refuel

p = get(handles.price,'String');                % price
p=str2double(p);
rc= get(handles.rcost,'String');                % running cost
rc=str2double(rc);
vp = get(handles.perf,'String');                % performance
vp=str2double(vp);
r = get(handles.range,'String');                % range
r=str2double(r);
e = get(handles.emiss,'String');                % emissions
e=str2double(e);
rf = get(handles.refuel,'String');              % refuel
rf=str2double(rf);

values = [p,rc,vp,r,e,rf];
n = values(i);

t=20-(p+rc+vp+r+e+rf);                          % total
t_s=num2str(t);

if  (isempty(n) || n < 0 || n > 20);
    txt = sprintf('Please choose a value between 0 and 20');
    m=msgbox(txt,name);
    set( m, 'color', [ 0.9 0.9 .9 ] )
elseif t<0
    m=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( m, 'color', [ 0.9 0.9 .9 ] )
else
    set(handles.total,'string',t_s); 
end



function resetcons_Callback(hObject, eventdata, handles)
set(handles.price,'string',0);
set(handles.rcost,'string',0);
set(handles.perf,'string',0);
set(handles.range,'string',0)
set(handles.emiss,'string',0);
set(handles.refuel,'string',0);
set(handles.total,'string',20);



function price_Callback(hObject, eventdata, handles)
preferences(handles,1,'Error Purchase Price')
guidata(hObject, handles)


function price_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rcost_Callback(hObject, eventdata, handles)
preferences(handles,2,'Error Running Cost')
guidata(hObject, handles)



function rcost_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function perf_Callback(hObject, eventdata, handles)
preferences(handles,3,'Error Vehicle Performance')
guidata(hObject, handles)


function perf_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function range_Callback(hObject, eventdata, handles)
preferences(handles,4,'Error Range')
guidata(hObject, handles)


function range_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function emiss_Callback(hObject, eventdata, handles)
preferences(handles,5,'Error Emissions')
guidata(hObject, handles)


function emiss_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function refuel_Callback(hObject, eventdata, handles)
preferences(handles,6,'Error Refuelling Availibility')
guidata(hObject, handles)


function refuel_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%policy controls

function policy(handles,i)
% i is an index relating to the check box.

properties = [handles.sevsl, handles.sevvl, handles.sevyi, handles.sevyo,...
    handles.text76;...
    handles.hysl,handles.hyvl,handles.hyyi,handles.hyyo,...
    handles.text77;...
    handles.phsl,handles.phvl,handles.phyi,handles.phyo,...
    handles.text78;...
    handles.fcsl,handles.fcvl,handles.fcyi,handles.fcyo,...
    handles.text79;...
    handles.psl,handles.pvl,handles.pyi,handles.pyo,handles.text80;...
    handles.dsl,handles.dvl,handles.dyi,handles.dyo,handles.text81;...
    handles.esl,handles.evl,handles.eyi,handles.eyo,handles.text82;...
    handles.hsl,handles.hvl,handles.hyi,handles.hyo,handles.text83];

a=[get(handles.sev,'value'); get(handles.hy,'value');...
    get(handles.ph,'value'); get(handles.fc,'value');...
    get(handles.petrol,'value'); get(handles.diesel,'value');...
    get(handles.electricity,'value'); get(handles.hydrogen,'value')];
   
if a(i)==1
    for j = 1:5
        set(properties(i,j),'visible','on');
    end
elseif a(i)==0
    for j = 1:5
        set(properties(i,j),'visible','off');
    end
end

set(properties(i,1),'value',0);
set(properties(i,2),'string','0');
set(properties(i,3),'string','2010');
set(properties(i,4),'string','2011');

if sum(a) > 0
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
end

function sev_Callback(hObject, eventdata, handles)
policy(handles,1)

function hy_Callback(hObject, eventdata, handles)
policy(handles,2)

function ph_Callback(hObject, eventdata, handles)
policy(handles,3)

function fc_Callback(hObject, eventdata, handles)
policy(handles,4)

function petrol_Callback(hObject, eventdata, handles)
policy(handles,5)

function diesel_Callback(hObject, eventdata, handles)
policy(handles,6)

function electricity_Callback(hObject, eventdata, handles)
policy(handles,7)

function hydrogen_Callback(hObject, eventdata, handles)
policy(handles,8)


%slider, value, years for PAMD

function manual_value(property,limit)
value = get(property,'String'); 
value = str2double(value); 

if (isempty(value) || value < 0 || value > limit)
    set(property,'Value',0);
    set(property,'String','0');
    txt = sprintf('Please choose a value below %d',limit);
    m=msgbox(txt, 'Error');
    set( m, 'color', [ 0.9 0.9 .9 ] )
else
    set(property,'Value',value);
end

function policy_year(in,out,final)
yi = get(in,'string');
yi = str2double(yi);
yo = get(out,'string');
yo = str2double(yo);

if nargin < 3
    final = 0;
end

if(yo<yi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
    set( my, 'color', [ 0.9 0.9 .9 ] )
    set(in,'string','2010');

elseif(yi<2010)
    my=msgbox('The policy year in cannot be smaller than 2010', 'Error Policy Year');
    set( my, 'color', [ 0.9 0.9 .9 ] )
    set(in,'string','2010');
end

if (final~=0) && (yo>final)
    my=msgbox('The policy year out cannot be greater than the final simulation year', 'Error Policy Year');
    set( my, 'color', [ 0.9 0.9 .9 ] )
    set(out,'string',final)
end

function sevsl_Callback(hObject, eventdata, handles)
sl = get(handles.sevsl,'Value');%obtains the slider value from the slider component
set(handles.sevvl,'String', num2str(sl));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function sevsl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function sevvl_Callback(hObject, eventdata, handles)
manual_value(handles.sevsl,1000)


function sevvl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function sevyi_Callback(hObject, eventdata, handles)
policy_year(handles.sevyi,handles.sevyo)

function sevyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function sevyo_Callback(hObject, eventdata, handles)
policy_year(handles.sevyi,handles.sevyo,handles.finalyear)

function sevyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function hysl_Callback(hObject, eventdata, handles)
sl = get(handles.hysl,'Value');%obtains the slider value from the slider component
set(handles.hyvl,'String', num2str(sl));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function hysl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function hyvl_Callback(hObject, eventdata, handles)
manual_value(handles.hyvl,1000)


function hyvl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function hyyi_Callback(hObject, eventdata, handles)
policy_year(handles.hyyi,handles.hyyo)
        

function hyyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function hyyo_Callback(hObject, eventdata, handles)
policy_year(handles.hyyi,handles.hyyo,handles.finalyear)


function hyyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function phsl_Callback(hObject, eventdata, handles)
sl = get(handles.phsl,'Value');%obtains the slider value from the slider component
set(handles.phvl,'String', num2str(sl));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function phsl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function phvl_Callback(hObject, eventdata, handles)
manual_value(handles.phvl,1000)


function phvl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function phyi_Callback(hObject, eventdata, handles)
policy_year(handles.phyi,handles.phyo)


function phyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function phyo_Callback(hObject, eventdata, handles)
policy_year(handles.phyi,handles.phyo,handles.finalyear)


function phyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function fcsl_Callback(hObject, eventdata, handles)
sl = get(handles.fcsl,'Value');%obtains the slider value from the slider component
set(handles.fcvl,'String', num2str(sl));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function fcsl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function fcvl_Callback(hObject, eventdata, handles)
manual_value(handles.fcvl,1000)

function fcvl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fcyi_Callback(hObject, eventdata, handles)
policy_year(handles.fcyi,handles.fcyo)

function fcyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fcyo_Callback(hObject, eventdata, handles)
policy_year(handles.fcyi,handles.fcyo,handles.finalyear)

function fcyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%%%%%%%%%%%changes in fuel prices


function psl_Callback(hObject, eventdata, handles)
sl = get(handles.psl,'Value');%obtains the slider value from the slider component
set(handles.pvl,'String', num2str(sl));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function psl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function pvl_Callback(hObject, eventdata, handles)
manual_value(handles.pvl,1000)

function pvl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pyi_Callback(hObject, eventdata, handles)
policy_year(handles.pyi,handles.pyo)

function pyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pyo_Callback(hObject, eventdata, handles)
policy_year(handles.pyi,handles.pyo,handles.finalyear)


function pyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dsl_Callback(hObject, eventdata, handles)
sl = get(handles.dsl,'Value');%obtains the slider value from the slider component
set(handles.dvl,'String', num2str(sl));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function dsl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function dvl_Callback(hObject, eventdata, handles)
manual_value(handles.dvl,1000)

function dvl_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dyi_Callback(hObject, eventdata, handles)
policy_year(handles.dyi,handles.dyo)

function dyi_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dyo_Callback(hObject, eventdata, handles)
policy_year(handles.dyi,handles.dyo)

function dyo_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function esl_Callback(hObject, eventdata, handles)
sl = get(handles.esl,'Value');%obtains the slider value from the slider component
set(handles.evl,'String', num2str(sl));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function esl_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function evl_Callback(hObject, eventdata, handles)
manual_value(handles.evl,1000)

function evl_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eyi_Callback(hObject, eventdata, handles)
policy_year(handles.eyi,handles.eyo)

function eyi_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eyo_Callback(hObject, eventdata, handles)
policy_year(handles.eyi,handles.eyo,handles.finalyear)

function eyo_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function hsl_Callback(hObject, eventdata, handles)
sl = get(handles.hsl,'Value');%obtains the slider value from the slider component
set(handles.hvl,'String', num2str(sl));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function hsl_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function hvl_Callback(hObject, eventdata, handles)
manual_value(handles.hvl,1000)

function hvl_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function hyi_Callback(hObject, eventdata, handles)
policy_year(handles.hyi,handles.hyo)

function hyi_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function hyo_Callback(hObject, eventdata, handles)
policy_year(handles.hyi,handles.hyo,handles.finalyear)

function hyo_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%other factors

function others(handles,i)
% i is an index relating to the check box.

% This matrix contains the locations of the properties relevant to each
% call, each row representing a different option
properties = [handles.ncegsl, handles.ncegvl, handles.ncegyi,...
    handles.ncegyo, handles.text84;...
    handles.ptisl, handles.ptivl, handles.ptiyi, handles.ptiyo,...
    handles.text85;...
    handles.dtisl, handles.dtivl, handles.dtiyi, handles.dtiyo,...
    handles.text86;...
    handles.htisl, handles.htivl, handles.htiyi, handles.htiyo,...
    handles.text87;...
    handles.pihtisl, handles.pihtivl, handles.pihtiyi, handles.pihtiyo,...
    handles.text88;...
    handles.etisl, handles.etivl, handles.etiyi, handles.etiyo,...
    handles.text89;...
    handles.fctisl, handles.fctivl, handles.fctiyi, handles.fctiyo,...
    handles.text90];
   
% And this stores the values in question
a=[get(handles.nceg,'value'); get(handles.pti,'value');...
    get(handles.dti,'value'); get(handles.hti,'value');...
    get(handles.pihti,'value'); get(handles.eti,'value');...
    get(handles.fcti,'value')];
   
if a(i)==1
    for j = 1:5
        set(properties(i,j),'visible','on');
    end
elseif a(i)==0
    for j = 1:5
        set(properties(i,j),'visible','off');
    end
end

set(properties(i,1),'value',0);
set(properties(i,2),'string','0');
set(properties(i,3),'string','2010');
set(properties(i,4),'string','2011');

if sum(a) > 0
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
end

function nceg_Callback(hObject, eventdata, handles)
others(handles,1)
    
function pti_Callback(hObject, eventdata, handles)
others(handles,2)

function dti_Callback(hObject, eventdata, handles)
others(handles,3)

function hti_Callback(hObject, eventdata, handles)
others(handles,4)

function pihti_Callback(hObject, eventdata, handles)
others(handles,5)

function eti_Callback(hObject, eventdata, handles)
others(handles,6)

function fcti_Callback(hObject, eventdata, handles)
others(handles,7)

%sliders, values, years for OFAMD


function ncegsl_Callback(hObject, eventdata, handles)
sl = get(handles.ncegsl,'Value');%obtains the slider value from the slider component
set(handles.ncegvl,'String', num2str(sl));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function ncegsl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ncegvl_Callback(hObject, eventdata, handles)
manual_value(handles.ncegvl,100)

function ncegvl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ncegyi_Callback(hObject, eventdata, handles)
policy_year(handles.ncegyi,handles.ncegyo)


function ncegyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ncegyo_Callback(hObject, eventdata, handles)
policy_year(handles.ncegyi,handles.ncegyo,handles.finalyear)

function ncegyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ptisl_Callback(hObject, eventdata, handles)
sl = get(handles.ptisl,'Value');%obtains the slider value from the slider component
set(handles.ptivl,'String', num2str(sl));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function ptisl_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function dtisl_Callback(hObject, eventdata, handles)
sl = get(handles.dtisl,'Value');%obtains the slider value from the slider component
set(handles.dtivl,'String', num2str(sl));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function dtisl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function htisl_Callback(hObject, eventdata, handles)
sl = get(handles.htisl,'Value');%obtains the slider value from the slider component
set(handles.htivl,'String', num2str(sl));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function htisl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function pihtisl_Callback(hObject, eventdata, handles)
sl = get(handles.pihtisl,'Value');%obtains the slider value from the slider component
set(handles.pihtivl,'String', num2str(sl));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function pihtisl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function etisl_Callback(hObject, eventdata, handles)
sl = get(handles.etisl,'Value');%obtains the slider value from the slider component
set(handles.etivl,'String', num2str(sl));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function etisl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function fctisl_Callback(hObject, eventdata, handles)
sl = get(handles.fctisl,'Value');%obtains the slider value from the slider component
set(handles.fctivl,'String', num2str(sl));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure


function fctisl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function ptivl_Callback(hObject, eventdata, handles)
manual_value(handles.ptivl,100)

function ptivl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ptiyi_Callback(hObject, eventdata, handles)
policy_year(handles.ptiyi,handles.ptiyo)


function ptiyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ptiyo_Callback(hObject, eventdata, handles)
policy_year(handles.ptiyi,handles.ptiyo,handles.finalyear)


function ptiyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function dtivl_Callback(hObject, eventdata, handles)
manual_value(handles.dtivl,100)

function dtivl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function dtiyi_Callback(hObject, eventdata, handles)
policy_year(handles.dtiyi,handles.dtiyo)

function dtiyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function dtiyo_Callback(hObject, eventdata, handles)
policy_year(handles.dtiyi,handles.dtiyo,handles.finalyear)

function dtiyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function htivl_Callback(hObject, eventdata, handles)
manual_value(handles.htivl,100)

function htivl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function htiyi_Callback(hObject, eventdata, handles)
policy_year(handles.htiyi,handles.htiyo)

function htiyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function htiyo_Callback(hObject, eventdata, handles)
policy_year(handles.htiyi,handles.htiyo,handles.finalyear)

function htiyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pihtivl_Callback(hObject, eventdata, handles)
manual_value(handles.pihtivl,100)

function pihtivl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pihtiyi_Callback(hObject, eventdata, handles)
policy_year(handles.pihtiyi,handles.pihtiyo)

function pihtiyi_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pihtiyo_Callback(hObject, eventdata, handles)
policy_year(handles.pihtiyi,handles.pihtiyo,handles.finalyear)

function pihtiyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function etivl_Callback(hObject, eventdata, handles)
manual_value(handles.etivl,100)


function etivl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function etiyi_Callback(hObject, eventdata, handles)
policy_year(handles.etiyi,handles.etiyo)

function etiyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function etiyo_Callback(hObject, eventdata, handles)
policy_year(handles.etiyi,handles.etiyo,handles.finalyear)

function etiyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fctivl_Callback(hObject, eventdata, handles)
manual_value(handles.fctivl,100)

function fctivl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fctiyi_Callback(hObject, eventdata, handles)
policy_year(handles.fctiyi,handles.fctiyo)

function fctiyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fctiyo_Callback(hObject, eventdata, handles)
policy_year(handles.fctiyi,handles.fctiyo,handles.finalyear)


function fctiyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%
%control buttons

function finalyear_Callback(hObject, eventdata, handles)


function finalyear_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function go_Callback(hObject, eventdata, handles)
global ICERT
global PAMD
global OFAMD
global CC 

ICERT(1)=0
%global CHECKPAMD
%global CHECKOFAMD
%global CHECKCC

%getting values of PAMD
ss10=get(handles.sev,'value');
ss1=get(handles.sevvl,'string');
ss11=str2double(ss1);
ss2=get(handles.sevyi,'string');
ss12=str2double(ss2);
ss3=get(handles.sevyo,'string');
ss13=str2double(ss3);

hy10=get(handles.hy,'value');
hy1=get(handles.hyvl,'string');
hy11=str2double(hy1);
hy2=get(handles.hyyi,'string');
hy12=str2double(hy2);
hy3=get(handles.hyyo,'string');
hy13=str2double(hy3);

ph10=get(handles.ph,'value');
ph1=get(handles.phvl,'string');
ph11=str2double(ph1);
ph2=get(handles.phyi,'string');
ph12=str2double(ph2);
ph3=get(handles.phyo,'string');
ph13=str2double(ph3);

fc10=get(handles.fc,'value');
fc1=get(handles.fcvl,'string');
fc11=str2double(fc1);
fc2=get(handles.fcyi,'string');
fc12=str2double(fc2);
fc3=get(handles.fcyo,'string');
fc13=str2double(fc3);

pp10=get(handles.petrol,'value');
pp1=get(handles.pvl,'string');
pp11=str2double(pp1);
pp2=get(handles.pyi,'string');
pp12=str2double(pp2);
pp3=get(handles.pyo,'string');
pp13=str2double(pp3);

dp10=get(handles.diesel,'value');
dp1=get(handles.dvl,'string');
dp11=str2double(dp1);
dp2=get(handles.dyi,'string');
dp12=str2double(dp2);
dp3=get(handles.dyo,'string');
dp13=str2double(dp3);

ep10=get(handles.electricity,'value');
ep1=get(handles.evl,'string');
ep11=str2double(ep1);
ep2=get(handles.eyi,'string');
ep12=str2double(ep2);
ep3=get(handles.eyo,'string');
ep13=str2double(ep3);

hp10=get(handles.hydrogen,'value');
hp1=get(handles.hvl,'string');
hp11=str2double(hp1);
hp2=get(handles.hyi,'string');
hp12=str2double(hp2);
hp3=get(handles.hyo,'string');
hp13=str2double(hp3);

    
%getting values of OFAMD

ec010=get(handles.nceg,'value');
ec01=get(handles.ncegvl,'string');
ec011=str2double(ec01);
ec02=get(handles.ncegyi,'string');
ec012=str2double(ec02);
ec03=get(handles.ncegyo,'string');
ec013=str2double(ec03);

pp010=get(handles.pti,'value');
pp01=get(handles.ptivl,'string');
pp011=str2double(pp01);
pp02=get(handles.ptiyi,'string');
pp012=str2double(pp02);
pp03=get(handles.ptiyo,'string');
pp013=str2double(pp03);

dp010=get(handles.dti,'value');
dp01=get(handles.dtivl,'string');
dp011=str2double(dp01);
dp02=get(handles.dtiyi,'string');
dp012=str2double(dp02);
dp03=get(handles.dtiyo,'string');
dp013=str2double(dp03);

hp010=get(handles.hti,'value');
hp01=get(handles.htivl,'string');
hp011=str2double(hp01);
hp02=get(handles.htiyi,'string');
hp012=str2double(hp02);
hp03=get(handles.htiyo,'string');
hp013=str2double(hp03);

pi010=get(handles.pihti,'value');
pi01=get(handles.pihtivl,'string');
pi011=str2double(pi01);
pi02=get(handles.pihtiyi,'string');
pi012=str2double(pi02);
pi03=get(handles.pihtiyo,'string');
pi013=str2double(pi03);

et010=get(handles.eti,'value');
et01=get(handles.etivl,'string');
et011=str2double(et01);
et02=get(handles.etiyi,'string');
et012=str2double(et02);
et03=get(handles.etiyo,'string');
et013=str2double(et03);

fc010=get(handles.fcti,'value');
fc01=get(handles.fctivl,'string');
fc011=str2double(fc01);
fc02=get(handles.fctiyi,'string');
fc012=str2double(fc02);
fc03=get(handles.fctiyo,'string');
fc013=str2double(fc03);



%%%%%%%%%%%%%%%%%%%%%%%%%
%set CC

p1 = get(handles.price,'String');
p=str2double(p1);
rc1 = get(handles.rcost,'String');
rc=str2double(rc1);
vp1 = get(handles.perf,'String');
vp=str2double(vp1);
r1 = get(handles.range,'String');
r=str2double(r1);
e1 = get(handles.emiss,'String');
e=str2double(e1);
rf1 = get(handles.refuel,'String');
rf=str2double(rf1);
t1=20-(p+rc+vp+r+e+rf);
y1 = get(handles.finalyear,'string');
y=str2double(y1);

 
%%%%%%%%%%%%%%%%%
%check before go

if (ss10==1 && ss11==0)||(hy10==1 && hy11==0)||(ph10==1 && ph11==0)||(fc10==1 && fc11==0)||(pp10==1 && pp11==0)||(dp10==1 && dp11==0)||(ep10==1 && ep11==0)||(hp10==1 && hp11==0)
       mp1=msgbox('Please note that one of the values in PAMD is not set', 'Set PAMD');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    
    elseif (ss10==1 && (ss12==ss13))||(hy10==1 && (hy12==hy13))||(ph10==1 && (ph12==ph13))||(fc10==1 && (fc12==fc13))||(pp10==1 && (pp12==pp13))||(dp10==1 && (dp12==dp13))||(ep10==1 && (ep12==ep13))||(hp10==1 && (hp12==hp13))
mp3=msgbox('Please note that the year out in PAMD cannot be equal to the year in', 'Set year PAMD');
    set( mp3, 'color', [ 0.9 0.9 .9 ] )
    
elseif (ec010==1 && ec011==0)||(pp010==1 && pp011==0)||(dp010==1 && dp011==0)||(hp010==1 && hp011==0)||(pi010==1 && pi011==0)||(et010==1 && et011==0)||(fc010==1 && fc011==0)
     mp2=msgbox('Please note that one of the values in OFAMD is not set', 'Set OFAMD');
    set( mp2, 'color', [ 0.9 0.9 .9 ] )
    
elseif (ec010==1 && (ec012==ec013))||(pp010==1 && (pp012==pp013))||(dp010==1 && (dp012==dp013))||(hp010==1 && (hp012==hp013))||(pi010==1 && (pi012==pi013))||(et010==1 && (et012==et013))||(fc010==1 && (fc012==fc013))
mp4=msgbox('Please note that the year out in OFAMD cannot be equal to the year in', 'Set year OFAMD');
    set( mp4, 'color', [ 0.9 0.9 .9 ] )
    
elseif ((p>0 || rc>0 || vp>0 || r>0 || e>0 || rf>0) && t1>0)
    mp5=msgbox('Please note that the Consumer Sentivity is incomplete', 'Set Consumer Sensitivity');
    set( mp5, 'color', [ 0.9 0.9 .9 ] )

elseif ((ss10==0 && hy10==0 && ph10==0 && fc10==0 && pp10==0 && dp10==0 && ep10==0 && hp10==0) && (ec010==0 && pp010==0 && dp010==0 && hp010==0 && pi010==0 && et010==0 && fc010==0) && t1==20)
    mp0=msgbox('Please note that no values are set!', 'Set Values');
   set( mp0, 'color', [ 0.9 0.9 .9 ] )
    
elseif ((ss10>0 || hy10>0 || ph10>0 || fc10>0 || pp10>0 || dp10>0 || ep10>0 || hp10>0) || (ec010>0 || pp010>0 || dp010>0 || hp010>0 || pi010>0 || et010>0 || fc010>0) || t1==0)
   PAMD=[ss10 ss11 ss12 ss13;
    hy10 hy11 hy12 hy13;
    ph10 ph11 ph12 ph13;
    fc10 fc11 fc12 fc13;
    pp10 pp11 pp12 pp13;
    dp10 dp11 dp12 dp13;
    ep10 ep11 ep12 ep13;
    hp10 hp11 hp12 hp13]; %[checked or not, value, year in, year out]

OFAMD=[ec010 ec011 ec012 ec013;
    pp010 pp011 pp012 pp013;
    dp010 dp011 dp012 dp013;
    hp010 hp011 hp012 hp013
    pi010 pi011 pi012 pi013;
    et010 et011 et012 et013;
    fc010 fc011 fc012 fc013]; %[checked or not, value, year in, year out]

CC = [p rc vp r e rf y];

ICERT(1)=0;
icert_cons_pref;
icert_policy;
end


if ICERT(1)==2
    mchoose=msgbox('Consumer Preference and Policy Analysis complete! Please press Plot to view results.','CPPA');
    set( mchoose, 'color', [ 0.9 0.9 .9 ]) 
    set(handles.plot,'visible','on')
else
    set(handles.plot,'visible','off');
end


function plot_Callback(hObject, eventdata, handles)
global ICERT
if ICERT(1)==2
    plot_consumer
else
end
