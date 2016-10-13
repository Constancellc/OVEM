function varargout = consumer(varargin)
% CONSUMER MATLAB code for consumer.fig
%      CONSUMER, by itself, creates a new CONSUMER or raises the existing
%      singleton*.
%
%      H = CONSUMER returns the handle to a new CONSUMER or the handle to
%      the existing singleton*.
%
%      CONSUMER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONSUMER.M with the given input arguments.
%
%      CONSUMER('Property','Value',...) creates a new CONSUMER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before consumer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to consumer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help consumer

% Last Modified by GUIDE v2.5 04-Dec-2011 17:17:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @consumer_OpeningFcn, ...
                   'gui_OutputFcn',  @consumer_OutputFcn, ...
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


% --- Executes just before consumer is made visible.
function consumer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to consumer (see VARARGIN)

% Choose default command line output for consumer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes consumer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = consumer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%
%top gui buttons

function about_consumer_Callback(hObject, eventdata, handles)
mcons1=msgbox('Consumer Preference is part of the Probability Analysis which allows to set his preferences for different SMMT Car Categories.','about Consumer Preference')
set( mcons1, 'color', [ 0.9 0.9 .9 ] )


function load_consumer_Callback(hObject, eventdata, handles)


function save_consumer_Callback(hObject, eventdata, handles)
global CAC %consumer advanced choice
a11=get(handles.mprice,'string');
a1=str2num(a11);
a21=get(handles.smprice,'string');
a2=str2num(a21);
a31=get(handles.lmprice,'string');
a3=str2num(a31);
a41=get(handles.umprice,'string');
a4=str2num(a41);
a51=get(handles.eprice,'string');
a5=str2num(a51);
a61=get(handles.lsprice,'string');
a6=str2num(a61);
a71=get(handles.ssprice,'string');
a7=str2num(a71);
a81=get(handles.dpprice,'string');
a8=str2num(a81);
a91=get(handles.mpvprice,'string');
a9=str2num(a91);
b11=get(handles.mrcost,'string');
b1=str2num(b11);
b21=get(handles.smrcost,'string');
b2=str2num(b21);
b31=get(handles.lmrcost,'string');
b3=str2num(b31);
b41=get(handles.umrcost,'string');
b4=str2num(b41);
b51=get(handles.ercost,'string');
b5=str2num(b51);
b61=get(handles.lsrcost,'string');
b6=str2num(b61);
b71=get(handles.ssrcost,'string');
b7=str2num(b71);
b81=get(handles.dprcost,'string');
b8=str2num(b81);
b91=get(handles.mpvrcost,'string');
b9=str2num(b91);
c11=get(handles.mcons,'string');
c1=str2num(c11);
c21=get(handles.smcons,'string');
c2=str2num(c21);
c31=get(handles.lmcons,'string');
c3=str2num(c31);
c41=get(handles.umcons,'string');
c4=str2num(c41);
c51=get(handles.econs,'string');
c5=str2num(c51);
c61=get(handles.lscons,'string');
c6=str2num(c61);
c71=get(handles.sscons,'string');
c7=str2num(c71);
c81=get(handles.dpcons,'string');
c8=str2num(c81);
c91=get(handles.mpvcons,'string');
c9=str2num(c91);
d11=get(handles.mperf,'string');
d1=str2num(d11);
d21=get(handles.smperf,'string');
d2=str2num(d21);
d31=get(handles.lmperf,'string');
d3=str2num(d31);
d41=get(handles.umperf,'string');
d4=str2num(d41);
d51=get(handles.eperf,'string');
d5=str2num(d51);
d61=get(handles.lsperf,'string');
d6=str2num(d61);
d71=get(handles.ssperf,'string');
d7=str2num(d71);
d81=get(handles.dpperf,'string');
d8=str2num(d81);
d91=get(handles.mpvperf,'string');
d9=str2num(d91);
e11=get(handles.mrange,'string');
e1=str2num(e11);
e21=get(handles.smrange,'string');
e2=str2num(e21);
e31=get(handles.lmrange,'string');
e3=str2num(e31);
e41=get(handles.umrange,'string');
e4=str2num(e41);
e51=get(handles.erange,'string');
e5=str2num(e51);
e61=get(handles.lsrange,'string');
e6=str2num(e61);
e71=get(handles.ssrange,'string');
e7=str2num(e71);
e81=get(handles.dprange,'string');
e8=str2num(e81);
e91=get(handles.mpvrange,'string');
e9=str2num(e91);
f11=get(handles.memiss,'string');
f1=str2num(f11);
f21=get(handles.smemiss,'string');
f2=str2num(f21);
f31=get(handles.lmemiss,'string');
f3=str2num(f31);
f41=get(handles.umemiss,'string');
f4=str2num(f41);
f51=get(handles.eemiss,'string');
f5=str2num(f51);
f61=get(handles.lsemiss,'string');
f6=str2num(f61);
f71=get(handles.ssemiss,'string');
f7=str2num(f71);
f81=get(handles.dpemiss,'string');
f8=str2num(f81);
f91=get(handles.mpvemiss,'string');
f9=str2num(f91);
g11=get(handles.mrefuel,'string');
g1=str2num(g11);
g21=get(handles.smrefuel,'string');
g2=str2num(g21);
g31=get(handles.lmrefuel,'string');
g3=str2num(g31);
g41=get(handles.umrefuel,'string');
g4=str2num(g41);
g51=get(handles.erefuel,'string');
g5=str2num(g51);
g61=get(handles.lsrefuel,'string');
g6=str2num(g61);
g71=get(handles.ssrefuel,'string');
g7=str2num(g71);
g81=get(handles.dprefuel,'string');
g8=str2num(g81);
g91=get(handles.mpvrefuel,'string');
g9=str2num(g91);


t1=20-(a1+b1+c1+d1+e1+f1+g1);
t2=20-(a2+b2+c2+d2+e2+f2+g2);
t3=20-(a3+b3+c3+d3+e3+f3+g3);
t4=20-(a4+b4+c4+d4+e4+f4+g4);
t5=20-(a5+b5+c5+d5+e5+f5+g5);
t6=20-(a6+b6+c6+d6+e6+f6+g6);
t7=20-(a7+b7+c7+d7+e7+f7+g7);
t8=20-(a8+b8+c8+d8+e8+f8+g8);
t9=20-(a9+b9+c9+d9+e9+f9+g9);

a=[a1 a2 a3 a4 a5 a6 a7 a8 a9];
b=[b1 b2 b3 b4 b5 b6 b7 b8 b9];
c=[c1 c2 c3 c4 c5 c6 c7 c8 c9];
d=[d1 d2 d3 d4 d5 d6 d7 d8 d9];
e=[e1 e2 e3 e4 e5 e6 e7 e8 e9];
f=[f1 f2 f3 f4 f5 f6 f7 f8 f9];
g=[g1 g2 g3 g4 g5 g6 g7 g8 g9];

astar = (a1*a2*a3*a4*a5*a6*a7*a8*a9);
bstar = (b1*b2*b3*b4*b5*b6*b7*b8*b9);
cstar = (c1*c2*c3*c4*c5*c6*c7*c8*c9);
dstar = (d1*d2*d3*d4*d5*d6*d7*d8*d9);
estar = (e1*e2*e3*e4*e5*e6*e7*e8*e9);
fstar = (f1*f2*f3*f4*f5*f6*f7*f8*f9);
gstar = (g1*g2*g3*g4*g5*g6*g7*g8*g9);

tstar = (astar*bstar*cstar*dstar*estar*fstar*gstar);


if (t1<0||t2<0||t3<0||t4<0||t5<0||t6<0||t7<0||t8<0||t9<0)
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
elseif (t1>0||t2>0||t3>0||t4>0||t5>0||t6>0||t7>0||t8>0||t9>0)
    mp2=msgbox('Please note that you have not allocated all your points','Error Allocated Points');
    set( mp2, 'color', [ 0.9 0.9 .9 ] )
elseif (tstar==0)
    mp2=msgbox('Please note that some of your points are still 0.  Please allocate a value greater than 0','Error Allocated Points');
    set( mp2, 'color', [ 0.9 0.9 .9 ] )
else
CAC=[a;b;c;d;e;f;g];
dlmwrite('consumer_adv_pref',CAC)  
mp2=msgbox('Your values have been saved!','Consumer_Survey');
    set( mp2, 'color', [ 0.9 0.9 .9 ] )

end

function help_consumer_Callback(hObject, eventdata, handles)
mcons2=msgbox('To run Consumer Preference, please give a value to all the vehicle parameters, for all the SMMT categories','help Consumer Preference')
set( mcons2, 'color', [ 0.9 0.9 .9 ] )


%%%%%%%%%%%%%%%%%%%%%%%%%%
%set the user input


function mprice_Callback(hObject, eventdata, handles)
p1 = get(handles.mprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.mrcost,'String');
rc=str2num(rc1);
c1 = get(handles.mcons,'String');
c=str2num(c1);
vp1 = get(handles.mperf,'String');
vp=str2num(vp1);
r1 = get(handles.mrange,'String');
r=str2num(r1);
e1 = get(handles.memiss,'String');
e=str2num(e1);
rf1 = get(handles.mrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(p) || p < 0 || p > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.mprice,'Value',0);
    set(handles.mprice,'String','0');
    mp=msgbox('Please a value between 0 to 5 for Purchase Price','Error Purchase Price');
    set( mp, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.mprice,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    p1 = get(handles.mprice,'String');
    p=str2num(p1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.mt,'string',t);
else
    set(handles.mt,'string',t);
end
guidata(hObject, handles)


function mprice_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mrcost_Callback(hObject, eventdata, handles)
p1 = get(handles.mprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.mrcost,'String');
rc=str2num(rc1);
c1 = get(handles.mcons,'String');
c=str2num(c1);
vp1 = get(handles.mperf,'String');
vp=str2num(vp1);
r1 = get(handles.mrange,'String');
r=str2num(r1);
e1 = get(handles.memiss,'String');
e=str2num(e1);
rf1 = get(handles.mrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rc)|| rc < 0 || rc > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.mrcost,'Value',0);
    set(handles.mrcost,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.mrcost,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rc1 = get(handles.mrcost,'String');
    rc=str2num(rc1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.mt,'string',t);
else
    set(handles.mt,'string',t);
end
guidata(hObject, handles)

function mrcost_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mcons_Callback(hObject, eventdata, handles)
p1 = get(handles.mprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.mrcost,'String');
rc=str2num(rc1);
c1 = get(handles.mcons,'String');
c=str2num(c1);
vp1 = get(handles.mperf,'String');
vp=str2num(vp1);
r1 = get(handles.mrange,'String');
r=str2num(r1);
e1 = get(handles.memiss,'String');
e=str2num(e1);
rf1 = get(handles.mrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(c)|| c < 0 || c > 7);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.mcons,'Value',0);
    set(handles.mcons,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.mcons,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    c1 = get(handles.mcons,'String');
    c=str2num(c1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.mt,'string',t);
else
    set(handles.mt,'string',t);
end
guidata(hObject, handles)

function mcons_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function mperf_Callback(hObject, eventdata, handles)
p1 = get(handles.mprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.mrcost,'String');
rc=str2num(rc1);
c1 = get(handles.mcons,'String');
c=str2num(c1);
vp1 = get(handles.mperf,'String');
vp=str2num(vp1);
r1 = get(handles.mrange,'String');
r=str2num(r1);
e1 = get(handles.memiss,'String');
e=str2num(e1);
rf1 = get(handles.mrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(vp) || vp < 0 || vp > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.mperf,'Value',0);
    set(handles.mperf,'String','0');
    mvp=msgbox('Please a value between 0 to 5 for Vehicle Performance','Error Vehicle Performance');
    set( mvp, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.mperf,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    vp1 = get(handles.mperf,'String');
    vp=str2num(vp1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.mt,'string',t);
else
    set(handles.mt,'string',t);
end
guidata(hObject, handles)

function mperf_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mrange_Callback(hObject, eventdata, handles)
p1 = get(handles.mprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.mrcost,'String');
rc=str2num(rc1);
c1 = get(handles.mcons,'String');
c=str2num(c1);
vp1 = get(handles.mperf,'String');
vp=str2num(vp1);
r1 = get(handles.mrange,'String');
r=str2num(r1);
e1 = get(handles.memiss,'String');
e=str2num(e1);
rf1 = get(handles.mrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(r)|| r < 0 || r > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.mrange,'Value',0);
    set(handles.mrange,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Range','Error Range');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.mrange,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    r1 = get(handles.mrange,'String');
    r=str2num(r1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.mt,'string',t);
else
    set(handles.mt,'string',t);
end
guidata(hObject, handles)

function mrange_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function memiss_Callback(hObject, eventdata, handles)
p1 = get(handles.mprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.mrcost,'String');
rc=str2num(rc1);
c1 = get(handles.mcons,'String');
c=str2num(c1);
vp1 = get(handles.mperf,'String');
vp=str2num(vp1);
r1 = get(handles.mrange,'String');
r=str2num(r1);
e1 = get(handles.memiss,'String');
e=str2num(e1);
rf1 = get(handles.mrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(e)|| e < 0 || e > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.memiss,'Value',0);
    set(handles.memiss,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Emissions','Error Emissions');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.memiss,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    e1 = get(handles.memiss,'String');
    e=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.mt,'string',t);
else
    set(handles.mt,'string',t);
end
guidata(hObject, handles)

function memiss_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mrefuel_Callback(hObject, eventdata, handles)
p1 = get(handles.mprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.mrcost,'String');
rc=str2num(rc1);
c1 = get(handles.mcons,'String');
c=str2num(c1);
vp1 = get(handles.mperf,'String');
vp=str2num(vp1);
r1 = get(handles.mrange,'String');
r=str2num(r1);
e1 = get(handles.memiss,'String');
e=str2num(e1);
rf1 = get(handles.mrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rf)|| rf < 0 || rf > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.mrefuel,'Value',0);
    set(handles.mrefuel,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Refuelling Availibility','Error Refuelling Availibility');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.mrefuel,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rf1 = get(handles.mrefuel,'String');
    rf=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.mt,'string',t);
else
    set(handles.mt,'string',t);
end
guidata(hObject, handles)

function mrefuel_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%sm

function smprice_Callback(hObject, eventdata, handles)
p1 = get(handles.smprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.smrcost,'String');
rc=str2num(rc1);
c1 = get(handles.smcons,'String');
c=str2num(c1);
vp1 = get(handles.smperf,'String');
vp=str2num(vp1);
r1 = get(handles.smrange,'String');
r=str2num(r1);
e1 = get(handles.smemiss,'String');
e=str2num(e1);
rf1 = get(handles.smrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(p) || p < 0 || p > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.smprice,'Value',0);
    set(handles.smprice,'String','0');
    mp=msgbox('Please a value between 0 to 5 for Purchase Price','Error Purchase Price');
    set( mp, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.smprice,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    p1 = get(handles.smprice,'String');
    p=str2num(p1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.smt,'string',t);
else
    set(handles.smt,'string',t);
end
guidata(hObject, handles)


function smprice_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function smrcost_Callback(hObject, eventdata, handles)
p1 = get(handles.smprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.smrcost,'String');
rc=str2num(rc1);
c1 = get(handles.smcons,'String');
c=str2num(c1);
vp1 = get(handles.smperf,'String');
vp=str2num(vp1);
r1 = get(handles.smrange,'String');
r=str2num(r1);
e1 = get(handles.smemiss,'String');
e=str2num(e1);
rf1 = get(handles.smrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rc)|| rc < 0 || rc > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.smrcost,'Value',0);
    set(handles.smrcost,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.smrcost,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rc1 = get(handles.smrcost,'String');
    rc=str2num(rc1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.smt,'string',t);
else
    set(handles.smt,'string',t);
end
guidata(hObject, handles)
function smrcost_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function smcons_Callback(hObject, eventdata, handles)
p1 = get(handles.smprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.smrcost,'String');
rc=str2num(rc1);
c1 = get(handles.smcons,'String');
c=str2num(c1);
vp1 = get(handles.smperf,'String');
vp=str2num(vp1);
r1 = get(handles.smrange,'String');
r=str2num(r1);
e1 = get(handles.smemiss,'String');
e=str2num(e1);
rf1 = get(handles.smrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(c)|| c < 0 || c > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.smcons,'Value',0);
    set(handles.smcons,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.smcons,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    c1 = get(handles.smcons,'String');
    c=str2num(c1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.smt,'string',t);
else
    set(handles.smt,'string',t);
end
guidata(hObject, handles)

function smcons_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function smperf_Callback(hObject, eventdata, handles)
p1 = get(handles.smprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.smrcost,'String');
rc=str2num(rc1);
c1 = get(handles.smcons,'String');
c=str2num(c1);
vp1 = get(handles.smperf,'String');
vp=str2num(vp1);
r1 = get(handles.smrange,'String');
r=str2num(r1);
e1 = get(handles.smemiss,'String');
e=str2num(e1);
rf1 = get(handles.smrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(vp) || vp < 0 || vp > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.smperf,'Value',0);
    set(handles.smperf,'String','0');
    mvp=msgbox('Please a value between 0 to 5 for Vehicle Performance','Error Vehicle Performance');
    set( mvp, 'color', [ 0.9 0.9 .9 ] )
  elseif (t1<0)
    set(handles.smperf,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    vp1 = get(handles.smperf,'String');
    vp=str2num(vp1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.smt,'string',t);
else
    set(handles.smt,'string',t);
end
guidata(hObject, handles)

function smperf_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function smrange_Callback(hObject, eventdata, handles)
p1 = get(handles.smprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.smrcost,'String');
rc=str2num(rc1);
c1 = get(handles.smcons,'String');
c=str2num(c1);
vp1 = get(handles.smperf,'String');
vp=str2num(vp1);
r1 = get(handles.smrange,'String');
r=str2num(r1);
e1 = get(handles.smemiss,'String');
e=str2num(e1);
rf1 = get(handles.smrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(r)|| r < 0 || r > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.smrange,'Value',0);
    set(handles.smrange,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Range','Error Range');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.smrange,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    r1 = get(handles.smrange,'String');
    r=str2num(r1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.smt,'string',t);
else
    set(handles.smt,'string',t);
end
guidata(hObject, handles)


function smrange_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function smemiss_Callback(hObject, eventdata, handles)
p1 = get(handles.smprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.smrcost,'String');
rc=str2num(rc1);
c1 = get(handles.smcons,'String');
c=str2num(c1);
vp1 = get(handles.smperf,'String');
vp=str2num(vp1);
r1 = get(handles.smrange,'String');
r=str2num(r1);
e1 = get(handles.smemiss,'String');
e=str2num(e1);
rf1 = get(handles.smrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(e)|| e < 0 || e > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.smemiss,'Value',0);
    set(handles.smemiss,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Emissions','Error Emissions');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.smemiss,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    e1 = get(handles.smemiss,'String');
    e=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.smt,'string',t);
else
    set(handles.smt,'string',t);
end
guidata(hObject, handles)

function smemiss_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function smrefuel_Callback(hObject, eventdata, handles)
p1 = get(handles.smprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.smrcost,'String');
rc=str2num(rc1);
c1 = get(handles.smcons,'String');
c=str2num(c1);
vp1 = get(handles.smperf,'String');
vp=str2num(vp1);
r1 = get(handles.smrange,'String');
r=str2num(r1);
e1 = get(handles.smemiss,'String');
e=str2num(e1);
rf1 = get(handles.smrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rf)|| rf < 0 || rf > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.smrefuel,'Value',0);
    set(handles.smrefuel,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Refuelling Availibility','Error Refuelling Availibility');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.smrefuel,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rf1 = get(handles.smrefuel,'String');
    rf=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.smt,'string',t);
else
    set(handles.smt,'string',t);
end
guidata(hObject, handles)

function smrefuel_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%lm

function lmprice_Callback(hObject, eventdata, handles)
p1 = get(handles.lmprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.lmrcost,'String');
rc=str2num(rc1);
c1 = get(handles.lmcons,'String');
c=str2num(c1);
vp1 = get(handles.lmperf,'String');
vp=str2num(vp1);
r1 = get(handles.lmrange,'String');
r=str2num(r1);
e1 = get(handles.lmemiss,'String');
e=str2num(e1);
rf1 = get(handles.lmrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(p) || p < 0 || p > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.lmprice,'Value',0);
    set(handles.lmprice,'String','0');
    mp=msgbox('Please a value between 0 to 5 for Purchase Price','Error Purchase Price');
    set( mp, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.lmprice,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    p1 = get(handles.lmprice,'String');
    p=str2num(p1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.lmt,'string',t);
else
    set(handles.lmt,'string',t);
end
guidata(hObject, handles)


function lmprice_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lmrcost_Callback(hObject, eventdata, handles)
p1 = get(handles.lmprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.lmrcost,'String');
rc=str2num(rc1);
c1 = get(handles.lmcons,'String');
c=str2num(c1);
vp1 = get(handles.lmperf,'String');
vp=str2num(vp1);
r1 = get(handles.lmrange,'String');
r=str2num(r1);
e1 = get(handles.lmemiss,'String');
e=str2num(e1);
rf1 = get(handles.lmrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rc)|| rc < 0 || rc > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.lmrcost,'Value',0);
    set(handles.lmrcost,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.lmrcost,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rc1 = get(handles.lmrcost,'String');
    rc=str2num(rc1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.lmt,'string',t);
else
    set(handles.lmt,'string',t);
end
guidata(hObject, handles)

function lmrcost_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lmcons_Callback(hObject, eventdata, handles)
p1 = get(handles.lmprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.lmrcost,'String');
rc=str2num(rc1);
c1 = get(handles.lmcons,'String');
c=str2num(c1);
vp1 = get(handles.lmperf,'String');
vp=str2num(vp1);
r1 = get(handles.lmrange,'String');
r=str2num(r1);
e1 = get(handles.lmemiss,'String');
e=str2num(e1);
rf1 = get(handles.lmrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(c)|| c < 0 || c > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.lmcons,'Value',0);
    set(handles.lmcons,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.lmcons,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    c1 = get(handles.lmcons,'String');
    c=str2num(c1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.lmt,'string',t);
else
    set(handles.lmt,'string',t);
end
guidata(hObject, handles)

function lmcons_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lmperf_Callback(hObject, eventdata, handles)
p1 = get(handles.lmprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.lmrcost,'String');
rc=str2num(rc1);
c1 = get(handles.lmcons,'String');
c=str2num(c1);
vp1 = get(handles.lmperf,'String');
vp=str2num(vp1);
r1 = get(handles.lmrange,'String');
r=str2num(r1);
e1 = get(handles.lmemiss,'String');
e=str2num(e1);
rf1 = get(handles.lmrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(vp) || vp < 0 || vp > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.lmperf,'Value',0);
    set(handles.lmperf,'String','0');
    mvp=msgbox('Please a value between 0 to 5 for Vehicle Performance','Error Vehicle Performance');
    set( mvp, 'color', [ 0.9 0.9 .9 ] )
    elseif (t1<0)
    set(handles.lmperf,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    vp1 = get(handles.lmperf,'String');
    vp=str2num(vp1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.lmt,'string',t);
else
    set(handles.lmt,'string',t);
end
guidata(hObject, handles)

function lmperf_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lmrange_Callback(hObject, eventdata, handles)
p1 = get(handles.lmprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.lmrcost,'String');
rc=str2num(rc1);
c1 = get(handles.lmcons,'String');
c=str2num(c1);
vp1 = get(handles.lmperf,'String');
vp=str2num(vp1);
r1 = get(handles.lmrange,'String');
r=str2num(r1);
e1 = get(handles.lmemiss,'String');
e=str2num(e1);
rf1 = get(handles.lmrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(r)|| r < 0 || r > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.lmrange,'Value',0);
    set(handles.lmrange,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Range','Error Range');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.lmrange,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    r1 = get(handles.lmrange,'String');
    r=str2num(r1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.lmt,'string',t);
else
    set(handles.lmt,'string',t);
end
guidata(hObject, handles)


function lmrange_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lmemiss_Callback(hObject, eventdata, handles)
p1 = get(handles.lmprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.lmrcost,'String');
rc=str2num(rc1);
c1 = get(handles.lmcons,'String');
c=str2num(c1);
vp1 = get(handles.lmperf,'String');
vp=str2num(vp1);
r1 = get(handles.lmrange,'String');
r=str2num(r1);
e1 = get(handles.lmemiss,'String');
e=str2num(e1);
rf1 = get(handles.lmrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(e)|| e < 0 || e > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.lmemiss,'Value',0);
    set(handles.lmemiss,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Emissions','Error Emissions');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.lmemiss,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    e1 = get(handles.lmemiss,'String');
    e=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.lmt,'string',t);
else
    set(handles.lmt,'string',t);
end
guidata(hObject, handles)

function lmemiss_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lmrefuel_Callback(hObject, eventdata, handles)
p1 = get(handles.lmprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.lmrcost,'String');
rc=str2num(rc1);
c1 = get(handles.lmcons,'String');
c=str2num(c1);
vp1 = get(handles.lmperf,'String');
vp=str2num(vp1);
r1 = get(handles.lmrange,'String');
r=str2num(r1);
e1 = get(handles.lmemiss,'String');
e=str2num(e1);
rf1 = get(handles.lmrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rf)|| rf < 0 || rf > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.lmrefuel,'Value',0);
    set(handles.lmrefuel,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Refuelling Availibility','Error Refuelling Availibility');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.lmrefuel,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rf1 = get(handles.lmrefuel,'String');
    rf=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.lmt,'string',t);
else
    set(handles.lmt,'string',t);
end
guidata(hObject, handles)

function lmrefuel_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%um


function umprice_Callback(hObject, eventdata, handles)
p1 = get(handles.umprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.umrcost,'String');
rc=str2num(rc1);
c1 = get(handles.umcons,'String');
c=str2num(c1);
vp1 = get(handles.umperf,'String');
vp=str2num(vp1);
r1 = get(handles.umrange,'String');
r=str2num(r1);
e1 = get(handles.umemiss,'String');
e=str2num(e1);
rf1 = get(handles.umrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(p) || p < 0 || p > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.umprice,'Value',0);
    set(handles.umprice,'String','0');
    mp=msgbox('Please a value between 0 to 5 for Purchase Price','Error Purchase Price');
    set( mp, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.umprice,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    p1 = get(handles.umprice,'String');
    p=str2num(p1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.umt,'string',t);
else
    set(handles.umt,'string',t);
end
guidata(hObject, handles)


function umprice_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function umrcost_Callback(hObject, eventdata, handles)
p1 = get(handles.umprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.umrcost,'String');
rc=str2num(rc1);
c1 = get(handles.umcons,'String');
c=str2num(c1);
vp1 = get(handles.umperf,'String');
vp=str2num(vp1);
r1 = get(handles.umrange,'String');
r=str2num(r1);
e1 = get(handles.umemiss,'String');
e=str2num(e1);
rf1 = get(handles.umrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rc)|| rc < 0 || rc > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.umrcost,'Value',0);
    set(handles.umrcost,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.umrcost,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rc1 = get(handles.umrcost,'String');
    rc=str2num(rc1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.umt,'string',t);
else
    set(handles.umt,'string',t);
end
guidata(hObject, handles)

function umrcost_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function umcons_Callback(hObject, eventdata, handles)
p1 = get(handles.umprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.umrcost,'String');
rc=str2num(rc1);
c1 = get(handles.umcons,'String');
c=str2num(c1);
vp1 = get(handles.umperf,'String');
vp=str2num(vp1);
r1 = get(handles.umrange,'String');
r=str2num(r1);
e1 = get(handles.umemiss,'String');
e=str2num(e1);
rf1 = get(handles.umrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(c)|| c < 0 || c > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.umcons,'Value',0);
    set(handles.umcons,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.umcons,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    c1 = get(handles.umcons,'String');
    c=str2num(c1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.umt,'string',t);
else
    set(handles.umt,'string',t);
end
guidata(hObject, handles)

function umcons_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function umperf_Callback(hObject, eventdata, handles)
p1 = get(handles.umprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.umrcost,'String');
rc=str2num(rc1);
c1 = get(handles.umcons,'String');
c=str2num(c1);
vp1 = get(handles.umperf,'String');
vp=str2num(vp1);
r1 = get(handles.umrange,'String');
r=str2num(r1);
e1 = get(handles.umemiss,'String');
e=str2num(e1);
rf1 = get(handles.umrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(vp) || vp < 0 || vp > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.umperf,'Value',0);
    set(handles.umperf,'String','0');
    mvp=msgbox('Please a value between 0 to 5 for Vehicle Performance','Error Vehicle Performance');
    set( mvp, 'color', [ 0.9 0.9 .9 ] )
    elseif (t1<0)
    set(handles.umperf,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    vp1 = get(handles.umperf,'String');
    vp=str2num(vp1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.umt,'string',t);
else
    set(handles.umt,'string',t);
end
guidata(hObject, handles)

function umperf_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function umrange_Callback(hObject, eventdata, handles)
p1 = get(handles.umprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.umrcost,'String');
rc=str2num(rc1);
c1 = get(handles.umcons,'String');
c=str2num(c1);
vp1 = get(handles.umperf,'String');
vp=str2num(vp1);
r1 = get(handles.umrange,'String');
r=str2num(r1);
e1 = get(handles.umemiss,'String');
e=str2num(e1);
rf1 = get(handles.umrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(r)|| r < 0 || r > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.umrange,'Value',0);
    set(handles.umrange,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Range','Error Range');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.umrange,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    r1 = get(handles.umrange,'String');
    r=str2num(r1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.umt,'string',t);
else
    set(handles.umt,'string',t);
end
guidata(hObject, handles)


function umrange_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function umemiss_Callback(hObject, eventdata, handles)
p1 = get(handles.umprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.umrcost,'String');
rc=str2num(rc1);
c1 = get(handles.umcons,'String');
c=str2num(c1);
vp1 = get(handles.umperf,'String');
vp=str2num(vp1);
r1 = get(handles.umrange,'String');
r=str2num(r1);
e1 = get(handles.umemiss,'String');
e=str2num(e1);
rf1 = get(handles.umrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(e)|| e < 0 || e > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.umemiss,'Value',0);
    set(handles.umemiss,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Emissions','Error Emissions');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
 elseif (t1<0)
    set(handles.umemiss,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    e1 = get(handles.umemiss,'String');
    e=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.umt,'string',t);
else
    set(handles.umt,'string',t);
end
guidata(hObject, handles)

function umemiss_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function umrefuel_Callback(hObject, eventdata, handles)
p1 = get(handles.umprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.umrcost,'String');
rc=str2num(rc1);
c1 = get(handles.umcons,'String');
c=str2num(c1);
vp1 = get(handles.umperf,'String');
vp=str2num(vp1);
r1 = get(handles.umrange,'String');
r=str2num(r1);
e1 = get(handles.umemiss,'String');
e=str2num(e1);
rf1 = get(handles.umrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rf)|| rf < 0 || rf > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.umrefuel,'Value',0);
    set(handles.umrefuel,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Refuelling Availibility','Error Refuelling Availibility');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.umrefuel,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rf1 = get(handles.umrefuel,'String');
    rf=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.umt,'string',t);
else
    set(handles.umt,'string',t);
end
guidata(hObject, handles)

function umrefuel_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%e

function eprice_Callback(hObject, eventdata, handles)
p1 = get(handles.eprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.ercost,'String');
rc=str2num(rc1);
c1 = get(handles.econs,'String');
c=str2num(c1);
vp1 = get(handles.eperf,'String');
vp=str2num(vp1);
r1 = get(handles.erange,'String');
r=str2num(r1);
e1 = get(handles.eemiss,'String');
e=str2num(e1);
rf1 = get(handles.erefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(p) || p < 0 || p > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.eprice,'Value',0);
    set(handles.eprice,'String','0');
    mp=msgbox('Please a value between 0 to 5 for Purchase Price','Error Purchase Price');
    set( mp, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.eprice,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    p1 = get(handles.eprice,'String');
    p=str2num(p1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.et,'string',t);
else
    set(handles.et,'string',t);
end
guidata(hObject, handles)


function eprice_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ercost_Callback(hObject, eventdata, handles)
p1 = get(handles.eprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.ercost,'String');
rc=str2num(rc1);
c1 = get(handles.econs,'String');
c=str2num(c1);
vp1 = get(handles.eperf,'String');
vp=str2num(vp1);
r1 = get(handles.erange,'String');
r=str2num(r1);
e1 = get(handles.eemiss,'String');
e=str2num(e1);
rf1 = get(handles.erefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rc)|| rc < 0 || rc > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.ercost,'Value',0);
    set(handles.ercost,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.ercost,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rc1 = get(handles.ercost,'String');
    rc=str2num(rc1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.et,'string',t);
else
    set(handles.et,'string',t);
end
guidata(hObject, handles)

function ercost_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function econs_Callback(hObject, eventdata, handles)
p1 = get(handles.eprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.ercost,'String');
rc=str2num(rc1);
c1 = get(handles.econs,'String');
c=str2num(c1);
vp1 = get(handles.eperf,'String');
vp=str2num(vp1);
r1 = get(handles.erange,'String');
r=str2num(r1);
e1 = get(handles.eemiss,'String');
e=str2num(e1);
rf1 = get(handles.erefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(c)|| c < 0 || c > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.econs,'Value',0);
    set(handles.econs,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.econs,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    c1 = get(handles.econs,'String');
    c=str2num(c1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.et,'string',t);
else
    set(handles.et,'string',t);
end
guidata(hObject, handles)

function econs_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function eperf_Callback(hObject, eventdata, handles)
p1 = get(handles.eprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.ercost,'String');
rc=str2num(rc1);
c1 = get(handles.econs,'String');
c=str2num(c1);
vp1 = get(handles.eperf,'String');
vp=str2num(vp1);
r1 = get(handles.erange,'String');
r=str2num(r1);
e1 = get(handles.eemiss,'String');
e=str2num(e1);
rf1 = get(handles.erefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(vp) || vp < 0 || vp > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.eperf,'Value',0);
    set(handles.eperf,'String','0');
    mvp=msgbox('Please a value between 0 to 5 for Vehicle Performance','Error Vehicle Performance');
    set( mvp, 'color', [ 0.9 0.9 .9 ] )
 elseif (t1<0)
    set(handles.eperf,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    vp1 = get(handles.eperf,'String');
    vp=str2num(vp1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.et,'string',t);
else
    set(handles.et,'string',t);
end
guidata(hObject, handles)

function eperf_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function erange_Callback(hObject, eventdata, handles)
p1 = get(handles.eprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.ercost,'String');
rc=str2num(rc1);
c1 = get(handles.econs,'String');
c=str2num(c1);
vp1 = get(handles.eperf,'String');
vp=str2num(vp1);
r1 = get(handles.erange,'String');
r=str2num(r1);
e1 = get(handles.eemiss,'String');
e=str2num(e1);
rf1 = get(handles.erefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(r)|| r < 0 || r > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.erange,'Value',0);
    set(handles.erange,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Range','Error Range');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.erange,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    r1 = get(handles.erange,'String');
    r=str2num(r1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.et,'string',t);
else
    set(handles.et,'string',t);
end
guidata(hObject, handles)


function erange_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function eemiss_Callback(hObject, eventdata, handles)
p1 = get(handles.eprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.ercost,'String');
rc=str2num(rc1);
c1 = get(handles.econs,'String');
c=str2num(c1);
vp1 = get(handles.eperf,'String');
vp=str2num(vp1);
r1 = get(handles.erange,'String');
r=str2num(r1);
e1 = get(handles.eemiss,'String');
e=str2num(e1);
rf1 = get(handles.erefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(e)|| e < 0 || e > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.eemiss,'Value',0);
    set(handles.eemiss,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Emissions','Error Emissions');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.eemiss,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    e1 = get(handles.eemiss,'String');
    e=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.et,'string',t);
else
    set(handles.et,'string',t);
end
guidata(hObject, handles)

function eemiss_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function erefuel_Callback(hObject, eventdata, handles)
p1 = get(handles.eprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.ercost,'String');
rc=str2num(rc1);
c1 = get(handles.econs,'String');
c=str2num(c1);
vp1 = get(handles.eperf,'String');
vp=str2num(vp1);
r1 = get(handles.erange,'String');
r=str2num(r1);
e1 = get(handles.eemiss,'String');
e=str2num(e1);
rf1 = get(handles.erefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rf)|| rf < 0 || rf > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.erefuel,'Value',0);
    set(handles.erefuel,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Refuelling Availibility','Error Refuelling Availibility');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.erefuel,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rf1 = get(handles.erefuel,'String');
    rf=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.et,'string',t);
else
    set(handles.et,'string',t);
end
guidata(hObject, handles)

function erefuel_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%ls

function lsprice_Callback(hObject, eventdata, handles)
p1 = get(handles.lsprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.lsrcost,'String');
rc=str2num(rc1);
c1 = get(handles.lscons,'String');
c=str2num(c1);
vp1 = get(handles.lsperf,'String');
vp=str2num(vp1);
r1 = get(handles.lsrange,'String');
r=str2num(r1);
e1 = get(handles.lsemiss,'String');
e=str2num(e1);
rf1 = get(handles.lsrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(p) || p < 0 || p > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.lsprice,'Value',0);
    set(handles.lsprice,'String','0');
    mp=msgbox('Please a value between 0 to 5 for Purchase Price','Error Purchase Price');
    set( mp, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.lsprice,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    p1 = get(handles.lsprice,'String');
    p=str2num(p1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.lst,'string',t);
else
    set(handles.lst,'string',t);
end
guidata(hObject, handles)


function lsprice_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lsrcost_Callback(hObject, eventdata, handles)
p1 = get(handles.lsprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.lsrcost,'String');
rc=str2num(rc1);
c1 = get(handles.lscons,'String');
c=str2num(c1);
vp1 = get(handles.lsperf,'String');
vp=str2num(vp1);
r1 = get(handles.lsrange,'String');
r=str2num(r1);
e1 = get(handles.lsemiss,'String');
e=str2num(e1);
rf1 = get(handles.lsrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rc)|| rc < 0 || rc > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.lsrcost,'Value',0);
    set(handles.lsrcost,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.lsrcost,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rc1 = get(handles.lsrcost,'String');
    rc=str2num(rc1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.lst,'string',t);
else
    set(handles.lst,'string',t);
end
guidata(hObject, handles)
function lsrcost_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lscons_Callback(hObject, eventdata, handles)
p1 = get(handles.lsprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.lsrcost,'String');
rc=str2num(rc1);
c1 = get(handles.lscons,'String');
c=str2num(c1);
vp1 = get(handles.lsperf,'String');
vp=str2num(vp1);
r1 = get(handles.lsrange,'String');
r=str2num(r1);
e1 = get(handles.lsemiss,'String');
e=str2num(e1);
rf1 = get(handles.lsrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(c)|| c < 0 || c > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.lscons,'Value',0);
    set(handles.lscons,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.lscons,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    c1 = get(handles.lscons,'String');
    c=str2num(c1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.lst,'string',t);
else
    set(handles.lst,'string',t);
end
guidata(hObject, handles)

function lscons_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lsperf_Callback(hObject, eventdata, handles)
p1 = get(handles.lsprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.lsrcost,'String');
rc=str2num(rc1);
c1 = get(handles.lscons,'String');
c=str2num(c1);
vp1 = get(handles.lsperf,'String');
vp=str2num(vp1);
r1 = get(handles.lsrange,'String');
r=str2num(r1);
e1 = get(handles.lsemiss,'String');
e=str2num(e1);
rf1 = get(handles.lsrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(vp) || vp < 0 || vp > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.lsperf,'Value',0);
    set(handles.lsperf,'String','0');
    mvp=msgbox('Please a value between 0 to 5 for Vehicle Performance','Error Vehicle Performance');
    set( mvp, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.lsperf,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    vp1 = get(handles.lsperf,'String');
    vp=str2num(vp1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.lst,'string',t);
else
    set(handles.lst,'string',t);
end
guidata(hObject, handles)

function lsperf_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lsrange_Callback(hObject, eventdata, handles)
p1 = get(handles.lsprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.lsrcost,'String');
rc=str2num(rc1);
c1 = get(handles.lscons,'String');
c=str2num(c1);
vp1 = get(handles.lsperf,'String');
vp=str2num(vp1);
r1 = get(handles.lsrange,'String');
r=str2num(r1);
e1 = get(handles.lsemiss,'String');
e=str2num(e1);
rf1 = get(handles.lsrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(r)|| r < 0 || r > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.lsrange,'Value',0);
    set(handles.lsrange,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Range','Error Range');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.lsrange,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    r1 = get(handles.lsrange,'String');
    r=str2num(r1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.lst,'string',t);
else
    set(handles.lst,'string',t);
end
guidata(hObject, handles)


function lsrange_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lsemiss_Callback(hObject, eventdata, handles)
p1 = get(handles.lsprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.lsrcost,'String');
rc=str2num(rc1);
c1 = get(handles.lscons,'String');
c=str2num(c1);
vp1 = get(handles.lsperf,'String');
vp=str2num(vp1);
r1 = get(handles.lsrange,'String');
r=str2num(r1);
e1 = get(handles.lsemiss,'String');
e=str2num(e1);
rf1 = get(handles.lsrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(e)|| e < 0 || e > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.lsemiss,'Value',0);
    set(handles.lsemiss,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Emissions','Error Emissions');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.lsemiss,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    e1 = get(handles.lsemiss,'String');
    e=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.lst,'string',t);
else
    set(handles.lst,'string',t);
end
guidata(hObject, handles)

function lsemiss_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lsrefuel_Callback(hObject, eventdata, handles)
p1 = get(handles.lsprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.lsrcost,'String');
rc=str2num(rc1);
c1 = get(handles.lscons,'String');
c=str2num(c1);
vp1 = get(handles.lsperf,'String');
vp=str2num(vp1);
r1 = get(handles.lsrange,'String');
r=str2num(r1);
e1 = get(handles.lsemiss,'String');
e=str2num(e1);
rf1 = get(handles.lsrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rf)|| rf < 0 || rf > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.lsrefuel,'Value',0);
    set(handles.lsrefuel,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Refuelling Availibility','Error Refuelling Availibility');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.lsrefuel,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rf1 = get(handles.lsrefuel,'String');
    rf=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.lst,'string',t);
else
    set(handles.lst,'string',t);
end
guidata(hObject, handles)

function lsrefuel_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%ss

function ssprice_Callback(hObject, eventdata, handles)
p1 = get(handles.ssprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.ssrcost,'String');
rc=str2num(rc1);
c1 = get(handles.sscons,'String');
c=str2num(c1);
vp1 = get(handles.ssperf,'String');
vp=str2num(vp1);
r1 = get(handles.ssrange,'String');
r=str2num(r1);
e1 = get(handles.ssemiss,'String');
e=str2num(e1);
rf1 = get(handles.ssrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(p) || p < 0 || p > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.ssprice,'Value',0);
    set(handles.ssprice,'String','0');
    mp=msgbox('Please a value between 0 to 5 for Purchase Price','Error Purchase Price');
    set( mp, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.ssprice,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    p1 = get(handles.ssprice,'String');
    p=str2num(p1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.sst,'string',t);
else
    set(handles.sst,'string',t);
end
guidata(hObject, handles)


function ssprice_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ssrcost_Callback(hObject, eventdata, handles)
p1 = get(handles.ssprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.ssrcost,'String');
rc=str2num(rc1);
c1 = get(handles.sscons,'String');
c=str2num(c1);
vp1 = get(handles.ssperf,'String');
vp=str2num(vp1);
r1 = get(handles.ssrange,'String');
r=str2num(r1);
e1 = get(handles.ssemiss,'String');
e=str2num(e1);
rf1 = get(handles.ssrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rc)|| rc < 0 || rc > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.ssrcost,'Value',0);
    set(handles.ssrcost,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.ssrcost,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rc1 = get(handles.ssrcost,'String');
    rc=str2num(rc1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.sst,'string',t);
else
    set(handles.sst,'string',t);
end
guidata(hObject, handles)

function ssrcost_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function sscons_Callback(hObject, eventdata, handles)
p1 = get(handles.ssprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.ssrcost,'String');
rc=str2num(rc1);
c1 = get(handles.sscons,'String');
c=str2num(c1);
vp1 = get(handles.ssperf,'String');
vp=str2num(vp1);
r1 = get(handles.ssrange,'String');
r=str2num(r1);
e1 = get(handles.ssemiss,'String');
e=str2num(e1);
rf1 = get(handles.ssrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(c)|| c < 0 || c > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.sscons,'Value',0);
    set(handles.sscons,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.sscons,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    c1 = get(handles.sscons,'String');
    c=str2num(c1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.sst,'string',t);
else
    set(handles.sst,'string',t);
end
guidata(hObject, handles)

function sscons_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ssperf_Callback(hObject, eventdata, handles)
p1 = get(handles.ssprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.ssrcost,'String');
rc=str2num(rc1);
c1 = get(handles.sscons,'String');
c=str2num(c1);
vp1 = get(handles.ssperf,'String');
vp=str2num(vp1);
r1 = get(handles.ssrange,'String');
r=str2num(r1);
e1 = get(handles.ssemiss,'String');
e=str2num(e1);
rf1 = get(handles.ssrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(vp) || vp < 0 || vp > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.ssperf,'Value',0);
    set(handles.ssperf,'String','0');
    mvp=msgbox('Please a value between 0 to 5 for Vehicle Performance','Error Vehicle Performance');
    set( mvp, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.ssperf,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    vp1 = get(handles.ssperf,'String');
    vp=str2num(vp1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.sst,'string',t);
else
    set(handles.sst,'string',t);
end
guidata(hObject, handles)

function ssperf_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ssrange_Callback(hObject, eventdata, handles)
p1 = get(handles.ssprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.ssrcost,'String');
rc=str2num(rc1);
c1 = get(handles.sscons,'String');
c=str2num(c1);
vp1 = get(handles.ssperf,'String');
vp=str2num(vp1);
r1 = get(handles.ssrange,'String');
r=str2num(r1);
e1 = get(handles.ssemiss,'String');
e=str2num(e1);
rf1 = get(handles.ssrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(r)|| r < 0 || r > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.ssrange,'Value',0);
    set(handles.ssrange,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Range','Error Range');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
   elseif (t1<0)
    set(handles.ssrange,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    r1 = get(handles.ssrange,'String');
    r=str2num(r1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.sst,'string',t);
else
    set(handles.sst,'string',t);
end
guidata(hObject, handles)


function ssrange_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ssemiss_Callback(hObject, eventdata, handles)
p1 = get(handles.ssprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.ssrcost,'String');
rc=str2num(rc1);
c1 = get(handles.sscons,'String');
c=str2num(c1);
vp1 = get(handles.ssperf,'String');
vp=str2num(vp1);
r1 = get(handles.ssrange,'String');
r=str2num(r1);
e1 = get(handles.ssemiss,'String');
e=str2num(e1);
rf1 = get(handles.ssrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(e)|| e < 0 || e > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.ssemiss,'Value',0);
    set(handles.ssemiss,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Emissions','Error Emissions');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.ssemiss,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    e1 = get(handles.ssemiss,'String');
    e=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.sst,'string',t);
else
    set(handles.sst,'string',t);
end
guidata(hObject, handles)

function ssemiss_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ssrefuel_Callback(hObject, eventdata, handles)
p1 = get(handles.ssprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.ssrcost,'String');
rc=str2num(rc1);
c1 = get(handles.sscons,'String');
c=str2num(c1);
vp1 = get(handles.ssperf,'String');
vp=str2num(vp1);
r1 = get(handles.ssrange,'String');
r=str2num(r1);
e1 = get(handles.ssemiss,'String');
e=str2num(e1);
rf1 = get(handles.ssrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rf)|| rf < 0 || rf > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.ssrefuel,'Value',0);
    set(handles.ssrefuel,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Refuelling Availibility','Error Refuelling Availibility');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.ssrefuel,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rf1 = get(handles.ssrefuel,'String');
    rf=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.sst,'string',t);
else
    set(handles.sst,'string',t);
end
guidata(hObject, handles)

function ssrefuel_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%dp


function dpprice_Callback(hObject, eventdata, handles)
p1 = get(handles.dpprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.dprcost,'String');
rc=str2num(rc1);
c1 = get(handles.dpcons,'String');
c=str2num(c1);
vp1 = get(handles.dpperf,'String');
vp=str2num(vp1);
r1 = get(handles.dprange,'String');
r=str2num(r1);
e1 = get(handles.dpemiss,'String');
e=str2num(e1);
rf1 = get(handles.dprefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(p) || p < 0 || p > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.dpprice,'Value',0);
    set(handles.dpprice,'String','0');
    mp=msgbox('Please a value between 0 to 5 for Purchase Price','Error Purchase Price');
    set( mp, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.dpprice,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    p1 = get(handles.dpprice,'String');
    p=str2num(p1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.dpt,'string',t);
else
    set(handles.dpt,'string',t);
end
guidata(hObject, handles)


function dpprice_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dprcost_Callback(hObject, eventdata, handles)
p1 = get(handles.dpprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.dprcost,'String');
rc=str2num(rc1);
c1 = get(handles.dpcons,'String');
c=str2num(c1);
vp1 = get(handles.dpperf,'String');
vp=str2num(vp1);
r1 = get(handles.dprange,'String');
r=str2num(r1);
e1 = get(handles.dpemiss,'String');
e=str2num(e1);
rf1 = get(handles.dprefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rc)|| rc < 0 || rc > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.dprcost,'Value',0);
    set(handles.dprcost,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.dprcost,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rc1 = get(handles.dprcost,'String');
    rc=str2num(rc1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.dpt,'string',t);
else
    set(handles.dpt,'string',t);
end
guidata(hObject, handles)


function dprcost_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function dpcons_Callback(hObject, eventdata, handles)
p1 = get(handles.dpprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.dprcost,'String');
rc=str2num(rc1);
c1 = get(handles.dpcons,'String');
c=str2num(c1);
vp1 = get(handles.dpperf,'String');
vp=str2num(vp1);
r1 = get(handles.dprange,'String');
r=str2num(r1);
e1 = get(handles.dpemiss,'String');
e=str2num(e1);
rf1 = get(handles.dprefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(c)|| c < 0 || c > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.dpcons,'Value',0);
    set(handles.dpcons,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.dpcons,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    c1 = get(handles.dpcons,'String');
    c=str2num(c1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.dpt,'string',t);
else
    set(handles.dpt,'string',t);
end
guidata(hObject, handles)

function dpcons_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function dpperf_Callback(hObject, eventdata, handles)
p1 = get(handles.dpprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.dprcost,'String');
rc=str2num(rc1);
c1 = get(handles.dpcons,'String');
c=str2num(c1);
vp1 = get(handles.dpperf,'String');
vp=str2num(vp1);
r1 = get(handles.dprange,'String');
r=str2num(r1);
e1 = get(handles.dpemiss,'String');
e=str2num(e1);
rf1 = get(handles.dprefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(vp) || vp < 0 || vp > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.dpperf,'Value',0);
    set(handles.dpperf,'String','0');
    mvp=msgbox('Please a value between 0 to 5 for Vehicle Performance','Error Vehicle Performance');
    set( mvp, 'color', [ 0.9 0.9 .9 ] )
  elseif (t1<0)
    set(handles.dpperf,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    vp1 = get(handles.dpperf,'String');
    vp=str2num(vp1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.dpt,'string',t);
else
    set(handles.dpt,'string',t);
end
guidata(hObject, handles)

function dpperf_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dprange_Callback(hObject, eventdata, handles)
p1 = get(handles.dpprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.dprcost,'String');
rc=str2num(rc1);
c1 = get(handles.dpcons,'String');
c=str2num(c1);
vp1 = get(handles.dpperf,'String');
vp=str2num(vp1);
r1 = get(handles.dprange,'String');
r=str2num(r1);
e1 = get(handles.dpemiss,'String');
e=str2num(e1);
rf1 = get(handles.dprefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(r)|| r < 0 || r > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.dprange,'Value',0);
    set(handles.dprange,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Range','Error Range');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.dprange,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    r1 = get(handles.dprange,'String');
    r=str2num(r1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.dpt,'string',t);
else
    set(handles.dpt,'string',t);
end
guidata(hObject, handles)

function dprange_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function dpemiss_Callback(hObject, eventdata, handles)
p1 = get(handles.dpprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.dprcost,'String');
rc=str2num(rc1);
c1 = get(handles.dpcons,'String');
c=str2num(c1);
vp1 = get(handles.dpperf,'String');
vp=str2num(vp1);
r1 = get(handles.dprange,'String');
r=str2num(r1);
e1 = get(handles.dpemiss,'String');
e=str2num(e1);
rf1 = get(handles.dprefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(e)|| e < 0 || e > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.dpemiss,'Value',0);
    set(handles.dpemiss,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Emissions','Error Emissions');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.dpemiss,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    e1 = get(handles.dpemiss,'String');
    e=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.dpt,'string',t);
else
    set(handles.dpt,'string',t);
end
guidata(hObject, handles)

function dpemiss_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dprefuel_Callback(hObject, eventdata, handles)
p1 = get(handles.dpprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.dprcost,'String');
rc=str2num(rc1);
c1 = get(handles.dpcons,'String');
c=str2num(c1);
vp1 = get(handles.dpperf,'String');
vp=str2num(vp1);
r1 = get(handles.dprange,'String');
r=str2num(r1);
e1 = get(handles.dpemiss,'String');
e=str2num(e1);
rf1 = get(handles.dprefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rf)|| rf < 0 || rf > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.dprefuel,'Value',0);
    set(handles.dprefuel,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Refuelling Availibility','Error Refuelling Availibility');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.dprefuel,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rf1 = get(handles.dprefuel,'String');
    rf=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.dpt,'string',t);
else
    set(handles.dpt,'string',t);
end
guidata(hObject, handles)

function dprefuel_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%mpv


function mpvprice_Callback(hObject, eventdata, handles)
p1 = get(handles.mpvprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.mpvrcost,'String');
rc=str2num(rc1);
c1 = get(handles.mpvcons,'String');
c=str2num(c1);
vp1 = get(handles.mpvperf,'String');
vp=str2num(vp1);
r1 = get(handles.mpvrange,'String');
r=str2num(r1);
e1 = get(handles.mpvemiss,'String');
e=str2num(e1);
rf1 = get(handles.mpvrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(p) || p < 0 || p > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.mpvprice,'Value',0);
    set(handles.mpvprice,'String','0');
    mp=msgbox('Please a value between 0 to 5 for Purchase Price','Error Purchase Price');
    set( mp, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.mpvprice,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    p1 = get(handles.mpvprice,'String');
    p=str2num(p1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.mpvt,'string',t);
else
    set(handles.mpvt,'string',t);
end
guidata(hObject, handles)

function mpvprice_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mpvrcost_Callback(hObject, eventdata, handles)
p1 = get(handles.mpvprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.mpvrcost,'String');
rc=str2num(rc1);
c1 = get(handles.mpvcons,'String');
c=str2num(c1);
vp1 = get(handles.mpvperf,'String');
vp=str2num(vp1);
r1 = get(handles.mpvrange,'String');
r=str2num(r1);
e1 = get(handles.mpvemiss,'String');
e=str2num(e1);
rf1 = get(handles.mpvrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rc)|| rc < 0 || rc > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.mpvrcost,'Value',0);
    set(handles.mpvrcost,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.mpvrcost,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rc1 = get(handles.mpvrcost,'String');
    rc=str2num(rc1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.mpvt,'string',t);
else
    set(handles.mpvt,'string',t);
end
guidata(hObject, handles)


function mpvrcost_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function mpvcons_Callback(hObject, eventdata, handles)
p1 = get(handles.mpvprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.mpvrcost,'String');
rc=str2num(rc1);
c1 = get(handles.mpvcons,'String');
c=str2num(c1);
vp1 = get(handles.mpvperf,'String');
vp=str2num(vp1);
r1 = get(handles.mpvrange,'String');
r=str2num(r1);
e1 = get(handles.mpvemiss,'String');
e=str2num(e1);
rf1 = get(handles.mpvrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(c)|| c < 0 || c > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.mpvcons,'Value',0);
    set(handles.mpvcons,'String','0');
    mrc=msgbox('Please a value between 0 to 5 for Running Cost','Error Running Cost');
    set( mrc, 'color', [ 0.9 0.9 .9 ] );
elseif (t1<0)
    set(handles.mpvcons,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    c1 = get(handles.mpvcons,'String');
    c=str2num(c1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.mpvt,'string',t);
else
    set(handles.mpvt,'string',t);
end
guidata(hObject, handles)

function mpvcons_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function mpvperf_Callback(hObject, eventdata, handles)
p1 = get(handles.mpvprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.mpvrcost,'String');
rc=str2num(rc1);
c1 = get(handles.mpvcons,'String');
c=str2num(c1);
vp1 = get(handles.mpvperf,'String');
vp=str2num(vp1);
r1 = get(handles.mpvrange,'String');
r=str2num(r1);
e1 = get(handles.mpvemiss,'String');
e=str2num(e1);
rf1 = get(handles.mpvrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(vp) || vp < 0 || vp > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.mpvperf,'Value',0);
    set(handles.mpvperf,'String','0');
    mvp=msgbox('Please a value between 0 to 5 for Vehicle Performance','Error Vehicle Performance');
    set( mvp, 'color', [ 0.9 0.9 .9 ] )
 elseif (t1<0)
    set(handles.mpvperf,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    vp1 = get(handles.mpvperf,'String');
    vp=str2num(vp1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.mpvt,'string',t);
else
    set(handles.mpvt,'string',t);
end
guidata(hObject, handles)

function mpvperf_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mpvrange_Callback(hObject, eventdata, handles)
p1 = get(handles.mpvprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.mpvrcost,'String');
rc=str2num(rc1);
c1 = get(handles.mpvcons,'String');
c=str2num(c1);
vp1 = get(handles.mpvperf,'String');
vp=str2num(vp1);
r1 = get(handles.mpvrange,'String');
r=str2num(r1);
e1 = get(handles.mpvemiss,'String');
e=str2num(e1);
rf1 = get(handles.mpvrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(r)|| r < 0 || r > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.mpvrange,'Value',0);
    set(handles.mpvrange,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Range','Error Range');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.mpvrange,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    r1 = get(handles.mpvrange,'String');
    r=str2num(r1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.mpvt,'string',t);
else
    set(handles.mpvt,'string',t);
end
guidata(hObject, handles)

function mpvrange_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function mpvemiss_Callback(hObject, eventdata, handles)
p1 = get(handles.mpvprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.mpvrcost,'String');
rc=str2num(rc1);
c1 = get(handles.mpvcons,'String');
c=str2num(c1);
vp1 = get(handles.mpvperf,'String');
vp=str2num(vp1);
r1 = get(handles.mpvrange,'String');
r=str2num(r1);
e1 = get(handles.mpvemiss,'String');
e=str2num(e1);
rf1 = get(handles.mpvrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(e)|| e < 0 || e > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.mpvemiss,'Value',0);
    set(handles.mpvemiss,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Emissions','Error Emissions');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
elseif (t1<0)
    set(handles.mpvemiss,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    e1 = get(handles.mpvemiss,'String');
    e=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.mpvt,'string',t);
else
    set(handles.mpvt,'string',t);
end
guidata(hObject, handles)

function mpvemiss_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mpvrefuel_Callback(hObject, eventdata, handles)
p1 = get(handles.mpvprice,'String');%get the string for the editText component
p=str2num(p1);
rc1 = get(handles.mpvrcost,'String');
rc=str2num(rc1);
c1 = get(handles.mpvcons,'String');
c=str2num(c1);
vp1 = get(handles.mpvperf,'String');
vp=str2num(vp1);
r1 = get(handles.mpvrange,'String');
r=str2num(r1);
e1 = get(handles.mpvemiss,'String');
e=str2num(e1);
rf1 = get(handles.mpvrefuel,'String');
rf=str2num(rf1);
t1=20-(p+rc+c+vp+r+e+rf)
t=num2str(t1)

if (isempty(rf)|| rf < 0 || rf > 5);  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.mpvrefuel,'Value',0);
    set(handles.mpvrefuel,'String','0');
    mr=msgbox('Please a value between 0 to 5 for Refuelling Availibility','Error Refuelling Availibility');
    set( mr, 'color', [ 0.9 0.9 .9 ] )
  elseif (t1<0)
    set(handles.mpvrefuel,'string','0');
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
    rf1 = get(handles.mpvrefuel,'String');
    rf=str2num(e1);
    t1=20-(p+rc+c+vp+r+e+rf);
    t=num2str(t1);
    set(handles.mpvt,'string',t);
else
    set(handles.mpvt,'string',t);
end
guidata(hObject, handles)

function mpvrefuel_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set consumer operation buttons

function consset_Callback(hObject, eventdata, handles) %set button
global CAC %consumer advanced choice
global CAC10 % determines if CAC is set or not
a11=get(handles.mprice,'string');
a1=str2num(a11);
a21=get(handles.smprice,'string');
a2=str2num(a21);
a31=get(handles.lmprice,'string');
a3=str2num(a31);
a41=get(handles.umprice,'string');
a4=str2num(a41);
a51=get(handles.eprice,'string');
a5=str2num(a51);
a61=get(handles.lsprice,'string');
a6=str2num(a61);
a71=get(handles.ssprice,'string');
a7=str2num(a71);
a81=get(handles.dpprice,'string');
a8=str2num(a81);
a91=get(handles.mpvprice,'string');
a9=str2num(a91);
b11=get(handles.mrcost,'string');
b1=str2num(b11);
b21=get(handles.smrcost,'string');
b2=str2num(b21);
b31=get(handles.lmrcost,'string');
b3=str2num(b31);
b41=get(handles.umrcost,'string');
b4=str2num(b41);
b51=get(handles.ercost,'string');
b5=str2num(b51);
b61=get(handles.lsrcost,'string');
b6=str2num(b61);
b71=get(handles.ssrcost,'string');
b7=str2num(b71);
b81=get(handles.dprcost,'string');
b8=str2num(b81);
b91=get(handles.mpvrcost,'string');
b9=str2num(b91);
c11=get(handles.mcons,'string');
c1=str2num(c11);
c21=get(handles.smcons,'string');
c2=str2num(c21);
c31=get(handles.lmcons,'string');
c3=str2num(c31);
c41=get(handles.umcons,'string');
c4=str2num(c41);
c51=get(handles.econs,'string');
c5=str2num(c51);
c61=get(handles.lscons,'string');
c6=str2num(c61);
c71=get(handles.sscons,'string');
c7=str2num(c71);
c81=get(handles.dpcons,'string');
c8=str2num(c81);
c91=get(handles.mpvcons,'string');
c9=str2num(c91);
d11=get(handles.mperf,'string');
d1=str2num(d11);
d21=get(handles.smperf,'string');
d2=str2num(d21);
d31=get(handles.lmperf,'string');
d3=str2num(d31);
d41=get(handles.umperf,'string');
d4=str2num(d41);
d51=get(handles.eperf,'string');
d5=str2num(d51);
d61=get(handles.lsperf,'string');
d6=str2num(d61);
d71=get(handles.ssperf,'string');
d7=str2num(d71);
d81=get(handles.dpperf,'string');
d8=str2num(d81);
d91=get(handles.mpvperf,'string');
d9=str2num(d91);
e11=get(handles.mrange,'string');
e1=str2num(e11);
e21=get(handles.smrange,'string');
e2=str2num(e21);
e31=get(handles.lmrange,'string');
e3=str2num(e31);
e41=get(handles.umrange,'string');
e4=str2num(e41);
e51=get(handles.erange,'string');
e5=str2num(e51);
e61=get(handles.lsrange,'string');
e6=str2num(e61);
e71=get(handles.ssrange,'string');
e7=str2num(e71);
e81=get(handles.dprange,'string');
e8=str2num(e81);
e91=get(handles.mpvrange,'string');
e9=str2num(e91);
f11=get(handles.memiss,'string');
f1=str2num(f11);
f21=get(handles.smemiss,'string');
f2=str2num(f21);
f31=get(handles.lmemiss,'string');
f3=str2num(f31);
f41=get(handles.umemiss,'string');
f4=str2num(f41);
f51=get(handles.eemiss,'string');
f5=str2num(f51);
f61=get(handles.lsemiss,'string');
f6=str2num(f61);
f71=get(handles.ssemiss,'string');
f7=str2num(f71);
f81=get(handles.dpemiss,'string');
f8=str2num(f81);
f91=get(handles.mpvemiss,'string');
f9=str2num(f91);
g11=get(handles.mrefuel,'string');
g1=str2num(g11);
g21=get(handles.smrefuel,'string');
g2=str2num(g21);
g31=get(handles.lmrefuel,'string');
g3=str2num(g31);
g41=get(handles.umrefuel,'string');
g4=str2num(g41);
g51=get(handles.erefuel,'string');
g5=str2num(g51);
g61=get(handles.lsrefuel,'string');
g6=str2num(g61);
g71=get(handles.ssrefuel,'string');
g7=str2num(g71);
g81=get(handles.dprefuel,'string');
g8=str2num(g81);
g91=get(handles.mpvrefuel,'string');
g9=str2num(g91);

t1=20-(a1+b1+c1+d1+e1+f1+g1);
t2=20-(a2+b2+c2+d2+e2+f2+g2);
t3=20-(a3+b3+c3+d3+e3+f3+g3);
t4=20-(a4+b4+c4+d4+e4+f4+g4);
t5=20-(a5+b5+c5+d5+e5+f5+g5);
t6=20-(a6+b6+c6+d6+e6+f6+g6);
t7=20-(a7+b7+c7+d7+e7+f7+g7);
t8=20-(a8+b8+c8+d8+e8+f8+g8);
t9=20-(a9+b9+c9+d9+e9+f9+g9);

a=[a1 a2 a3 a4 a5 a6 a7 a8 a9];
b=[b1 b2 b3 b4 b5 b6 b7 b8 b9];
c=[c1 c2 c3 c4 c5 c6 c7 c8 c9];
d=[d1 d2 d3 d4 d5 d6 d7 d8 d9];
e=[e1 e2 e3 e4 e5 e6 e7 e8 e9];
f=[f1 f2 f3 f4 f5 f6 f7 f8 f9];
g=[g1 g2 g3 g4 g5 g6 g7 g8 g9];

astar = (a1*a2*a3*a4*a5*a6*a7*a8*a9);
bstar = (b1*b2*b3*b4*b5*b6*b7*b8*b9);
cstar = (c1*c2*c3*c4*c5*c6*c7*c8*c9);
dstar = (d1*d2*d3*d4*d5*d6*d7*d8*d9);
estar = (e1*e2*e3*e4*e5*e6*e7*e8*e9);
fstar = (f1*f2*f3*f4*f5*f6*f7*f8*f9);
gstar = (g1*g2*g3*g4*g5*g6*g7*g8*g9);


%y1=get(handles.year,'string');
%y=str2num(y1);

if (t1<0||t2<0||t3<0||t4<0||t5<0||t6<0||t7<0||t8<0||t9<0)
    mp1=msgbox('You have exceeded your maximum allocated points','Error Allocated Points');
    set( mp1, 'color', [ 0.9 0.9 .9 ] )
elseif (t1>0||t2>0||t3>0||t4>0||t5>0||t6>0||t7>0||t8>0||t9>0)
    mp2=msgbox('Please note that you have not allocated all your points','Error Allocated Points');
    set( mp2, 'color', [ 0.9 0.9 .9 ] )
elseif ((astar*bstar*cstar*dstar*estar*fstar*gstar)==0)
    mp2=msgbox('Please note that some of your points are still 0.  Please allocate a value greater than 0','Error Allocated Points');
    set( mp2, 'color', [ 0.9 0.9 .9 ] )
else
CAC=[a;b;c;d;e;f;g];
CAC10=[0]; %purposely set to 0 because at this point we only want this to be a survey! otherwise should be set to 1
dlmwrite('consumer_adv_pref',CAC) 
close
end 


function reset_Callback(hObject, eventdata, handles) % reset button
%reset purchase price
set(handles.mprice,'string',0);
set(handles.smprice,'string',0);
set(handles.lmprice,'string',0);
set(handles.umprice,'string',0);
set(handles.eprice,'string',0);
set(handles.lsprice,'string',0);
set(handles.ssprice,'string',0);
set(handles.dpprice,'string',0);
set(handles.mpvprice,'string',0);

%reset running costs
set(handles.mrcost,'string',0);
set(handles.smrcost,'string',0);
set(handles.lmrcost,'string',0);
set(handles.umrcost,'string',0);
set(handles.ercost,'string',0);
set(handles.lsrcost,'string',0);
set(handles.ssrcost,'string',0);
set(handles.dprcost,'string',0);
set(handles.mpvrcost,'string',0);

%reset fuel consumption
set(handles.mcons,'string',0);
set(handles.smcons,'string',0);
set(handles.lmcons,'string',0);
set(handles.umcons,'string',0);
set(handles.econs,'string',0);
set(handles.lscons,'string',0);
set(handles.sscons,'string',0);
set(handles.dpcons,'string',0);
set(handles.mpvcons,'string',0);

%reset vehicle performance
set(handles.mperf,'string',0);
set(handles.smperf,'string',0);
set(handles.lmperf,'string',0);
set(handles.umperf,'string',0);
set(handles.eperf,'string',0);
set(handles.lsperf,'string',0);
set(handles.ssperf,'string',0);
set(handles.dpperf,'string',0);
set(handles.mpvperf,'string',0);

%reset refuelling
set(handles.mrefuel,'string',0);
set(handles.smrefuel,'string',0);
set(handles.lmrefuel,'string',0);
set(handles.umrefuel,'string',0);
set(handles.erefuel,'string',0);
set(handles.lsrefuel,'string',0);
set(handles.ssrefuel,'string',0);
set(handles.dprefuel,'string',0);
set(handles.mpvrefuel,'string',0);

%reset range
set(handles.mrange,'string',0);
set(handles.smrange,'string',0);
set(handles.lmrange,'string',0);
set(handles.umrange,'string',0);
set(handles.erange,'string',0);
set(handles.lsrange,'string',0);
set(handles.ssrange,'string',0);
set(handles.dprange,'string',0);
set(handles.mpvrange,'string',0);

%reset emissions
set(handles.memiss,'string',0);
set(handles.smemiss,'string',0);
set(handles.lmemiss,'string',0);
set(handles.umemiss,'string',0);
set(handles.eemiss,'string',0);
set(handles.lsemiss,'string',0);
set(handles.ssemiss,'string',0);
set(handles.dpemiss,'string',0);
set(handles.mpvemiss,'string',0);




function cancel_Callback(hObject, eventdata, handles)
global CAC10
global CAC
CAC10=[0];
CAC=[0];
close()


function year_Callback(hObject, eventdata, handles)


function year_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
