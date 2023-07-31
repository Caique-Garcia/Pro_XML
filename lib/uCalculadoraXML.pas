unit uCalculadoraXML;

interface

type
  TCalculadoraXML = class
  private
    FValorTotal: String;
    FValorBaseICMS: String;
    FValorICMS: String;
    FCaminhoDiretorio: String;
    procedure SetValorTotal(const Value: String);
    procedure SetValorBaseICMS(const Value: String);
    procedure SetValorICMS(const Value: String);
    procedure SetCaminhoDiretorio(const Value: String);


  public
    property ValorTotal : String read FValorTotal write SetValorTotal;
    property ValorICMS : String read FValorICMS write SetValorICMS;
    property ValorBaseICMS : String read FValorBaseICMS write SetValorBaseICMS;
    property CaminhoDiretorio : String read FCaminhoDiretorio write SetCaminhoDiretorio;
    procedure ProcessarXMLs;
  end;

implementation

uses
  Vcl.FileCtrl,
  Xml.XMLIntf,
  Xml.XMLDoc,
  System.IOUtils,
  System.SysUtils, Vcl.Dialogs;

{ TCalculadoraXML }

procedure TCalculadoraXML.ProcessarXMLs;
var
  dir: TDirectory;
  files: TArray<string>;
  doc: TXMLDocument;
  node: IXMLNode;
  i: integer;

begin
  //Processar XMLS no diretorio
  //Pegando arquivos e jogando num array de nomes de arquivos
  ShowMessage(CaminhoDiretorio);
  files := TDirectory.GetFiles(CaminhoDiretorio + '\', '*.xml');

  //Rodando o array de Caminhos do XML
  for I := 0 to Length(files)-1 do
  begin
    doc := TXMLDocument.Create(nil);
    doc.LoadFromFile(files[i]);

    node := doc.DocumentElement;
    ValorTotal := Inttostr(StrToint(ValorTotal) + StrToint(node.Attributes['vNF'].Value));

    doc.free;
  end;





end;

procedure TCalculadoraXML.SetCaminhoDiretorio(const Value: String);
begin
  FCaminhoDiretorio := Value;
end;

procedure TCalculadoraXML.SetValorBaseICMS(const Value: String);
begin
  FValorBaseICMS := Value;
end;

procedure TCalculadoraXML.SetValorICMS(const Value: String);
begin
  FValorICMS := Value;
end;

procedure TCalculadoraXML.SetValorTotal(const Value: String);
begin
  FValorTotal := Value;
end;

end.
