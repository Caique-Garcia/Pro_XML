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
    FValorTotalBCFloat: Double;
    FValorTotalICMSFloat: Double;
    procedure SetValorTotal(const Value: String);
    procedure SetValorBaseICMS(const Value: String);
    procedure SetValorICMS(const Value: String);
    procedure SetCaminhoDiretorio(const Value: String);
    procedure SetValorTotalFloat(const Value: Double);
    procedure SetValorTotalBCFloat(const Value: Double);
    procedure SetValorTotalICMSFloat(const Value: Double);


  public
    property ValorTotal : String read FValorTotal write SetValorTotal;
    property ValorTotalFloat : Double read FValorTotalFloat Write SetValorTotalFloat;
    property ValorTotalBCFloat : Double read FValorTotalBCFloat Write SetValorTotalBCFloat;
    property ValorTotalICMSFloat : Double read FValorTotalICMSFloat Write SetValorTotalICMSFloat;
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
    NodeinfNFe, NodeprotNFe, NodeIde : IXMLNode;
    BValorString, TagAutorizado, NumeroNF: String;
    AValorFloat, BValorFloat, AValorFloatBC, AValorFloatICMS: Double;
begin
   XMLDocument := TXMLDocument.Create(Nil);
  try
    //Aqui carregamos o arquivo XML no objeto XMLDocument
    XMLDocument.LoadFromFile(CaminhoXML);
    NodeIde := XMLDocument.ChildNodes.FindNode('nfeProc').ChildNodes.FindNode('NFe').ChildNodes.FindNode('infNFe').ChildNodes.FindNode('ide');
    NumeroNF := NodeIde.ChildValues['nNF'];

    //Aqui vamos tentar pegar o Valor da Tag de Autorização
    NodeprotNFe := XMLDocument.ChildNodes.FindNode('nfeProc').ChildNodes.FindNode('protNFe');
    try
      TagAutorizado := NodeprotNFe.ChildNodes.FindNode('infProt').ChildValues['xMotivo'];
    except
      //Caso não consiga atribui nulo
      TagAutorizado := '';
    end;


    //Aqui vamos verificar se existe a tag de autorização no XML
    if TagAutorizado = 'Autorizado o uso da NF-e' then
    begin

      //Aqui Selecionamos e recuperando o valor da tag(nó)
      NodeinfNFe := XMLDocument.ChildNodes.FindNode('nfeProc').ChildNodes.FindNode('NFe').ChildNodes.FindNode('infNFe');
      AValorFloat := NodeinfNFe.ChildNodes.FindNode('total').ChildNodes.FindNode('ICMSTot').ChildValues['vNF'];

      ContadorXML := ContadorXML + 1;
      BValorFloat := AValorFloat/100;
      BValorString := FloatToStrF(BValorFloat, ffFixed, 15, 2);

      //Aqui Vamos passar pra variavel global o valor somado
      ValorTotalFloat := ValorTotalFloat + BValorFloat;


      //Aqui estamos calculando o calor da base de ICMS
      AValorFloatBC := NodeinfNFe.ChildNodes.FindNode('total').ChildNodes.FindNode('ICMSTot').ChildValues['vBC'];
      AValorFloatBC := AValorFloatBC/100;

      ValorTotalBCFloat := ValorTotalBCFloat + AValorFloatBC;

      //Aqui estamos calculando o valor do ICMS
      AValorFloatICMS := NodeinfNFe.ChildNodes.FindNode('total').ChildNodes.FindNode('ICMSTot').ChildValues['vICMS'];
      AValorFloatICMS := AValorFloatICMS/100;

      ValorTotalICMSFloat := ValorTotalICMSFloat + AValorFloatICMS;


      //Aqui exibimos os resultados
      //FormPrincipal.Memo1.Lines.Add(BValorString);
    end
    else
    begin
      // Aqui executamos caso o XMl não tenha a tag de autorização
      ContadorXMLErro := ContadorXMLErro +1;
      FormPrincipal.Memo1.Lines.Add(NumeroNF + ' - XML sem Tag de Autorização');
    end;

  finally
    //XMLDocument.Free;
  end;
end;

procedure TCalculadoraXML.ProcessarXMLs;
var
  files: TArray<string>;
  i: integer;
  AValorTotal, AValorTotalBC, AValorTotalICMS: String;
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

    //Aqui estamos transformando os valores Double em String
    AValortotal := FloatToStrF(ValorTotalFloat, ffFixed, 15, 2);
    AValorTotalBC := FloatToStrF(ValorTotalBCFloat, ffFixed, 15, 2);
    AValorTotalICMS := FloatToStrF(ValorTotalICMSFloat, ffFixed, 15, 2);;

    //Aqui vamos exibir a Soma
    FormPrincipal.LabelValorTotal.Caption := 'R$ ' +AValorTotal;
    FormPrincipal.LabelbaseICMS.Caption := 'R$ ' +AValorTotalBC;
    FormPrincipal.LabelValorICMS.Caption := 'R$ ' +AValorTotalICMS;

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

procedure TCalculadoraXML.SetValorTotalBCFloat(const Value: Double);
begin
  FValorTotalBCFloat := Value;
end;

procedure TCalculadoraXML.SetValorTotalFloat(const Value: Double);
begin
  FValorTotalFloat := Value;
end;

procedure TCalculadoraXML.SetValorTotalICMSFloat(const Value: Double);
begin
  FValorTotalICMSFloat := Value;
end;

end.
