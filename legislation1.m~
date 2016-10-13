function varargout = legislation1(varargin)
% LEGISLATION1 MATLAB code for legislation1.fig
%      LEGISLATION1, by itself, creates a new LEGISLATION1 or raises the existing
%      singleton*.
%
%      H = LEGISLATION1 returns the handle to a new LEGISLATION1 or the handle to
%      the existing singleton*.
%
%      LEGISLATION1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LEGISLATION1.M with the given input arguments.
%
%      LEGISLATION1('Property','Value',...) creates a new LEGISLATION1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before legislation1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to legislation1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help legislation1

% Last Modified by GUIDE v2.5 15-Nov-2011 19:09:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @legislation1_OpeningFcn, ...
                   'gui_OutputFcn',  @legislation1_OutputFcn, ...
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


% --- Executes just before legislation1 is made visible.
function legislation1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to legislation1 (see VARARGIN)

% Choose default command line output for legislation1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes legislation1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = legislation1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%top gui buttons

function alegload_Callback(hObject, eventdata, handles)


function alegsave_Callback(hObject, eventdata, handles)


function aleghelp_Callback(hObject, eventdata, handles)
ahlp=msgbox('The advanced legislation allows the user to decide which legislations to introduce, and control teh timeline of their effect','Advanced Legislation');
    set( ahlp, 'color', [ 0.9 0.9 .9 ] )




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set quantities sliders


function alegfuelsl_Callback(hObject, eventdata, handles)
afuel = get(handles.alegfuelsl,'Value');%obtains the slider value from the slider component
set(handles.alegfuelval,'String', num2str(afuel));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure


function alegfuelsl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function alegsubsidysl_Callback(hObject, eventdata, handles)
asubsidy = get(handles.alegsubsidysl,'Value');%obtains the slider value from the slider component
set(handles.alegsubsidyval,'String', num2str(asubsidy));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function alegsubsidysl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function alegdistsl_Callback(hObject, eventdata, handles)
adist = get(handles.alegdistsl,'Value');%obtains the slider value from the slider component
set(handles.alegdistval,'String', num2str(adist));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function alegdistsl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function alegfleetsl_Callback(hObject, eventdata, handles)
afleet = get(handles.alegfleetsl,'Value');%obtains the slider value from the slider component
set(handles.alegfleetval,'String', num2str(afleet));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function alegfleetsl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function aleglearnsl_Callback(hObject, eventdata, handles)
alearn = get(handles.aleglearnsl,'Value');%obtains the slider value from the slider component
set(handles.aleglearnval,'String', num2str(alearn));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function aleglearnsl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




function aleginfrasl_Callback(hObject, eventdata, handles)
ainfra = get(handles.aleginfrasl,'Value');%obtains the slider value from the slider component
set(handles.aleginfraval,'String', num2str(ainfra));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function aleginfrasl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function alegrenewsl_Callback(hObject, eventdata, handles)
arenew = get(handles.alegrenewsl,'Value');%obtains the slider value from the slider component
set(handles.alegrenewval,'String', num2str(arenew));%puts the slider value into the edit text component
guidata(hObject, handles);% Update handles structure

function alegrenewsl_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set quantities values


function alegfuelval_Callback(hObject, eventdata, handles)
afuel = get(handles.alegfuelval,'String');%get the string for the editText component
afuel = str2num(afuel);%convert from string to number if possible, otherwise returns empty


if (isempty(afuel) || afuel < 0 || afuel > 100)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.alegfuelsl,'Value',0);
    set(handles.alegfuelval,'String','0');
else
    set(handles.alegfuelsl,'Value',afuel);
end

function alegfuelval_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function alegsubsidyval_Callback(hObject, eventdata, handles)
asubsidy = get(handles.alegsubsidyval,'String');%get the string for the editText component
asubsidy = str2num(asubsidy);%convert from string to number if possible, otherwise returns empty


if (isempty(asubsidy) || asubsidy < 0 || asubsidy > 10000)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.alegsubsidysl,'Value',0);
    set(handles.alegsubsidyval,'String','0');
else
    set(handles.alegsubsidysl,'Value',asubsidy);
end

function alegsubsidyval_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function alegdistval_Callback(hObject, eventdata, handles)
adist = get(handles.alegdistval,'String');%get the string for the editText component
adist = str2num(adist);%convert from string to number if possible, otherwise returns empty


if (isempty(adist) || adist < 0 || adist > 20)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.alegdistsl,'Value',0);
    set(handles.alegdistval,'String','0');
else
    set(handles.alegdistsl,'Value',adist);
end

function alegdistval_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function alegfleetval_Callback(hObject, eventdata, handles)
afleet = get(handles.alegfleetval,'String');%get the string for the editText component
afleet = str2num(afleet);%convert from string to number if possible, otherwise returns empty


if (isempty(afleet) || afleet < 0 || afleet > 100)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.alegfleetsl,'Value',0);
    set(handles.alegfleetval,'String','0');
else
    set(handles.alegfleetsl,'Value',afleet);
end

function alegfleetval_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function aleglearnval_Callback(hObject, eventdata, handles)
alearn = get(handles.aleglearnval,'String');%get the string for the editText component
alearn = str2num(alearn);%convert from string to number if possible, otherwise returns empty


if (isempty(alearn) || alearn < 0 || alearn > 100)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.aleglearnsl,'Value',0);
    set(handles.aleglearnval,'String','0');
else
    set(handles.aleglearnsl,'Value',alearn);
end

function aleglearnval_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function aleginfraval_Callback(hObject, eventdata, handles)
ainfra = get(handles.aleginfraval,'String');%get the string for the editText component
ainfra = str2num(ainfra);%convert from string to number if possible, otherwise returns empty


if (isempty(ainfra) || ainfra < 0 || ainfra > 10000)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.aleginfrasl,'Value',0);
    set(handles.aleginfraval,'String','0');
else
    set(handles.aleginfrasl,'Value',ainfra);
end

function aleginfraval_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function alegrenewval_Callback(hObject, eventdata, handles)
arenew = get(handles.alegrenewval,'String');%get the string for the editText component
arenew = str2num(arenew);%convert from string to number if possible, otherwise returns empty


if (isempty(arenew) || arenew < 0 || arenew > 10000)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.alegrenewsl,'Value',0);
    set(handles.alegrenewval,'String','0');
else
    set(handles.alegrenewsl,'Value',arenew);
end

function alegrenewval_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%
%time start year

function fuelstart_Callback(hObject, eventdata, handles)
a1=get(handles.alegfuelsl,'Value');
a2=get(handles.fuelstart,'string');
fuelstart=str2num(a2);
a3=get(handles.fuelend,'string');
fuelend=str2num(a3);
if ((a1>0)&&((isempty(fuelstart) || fuelstart<2000 || fuelstart > fuelend)));  
  %  set(handles.fuelstart,'Value',2000);
  %  set(handles.fuelstart,'String','2000');
        myear=msgbox('The start year cannot be less that 2000 or larger than the end year.','Error start year');
    set( myear, 'color', [ 0.9 0.9 .9 ] )
end

function fuelstart_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function subsidystart_Callback(hObject, eventdata, handles)
e1=get(handles.alegsubsidysl,'Value');
e2=get(handles.subsidystart,'string');
subsidystart=str2num(e2);
e3=get(handles.subsidyend,'string');
subsidyend=str2num(e3);
if ((e1>0)&&((isempty(subsidystart) || subsidystart<2000 || subsidystart > subsidyend))); 
  %  set(handles.subsidystart,'Value',2000);
  %  set(handles.subsidystart,'String','2000');
        myear=msgbox('The start year cannot be less that 2000 or larger than the end year.','Error start year');
    set( myear, 'color', [ 0.9 0.9 .9 ] )
end

function subsidystart_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function diststart_Callback(hObject, eventdata, handles)
b1=get(handles.alegdistsl,'Value');
b2=get(handles.diststart,'string');
diststart=str2num(b2);
b3=get(handles.distend,'string');
distend=str2num(b3);
if ((b1>0)&&((isempty(diststart) || diststart<2000 || diststart > distend))); 
   % set(handles.diststart,'Value',2000);
   % set(handles.diststart,'String','2000');
    myear=msgbox('The start year cannot be less that 2000 or larger than the end year.','Error start year');
    set( myear, 'color', [ 0.9 0.9 .9 ] )
end

function diststart_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fleetstart_Callback(hObject, eventdata, handles)
c1=get(handles.alegfleetsl,'Value');
c2=get(handles.fleetstart,'string');
fleetstart=str2num(c2);
c3=get(handles.fleetend,'string');
fleetend=str2num(c3);
if ((c1>0)&&((isempty(fleetstart) || fleetstart<2000 || fleetstart > fleetend))); 
  %  set(handles.fleetstart,'Value',2000);
   % set(handles.fleetstart,'String','2000');
        myear=msgbox('The start year cannot be less that 2000 or larger than the end year.','Error start year');
    set( myear, 'color', [ 0.9 0.9 .9 ] )
end

function fleetstart_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function learnstart_Callback(hObject, eventdata, handles)
d1=get(handles.aleglearnsl,'Value');
d2=get(handles.learnstart,'string');
learnstart=str2num(d2);
d3=get(handles.learnend,'string');
learnend=str2num(d3);
if ((d1>0)&&((isempty(learnstart) || learnstart<2000 || learnstart > learnend))); 
   % set(handles.learnstart,'Value',2000);
   % set(handles.learnstart,'String','2000');
        myear=msgbox('The start year cannot be less that 2000 or larger than the end year.','Error start year');
    set( myear, 'color', [ 0.9 0.9 .9 ] )
end

function learnstart_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function infrastart_Callback(hObject, eventdata, handles)
f1=get(handles.aleginfrasl,'Value');
f2=get(handles.infrastart,'string');
infrastart=str2num(f2);
f3=get(handles.infraend,'string');
infraend=str2num(f3);
if ((f1>0)&&((isempty(infrastart) || infrastart<2000 || infrastart > infraend))); 
   % set(handles.infrastart,'Value',2000);
   % set(handles.infrastart,'String','2000');
        myear=msgbox('The start year cannot be less that 2000 or larger than the end year.','Error start year');
    set( myear, 'color', [ 0.9 0.9 .9 ] )
end

function infrastart_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function renewstart_Callback(hObject, eventdata, handles)
g1=get(handles.alegrenewsl,'Value');
g2=get(handles.renewstart,'string');
renewstart=str2num(g2);
g3=get(handles.renewend,'string');
renewend=str2num(g3);
if ((g1>0)&&((isempty(renewstart) || renewstart<2000 || renewstart > renewend))); 
   % set(handles.renewstart,'Value',2000);
   % set(handles.renewstart,'String','2000');
        myear=msgbox('The start year cannot be less that 2000 or larger than the end year.','Error start year');
    set( myear, 'color', [ 0.9 0.9 .9 ] )
end

function renewstart_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%time end year

function fuelend_Callback(hObject, eventdata, handles)
a1=get(handles.alegfuelsl,'Value');
a2=get(handles.fuelstart,'string');
fuelstart=str2num(a2);
a3=get(handles.fuelend,'string');
fuelend=str2num(a3);
if ((a1>0)&&((isempty(fuelend) || fuelstart > fuelend)));  
   % set(handles.fuelstart,'Value',2000);
   % set(handles.fuelstart,'String','2000');
        myear=msgbox('The end year cannot be empty, or smaller that the start year.','Error end year');
    set( myear, 'color', [ 0.9 0.9 .9 ] )
end

function fuelend_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function subsidyend_Callback(hObject, eventdata, handles)
e1=get(handles.alegsubsidysl,'Value');
e2=get(handles.subsidystart,'string');
subsidystart=str2num(e2);
e3=get(handles.subsidyend,'string');
subsidyend=str2num(e3);
if ((e1>0)&&((isempty(subsidyend) || subsidystart > subsidyend))); 
    %set(handles.subsidystart,'Value',2000);
    %set(handles.subsidystart,'String','2000');
     myear=msgbox('The end year cannot be empty, or smaller that the start year.','Error end year');
    set( myear, 'color', [ 0.9 0.9 .9 ] )
end

function subsidyend_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function distend_Callback(hObject, eventdata, handles)
b1=get(handles.alegdistsl,'Value');
b2=get(handles.diststart,'string');
diststart=str2num(b2);
b3=get(handles.distend,'string');
distend=str2num(b3);
if ((b1>0)&&((isempty(distend) || diststart > distend))); 
    %set(handles.diststart,'Value',2000);
    %set(handles.diststart,'String','2000');
     myear=msgbox('The end year cannot be empty, or smaller that the start year.','Error end year');
    set( myear, 'color', [ 0.9 0.9 .9 ] )
end

function distend_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fleetend_Callback(hObject, eventdata, handles)
c1=get(handles.alegfleetsl,'Value');
c2=get(handles.fleetstart,'string');
fleetstart=str2num(c2);
c3=get(handles.fleetend,'string');
fleetend=str2num(c3);
if ((c1>0)&&((isempty(fleetend) || fleetstart > fleetend))); 
   % set(handles.fleetstart,'Value',2000);
   % set(handles.fleetstart,'String','2000');
     myear=msgbox('The end year cannot be empty, or smaller that the start year.','Error end year');
    set( myear, 'color', [ 0.9 0.9 .9 ] )
end


function fleetend_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function learnend_Callback(hObject, eventdata, handles)
d1=get(handles.aleglearnsl,'Value');
d2=get(handles.learnstart,'string');
learnstart=str2num(d2);
d3=get(handles.learnend,'string');
learnend=str2num(d3);
if ((d1>0)&&((isempty(learnend) || learnstart > learnend))); 
   % set(handles.learnstart,'Value',2000);
   % set(handles.learnstart,'String','2000');
     myear=msgbox('The end year cannot be empty, or smaller that the start year.','Error end year');
    set( myear, 'color', [ 0.9 0.9 .9 ] )
end

function learnend_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function infraend_Callback(hObject, eventdata, handles)
f1=get(handles.aleginfrasl,'Value');
f2=get(handles.infrastart,'string');
infrastart=str2num(f2);
f3=get(handles.infraend,'string');
infraend=str2num(f3);
if ((f1>0)&&((isempty(infraend) ||  infrastart > infraend))); 
   % set(handles.infrastart,'Value',2000);
   % set(handles.infrastart,'String','2000');
     myear=msgbox('The end year cannot be empty, or smaller that the start year.','Error end year');
    set( myear, 'color', [ 0.9 0.9 .9 ] )
end

function infraend_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function renewend_Callback(hObject, eventdata, handles)
g1=get(handles.alegrenewsl,'Value');
g2=get(handles.renewstart,'string');
renewstart=str2num(g2);
g3=get(handles.renewend,'string');
renewend=str2num(g3);
if ((g1>0)&&((isempty(renewend) || renewstart > renewend))); 
   % set(handles.renewstart,'Value',2000);
   % set(handles.renewstart,'String','2000');
     myear=msgbox('The end year cannot be empty, or smaller that the start year.','Error end year');
    set( myear, 'color', [ 0.9 0.9 .9 ] )
end


function renewend_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%bottom command buttons

function set_Callback(hObject, eventdata, handles)
global LAC
global LAV

a1=get(handles.alegfuelsl,'Value');
a21=get(handles.fuelstart,'String');
a2=str2num(a21);
a31=get(handles.fuelend,'String');
a3=str2num(a31);
b1=get(handles.alegdistsl,'Value');
b21=get(handles.diststart,'String');
b2=str2num(b21);
b31=get(handles.distend,'String');
b3=str2num(b31);
c1=get(handles.alegfleetsl,'Value');
c21=get(handles.fleetstart,'String');
c2=str2num(c21);
c31=get(handles.fleetend,'String');
c3=str2num(c31);
d1=get(handles.aleglearnsl,'Value');
d21=get(handles.learnstart,'String');
d2=str2num(d21);
d31=get(handles.learnend,'String');
d3=str2num(d31);
e1=get(handles.alegsubsidysl,'Value');
e21=get(handles.subsidystart,'String');
e2=str2num(e21);
e31=get(handles.subsidyend,'String');
e3=str2num(e31);
f1=get(handles.aleginfrasl,'Value');
f21=get(handles.infrastart,'String');
f2=str2num(f21);
f31=get(handles.infraend,'String');
f3=str2num(f31);
g1=get(handles.alegrenewsl,'Value');
g21=get(handles.renewstart,'String');
g2=str2num(g21);
g31=get(handles.renewend,'String');
g3=str2num(g31);

a=[a1 a2 a3];
b=[b1 b2 b3];
c=[c1 c2 c3];
d=[d1 d2 d3];
e=[d1 d2 d3];
f=[f1 f2 f3];
g=[g1 g2 g3];

if((a1>0)&&(a2<2000||a3==0))
me1=msgbox('Please note that the years for fuel price cannot be 0', 'error year fuel price');
set( me1, 'color', [ 0.9 0.9 .9 ] )
elseif((b1>0)&&(b2<2000||b3==0))
me1=msgbox('Please note that the years for the distance travelled cannot be 0', 'error year distance travelled');
set( me1, 'color', [ 0.9 0.9 .9 ] )
elseif((c1>0)&&(c2<2000||c3==0))
me1=msgbox('Please note that the years for the fleet growth cannot be 0', 'error year fleet growth');
set( me1, 'color', [ 0.9 0.9 .9 ] )
elseif((d1>0)&&(d2<2000||d3==0))
me1=msgbox('Please note that the years for the learning rates cannot be 0', 'error year learning rates');
set( me1, 'color', [ 0.9 0.9 .9 ] )
elseif((e1>0)&&(e2<2000||e3==0))
me1=msgbox('Please note that the years for the sybsidy on clean vehicles cannot be 0', 'error year subsidy');
set( me1, 'color', [ 0.9 0.9 .9 ] )
elseif((f1>0)&&(f2<2000||f3==0))
me1=msgbox('Please note that the years for the infrastructure cannot be 0', 'error year infrastructure');
set( me1, 'color', [ 0.9 0.9 .9 ] )
elseif((g1>0)&&(g2<2000||g3==0))
me1=msgbox('Please note that the years for the renewable energy cannot be 0', 'error year renewable energy');
set( me1, 'color', [ 0.9 0.9 .9 ] )
else
    LAC=[1];
    LAV=[a;b;c;d;e;f;g];
    close();
end


function reset_Callback(hObject, eventdata, handles)

%resets the sliders
set(handles.alegfuelsl,'Value',0);
set(handles.alegdistsl,'Value',0);
set(handles.alegfleetsl,'Value',0);
set(handles.aleglearnsl,'Value',0);
set(handles.alegsubsidysl,'Value',0);
set(handles.aleginfrasl,'Value',0);
set(handles.alegrenewsl,'Value',0);

%resets the values
set(handles.alegfuelval,'String',0);
set(handles.alegdistval,'String',0);
set(handles.alegfleetval,'String',0);
set(handles.aleglearnval,'String',0);
set(handles.alegsubsidyval,'String',0);
set(handles.aleginfraval,'String',0);
set(handles.alegrenewval,'String',0);

%reset the start date
set(handles.fuelstart,'String',0);
set(handles.diststart,'String',0);
set(handles.fleetstart,'String',0);
set(handles.learnstart,'String',0);
set(handles.subsidystart,'String',0);
set(handles.infrastart,'String',0);
set(handles.renewstart,'String',0);

%resets the end date
set(handles.fuelend,'String',0);
set(handles.distend,'String',0);
set(handles.fleetend,'String',0);
set(handles.learnend,'String',0);
set(handles.subsidyend,'String',0);
set(handles.infraend,'String',0);
set(handles.renewend,'String',0);


function cancel_Callback(hObject, eventdata, handles)
global LAC

LAC=[0];
close();

%set error message if year is set but no value set
%set error message if value is set but no dates
