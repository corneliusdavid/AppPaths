unit ufrmAppPaths;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.ListBox, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ListView,
  FMX.TabControl, System.Actions, FMX.ActnList, Beyond.Bind.DateUtils,
  Beyond.Bind.Json, Beyond.Bind.StrUtils;

type
  TfrmAppPaths = class(TForm)
    tblPaths: TFDMemTable;
    tblPathsPathName: TStringField;
    tblPathsPathValue: TStringField;
    BindingsList1: TBindingsList;
    BindSourcePaths: TBindSourceDB;
    pnlBottom: TPanel;
    btnInfo: TButton;
    lblTitle: TLabel;
    lvPaths: TListView;
    LinkListControlToField1: TLinkListControlToField;
    tabctrlAppPaths: TTabControl;
    tabPaths: TTabItem;
    tabFiles: TTabItem;
    aclAppPaths: TActionList;
    actNextTabFiles: TNextTabAction;
    tblFiles: TFDMemTable;
    tblFilesFilename: TStringField;
    lvFiles: TListView;
    BindSourceFiles: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    pnlFiles: TPanel;
    btnBack: TButton;
    lblPathName: TLabel;
    actPrevTabPaths: TPreviousTabAction;
    LinkPropertyToFieldText: TLinkPropertyToField;
    StyleBk: TStyleBook;
    LinkPropertyToFieldTagString: TLinkPropertyToField;
    procedure FormCreate(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure lvPathsGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure lvPathsItemClick(const Sender: TObject; const AItem: TListViewItem);
  private
    const
      MAX_FILES = 100;
    procedure CheckYesButton(Sender: TObject; const AResult: TModalResult);
    procedure GotoGitHub;
    procedure RefreshPathList;
    procedure RefreshFileList;
  end;

var
  frmAppPaths: TfrmAppPaths;

implementation

{$R *.fmx}
{$R *.Macintosh.fmx MACOS}
{$R *.iPad.fmx IOS}
{$R *.iPhone.fmx IOS}
{$R *.iPhone4in.fmx IOS}
{$R *.iPhone47in.fmx IOS}
{$R *.iPhone55in.fmx IOS}
{$R *.XLgXhdpiTb.fmx ANDROID}
{$R *.SmXhdpiPh.fmx ANDROID}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.Windows.fmx MSWINDOWS}

uses
  System.IOUtils,
  FMX.DialogService.Async,
  uOpenURL;

procedure TfrmAppPaths.btnInfoClick(Sender: TObject);
begin
  TDialogServiceAsync.MessageDialog('AppPaths - Display the value of several path funtions in Delphi''s TPath class. Compile and run this on different platforms (Windows, Mac, Android, and iOS) to see differences.' + sLineBreak + sLineBreak +
                                    'Based on a tutorial app in the book, Fearless Cross-Platform Development with Delphi, by David Cornelius, published by Packt Publishing.  Icon by Icons8, https://icons8.com' + sLineBreak + sLineBreak +
                                    'Would you like to visit the GitHub project site?',
                                    TMsgDlgType.mtInformation,
                                    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbClose],
                                    TMsgDlgBtn.mbClose, 0, CheckYesButton);
end;

procedure TfrmAppPaths.FormCreate(Sender: TObject);
begin
  // keep the tabs visible at design-time for ease of design, hide at run-time
  tabctrlAppPaths.TabPosition := TTabPosition.None;
  // make sure we start with paths no matter where we left them at design-time
  tabctrlAppPaths.ActiveTab := tabPaths;

  RefreshPathList;

  ReportMemoryLeaksOnShutdown := True;
end;

procedure TfrmAppPaths.CheckYesButton(Sender: TObject; const AResult: TModalResult);
begin
  if AResult = mrYes then
    GotoGitHub;
end;

procedure TfrmAppPaths.GotoGitHub;
begin
  TUrlOpen.Open('https://github.com/corneliusdavid/AppPaths');
end;

procedure TfrmAppPaths.RefreshFileList;
var
  LMaxFileMsgAdded: Boolean;
  LCurrPath: string;
begin
  // fill the file list with file names for the specified path
  tblFiles.EmptyDataSet;

  LCurrPath := tblPathsPathValue.AsString;
  LMaxFileMsgAdded := False;

  TDirectory.GetFiles(tblPathsPathValue.AsString, TSearchOption.soTopDirectoryOnly,
    function(const Path: string; const SearchRec: TSearchRec): Boolean
    begin
      Result := tblFiles.RecordCount < MAX_FILES;

      if Result then
        tblFiles.AppendRecord([SearchRec.Name])
      else if not LMaxFileMsgAdded then begin
        LMaxFileMsgAdded := True;
        tblFiles.AppendRecord([Format('(File count capped at %d)', [MAX_FILES])]);
      end;
    end);

  tblFiles.First;
end;

procedure TfrmAppPaths.RefreshPathList;
begin
  // fill the path list with path values
  tblPaths.EmptyDataSet;
  tblPaths.AppendRecord(['Application Name', ParamStr(0)]);
  tblPaths.AppendRecord(['Current directory', GetCurrentDir]);
  {$IFDEF CONDITIONALEXPRESSIONS}
    {$IF CompilerVersion >= 29.0}
    tblPaths.AppendRecord(['AppPath', TPath.GetAppPath]);
    tblPaths.AppendRecord(['Desktop', TPath.GetDesktopPath]);
    {$ENDIF}
  {$ENDIF}
  tblPaths.AppendRecord(['Temp', TPath.GetTempPath]);
  tblPaths.AppendRecord(['Home', TPath.GetHomePath]);
  tblPaths.AppendRecord(['Documents', TPath.GetDocumentsPath]);
  tblPaths.AppendRecord(['Library', TPath.GetLibraryPath]);
  tblPaths.AppendRecord(['Cache', TPath.GetCachePath]);
  {$IFNDEF IOS}
  tblPaths.AppendRecord(['Shared', TPath.GetSharedDocumentsPath]);
  tblPaths.AppendRecord(['Public', TPath.GetPublicPath]);
  tblPaths.AppendRecord(['Pictures', TPath.GetPicturesPath]);
  tblPaths.AppendRecord(['Shared Pictures', TPath.GetSharedPicturesPath]);
  tblPaths.AppendRecord(['Camera', TPath.GetCameraPath]);
  tblPaths.AppendRecord(['Shared Camera', TPath.GetSharedCameraPath]);
  tblPaths.AppendRecord(['Music', TPath.GetMusicPath]);
  tblPaths.AppendRecord(['Shared Music', TPath.GetSharedMusicPath]);
  tblPaths.AppendRecord(['Movies', TPath.GetMoviesPath]);
  tblPaths.AppendRecord(['SharedMovies', TPath.GetSharedMoviesPath]);
  tblPaths.AppendRecord(['Alarms', TPath.GetAlarmsPath]);
  tblPaths.AppendRecord(['Shared Alarms', TPath.GetSharedAlarmsPath]);
  tblPaths.AppendRecord(['Downloads', TPath.GetSharedAlarmsPath]);
  tblPaths.AppendRecord(['Shared Downloads', TPath.GetSharedDownloadsPath]);
  tblPaths.AppendRecord(['Ringtones', TPath.GetRingtonesPath]);
  tblPaths.AppendRecord(['Shared Ringtones', TPath.GetSharedRingtonesPath]);
  {$ENDIF}

  tblPaths.First;
end;

procedure TfrmAppPaths.lvPathsGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  case EventInfo.GestureID of
    sgiLeft:
      begin
        if tabctrlAppPaths.ActiveTab <> tabPaths then
          tabctrlAppPaths.ActiveTab := tabPaths;
        Handled := True;
      end;
  end;
end;

procedure TfrmAppPaths.lvPathsItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  if not SameText(tblPathsPathName.AsString, 'Application Name') then begin
    RefreshFileList;
    actNextTabFiles.Execute;
  end;
end;

end.
