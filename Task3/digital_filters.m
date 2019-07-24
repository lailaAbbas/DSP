function varargout = digital_filters(varargin)



% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @digital_filters_OpeningFcn, ...
                   'gui_OutputFcn',  @digital_filters_OutputFcn, ...
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


% --- Executes just before digital_filters is made visible.
function digital_filters_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to digital_filters (see VARARGIN)

%draw unit circle
c_draw(hObject, eventdata, handles);


% Choose default command line output for digital_filters
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = digital_filters_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



% --- Executes on button press in PP.
function PP_Callback(hObject, eventdata, handles)
% hObject    handle to PP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%click to add a pole point in the unit circle
[x,y]=ginput(1);

%push a point and its conjugate to the poles array 
handles.p(length(handles.p)+1)=x+1j*y;

% Update handles structure
guidata(hObject, handles);

%plot the freq response and its effect in the original signal
freq_plot(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in ZZ.
function ZZ_Callback(hObject, eventdata, handles)
% hObject    handle to ZZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%click to add a zero point in the unit circle
[x,y]=ginput(1);

%push a point and its conjugate to the zeros array 
handles.z(length(handles.z)+1)=x+1j*y;

% Update handles structure
guidata(hObject, handles);

%plot the freq response and its effect in the original signal
freq_plot(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in nP.
function nP_Callback(hObject, eventdata, handles)
% hObject    handle to nP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%click to remove a pole point in the unit circle
[x,y]=ginput(1);

%search for the selected pole from the poles array and remove it
temp=find(real(handles.p <(x+0.1)) & real(handles.p>(x-0.1)) & imag(handles.p)< (y+0.1) & imag(handles.p)> (y-0.1) );
handles.p(temp)=[];

% Update handles structure
guidata(hObject, handles);

%plot the freq response and its effect in the original signal
freq_plot(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in nZ.
function nZ_Callback(hObject, eventdata, handles)
% hObject    handle to nZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%click to remove a zero point in the unit circle
[x,y]=ginput(1);

%search for the selected zero from the zero array and remove it
temp=find(real(handles.z <(x+0.1)) & real(handles.z>(x-0.1)) & imag(handles.z)< (y+0.1) & imag(handles.z)> (y-0.1));
handles.z(temp)=[];

%remove the selected zero from  the listBox
%handles.B(temp)=[];

% Update handles structure
guidata(hObject, handles);

%plot the freq response and its effect in the original signal
freq_plot(hObject, eventdata, handles);

%show the listbox after removing points
%set(handles.listbox2,'String',handles.B);
% Update handles structure
guidata(hObject, handles);



function c_draw(hObject, eventdata, handles)

axes(handles.axes1);
global num
global den
num = [ ] ;
den = [ ] ;
zplaneplot(num,den);
grid ON;
hold off;
% Update handles structure
guidata(hObject, handles);


function freq_plot(hObject, eventdata, handles)



%clear the unit circuit axes
cla(handles.axes1,'reset');
axes(handles.axes1)
c_draw(hObject, eventdata, handles);
hold on

%plot poles and zeros markers
plot_p=plot(real(handles.p),imag(handles.p),'X');
plot_z=plot(real(handles.z),imag(handles.z),'O');
set(plot_p,'markersize',8,'linewidth',2);
set(plot_z,'markersize',8,'linewidth',2);
hold off;

%Get the transfer function coeffecients
[b,a]=zp2tf(handles.z',handles.p,1);

%Get the frequency response 
[h,w] = freqz(b,a,length(handles.y_fft));

%plot the frequency response mag 
axes(handles.axes2)
plot(w/pi,20*log10(abs(h)))
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
grid on;

%plot the frequency response phase
axes(handles.axes3)
plot(w/pi,20*log10(angle(h)))
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Phase (dB)')
grid on;

%apply the filter in the orignial signal
filter=h'.*handles.y_fft;
axes(handles.axes5)
plot(real(ifft(filter)))
xlabel('Signal in time domain after filteration')

%plot the filtered signal in time and freq domains
axes(handles.axes7)
plot(abs(filter))
xlabel('fft after filteration')
xlabel('Signal in freq domain after filteration')
  

% Update handles structure
guidata(hObject, handles);
       

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiopen();
y = val(1,:);

handles.y_fft=fft(y);

%plot the original signal in time domain
axes(handles.axes4)
plot(y)
xlabel('Signal in time domain before filteration')

axes(handles.axes6)
plot(abs(handles.y_fft))
xlabel('Signal in freq domain before filteration')
handles.p=[];   % Array holds poles in complex formula
handles.z=[];   % Array holds zeros in complex formula

% Choose default command line output for digital_filters
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in Record_Voice_by_Speaker.
function Record_Voice_by_Speaker_Callback(hObject, eventdata, handles)
% hObject    handle to Record_Voice_by_Speaker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

z= audiorecorder ;
disp('start speaking')
recordblocking ( z , 10 );
disp('end of speaking')
play(z) ;
myrecording = getaudiodata (z) ;
axes(handles.axes4)
myrecording = myrecording(: , 1);
plot(myrecording) ;

myrecording = myrecording' ; 
handles.y_fft=fft(myrecording);
xlabel('Signal in time domain before filteration')

axes(handles.axes6)
plot(abs(handles.y_fft))
xlabel('Signal in freq domain before filteration')

handles.p=[];   % Array holds poles in complex formula
handles.z=[];   % Array holds zeros in complex formula

% Choose default command line output for digital_filters
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
