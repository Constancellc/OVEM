function varargout = ice(varargin)
% ICE MATLAB code for ice.fig
%      ICE, by itself, creates a novice ICE or raises the existing
%      singleton*.
%
%      H = ICE returns the handle to a novice ICE or the handle to
%      the existing singleton*.
%
%      ICE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ICE.M with the given input arguments.
%
%      ICE('Property','Value',...) creates a novice ICE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ice_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ice_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ice

% Last Modified by GUIDE v2.5 30-Nov-2011 10:03:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ice_OpeningFcn, ...
                   'gui_OutputFcn',  @ice_OutputFcn, ...
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


% --- Executes just before ice is made visible.
function ice_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ice (see VARARGIN)

global SPD;
SCC=SPD(1)-1;               % Index of selected SMMT
smmtcategories = {'Mini' 'Super Mini' 'Lower Medium' 'Upper Medium' 'Executive' 'Luxury Saloon' 'Specialists Sports' 'Dual Purpose' 'MPV'};
bestselling = {'Hyundai i10' 'Ford Fiesta' 'Ford Focus' 'BMW 3 Series' 'Mercedes-Benz C Class' 'Mercedes-Benz S Class' 'Volkswagen Scirocco' 'Honda CR-V' 'Vauxhall Zafira'};

% Adds strings containing the chosen SMMT catergory and the best selling
% model from that category to the structure
set(handles.smmttext,'string',smmtcategories{SCC});
set(handles.bestsellingtext,'string',bestselling{SCC});

guidata(hObject, handles);

set(handles.fuel_type,'SelectionChangeFcn',@fuel_type_SelectionChangeFcn)
set(handles.gearboxtype,'SelectionChangeFcn',@gearboxtype_SelectionChangeFcn)

global VP
% If vehicle parameters have been set already add them to the structure
if (VP(1)>0)
    % Why strings??
    set(handles.drag,'string',VP(1));
    set(handles.frontalarea, 'string',VP(2));
    set(handles.weight, 'string',VP(3));
    set(handles.wheeldrive, 'string',VP(4));
    set(handles.tyrediam, 'string',VP(5));
    set(handles.tyreroll, 'string',VP(6));    
% Otherwise store zeros. This is stupid, they already contain zeros
else 
    set(handles.drag, 'string','0');
    set(handles.frontalarea, 'string','0');
    set(handles.weight, 'string','0');
    set(handles.wheeldrive, 'string','0');
    set(handles.tyrediam, 'string','0');
    set(handles.tyreroll, 'string','0');
end

global PS

% Same stupid shit
global EP
if (EP(1)>0)
set(handles.enginesize, 'string', EP(1));
set(handles.etorque,'string', EP(2));
set(handles.epower,'string', EP(3));
else 
set(handles.enginesize, 'string', '0');
set(handles.etorque,'string','0');
set(handles.epower,'string','0');
end

%... And again
global T
if(T(2)>0)
    set(handles.gbspd, 'string', T(2));
set(handles.tgratio, 'string', T(3));
set(handles.fgratio, 'string', T(4));
set(handles.gbeffy, 'string', T(5));
set(handles.axleffy, 'string', T(6));
else
    set(handles.gbspd, 'string', '0');
set(handles.tgratio, 'string', '0');
set(handles.fgratio, 'string', '0');
set(handles.gbeffy, 'string', '0');
set(handles.axleffy, 'string', '0');
end

% Dear god
global VR
if (VR(1)>0)
    set(handles.range,'string',VR(1));
else
    set(handles.range,'string','0');
end

global MP

guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = ice_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1); % this is used to set focus on the axes currently in use


global SPD; % set car picture depending on which smmt category chosen in vmod1
SCC=SPD(1)-1;
picture = {'1.tiff' '2.tiff' '3.tiff' '4.tiff' '5.tiff' '6.tiff' '7.tiff' '8.tiff' '9.tiff'};
axes(handles.axes4);
imshow(picture{SCC});


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%gui top buttons

function loadice_Callback(hObject, eventdata, handles)
%allow the user to choose which settings to load
[filename, pathname] = uigetfile('*.fig', 'Choose the GUI settings file to load');

%construct the path name of the file to be loaded
loadDataName = fullfile(pathname,filename);

%this is the gui that will be closed once we load the new settings
ice = gcf;  

%load the settings, which creates a new gui
hgload(loadDataName); 

%closes the old gui
close(ice);



function saveice_Callback(hObject, eventdata, handles)

%allow the user to specify where to save the settings file
[filename,pathname] = uiputfile('save_ice','Save your GUI settings');

if pathname == 0 %if the user pressed cancelled, then we exit this callback
    return
end

%construct the path name of the save location
saveDataName = fullfile(pathname,filename); 

%saves the gui data
hgsave(saveDataName);

function helpice_Callback(hObject, eventdata, handles)
mih=msgbox('ICE Parameters allows you to set all the parameters that affect the performance of a vehicle.  Following your choice of SMMT category, you can now either set default values, taken from the 2009 best selling vehicle in that category or set your own','ICE Parameters help')
       set( mih, 'color', [ 0.9 0.9 .9 ] )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%vehicle control buttons

function vehicledefault_Callback(hObject, eventdata, handles)
global SPD;
SCC=SPD(1)-1;

%values for 9 vehicle segments taken from ovem3
Cd = [0.32 0.32 0.32 0.27 0.25 0.26 0.34 0.32 0.31];  
Af = [1.97 2.04 2.05 2.17 2.05 2.21 2.14 2.44 2.45];
glider_mass = [925 966 1327 1515 1575 1970 1318 1647 1613];
wheel_drive = [2 2 2 2 2 2 2 2 4]; % check with justin 
tyre_dia_in=[14 16 16 17 16 17 17 17 16]; %in
Crr= [0.0085 0.0099 0.0106 .0096 .0096 .0096 .0096 .0096 .0096];

checkboxStatus = get(handles.vehicledefault,'Value');
if(checkboxStatus)
    %if box is checked, 
set(handles.drag,'string',Cd(SCC));
set(handles.frontalarea,'string',Af(SCC));
set(handles.weight,'string',glider_mass(SCC));
set(handles.wheeldrive,'string',wheel_drive(SCC));
set(handles.tyrediam,'string',tyre_dia_in(SCC));
set(handles.tyreroll,'string',Crr(SCC));

else
    %if box is unchecked, text is set to 0
    % ^Pretty sure you've already done that mate
set(handles.drag, 'string','0');
set(handles.frontalarea, 'string','0');
set(handles.weight, 'string','0');
set(handles.wheeldrive, 'string','0');
set(handles.tyrediam, 'string','0');
set(handles.tyreroll, 'string','0');

end
guidata(hObject, handles);

% not really sure what this one does
function vehiclereset_Callback(hObject, eventdata, handles)
set(handles.drag,'string','0');
set(handles.frontalarea, 'string','0');
set(handles.weight, 'string','0');
set(handles.wheeldrive, 'string','0');
set(handles.tyrediam, 'string','0');
set(handles.tyreroll, 'string','0');
guidata(hObject, handles);

function vehicleadvanced_Callback(hObject, eventdata, handles)
madv=msgbox('Sorry, the advanced feature is still inactive','advanced');
    set( madv, 'color', [ 0.9 0.9 .9 ] )


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%vehicle values

% Drag Coefficient 
function drag_Callback(hObject, eventdata, handles)
dc = get(handles.drag,'String');        % get the string 
dc = str2num(dc);                       % convert from string to number 

% If no value input, or a value not between 0 and 0.4, complain
if (isempty(dc) || dc < 0 || dc > 0.4)  
    set(handles.drag,'String','0');
    mdc=msgbox('Please set the drag coefficient to a value between 0 and 0.4','Drag Coefficient');
    set( mdc, 'color', [ 0.9 0.9 .9 ] );
end
guidata(hObject, handles);

function drag_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'));
    set(hObject,'BackgroundColor','white');
end

% Frontal Area
function frontalarea_Callback(hObject, eventdata, handles)
ifa = get(handles.frontalarea,'String');    % get the string
ifa = str2num(ifa);                         % convert from string to number

% Same deal
if (isempty(ifa) || ifa < 0 || ifa > 3)  
    set(handles.frontalarea,'String','0');
    mifa=msgbox('please set the frontal area to a value between 0 and 3 ','frontal area');
    set( mifa, 'color', [ 0.9 0.9 .9 ] );
end

function frontalarea_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Weight
function weight_Callback(hObject, eventdata, handles)
w = get(handles.weight,'String');%get the string for the editText component
w = str2num(w);%convert from string to number if possible, otherwise returns empty
if (isempty(w) || w < 0)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.weight,'String','0');
    mw=msgbox('Please set the kerb weight to a number greater than 0','Kerb Weight');
    set(mw, 'color', [ 0.9 0.9 .9 ] );
end

function weight_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Number of wheel drive (2 or 4)
function wheeldrive_Callback(hObject, eventdata, handles)
wd = get(handles.wheeldrive,'String');%get the string for the editText component
wd = str2num(wd);%convert from string to number if possible, otherwise returns empty
if (isempty(wd) || wd<(2) ||wd>(4)||((2)<wd && wd<(4))); %  if user inputs something is not a number, or if the input is not 2 or 4
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

% Tyre Diameter
function tyrediam_Callback(hObject, eventdata, handles)
td = get(handles.tyrediam,'String');%get the string for the editText component
td = str2num(td);%convert from string to number if possible, otherwise returns empty
if (isempty(td) || td < 14 || td > 17)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.tyrediam,'String','0');
    mtd=msgbox('please set the tyre diameter between 14" and 17"','tyre diameter');
    set( mtd, 'color', [ 0.9 0.9 .9 ] );
end

function tyrediam_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function tyreroll_Callback(hObject, eventdata, handles)
tr = get(handles.tyreroll,'String');%get the string for the editText component
tr = str2num(tr);%convert from string to number if possible, otherwise returns empty
if (isempty(tr) || tr < 0 || tr > 0.02)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.tyreroll,'String','0');
    mtr=msgbox('please set the tyre rolling resistance between 0 and 0.02','tyre roll resistance');
    set( mtr, 'color', [ 0.9 0.9 .9 ] );

end

function tyreroll_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%engine parameters

%engine control buttons

function enginedefault_Callback(hObject, eventdata, handles)
global SPD;
SCC=SPD(1)-1;
default_esize = [1.1 1.4 2.0 3.0 2.0 3.2 2.0 2.2 1.9];
engine_torque = [98 125 185 400 360 500 280 350 280];
engine_power = [49 70.5 104.4 145 99.9 149.9 154.7 110 92];

checkboxStatus = get(handles.enginedefault,'Value');

if (checkboxStatus)
set(handles.enginesize, 'string', default_esize(SCC));
set(handles.etorque,'string',engine_torque(SCC));
set(handles.epower,'string',engine_power(SCC));
else   
%set(handles.enginesize, 'string', '0');
%set(handles.etorque,'string','0');
%set(handles.epower,'string','0');


e=get(handles.enginesize,'string');
es=str2num(e);
ft=get(handles.petrol,'value');
if (ft==1)
    if(es>0)
    et=(99.129*es - 9.5001);
    ep=(61.027*es - 12.571);
    set(handles.etorque,'string',et);
    set(handles.epower,'string',ep);

    else
        et=0;
        ep=0;
        set(handles.etorque,'string',et);
        set(handles.epower,'string',ep);

    end
elseif(ft==0)
    if(es>0)
    et=(152.78*es^1.0215);
    ep=(81.128*es - 33.592);
    set(handles.etorque,'string',et);
    set(handles.epower,'string',ep);

    else
        et=0;
        ep=0;
    set(handles.etorque,'string',et);
    set(handles.epower,'string',ep);

    end    
end
end


function reseticeengine_Callback(hObject, eventdata, handles)
set(handles.enginesize, 'string', '0');
set(handles.etorque,'string','0');
set(handles.epower,'string','0');



function advancediceengine_Callback(hObject, eventdata, handles)
madv=msgbox('Sorry, the advanced feature is still inactive','advanced');
    set( madv, 'color', [ 0.9 0.9 .9 ] )


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%combustion user values

function fuel_type_SelectionChangeFcn(hObject, eventdata)
handles=guidata(hObject);

switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
    case 'diesel'
      set(handles.turbocharged,'Visible','on');
      set(handles.turbocharged,'value',1);
    otherwise
        set(handles.turbocharged,'Visible','off');
        set(handles.turbocharged,'value',0);
end

ft=get(handles.petrol,'value');
e=get(handles.enginesize,'string');
es=str2num(e);

if (ft==1)
    if(es>0)
    et=(99.129*es - 9.5001);
    ep=(61.027*es - 12.571);
    set(handles.etorque,'string',et);
    set(handles.epower,'string',ep);
    else
        et=0;
        ep=0;
        set(handles.etorque,'string',et);
        set(handles.epower,'string',ep);
    end
elseif(ft==0)
    if(es>0)
    et=(152.78*es^1.0215);
    ep=(81.128*es - 33.592);
    set(handles.etorque,'string',et);
    set(handles.epower,'string',ep);
    else
        et=0;
        ep=0;
        set(handles.etorque,'string',et);
        set(handles.epower,'string',ep);
    end
end



guidata(hObject, handles);


function turbocharged_Callback(hObject, eventdata, handles)
ft=get(handles.petrol,'value');
tc=get(handles.turbocharged,'value');
if(ft==0||tc==0)
    mdntc=msgbox('Sorry, non turocharged diesel cannot be simulated','advanced');
    set( mdntc, 'color', [ 0.9 0.9 .9 ] );
    set(handles.turbocharged,'value',1);
else
end


function enginesize_Callback(hObject, eventdata, handles)
global SPD
t=SPD(1);
e=get(handles.enginesize,'string');
es=str2num(e);
if(t==2)
    if (isempty(es) || es > 1.1)  
    set(handles.enginesize,'String','0');
    met=msgbox('the engine size for a Mini Smmt Category type vehicle cannot be greater than 1.1','engine size');
    set( met, 'color', [ 0.9 0.9 .9 ] );
    end
elseif(t==3)
    if (isempty(es) || es<1 || es > 1.4)  
    set(handles.enginesize,'String','0');
    met=msgbox('the engine size for a Supermini Smmt Category type vehicle should be between 1 and 1.4','engine size');
    set( met, 'color', [ 0.9 0.9 .9 ] );
    end
elseif(t==4)
    if (isempty(es) || es<1.3 || es > 2.0)  
    set(handles.enginesize,'String','0');
    met=msgbox('the engine size for a Lower Medium Smmt Category type vehicle should be between 1.3 and 2.0','engine size');
    set( met, 'color', [ 0.9 0.9 .9 ] );
    end
elseif(t==5)
    if (isempty(es) || es<1.6 || es > 3.0)  
    set(handles.enginesize,'String','0');
    met=msgbox('the engine size for an Upper Medium Smmt Category type vehicle should be between 1.6 and 3.0','engine size');
    set( met, 'color', [ 0.9 0.9 .9 ] );
    end
elseif(t==6)
    if (isempty(es) || es<2 || es > 3.5)  
    set(handles.enginesize,'String','0');
    met=msgbox('the engine size for an Executive Smmt Category type vehicle should be between 2 and 3.5','engine size');
    set( met, 'color', [ 0.9 0.9 .9 ] );
    end
elseif(t==7)
    if (isempty(es) || es < 3.5)  
    set(handles.enginesize,'String','0');
    met=msgbox('the engine size for a Luxury Smmt Category type vehicle should be larger than 3.5','engine size');
    set( met, 'color', [ 0.9 0.9 .9 ] );
    end
else
end  

ft=get(handles.petrol,'value')
if (ft==1)
    if(es>0)
    et=(99.129*es - 9.5001);
    ep=(61.027*es - 12.571);
    set(handles.etorque,'string',et);
    set(handles.epower,'string',ep);
    else
        et=0;
        ep=0;
        set(handles.etorque,'string',et);
    set(handles.epower,'string',ep);
    end
elseif(ft==0)
    if(es>0)
    et=(152.78*es^1.0215);
    ep=(81.128*es - 33.592);
    set(handles.etorque,'string',et);
    set(handles.epower,'string',ep);
    else
        et=0;
        ep=0;
        set(handles.etorque,'string',et);
    set(handles.epower,'string',ep);
    end
end




function enginesize_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%transmission control buttons

function gbdefault_Callback(hObject, eventdata, handles)
global SPD;

SCC=SPD(1)-1;
top_gear_number = [5 5 5 6 6 7 6 6 6];
top_gear_ratio = [.72 .76 .77 .84 .83 .73 .92 .64 .61];
final_drive_ratio = [4.6 4.06 3.56 2.35 2.47 2.82 3.14 4.11 3.65];

ttype=get(handles.multigear,'value');
checkboxStatus = get(handles.gbdefault,'Value');

if(ttype==1)
    if(checkboxStatus) %if multigear box is chosen and default is checked,   
        set(handles.gbspd, 'string', top_gear_number(SCC));
        set(handles.tgratio, 'string', top_gear_ratio (SCC));
        set(handles.fgratio, 'string', final_drive_ratio(SCC));
        set(handles.gbeffy, 'string', '95');
        set(handles.axleffy, 'string', '100');
    else
        set(handles.gbspd, 'string', '0');
        set(handles.tgratio, 'string', '0');
        set(handles.fgratio, 'string', '0');
        set(handles.gbeffy, 'string', '0');
        set(handles.axleffy, 'string', '0');
    end
elseif(ttype==0) %if CVT is chosen and default is automatic
        set(handles.gbspd,'string','100');
        set(handles.tgratio, 'string', top_gear_ratio (SCC));
        set(handles.fgratio, 'string', final_drive_ratio(SCC));
        set(handles.gbeffy, 'string', '95');
        set(handles.axleffy, 'string', '100');
end
          

function gbreset_Callback(hObject, eventdata, handles)
set(handles.gbspd, 'string', '0');
set(handles.tgratio, 'string', '0');
set(handles.fgratio, 'string', '0');
set(handles.gbeffy, 'string', '0');
set(handles.axleffy, 'string', '0');

function gbadvanced_Callback(hObject, eventdata, handles)
madv=msgbox('Sorry, the advanced feature is still inactive','advanced');
    set( madv, 'color', [ 0.9 0.9 .9 ] )

%transmission user input
function gearboxtype_SelectionChangeFcn(hObject, eventdata)
handles=guidata(hObject);

global SPD;

SCC=SPD(1)-1;
top_gear_number = [5 5 5 6 6 7 6 6 6];
top_gear_ratio = [.72 .76 .77 .84 .83 .73 .92 .64 .61];
final_drive_ratio = [4.6 4.06 3.56 2.35 2.47 2.82 3.14 4.11 3.65];

switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
    case 'multigear'
      set(handles.text46,'Visible','on');
      set(handles.text47,'Visible','on');
      set(handles.text50,'Visible','on');
      set(handles.text48,'Visible','on');
      set(handles.text49,'Visible','on');
      set(handles.text33,'Visible','on');
      set(handles.text27,'Visible','on');
      set(handles.gbspd,'Visible','on');
      set(handles.gbspd,'string','0');
      set(handles.tgratio,'Visible','on');
      set(handles.tgratio,'string','0');
      set(handles.fgratio,'Visible','on');
      set(handles.fgratio,'string','0');
      set(handles.gbeffy,'Visible','on');
      set(handles.gbeffy,'string','0');
      set(handles.axleffy,'Visible','on');
      set(handles.axleffy,'string','0');
      set(handles.gbdefault,'Visible','on');
      set(handles.gbreset,'Visible','on');
      set(handles.gbadvanced,'Visible','on');
    otherwise
        set(handles.text46,'Visible','off');
      set(handles.text47,'Visible','off');
      set(handles.text50,'Visible','off');
      set(handles.text48,'Visible','off');
      set(handles.text49,'Visible','off');
      set(handles.text33,'Visible','off');
      set(handles.text27,'Visible','off');
      set(handles.gbspd,'Visible','off');
      set(handles.gbspd,'string','100');
      set(handles.tgratio,'Visible','off');
      set(handles.tgratio, 'string', top_gear_ratio (SCC));
      set(handles.fgratio,'Visible','off');
      set(handles.fgratio, 'string', final_drive_ratio(SCC));
      set(handles.gbeffy,'Visible','off');
      set(handles.gbeffy,'string','95');
      set(handles.axleffy,'Visible','off');
      set(handles.axleffy,'string','100');
      set(handles.gbdefault,'Visible','off');
      set(handles.gbreset,'Visible','off');
      set(handles.gbadvanced,'Visible','off');
end

guidata(hObject, handles);





function gbspd_Callback(hObject, eventdata, handles)
global SPD
SCC=SPD(1)-1
top_gear_ratio = [.72 .76 .77 .84 .83 .73 .92 .64 .61];
final_drive_ratio = [4.6 4.06 3.56 2.35 2.47 2.82 3.14 4.11 3.65];

gbs = get(handles.gbspd,'String');%get the string for the editText component
gbs = str2num(gbs);%convert from string to number if possible, otherwise returns empty
if (isempty(gbs) || gbs < 4 || gbs > 7)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.gbspd,'String','0');
    mgbs=msgbox('please set the gearbox speed value between 4 and 7','gearbox speed');
    set( mgbs, 'color', [ 0.9 0.9 .9 ] )
end

gbt=get(handles.multigear,'value')

if (gbt==1 && gbs>0)
        set (handles.tgratio,'string',top_gear_ratio(SCC));
        set (handles.fgratio,'string',final_drive_ratio(SCC));
else
end

function gbspd_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function tgratio_Callback(hObject, eventdata, handles)
tgr = get(handles.tgratio,'String');%get the string for the editText component
tgr = str2num(tgr);%convert from string to number if possible, otherwise returns empty
if (isempty(tgr) || tgr < 0 || tgr > 1)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.tgratio,'String','0');
    mtgr=msgbox('please set the top gear ratio value between 0 and 1','top gear ratio');
    set( mtgr, 'color', [ 0.9 0.9 .9 ] )

end

function tgratio_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fgratio_Callback(hObject, eventdata, handles)
fgr = get(handles.fgratio,'String');%get the string for the editText component
fgr = str2num(fgr);%convert from string to number if possible, otherwise returns empty
if (isempty(fgr) || fgr < 2 || fgr > 5)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.fgratio,'String','0');
    mfgr=msgbox('please set the final gear ratio value between 2 and 5','final gear ratio');
    set( mfgr, 'color', [ 0.9 0.9 .9 ] )

end

function fgratio_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gbeffy_Callback(hObject, eventdata, handles)
gbe = get(handles.gbeffy,'String');%get the string for the editText component
gbe = str2num(gbe);%convert from string to number if possible, otherwise returns empty
if (isempty(gbe) || gbe < 0 || gbe > 100)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.gbeffy,'String','0');
    mgbe=msgbox('please set the gearbox efficiency value between 0 and 100','gearbox efficiency');
    set( mgbe, 'color', [ 0.9 0.9 .9 ] )

end

function gbeffy_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function axleffy_Callback(hObject, eventdata, handles)
ae = get(handles.axleffy,'String');%get the string for the editText component
ae = str2num(ae);%convert from string to number if possible, otherwise returns empty
if (isempty(ae) || ae < 0 || ae > 100)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.axleffy,'String','0');
    mae=msgbox('please set the axle efficiency value between 0 and 100','axle efficiency');
    set( mae, 'color', [ 0.9 0.9 .9 ] )

end

function axleffy_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%range

function rangedefault_Callback(hObject, eventdata, handles)
rd=get(handles.rangedefault,'value');
if(rd==1)
set(handles.range,'string','950');
else
    set(handles.range,'string','0');
end

function range_Callback(hObject, eventdata, handles)
rng1 = get(handles.range,'String');%get the string for the editText component
rng = str2num(rng1);%convert from string to number if possible, otherwise returns empty
if (isempty(rng) || rng < 0)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
    set(handles.range,'String','0');
    mrng=msgbox('please set the Range value greater that 0','Range');
    set( mrng, 'color', [ 0.9 0.9 .9 ] )
else 
end

function range_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%regen braking

%function regen_Callback(hObject, eventdata, handles)
%r=get(handles.regen,'value')
%if(r==0)
%    set(handles.text69,'visible','off')
%    set(handles.regeneffy,'visible','off')
%    set(handles.regeneffy,'value',0)
%    set(handles.text70,'visible','off')
%    set(handles.regendefault,'visible','off')
%else
%    set(handles.text69,'visible','on')
%    set(handles.regeneffy,'visible','on')
%    set(handles.regeneffy,'value',0)
%    set(handles.text70,'visible','on')
%    set(handles.regendefault,'visible','on')
%end


%function regeneffy_Callback(hObject, eventdata, handles)
%reg = get(handles.regeneffy,'String');%get the string for the editText component
%reg = str2num(reg);%convert from string to number if possible, otherwise returns empty
%if (isempty(reg) || reg < 0 || reg > 100)  %if user inputs something is not a number, or if the input is less than or greater than 100, then the slider value defaults to 0
%    set(handles.regeneffy,'String','0');
%    mreg=msgbox('please set the regeneration efficiency value between 0 and 100','Regenerative Efficiency');
%    set( mreg, 'color', [ 0.9 0.9 .9 ] )
%end

%function regeneffy_CreateFcn(hObject, eventdata, handles)
%
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%    set(hObject,'BackgroundColor','white');
%end


%function regendefault_Callback(hObject, eventdata, handles)  %assume that regen in ICE is mechanical
%checkboxStatus = get(handles.regendefault,'Value');
%r=get(handles.regen,'value');
%
%if ((checkboxStatus)&&(r==1))
%set(handles.regeneffy, 'string', '85')
%else set(handles.regeneffy,'string','0')
%end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ice gui main buttons
 

function setice_Callback(hObject, eventdata, handles);
global VP
global PS
global EP
global MP
global T
global VR
global SET


dc1=get(handles.drag, 'string');
dc=str2num(dc1);
fa1=get(handles.frontalarea, 'string');
fa=str2num(fa1);
kw1=get(handles.weight, 'string');
kw=str2num(kw1);
wd1=get(handles.wheeldrive, 'string');
wd=str2num(wd1);
td1=get(handles.tyrediam, 'string');
td=str2num(td1);
tr1=get(handles.tyreroll, 'string');
tr=str2num(tr1);
VP=[dc fa kw wd td tr];

%r=get(handles.regen,'value');
%regeffy=get(handles.regeneffy,'string');
%reffy=str2num(regeffy);

ft=get(handles.petrol, 'value');  % 1=petrol, 0=diesel
tc=get(handles.turbocharged,'value'); % 1=turbocharged, 0=not turbocharged
PS=[0 3 ft tc];

es1=get(handles.enginesize, 'string');
es=str2num(es1);
et1=get(handles.etorque, 'string');
et=str2num(et1);
ep1=get(handles.epower, 'string');
ep=str2num(ep1);
EP=[es et ep];

MP=[0 0 0];

gbt=get(handles.multigear, 'value'); % 1=multigear, 0=CVT
gbs1=get(handles.gbspd, 'string');
gbs=str2num(gbs1);
tgr1=get(handles.tgratio, 'string');
tgr=str2num(tgr1);
fgr1=get(handles.fgratio, 'string');
fgr=str2num(fgr1);
gbe1=get(handles.gbeffy, 'string');
gbe=str2num(gbe1);
axe1=get(handles.axleffy, 'string');
axe=str2num(axe1);
T=[gbt gbs tgr fgr gbe axe];

rng1=get(handles.range,'string');
rng=str2num(rng1);
%reg1=get(handles.regeneffy,'string');
%reg=str2num(reg1);
VR=[rng 0];

if(VP(1)==0||VP(2)==0||VP(3)==0||VP(4)==0||VP(5)==0||VP(6)==0)
    mvperror=msgbox('Please note that the Vehicle Parameters could not be set to 0','Error Set Parameters');
    set( mvperror, 'color', [ 0.9 0.9 .9 ] )
%elseif((r==1)&&(reffy==0))
%     mregen=msgbox('Please note that the Regenerative Effy cannot be 0 if Regenerative Braking is ON' ,'Error Regen Effy');
%    set( mregen, 'color', [ 0.9 0.9 .9 ] )
elseif (EP(1)==0)
     mcperror=msgbox('Please note that the Engine Parameters could not be set to 0','Error Set Parameters');
    set( mcperror, 'color', [ 0.9 0.9 .9 ] )
elseif (VR(1)==0)
    mrerror=msgbox('Please note that the Range of the vehicle could not be set to 0','Error Set Parameters');
    set( mrerror, 'color', [ 0.9 0.9 .9 ] )
elseif (T(2)==0||T(3)==0||T(4)==0||T(5)==0||T(6)==0)
    mterror=msgbox('Please note that the Transmission Parameters could not be set to 0','Error Set Parameters');
    set( mterror, 'color', [ 0.9 0.9 .9 ] )
else
    SET=[1];
    close();
end


function cancel_button_Callback(hObject, eventdata, handles)
global VP
global PS
global EP
global MP
global T
global VR
global SET

VP=[0 0 0 0 0 0]; % rests all the global variables on cancel
PS=[0 0 0 0];
EP=[0 0 0];
MP=[0 0 0];
T=[0 0 0 0 0 0];
VR=[0 0];
SET=[0];

close();
