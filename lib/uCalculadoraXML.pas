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
    procedure GetTagValueFromXML(const FileName, TagName: string; var TagValue: string);
  end;

implementation

uses
  Vcl.FileCtrl,
  Xml.XMLIntf,
  Xml.XMLDoc,
  System.IOUtils,
  System.SysUtils,
  Vcl.Dialogs;

{ TCalculadoraXML }

procedure TCalculadoraXML.GetTagValueFromXML(const FileName, TagName: string;
  var TagValue: string);
  var
    XMLDocument: TXMLDocument;
    NodeinfNFe: IXMLNode;
    AValor: OleVariant;
    BValor: String;
begin

  XMLDocument := TXMLDocument.Create(nil);
  try
    XMLDocument.LoadFromFile(FileName);
    NodeinfNFe := XMLDocument.ChildNodes.FindNode('nfeProc').ChildNodes.FindNode('NFe').ChildNodes.FindNode('infNFe');
    // Aqui, navegamos pelos nós do XML
    TagValue := NodeinfNFe.ChildNodes.FindNode('ide').ChildValues['nNF'];
    AValor := NodeinfNFe.ChildNodes.FindNode('total').ChildNodes.FindNode('ICMSTot').ChildValues['vNF'];

    BValor := AValor;
    ValorTotal := BValor;
    ShowMessage(BValor);

  finally

    //FreeAndNil(XMLDocument);
  end;
end;

procedure TCalculadoraXML.ProcessarXMLs;
var
  files: TArray<string>;
  i: integer;
  TagValue: string;
begin
  //Processar XMLS no diretorio
  //Pegando arquivos e jogando num array de nomes de arquivos
  files := TDirectory.GetFiles(CaminhoDiretorio + '\', '*.xml');
  //ShowMessage(CaminhoDiretorio + '\' + '*.xml');
  TagValue:= '';
  //Rodando o array de Caminhos do XML
  for  i := Length(files)-1 downto 0 do
  begin
     GetTagValueFromXML(files[i],'cUF',TagValue);

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
