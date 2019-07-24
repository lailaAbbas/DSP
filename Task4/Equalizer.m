function varargout = Equalizer(varargin)
% EQUALIZER MATLAB code for Equalizer.fig
%      EQUALIZER, by itself, creates a new EQUALIZER or raises the existing
%      singleton*.
%
%      H = EQUALIZER returns the handle to a new EQUALIZER or the handle to
%      the existing singleton*.
%
%      EQUALIZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EQUALIZER.M with the given input arguments.
%
%      EQUALIZER('Property','Value',...) creates a new EQUALIZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Equalizer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Equalizer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Equalizer

% Last Modified by GUIDE v2.5 12-Apr-2018 16:57:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Equalizer_OpeningFcn, ...
                   'gui_OutputFcn',  @Equalizer_OutputFcn, ...
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


% --- Executes just before Equalizer is made visible.
function Equalizer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Equalizer (see VARARGIN)
set(handles.Browse,'enable','off');
set(handles.record_stop,'enable','off');
global gain1
global gain2
global gain3
global gain4
global gain5
global gain6
global gain7
global gain8
gain1 = 1 ; 
gain2 = 1 ; 
gain3 = 1 ;
gain4 = 1 ; 
gain5 = 1 ; 
gain6 = 1 ;
gain7 = 1 ; 
gain8 = 1 ;


Str = num2str(gain1);
set(handles.text1 , 'String' , Str)
Str = num2str(gain2);
set(handles.text2 , 'String' , Str)
Str = num2str(gain3);
set(handles.text3 , 'String' , Str)
Str = num2str(gain4);
set(handles.text4 , 'String' , Str)
Str = num2str(gain5);
set(handles.text5 , 'String' , Str)
Str = num2str(gain6);
set(handles.text6 , 'String' , Str)
Str = num2str(gain7);
set(handles.text7 , 'String' , Str)
Str = num2str(gain8);
set(handles.text8 , 'String' , Str)

zoom();
% Choose default command line output for Equalizer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Equalizer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Equalizer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Offline_radio.
function Offline_radio_Callback(hObject, eventdata, handles)
% hObject    handle to Offline_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.record_stop,'enable','off');
handles.Online_radio.Value = 0 ;
if (handles.Offline_radio.Value == 1 )
    set(handles.Browse,'enable','on');
else
    set(handles.Browse,'enable','off');
end
% Hint: get(hObject,'Value') returns toggle state of Offline_radio


% --- Executes on button press in Online_radio.
function Online_radio_Callback(hObject, eventdata, handles)
% hObject    handle to Online_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Browse,'enable','off');
handles.Offline_radio.Value = 0 ;
if (handles.Online_radio.Value == 1 )
    set(handles.record_stop,'enable','on');
else
    set(handles.record_stop,'enable','off');
end
% Hint: get(hObject,'Value') returns toggle state of Online_radio


% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y
global gain1
global gain2
global gain3
global gain4
global gain5
global gain6
global gain7
global gain8
global yFinal;

%uiopen();                   %Upload Bio-Signal .mat
%y1 = val(1,:);               %signal for all samples(rows)
%y = y1;
[filename,pathname] = uigetfile({'*.wav'}, 'File Selector');
y_path = strcat(pathname, filename);
[wave,fs]=audioread(y_path); 
y = wave(1:50000,1)
axes(handles.axes1)          
plot(y)   
n = length(y)
axes(handles.axes2)   
freq = -1:2/n:1-2/n;
wdft = fftshift(fft(y));     %FFT and shift to center
plot(freq,20*log(abs(wdft)))      
axes(handles.axes3)   
plot(freq,angle(wdft))

yFiltered1 = ApplyFilter(gain1,gain2,gain3,gain4,gain5,gain6,gain7,gain8,y);
yFiltered = conv(yFiltered1,gausswin(60));

n = length(yFiltered);
Freq = -1:2/n:1-2/n;
yFilteredFreq = fftshift(fft(yFiltered));
axes(handles.axes5) 
plot(Freq,20*log(abs(yFilteredFreq)));
axes(handles.axes6) 
plot(Freq,angle(yFilteredFreq));
axes(handles.axes4);
plot(yFiltered) ;
yFinal = yFiltered; %%to play final result

% --- Executes on button press in record_stop.
function record_stop_Callback(hObject, eventdata, handles)
% hObject    handle to record_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y
global gain1
global gain2
global gain3
global gain4
global gain5
global gain6
global gain7
global gain8
global yFinal;
recorder1 = audiorecorder(44100,16,1);
while get(hObject,'Value')
record(recorder1);
pause(0.5);
%pause(0.1) ;
%stop(recorder1);
myRecording = getaudiodata(recorder1);
M =length(myRecording)
y1 = myRecording;
y = y1;
%n = length(y);
%axes(handles.axes2)   
%freq = -1:2/n:1-2/n;
%wdft = fftshift(fft(y));     %FFT and shift to center
%plot(freq,20*log(abs(wdft)))      
%axes(handles.axes3)   
%plot(freq,angle(wdft))

%yFiltered1 = ApplyFilter(gain1,gain2,gain3,gain4,gain5,gain6,gain7,gain8,y); 
%yFiltered = conv(yFiltered1,gausswin(60));

%n = length(yFiltered);
%Freq = -1:2/n:1-2/n;
%yFilteredFreq = fftshift(fft(yFiltered));
%axes(handles.axes5) 
%plot(Freq,20*log(abs(yFilteredFreq)));
%axes(handles.axes6) 
%plot(Freq,angle(yFilteredFreq));
%axes(handles.axes4);
%plot(yFiltered) ;
%yFinal = yFiltered;
RecLength = length(myRecording);
length(RecLength)
if(M>1000)
   %y = y;
%else
   y = myRecording((RecLength-1000):RecLength);
end
axes(handles.axes1)
plot (y);
axes(handles.axes2)   
n = length(y);
freq = -1:2/n:1-2/n;
wdft = fftshift(fft(y));     %FFT and shift to center
plot(freq,20*log(abs(wdft)))      
axes(handles.axes3)   
plot(freq,angle(wdft))
yFiltered1 = ApplyFilter(gain1,gain2,gain3,gain4,gain5,gain6,gain7,gain8,y); 
yFiltered = conv(yFiltered1,gausswin(60));
n = length(yFiltered);
Freq = -1:2/n:1-2/n;
yFilteredFreq = fftshift(fft(yFiltered));
axes(handles.axes5) 
plot(Freq,20*log(abs(yFilteredFreq)));
axes(handles.axes6) 
plot(Freq,angle(yFilteredFreq));
axes(handles.axes4);
plot(yFiltered) ;
yFinal = yFiltered;
end


% Hint: get(hObject,'Value') returns toggle state of record_stop


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gain1
global gain2
global gain3
global gain4
global gain5
global gain6
global gain7
global gain8
gain1 = 1 ; 
gain2 = 1 ; 
gain3 = 1 ;
gain4 = 1 ; 
gain5 = 1 ; 
gain6 = 1 ;
gain7 = 1 ; 
gain8 = 1 ;
global y
global yFinal

set(handles.slider1,'Value',1);
set(handles.slider2,'Value',1);
set(handles.slider3,'Value',1);
set(handles.slider4,'Value',1);
set(handles.slider5,'Value',1);
set(handles.slider6,'Value',1);
set(handles.slider7,'Value',1);
set(handles.slider8,'Value',1);

Str = num2str(gain1);
set(handles.text1 , 'String' , Str)
Str = num2str(gain2);
set(handles.text2 , 'String' , Str)
Str = num2str(gain3);
set(handles.text3 , 'String' , Str)
Str = num2str(gain4);
set(handles.text4 , 'String' , Str)
Str = num2str(gain5);
set(handles.text5 , 'String' , Str)
Str = num2str(gain6);
set(handles.text6 , 'String' , Str)
Str = num2str(gain7);
set(handles.text7 , 'String' , Str)
Str = num2str(gain8);
set(handles.text8 , 'String' , Str)

yFiltered1 = ApplyFilter(gain1,gain2,gain3,gain4,gain5,gain6,gain7,gain8,y); 
yFiltered = conv(yFiltered1,gausswin(60));

n = length(yFiltered);
Freq = -1:2/n:1-2/n;
yFilteredFreq = fftshift(fft(yFiltered));
axes(handles.axes5) 
plot(Freq,20*log(abs(yFilteredFreq)));
axes(handles.axes6) 
plot(Freq,angle(yFilteredFreq));
axes(handles.axes4);
plot(yFiltered) ;
yFinal = yFiltered;
% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y

global gain1
global gain2
global gain3
global gain4
global gain5
global gain6
global gain7
global gain8
global yFinal
gain1 = hObject.Value ;
Str = num2str(gain1);
set(handles.text1 , 'String' , Str)

yFiltered1 = ApplyFilter(gain1,gain2,gain3,gain4,gain5,gain6,gain7,gain8,y); 
yFiltered = conv(yFiltered1,gausswin(60));

n = length(yFiltered);
Freq = -1:2/n:1-2/n;
yFilteredFreq = fftshift(fft(yFiltered));
axes(handles.axes5) 
plot(Freq,20*log(abs(yFilteredFreq)));
axes(handles.axes6) 
plot(Freq,angle(yFilteredFreq));
axes(handles.axes4);
plot(yFiltered) ;
yFinal = yFiltered;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y
global yFinal
global gain1
global gain2
global gain3
global gain4
global gain5
global gain6
global gain7
global gain8

gain2 = hObject.Value ; 
Str = num2str(gain2);
set(handles.text2 , 'String' , Str)

yFiltered1 = ApplyFilter(gain1,gain2,gain3,gain4,gain5,gain6,gain7,gain8,y); 
yFiltered = conv(yFiltered1,gausswin(60));

n = length(yFiltered);
Freq = -1:2/n:1-2/n;
yFilteredFreq = fftshift(fft(yFiltered));
axes(handles.axes5) 
plot(Freq,20*log(abs(yFilteredFreq)));
axes(handles.axes6) 
plot(Freq,angle(yFilteredFreq));
axes(handles.axes4);
plot(yFiltered)
yFinal = yFiltered;

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y
global yFinal
global gain1
global gain2
global gain3
global gain4
global gain5
global gain6
global gain7
global gain8

gain3 = hObject.Value ; 
Str = num2str(gain3);
set(handles.text3 , 'String' , Str)

yFiltered1 = ApplyFilter(gain1,gain2,gain3,gain4,gain5,gain6,gain7,gain8,y); 
yFiltered = conv(yFiltered1,gausswin(60));
yFinal = yFiltered;
n = length(yFiltered);
Freq = -1:2/n:1-2/n;
yFilteredFreq = fftshift(fft(yFiltered));
axes(handles.axes5) 
plot(Freq,20*log(abs(yFilteredFreq)));
axes(handles.axes6) 
plot(Freq,angle(yFilteredFreq));
axes(handles.axes4);
plot(yFiltered) ;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y
global yFinal
global gain1
global gain2
global gain3
global gain4
global gain5
global gain6
global gain7
global gain8

gain4 = hObject.Value ; 
Str = num2str(gain4);
set(handles.text4 , 'String' , Str)
yFiltered1 = ApplyFilter(gain1,gain2,gain3,gain4,gain5,gain6,gain7,gain8,y); 
yFiltered = conv(yFiltered1,gausswin(60));

n = length(yFiltered);
Freq = -1:2/n:1-2/n;
yFilteredFreq = fftshift(fft(yFiltered));
axes(handles.axes5) 
plot(Freq,20*log(abs(yFilteredFreq)));
axes(handles.axes6) 
plot(Freq,angle(yFilteredFreq));
axes(handles.axes4);
plot(yFiltered) ;
yFinal = yFiltered;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y
global yFinal
global gain1
global gain2
global gain3
global gain4
global gain5
global gain6
global gain7
global gain8

gain5 = hObject.Value ; 
Str = num2str(gain5);
set(handles.text5 , 'String' , Str)

yFiltered1 = ApplyFilter(gain1,gain2,gain3,gain4,gain5,gain6,gain7,gain8,y); 
yFiltered = conv(yFiltered1,gausswin(60));

n = length(yFiltered);
Freq = -1:2/n:1-2/n;
yFilteredFreq = fftshift(fft(yFiltered));
axes(handles.axes5) 
plot(Freq,20*log(abs(yFilteredFreq)));
axes(handles.axes6) 
plot(Freq,angle(yFilteredFreq));
axes(handles.axes4);
plot(yFiltered) ;
yFinal = yFiltered;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y
global yFinal
global gain1
global gain2
global gain3
global gain4
global gain5
global gain6
global gain7
global gain8

gain7 = hObject.Value ; 
Str = num2str(gain7);
set(handles.text7 , 'String' , Str)

yFiltered1 = ApplyFilter(gain1,gain2,gain3,gain4,gain5,gain6,gain7,gain8,y); 
yFiltered = conv(yFiltered1,gausswin(60));

n = length(yFiltered);
Freq = -1:2/n:1-2/n;
yFilteredFreq = fftshift(fft(yFiltered));
axes(handles.axes5) 
plot(Freq,20*log(abs(yFilteredFreq)));
axes(handles.axes6) 
plot(Freq,angle(yFilteredFreq));
axes(handles.axes4);
plot(yFiltered) ;
yFinal = yFiltered;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y

global gain1
global gain2
global gain3
global gain4
global gain5
global gain6
global gain7
global gain8
global yFinal
gain8 = hObject.Value ; 
Str = num2str(gain8);
set(handles.text8 , 'String' , Str)

yFiltered1 = ApplyFilter(gain1,gain2,gain3,gain4,gain5,gain6,gain7,gain8,y); 
yFiltered = conv(yFiltered1,gausswin(60));
yFinal = yFiltered;
n = length(yFiltered);
Freq = -1:2/n:1-2/n;
yFilteredFreq = fftshift(fft(yFiltered));
axes(handles.axes5) 
plot(Freq,20*log(abs(yFilteredFreq)));
axes(handles.axes6) 
plot(Freq,angle(yFilteredFreq));
axes(handles.axes4);
plot(yFiltered) ;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y
global yFinal
global gain1
global gain2
global gain3
global gain4
global gain5
global gain6
global gain7
global gain8

gain6 = hObject.Value ; 
Str = num2str(gain6);
set(handles.text6 , 'String' , Str)

yFiltered1 = ApplyFilter(gain1,gain2,gain3,gain4,gain5,gain6,gain7,gain8,y); 
yFiltered = conv(yFiltered1,gausswin(60));
yFinal = yFiltered;
n = length(yFiltered);
Freq = -1:2/n:1-2/n;
yFilteredFreq = fftshift(fft(yFiltered));
axes(handles.axes5) 
plot(Freq,20*log(abs(yFilteredFreq)));
axes(handles.axes6) 
plot(Freq,angle(yFilteredFreq));
axes(handles.axes4);
plot(yFiltered) ;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1) ;
guidata(hObject, handles);

function YFiltered = ApplyFilter(Gain1,Gain2,Gain3,Gain4,Gain5,Gain6,Gain7,Gain8,Signal)
BandPass1 = fir1(48,[0.0001 0.125]);
BandPass2 = fir1(48,[0.125 0.25]);
BandPass3 = fir1(48,[0.25 0.375]);
BandPass4 = fir1(48,[0.375 0.5]);
BandPass5 = fir1(48,[0.5 0.625]);
BandPass6 = fir1(48,[0.625 0.75]);
BandPass7 = fir1(48,[0.75 0.875]);
BandPass8 = fir1(48,[0.875 0.99999]);
YFiltered1 = filter(BandPass1,1,Signal);
YFiltered2 = filter(BandPass2,1,Signal);
YFiltered3 = filter(BandPass3,1,Signal);
YFiltered4 = filter(BandPass4,1,Signal);
YFiltered5 = filter(BandPass5,1,Signal);
YFiltered6 = filter(BandPass6,1,Signal);
YFiltered7 = filter(BandPass7,1,Signal);
YFiltered8 = filter(BandPass8,1,Signal);
YFiltered = Gain1*YFiltered1 + Gain2*YFiltered2 + Gain3*YFiltered3 + Gain4*YFiltered4 + Gain5*YFiltered5 + Gain6*YFiltered6 + Gain7*YFiltered7 + Gain8*YFiltered8;    
%YFilteredx = Gain1*fftshift(fft(YFiltered1)) + Gain2*fftshift(fft(YFiltered2)) + Gain3*fftshift(fft(YFiltered3)) + Gain4*fftshift(fft(YFiltered4)) + Gain5*fftshift(fft(YFiltered5)) + Gain6*fftshift(fft(YFiltered6)) + Gain7*fftshift(fft(YFiltered7)) + Gain8*fftshift(fft(YFiltered8));    
%YFiltered = ifft(ifftshift(YFilteredx));
% --- Executes on button press in play.
%function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global yFinal;
%sound(yFinal(1:100000))


% --------------------------------------------------------------------
% hObject    handle to pan_toolbar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function pan_toolbar_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to pan_toolbar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pan();


% --------------------------------------------------------------------
% hObject    handle to zoom_toolbar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
