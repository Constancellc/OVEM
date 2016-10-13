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

function resetcons_Callback(hObject, eventdata, handles)
set(handles.price,'string',0);
set(handles.rcost,'string',0);
set(handles.perf,'string',0);
set(handles.range,'string',0)
set(handles.emiss,'string',0);
set(handles.refuel,'string',0);
set(handles.total,'string',20);



function price_Callback(hObject, eventdata, handles)
p1 = get(handles.price,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.rcost,'String');
rc=str2num(rc1);
vp1 = get(handles.perf,'String');
vp=str2num(vp1);
r1 = get(handles.range,'String');
r=str2num(r1);
e1 = get(handles.emiss,'String');
e=str2num(e1);
rf1 = get(handles.refuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+vp+r+e+rf);
t=num2str(t1);


if  (isempty(p) || p < 0 || p > 20);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.price,'Value',0);
    set(handles.price,'String','0');
    mp=msgbox('Please insert a value between 0 to 20 for Purchase Price','Error Purchase Price');
    set( mp, 'color', [ 0.9 0.9 .9 ] )
else
end

if (t1<0)
    set(handles.price,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    p1 = get(handles.price,'String');
    p=str2num(p1);
    t1=20-(p+rc+vp+r+e+rf);
    t=num2str(t1);
    set(handles.total,'string',t);
elseif (t1==0||t1>0)
    set(handles.total,'string',t);
else
end
guidata(hObject, handles)


function price_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rcost_Callback(hObject, eventdata, handles)
p1 = get(handles.price,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.rcost,'String');
rc=str2num(rc1);
vp1 = get(handles.perf,'String');
vp=str2num(vp1);
r1 = get(handles.range,'String');
r=str2num(r1);
e1 = get(handles.emiss,'String');
e=str2num(e1);
rf1 = get(handles.refuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+vp+r+e+rf);
t=num2str(t1);

if  (isempty(rc)|| rc < 0 || rc > 20);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.rcost,'Value',0);
    set(handles.rcost,'String','0');
    mrc=msgbox('Please insert a value between 0 to 20 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
else
end

if (t1<0)
    set(handles.rcost,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rc1 = get(handles.rcost,'String');
    rc=str2num(rc1);
    t1=20-(p+rc+vp+r+e+rf);
    t=num2str(t1);
    set(handles.total,'string',t);
elseif (t1==0||t1>0)
    set(handles.total,'string',t);
else
end
guidata(hObject, handles)


function rcost_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function perf_Callback(hObject, eventdata, handles)
p1 = get(handles.price,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.rcost,'String');
rc=str2num(rc1);
vp1 = get(handles.perf,'String');
vp=str2num(vp1);
r1 = get(handles.range,'String');
r=str2num(r1);
e1 = get(handles.emiss,'String');
e=str2num(e1);
rf1 = get(handles.refuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+vp+r+e+rf)
t=num2str(t1)

if (isempty(vp) || vp < 0 || vp > 20);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.perf,'Value',0);
    set(handles.perf,'String','0');
    mvp=msgbox('Please insert a value between 0 to 20 for Vehicle Performance','Error Vehicle Performance');
    set( mvp, 'color', [ 0.9 0.9 .9 ] )
end

if (t1<0)
    set(handles.perf,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    vp1 = get(handles.perf,'String');
    vp=str2num(vp1);
    t1=20-(p+rc+vp+r+e+rf);
    t=num2str(t1);
    set(handles.total,'string',t);
elseif (t1==0||t1>0)
    set(handles.total,'string',t);
else
end
guidata(hObject, handles)



function perf_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range_Callback(hObject, eventdata, handles)
p1 = get(handles.price,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.rcost,'String');
rc=str2num(rc1);
vp1 = get(handles.perf,'String');
vp=str2num(vp1);
r1 = get(handles.range,'String');
r=str2num(r1);
e1 = get(handles.emiss,'String');
e=str2num(e1);
rf1 = get(handles.refuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+vp+r+e+rf)
t=num2str(t1)

if (isempty(r)|| r < 0 || r > 20);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.range,'Value',0);
    set(handles.range,'String','0');
    mr=msgbox('Please insert a value between 0 to 20 for Range','Error Range');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
end

if (t1<0)
    set(handles.range,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    r1 = get(handles.range,'String');
    r=str2num(r1);
    t1=20-(p+rc+vp+r+e+rf);
    t=num2str(t1);
    set(handles.total,'string',t);
elseif (t1==0||t1>0)
    set(handles.total,'string',t);
else
end
guidata(hObject, handles)



function range_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function emiss_Callback(hObject, eventdata, handles)
p1 = get(handles.price,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.rcost,'String');
rc=str2num(rc1);
vp1 = get(handles.perf,'String');
vp=str2num(vp1);
r1 = get(handles.range,'String');
r=str2num(r1);
e1 = get(handles.emiss,'String');
e=str2num(e1);
rf1 = get(handles.refuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+vp+r+e+rf)
t=num2str(t1)


if (isempty(e)|| e < 0 || e > 20);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.emiss,'Value',0);
    set(handles.emiss,'String','0');
    mr=msgbox('Please insert a value between 0 to 20 for Emissions','Error Emissions');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
end

if (t1<0)
    set(handles.emiss,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    e1 = get(handles.emiss,'String');
    e=str2num(e1);
    t1=20-(p+rc+vp+r+e+rf);
    t=num2str(t1);
    set(handles.total,'string',t);
elseif (t1==0||t1>0)
    set(handles.total,'string',t);
else
end
guidata(hObject, handles) 

function emiss_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function refuel_Callback(hObject, eventdata, handles)
p1 = get(handles.price,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.rcost,'String');
rc=str2num(rc1);
vp1 = get(handles.perf,'String');
vp=str2num(vp1);
r1 = get(handles.range,'String');
r=str2num(r1);
e1 = get(handles.emiss,'String');
e=str2num(e1);
rf1 = get(handles.refuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+vp+r+e+rf)
t=num2str(t1)


if (isempty(rf)|| rf < 0 || rf > 20);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.refuel,'Value',0);
    set(handles.refuel,'String','0');
    mr=msgbox('Please insert a value between 0 to 20 for Refuelling Availibility','Error Refuelling Availibility');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
end

if (t1<0)
    set(handles.refuel,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rf1 = get(handles.refuel,'String');
    rf=str2num(rf1);
    t1=20-(p+rc+vp+r+e+rf);
    t=num2str(t1);
    set(handles.total,'string',t);
elseif (t1==0||t1>0)
    set(handles.total,'string',t);
else
end
guidata(hObject, handles)

function refuel_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%policy controls



function sev_Callback(hObject, eventdata, handles)
a1=get(handles.sev,'value');
a2=get(handles.hy,'value');
a3=get(handles.ph,'value');
a4=get(handles.fc,'value');
a5=get(handles.petrol,'value');
a6=get(handles.diesel,'value');
a7=get(handles.electricity,'value');
a8=get(handles.hydrogen,'value');
if a1==1
    set(handles.sevsl,'visible','on');
    set(handles.sevvl,'visible','on');
    set(handles.sevyi,'visible','on');
    set(handles.sevyo,'visible','on');
    set(handles.text76,'visible','on');
elseif a1==0
    set(handles.sevsl,'visible','off');
    set(handles.sevvl,'visible','off');
    set(handles.sevyi,'visible','off');
    set(handles.sevyo,'visible','off');
    set(handles.text76,'visible','off');
    set(handles.sevsl,'value',0);
    set(handles.sevvl,'string','0');
    set(handles.sevyi,'string','2010');
    set(handles.sevyo,'string','2011');
    
    
end

if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1||a8==1)
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
end
    
    
function hy_Callback(hObject, eventdata, handles)
a1=get(handles.sev,'value');
a2=get(handles.hy,'value');
a3=get(handles.ph,'value');
a4=get(handles.fc,'value');
a5=get(handles.petrol,'value');
a6=get(handles.diesel,'value');
a7=get(handles.electricity,'value');
a8=get(handles.hydrogen,'value');
if a2==1
    set(handles.hysl,'visible','on');
    set(handles.hyvl,'visible','on');
    set(handles.hyyi,'visible','on');
    set(handles.hyyo,'visible','on');
    set(handles.text77,'visible','on');
elseif a2==0
    set(handles.hysl,'visible','off');
    set(handles.hyvl,'visible','off');
    set(handles.hyyi,'visible','off');
    set(handles.hyyo,'visible','off');
    set(handles.text77,'visible','off');
    set(handles.hysl,'value',0);
    set(handles.hyvl,'string','0');
    set(handles.hyyi,'string','2010');
    set(handles.hyyo,'string','2011');
end
if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1||a8==1)
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
end

function ph_Callback(hObject, eventdata, handles)
a1=get(handles.sev,'value');
a2=get(handles.hy,'value');
a3=get(handles.ph,'value');
a4=get(handles.fc,'value');
a5=get(handles.petrol,'value');
a6=get(handles.diesel,'value');
a7=get(handles.electricity,'value');
a8=get(handles.hydrogen,'value');
if a3==1
    set(handles.phsl,'visible','on');
    set(handles.phvl,'visible','on');
    set(handles.phyi,'visible','on');
    set(handles.phyo,'visible','on');
    set(handles.text78,'visible','on');
elseif a3==0
    set(handles.phsl,'visible','off');
    set(handles.phvl,'visible','off');
    set(handles.phyi,'visible','off');
    set(handles.phyo,'visible','off');
    set(handles.text78,'visible','off');
    set(handles.phsl,'value',0);
    set(handles.phvl,'string','0');
    set(handles.phyi,'string','2010');
    set(handles.phyo,'string','2011');
end
if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1||a8==1)
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
end

function fc_Callback(hObject, eventdata, handles)
a1=get(handles.sev,'value');
a2=get(handles.hy,'value');
a3=get(handles.ph,'value');
a4=get(handles.fc,'value');
a5=get(handles.petrol,'value');
a6=get(handles.diesel,'value');
a7=get(handles.electricity,'value');
a8=get(handles.hydrogen,'value');
if a4==1
    set(handles.fcsl,'visible','on');
    set(handles.fcvl,'visible','on');
    set(handles.fcyi,'visible','on');
    set(handles.fcyo,'visible','on');
    set(handles.text79,'visible','on');
elseif a4==0
    set(handles.fcsl,'visible','off');
    set(handles.fcvl,'visible','off');
    set(handles.fcyi,'visible','off');
    set(handles.fcyo,'visible','off');
    set(handles.text79,'visible','off');
    set(handles.fcsl,'value',0);
    set(handles.fcvl,'string','0');
    set(handles.fcyi,'string','2010');
    set(handles.fcyo,'string','2011');
end
if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1||a8==1)
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
end

function petrol_Callback(hObject, eventdata, handles)
a1=get(handles.sev,'value');
a2=get(handles.hy,'value');
a3=get(handles.ph,'value');
a4=get(handles.fc,'value');
a5=get(handles.petrol,'value');
a6=get(handles.diesel,'value');
a7=get(handles.electricity,'value');
a8=get(handles.hydrogen,'value');
if a5==1
    set(handles.psl,'visible','on');
    set(handles.pvl,'visible','on');
    set(handles.pyi,'visible','on');
    set(handles.pyo,'visible','on');
    set(handles.text80,'visible','on');
elseif a5==0
    set(handles.psl,'visible','off');
    set(handles.pvl,'visible','off');
    set(handles.pyi,'visible','off');
    set(handles.pyo,'visible','off');
    set(handles.text80,'visible','off');
    set(handles.psl,'value',0);
    set(handles.pvl,'string','0');
    set(handles.pyi,'string','2010');
    set(handles.pyo,'string','2011');
end
if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1||a8==1)
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
end

function diesel_Callback(hObject, eventdata, handles)
a1=get(handles.sev,'value');
a2=get(handles.hy,'value');
a3=get(handles.ph,'value');
a4=get(handles.fc,'value');
a5=get(handles.petrol,'value');
a6=get(handles.diesel,'value');
a7=get(handles.electricity,'value');
a8=get(handles.hydrogen,'value');
if a6==1
    set(handles.dsl,'visible','on');
    set(handles.dvl,'visible','on');
    set(handles.dyi,'visible','on');
    set(handles.dyo,'visible','on');
    set(handles.text81,'visible','on');
elseif a6==0
    set(handles.dsl,'visible','off');
    set(handles.dvl,'visible','off');
    set(handles.dyi,'visible','off');
    set(handles.dyo,'visible','off');
    set(handles.text81,'visible','off');
    set(handles.dsl,'value',0);
    set(handles.dvl,'string','0');
    set(handles.dyi,'string','2010');
    set(handles.dyo,'string','2011');
end

if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1||a8==1)
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
end

function electricity_Callback(hObject, eventdata, handles)
a1=get(handles.sev,'value');
a2=get(handles.hy,'value');
a3=get(handles.ph,'value');
a4=get(handles.fc,'value');
a5=get(handles.petrol,'value');
a6=get(handles.diesel,'value');
a7=get(handles.electricity,'value');
a8=get(handles.hydrogen,'value');
if a7==1
    set(handles.esl,'visible','on');
    set(handles.evl,'visible','on');
    set(handles.eyi,'visible','on');
    set(handles.eyo,'visible','on');
    set(handles.text82,'visible','on');
elseif a7==0
    set(handles.esl,'visible','off');
    set(handles.evl,'visible','off');
    set(handles.eyi,'visible','off');
    set(handles.eyo,'visible','off');
    set(handles.text82,'visible','off');
    set(handles.esl,'value',0);
    set(handles.evl,'string','0');
    set(handles.eyi,'string','2010');
    set(handles.eyo,'string','2011');
end
if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1||a8==1)
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
end

function hydrogen_Callback(hObject, eventdata, handles)
a1=get(handles.sev,'value');
a2=get(handles.hy,'value');
a3=get(handles.ph,'value');
a4=get(handles.fc,'value');
a5=get(handles.petrol,'value');
a6=get(handles.diesel,'value');
a7=get(handles.electricity,'value');
a8=get(handles.hydrogen,'value');
if a8==1
    set(handles.hsl,'visible','on');
    set(handles.hvl,'visible','on');
    set(handles.hyi,'visible','on');
    set(handles.hyo,'visible','on');
    set(handles.text83,'visible','on');
elseif a8==0
    set(handles.hsl,'visible','off');
    set(handles.hvl,'visible','off');
    set(handles.hyi,'visible','off');
    set(handles.hyo,'visible','off');
    set(handles.text83,'visible','off');
    set(handles.hsl,'value',0);
    set(handles.hvl,'string','0');
    set(handles.hyi,'string','2010');
    set(handles.hyo,'string','2011');
end
if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1||a8==1)
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
end



%slider, value, years for PAMD


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
vl = get(handles.sevvl,'String');%get the string for the editText component
vl1 = str2num(vl);%convert from string to number if possible, otherwise returns empty


if (isempty(vl1) || vl1 < 0 || vl1 > 10000)  %if user inputs something is not a number, or if the input is less than or greater than 10000, then the slider value defaults to 0
    set(handles.sevsl,'Value',0);
    set(handles.sevvl,'String','0');
else
    set(handles.sevsl,'Value',vl1);
end

function sevvl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function sevyi_Callback(hObject, eventdata, handles)
syi1 = get(handles.sevyi,'string');
syi = str2num(syi1);
syo1 = get(handles.sevyo,'string');
syo = str2num(syo1);

if(syo<syi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
         set(handles.sevyi,'string','2010');

elseif(syi<2010)
    my=msgbox('The policy year in cannot be smaller than 2010', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.sevyi,'string','2010');
end

function sevyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function sevyo_Callback(hObject, eventdata, handles)
syi1 = get(handles.sevyi,'string');
syi = str2num(syi1);
syo1 = get(handles.sevyo,'string');
syo = str2num(syo1);
cy1 = get(handles.finalyear,'string');
cy = str2num(cy1);

if(syo<syi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
elseif(syo>cy)
    my=msgbox('The policy year out cannot be greater than the final simulation year', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.sevyo,'string',cy)
end

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
vl = get(handles.hyvl,'String');%get the string for the editText component
vl1 = str2num(vl);%convert from string to number if possible, otherwise returns empty


if (isempty(vl1) || vl1 < 0 || vl1 > 10000)  %if user inputs something is not a number, or if the input is less than or greater than 10000, then the slider value defaults to 0
    set(handles.hysl,'Value',0);
    set(handles.hyvl,'String','0');
else
    set(handles.hysl,'Value',vl1);
end

function hyvl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function hyyi_Callback(hObject, eventdata, handles)
syi1 = get(handles.hyyi,'string');
syi = str2num(syi1);
syo1 = get(handles.hyyo,'string');
syo = str2num(syo1);

if(syo<syi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.hyyi,'string','2010');

elseif(syi<2010)
    my=msgbox('The policy year in cannot be smaller than 2010', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.hyyi,'string','2010');
end
        

function hyyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function hyyo_Callback(hObject, eventdata, handles)
pyi1 = get(handles.hyyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.hyyo,'string');
pyo = str2num(pyo1);
cy1 = get(handles.finalyear,'string');
cy = str2num(cy1);
   
if(pyo<pyi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.hyyo,'string',cy);
elseif(pyo>cy)
    my=msgbox('The policy year out cannot be greater than the final simulation year', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.hyyo,'string',cy);
end

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
vl = get(handles.phvl,'String');%get the string for the editText component
vl1 = str2num(vl);%convert from string to number if possible, otherwise returns empty


if (isempty(vl1) || vl1 < 0 || vl1 > 10000)  %if user inputs something is not a number, or if the input is less than or greater than 10000, then the slider value defaults to 0
    set(handles.phsl,'Value',0);
    set(handles.phvl,'String','0');
else
    set(handles.phsl,'Value',vl1);
end

function phvl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function phyi_Callback(hObject, eventdata, handles)
syi1 = get(handles.phyi,'string');
syi = str2num(syi1);
syo1 = get(handles.phyo,'string');
syo = str2num(syo1);

if(syo<syi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.phyi,'string','2010');

elseif(syi<2010)
    my=msgbox('The policy year in cannot be smaller than 2010', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.phyi,'string','2010');
end
        

function phyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function phyo_Callback(hObject, eventdata, handles)
pyi1 = get(handles.phyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.phyo,'string');
pyo = str2num(pyo1);
cy1 = get(handles.finalyear,'string');
cy = str2num(cy1);


if(pyo<pyi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.phyo,'string',cy);
elseif(pyo>cy)
    my=msgbox('The policy year out cannot be greater than the final simulation year', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.phyo,'string',cy);
end

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
vl = get(handles.fcvl,'String');%get the string for the editText component
vl1 = str2num(vl);%convert from string to number if possible, otherwise returns empty


if (isempty(vl1) || vl1 < 0 || vl1 > 10000)  %if user inputs something is not a number, or if the input is less than or greater than 10000, then the slider value defaults to 0
    set(handles.fcsl,'Value',0);
    set(handles.fcvl,'String','0');
else
    set(handles.fcsl,'Value',vl1);
end

function fcvl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fcyi_Callback(hObject, eventdata, handles)
syi1 = get(handles.fcyi,'string');
syi = str2num(syi1);
syo1 = get(handles.fcyo,'string');
syo = str2num(syo1);

if(syo<syi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.fcyi,'string','2010');

elseif(syi<2010)
    my=msgbox('The policy year in cannot be smaller than 2010', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.fcyi,'string','2010');
end
        

function fcyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fcyo_Callback(hObject, eventdata, handles)
pyi1 = get(handles.fcyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.fcyo,'string');
pyo = str2num(pyo1);
cy1 = get(handles.finalyear,'string');
cy = str2num(cy1);

if(pyo<pyi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.fcyo,'string',cy);
elseif(pyo>cy)
    my=msgbox('The policy year out cannot be greater than the final simulation year', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.fcyo,'string',cy);
end

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
vl = get(handles.pvl,'String');%get the string for the editText component
vl1 = str2num(vl);%convert from string to number if possible, otherwise returns empty


if (isempty(vl1) || vl1 < 0 || vl1 > 10000)  %if user inputs something is not a number, or if the input is less than or greater than 10000, then the slider value defaults to 0
    set(handles.psl,'Value',0);
    set(handles.pvl,'String','0');
else
    set(handles.psl,'Value',vl1);
end

function pvl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pyi_Callback(hObject, eventdata, handles)
syi1 = get(handles.pyi,'string');
syi = str2num(syi1);
syo1 = get(handles.pyo,'string');
syo = str2num(syo1);

if(syo<syi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.pyi,'string','2010');

elseif(syi<2010)
    my=msgbox('The policy year in cannot be smaller than 2010', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.pyi,'string','2010');
end

function pyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pyo_Callback(hObject, eventdata, handles)
pyi1 = get(handles.pyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.pyo,'string');
pyo = str2num(pyo1);
cy1 = get(handles.finalyear,'string');
cy = str2num(cy1);

if(pyo<pyi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.pyo,'string',cy);
elseif(pyo>cy)
    my=msgbox('The policy year out cannot be greater than the final simulation year', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.pyo,'string',cy);
end

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
vl = get(handles.dvl,'String');%get the string for the editText component
vl1 = str2num(vl);%convert from string to number if possible, otherwise returns empty


if (isempty(vl1) || vl1 < 0 || vl1 > 10000)  %if user inputs something is not a number, or if the input is less than or greater than 10000, then the slider value defaults to 0
    set(handles.dsl,'Value',0);
    set(handles.dvl,'String','0');
else
    set(handles.dsl,'Value',vl1);
end

function dvl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function dyi_Callback(hObject, eventdata, handles)
syi1 = get(handles.dyi,'string');
syi = str2num(syi1);
syo1 = get(handles.dyo,'string');
syo = str2num(syo1);

if(syo<syi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.dyi,'string','2010');

elseif(syi<2010)
    my=msgbox('The policy year in cannot be smaller than 2010', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.dyi,'string','2010');
end

function dyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function dyo_Callback(hObject, eventdata, handles)
pyi1 = get(handles.dyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.dyo,'string');
pyo = str2num(pyo1);
cy1 = get(handles.finalyear,'string');
cy = str2num(cy1);

if(pyo<pyi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.dyo,'string',cy);
        
elseif(pyo>cy)
    my=msgbox('The policy year out cannot be greater than the final simulation year', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.dyo,'string',cy);
end

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
vl = get(handles.evl,'String');%get the string for the editText component
vl1 = str2num(vl);%convert from string to number if possible, otherwise returns empty


if (isempty(vl1) || vl1 < 0 || vl1 > 10000)  %if user inputs something is not a number, or if the input is less than or greater than 10000, then the slider value defaults to 0
    set(handles.esl,'Value',0);
    set(handles.evl,'String','0');
else
    set(handles.esl,'Value',vl1);
end

function evl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function eyi_Callback(hObject, eventdata, handles)
syi1 = get(handles.eyi,'string');
syi = str2num(syi1);
syo1 = get(handles.eyo,'string');
syo = str2num(syo1);

if(syo<syi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.eyi,'string','2010');

elseif(syi<2010)
    my=msgbox('The policy year in cannot be smaller than 2010', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.eyi,'string','2010');
end

function eyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function eyo_Callback(hObject, eventdata, handles)
pyi1 = get(handles.eyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.eyo,'string');
pyo = str2num(pyo1);
cy1 = get(handles.finalyear,'string');
cy = str2num(cy1);

if(pyo<pyi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
         set(handles.eyo,'string',cy);
elseif(pyo>cy)
    my=msgbox('The policy year out cannot be greater than the final simulation year', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.eyo,'string',cy);
end

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
vl = get(handles.hvl,'String');%get the string for the editText component
vl1 = str2num(vl);%convert from string to number if possible, otherwise returns empty


if (isempty(vl1) || vl1 < 0 || vl1 > 10000)  %if user inputs something is not a number, or if the input is less than or greater than 10000, then the slider value defaults to 0
    set(handles.hsl,'Value',0);
    set(handles.hvl,'String','0');
else
    set(handles.hsl,'Value',vl1);
end

function hvl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function hyi_Callback(hObject, eventdata, handles)
syi1 = get(handles.hyi,'string');
syi = str2num(syi1);
syo1 = get(handles.hyo,'string');
syo = str2num(syo1);

if(syo<syi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] );
        set(handles.hyi,'string','2010');

elseif(syi<2010)
    my=msgbox('The policy year in cannot be smaller than 2010', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] );
        set(handles.hyi,'string','2010');
end

function hyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function hyo_Callback(hObject, eventdata, handles)
pyi1 = get(handles.hyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.hyo,'string');
pyo = str2num(pyo1);
cy1 = get(handles.finalyear,'string');
cy = str2num(cy1);

if(pyo<pyi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.hyo,'string',cy);
elseif(pyo>cy)
    my=msgbox('The policy year out cannot be greater than the final simulation year', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.hyo,'string',cy);
end

function hyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%other factors



function nceg_Callback(hObject, eventdata, handles)
a1=get(handles.nceg,'value');
a2=get(handles.pti,'value');
a3=get(handles.dti,'value');
a4=get(handles.hti,'value');
a5=get(handles.pihti,'value');
a6=get(handles.eti,'value');
a7=get(handles.fcti,'value');
if a1==1
    set(handles.ncegsl,'visible','on');
    set(handles.ncegvl,'visible','on');
    set(handles.ncegyi,'visible','on');
    set(handles.ncegyo,'visible','on');
    set(handles.text84,'visible','on');
elseif a1==0
    set(handles.ncegsl,'visible','off');
    set(handles.ncegvl,'visible','off');
    set(handles.ncegyi,'visible','off');
    set(handles.ncegyo,'visible','off');
    set(handles.text84,'visible','off');
    set(handles.ncegsl,'value',0);
    set(handles.ncegvl,'string','0');
    set(handles.ncegyi,'string','2010');
    set(handles.ncegyo,'string','2011');
end

if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1)
    set(handles.yiof,'visible','on')
    set(handles.yoof,'visible','on')
else
    set(handles.yiof,'visible','off')
    set(handles.yoof,'visible','off')
end

    
function pti_Callback(hObject, eventdata, handles)
a1=get(handles.nceg,'value');
a2=get(handles.pti,'value');
a3=get(handles.dti,'value');
a4=get(handles.hti,'value');
a5=get(handles.pihti,'value');
a6=get(handles.eti,'value');
a7=get(handles.fcti,'value');
if a2==1
    set(handles.ptisl,'visible','on');
    set(handles.ptivl,'visible','on');
    set(handles.ptiyi,'visible','on');
    set(handles.ptiyo,'visible','on');
    set(handles.text85,'visible','on');
elseif a2==0
    set(handles.ptisl,'visible','off');
    set(handles.ptivl,'visible','off');
    set(handles.ptiyi,'visible','off');
    set(handles.ptiyo,'visible','off');
    set(handles.text85,'visible','off');
    set(handles.ptisl,'value',0);
    set(handles.ptivl,'string','0');
    set(handles.ptiyi,'string','2010');
    set(handles.ptiyo,'string','2011');
end

if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1)
    set(handles.yiof,'visible','on')
    set(handles.yoof,'visible','on')
else
    set(handles.yiof,'visible','off')
    set(handles.yoof,'visible','off')
end

function dti_Callback(hObject, eventdata, handles)
a1=get(handles.nceg,'value');
a2=get(handles.pti,'value');
a3=get(handles.dti,'value');
a4=get(handles.hti,'value');
a5=get(handles.pihti,'value');
a6=get(handles.eti,'value');
a7=get(handles.fcti,'value');
if a3==1
    set(handles.dtisl,'visible','on');
    set(handles.dtivl,'visible','on');
    set(handles.dtiyi,'visible','on');
    set(handles.dtiyo,'visible','on');
    set(handles.text86,'visible','on');
elseif a3==0
    set(handles.dtisl,'visible','off');
    set(handles.dtivl,'visible','off');
    set(handles.dtiyi,'visible','off');
    set(handles.dtiyo,'visible','off');
    set(handles.text86,'visible','off');
    set(handles.dtisl,'value',0);
    set(handles.dtivl,'string','0');
    set(handles.dtiyi,'string','2010');
    set(handles.dtiyo,'string','2011');
end

if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1)
    set(handles.yiof,'visible','on')
    set(handles.yoof,'visible','on')
else
    set(handles.yiof,'visible','off')
    set(handles.yoof,'visible','off')
end


function hti_Callback(hObject, eventdata, handles)
a1=get(handles.nceg,'value');
a2=get(handles.pti,'value');
a3=get(handles.dti,'value');
a4=get(handles.hti,'value');
a5=get(handles.pihti,'value');
a6=get(handles.eti,'value');
a7=get(handles.fcti,'value');
if a4==1
    set(handles.htisl,'visible','on');
    set(handles.htivl,'visible','on');
    set(handles.htiyi,'visible','on');
    set(handles.htiyo,'visible','on');
    set(handles.text87,'visible','on');
elseif a4==0
    set(handles.htisl,'visible','off');
    set(handles.htivl,'visible','off');
    set(handles.htiyi,'visible','off');
    set(handles.htiyo,'visible','off');
    set(handles.text87,'visible','off');
    set(handles.htisl,'value',0);
    set(handles.htivl,'string','0');
    set(handles.htiyi,'string','2010');
    set(handles.htiyo,'string','2011');
end

if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1)
    set(handles.yiof,'visible','on')
    set(handles.yoof,'visible','on')
else
    set(handles.yiof,'visible','off')
    set(handles.yoof,'visible','off')
end

function pihti_Callback(hObject, eventdata, handles)
a1=get(handles.nceg,'value');
a2=get(handles.pti,'value');
a3=get(handles.dti,'value');
a4=get(handles.hti,'value');
a5=get(handles.pihti,'value');
a6=get(handles.eti,'value');
a7=get(handles.fcti,'value');
if a5==1
    set(handles.pihtisl,'visible','on');
    set(handles.pihtivl,'visible','on');
    set(handles.pihtiyi,'visible','on');
    set(handles.pihtiyo,'visible','on');
    set(handles.text88,'visible','on');
elseif a5==0
    set(handles.pihtisl,'visible','off');
    set(handles.pihtivl,'visible','off');
    set(handles.pihtiyi,'visible','off');
    set(handles.pihtiyo,'visible','off');
    set(handles.text88,'visible','off');
    set(handles.pihtisl,'value',0);
    set(handles.pihtivl,'string','0');
    set(handles.pihtiyi,'string','2010');
    set(handles.pihtiyo,'string','2011');
end

if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1)
    set(handles.yiof,'visible','on')
    set(handles.yoof,'visible','on')
else
    set(handles.yiof,'visible','off')
    set(handles.yoof,'visible','off')
end

function eti_Callback(hObject, eventdata, handles)
a1=get(handles.nceg,'value');
a2=get(handles.pti,'value');
a3=get(handles.dti,'value');
a4=get(handles.hti,'value');
a5=get(handles.pihti,'value');
a6=get(handles.eti,'value');
a7=get(handles.fcti,'value');
if a6==1
    set(handles.etisl,'visible','on');
    set(handles.etivl,'visible','on');
    set(handles.etiyi,'visible','on');
    set(handles.etiyo,'visible','on');
    set(handles.text89,'visible','on');
elseif a6==0
    set(handles.etisl,'visible','off');
    set(handles.etivl,'visible','off');
    set(handles.etiyi,'visible','off');
    set(handles.etiyo,'visible','off');
    set(handles.text89,'visible','off');
    set(handles.etisl,'value',0);
    set(handles.etivl,'string','0');
    set(handles.etiyi,'string','2010');
    set(handles.etiyo,'string','2011');
end

if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1)
    set(handles.yiof,'visible','on')
    set(handles.yoof,'visible','on')
else
    set(handles.yiof,'visible','off')
    set(handles.yoof,'visible','off')
end

function fcti_Callback(hObject, eventdata, handles)
a1=get(handles.nceg,'value');
a2=get(handles.pti,'value');
a3=get(handles.dti,'value');
a4=get(handles.hti,'value');
a5=get(handles.pihti,'value');
a6=get(handles.eti,'value');
a7=get(handles.fcti,'value');
if a7==1
    set(handles.fctisl,'visible','on');
    set(handles.fctivl,'visible','on');
    set(handles.fctiyi,'visible','on');
    set(handles.fctiyo,'visible','on');
    set(handles.text90,'visible','on');
elseif a7==0
    set(handles.fctisl,'visible','off');
    set(handles.fctivl,'visible','off');
    set(handles.fctiyi,'visible','off');
    set(handles.fctiyo,'visible','off');
    set(handles.text90,'visible','off');
    set(handles.fctisl,'value',0);
    set(handles.fctivl,'string','0');
    set(handles.fctiyi,'string','2010');
    set(handles.fctiyo,'string','2011');
end

if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1)
    set(handles.yiof,'visible','on')
    set(handles.yoof,'visible','on')
else
    set(handles.yiof,'visible','off')
    set(handles.yoof,'visible','off')
end



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
vl = get(handles.ncegvl,'String');%get the string for the editText component
vl1 = str2num(vl);%convert from string to number if possible, otherwise returns empty


if (isempty(vl1) || vl1 < 0 || vl1 > 100)  %if user inputs something is not a number, or if the input is less than or greater than 10000, then the slider value defaults to 0
    set(handles.ncegsl,'Value',0);
    set(handles.ncegvl,'String','0');
else
    set(handles.ncegsl,'Value',vl1);
end

function ncegvl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ncegyi_Callback(hObject, eventdata, handles)
syi1 = get(handles.ncegyi,'string');
syi = str2num(syi1);
syo1 = get(handles.ncegyo,'string');
syo = str2num(syo1);

if(syo<syi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] );
        set(handles.ncegyi,'string','2010');

elseif(syi<2010)
    my=msgbox('The policy year in cannot be smaller than 2010', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] );
        set(handles.ncegyi,'string','2010');
end

function ncegyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ncegyo_Callback(hObject, eventdata, handles)
pyi1 = get(handles.ncegyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.ncegyo,'string');
pyo = str2num(pyo1);
cy1 = get(handles.finalyear,'string');
cy = str2num(cy1);

if(pyo<pyi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.ncegyo,'string',cy);
elseif(pyo>cy)
    my=msgbox('The policy year out cannot be greater than the final simulation year', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.ncegyo,'string',cy);
end

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
vl = get(handles.ptivl,'String');%get the string for the editText component
vl1 = str2num(vl);%convert from string to number if possible, otherwise returns empty


if (isempty(vl1) || vl1 < 0 || vl1 > 100)  %if user inputs something is not a number, or if the input is less than or greater than 10000, then the slider value defaults to 0
    set(handles.ptisl,'Value',0);
    set(handles.ptivl,'String','0');
else
    set(handles.ptisl,'Value',vl1);
end

function ptivl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ptiyi_Callback(hObject, eventdata, handles)
syi1 = get(handles.ptiyi,'string');
syi = str2num(syi1);
syo1 = get(handles.ptiyo,'string');
syo = str2num(syo1);

if(syo<syi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] );
        set(handles.ptiyi,'string','2010');

elseif(syi<2010)
    my=msgbox('The policy year in cannot be smaller than 2010', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] );
        set(handles.ptiyi,'string','2010');
end

function ptiyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ptiyo_Callback(hObject, eventdata, handles)
pyi1 = get(handles.ptiyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.ptiyo,'string');
pyo = str2num(pyo1);
cy1 = get(handles.finalyear,'string');
cy = str2num(cy1);

if(pyo<pyi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.ptiyo,'string',cy);
elseif(pyo>cy)
    my=msgbox('The policy year out cannot be greater than the final simulation year', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.ptiyo,'string',cy);
end

function ptiyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function dtivl_Callback(hObject, eventdata, handles)
vl = get(handles.dtivl,'String');%get the string for the editText component
vl1 = str2num(vl);%convert from string to number if possible, otherwise returns empty


if (isempty(vl1) || vl1 < 0 || vl1 > 100)  %if user inputs something is not a number, or if the input is less than or greater than 10000, then the slider value defaults to 0
    set(handles.dtisl,'Value',0);
    set(handles.dtivl,'String','0');
else
    set(handles.dtisl,'Value',vl1);
end

function dtivl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function dtiyi_Callback(hObject, eventdata, handles)
syi1 = get(handles.dtiyi,'string');
syi = str2num(syi1);
syo1 = get(handles.dtiyo,'string');
syo = str2num(syo1);

if(syo<syi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] );
        set(handles.dtiyi,'string','2010');

elseif(syi<2010)
    my=msgbox('The policy year in cannot be smaller than 2010', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] );
        set(handles.dtiyi,'string','2010');
end

function dtiyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function dtiyo_Callback(hObject, eventdata, handles)
pyi1 = get(handles.dtiyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.dtiyo,'string');
pyo = str2num(pyo1);
cy1 = get(handles.finalyear,'string');
cy = str2num(cy1);

if(pyo<pyi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.dtiyo,'string',cy);
elseif(pyo>cy)
    my=msgbox('The policy year out cannot be greater than the final simulation year', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.dtiyo,'string',cy);
end

function dtiyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function htivl_Callback(hObject, eventdata, handles)
vl = get(handles.htivl,'String');%get the string for the editText component
vl1 = str2num(vl);%convert from string to number if possible, otherwise returns empty


if (isempty(vl1) || vl1 < 0 || vl1 > 100)  %if user inputs something is not a number, or if the input is less than or greater than 10000, then the slider value defaults to 0
    set(handles.htisl,'Value',0);
    set(handles.htivl,'String','0');
else
    set(handles.htisl,'Value',vl1);
end

function htivl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function htiyi_Callback(hObject, eventdata, handles)
syi1 = get(handles.htiyi,'string');
syi = str2num(syi1);
syo1 = get(handles.htiyo,'string');
syo = str2num(syo1);

if(syo<syi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] );
         set(handles.htiyi,'string','2010');

elseif(syi<2010)
    my=msgbox('The policy year in cannot be smaller than 2010', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] );
        set(handles.htiyi,'string','2010');
end

function htiyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function htiyo_Callback(hObject, eventdata, handles)
pyi1 = get(handles.htiyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.htiyo,'string');
pyo = str2num(pyo1);
cy1 = get(handles.finalyear,'string');
cy = str2num(cy1);

if(pyo<pyi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.htiyo,'string',cy);
elseif(pyo>cy)
    my=msgbox('The policy year out cannot be greater than the final simulation year', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.htiyo,'string',cy);
end

function htiyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pihtivl_Callback(hObject, eventdata, handles)
vl = get(handles.pihtivl,'String');%get the string for the editText component
vl1 = str2num(vl);%convert from string to number if possible, otherwise returns empty


if (isempty(vl1) || vl1 < 0 || vl1 > 100)  %if user inputs something is not a number, or if the input is less than or greater than 10000, then the slider value defaults to 0
    set(handles.pihtisl,'Value',0);
    set(handles.pihtivl,'String','0');
else
    set(handles.pihtisl,'Value',vl1);
end

function pihtivl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pihtiyi_Callback(hObject, eventdata, handles)
syi1 = get(handles.pihtiyi,'string');
syi = str2num(syi1);
syo1 = get(handles.pihtiyo,'string');
syo = str2num(syo1);

if(syo<syi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] );
        set(handles.pihtiyi,'string','2010');

elseif(syi<2010)
    my=msgbox('The policy year in cannot be smaller than 2010', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] );
        set(handles.pihtiyi,'string','2010');
end

function pihtiyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pihtiyo_Callback(hObject, eventdata, handles)
pyi1 = get(handles.pihtiyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.pihtiyo,'string');
pyo = str2num(pyo1);
cy1 = get(handles.finalyear,'string');
cy = str2num(cy1);

if(pyo<pyi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.pihtiyo,'string',cy);
elseif(pyo>cy)
    my=msgbox('The policy year out cannot be greater than the final simulation year', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.pihtiyo,'string',cy);
end

function pihtiyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function etivl_Callback(hObject, eventdata, handles)
vl = get(handles.etivl,'String');%get the string for the editText component
vl1 = str2num(vl);%convert from string to number if possible, otherwise returns empty


if (isempty(vl1) || vl1 < 0 || vl1 > 100)  %if user inputs something is not a number, or if the input is less than or greater than 10000, then the slider value defaults to 0
    set(handles.etisl,'Value',0);
    set(handles.etivl,'String','0');
else
    set(handles.etisl,'Value',vl1);
end

function etivl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function etiyi_Callback(hObject, eventdata, handles)
syi1 = get(handles.etiyi,'string');
syi = str2num(syi1);
syo1 = get(handles.etiyo,'string');
syo = str2num(syo1);

if(syo<syi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] );
         set(handles.etiyi,'string','2010');

elseif(syi<2010)
    my=msgbox('The policy year in cannot be smaller than 2010', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] );
        set(handles.etiyi,'string','2010');
end

function etiyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function etiyo_Callback(hObject, eventdata, handles)
pyi1 = get(handles.etiyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.etiyo,'string');
pyo = str2num(pyo1);
cy1 = get(handles.finalyear,'string');
cy = str2num(cy1);

if(pyo<pyi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.etiyo,'string',cy);
elseif(pyo>cy)
    my=msgbox('The policy year out cannot be greater than the final simulation year', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.etiyo,'string',cy);
end

function etiyo_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fctivl_Callback(hObject, eventdata, handles)
vl = get(handles.fctivl,'String');%get the string for the editText component
vl1 = str2num(vl);%convert from string to number if possible, otherwise returns empty


if (isempty(vl1) || vl1 < 0 || vl1 > 100)  %if user inputs something is not a number, or if the input is less than or greater than 10000, then the slider value defaults to 0
    set(handles.fctisl,'Value',0);
    set(handles.fctivl,'String','0');
else
    set(handles.fctisl,'Value',vl1);
end

function fctivl_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fctiyi_Callback(hObject, eventdata, handles)
syi1 = get(handles.fctiyi,'string');
syi = str2num(syi1);
syo1 = get(handles.fctiyo,'string');
syo = str2num(syo1);

if(syo<syi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] );
        set(handles.fctiyi,'string','2010');

elseif(syi<2010)
    my=msgbox('The policy year in cannot be smaller than 2010', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] );
        set(handles.fctiyi,'string','2010');
end

function fctiyi_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fctiyo_Callback(hObject, eventdata, handles)
pyi1 = get(handles.fctiyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.fctiyo,'string');
pyo = str2num(pyo1);
cy1 = get(handles.finalyear,'string');
cy = str2num(cy1);

if(pyo<pyi)
    my=msgbox('The policy year out cannot be smaller than the year in', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.fctiyo,'string',cy);
elseif(pyo>cy)
    my=msgbox('The policy year out cannot be greater than the final simulation year', 'Error Policy Year');
        set( my, 'color', [ 0.9 0.9 .9 ] )
        set(handles.fctiyo,'string',cy);
end
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
ss11=str2num(ss1);
ss2=get(handles.sevyi,'string');
ss12=str2num(ss2);
ss3=get(handles.sevyo,'string');
ss13=str2num(ss3);

hy10=get(handles.hy,'value');
hy1=get(handles.hyvl,'string');
hy11=str2num(hy1);
hy2=get(handles.hyyi,'string');
hy12=str2num(hy2);
hy3=get(handles.hyyo,'string');
hy13=str2num(hy3);

ph10=get(handles.ph,'value');
ph1=get(handles.phvl,'string');
ph11=str2num(ph1);
ph2=get(handles.phyi,'string');
ph12=str2num(ph2);
ph3=get(handles.phyo,'string');
ph13=str2num(ph3);

fc10=get(handles.fc,'value');
fc1=get(handles.fcvl,'string');
fc11=str2num(fc1);
fc2=get(handles.fcyi,'string');
fc12=str2num(fc2);
fc3=get(handles.fcyo,'string');
fc13=str2num(fc3);

pp10=get(handles.petrol,'value');
pp1=get(handles.pvl,'string');
pp11=str2num(pp1);
pp2=get(handles.pyi,'string');
pp12=str2num(pp2);
pp3=get(handles.pyo,'string');
pp13=str2num(pp3);

dp10=get(handles.diesel,'value');
dp1=get(handles.dvl,'string');
dp11=str2num(dp1);
dp2=get(handles.dyi,'string');
dp12=str2num(dp2);
dp3=get(handles.dyo,'string');
dp13=str2num(dp3);

ep10=get(handles.electricity,'value');
ep1=get(handles.evl,'string');
ep11=str2num(ep1);
ep2=get(handles.eyi,'string');
ep12=str2num(ep2);
ep3=get(handles.eyo,'string');
ep13=str2num(ep3);

hp10=get(handles.hydrogen,'value');
hp1=get(handles.hvl,'string');
hp11=str2num(hp1);
hp2=get(handles.hyi,'string');
hp12=str2num(hp2);
hp3=get(handles.hyo,'string');
hp13=str2num(hp3);

    
%getting values of OFAMD

ec010=get(handles.nceg,'value');
ec01=get(handles.ncegvl,'string');
ec011=str2num(ec01);
ec02=get(handles.ncegyi,'string');
ec012=str2num(ec02);
ec03=get(handles.ncegyo,'string');
ec013=str2num(ec03);

pp010=get(handles.pti,'value');
pp01=get(handles.ptivl,'string');
pp011=str2num(pp01);
pp02=get(handles.ptiyi,'string');
pp012=str2num(pp02);
pp03=get(handles.ptiyo,'string');
pp013=str2num(pp03);

dp010=get(handles.dti,'value');
dp01=get(handles.dtivl,'string');
dp011=str2num(dp01);
dp02=get(handles.dtiyi,'string');
dp012=str2num(dp02);
dp03=get(handles.dtiyo,'string');
dp013=str2num(dp03);

hp010=get(handles.hti,'value');
hp01=get(handles.htivl,'string');
hp011=str2num(hp01);
hp02=get(handles.htiyi,'string');
hp012=str2num(hp02);
hp03=get(handles.htiyo,'string');
hp013=str2num(hp03);

pi010=get(handles.pihti,'value');
pi01=get(handles.pihtivl,'string');
pi011=str2num(pi01);
pi02=get(handles.pihtiyi,'string');
pi012=str2num(pi02);
pi03=get(handles.pihtiyo,'string');
pi013=str2num(pi03);

et010=get(handles.eti,'value');
et01=get(handles.etivl,'string');
et011=str2num(et01);
et02=get(handles.etiyi,'string');
et012=str2num(et02);
et03=get(handles.etiyo,'string');
et013=str2num(et03);

fc010=get(handles.fcti,'value');
fc01=get(handles.fctivl,'string');
fc011=str2num(fc01);
fc02=get(handles.fctiyi,'string');
fc012=str2num(fc02);
fc03=get(handles.fctiyo,'string');
fc013=str2num(fc03);



%%%%%%%%%%%%%%%%%%%%%%%%%
%set CC

p1 = get(handles.price,'String');
p=str2num(p1);
rc1 = get(handles.rcost,'String');
rc=str2num(rc1);
vp1 = get(handles.perf,'String');
vp=str2num(vp1);
r1 = get(handles.range,'String');
r=str2num(r1);
e1 = get(handles.emiss,'String');
e=str2num(e1);
rf1 = get(handles.refuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+vp+r+e+rf);
y1 = get(handles.finalyear,'string');
y=str2num(y1);

 
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
