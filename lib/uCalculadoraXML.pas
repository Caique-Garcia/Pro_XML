unit uCalculadoraXML;

interface

type
  TCalculadoraXML = class
  private
    FValorTotal: String;
    FValorBaseICMS: String;
    FValorICMS: String;
    FCaminhoDiretorio: String;
    FValorTotalFloat: Double;
    procedure SetValorTotal(const Value: String);
    procedure SetValorBaseICMS(const Value: String);
    procedure SetValorICMS(const Value: String);
    procedure SetCaminhoDiretorio(const Value: String);
    procedure SetValorTotalFloat(const Value: Double);


  public
    property ValorTotal : String read FValorTotal write SetValorTotal;
    property ValorTotalFloat : Double read FValorTotalFloat Write SetValorTotalFloat;
    property ValorICMS : String read FValorICMS write SetValorICMS;
    property ValorBaseICMS : String read FValorBaseICMS write SetValorBaseICMS;
    property CaminhoDiretorio : String read FCaminhoDiretorio write SetCaminhoDiretorio;
    procedure ProcessarXMLs;
    procedure GetTagValueFromXML(var CaminhoXML: string);
  end;

  var
     AValorTotal: String;
     ContadorXML, ContadorXMLErro: Integer;


implementation

uses
  Vcl.FileCtrl,
  Xml.XMLIntf,
  Xml.XMLDoc,
  System.IOUtils,
  System.SysUtils,
  Vcl.Dialogs, ProXML.FormPrincipal;

{ TCalculadoraXML }

procedure TCalculadoraXML.GetTagValueFromXML(var CaminhoXML: string);
  var
    XMLDocument: IXMLDocument;
    NodeinfNFe: IXMLNode;
    BValorString: String;
    AValorFloat, BValorFloat: Double;
begin

   XMLDocument := TXMLDocument.Create(Nil);
  try
    //Aqui carregamos o arquivo XML no objeto XMLDocument
    XMLDocument.LoadFromFile(CaminhoXML);

    //Aqui Selecionamos e recuperando o valor da tag(nó)
    NodeinfNFe := XMLDocument.ChildNodes.FindNode('nfeProc').ChildNodes.FindNode('NFe').ChildNodes.FindNode('infNFe');
    AValorFloat := NodeinfNFe.ChildNodes.FindNode('total').ChildNodes.FindNode('ICMSTot').ChildValues['vNF'];


    ContadorXML := ContadorXML + 1;
    BValorFloat := AValorFloat/100;
    BValorString := FloatToStrF(BValorFloat, ffFixed, 15, 2);

    //Aqui Vamos passar pra variavel global o valor somado
    ValorTotalFloat := ValorTotalFloat + BValorFloat;

    //Aqui exibimos os resultados
    FormPrincipal.Memo1.Lines.Add(BValorString);
  finally
    //XMLDocument.Free;
  end;
end;

procedure TCalculadoraXML.ProcessarXMLs;
var
  files: TArray<string>;
  i: integer;
  AValorTotal: String;
begin
  ValorTotal := '0.00';
  //Processar XMLS no diretorio
  //Pegando arquivos e jogando num array de nomes de arquivos
  files := TDirectory.GetFiles(CaminhoDiretorio + '\', '*.xml');

    //Passando pelo Arraay com os nomes dos XMLs
    for  i := 0 to High(files) do
    begin
        ////Aqui executamos a função que lê o arquivo XML
        GetTagValueFromXML(files[i]);

    end;

    AValortotal := FloatToStrF(ValorTotalFloat, ffFixed, 15, 2);
    //Aqui vamos exibir a Soma
    FormPrincipal.LabelValorTotal.Caption := 'R$ ' +AValorTotal;
    FormPrincipal.Memo1.Lines.Add('Foram processasdos ' + IntToSTr(ContadorXML) + ' Arquivos XMLs')
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

procedure TCalculadoraXML.SetValorTotalFloat(const Value: Double);
begin
  FValorTotalFloat := Value;
end;

end.
