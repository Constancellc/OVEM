function varargout = PAMD(varargin)
% PAMD MATLAB code for PAMD.fig
%      PAMD, by itself, creates a novice PAMD or raises the existing
%      singleton*.
%
%      H = PAMD returns the handle to a novice PAMD or the handle to
%      the existing singleton*.
%
%      PAMD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PAMD.M with the given input arguments.
%
%      PAMD('Property','Value',...) creates a novice PAMD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PAMD_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PAMD_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PAMD

% Last Modified by GUIDE v2.5 11-Jan-2012 23:15:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PAMD_OpeningFcn, ...
                   'gui_OutputFcn',  @PAMD_OutputFcn, ...
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


% --- Executes just before PAMD is made visible.
function PAMD_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PAMD (see VARARGIN)






% --- Outputs from this function are returned to the command line.
function varargout = PAMD_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1); % this is used to set focus on the axes currently in use




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
    set(handles.text101,'visible','on');
elseif a1==0
    set(handles.sevsl,'visible','off');
    set(handles.sevvl,'visible','off');
    set(handles.sevyi,'visible','off');
    set(handles.sevyo,'visible','off');
    set(handles.text101,'visible','off');
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
    set(handles.text102,'visible','on');
elseif a2==0
    set(handles.hysl,'visible','off');
    set(handles.hyvl,'visible','off');
    set(handles.hyyi,'visible','off');
    set(handles.hyyo,'visible','off');
    set(handles.text102,'visible','off');
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
    set(handles.text103,'visible','on');
elseif a3==0
    set(handles.phsl,'visible','off');
    set(handles.phvl,'visible','off');
    set(handles.phyi,'visible','off');
    set(handles.phyo,'visible','off');
    set(handles.text103,'visible','off');
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
    set(handles.text104,'visible','on');
elseif a4==0
    set(handles.fcsl,'visible','off');
    set(handles.fcvl,'visible','off');
    set(handles.fcyi,'visible','off');
    set(handles.fcyo,'visible','off');
    set(handles.text104,'visible','off');
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
    set(handles.text105,'visible','on');
elseif a5==0
    set(handles.psl,'visible','off');
    set(handles.pvl,'visible','off');
    set(handles.pyi,'visible','off');
    set(handles.pyo,'visible','off');
    set(handles.text105,'visible','off');
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
    set(handles.text106,'visible','on');
elseif a6==0
    set(handles.dsl,'visible','off');
    set(handles.dvl,'visible','off');
    set(handles.dyi,'visible','off');
    set(handles.dyo,'visible','off');
    set(handles.text106,'visible','off');
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
    set(handles.text107,'visible','on');
elseif a7==0
    set(handles.esl,'visible','off');
    set(handles.evl,'visible','off');
    set(handles.eyi,'visible','off');
    set(handles.eyo,'visible','off');
    set(handles.text107,'visible','off');
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
    set(handles.text108,'visible','on');
elseif a8==0
    set(handles.hsl,'visible','off');
    set(handles.hvl,'visible','off');
    set(handles.hyi,'visible','off');
    set(handles.hyo,'visible','off');
    set(handles.text108,'visible','off');
end
if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1||a8==1)
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
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
global CC
syi1 = get(handles.sevyi,'string');
syi = str2num(syi1);
syo1 = get(handles.sevyo,'string');
syo = str2num(syo1);
cy = CC(7);

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
global CC
pyi1 = get(handles.hyyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.hyyo,'string');
pyo = str2num(pyo1);
cy = CC(7);

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
global CC
pyi1 = get(handles.phyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.phyo,'string');
pyo = str2num(pyo1);
cy = CC(7);

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
global CC
pyi1 = get(handles.fcyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.fcyo,'string');
pyo = str2num(pyo1);
cy = CC(7);

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
global CC
pyi1 = get(handles.pyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.pyo,'string');
pyo = str2num(pyo1);
cy = CC(7);

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
global CC
pyi1 = get(handles.dyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.dyo,'string');
pyo = str2num(pyo1);
cy = CC(7);

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
global CC
pyi1 = get(handles.eyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.eyo,'string');
pyo = str2num(pyo1);
cy = CC(7);

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
global CC
pyi1 = get(handles.hyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.hyo,'string');
pyo = str2num(pyo1);
cy = CC(7);

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




%%%%control keys

function setpamd_Callback(hObject, eventdata, handles)
global SETPAMD
global PAMD


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

PAMD=[ss10 ss11 ss12 ss13;
    hy10 hy11 hy12 hy13;
    ph10 ph11 ph12 ph13;
    fc10 fc11 fc12 fc13;
    pp10 pp11 pp12 pp13;
    dp10 dp11 dp12 dp13;
    ep10 ep11 ep12 ep13;
    hp10 hp11 hp12 hp13];
    
if (ss10==0 && ss11>0)||(hy10==0 && hy11>0)||(ph10==0 && ph11>0)||(fc10==0 && fc11>0)||(pp10==0 && pp11>0)||(dp10==0 && dp11>0)||(ep10==0 && ep11>0)||(hp10==0 && hp11>0)
       mp2=msgbox('Please note that one of your values is not selected', 'SET PAMD');
    set( mp2, 'color', [ 0.9 0.9 .9 ] )
else
SETPAMD=[1];
close
end

function cancelpolicy_Callback(hObject, eventdata, handles)
global SETPAMD
SETPAMD=[0];
close
