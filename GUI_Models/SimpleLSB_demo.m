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

% Last Modified by GUIDE v2.5 04-Nov-2014 14:27:12

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
handles.attackThresholdSP=0.004;

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
[originalImageFilename,originalImagePath]=uigetfile({'*.bmp';'*.pgm';'*.*'},'File Selector');
[~,originalImageName,originalImageExt]=fileparts(originalImageFilename);
handles.originalImageName=originalImageName;
handles.originalImageExt=originalImageExt;
handles.originalImagePath=originalImagePath;
%originalImagePath='D:\work\BOSSdb1.0\';
%originalImageFilename='2.pgm';
handles.originalImage=imread([originalImagePath originalImageFilename]);
imshow(handles.originalImage,'Parent',handles.originalImageAxes);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in perfromEmbedding.
function perfromEmbedding_Callback(hObject, eventdata, handles)
% hObject    handle to perfromEmbedding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pEmb=1;

[messageFilename,messagePath]=uigetfile({'*.htm';'*.txt';'*.*'},'Select file with message to embedd');
%messageFilename='pass.txt';
%messagePath='D:\work\';

%[stegoImageFilename,stegoImagePath]=uiputfile({'*.bmp';'*.pgm';'*.*'},'File Selector',[handles.originalImagePath handles.originalImageName '_SG.bmp' ]);
stegoImagePath=handles.originalImagePath;
stegoImageFilename=[handles.originalImageName '_SG.bmp' ];


messageFileInfo = dir([messagePath messageFilename]);
messageFileSize = 8*messageFileInfo.bytes;

capacity=floor(pEmb*numel(handles.originalImage)/3);

if(messageFileSize > capacity)
    msgbox(['CM capacity='  num2str(capacity) ' bits message file size = ' num2str(messageFileSize) ' bits'],'Impossible to emedd selected file');
    return;
end

b=getFileBits([messagePath messageFilename]);

handles.sgImage=eurModel3LSBreplacingSingleImageEmbedding(pEmb,b,handles.originalImage);

imshow(handles.sgImage,'Parent',handles.sgImageAxes);
imwrite(handles.sgImage,[stegoImagePath stegoImageFilename],'bmp');

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


function [bitArray] = getFileBits(filename)

fileID = fopen(filename);
A = uint8(fread(fileID));
fclose(fileID);
A(numel(A)+1:numel(A)+3)=[123;241;142]; % Signal of the EOF


bits=de2bi(A,8);
bitArray=reshape(bits',1,[]);

function [message] = getAndSaveMessageFromBits(bitArray,filename)

preBinaryMessage=reshape(bitArray,8,[]);
binaryMessage=preBinaryMessage';

message=bi2de(binaryMessage);

for i=1:numel(message)-2
    if(message(i)==123 && message(i+1)==241 && message(i+2)==142 )
        message=message(1:i-1);
        break;
    end
    if(i==numel(message)-2)
        error('Broken file. Can not extract message.')
    end
end

fileID=fopen(filename,'w')
fwrite(fileID,message);
fclose(fileID);



% --- Executes on button press in ExtractButton.
function ExtractButton_Callback(hObject, eventdata, handles)
% hObject    handle to ExtractButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pEmb=1;

[extractedMessageFilename,extractedMessagePath]=uiputfile({'*.txt';'*.*'},'Select file where to extract message');
%extractedMessageFilename='passExtracted.txt';
%extractedMessagePath='D:\work\';

messageBits=eurModel3LSBreplacingSingleImageExtracting(pEmb,handles.sgImage);
messsage=getAndSaveMessageFromBits(messageBits,[extractedMessagePath extractedMessageFilename]);


% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in openStegoImageButton.
function openStegoImageButton_Callback(hObject, eventdata, handles)
% hObject    handle to openStegoImageButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[stegoImageFilename,stegoImagePath]=uigetfile({'*.bmp';'*.pgm';'*.*'},'File Selector');
%stegoImagePath='D:\work\';
%stegoImageFilename='sg_1.pgm';
handles.stegoImagePath=stegoImagePath;
handles.stegoImageFilename=stegoImageFilename;
handles.sgImage=imread([stegoImagePath stegoImageFilename]);
imshow(handles.sgImage,'Parent',handles.sgImageAxes);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in AttackButton.
function AttackButton_Callback(hObject, eventdata, handles)
% hObject    handle to AttackButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.attackThresholdSP = str2num(cell2mat(inputdlg('Threshold','Enter threshold',1,{num2str(handles.attackThresholdSP)})));

cmAttackValue=borrowedFridrichSP(handles.originalImage);
set(handles.hi2CMValueText,'String',cmAttackValue);

sgAttackValue=borrowedFridrichSP(handles.sgImage);
set(handles.hi2SGValueText,'String',sgAttackValue);

if(cmAttackValue>handles.attackThresholdSP)
    set(handles.hi2CMStatus,'String','Embedding Detected!!');
else
    set(handles.hi2CMStatus,'String','Not Detected.');
end

if(sgAttackValue>handles.attackThresholdSP)
    set(handles.hi2SGStatus,'String','Embedding Detected!!');
else
    set(handles.hi2SGStatus,'String','Not Detected.');
end


% Update handles structure
guidata(hObject, handles);
