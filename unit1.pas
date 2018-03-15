unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    Angle: Double;
    LastDrawTime: QWord;
    LastUpdateTime: QWord;
  public
    // deltaTime в секундах
    procedure GameUpdate(deltaTime: Double);
    procedure Draw(c: TCanvas);
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Timer1Timer(Sender: TObject);
var
  t: QWord;
begin
  t := GetTickCount64;
  GameUpdate(Double(t - LastUpdateTime) / 1000);
  LastUpdateTime := t;
  // if 10 < t - LastDrawTime then
  begin
    PaintBox1.Invalidate;
    LastDrawTime := t;
  end;
end;

procedure TForm1.GameUpdate(deltaTime: Double);
begin
  Angle := Angle + deltaTime;
  if Angle >= 2*Pi then
    Angle := Angle - 2*Pi;
end;

procedure TForm1.Draw(c: TCanvas);
var
  centerX, centerY, posX, posY: Double;
  radius: Double;
begin
  radius := c.Width / 4;
  centerX := c.Width / 2;
  centerY := c.Height / 2;
  posX := centerX + radius * Cos(Angle);
  posY := centerY + radius * Sin(Angle);
  c.Pen.Color := clBlack;
  c.Brush.Color := clBlue;
  c.Rectangle(Round(posX) - 30, Round(posY) - 30, Round(posX) + 30, Round(posY) + 30);
  c.Line(Round(centerX), Round(centerY), Round(posX), Round(posY));
end;

procedure TForm1.PaintBox1Click(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  LastDrawTime := GetTickCount64;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  Draw(PaintBox1.Canvas);
end;

end.

