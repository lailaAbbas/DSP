function varargout = Task5(varargin)
% TASK5 MATLAB code for Task5.fig
%      TASK5, by itself, creates a new TASK5 or raises the existing
%      singleton*.
%
%      H = TASK5 returns the handle to a new TASK5 or the handle to
%      the existing singleton*.
%
%      TASK5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TASK5.M with the given input arguments.
%
%      TASK5('Property','Value',...) creates a new TASK5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Task5_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Task5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Task5

% Last Modified by GUIDE v2.5 28-Apr-2018 16:58:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Task5_OpeningFcn, ...
                   'gui_OutputFcn',  @Task5_OutputFcn, ...
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


% --- Executes just before Task5 is made visible.
function Task5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Task5 (see VARARGIN)

% Choose default command line output for Task5
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Task5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Task5_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla reset;%to guarantee that the previous plot has been deleted
uiopen();
y = datablock1.data(: , 1 );
length(y);
axes(handles.axes1);
plot(y);
sum = 0 ;
for i = 1 : length(y)
    D =  datablock1.data(i,1) ;
    sum = sum + D ;
end
mean = sum / length(y) ;
mean = abs(mean)