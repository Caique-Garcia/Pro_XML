unit ProXML.FormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Skia,
  Skia.Vcl, Vcl.FileCtrl, Vcl.Buttons;

type
  TFormPrincipal = class(TForm)
    PnlContainer: TPanel;
    PnlCabecalho: TPanel;
    PnlCorpo: TPanel;
    PnlInfo: TPanel;
    PnlLocal: TPanel;
    PnlLogo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    PnlImg: TPanel;
    PnlInfoLocal: TPanel;
    SkSvg1: TSkSvg;
    SkAnimatedImage1: TSkAnimatedImage;
    FileOpenDialog1: TFileOpenDialog;
    EditCaminho: TEdit;
    Shape1: TShape;
    PnlBtns: TPanel;
    PnlBtnGO: TPanel;
    Shape2: TShape;
    SpeedButton1: TSpeedButton;
    PanelVaorICMS: TPanel;
    PanelValorBaseICMS: TPanel;
    PanelValorTotal: TPanel;
    PanelIMGValorTotal: TPanel;
    PanelTextoValorTotal: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label3: TLabel;
    LabelValorTotal: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LabelbaseICMS: TLabel;
    LabelValorICMS: TLabel;
    SkSvg2: TSkSvg;
    SkSvg3: TSkSvg;
    SkSvg4: TSkSvg;
    procedure SkSvg1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

procedure TFormPrincipal.SkSvg1Click(Sender: TObject);
begin
  //Selecionando a pasta de arquivos
  FileOpenDialog1.Execute;
  EditCaminho.Text := FileOpenDialog1.FileName ;
end;

end.
