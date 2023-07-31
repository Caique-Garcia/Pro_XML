unit ProXML.FormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Skia,
  Skia.Vcl, Vcl.FileCtrl;

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
    OpenDialog1: TOpenDialog;
    SkAnimatedImage1: TSkAnimatedImage;
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
  //clique na pasta
//  OpenDialog1.Create(nil);
//  try
//    OpenDialog1.OnShow(self);
//  finally
//    OpenDialog1.Free;
//  end;
end;

end.
