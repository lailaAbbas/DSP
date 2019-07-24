function varargout = Task6_taslem(varargin)
% TASK6_TASLEM MATLAB code for Task6_taslem.fig
%      TASK6_TASLEM, by itself, creates a new TASK6_TASLEM or raises the existing
%      singleton*.
%
%      H = TASK6_TASLEM returns the handle to a new TASK6_TASLEM or the handle to
%      the existing singleton*.
%
%      TASK6_TASLEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TASK6_TASLEM.M with the given input arguments.
%
%      TASK6_TASLEM('Property','Value',...) creates a new TASK6_TASLEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Task6_taslem_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Task6_taslem_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Task6_taslem

% Last Modified by GUIDE v2.5 13-May-2018 21:01:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Task6_taslem_OpeningFcn, ...
                   'gui_OutputFcn',  @Task6_taslem_OutputFcn, ...
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


% --- Executes just before Task6_taslem is made visible.
function Task6_taslem_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Task6_taslem (see VARARGIN)
set(handles.Signal_type, 'String', 'moaz / Laila /  Asmaa');
% Choose default command line output for Task6_taslem
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Task6_taslem wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Task6_taslem_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal
global y
uiopen() ;
signal = y(:,1);
axes(handles.axes1);
plot(signal);
%[filename,pathname] = uigetfile({'*.mat'}, 'File Selector');
%handles.fullpathname = strcat(pathname, filename);
%set(handles.Signal_type, 'String', filename);
%guidata(hObject, handles);    
%axes(handles.axes1);
%plot(handles.fullpathname);

% --- Executes on button press in Apply_Filter.
function Apply_Filter_Callback(hObject, eventdata, handles)
% hObject    handle to Apply_Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal
F0= 60 ; Fs = 200 ; Q=35;
W0= 2*F0 /Fs;
Bw = W0 / Q;
n = 4; %degree of notch
[a,b] = iircomb(n,Bw);
signal_filtered = filter(a,b,signal);
signal_filtered_gauss = conv(signal_filtered,gausswin(60)) ;
axes(handles.axes2);
plot(signal_filtered_gauss);

% --- Executes on button press in Test_signal.
function Test_signal_Callback(hObject, eventdata, handles)
% hObject    handle to Test_signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles);  
global signal
global y
rms_y1 = sqrt(mean(y.^2));
if (rms_y1>=36.6946 && rms_y1<=39.1075 )
 
      set(handles.Signal_type,'string','Close Fingers' );
elseif (rms_y1>=15.1768 && rms_y1<=34.1409)   
    
    set(handles.Signal_type,'string','double tab' );
elseif (rms_y1>=   43.4406 && rms_y1<=   57.5726)   
    
    set(handles.Signal_type,'string','Hands up' );
elseif (rms_y1>=  7.1214 && rms_y1<=   22.1513)   
    
    set(handles.Signal_type,'string','Right Rotation' );
end
