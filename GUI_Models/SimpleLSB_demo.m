function varargout = SimpleLSB_demo(varargin)
% SIMPLELSB_DEMO MATLAB code for SimpleLSB_demo.fig
%      SIMPLELSB_DEMO, by itself, creates a new SIMPLELSB_DEMO or raises the existing
%      singleton*.
%
%      H = SIMPLELSB_DEMO returns the handle to a new SIMPLELSB_DEMO or the handle to
%      the existing singleton*.
%
%      SIMPLELSB_DEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMPLELSB_DEMO.M with the given input arguments.
%
%      SIMPLELSB_DEMO('Property','Value',...) creates a new SIMPLELSB_DEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SimpleLSB_demo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SimpleLSB_demo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SimpleLSB_demo

% Last Modified by GUIDE v2.5 23-Oct-2014 10:52:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SimpleLSB_demo_OpeningFcn, ...
                   'gui_OutputFcn',  @SimpleLSB_demo_OutputFcn, ...
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


% --- Executes just before SimpleLSB_demo is made visible.
function SimpleLSB_demo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SimpleLSB_demo (see VARARGIN)

% Choose default command line output for SimpleLSB_demo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SimpleLSB_demo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SimpleLSB_demo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in openImageButton.
function openImageButton_Callback(hObject, eventdata, handles)
% hObject    handle to openImageButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%[originalImageFilename,originalImagePath]=uigetfile({'*.bmp';'*.pgm';'*.*'},'File Selector');
originalImagePath='D:\work\BOSSdb1.0\';
originalImageFilename='1.pgm';
handles.originalImage=imread([originalImagePath originalImageFilename]);
imshow(handles.originalImage,'Parent',handles.originalImageAxes);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in perfromEmbedding.
function perfromEmbedding_Callback(hObject, eventdata, handles)
% hObject    handle to perfromEmbedding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.sgImage=handles.originalImage+uint8(round(rand(size(handles.originalImage))));

imshow(handles.sgImage,'Parent',handles.sgImageAxes);

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in visualAttackButton.
function visualAttackButton_Callback(hObject, eventdata, handles)
% hObject    handle to visualAttackButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.originalImageVisualAttack=255*mod(handles.originalImage,2);
handles.sgImageVisualAttack=255*mod(handles.sgImage,2);

imshow(handles.originalImageVisualAttack,'Parent',handles.originalImageVisualAttackAxes);
imshow(handles.sgImageVisualAttack,'Parent',handles.sgImageVisualAttackAxes);

% Update handles structure
guidata(hObject, handles);