unit UMiroir;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ExtDlgs, ComCtrls;

type
  TfrmMain = class(TForm)
    cb_VertFlip: TCheckBox;
    cb_HorzFlip: TCheckBox;
    cb_180Degre: TCheckBox;
    btn_LoadBitmap: TButton;
    OPD: TOpenPictureDialog;
    tb_Factor: TTrackBar;
    pb_Display: TPaintBox;
    Panel1: TPanel;
    cb_Center: TCheckBox;
    cb_UsePlgBlt: TCheckBox;
    lbl_PosSize: TLabel;
    lbl_Zoom: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cb_VertFlipClick(Sender: TObject);
    procedure btn_LoadBitmapClick(Sender: TObject);
    procedure tb_FactorChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pb_DisplayPaint(Sender: TObject);
    procedure cb_CenterClick(Sender: TObject);
    procedure cb_UsePlgBltClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}
Type
  {Déclaration d'un Type pour l'utilisation de PlgBlt}
  T2DFace = Array[0..2] Of TPoint;

Var
    BMP : TBitmap;
    VertFlip : Boolean = False;
    HorzFlip : Boolean = False;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  BMP := TBitmap.Create;
  BMP.LoadFromFile(ExtractFilePath(Application.ExeName)+'Flag.bmp');
  {Evite les scintillements}
  DoubleBuffered := True;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BMP.Free;
end;

procedure TfrmMain.cb_VertFlipClick(Sender: TObject);
begin
  {Inverse les valeurs Boolean en fonction de l'appelant}
  Case TComponent(Sender).Tag Of
    0: VertFlip := Not VertFlip;
    1: HorzFlip := Not HorzFlip;
    2: Begin
         VertFlip := Not VertFlip;
         HorzFlip := Not HorzFlip;
       End;
  End;
  Invalidate;
end;

{Permet de charger vos images}
procedure TfrmMain.btn_LoadBitmapClick(Sender: TObject);
begin
  If Opd.Execute Then BMP.LoadFromFile(Opd.FileName);
  Invalidate;
end;

procedure TfrmMain.tb_FactorChange(Sender: TObject);
begin
  lbl_Zoom.Caption := Format('Zoom: %d%%', [tb_Factor.Position]);
  Invalidate;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  Invalidate;
end;

procedure TfrmMain.pb_DisplayPaint(Sender: TObject);
{Petite astuce pour le calcule des positions}
Const OrgFlip : Array[Boolean] Of Integer = (0, 1);
      SizeFlip : Array[Boolean] Of Integer = (1, -1);
Var OrgX, OrgY,
    SizeX, SizeY : Integer;
    Factor : Extended;
    PntArray : T2DFace;
begin
  {Calcule le Facteur Zoom}
  Factor := tb_Factor.Position * 1e-2;
  With BMP do Begin
  {Calcule les positions en fonction des effets miroirs et du Zoom}
    SizeX := Round(Width * SizeFlip[HorzFlip] * Factor);
    OrgX := Round(Width * OrgFlip[HorzFlip] * Factor);
    SizeY := Round(Height * SizeFlip[VertFlip] * Factor);
    OrgY := Round(Height * OrgFlip[VertFlip] * Factor);
  End;

  If cb_Center.Checked Then Begin
  {Si l'image doit être centrée}
    OrgX := OrgX + ((pb_Display.ClientWidth - Abs(SizeX)) Div 2);
    OrgY := OrgY + ((pb_Display.ClientHeight - Abs(SizeY)) Div 2);
  End;

  {Offre une meilleur qualité lors du Zoom}
  SetStretchBltMode(pb_Display.Canvas.Handle, HALFTONE);

  If cb_UsePlgBlt.Checked Then Begin
  {En fonction du choix on dessine le résultat avec PlgBlt}
    PntArray[0] := Point(OrgX, OrgY);
    PntArray[1] := Point(OrgX+SizeX, OrgY);
    PntArray[2] := Point(OrgX, OrgY+SizeY);
    PlgBlt(pb_Display.Canvas.Handle, PntArray, BMP.Canvas.Handle, 0, 0, BMP.Width, BMP.Height, 0, 0, 0);
  End
  Else
  {Ou avec StretchBlt}
    StretchBlt(pb_Display.Canvas.Handle, OrgX, OrgY, SizeX, SizeY, BMP.Canvas.Handle, 0, 0, BMP.Width, BMP.Height, srcCOPY);

  lbl_PosSize.Caption := Format('Left: %d , Top: %d'#13'Width: %d , Height: %d', [OrgX, OrgY, SizeX, SizeY]);
end;

procedure TfrmMain.cb_CenterClick(Sender: TObject);
begin
  Invalidate;
end;

procedure TfrmMain.cb_UsePlgBltClick(Sender: TObject);
begin
  Invalidate;
end;

end.
