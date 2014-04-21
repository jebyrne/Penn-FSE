function varargout = gui_usage(varargin)
% GUI_USAGE MATLAB code for gui_usage.fig
%      GUI_USAGE, by itself, creates a new GUI_USAGE or raises the existing
%      singleton*.
%
%      H = GUI_USAGE returns the handle to a new GUI_USAGE or the handle to
%      the existing singleton*.
%
%      GUI_USAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_USAGE.M with the given input arguments.
%
%      GUI_USAGE('Property','Value',...) creates a new GUI_USAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_usage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_usage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_usage

% Last Modified by GUIDE v2.5 10-Oct-2012 16:21:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_usage_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_usage_OutputFcn, ...
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


% --- Executes just before gui_usage is made visible.
function gui_usage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_usage (see VARARGIN)

% Choose default command line output for gui_usage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Show image
global GUI;
GUI.is_exit = false; 
GUI.h = figure(128);
set(GUI.h,'NumberTitle','off','Toolbar','none','Menubar','none','Name','Video Bounding Box');
imdisplay(GUI.startframe);

% UIWAIT makes gui_usage wait for user response (see UIRESUME)
uiwait(handles.gui_usage);



% --- Outputs from this function are returned to the command line.
function varargout = gui_usage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;




% --- Executes on button press in playbutton.
function playbutton_Callback(hObject, eventdata, handles)
% hObject    handle to playbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.playbutton,'Enable','off');
set(handles.startframe_fastfwd,'Enable','off');
set(handles.startframe_fastback,'Enable','off');
set(handles.startframe_fwd,'Enable','off');
set(handles.startframe_back,'Enable','off');
set(handles.endframe_fastfwd,'Enable','off');
set(handles.endframe_fastback,'Enable','off');
set(handles.endframe_fwd,'Enable','off');
set(handles.endframe_back,'Enable','off');

global GUI;
for k=GUI.startframe:5:GUI.endframe
  imdisplay(k);
end
set(hObject,'Enable','on');

set(handles.playbutton,'Enable','on');
set(handles.startframe_fastfwd,'Enable','on');
set(handles.startframe_fastback,'Enable','on');
set(handles.startframe_fwd,'Enable','on');
set(handles.startframe_back,'Enable','on');
set(handles.endframe_fastfwd,'Enable','on');
set(handles.endframe_fastback,'Enable','on');
set(handles.endframe_fwd,'Enable','on');
set(handles.endframe_back,'Enable','on');

set(handles.exitbutton,'Enable','on');
set(handles.donebutton,'Enable','on');

% --- Executes on button press in endframe_fastback.
function endframe_fastback_Callback(hObject, eventdata, handles)
% hObject    handle to endframe_fastback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GUI;
GUI.endframe = max(GUI.endframe - 5*30,1);
GUI.startframe = min(GUI.startframe, GUI.endframe);
imdisplay(GUI.endframe);


% --- Executes on button press in endframe_fastback.
function endframe_back_Callback(hObject, eventdata, handles)
% hObject    handle to endframe_fastback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GUI;
GUI.endframe = max(GUI.endframe - 1,1);
GUI.startframe = min(GUI.startframe, GUI.endframe);
imdisplay(GUI.endframe);

% --- Executes on button press in endframe_fastfwd.
function endframe_fastfwd_Callback(hObject, eventdata, handles)
% hObject    handle to endframe_fastfwd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GUI;
GUI.endframe = min(GUI.endframe + 5*30, GUI.maxframes);
GUI.startframe = min(GUI.startframe, GUI.endframe);
imdisplay(GUI.endframe);


% --- Executes on button press in endframe_fastfwd.
function endframe_fwd_Callback(hObject, eventdata, handles)
% hObject    handle to endframe_fastfwd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GUI;
GUI.endframe = min(GUI.endframe + 1, GUI.maxframes);
GUI.startframe = min(GUI.startframe, GUI.endframe);
imdisplay(GUI.endframe);

% --- Executes on button press in startframe_fastback.
function startframe_fastback_Callback(hObject, eventdata, handles)
% hObject    handle to startframe_fastback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GUI;
GUI.startframe = max(GUI.startframe - 5*30,1);
GUI.endframe = max(GUI.startframe, GUI.endframe);
imdisplay(GUI.startframe);


% --- Executes on button press in startframe_fastback.
function startframe_back_Callback(hObject, eventdata, handles)
% hObject    handle to startframe_fastback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GUI;
GUI.startframe = max(GUI.startframe - 1,1);
GUI.endframe = max(GUI.startframe, GUI.endframe);
imdisplay(GUI.startframe);


% --- Executes on button press in startframe_fastfwd.
function startframe_fastfwd_Callback(hObject, eventdata, handles)
% hObject    handle to startframe_fastfwd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GUI;
GUI.startframe = min(GUI.startframe + 5*30, GUI.maxframes);
GUI.endframe = max(GUI.startframe, GUI.endframe);
imdisplay(GUI.startframe);


% --- Executes on button press in startframe_fastfwd.
function startframe_fwd_Callback(hObject, eventdata, handles)
% hObject    handle to startframe_fastfwd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GUI;
GUI.startframe = min(GUI.startframe + 1, GUI.maxframes);
GUI.endframe = max(GUI.startframe, GUI.endframe);
imdisplay(GUI.startframe);


% --- Executes on button press in donebutton.
function donebutton_Callback(hObject, eventdata, handles)
% hObject    handle to donebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GUI;
%delete(GUI.h);
delete(handles.gui_usage); 


% --- Executes on button press in exitbutton.
function exitbutton_Callback(hObject, eventdata, handles)
% hObject    handle to exitbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GUI;
GUI.is_exit = true; 
delete(GUI.h);
delete(handles.gui_usage); 


% --- Display image
function imdisplay(k_img)
global GUI;
figure(GUI.h);
imgname = fullfile(GUI.videodir,sprintf(GUI.imgstr, k_img));
img = imread(imgname);
roi = imcrop(img,GUI.bbox);
imagesc(roi);  axis image; axis off;
title(sprintf('[%s]:[%d-%d][%d/%d]', GUI.classname, GUI.startframe, GUI.endframe, k_img-GUI.startframe, GUI.endframe-GUI.startframe)); 
drawnow;
