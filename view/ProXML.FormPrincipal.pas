unit ProXML.FormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Skia,
  Skia.Vcl, Vcl.FileCtrl, Vcl.Buttons, Vcl.Imaging.pngimage;

type
  TFormPrincipal = class(TForm)
    PnlContainer: TPanel;
    PnlCabecalho: TPanel;
    PnlCorpo: TPanel;
    PnlInfo: TPanel;
    PnlLocal: TPanel;
    PnlLogo: TPanel;
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
    Memo1: TMemo;
    GifCarregando: TSkAnimatedImage;
    Image1: TImage;
    procedure SkSvg1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses
  uCalculadoraXML;

{$R *.dfm}

procedure TFormPrincipal.SkSvg1Click(Sender: TObject);
begin
  //Selecionando a pasta de arquivos
  FileOpenDialog1.Execute;
  EditCaminho.Text := FileOpenDialog1.FileName;
end;

procedure TFormPrincipal.SpeedButton1Click(Sender: TObject);
var
  CalculadoraXML : TCalculadoraXML;

begin
  GifCarregando.Visible := not GifCarregando.Visible;
  SpeedButton1.Enabled := false;


  CalculadoraXML:=  TCalculadoraXML.Create;
  try

    if EditCaminho.Text <> '' then
    begin
      CalculadoraXML.CaminhoDiretorio := EditCaminho.Text;
      CalculadoraXML.ProcessarXMLs;
    end;
    
  finally
    CalculadoraXML.Free;
  end;

  GifCarregando.Visible := not GifCarregando.Visible;
  SpeedButton1.Enabled := true;
end;

end.
