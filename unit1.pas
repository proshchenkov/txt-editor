unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ComCtrls, PrintersDlgs, Printers, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    FontDialog1: TFontDialog;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
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
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
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

end.
