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
    procedure GetTagValueFromXML(var CaminhoXML: string);
  end;

  var
     AValorTotal: String;


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
begin
   XMLDocument := TXMLDocument.Create(Nil);
  try
    //Aqui carregamos o arquivo XML no objeto XMLDocument
    XMLDocument.LoadFromFile(CaminhoXML);

    //Aqui Selecionamos e recuperando o valor da tag(nó)
    NodeinfNFe := XMLDocument.ChildNodes.FindNode('nfeProc').ChildNodes.FindNode('NFe').ChildNodes.FindNode('infNFe');
    BValorString := NodeinfNFe.ChildNodes.FindNode('ide').ChildValues['nNF'];

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
begin
  //Processar XMLS no diretorio
  //Pegando arquivos e jogando num array de nomes de arquivos
  files := TDirectory.GetFiles(CaminhoDiretorio + '\', '*.xml');

    //Passando pelo Arraay com os nomes dos XMLs
    for  i := 0 to High(files) do
    begin
        ////Aqui executamos a função que lê o arquivo XML
        GetTagValueFromXML(files[i]);

        //Aqui selecionamos o valor de uma das tags/nos do XMl
        //NodeinfNFe := XMLDocument.ChildNodes.FindNode('nfeProc').ChildNodes.FindNode('NFe').ChildNodes.FindNode('infNFe');

        //Aqui Recuperando valor total no xml da nota
        // XMLDocument.LoadFromFile(Files[i]);
        // AValor := XMLDocument
        // .ChildNodes.FindNode('nfeProc')
        // .ChildNodes.FindNode('NFe')
        // .ChildNodes.FindNode('infNFe')
        // .ChildNodes.FindNode('total')
        // .ChildNodes.FindNode('ICMSTot')
        // .ChildValues['vNF'];

        //Aqui somamos e convertemos os valores dessa tag
        //BValor := BValor + (AValor/100);
        //Valortotal := FloatToStrF(BValor, ffFixed, 15, 2);
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
