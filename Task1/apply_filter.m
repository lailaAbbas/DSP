function varargout = apply_filter(varargin)
% APPLY_FILTER MATLAB code for apply_filter.fig
%      APPLY_FILTER, by itself, creates a new APPLY_FILTER or raises the existing
%      singleton*.
%
%      H = APPLY_FILTER returns the handle to a new APPLY_FILTER or the handle to
%      the existing singleton*.
%
%      APPLY_FILTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APPLY_FILTER.M with the given input arguments.
%
%      APPLY_FILTER('Property','Value',...) creates a new APPLY_FILTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before apply_filter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to apply_filter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help apply_filter

% Last Modified by GUIDE v2.5 13-Feb-2018 09:00:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @apply_filter_OpeningFcn, ...
                   'gui_OutputFcn',  @apply_filter_OutputFcn, ...
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


% --- Executes just before apply_filter is made visible.
function apply_filter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to apply_filter (see VARARGIN)

% Choose default command line output for apply_filter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes apply_filter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = apply_filter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
