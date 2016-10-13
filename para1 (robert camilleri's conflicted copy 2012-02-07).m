function varargout = para1(varargin)
% PARA1 MATLAB code for para1.fig
%      PARA1, by itself, creates a new PARA1 or raises the existing
%      singleton*.
%
%      H = PARA1 returns the handle to a new PARA1 or the handle to
%      the existing singleton*.
%
%      PARA1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARA1.M with the given input arguments.
%
%      PARA1('Property','Value',...) creates a new PARA1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before para1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to para1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help para1

% Last Modified by GUIDE v2.5 05-Jan-2012 19:55:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @para1_OpeningFcn, ...
                   'gui_OutputFcn',  @para1_OutputFcn, ...
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


% --- Executes just before para1 is made visible.
function para1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to para1 (see VARARGIN)


set(handles.userchoice,'SelectionChangeFcn',@userchoice_SelectionChangeFcn)


global SPD; %SPD=[SMMT powertrain drivecycle]

SCC=SPD(1)-1;
smmtcategories = {'Mini' 'Super Mini' 'Lower Medium' 'Upper Medium' 'Executive' 'Luxury Saloon' 'Specialists Sports' 'Dual Purpose' 'MPV'};
bestselling = {'Hyundai i10' 'Ford Fiesta' 'Ford Focus' 'BMW 3 Series' 'Mercedes-Benz C Class' 'Mercedes-Benz S Class' 'Volkswagen Scirocco' 'Honda CR-V' 'Vauxhall Zafira'};
SPC=SPD(2)-1;
powertrain = {'ICE' 'Hybrid' 'Electric'};
SDC=SPD(3)-1;
drivecycle = {'NEDC' 'Artemis' 'FUDS' 'NYCC' 'US06' 'US HWFET' 'US EPA'};


if ((SPD(1)>1)&&(SPD(2)>1)&&(SPD(3)>1))
    
set(handles.smmt2,'string',smmtcategories{SCC});
set(handles.best2,'string',bestselling{SCC});
set(handles.powertrain2,'string',powertrain{SPC});
set(handles.drivecycle2,'string',drivecycle{SDC});
else
end


% Choose default command line output for para1
handles.output = hObject;




% Update handles structure
guidata(hObject, handles);

% UIWAIT makes para1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = para1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

axes(handles.axes1); % this is used to set focus on the axes currently in use


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%top three buttons 


function aboutpara_Callback(hObject, eventdata, handles)
mp1=msgbox('Parametric Analysis enables to study the effect of one vehicle parameter on the vehicle performance.  On the otherhand, Vehicle Comparison enables to compare various powertrains and SMMT Categories', 'parametric analysis');
set( mp1, 'color', [ 0.9 0.9 .9 ] )


function helppara_Callback(hObject, eventdata, handles)
mp2=msgbox('Run the Vehicle Sweep.  Then choose which values you wish to plot', 'help!');
set( mp2, 'color', [ 0.9 0.9 .9 ] )

function back_Callback(hObject, eventdata, handles)
global OVEM_31OK
OVEM_31OK(1)=[0]

%you should set global variables to be 0 not individual parameters!
    set(handles.ll1,'string','0');
    
    set(handles.ul1,'string','0');
 
set(handles.startp2,'string','0');
set(handles.stepsp2,'string','0');
set(handles.incrementp2,'string','0');
set(handles.finalp2,'string','0');
set(handles.comparesame,'value',1);
set(handles.fordifferent,'value',1);
close()

%cancel also the parrs inserted in first part of para


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%parametric analysis


function userchoice_SelectionChangeFcn(hObject, eventdata)
handles=guidata(hObject);
p1=get(handles.parameter1,'value');
p2=get(handles.parameter2,'value');
p3=get(handles.comparesame,'value');
p4=get(handles.fordifferent,'value');

global OVEM_31OK
%c11 = get(handles.constant,'string');
%c=str2num(c11);
%c12 = get(handles.constant1,'string');
%c1=str2num(c12);

switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
    case 'parametric'
        mpara=msgbox('Sorry, the Parametric Analysis is still inactive.', 'Parametric Analysis');
    set( mpara, 'color', [ 0.9 0.9 .9 ] )
    %    set(handles.parameter1,'visible','on'); %was commented out from here
     %   set(handles.parameter2,'visible','off');
     %   set(handles.plotxpara,'visible','on');
     %   set(handles.plotypara,'visible','on');
     %   set(handles.reference,'visible','on');
     %   set(handles.gopara,'visible','on');
     %   set(handles.cancelpara,'visible','on');
     %   if(p1==1)
     %       set(handles.parameterpop1,'visible','on');
    %set(handles.ll,'visible','on');
    %set(handles.ll1,'visible','on');
    %set(handles.llp,'visible','on');
    %set(handles.sv,'visible','on');
    %set(handles.sv1,'visible','on');
    %set(handles.sv1,'string','0');
    %set(handles.ul,'visible','on');
    %set(handles.ul1,'visible','on');
    %set(handles.ulp,'visible','on');
    %set(handles.fv,'visible','on');
    %set(handles.fv1,'visible','on');
    %set(handles.ll1,'string','0');
    %set(handles.fv1,'string','0');
    %    else
     %       set(handles.parameterpop1,'visible','off');
    %set(handles.ll,'visible','off');
    %set(handles.ll1,'visible','off');
    %set(handles.llp,'visible','off');
    %set(handles.sv,'visible','off');
    %set(handles.sv1,'visible','off');
    %set(handles.sv1,'string','0');
    %set(handles.ul,'visible','off');
    %set(handles.ul1,'visible','off');
    %set(handles.ulp,'visible','off');
    %set(handles.fv,'visible','off');
    %set(handles.fv1,'visible','off');
    %set(handles.ll1,'string','0');
    %set(handles.fv1,'string','0');
    %    end
    %    if(p2==1)
    %    set(handles.parameterpop2,'visible','on');
    %    set(handles.startp2,'visible','on');
    %    set(handles.stepsp2,'visible','on');
    %    set(handles.incrementp2,'visible','on');
    %    set(handles.finalp2,'visible','on');
    %    set(handles.startt2,'visible','on');
    %    set(handles.stepst2,'visible','on');
    %    set(handles.incrementt2,'visible','on');
    %    set(handles.finalt2,'visible','on');
    %    else
    %        set(handles.parameterpop2,'visible','off');
    %    set(handles.startp2,'visible','off');
    %    set(handles.stepsp2,'visible','off');
    %    set(handles.incrementp2,'visible','off');
    %    set(handles.finalp2,'visible','off');
    %    set(handles.startt2,'visible','off');
    %    set(handles.stepst2,'visible','off');
    %    set(handles.incrementt2,'visible','off');
    %    set(handles.finalt2,'visible','off');
    %    end %was commented out till here
        set(handles.comparesame,'visible','off');
        set(handles.fordifferent,'visible','off');
        set(handles.constant,'visible','off');
        set(handles.constant1,'visible','off');
        set(handles.gocompare,'visible','off');
        set(handles.plotcompare,'visible','off');
        set(handles.plotycompare,'visible','off');
        set(handles.proba,'visible','off');
    otherwise
        if OVEM_31OK(1)==0
        set(handles.parameter1,'visible','off');
        set(handles.parameter2,'visible','off');
        set(handles.plotxpara,'visible','off');
        set(handles.plotypara,'visible','off');
        set(handles.reference,'visible','off');
        set(handles.gopara,'visible','off');
        set(handles.cancelpara,'visible','off');
        set(handles.parameterpop1,'visible','off');
        set(handles.parameterpop1,'visible','off');
    set(handles.ll,'visible','off');
    set(handles.ll1,'visible','off');
    set(handles.llp,'visible','off');
    set(handles.sv,'visible','off');
    set(handles.sv1,'visible','off');
    set(handles.sv1,'string','0');
    set(handles.ul,'visible','off');
    set(handles.ul1,'visible','off');
    set(handles.ulp,'visible','off');
    set(handles.fv,'visible','off');
    set(handles.fv1,'visible','off');
    set(handles.ll1,'string','0');
    set(handles.fv1,'string','0');
        set(handles.parameterpop2,'visible','off');
        set(handles.startp2,'visible','off');
        set(handles.stepsp2,'visible','off');
        set(handles.incrementp2,'visible','off');
        set(handles.finalp2,'visible','off');
        set(handles.startt2,'visible','off');
        set(handles.stepst2,'visible','off');
        set(handles.incrementt2,'visible','off');
        set(handles.finalt2,'visible','off');
        set(handles.comparesame,'visible','off');
        set(handles.fordifferent,'visible','off');
        set(handles.gocompare,'visible','on');
        set(handles.plotycompare,'visible','off');
        set(handles.plotcompare,'visible','off');
        set(handles.constant,'visible','off');
        set(handles.constant1,'visible','off');
        set(handles.proba,'visible','off');
        elseif OVEM_31OK(1)==1
        set(handles.parameter1,'visible','off');
        set(handles.parameter2,'visible','off');
        set(handles.plotxpara,'visible','off');
        set(handles.plotypara,'visible','off');
        set(handles.reference,'visible','off');
        set(handles.gopara,'visible','off');
        set(handles.cancelpara,'visible','off');
        set(handles.parameterpop1,'visible','off');
      set(handles.ll,'visible','off');
    set(handles.ll1,'visible','off');
    set(handles.llp,'visible','off');
    set(handles.sv,'visible','off');
    set(handles.sv1,'visible','off');
    set(handles.sv1,'string','0');
    set(handles.ul,'visible','off');
    set(handles.ul1,'visible','off');
    set(handles.ulp,'visible','off');
    set(handles.fv,'visible','off');
    set(handles.fv1,'visible','off');
    set(handles.ll1,'string','0');
    set(handles.fv1,'string','0'); 
        set(handles.parameterpop2,'visible','off');
        set(handles.startp2,'visible','off');
        set(handles.stepsp2,'visible','off');
        set(handles.incrementp2,'visible','off');
        set(handles.finalp2,'visible','off');
        set(handles.startt2,'visible','off');
        set(handles.stepst2,'visible','off');
        set(handles.incrementt2,'visible','off');
        set(handles.finalt2,'visible','off');
        set(handles.comparesame,'visible','on');
        set(handles.fordifferent,'visible','on');
        set(handles.gocompare,'visible','on');
        set(handles.plotycompare,'visible','on');
        set(handles.plotcompare,'visible','on');
        set(handles.constant,'visible','on');
        set(handles.constant1,'visible','on');
        set(handles.proba,'visible','on');
            %((p3>1)&&(p4>1))
        %set(handles.constant,'visible','on');
        %set(handles.constant1,'visible','on');
        %else
        %set(handles.constant,'visible','off');
        %set(handles.constant1,'visible','off');
        end
end


function vehicle_para1_Callback(hObject, eventdata, handles)

function vehicle_para1_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ll1_Callback(hObject, eventdata, handles)
%store the contents of input1_editText as a string. if the string is not a number then input will be empty
input = str2num(get(hObject,'String'));
if (isempty(input))%checks to see if input is empty. if so, default input1_editText to zero
     set(hObject,'String','0')
end
guidata(hObject, handles);

p1=get(handles.parameterpop1,'value');
if (p1==1)
    m23=msgbox('Please select a vehicle parameter', 'error vehicle parameter');
    set( m23, 'color', [ 0.9 0.9 .9 ] )
end

a = get(handles.ll1,'String');
b = get(handles.stepsp1,'String');
c = get(handles.incrementp1,'String');% a, b, c are variables of Strings type, and need to be converted to variables of Number type before they can be added together
total = str2num(a) + (str2num(b) * str2num(c));% need to convert the answer back into String type to display it
d = num2str(total);

if ((p1==2||p1==3||p1==3||p1==4||p1==5)&&(total>100))
    m11=msgbox('Please note that the final value cannot be > 100', 'error start');
    set( m11, 'color', [ 0.9 0.9 .9 ] )
else
set(handles.fv1,'String',d);
end

guidata(hObject, handles);

function ll1_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function ul1_Callback(hObject, eventdata, handles)


function ul1_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function stepsp1_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
if (isempty(input))%checks to see if input is empty. if so, default input1_editText to zero
     set(hObject,'String','0')
end

p1=get(handles.parameterpop1,'value');
if (p1==1)
    m23=msgbox('Please select a vehicle parameter', 'error vehicle parameter');
    set( m23, 'color', [ 0.9 0.9 .9 ] )
end 
a = get(handles.ll1,'String');
b = get(handles.stepsp1,'String');
c = get(handles.incrementp1,'String');% a, b, c are variables of Strings type, and need to be converted to variables of Number type before they can be added together
total = str2num(a) + (str2num(b) * str2num(c));% need to convert the answer back into String type to display it
d = num2str(total);

if ((p1==2||p1==3||p1==3||p1==4||p1==5)&&(total>100))
    m12=msgbox('Please note that the final value cannot be > 100', 'error steps');
    set( m12, 'color', [ 0.9 0.9 .9 ] )
else
set(handles.fv1,'String',d);
end
guidata(hObject, handles);

function stepsp1_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function incrementp1_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
if (isempty(input))%checks to see if input is empty. if so, default input1_editText to zero
     set(hObject,'String','0')
end

p1=get(handles.parameterpop1,'value');
if (p1==1)
    m23=msgbox('Please select a vehicle parameter', 'error vehicle parameter');
    set( m23, 'color', [ 0.9 0.9 .9 ] )
end
a = get(handles.ll1,'String');
b = get(handles.stepsp1,'String');
c = get(handles.incrementp1,'String');% a, b, c are variables of Strings type, and need to be converted to variables of Number type before they can be added together
total = str2num(a) + (str2num(b) * str2num(c));% need to convert the answer back into String type to display it
d = num2str(total);

if ((p1==2||p1==3||p1==3||p1==4||p1==5)&&(total>100))
    m13=msgbox('Please note that the final value cannot be > 100', 'error increment');
    set( m13, 'color', [ 0.9 0.9 .9 ] )
else
set(handles.fv1,'String',d);
end

guidata(hObject, handles);

function incrementp1_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function fv1_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%parameter2

function startp2_Callback(hObject, eventdata, handles)
%store the contents of input1_editText as a string. if the string is not a number then input will be empty
input = str2num(get(hObject,'String'));
if (isempty(input))%checks to see if input is empty. if so, default input1_editText to zero
     set(hObject,'String','0')
end
guidata(hObject, handles);

p2=get(handles.parameterpop2,'value');
if (p2==1)
    m23=msgbox('Please select a vehicle parameter', 'error vehicle parameter');
    set( m23, 'color', [ 0.9 0.9 .9 ] )
end
e = get(handles.startp2,'String');
f = get(handles.stepsp2,'String');
g = get(handles.incrementp2,'String');
total = str2num(e) + (str2num(f) * str2num(g));% need to convert the answer back into String type to display it
h = num2str(total);

if ((p2==2||p2==3||p2==3||p2==4||p2==5)&&(total>100))
    m21=msgbox('Please note that the final value cannot be > 100', 'error start');
    set( m21, 'color', [ 0.9 0.9 .9 ] )
else
set(handles.finalp2,'String',h);
end
guidata(hObject, handles);


function startp2_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function stepsp2_Callback(hObject, eventdata, handles)
%store the contents of input1_editText as a string. if the string is not a number then input will be empty
input = str2num(get(hObject,'String'));
if (isempty(input))%checks to see if input is empty. if so, default input1_editText to zero
     set(hObject,'String','0')
end
guidata(hObject, handles);

p2=get(handles.parameterpop2,'value');
if (p2==1)
    m23=msgbox('Please select a vehicle parameter', 'error vehicle parameter');
    set( m23, 'color', [ 0.9 0.9 .9 ] )
end

e = get(handles.startp2,'String');
f = get(handles.stepsp2,'String');
g = get(handles.incrementp2,'String');
total = str2num(e) + (str2num(f) * str2num(g));% need to convert the answer back into String type to display it
h = num2str(total);

if ((p2==2||p2==3||p2==3||p2==4||p2==5)&&(total>100))
    m22=msgbox('Please note that the final value cannot be > 100', 'error steps');
    set( m22, 'color', [ 0.9 0.9 .9 ] )
else
set(handles.finalp2,'String',h);
end
guidata(hObject, handles);

function stepsp2_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function incrementp2_Callback(hObject, eventdata, handles)
%store the contents of input1_editText as a string. if the string is not a number then input will be empty
input = str2num(get(hObject,'String'));
if (isempty(input))%checks to see if input is empty. if so, default input1_editText to zero
     set(hObject,'String','0')
end
guidata(hObject, handles);

p2=get(handles.parameterpop2,'value');
if (p2==1)
    m23=msgbox('Please select a vehicle parameter', 'error vehicle parameter');
    set( m23, 'color', [ 0.9 0.9 .9 ] )
end

e = get(handles.startp2,'String');
f = get(handles.stepsp2,'String');
g = get(handles.incrementp2,'String');
total = str2num(e) + (str2num(f) * str2num(g));
h = num2str(total);% need to convert the answer back into String type to display it

if ((p2==2||p2==3||p2==3||p2==4||p2==5)&&(total>100))
    m23=msgbox('Please note that the final value cannot be > 100', 'error increment');
    set( m23, 'color', [ 0.9 0.9 .9 ] )
else
set(handles.finalp2,'String',h);
end

guidata(hObject, handles);


function incrementp2_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function finalp2_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function edit5_Callback(hObject, eventdata, handles)


function edit5_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function pushbutton9_Callback(hObject, eventdata, handles)





function edit6_Callback(hObject, eventdata, handles)


function edit6_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit7_Callback(hObject, eventdata, handles)


function edit7_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit8_Callback(hObject, eventdata, handles)


function edit8_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function parameterpop1_Callback(hObject, eventdata, handles)


function parameterpop1_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function parameter1_Callback(hObject, eventdata, handles)
p1=get(handles.parameter1,'value')
if(p1==0)
    set(handles.parameterpop1,'visible','off');
    set(handles.ll,'visible','off');
    set(handles.ll1,'visible','off');
    set(handles.llp,'visible','off');
    set(handles.sv,'visible','off');
    set(handles.sv1,'visible','off');
    set(handles.sv1,'string','0');
    set(handles.ul,'visible','off');
    set(handles.ul1,'visible','off');
    set(handles.ulp,'visible','off');
    set(handles.fv,'visible','off');
    set(handles.fv1,'visible','off');
    set(handles.ll1,'string','0');
    set(handles.fv1,'string','0');
else
    set(handles.parameterpop1,'visible','on');
    set(handles.ll,'visible','on');
    set(handles.ll1,'visible','on');
    set(handles.llp,'visible','on');
    set(handles.sv,'visible','on');
    set(handles.sv1,'visible','on');
    set(handles.sv1,'string','0');
    set(handles.ul,'visible','on');
    set(handles.ul1,'visible','on');
    set(handles.ulp,'visible','on');
    set(handles.fv,'visible','on');
    set(handles.fv1,'visible','on');
    set(handles.ll1,'string','0');
    set(handles.fv1,'string','0');
end


function parameterpop2_Callback(hObject, eventdata, handles)


function parameterpop2_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function parameter2_Callback(hObject, eventdata, handles)
p2=get(handles.parameter2,'value')
if(p2==0)
    set(handles.parameterpop2,'visible','off');
    set(handles.startt2,'visible','off');
    set(handles.stepst2,'visible','off');
    set(handles.incrementt2,'visible','off');
    set(handles.finalt2,'visible','off');
    set(handles.startp2,'visible','off');
    set(handles.startp2,'string','0');
    set(handles.stepsp2,'visible','off');
    set(handles.stepsp2,'string','0');
    set(handles.incrementp2,'visible','off');
    set(handles.incrementp2,'string','0');
    set(handles.finalp2,'visible','off');
    set(handles.finalp2,'string','0');
else
    set(handles.parameterpop2,'visible','on');
    set(handles.startt2,'visible','on');
    set(handles.stepst2,'visible','on');
    set(handles.incrementt2,'visible','on');
    set(handles.finalt2,'visible','on');
    set(handles.startp2,'visible','on');
    set(handles.startp2,'string','0');
    set(handles.stepsp2,'visible','on');
    set(handles.stepsp2,'string','0');
    set(handles.incrementp2,'visible','on');
    set(handles.incrementp2,'string','0');
    set(handles.finalp2,'visible','on');
    set(handles.finalp2,'string','0');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%para control buttons


function gopara_Callback(hObject, eventdata, handles)
%global variables carried forward from vmod1
global SPD
global VP %VP=[0 0 0 0 0 0]
global PS
global EP
global MP
global T
global VR

%new global variables to define variations in parameters
global SVP1  %[parameter choice1, 1, 2, 3, 4]
global SVP2 % [parameter choice2, 1, 2, 3, 4]

p1=get(handles.parameter1,'value');
p2=get(handles.parameter2,'value');
if (p1==0 && p2==0)
mp=msgbox('please select a parameter.','Vehicle Parameter');
set( mp, 'color', [ 0.9 0.9 .9 ] )
elseif (p1==1 && p2==0)
    SVP2=[1] %put as 1 so that when you insert it in for i=1:SVP2(1) it will only run the loop once
end
%ovem32 but keep all the results from ovem31
    

function plotxpara_Callback(hObject, eventdata, handles)


function plotxpara_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function plotypara_Callback(hObject, eventdata, handles)


function plotypara_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function reference_Callback(hObject, eventdata, handles)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%vehicle compare

function comparesame_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function comparesame_Callback(hObject, eventdata, handles)
cs=get(handles.comparesame,'value');
fd=get(handles.fordifferent,'value');
if(cs==2&&fd==3)||(cs==3&&fd==2);
    set(handles.constant,'visible','on');
    set(handles.constant1,'visible','on');
    set(handles.constant1,'string','Drivecycle');
    set(handles.plotycompare,'visible','on');
    set(handles.plotcompare,'visible','on');
    set(handles.proba,'visible','on');
else
    set(handles.constant,'visible','off');
    set(handles.constant1,'visible','off');
    set(handles.plotycompare,'visible','off');
    set(handles.plotcompare,'visible','off');
    set(handles.proba,'visible','off');
end


function fordifferent_Callback(hObject, eventdata, handles)
cs=get(handles.comparesame,'value');
fd=get(handles.fordifferent,'value');
if(cs==2&&fd==3)||(cs==3&&fd==2);
    set(handles.constant,'visible','on');
    set(handles.constant1,'visible','on');
    set(handles.constant1,'string','Drivecycle');
    set(handles.plotycompare,'visible','on');
    set(handles.plotcompare,'visible','on');
    set(handles.proba,'visible','on');
else
    set(handles.constant,'visible','off');
    set(handles.constant1,'visible','off');
    set(handles.plotycompare,'visible','off');
    set(handles.plotcompare,'visible','off');
    set(handles.proba,'visible','off');
end


function fordifferent_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%results

    
function gocompare_Callback(hObject, eventdata, handles)
global OVEM_31OK       
OVEM_31=[0];
ovem_31();   

if OVEM_31OK(1)==1
    mchoose=msgbox('vehicle Sweep Done! Please select from the comparison options.','Vehicle Comparison');
   set( mchoose, 'color', [ 0.9 0.9 .9 ] )
    set(handles.comparesame,'visible','on');
    set(handles.fordifferent,'visible','on');
else
    set(handles.comparesame,'visible','off');
    set(handles.fordifferent,'visible','off');
    set(handles.constant,'visible','off');
    set(handles.constant1,'visible','off');
    set(handles.plotycompare,'visible','off')
    set(handles.plotcompare,'visible','off')
    set(handles.proba,'visible','off');
end


        
function plotycompare_Callback(hObject, eventdata, handles)



function plotycompare_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function plotcompare_Callback(hObject, eventdata, handles)
global PLOTX
global SPD
global PS

pt=SPD(2); %powertrain, 2=ice, %3=hyb, 4=ev
ft=PS(3); %fueltype, 1=petrol, 0=diesel
ht=PS(1); %hybrid type, 1=series, 2=dual, 3=plugin 
eb=PS(2); %hybrid engine type, 1=ice, 0=fuelcell

%pet, die, hyb, phyb, ev, fc = 5, 6, 4, 16, 1, 15
%changed these values to 1, 2 , 3, 4, 5, 6 to extract vectors from matrix

if pt==4;
   %powertrain_type = [1]; %electric
   pwrtrain=[5];
elseif pt==2;
    if ft==1;
        %powertrain_type = [5]; %petrol
        pwrtrain=[1]; 
    elseif ft==0;
        %powertrain_type = [6]; %diesel
        pwrtrain=[2];
    end
elseif pt==3;
    if ht==3;
        %powertrain_type = [16]; %plugin hybrid
        pwrtrain=[4];
    elseif (ht==1||ht==2)&&(eb==0);
            %powertrain_type = [15]; %fuel cell
            pwrtrain=[6];
    elseif (ht==1)&&(eb==1);
            %powertrain_type = [4]; %hybrid 
            pwrtrain=[3];
    elseif (ht==2)&&(eb==1);
            %powertrain_type = [4]; %hybrid
            pwrtrain=[3];
        end
end


global VCOMP
global MJKM
global GHGKM
global NCC
global MJKMWTW
global GHGKMWTW
global SCC
global PWT


cs=get(handles.comparesame,'value');
fd=get(handles.fordifferent,'value');
c1=fd+1;
py=get(handles.plotycompare,'value');


VCOMP=[cs fd c1 py];
SCC=(SPD(1)-1);
PWT=(pwrtrain(1));
if ((VCOMP(1)==2) && (VCOMP(2)==3))
    if py==1;
    pchoose=msgbox('please select a value from the plot y-axis','Error Plot y-axis');
   set( pchoose, 'color', [ 0.9 0.9 .9 ] )
    elseif py==2 ;    
        PLOTX=MJKM(SCC,:);
        plot_results
    elseif py==3 ;
        PLOTX=GHGKM(SCC,:);
        plot_results
    elseif py==4;
        PLOTX=NCC(SCC,:);
        plot_results
    end
elseif ((VCOMP(1)==3) && (VCOMP(2)==2))
    if py==1;
    pchoose=msgbox('please select a value from the plot y-axis','Error Plot y-axis');
   set( pchoose, 'color', [ 0.9 0.9 .9 ] )
    elseif py==2;
           PLOTX=MJKM(:,PWT);
           plot_results
    elseif py==3;
           PLOTX=GHGKM(:,PWT);
           plot_results
    elseif py==4;
           PLOTX=NCC(:,PWT);
           plot_results
    end  
end


function plotcompare_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function proba_Callback(hObject, eventdata, handles)
global CONSUMEROK
CONSUMEROK=[0]
proba1
