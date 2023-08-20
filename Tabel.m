function varargout = Tabel(varargin)
% TABEL MATLAB code for Tabel.fig
%      TABEL, by itself, creates a new TABEL or raises the existing
%      singleton*.
%
%      H = TABEL returns the handle to a new TABEL or the handle to
%      the existing singleton*.
%
%      TABEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TABEL.M with the given input arguments.
%
%      TABEL('Property','Value',...) creates a new TABEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Tabel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Tabel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Tabel

% Last Modified by GUIDE v2.5 25-Oct-2014 02:52:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Tabel_OpeningFcn, ...
                   'gui_OutputFcn',  @Tabel_OutputFcn, ...
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

% --- Executes just before Tabel is made visible.
function Tabel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Tabel (see VARARGIN)

% Load Config
run('config.m')

% Eksekusi Query
kredit = exec(dbConn,'SELECT alternatif.Id_Kriteria, pemohon.Nama_Pemohon, alternatif.UangMuka,alternatif.Angsuran, alternatif.Pekerjaan, alternatif.LamaBekerja, alternatif.Gaji, alternatif.Pendidikan, alternatif.StatusRumah FROM alternatif INNER JOIN pemohon ON alternatif.Id_kriteria=pemohon.Id_Kriteria');
result = fetch(kredit);
set(handles.uitable1,'data',result.Data);


% Choose default command line output for Tabel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Tabel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Tabel_OutputFcn(hObject, eventdata, handles) 
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

% Load Config
run('config.m')

% Eksekusi Query
sql = exec(dbConn,'SELECT alternatif.Id_Kriteria, pemohon.Nama_Pemohon, alternatif.UangMuka,alternatif.Angsuran, alternatif.Pekerjaan, alternatif.LamaBekerja, alternatif.Gaji, alternatif.Pendidikan, alternatif.StatusRumah FROM alternatif INNER JOIN pemohon ON alternatif.Id_kriteria=pemohon.Id_Kriteria');
result = fetch(sql);
set(handles.uitable1,'data',result.Data);

% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
% Eksekusi Query
% Delete data from Table1



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Load Config
run('config.m')

sql = exec(dbConn,'SELECT UangMuka,Angsuran,Pekerjaan,LamaBekerja,Gaji,Pendidikan,StatusRumah FROM alternatif');
result = fetch(sql);
disp(result);
x=cell2mat(result.Data);
disp(x);
[m n]=size(x);
disp(x);
k=[1 1 1 1 1 1 1];

w1= handles.bobotUangMuka;
w2= handles.bobotAngsuran;
w3= handles.bobotPekerjaan;
w4= handles.bobotLamaBekerja;
w5= handles.bobotGaji;
w6= handles.bobotPendidikan;
w7= handles.bobotStatusRumah;

w = [ w1,w2,w3,w4,w5,w6,w7]

% tahapan 1. normalisasi matrix
R=zeros(m,n); %membuat matrix R, yang merupakan matrik kosong
Y=zeros(m,n) ;%membuat matrik Y, yang marupakan matrik kosong
for j=1:n,
    if k(j)==1,%statement untuk kriteria dengan atribut keuntungan
        R(:,j)=x(:,j)./max(x(:,j));
    else
        R(:,j)=min(x(:,j))./x(:,j);
    end;
end;
disp ('nilai input x=')
disp(x)
disp ('bobot yang diberikan w=')
disp(w)
disp ('atribut tiap kriteria k=')
disp(k)
disp('matrik yang sudah ternomalisasi R=')
disp(R)

%tahapan kedua, proses perangkingan
for i=1:m,
    V(i)= sum (w.*R(i,:))
end;
t=[V]
    bar(t)
    grid on
    axes(handles.axes2)
set(handles.uitable3,'data',R);
disp(V);
set(handles.uitable2,'data',V.');



% --- Executes on selection change in popupmenu13.
function popupmenu13_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
popupmenu13=get(hObject,'value');
    switch popupmenu13
       case 1
       bobotUangMuka='';
       case 2
       bobotUangMuka=1;
       case 3
       bobotUangMuka=2;
       case 4
       bobotUangMuka=3;
       case 5
       bobotUangMuka=4;
       case 6
       bobotUangMuka=5;
    end
handles.bobotUangMuka = bobotUangMuka;
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu13 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu13


% --- Executes during object creation, after setting all properties.
function popupmenu13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.popupmenu13=hObject;
guidata(hObject, handles)
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu14.
function popupmenu14_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
popupmenu14=get(hObject,'value');
    switch popupmenu14
       case 1
       bobotAngsuran='';
       case 2
       bobotAngsuran=1;
       case 3
       bobotAngsuran=2;
       case 4
       bobotAngsuran=3;
       case 5
       bobotAngsuran=4;
       case 6
       bobotAngsuran=5;
    end
handles.bobotAngsuran = bobotAngsuran;
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu14 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu14


% --- Executes during object creation, after setting all properties.
function popupmenu14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.popupmenu14=hObject;
guidata(hObject, handles)
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu15.
function popupmenu15_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
popupmenu15=get(hObject,'value');
    switch popupmenu15
       case 1
       bobotPekerjaan='';
       case 2
       bobotPekerjaan=1;
       case 3
       bobotPekerjaan=2;
    end
handles.bobotPekerjaan = bobotPekerjaan;
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu15 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu15


% --- Executes during object creation, after setting all properties.
function popupmenu15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.popupmenu15=hObject;
guidata(hObject, handles)
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu16.
function popupmenu16_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
popupmenu16=get(hObject,'value');
    switch popupmenu16
       case 1
       bobotLamaBekerja='';
       case 2
       bobotLamaBekerja=1;
       case 3
       bobotLamaBekerja=2;
       case 4
       bobotLamaBekerja=3;
       case 5
       bobotLamaBekerja=4;
       case 6
       bobotLamaBekerja=5;
    end
handles.bobotLamaBekerja = bobotLamaBekerja;
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu16 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu16


% --- Executes during object creation, after setting all properties.
function popupmenu16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.popupmenu16=hObject;
guidata(hObject, handles)
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu17.
function popupmenu17_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
popupmenu17=get(hObject,'value');
    switch popupmenu17
       case 1
       bobotGaji='';
       case 2
       bobotGaji=1;
       case 3
       bobotGaji=2;
       case 4
       bobotGaji=3;
       case 5
       bobotGaji=4;
       case 6
       bobotGaji=5;
    end
handles.bobotGaji = bobotGaji;
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu17 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu17


% --- Executes during object creation, after setting all properties.
function popupmenu17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.popupmenu17=hObject;
guidata(hObject, handles)
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu18.
function popupmenu18_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
popupmenu18=get(hObject,'value');
    switch popupmenu18
       case 1
       bobotPendidikan='';
       case 2
       bobotPendidikan=1;
       case 3
       bobotPendidikan=2;
       case 4
       bobotPendidikan=3;
    end
handles.bobotPendidikan = bobotPendidikan;
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu18 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu18


% --- Executes during object creation, after setting all properties.
function popupmenu18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.popupmenu18=hObject;
guidata(hObject, handles)
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.uitable1=hObject;
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes during object creation, after setting all properties.
function uitable2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.uitable2=hObject;
guidata(hObject, handles);

% --- Executes on key press with focus on uitable1 and none of its controls.
function uitable1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function pushbutton4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.pushbutton4=hObject;
guidata(hObject, handles)

% --- Executes during object creation, after setting all properties.
function uitable3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.uitable3=hObject;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2
handles.axes2=hObject;
guidata(hObject, handles);

% --- Executes on selection change in popupmenu23.
function popupmenu23_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
popupmenu23=get(hObject,'value');
    switch popupmenu23
       case 1
       bobotStatusRumah='';
       case 2
       bobotStatusRumah=1;
       case 3
       bobotStatusRumah=2;
       case 4
       bobotStatusRumah=3;
    end
handles.bobotStatusRumah = bobotStatusRumah;
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu23 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu23


% --- Executes during object creation, after setting all properties.
function popupmenu23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.popupmenu23=hObject;
guidata(hObject, handles)
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.popupmenu13,'value',1);
set(handles.popupmenu14,'value',1);
set(handles.popupmenu15,'value',1);
set(handles.popupmenu16,'value',1);
set(handles.popupmenu17,'value',1);
set(handles.popupmenu18,'value',1);
set(handles.popupmenu23,'value',1);
set(handles.uitable1,'data','');
set(handles.uitable2,'data','');
set(handles.uitable3,'data','');

cla reset;


% --- Executes during object creation, after setting all properties.
function pushbutton6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.pushbutton6=hObject;
guidata(hObject, handles)
