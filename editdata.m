function varargout = editdata(varargin)
% EDITDATA MATLAB code for editdata.fig
%      EDITDATA, by itself, creates a new EDITDATA or raises the existing
%      singleton*.
%
%      H = EDITDATA returns the handle to a new EDITDATA or the handle to
%      the existing singleton*.
%
%      EDITDATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDITDATA.M with the given input arguments.
%
%      EDITDATA('Property','Value',...) creates a new EDITDATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before editdata_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to editdata_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help editdata

% Last Modified by GUIDE v2.5 24-Oct-2014 17:24:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @editdata_OpeningFcn, ...
                   'gui_OutputFcn',  @editdata_OutputFcn, ...
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


% --- Executes just before editdata is made visible.
function editdata_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to editdata (see VARARGIN)
clc

% Load Config
run('config.m')
 
% Eksekusi Query
sql = exec(dbConn,['SELECT alternatif.ID_kriteria, pemohon.Nama_Pemohon, alternatif.UangMuka,alternatif.Angsuran, alternatif.Pekerjaan, alternatif.LamaBekerja, alternatif.Gaji, alternatif.Pendidikan, alternatif.StatusRumah FROM alternatif LEFT JOIN pemohon ON pemohon.Id_kriteria = alternatif.ID_kriteria ']);
result = fetch(sql);
set(handles.uitable1,'data', result.Data);

% Choose default command line output for editdata
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes editdata wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = editdata_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.edit1=hObject;
guidata(hObject, handles);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Load Config
run('config.m')

%GET TEXTFIELD
A = get(handles.edit1,'String');
B = str2num(get(handles.edit9,'String'));
C = str2num(get(handles.edit10,'String'));
%D = str2num(get(handles.edit4,'String'));
%E = str2num(get(handles.edit5,'String'));
F = str2num(get(handles.edit11,'String'));
%G = str2num(get(handles.edit7,'String'));
%H = str2num(get(handles.edit8,'String'));
%I = str2num(get(handles.edit8,'String'));

%GET FROM POP UP MENU
Pekerjaan=handles.valuepekerjaan;
LamaBekerja=handles.valuelamabekerja;
Pendidikan=handles.valuependidikan;
StatusRumah=handles.valuestatusrumah;

% Add a records using FASTINSERT.
% Insert data into Table1.
fastinsert(dbConn,'alternatif',{'Id_Kriteria','UangMuka','Angsuran','Pekerjaan','LamaBekerja','Gaji','Pendidikan','StatusRumah'}, {A,B,C,Pekerjaan,LamaBekerja,F,Pendidikan,StatusRumah});

% Eksekusi Query
sql = exec(dbConn,'SELECT * FROM alternatif');
result = fetch(sql);
set(handles.uitable1,'data',result.Data);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Load Config
run('config.m')

% Eksekusi Query
sql = exec(dbConn,'SELECT alternatif.ID_kriteria, pemohon.Nama_Pemohon, alternatif.UangMuka,alternatif.Angsuran, alternatif.Pekerjaan, alternatif.LamaBekerja, alternatif.Gaji, alternatif.Pendidikan, alternatif.StatusRumah FROM alternatif LEFT JOIN pemohon ON pemohon.Id_kriteria = alternatif.ID_kriteria');
result = fetch(sql);
set(handles.uitable1,'data',result.Data);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc

% Load Config
run('config.m')

%GET TEXTFIELD
A = (get(handles.edit1,'String'));
% Add a records using FASTINSERT.
% Insert data into Table1.
sql=['delete from alternatif where Id_Kriteria = ' '''' A ''''];
curs = exec(dbConn,sql);
curs =fetch(curs);
curs.Data

sql = exec(dbConn,'SELECT alternatif.ID_kriteria, pemohon.Nama_Pemohon, alternatif.UangMuka,alternatif.Angsuran, alternatif.Pekerjaan, alternatif.LamaBekerja, alternatif.Gaji, alternatif.Pendidikan, alternatif.StatusRumah FROM alternatif LEFT JOIN pemohon ON pemohon.Id_kriteria = alternatif.ID_kriteria');
result = fetch(sql);
set(handles.uitable1,'data',result.Data);

% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
popupmenu6=get(hObject,'value');
    switch popupmenu6
       case 1
       valuepekerjaan='';
       case 2
       valuepekerjaan=1;
       case 3
       valuepekerjaan=2;
    end
handles.valuepekerjaan = valuepekerjaan;
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.popupmenu6=hObject;
guidata(hObject, handles);
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu9.
function popupmenu9_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
popupmenu9=get(hObject,'value');
    switch popupmenu9
       case 1
       valuependidikan='';
       case 2
       valuependidikan=1;
       case 3
       valuependidikan=2;
       case 4
       valuependidikan=3;
    end
handles.valuependidikan= valuependidikan;
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu9


% --- Executes during object creation, after setting all properties.
function popupmenu9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.popupmenu9=hObject;
guidata(hObject, handles);
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu10.
function popupmenu10_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
popupmenu10=get(hObject,'value');
    switch popupmenu10
       case 1
       valuelamabekerja='';
       case 2
       valuelamabekerja=1;
       case 3
       valuelamabekerja=2;
       case 4
       valuelamabekerja=3;
       case 5
       valuelamabekerja=4;
       case 6
       valuelamabekerja=5;
       case 7
       valuelamabekerja=6;
       case 8
       valuelamabekerja=7;
       case 9
       valuelamabekerja=8;
       case 10
       valuelamabekerja=9;
       case 11
       valuelamabekerja=10;
    end
handles.valuelamabekerja = valuelamabekerja;
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu10


% --- Executes during object creation, after setting all properties.
function popupmenu10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.popupmenu10=hObject;
guidata(hObject, handles);
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
close;


% --- Executes on selection change in popupmenu12.
function popupmenu12_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
popupmenu12=get(hObject,'value');
    switch popupmenu12
       case 1
       valuestatusrumah='';
       case 2
       valuestatusrumah=1;
       case 3
       valuestatusrumah=2
       case 4
       valuestatusrumah=3;
    end
handles.valuestatusrumah= valuestatusrumah;
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu12 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu12


% --- Executes during object creation, after setting all properties.
function popupmenu12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.popupmenu12=hObject;
guidata(hObject, handles);
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.pushbutton2=hObject;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.uitable1=hObject;
guidata(hObject, handles);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1,'string','');
set(handles.edit9,'string','');
set(handles.edit10,'string','');
set(handles.popupmenu6,'value',1);
set(handles.popupmenu10,'value',1);
set(handles.edit11,'string','');
set(handles.popupmenu9,'value',1);
set(handles.popupmenu12,'value',1);
set(handles.uitable1,'data','');



% --- Executes during object creation, after setting all properties.
function pushbutton7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.pushbutton7=hObject;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function pushbutton4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.pushbutton4=hObject;
guidata(hObject, handles);



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.edit9=hObject;
guidata(hObject, handles);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.edit10=hObject;
guidata(hObject, handles);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.edit11=hObject;
guidata(hObject, handles);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
