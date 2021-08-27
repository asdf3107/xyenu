unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.Buttons, SyncObjs, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, Math, DateUtils, ShellApi, clipbrd, IdURI;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    ListView1: TListView;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Panel1: TPanel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Timer1: TTimer;
    N6: TMenuItem;
    N7: TMenuItem;
    Button6: TButton;
    PopupMenu1: TPopupMenu;
    URL1: TMenuItem;
    URL2: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    Panel2: TPanel;
    StaticText1: TStaticText;
    Label1: TLabel;
    StaticText2: TStaticText;
    Label2: TLabel;
    StaticText3: TStaticText;
    Label3: TLabel;
    StaticText4: TStaticText;
    Label4: TLabel;
    Button5: TButton;
    Memo1: TMemo;
    Button7: TButton;
    Button8: TButton;
    N10: TMenuItem;
    Edit2: TEdit;
    Button9: TButton;
    Button10: TButton;
    N11: TMenuItem;
    N12: TMenuItem;
    ListBox1: TListBox;
    procedure N2Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListView1AdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure ListView1AdvancedCustomDrawSubItem(Sender: TCustomListView;
      Item: TListItem; SubItem: Integer; State: TCustomDrawState;
      Stage: TCustomDrawStage; var DefaultDraw: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure URL2Click(Sender: TObject);
    procedure ListView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure URL1Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure N9Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
  private
    procedure MakeReport;
    procedure ReportRequest;
    procedure MakeSitemap;
    { Private declarations }
  public
    function GetColor(i: integer): TColor;
    function CheckUrl (AStr : string) : string;
    { Public declarations }


  end;

  type
    TNewThread = class(TThread)
    private
    procedure AddNewLink;
    procedure AddSubitems;
      { Private declarations }
    protected
      procedure Execute; override;
    end;


var
  Form1: TForm1;
  sort, selectedUrl, source, old, dom, prot, www : string;
  ans, curUrl, j, thread, maxThreads : integer;
  once, work: boolean;
  CS, CS2, CS4 : TCriticalSection;
  tTime, tTime2 : TDateTime;
  links : TStringLIst;
  IdHandler : TIdSSLIOHandlerSocketOpenSSL;
  NewThread: TNewThread;
  Item : TListItem;

implementation

{$R *.dfm}

uses Unit3, Unit4, Unit5;


procedure TForm1.MakeSitemap;
var F: TextFile;
   i: Integer;
   strl : TStringList;
begin

  strl := TStringList.Create;
  AssignFile(F, 'sitemap.xml');
  Rewrite(F);
  WriteLn(F, '<?xml version="1.0" encoding="UTF-8"?>');
  WriteLn(F, '<urlset');
  WriteLn(F, '      xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"');
  WriteLn(F, '      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"');
  WriteLn(F, '      xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9');
  WriteLn(F, '            http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">');
  WriteLn(F, '<!-- created with Vanik''s Xueny Link Crawler -->');
  WriteLn(F, '');
  WriteLn(F, '');

  strl.Sorted := false;
  for i := 0 to ListView1.items.count-1 do
    begin
      if (ListView1.Items[i].subitems[0] = 'ok') and (ListView1.Items[i].subitems[1] = 'text/html') then
        begin
          strl.Add(ListView1.Items[i].Caption);
        end;
    end;
  strl.Sorted := true;

  for i := 0 to strl.Count-1 do
    begin
      WriteLn(F, '<url>');
      WriteLn(F, '  <loc>' + strl[i] + '</loc>');
      WriteLn(F, '  <lastmod>2020-07-06T18:17:19+00:00</lastmod>');
      WriteLn(F, '  <priority>1.00</priority>');
      WriteLn(F, '</url>');
    end;



  WriteLn(F, '');
  WriteLn(F, '');
  WriteLn(F, '</urlset>');

  CloseFile(F);

  beep;
  showmessage ('Done!');
end;

procedure TForm1.MakeReport;
var F: TextFile;
  errs, ok, ext, i: Integer;
begin

  for i := 0 to ListView1.items.count-1 do
    begin
      if ListView1.Items[i].subitems[0] = 'skip external' then inc(ext) ;
      if ListView1.Items[i].subitems[0] = 'ok' then inc(ok);
      if ListView1.Items[i].subitems[0] = 'not found' then inc(errs);
    end;


  AssignFile(F, 'report.html');
  Rewrite(F);

  WriteLn(F, '<h1>����� �� ����� ' + edit1.text + '</h1>');
  WriteLn(F, '<p>������� ������: ' + inttostr (ok) + '</p>');
  WriteLn(F, '<p>����� ������: ' + inttostr (errs) + '</p>');
  WriteLn(F, '<p>������� ������: ' + inttostr (ext) + '</p>');

  CloseFile(F);

  ShellExecute(handle, 'open', PChar(ExtractFilePath(paramstr(0)) + 'report.html'), nil, nil, SW_NORMAL );

end;

function TForm1.CheckUrl (AStr : string) : string;
const
  Conversion = ['�'..'�', ' '];
var
  Sp, Rp: PChar;
  i : integer;
begin

  if (pos ('%D', AStr) <> 0) or (pos ('%B', AStr) <> 0) or (pos ('%8', AStr) <> 0) or
     (pos ('%9', AStr) <> 0) or (pos ('%2', AStr) <> 0) or (pos ('%3', AStr) <> 0) or
     (pos ('%E', AStr) <> 0) or (pos ('%A', AStr) <> 0) then exit;


  AStr := ansilowercase(AStr);

  for I := 1 to length(AStr) do
  begin
    if AStr[i] in Conversion then
      begin
        result := 'enc';
        exit;
      end
  end;


end;

function TForm1.GetColor (i : integer) : TColor;
begin


  result := clGray;

  if ListView1.Items[i].SubItems.Count = 0 then exit;

  if ListView1.Items[i].subitems[0] = 'busy' then result := clBlack;
  if ListView1.Items[i].subitems[0] = 'skip external' then result := clBlue;
  if ListView1.Items[i].subitems[0] = 'ok' then result := clGreen;
  if ListView1.Items[i].subitems[0] = 'not found' then result := clRed;


end;

function CustomSortProc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin

  if ParamSort=0 then
   begin
    if sort = 'asc' then Result := CompareText(Item1.Caption,Item2.Caption)
        else Result := -CompareText(Item1.Caption,Item2.Caption);
   end
  else
   begin
    if Item1.SubItems.Count>ParamSort-1 then
      begin
        if Item2.SubItems.Count>ParamSort-1 then
         begin
          if sort = 'asc' then Result := CompareText(Item1.SubItems[ParamSort-1],Item2.SubItems[ParamSort-1])
              else Result := -CompareText(Item1.SubItems[ParamSort-1],Item2.SubItems[ParamSort-1]);
         end
        else
          begin
           if sort = 'asc' then Result:= 1 else Result:= -1;
          end;
      end
    else
      begin
        if sort = 'asc' then Result:= -1 else Result:= 1;
      end;
   end;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin





//
// NewThread := TNewThread.Create(true);
// NewThread.FreeOnTerminate := True; // ���������� ����� ����� ���������� ������
// NewThread.Resume;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 listView1.SetFocus;
 curUrl := 0;

 Item := ListView1.Items.Add;
 Item.Caption := edit1.text;
 Item.SubItems.Add('pending');
 Item.SubItems.Add('');
 Item.SubItems.Add('');
 Item.SubItems.Add('');
 Item.SubItems.Add('');
 Item.SubItems.Add('');
 Item.SubItems.Add('');
 Item.SubItems.Add('0');

 if pos ('http://', edit1.Text) = 1 then prot := 'http://';
 if pos ('https://', edit1.Text) = 1 then prot := 'https://';
 
 if (pos ('https://', edit1.Text) = 0) and (pos ('http://', edit1.Text) = 0) then
   begin
     showmessage ('����� ������� �������� https:// or http://');
     exit;
   end;

 if pos ('//www.', edit1.Text) <> 0 then www := 'www.';

 dom := edit1.Text;
 if dom[length (dom)] = '/' then dom := copy (dom, 1, length (dom)-1);
 dom := stringreplace (dom, prot, '', [rfReplaceAll]);



 links.Add(prot + www + dom);
 links.Add(prot + www + dom + '/');


// showmessage (dom); exit;

// Button3.Enabled := false; Button4.Enabled := false; Button6.Enabled := false;

 maxThreads := Form3.TrackBar1.Position;
 maxThreads := 50;
 work := true;

 tTime := now;
 Timer1.Enabled := true;

// NewThread := TNewThread.Create(true);
// NewThread.FreeOnTerminate := True; // ���������� ����� ����� ���������� ������
// NewThread.Resume;

 for thread := 1 to maxThreads do
  begin
      NewThread := TNewThread.Create(true);
      NewThread.FreeOnTerminate := True; // ���������� ����� ����� ���������� ������
      NewThread.Resume;
  //    sleep (1000);// ������ ������
   //   NewThread.OnTerminate := TNewThread_ThreadTerminate;
  end;


 thread := maxThreads;
 Label1.caption := inttostr (thread);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin

  work := false;
  timer1.Enabled := false;
  Form1.button3.enabled := true; Form1.button4.enabled := true; Form1.button6.enabled := true;


end;



procedure TForm1.Button3Click(Sender: TObject);
var
  X, J : Integer;
  F : TextFile;
  S : String;
begin
  AssignFile(F, 'out.csv');
  Rewrite(F);
  for X := 0 to ListView1.Items.Count - 1 do
  begin
    S := ListView1.Items.Item[X].Caption + '|';
    for J := 0 to ListView1.Items.Item[X].SubItems.Count - 1 do
      S := S + ListView1.Items.Item[X].SubItems.Strings[J] + '|';
    SetLength(S, Length(S) - 1);
    WriteLn(F, S);
  end;
  CloseFile(F);
  listView1.SetFocus;


end;


procedure TForm1.Button4Click(Sender: TObject);
var
  I, j  : Integer;
  F  : TextFile;
  S  : String;
  sl : TStringList;
  ListItem : TListItem;
begin
  if FileExists('out.csv') then
  begin
    j := 0;
    sl := TStringList.Create;
    sl.Delimiter:= '|';
    sl.StrictDelimiter := True;
    AssignFile(F, 'out.csv');
    Reset(F);
    while not Eof(F) do
    begin
      ReadLn(F, S);
      sl.DelimitedText := S;
      ListItem := ListView1.Items.Add;
      ListItem.Caption := sl.Strings[0];
      for I := 1 to sl.Count - 1 do
        ListItem.SubItems.Add(sl.Strings[I]);
      label2.Caption := inttostr (j);
      inc(j);
      application.ProcessMessages;
    end;
    sl.Free;
    CloseFile(F);
  end;

 links.LoadFromFile('links.txt');

 listView1.SetFocus;

end;

procedure TForm1.Button5Click(Sender: TObject);
var
 http : TIdHTTP;
 s : WideString;
begin

  showmessage (CheckUrl('https://ru.wikipedia.org/w/index.php?title=%D0%A1%D0%BB%D1%83%D0%B6%D0%B5%D0%B1%D0%BD%D0%B0%D1%8F:%D0%A1%D0%B2%D0%B5%D0%B6%D0%B8%D0%B5_%D0%BF%D1%80%D0%B0%D0%B2%D0%BA%D0%B8&amp;feed=atom'));

//  memo1.Lines.add (TIdURI.URLEncode('https://ru.wikipedia.org/wiki/%D0%A1%D0%BB%D1%83%D0%B6%D0%B5%D0%B1%D0%BD%D0%B0%D1%8F:%D0%9F%D0%BE%D0%B8%D1%81%D0%BA'));


 exit;


   MakeReport;


end;

procedure TForm1.Button6Click(Sender: TObject);
begin
   Listview1.Clear;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Form5.ShowModal;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
 listview1.Items[strtoint (Edit2.text)].Delete;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  links.SaveToFile('links.txt');
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   exitProcess(0);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  MainThread: THandle;
begin

//  if yearof (now) = 2021 then
//   begin
//    showmessage ('������ ��� ��������.. � ����������.');
//    Application.Terminate;
//   end;

  sort := 'asc';

  CS := TCriticalSection.Create;
  CS2 := TCriticalSection.Create;
  CS4 := TCriticalSection.Create;
//  MainThread := GetCurrentProcess;
//  SetPriorityClass(MainThread, REALTIME_PRIORITY_CLASS);
//  SetThreadPriority(MainThread, THREAD_PRIORITY_TIME_CRITICAL);

  links := TStringList.Create;
  links.Sorted := true;

  label1.Caption := '';
  label2.Caption := '';
  label3.Caption := '';
  label4.Caption := '';

  listbox1.Items.LoadFromFile('list.txt', TEncoding.UTF8);

end;

procedure TForm1.ListView1AdvancedCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
  var DefaultDraw: Boolean);
var
  text : string;
begin

//   exit;

// DefaultDraw := true;
// Stage := cdPostPaint;

  with ListView1 do
   begin
    Canvas.Font.Color := GetColor (item.Index);

   if Item.Selected then
      begin
          Canvas.Brush.Color := clBlue;
          Canvas.Font.Color := clWhite;
      end;


    Canvas.FillRect(Item.DisplayRect(drLabel));

    text := copy (Item.Caption, 1,(listview1.Columns[0].width div 6)-3);
    if text <> Item.Caption then text := text + '...';

    Canvas.TextOut(Item.DisplayRect(drLabel).Left-1,
      Item.DisplayRect(drLabel).Top, text);

   // DefaultDraw := false;
  end;


end;




procedure TForm1.ListView1AdvancedCustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
var mRect: TRect;
    i : Integer;
begin

  // exit;

   DefaultDraw := true;
  mRect := Item.DisplayRect(drLabel);
  for i := SubItem-1 downto 0 do mRect.Left := mRect.Left + Sender.Column[i].Width;
  mRect.Right := mRect.Left + Sender.Column[SubItem].Width;
  with ListView1.Canvas do begin
    Font.Color := GetColor (item.Index);

    if Item.Selected then
      begin
          Brush.Color := clBlue;
          Font.Color := clWhite;
      end;

    FillRect(mRect);
    if SubItem <= Item.SubItems.Count then TextRect(mRect,mRect.Left, mRect.Top, Item.SubItems[SubItem-1]);

  end;



end;

procedure TForm1.ListView1Click(Sender: TObject);
begin
 edit2.Text := inttostr (listview1.ItemIndex);
end;

procedure TForm1.ListView1ColumnClick(Sender: TObject; Column: TListColumn);
begin
     if sort = 'asc' then sort := 'desc' else sort := 'asc';
     ListView1.CustomSort(@CustomSortProc, Column.Index);
end;

procedure TForm1.ListView1DblClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(selectedUrl), nil, nil, SW_NORMAL );
end;

procedure TForm1.ListView1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var P: TPoint;
begin
  if listview1.Items[listview1.ItemIndex] = nil then exit;

  SelectedUrl := listview1.Items[listview1.ItemIndex].Caption;

  P:=GetClientOrigin;
  if Button = mbRight then
    PopupMenu1.Popup(X+P.X+ListView1.Left, Y+P.Y+ListView1.Top);
end;


procedure TForm1.N10Click(Sender: TObject);
begin
 listview1.Items[listview1.ItemIndex].Delete;
end;

procedure TForm1.N11Click(Sender: TObject);
begin
 MakeReport;
end;

procedure TForm1.N12Click(Sender: TObject);
begin
  MakeSitemap;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
   Showmessage ('Xyenu 1.0 alpha' + #10#13 + #10#13 + 'by: Vanik' + #10#13 + #10#13 +
          '��������� ����� ��������� ��� ������� � ������������� �������������.' + #10#13 + #10#13 +
          '�������, �����!');
end;

procedure TForm1.N6Click(Sender: TObject);
begin
  Form3.Showmodal;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
   showmessage ('����� ��� ����� ������������...');
//  ShellExecute(Handle, 'open', 'https://ya.ru/', nil, nil, SW_NORMAL );
end;

procedure TForm1.N8Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(selectedUrl), nil, nil, SW_NORMAL );
end;

procedure TForm1.N9Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(listview1.Items[listview1.ItemIndex].Subitems[6]), nil, nil, SW_NORMAL );
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  perc : extended;
  tElapsed, tLeft : TDateTime;
begin

 try
  listview1.Repaint;

  perc := RoundTo (((curUrl+1) / ListView1.Items.Count) * 100, -2);
  label2.caption := inttostr (curUrl+1) + ' / ' + inttostr (ListView1.Items.Count) + ' (' +
      floattostr (perc) + '%)';

  tElapsed := Now - tTime;
  label3.Caption := FormatDateTime( 'hh:nn:ss.zzz', tElapsed );

  tLeft := (tElapsed * (100 / perc)) - tElapsed ;
  if tLeft = strtotime ('00:00:00') then label4.Caption := '��������� ������...'
    else label4.Caption := FormatDateTime( 'hh:nn:ss', tLeft);

  Label1.caption := inttostr (thread);

  if (work = False) and (thread = 0) and (button3.Enabled = false) then
   begin
     Button3.Enabled := true;
     Button4.Enabled := true;
     Button6.Enabled := true;
   end;

 except showmessage ('������� 3'); end;

end;

procedure TForm1.URL1Click(Sender: TObject);
begin
  Clipboard.AsText := SelectedUrl;
  MessageBeep( MB_ICONASTERISK );
end;

procedure TForm1.URL2Click(Sender: TObject);
begin

  Form4.Edit1.Text := SelectedUrl;
  Form4.Edit2.Text := listview1.Items[listview1.ItemIndex].Subitems[6];

  Form4.Showmodal;
end;

procedure TNewThread.AddSubitems;
begin


end;

procedure TNewThread.AddNewLink;
begin



end;

procedure TNewThread.Execute;
var
 http : TIdHTTP;
 l, l2, level, i, cur, tout, res : integer;
 domain, link, link1, link2, link3, fname, str, str2, url, duration, err, tip : string;
 strl : TStringList;
 tItem, tItem2: TListItem;
 memo:TMemoryStream;
begin






 while work do
  begin
    CS.Enter;  //************************************

//    if curUrl > 10 then break;

    try
      domain := form1.listbox1.items[curUrl];
      url := 'https://' + domain;
      form1.ListBox1.ItemIndex := curUrl;

      inc(curUrl);

//      if curUrl mod 100 = 0 then
//       begin
//         form1.listbox1.items.SaveToFile('list_back.txt');
//         form1.Memo1.Lines.SaveToFile('inns.txt');
//       end;

      tout := 0;

    except showmessage ('��� ������: ������� 4 '+ form1.listview1.items[i].Caption + ' ' + inttostr (i)); continue; end;

    CS.Leave;  //************************************


    if url <> '' then
      begin

    //    showmessage (inttostr (thread) + ' �����, ���: ' + url);
        err := '';
        try
          err := '';

            tTime2 := now;

            IdHandler := TIdSSLIOHandlerSocketOpenSSL.Create (nil);
            IdHandler.SSLOptions.Method := sslvSSLv23;
            http := TIdHttp.Create;
            http.IOHandler := IdHandler;
            http.HandleRedirects := true;
            http.ConnectTimeout:=7000;
            http.ReadTimeout:=7000;
//            str := form1.IdHTTP1.Get(TIdURI.URLEncode(url));


            if Form1.checkUrl(url) = 'enc' then str := http.Get(TIdURI.URLEncode(url))
                else str := http.Get(url);
//            tip := http.Response.ContentType;


//            showmessage ('|' + url + '|');

            http.Free;


                            // ��������� ��������
//            if Form5.Checkbox1.checked = true then
//             begin
//               strl := TStringList.Create;
//               fname := url;
//               fname := StringReplace (fname, '/', '_', [rfReplaceAll]); fname := StringReplace (fname, '\', '_', [rfReplaceAll]);
//               fname := StringReplace (fname, ':', '_', [rfReplaceAll]); fname := StringReplace (fname, '*', '_', [rfReplaceAll]);
//               fname := StringReplace (fname, '"', '_', [rfReplaceAll]); fname := StringReplace (fname, '<', '_', [rfReplaceAll]);
//               fname := StringReplace (fname, '>', '_', [rfReplaceAll]); fname := StringReplace (fname, '|', '_', [rfReplaceAll]);
//               fname := StringReplace (fname, '?', '_', [rfReplaceAll]);
//               strl.Text := str;
//               if not fileexists ('C:/SavedSite/' + fname + '.txt') then strl.SaveToFile('C:/SavedSite/' + fname + '.txt');
//               strl.free;
//             end;

       //     str := http.Get(TIdURI.URLEncode(url));

          duration := FormatDateTime( 'nn:ss.zzz', Now - tTime2 );

        except
          on E: Exception do
           begin
            err := E.Message;
           end;
        end;




          str2 := str;
        //   ����� ������
        while (pos('���', str2) <> 0) do
          begin
            link := copy (str2, pos('���', str2), 50);
            link := StringReplace (link, #9, '', [rfReplaceAll]);
            link := StringReplace (link, #10, '', [rfReplaceAll]);
            link := StringReplace (link, #13, '', [rfReplaceAll]);

            CS2.Enter;  //************************************

              form1.Memo1.Lines.Add(domain + '||' + link);

            CS2.Leave;  //************************************

            str2 := copy (str2, pos('���', str2)+3, length (str2));

          end;   //   ����� ����� ������

          // *--------------------------------------------

        link1 := ''; link2 := ''; link3 := '';

        while (pos('href="', str) <> 0)  and (err = '') do
          begin
            link := copy (str, pos('href="', str)+6, 1024);
            link := copy (link, 1, pos('"', link)-1);

//            form1.memo1.lines.add(link);


           if ((pos('/contact', link) <> 0) or (pos('/kontakt', link) <> 0) or (pos('/polit', link) <> 0) or (pos('/polic', link) <> 0)) and (tout < 3) then
              begin
                 CS4.Enter;  // ====++++++++++++++----------+++++++++

                  if (link <> link1) and (link <> link2) and (link <> link3) then form1.ListBox1.Items.Add(domain + link);

                  if link1 = '' then link1 := link
                  else if link2 = '' then link2 := link
                  else if link3 = '' then link3 := link;


                  inc(tout);


                 CS4.Leave;     // ====++++++++++++++----------+++++++++
              end;

            str := copy (str, pos('href="', str)+3, length (str));

          end;   //   ����� ����� ������

      //  if Form1.ListView1.Items.Count > 3000 then work := false;



      end;  //   end of  if url <> ''

  end;   //   end of while work


// *************----------------------************************** �������
// *************----------------------************************** �������
// *************----------------------************************** �������




end;

procedure Tform1.ReportRequest;
begin
    if once = true then
    begin
      once := false;
      ans:=MessageBox(handle, PChar('������� �����?'), PChar('Xyenu - ���� ������ ��������'), MB_YESNO+MB_ICONQUESTION);
      case ans of
       idyes: Form1.MakeReport;
      end;
    end;
end;


end.
