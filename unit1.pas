unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ComCtrls, PrintersDlgs, Printers, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    FindDialog1: TFindDialog;
    FontDialog1: TFontDialog;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    PageSetupDialog1: TPageSetupDialog;
    PrintDialog1: TPrintDialog;
    ReplaceDialog1: TReplaceDialog;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    procedure FindDialog1Find(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure ReplaceDialog1Replace(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
    StatusBar1.Panels[0].Text := OpenDialog1.FileName;
  end;
end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin
  Memo1.CutToClipboard;
end;

procedure TForm1.FindDialog1Find(Sender: TObject);
var
  I, J, PosReturn, SkipChars: integer;
begin
  for I := 0 to Memo1.Lines.Count do
  begin
    PosReturn := Pos(FindDialog1.FindText, Memo1.Lines[I]);
    if PosReturn <> 0 then { found! }
    begin
      SkipChars := 0;
      for J := 0 to I - 1 do
        SkipChars := SkipChars + Length(Memo1.Lines[J]);
      SkipChars := SkipChars + (I * 2);
      SkipChars := SkipChars + PosReturn - 1;
      Memo1.SetFocus;
      Memo1.SelStart := SkipChars;
      Memo1.SelLength := Length(FindDialog1.FindText);
      Break;
    end;
  end;
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
  Memo1.CopyToClipboard;
end;

procedure TForm1.MenuItem12Click(Sender: TObject);
begin
  Memo1.PasteFromClipboard;
end;

procedure TForm1.MenuItem13Click(Sender: TObject);
begin
  Memo1.ClearSelection;
end;

procedure TForm1.MenuItem14Click(Sender: TObject);
begin
  FindDialog1.Execute;
end;

procedure TForm1.MenuItem15Click(Sender: TObject);
begin
  ReplaceDialog1.Execute;
end;

procedure TForm1.MenuItem16Click(Sender: TObject);
begin
  Memo1.SelectAll;
end;

procedure TForm1.MenuItem18Click(Sender: TObject);
begin
  if FontDialog1.Execute then
    Memo1.Font := FontDialog1.Font;
end;

procedure TForm1.MenuItem20Click(Sender: TObject);
begin
  if StatusBar1.Visible = False then
  begin
    StatusBar1.Visible := True;
    MenuItem20.Checked := True;
  end
  else
  begin
    StatusBar1.Visible := False;
    MenuItem20.Checked := False;
  end;
end;

procedure TForm1.MenuItem23Click(Sender: TObject);
begin
  Memo1.Text := Memo1.Text + FormatDateTime('hh.nn', Time) + ' ' + DateToStr(Date);
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    Memo1.Lines.SaveToFile(SaveDialog1.FileName);
    StatusBar1.Panels[0].Text := SaveDialog1.FileName;
  end;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  PageSetupDialog1.Execute;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
var
  lh, i: integer;
begin
  if PrintDialog1.Execute then
  begin
    Printer.BeginDoc;
    Printer.Canvas.Font.Name := 'Courier New';
    Printer.Canvas.Font.Size := 10;
    Printer.Canvas.Font.Color := clBlack;
    lh := round(1.2 * abs(printer.Canvas.TextHeight('I')));
    for i := 0 to Memo1.Lines.Count - 1 do
    begin
      if (i > 0) and (i mod 40 = 0) then
        Printer.NewPage;
      Printer.Canvas.TextOut(10, 3 * lh + lh * (i mod 40), Memo1.Lines[i]);
    end;
    Printer.EndDoc;
    ShowMessage('Печать завершена');
  end;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  Memo1.Text := '';
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  Memo1.Undo;
end;

procedure TForm1.ReplaceDialog1Replace(Sender: TObject);
var
  SelPos: integer;
begin
  with TReplaceDialog(Sender) do
  begin
    SelPos := Pos(FindText, Memo1.Lines.Text);
    if SelPos > 0 then
    begin
      Memo1.SelStart := SelPos - 1;
      Memo1.SelLength := Length(FindText);
      Memo1.SelText := ReplaceText;
    end
    else
      MessageDlg(Concat('Could not find "', FindText, '" in Memo1.'),
        mtError, [mbOK], 0);
  end;
end;

end.
