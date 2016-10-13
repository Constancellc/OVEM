function varargout = OFAMD(varargin)
% OFAMD MATLAB code for OFAMD.fig
%      OFAMD, by itself, creates a novice OFAMD or raises the existing
%      singleton*.
%
%      H = OFAMD returns the handle to a novice OFAMD or the handle to
%      the existing singleton*.
%
%      OFAMD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OFAMD.M with the given input arguments.
%
%      OFAMD('Property','Value',...) creates a novice OFAMD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OFAMD_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OFAMD_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OFAMD

% Last Modified by GUIDE v2.5 11-Jan-2012 21:50:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OFAMD_OpeningFcn, ...
                   'gui_OutputFcn',  @OFAMD_OutputFcn, ...
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


% --- Executes just before OFAMD is made visible.
function OFAMD_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OFAMD (see VARARGIN)






% --- Outputs from this function are returned to the command line.
function varargout = OFAMD_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1); % this is used to set focus on the axes currently in use



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
    set(handles.text101,'visible','on');
elseif a1==0
    set(handles.ncegsl,'visible','off');
    set(handles.ncegvl,'visible','off');
    set(handles.ncegyi,'visible','off');
    set(handles.ncegyo,'visible','off');
    set(handles.text101,'visible','off');
end

if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1)
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
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
    set(handles.text102,'visible','on');
elseif a2==0
    set(handles.ptisl,'visible','off');
    set(handles.ptivl,'visible','off');
    set(handles.ptiyi,'visible','off');
    set(handles.ptiyo,'visible','off');
    set(handles.text102,'visible','off');
end

if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1)
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
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
    set(handles.text103,'visible','on');
elseif a3==0
    set(handles.dtisl,'visible','off');
    set(handles.dtivl,'visible','off');
    set(handles.dtiyi,'visible','off');
    set(handles.dtiyo,'visible','off');
    set(handles.text103,'visible','off');
end

if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1)
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
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
    set(handles.text104,'visible','on');
elseif a4==0
    set(handles.htisl,'visible','off');
    set(handles.htivl,'visible','off');
    set(handles.htiyi,'visible','off');
    set(handles.htiyo,'visible','off');
    set(handles.text104,'visible','off');
end

if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1)
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
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
    set(handles.text105,'visible','on');
elseif a5==0
    set(handles.pihtisl,'visible','off');
    set(handles.pihtivl,'visible','off');
    set(handles.pihtiyi,'visible','off');
    set(handles.pihtiyo,'visible','off');
    set(handles.text105,'visible','off');
end

if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1)
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
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
    set(handles.text106,'visible','on');
elseif a6==0
    set(handles.etisl,'visible','off');
    set(handles.etivl,'visible','off');
    set(handles.etiyi,'visible','off');
    set(handles.etiyo,'visible','off');
    set(handles.text106,'visible','off');
end

if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1)
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
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
    set(handles.text107,'visible','on');
elseif a7==0
    set(handles.fctisl,'visible','off');
    set(handles.fctivl,'visible','off');
    set(handles.fctiyi,'visible','off');
    set(handles.fctiyo,'visible','off');
    set(handles.text107,'visible','off');
end

if (a1==1||a2==1||a3==1||a4==1||a5==1||a6==1||a7==1)
    set(handles.yi,'visible','on')
    set(handles.yo,'visible','on')
else
    set(handles.yi,'visible','off')
    set(handles.yo,'visible','off')
end


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
global CC
pyi1 = get(handles.ncegyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.ncegyo,'string');
pyo = str2num(pyo1);
cy = CC(7);

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
global CC
pyi1 = get(handles.ptiyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.ptiyo,'string');
pyo = str2num(pyo1);
cy = CC(7);

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
global CC
pyi1 = get(handles.dtiyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.dtiyo,'string');
pyo = str2num(pyo1);
cy = CC(7);

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
global CC
pyi1 = get(handles.htiyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.htiyo,'string');
pyo = str2num(pyo1);
cy = CC(7);

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
global CC
pyi1 = get(handles.pihtiyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.pihtiyo,'string');
pyo = str2num(pyo1);
cy = CC(7);

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
global CC
pyi1 = get(handles.etiyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.etiyo,'string');
pyo = str2num(pyo1);
cy = CC(7);

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
global CC
pyi1 = get(handles.fctiyi,'string');
pyi = str2num(pyi1);
pyo1 = get(handles.fctiyo,'string');
pyo = str2num(pyo1);
cy = CC(7);

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




%%%%control keys

function setofamd_Callback(hObject, eventdata, handles)
global SETOFAMD
global OFAMD


    
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

OFAMD=[ec010 ec011 ec012 ec013;
    pp010 pp011 pp012 pp013;
    dp010 dp011 dp012 dp013;
    hp010 hp011 hp012 hp013
    pi010 pi011 pi012 pi013;
    et010 et011 et012 et013;
    fc010 fc011 fc012 fc013];

if (ec011>0 && ec010==0)||(pp011>0 && pp010==0)||(dp011>0 && dp010==0)||(hp011>0 && hp010==0)||(pi011>0 && pi010==0)||(et011>0 && et010==0)||(fc011>0 && fc010==0)
    mp2=msgbox('Please note that one of your values is not selected', 'SET OFAMD');
    set( mp2, 'color', [ 0.9 0.9 .9 ] )
else
    SETOFAMD=[1];
    close
end

function cancelpolicy_Callback(hObject, eventdata, handles)
global SETOFAMD
SETOFAMD=[0];
close
