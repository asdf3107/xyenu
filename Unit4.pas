unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, clipbrd, ShellAPI;

type
  TForm4 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
  Clipboard.AsText := edit1.Text;
  MessageBeep( MB_ICONASTERISK );
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Clipboard.AsText := edit2.Text;
  MessageBeep( MB_ICONASTERISK );
end;

procedure TForm4.Button3Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(Edit1.text), nil, nil, SW_NORMAL );
end;

procedure TForm4.Button4Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(Edit2.text), nil, nil, SW_NORMAL );
end;

end.
