unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TForm3 = class(TForm)
    TrackBar1: TTrackBar;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure TrackBar1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
  Button1.Enabled := false;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  Form3.Close;
end;

procedure TForm3.TrackBar1Change(Sender: TObject);
begin
  label1.Caption := 'Колличество потоков: ' + inttostr (trackbar1.Position);
  Button1.Enabled := true;
end;

end.
