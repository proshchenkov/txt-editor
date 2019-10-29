unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ComCtrls, PrintersDlgs, Printers, Unit2;

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
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
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
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure Memo1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure Memo1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure ReplaceDialog1Find(Sender: TObject);
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
    StatusBar1.Panels[1].Text := OpenDialog1.FileName;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if messagedlg('Close?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    CloseAction := caFree
  else
    CloseAction := caNone;
end;

procedure TForm1.FindDialog1Find(Sender: TObject);
begin
  if pos(FindDialog1.FindText, Memo1.Text) <> 0 then
  begin
    Memo1.HideSelection := False;
    Memo1.SelStart := pos(FindDialog1.FindText, Memo1.Text) - 1;
    Memo1.SelLength := Length(FindDialog1.FindText);
  end
  else
    MessageDlg('Строка ' + FindDialog1.FindText + ' не найдена!',
      mtConfirmation, [mbYes], 0);
end;

procedure TForm1.Memo1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  StatusBar1.Panels[0].Text :=
    ' ' + Memo1.CaretPos.y.ToString + ': ' + Memo1.CaretPos.x.ToString;
end;

procedure TForm1.Memo1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  StatusBar1.Panels[0].Text :=
    ' ' + Memo1.CaretPos.y.ToString + ': ' + Memo1.CaretPos.x.ToString;
end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin
  Memo1.CutToClipboard;
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
  FontDialog1.Execute;
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

procedure TForm1.MenuItem22Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    Memo1.Lines.SaveToFile(SaveDialog1.FileName);
    StatusBar1.Panels[1].Text := SaveDialog1.FileName;
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
    Printer.Canvas.Font.Name := Memo1.Font.Name;
    Printer.Canvas.Font.Size := Memo1.Font.Size;
    Printer.Canvas.Font.Color := Memo1.Font.Color;
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

procedure TForm1.ReplaceDialog1Find(Sender: TObject);
var
  ss, SPos: integer;
  last: boolean;
  st: string;
begin
  with ReplaceDialog1 do
  begin
    if (frFindNext in Options) then
      SPos := Memo1.SelStart + Memo1.SelLength + 1;
    last := not (frReplaceAll in Options);
    repeat
      if frMatchCase in Options then
        ss := Pos(FindText, Copy(Memo1.Lines.Text, SPos + 1,
          Length(Memo1.Lines.Text))) + SPos - 1
      else
        ss := Pos(AnsiLowerCase(FindText), AnsiLowerCase(
          Copy(Memo1.Lines.Text, SPos + 1, Length(Memo1.Lines.Text)))) + SPos - 1;
      if ss >= SPos then
      begin
        Memo1.SelStart := ss;
        Memo1.SelLength := Length(FindText);
        if (frReplaceAll in Options) then
        begin
          Memo1.SelText := ReplaceDialog1.ReplaceText;
          SPos := Memo1.SelStart + Memo1.SelLength + 1;
        end;
      end
      else
      begin
        if (frReplaceAll in Options) or (frReplace in Options) then
          st := 'Замена "' + FindText + '" на "' + ReplaceText +
            '" закончена'
        else
          st := 'Текст "' + FindText + '" не найден';
        if MessageDlg(st + '. Продолжать диалог?',
          mtConfirmation, mbYesNoCancel, 0) <> mrYes then
          CloseDialog;
        last := True;
      end;
    until last;
  end;
end;

procedure TForm1.ReplaceDialog1Replace(Sender: TObject);
begin
  if Memo1.SelText <> '' then
    Memo1.SelText := ReplaceDialog1.ReplaceText;
  if frReplaceAll in ReplaceDialog1.Options then
    ReplaceDialog1Find(Self);

end;

end.
