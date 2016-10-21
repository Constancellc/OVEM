function varargout = ovemplus(varargin)
% OVEMPLUS MATLAB code for ovemplus.fig
%      OVEMPLUS, by itself, creates a new OVEMPLUS or raises the existing
%      singleton*.
%
%      H = OVEMPLUS returns the handle to a new OVEMPLUS or the handle to
%      the existing singleton*.
%
%      OVEMPLUS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OVEMPLUS.M with the given input arguments.
%
%      OVEMPLUS('Property','Value',...) creates a new OVEMPLUS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ovemplus_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ovemplus_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ovemplus

% Last Modified by GUIDE v2.5 09-Feb-2012 22:43:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ovemplus_OpeningFcn, ...
                   'gui_OutputFcn',  @ovemplus_OutputFcn, ...
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


% --- Executes just before ovemplus is made visible.
function ovemplus_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ovemplus (see VARARGIN)

% Choose default command line output for ovemplus
handles.output = hObject;

global SPD
global VP
global PS
global EP
global MP
global T
global VR
global SET
global SETVC %set vehicle comparison

SPD=[0 0 0];
VP=[0 0 0 0 0 0]; % rests all the global variables on cancel
PS=[0 0 0 0];
EP=[0 0 0];
MP=[0 0 0];
T=[0 0 0 0 0 0];
VR=[0 0];
SET=[0];
SETVC=[0];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ovemplus wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ovemplus_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

axes(handles.axes1); % sets white background

axes(handles.axes5);
imshow('ovemlogo1.png'); % sets ovemlogo
axes(handles.axes6);
imshow('ovemlogo2.tiff'); % sets ovem+ text

%%%%%%%%%%%%%%%%%%%%%%%%%%
%buttons

% about OVEM +
% This button just brings up a text box with information
function about_Callback(hObject, eventdata, handles)
mo1=msgbox('Oxford Vehicle Emissions Modelling Plus (OVEM+) is a set of tools to simulate possible technology scenarios and consumer behaviour, and allows to forsee how this affects the diffusion of different vehicles into the road transport market.  The Vehicle Modelling enables you to design and simulate the peformance of vehicle with various powertrain technologies.  A second part within the vehicle model, Paramatric Analysis simulates how various components contribute to the vehicle performance.  On the otherhand, Probability Analysis allows to foecast how consumer behavious and legislation may effect the trends in transportation and emissions. OVEM+ is the result of a study performed by the Institute for Carbon and Energy Reduction in Transport (ICERT) within the University of Oxford.','about OVEM+');
set( mo1, 'color', [ 0.9 0.9 .9 ] )

% help
% Also just a text box
function help_Callback(hObject, eventdata, handles)
mo2=msgbox('OVEM+ is a set of tools to simulate possible technology scenarios and consumer behaviour, and allows to forsee how this affects the diffusion of different vehicles into the road transport market.  The Vehicle Modelling enables you to design and simulate the peformance of vehicle with various powertrain technologies.  A second part within the vehicle model, Paramatric Analysis simulates how various components contribute to the vehicle performance.  On the otherhand, Probability Analysis allows to foecast how consumer behavious and legislation may effect the trends in transportation and emissions.  Please select Vehicle Modelling to get started', 'help!');
set( mo2, 'color', [ 0.9 0.9 .9 ] )

% Vehicle Modelling
function vmod_Callback(hObject, eventdata, handles)
    global SPD
    if((SPD(1)>1)&&(SPD(2)>1)&&(SPD(3)>1))
    else 
        SPD= [1 1 1];
    end
vmod1


% Vehicle Sweep
% Opens new GUI 'para1'
function VS_Callback(hObject, eventdata, handles)
para1

% Consumer Model
% Opens new GUI 'proba1'
function ConsM_Callback(hObject, eventdata, handles)
proba1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%notes
% check how to rsume uce, electric and hybrid, similar to what you did on
% vmod

%blank the first part of para.  put an not available note and allow only
%the 2nd part of it

%policy intervention values not showing and year for pi

%policy intervention year should be taken from consumer

%consumer, set B in icert before the ovem loop as B_pp etc

