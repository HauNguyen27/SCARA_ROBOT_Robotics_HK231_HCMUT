 function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 10-Dec-2023 11:00:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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

% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global scara;
global theta1_pre;
global theta2_pre;
global d3_pre;
global theta4_pre; 
d     = [179 0 0 0];
theta = [0 90 0 0];
a     = [200 300 0 0];
alpha = [0 0 180 0];

scara = Arm_scara(d, theta, a, alpha);
theta1_pre = 0;
theta2_pre = pi/2;
d3_pre = 0;
theta4_pre = 0;

scara = scara.update();
set_ee(scara, handles);
scara.plot(handles.axes1, get(handles.coord,'Value'), get(handles.workspace,'Value'));

% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on slider movement.
function slider1_Callback(~, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

        global theta1;
        global theta2;
        global d3;
        global theta4;

        theta1 = (pi/180)*(get(handles.slider1,'Value'));
        set(handles.theta1_box,'String',theta1*180/pi);
        theta2 = str2double(get(handles.theta2_box,'String'));
        theta4 = str2double(get(handles.theta4_box,'String'));
        d3 = str2double(get(handles.d3_box,'String'));

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

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
        global theta1;
        global theta2;
        global d3;
        global theta4;
        
        theta2 = (pi/180)*(get(handles.slider2,'Value'));
        set(handles.theta2_box,'String',theta2*180/pi);
        theta1 = str2double(get(handles.theta1_box,'String'));
        theta4 = str2double(get(handles.theta4_box,'String'));
        d3 = str2double(get(handles.d3_box,'String'));

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

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
        global theta1;
        global theta2;
        global d3;
        global theta4;
         
        d3 = get(handles.slider3,'Value');
        set(handles.d3_box,'String',d3);
        theta1 = (pi/180)*str2double(get(handles.theta1_box,'String'));
        theta2 = (pi/180)*str2double(get(handles.theta2_box,'String'));
        theta4 = (pi/180)*str2double(get(handles.theta4_box,'String'));

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

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
        global theta1;
        global theta2;
        global d3;
        global theta4;
        
        theta4 = (pi/180)*(get(handles.slider4,'Value'));
        set(handles.theta4_box,'String',theta4*180/pi);
        theta2 = str2double(get(handles.theta2_box,'String'));
        theta1 = str2double(get(handles.theta1_box,'String'));
        d3 = str2double(get(handles.d3_box,'String'));
      
% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function theta1_box_Callback(hObject, eventdata, handles)
% hObject    handle to theta1_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta1_box as text
%        str2double(get(hObject,'String')) returns contents of theta1_box as a double

% --- Executes during object creation, after setting all properties.
function theta1_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta1_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function theta2_box_Callback(hObject, eventdata, handles)
% hObject    handle to theta2_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta2_box as text
%        str2double(get(hObject,'String')) returns contents of theta2_box as a double

% --- Executes during object creation, after setting all properties.
function theta2_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta2_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function d3_box_Callback(hObject, eventdata, handles)
% hObject    handle to d3_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d3_box as text
%        str2double(get(hObject,'String')) returns contents of d3_box as a double

% --- Executes during object creation, after setting all properties.
function d3_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d3_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function theta4_box_Callback(hObject, eventdata, handles)
% hObject    handle to theta4_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta4_box as text
%        str2double(get(hObject,'String')) returns contents of theta4_box as a double

% --- Executes during object creation, after setting all properties.
function theta4_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta4_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in forward_btn.
function forward_btn_Callback(hObject, eventdata, handles)
% hObject    handle to forward_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global scara
    global theta1;
    global theta2;
    global d3;
    global theta4;
    global theta1_pre;
    global theta2_pre;
    global d3_pre;
    global theta4_pre; 

        theta1 = (pi/180)*str2double(get(handles.theta1_box,'String'));
        theta2 = (pi/180)*str2double(get(handles.theta2_box,'String'));
        d3 = str2double(get(handles.d3_box,'String'));
        theta4 = (pi/180)*str2double(get(handles.theta4_box,'String'));

    if theta1 < deg2rad(-125)  || theta1 > deg2rad(125)
        warndlg('Mời nhập lại');
    elseif theta2 < deg2rad(-145) || theta2 > deg2rad(145)
        warndlg('Mời nhập lại');
    elseif d3 < 0 || d3 > 150
        warndlg('Mời nhập lại');
    elseif theta4 < deg2rad(0) || theta4 > deg2rad(360)
        warndlg('Mời nhập lại');
    else
    
        for k=1:15
         theta1_temp = theta1_pre + (theta1-theta1_pre)*(k)/15;
         theta2_temp = theta2_pre + (theta2-theta2_pre)*(k)/15;
         d3_temp = d3_pre + (-d3-d3_pre)*(k)/15;
         theta4_temp = theta4_pre + (theta4-theta4_pre)*(k)/15;

         set(handles.running,'visible','On');
         scara = scara.set_joint(1, theta1_temp);
         scara = scara.set_joint(2, theta2_temp);
         scara = scara.set_joint(3, d3_temp);
         scara = scara.set_joint(4, theta4_temp);
         scara = scara.update();
         set_ee(scara, handles);
         scara.plot(handles.axes1, get(handles.coord,'Value'), get(handles.workspace,'Value'));
        end
        
        set(handles.running,'visible','Off');
        theta1_pre = theta1;
        theta2_pre = theta2;
        d3_pre = -d3;
        theta4_pre = theta4;
    end
function x_val_Callback(hObject, eventdata, ~)
% hObject    handle to x_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_val as text
%        str2double(get(hObject,'String')) returns contents of x_val as a double

% --- Executes during object creation, after setting all properties.
function x_val_CreateFcn(hObject, ~, handles)
% hObject    handle to x_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function y_val_Callback(hObject, eventdata, handles)
% hObject    handle to y_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_val as text
%        str2double(get(hObject,'String')) returns contents of y_val as a double

% --- Executes during object creation, after setting all properties.
function y_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function z_val_Callback(hObject, eventdata, handles)
% hObject    handle to z_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_val as text
%        str2double(get(hObject,'String')) returns contents of z_val as a double

% --- Executes during object creation, after setting all properties.
function z_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function roll_val_Callback(hObject, eventdata, handles)
% hObject    handle to roll_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roll_val as text
%        str2double(get(hObject,'String')) returns contents of roll_val as a double

% --- Executes during object creation, after setting all properties.
function roll_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roll_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pitch_val_Callback(hObject, eventdata, handles)
% hObject    handle to pitch_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pitch_val as text
%        str2double(get(hObject,'String')) returns contents of pitch_val as a double

% --- Executes during object creation, after setting all properties.
function pitch_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pitch_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function yaw_val_Callback(hObject, eventdata, handles)
% hObject    handle to yaw_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yaw_val as text
%        str2double(get(hObject,'String')) returns contents of yaw_val as a double

% --- Executes during object creation, after setting all properties.
function yaw_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaw_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in workspace.
function workspace_Callback(hObject, eventdata, handles)
% hObject    handle to workspace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of workspace
global scara
scara.plot(handles.axes1, get(handles.coord,'Value'), get(handles.workspace,'Value'));  

% --- Executes on button press in coord.
function coord_Callback(hObject, eventdata, handles)
% hObject    handle to coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of coord
global scara
scara.plot(handles.axes1, get(handles.coord,'Value'), get(handles.workspace,'Value')); 

function x_inv_Callback(hObject, eventdata, handles)
% hObject    handle to x_inv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_inv as text
%        str2double(get(hObject,'String')) returns contents of x_inv as a double

% --- Executes during object creation, after setting all properties.
function x_inv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_inv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function y_inv_Callback(hObject, eventdata, handles)
% hObject    handle to y_inv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_inv as text
%        str2double(get(hObject,'String')) returns contents of y_inv as a double

% --- Executes during object creation, after setting all properties.
function y_inv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_inv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function z_inv_Callback(hObject, eventdata, handles)
% hObject    handle to z_inv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_inv as text
%        str2double(get(hObject,'String')) returns contents of z_inv as a double

% --- Executes during object creation, after setting all properties.
function z_inv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_inv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v_max_Callback(hObject, eventdata, handles)
% hObject    handle to v_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v_max as text
%        str2double(get(hObject,'String')) returns contents of v_max as a double

% --- Executes during object creation, after setting all properties.
function v_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function a_max_Callback(hObject, eventdata, handles)
% hObject    handle to a_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_max as text
%        str2double(get(hObject,'String')) returns contents of a_max as a double

% --- Executes during object creation, after setting all properties.
function a_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function yaw_inv_Callback(hObject, eventdata, handles)
% hObject    handle to yaw_inv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yaw_inv as text
%        str2double(get(hObject,'String')) returns contents of yaw_inv as a double

% --- Executes during object creation, after setting all properties.
function yaw_inv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaw_inv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in inverse_btn.
function inverse_btn_Callback(hObject, eventdata, handles)
% hObject    handle to inverse_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global scara
    global theta1;
    global theta2;
    global d3;
    global theta4;
    global theta1_pre;
    global theta2_pre;
    global d3_pre;
    global theta4_pre;
    global qt vt at j;

    a1 =200;
    a2 =300;

    x_in = str2double(handles.x_inv.String);
    y_in = str2double(handles.y_inv.String);
    z_in = str2double(handles.z_inv.String);
    yaw_in = deg2rad(str2double(handles.yaw_inv.String));

    x_end = str2double(handles.x_val.String);
    y_end = str2double(handles.y_val.String);
    z_end = str2double(handles.z_val.String);
    yaw_end = deg2rad(str2double(handles.yaw_val.String));
    
    vmax = str2double(handles.v_max.String);
    amax = str2double(handles.a_max.String);

    x_pre = x_end;
    y_pre = y_end;
    z_pre = z_end;
    yaw_pre = yaw_end;
    
    % Nhập giá trị động học nghịch
    if ((x_in^2 +y_in^2) > (a1+a2)^2)||(z_in < 29)||(z_in > 179)
        warndlg('Mời nhập lại!');
    else

        % Trajectory
        qmax = sqrt((x_in - x_end)^2 + (y_in - y_end)^2 + (z_in - z_end)^2);

        if vmax > sqrt(qmax*amax/2)
           vmax = sqrt(qmax*amax/2);
        end

        if (handles.lspb_btn.Value)
            t1 = vmax/amax;
            q1 = 1/2*amax*t1^2;
            t2 = (qmax - 2*q1)/vmax;
            q2 = qmax - 2*q1;
            t3 = 2*t1 + t2;
            dt = t3/75;

            t = 0:t3/75:t3;
            qt = zeros(size(length(t)));
            vt = zeros(size(length(t)));
            at = zeros(size(length(t)));

        elseif (handles.scurve_btn.Value)
            t1 = vmax/amax;
            t2 = 2*t1;
            t3 = qmax/vmax;
            t4 = t1 + t3;
            t5 = t2 + t3;
            jerk = amax/t1;
            dt = t5/75;

            t = 0:t5/75:t5;
            qt = zeros(size(length(t)));
            vt = zeros(size(length(t)));
            at = zeros(size(length(t)));
            j = zeros(size(length(t)));
        end

        for i=1:length(t)
        if (handles.lspb_btn.Value)
             if t(i) < t1
                qt(i) = 1/2*amax*t(i)^2;
                vt(i) = amax*t(i);
                at(i) = amax;
            elseif t(i) < t1 + t2
                qt(i) = q1 + vmax*(t(i) - t1);
                vt(i) = vmax;
                at(i) = 0;
            else 
                te = t(i) - t1 - t2;
                qt(i) = q1 + q2 + vmax*te - 1/2*amax*te^2;
                vt(i) = vmax - amax*te;
                at(i) = -amax;
             end

        elseif (handles.scurve_btn.Value)
            if t(i) <= t1
                qt(i) = 1/6*jerk*t(i)^3;   
                vt(i) = 1/2*jerk*t(i)^2;   
                at(i) = jerk*t(i);
                j(i) = jerk;
            elseif t(i) <= t2
                qt(i) = 1/6*jerk*t1^3 + 1/2*jerk*t1^2*(t(i)-t1) + 1/2*amax*(t(i)-t1)^2 - 1/6*jerk*(t(i)-t1)^3;
                vt(i) = 1/2*jerk*t1^2 + amax*(t(i)-t1) - 1/2*jerk*(t(i)-t1)^2;
                at(i) = amax - jerk*(t(i)-t1);
                j(i) = -jerk;
            elseif t(i) <= t3
                qt(i) = amax*t1^2 + vmax*(t(i)-t2);
                vt(i) = vmax;
                at(i) = 0;
                j(i) = 0;
            elseif t(i) <= t4
                qt(i) = amax*t1^2 + vmax*(t3-t2) + vmax*(t(i)-t3) - 1/6*jerk*(t(i)-t3)^3;
                vt(i) = vmax - 1/2*jerk*(t(i)-t3)^2;
                at(i) = -jerk*(t(i)-t3);
                j(i) = -jerk;
            elseif t(i) <= t5
                qt(i) = qmax - 1/6*jerk*(t5 - t(i))^3;
                vt(i) = vmax - 1/2*jerk*(t4-t3)^2 - amax*(t(i)-t4) + 1/2*jerk*(t(i)-t4)^2;
                at(i) = -amax + jerk*(t(i)-t4);
                j(i) = jerk;
            end
        end

        % Hoạch định lại toạ độ theo đường thẳng
        x = x_end + (qt(i)/qmax)*(x_in - x_end);
        y = y_end + (qt(i)/qmax)*(y_in - y_end);
        z = z_end + (qt(i)/qmax)*(z_in - z_end);
        yaw = yaw_end + (qt(i)/qmax)*(yaw_in - yaw_end);

        % Động học nghịch
        theta2 = acos((x^2 + y^2 - a1^2 - a2^2)/(2*a1*a2));
        theta1 = asin(((a1 + a2*cos(theta2))*y - a2*sin(theta2)*x)/((a1 + a2*cos(theta2))^2 +(a2*sin(theta2))^2));
        d3 = z - 179;
        theta4 = theta1 + theta2 - yaw;

        % Vòng lặp chạy robot
         theta1_temp = theta1_pre + (theta1-theta1_pre)*(i)/length(t);
         theta2_temp = theta2_pre + (theta2-theta2_pre)*(i)/length(t);
         d3_temp = d3_pre + (d3-d3_pre)*(i)/length(t);
         theta4_temp = theta4_pre + (theta4-theta4_pre)*(i)/length(t);

         set(handles.running,'visible','On');

         scara = scara.set_joint(1, theta1_temp);
         scara = scara.set_joint(2, theta2_temp);
         scara = scara.set_joint(3, d3_temp);
         scara = scara.set_joint(4, theta4_temp);
         scara = scara.update();
         set_ee(scara, handles);
         scara.plot(handles.axes1, get(handles.coord,'Value'), get(handles.workspace,'Value'));

        % vận tốc end effector
         v_end = [(x-x_pre)/dt;
                  (y-y_pre)/dt;
                  (z-z_pre)/dt;
                  (yaw-yaw_pre)/dt];

        % Ma trận jacobian
        Jacobian = [-a2*sin(theta1 + theta2) - a1*sin(theta1)    -a2*sin(theta1 + theta2)  0   0;
                    a2*cos(theta1 + theta2) + a1*cos(theta1)     a2*cos(theta1 + theta2)   0   0;
                    0                                            0                         1   0;
                    1                                            1                         0   1];

         v_joint = pinv(Jacobian)*v_end;
         vth1(i) = v_joint(1,1);
         vth2(i) = v_joint(2,1);
         vd3(i) = v_joint(3,1);
         vth4(i) = v_joint(4,1);

         qth1(i) = theta1;
         qth2(i) = theta2;
         qd3(i) = d3;
         qth4(i) = theta4;

         xd(i) = x;
         yd(i) = y;
         zd(i) = z;
         plot3(xd, yd, zd, 'k', 'linewidth', 2);

         axes(handles.theta1_plot);
         plot(qth1);
         ylabel('Theta1');
         hold off;
         grid on;
         axes(handles.theta2_plot);
         plot(qth2);
         ylabel('Theta2');
         hold off;
         grid on;
         axes(handles.d3_plot);
         plot(qd3);
         ylabel('D3');
         hold off;
         grid on;
         axes(handles.theta4_plot);
         plot(qth4);
         ylabel('Theta 4');
         hold off;
         grid on;

        if (handles.lspb_btn.Value)
             axes(handles.q1_plot);
             plot(qt);
             ylabel('q');
             hold off;
             grid on;
             axes(handles.v1_plot);
             plot(vt);
             ylabel('v');
             hold off;
             grid on;
             axes(handles.a1_plot);
             plot(at);
             ylabel('a');
             hold off;
             grid on;
             axes(handles.axes1); 

        elseif (handles.scurve_btn.Value)
             axes(handles.q1_plot);
             plot(qt);
             ylabel('q');
             hold off;
             grid on;
             axes(handles.v1_plot);
             plot(vt);
             ylabel('v');
             hold off;
             grid on;
             axes(handles.a1_plot);
             plot(at);
             ylabel('a');
             hold off;
             grid on;
             axes(handles.j_plot);
             plot(j);
             ylabel('Jerk');
             hold off;
             grid on;
             axes(handles.axes1);    
        end
        end

    end

    set(handles.running,'visible','Off');
    theta1_pre = theta1;
    theta2_pre = theta2;
    d3_pre = d3;
    theta4_pre = theta4;

% --- Executes on button press in lspb_btn.
function lspb_btn_Callback(hObject, eventdata, handles)
% hObject    handle to lspb_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in scurve_btn.
function scurve_btn_Callback(hObject, eventdata, handles)
% hObject    handle to scurve_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   
% --- Executes when uipanel4 is resized.
function uipanel4_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to uipanel4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in reset_btn.
function reset_btn_Callback(hObject, eventdata, handles)
% hObject    handle to reset_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global scara
global theta1;
global theta2;
global d3;
global theta4;
global theta1_pre;
global theta2_pre;
global d3_pre;
global theta4_pre;

    theta1 = 0;
    theta2 = pi/2;
    d3 = 0;
    theta4 = 0;
    for k=1:15
         theta1_temp = theta1_pre + (theta1-theta1_pre)*(k)/15;
         theta2_temp = theta2_pre + (theta2-theta2_pre)*(k)/15;
         d3_temp = d3_pre + (d3-d3_pre)*(k)/15;
         theta4_temp = theta4_pre + (theta4-theta4_pre)*(k)/15;

         set(handles.running,'visible','On');
         scara = scara.set_joint(1, theta1_temp);
         scara = scara.set_joint(2, theta2_temp);
         scara = scara.set_joint(3, d3_temp);
         scara = scara.set_joint(4, theta4_temp);
         scara = scara.update();
         set_ee(scara, handles);
         scara.plot(handles.axes1, get(handles.coord,'Value'), get(handles.workspace,'Value'));
    end

    set(handles.running,'visible','Off');
    theta1_pre = theta1;
    theta2_pre = theta2;
    d3_pre = d3;
    theta4_pre = theta4;
