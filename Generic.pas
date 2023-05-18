unit Generic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StrUtils, ExtCtrls, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    imgMain: TImage;
    areaPal: TImage;
    areaBrowser: TImage;
    chkInvalid: TCheckBox;
    btnCopy: TButton;
    btnPaste: TButton;
    btnGradient: TButton;
    areaRGB: TImage;
    btnLoad: TButton;
    btnSave: TButton;
    btnSaveAs: TButton;
    menuLength: TComboBox;
    editAddress: TLabeledEdit;
    lblLength: TLabel;
    memoASM: TMemo;
    dlgOpen: TOpenDialog;
    editLength: TEdit;
    btnReload: TButton;
    dlgColour: TColorDialog;
    btnColour: TButton;
    dlgSave: TSaveDialog;
    barBrowser: TScrollBar;
    lblBrowser: TLabel;
    btnSwap: TButton;
    btnReverse: TButton;
    btnASM: TButton;
    lblBrowserMouse: TLabel;
    areaBrowserOut: TImage;
    editBits: TRichEdit;
    Bevel2: TBevel;
    lblBrightness: TLabel;
    menuBrightness: TComboBox;
    chkLittle: TCheckBox;
    btnExBIN: TButton;
    btnExTPL: TButton;
    dlgSaveTPL: TSaveDialog;
    lblAnimation: TLabel;
    menuAnimation: TComboBox;
    editAnimation: TLabeledEdit;
    areaAnimation: TImage;
    btnPlay: TButton;
    timerAnimation: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure chkInvalidClick(Sender: TObject);
    procedure areaBrowserMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure areaBrowserMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure areaBrowserOutMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure areaPalMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure areaPalMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure menuLengthChange(Sender: TObject);
    procedure editLengthKeyPress(Sender: TObject; var Key: Char);
    procedure editLengthChange(Sender: TObject);
    procedure editAddressKeyPress(Sender: TObject; var Key: Char);
    procedure editAddressChange(Sender: TObject);
    procedure btnReloadClick(Sender: TObject);
    procedure areaRGBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnColourClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveAsClick(Sender: TObject);
    procedure barBrowserChange(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnPasteClick(Sender: TObject);
    procedure btnGradientClick(Sender: TObject);
    procedure btnSwapClick(Sender: TObject);
    procedure btnReverseClick(Sender: TObject);
    procedure btnASMClick(Sender: TObject);
    procedure editBitsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure menuBrightnessChange(Sender: TObject);
    procedure chkLittleClick(Sender: TObject);
    procedure btnExBINClick(Sender: TObject);
    procedure btnExTPLClick(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure timerAnimationTimer(Sender: TObject);
    procedure editAnimationKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure LoadFile(openthis: string);
    procedure SaveFile(savethis: string);
    function GetWord(a: integer): word;
    function GetBit(i, b: integer): byte;
    function Explode(s, d: string; n: integer): string;
    procedure DrawHLine(r, g, b, a: byte; x, y, w: integer);
    procedure DrawVLine(r, g, b, a: byte; x, y, h: integer);
    procedure DrawRect(r, g, b, a: byte; x, y, w, h: integer);
    procedure DrawBox(r, g, b, a: byte; x, y, w, h: integer);
    procedure DrawBox2(r, g, b, a: byte; x, y, w, h, t: integer);
    procedure FillScreen(r, g, b, a: byte);

    procedure ClearBrowser;
    procedure DrawRectMD(c: word; x, y, w, h: integer);
    procedure DrawRectBad(x, y, w, h: integer);
    procedure DrawBrowser;
    procedure ClearPal;
    procedure DrawPal;
    procedure DrawRGB;
    procedure LoadPal;
    function GetColour(c: integer): word;
    procedure WriteColour(c: word; n: integer);
    procedure ByteSwapFile;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  myfile: file;
  filearray, copybuffer: array of byte;
  tplarray: array[0..$303] of byte;
  pixelarray: PByteArray;
  scanwidth, actualwidth, actualheight, visiblewidth, visibleheight, romwordcount,
  browserpos, palcount, palselect, palselect2, romaddress, aniframes, anicurrent: integer;
  romopen: string;

const
  lumin: array[0..63] of byte = (0,0,52,52,87,87,116,116,144,144,172,172,206,206,255,255, // Real
    0,0,29,29,52,52,70,70,87,87,101,101,116,116,130,130, // Shadow
    130,130,144,144,158,158,172,172,187,187,206,206,228,228,255,255, // Highlight
    0,0,32,32,64,64,96,96,128,128,160,160,192,192,224,224); // Genecyst

implementation

{$R *.dfm}

{ File stuff }

procedure TForm1.LoadFile(openthis: string); // Open file and copy to array.
begin
  if FileExists(openthis) = true then
    begin
    AssignFile(myfile,openthis); // Get file.
    FileMode := fmOpenRead; // Read only.
    Reset(myfile,1);
    SetLength(filearray,FileSize(myfile));
    BlockRead(myfile,filearray[0],FileSize(myfile)); // Copy file to memory.
    CloseFile(myfile); // Close file.
    end;
end;

procedure TForm1.SaveFile(savethis: string); // Save ROM array to file.
begin
  if chkLittle.Checked then ByteSwapFile;
  AssignFile(myfile,savethis);
  FileMode := fmOpenReadWrite;
  ReWrite(myfile,1);
  BlockWrite(myfile,filearray[0],Length(filearray));
  CloseFile(myfile);
  if chkLittle.Checked then ByteSwapFile;
end;

function TForm1.GetWord(a: integer): word; // Get word from file array.
begin
  result := (filearray[a] shl 8)+filearray[a+1];
end;

{ Byte operations }

function TForm1.GetBit(i, b: integer): byte; // Get bit from integer (output 0 or 1).
begin
  result := (i and (1 shl b)) shr b;
end;

{ String operations }

function TForm1.Explode(s, d: string; n: integer): string; // Get part of a string using delimiter.
var n2: integer;
begin 
  if (AnsiPos(d,s) = 0) and ((n = 0) or (n = -1)) then result := s // Output full string if delimiter not found.
  else
    begin
    if n > -1 then // Check for negative substring.
      begin
      s := s+d;
      n2 := n;
      end
    else
      begin
      d := AnsiReverseString(d);
      s := AnsiReverseString(s)+d; // Reverse string for negative.
      n2 := Abs(n)-1;
      end;
    while n2 > 0 do
      begin
      Delete(s,1,AnsiPos(d,s)+Length(d)-1); // Trim earlier substrings and delimiters.
      dec(n2);
      end;
    Delete(s,AnsiPos(d,s),Length(s)-AnsiPos(d,s)+1); // Trim later substrings and delimiters.
    if n < 0 then s := AnsiReverseString(s); // Un-reverse string if negative.
    result := s;
  end;
end;

{ Form management. }

procedure TForm1.FormCreate(Sender: TObject);
begin
  imgMain.Picture.Bitmap.PixelFormat := pf32bit; // Set main bitmap to 32-bit RGBA.
  actualwidth := Screen.Width; // Set dimensions to match the screen.
  actualheight := Screen.Height;
  visiblewidth := Form1.ClientWidth; // Set boundaries to match window.
  visibleheight := Form1.ClientHeight;
  imgMain.Picture.Bitmap.Width := actualwidth;
  imgMain.Picture.Bitmap.Height := actualheight;
  imgMain.Width := visiblewidth;
  imgMain.Height := visibleheight;
  pixelarray := imgMain.Picture.Bitmap.ScanLine[0]; // Get pointer for pixels.
  scanwidth := Longint(imgMain.Picture.Bitmap.ScanLine[1])-Longint(pixelarray); // Get scanline width (+ padding).

  FillScreen(240,240,240,255); // Match background to form background.
  ClearBrowser;
  romopen := '';
end;

{ Pixel operations. }

procedure TForm1.DrawHLine(r, g, b, a: byte; x, y, w: integer); // Draw horizontal line.
var p, i: integer;
begin
  if w < 0 then // Check if width is negative.
    begin
    x := x+w; // Flip.
    w := abs(w); // Make positive.
    end;
  if x+w > actualwidth then w := actualwidth-x; // Trim line if it overflows.
  if x < 0 then // Check if position is negative.
    begin
    w := w+x; // Trim line.
    x := 0; // Align to edge.
    end;
  if (y > actualheight) or (y < 0) then
    begin
    w := 0;
    y := 0;
    end;
  p := (y*scanwidth)+(x shl 2); // Find address for pixel.
  for i := 0 to (w-1) do
    begin
    pixelarray[p+(i shl 2)] := b; // Write pixel data.
    pixelarray[p+1+(i shl 2)] := g;
    pixelarray[p+2+(i shl 2)] := r;
    pixelarray[p+3+(i shl 2)] := 255;
    end;
end;

procedure TForm1.DrawVLine(r, g, b, a: byte; x, y, h: integer); // Draw vertical line.
var p, i: integer;
begin
  if h < 0 then // Check if height is negative.
    begin
    y := y+h; // Flip.
    h := abs(h); // Make positive.
    end;
  if y+h > actualheight then h := actualheight-y; // Trim line if it overflows.
  if y < 0 then // Check if position is negative.
    begin
    h := h+y; // Trim line.
    y := 0; // Align to edge.
    end;
  if (x > actualwidth) or (x < 0) then
    begin
    h := 0;
    x := 0;
    end;
  p := (y*scanwidth)+(x shl 2); // Find address for pixel.
  for i := 0 to (h-1) do
    begin
    pixelarray[p] := b; // Write pixel data.
    pixelarray[p+1] := g;
    pixelarray[p+2] := r;
    pixelarray[p+3] := 255;
    p := p+scanwidth; // Jump to next scanline, same y position.
    end;
end;

procedure TForm1.DrawRect(r, g, b, a: byte; x, y, w, h: integer); // Draw solid rectangle.
var p, i, j: integer;
begin
  if x < 0 then // Check if position is negative.
    begin
    w := w+x; // Trim rectangle.
    x := 0; // Align to edge.
    end;
  if y < 0 then
    begin
    h := h+y;
    y := 0;
    end;
  if x+w > actualwidth then w := actualwidth-x; // Trim rectangle if it overflows.
  if y+h > actualheight then h := actualheight-y;
  p := (y*scanwidth)+(x shl 2); // Find address for 1st pixel.
  for i := 0 to (h-1) do
    begin
    for j := 0 to (w-1) do
      begin
      pixelarray[p+(j shl 2)] := b; // Write pixel data.
      pixelarray[p+1+(j shl 2)] := g;
      pixelarray[p+2+(j shl 2)] := r;
      pixelarray[p+3+(j shl 2)] := 255;
      end;
    p := p+scanwidth; // Jump to next scanline, same y position.
    end;
end;

procedure TForm1.DrawBox(r, g, b, a: byte; x, y, w, h: integer); // Draw empty box.
begin
  DrawHLine(r, g, b, a, x, y, w); // Top.
  DrawVLine(r, g, b, a, x, y+1, h-2); // Left.
  DrawVLine(r, g, b, a, x+w-1, y+1, h-2); // Right.
  DrawHline(r, g, b, a, x, y+h-1, w); // Bottom.
end;

procedure TForm1.DrawBox2(r, g, b, a: byte; x, y, w, h, t: integer); // Draw empty box with thicker lines.
var i: integer;
begin
  for i:= 0 to t-1 do
    DrawBox(r,g,b,a,x+i,y+i,w-(i shl 1),h-(i shl 1)); // Draw concentric boxes.
end;

procedure TForm1.FillScreen(r, g, b, a: byte); // Fill screen with one colour.
var i: integer;
begin
  DrawHLine(r, g, b, a, 0, 0, visiblewidth); // Fill first visible line.
  for i := 1 to (visibleheight-1) do // Copy visible lines.
    Move(pixelarray[0],pixelarray[i*scanwidth],(visiblewidth shl 2));
end;

procedure TForm1.ClearBrowser; // Clear ROM browser.
begin
  DrawRect(240,240,240,255,areaBrowser.Left,areaBrowser.Top,areaBrowser.Width,areaBrowser.Height);
end;

procedure TForm1.btnLoadClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    begin
    LoadFile(dlgOpen.FileName); // Load ROM file.
    romopen := dlgOpen.FileName; // Copy path & name of ROM.
    Form1.Caption := 'HivePal 2.2 - '+romopen;
    romwordcount := Length(filearray) shr 1; // Get number of words in ROM.
    browserpos := 0;
    romaddress := 0;
    palcount := 0;
    palselect := 0;
    palselect2 := 0;
    memoASM.Clear;
    editBits.Lines[0] := '0000000000000000';
    editBits.Enabled := false;
    ClearPal;
    if chkLittle.Checked then ByteSwapFile;
    DrawBrowser;
    if romwordcount > 1024 then
      begin
      barBrowser.Enabled := true;
      barBrowser.Max := (romwordcount shr 5)-32; // Set scrollbar size.
      barBrowser.Position := 0; // Move to top.
      end
    else barBrowser.Enabled := false; // Disable scrollbar for small file.
    end;
end;

procedure TForm1.DrawRectMD(c: word; x, y, w, h: integer); // Draw rectangle with $0BGR as colour.
var b: integer;
begin
  b := menuBrightness.ItemIndex * 16;
  DrawRect(lumin[(c and $f)+b],lumin[((c shr 4) and $f)+b],lumin[((c shr 8) and $f)+b],255,x,y,w,h);
end;

procedure TForm1.DrawRectBad(x, y, w, h: integer); // Draw striped rectangle to suggest a "bad" colour.
var z: integer;
begin
  for z := 0 to h-1 do
    DrawHLine(64+((z and 1) shl 6),64+((z and 1) shl 6),64+((z and 1) shl 6),255,x,y+z,w);
end;

procedure TForm1.DrawBrowser; // Draw ROM browser window.
var i: integer;
begin
  ClearBrowser;
  i := 0;
  while (i < 1024) and (browserpos+(i shl 1) < romwordcount shl 1) do
    begin
    // Check if it's a valid $0EEE palette.
    if (chkInvalid.Checked = false) and (GetWord(browserpos+(i shl 1)) and $f111 <> 0) then
    DrawRectBad(areaBrowser.Left+((i and $1f) shl 4),areaBrowser.Top+((i and $fe0) shr 1),16,16)
    else
    DrawRectMD(GetWord(browserpos+(i shl 1)),areaBrowser.Left+((i and $1f) shl 4),
      areaBrowser.Top+((i and $fe0) shr 1),16,16);
    inc(i);
    end;
  imgMain.Refresh;
  lblBrowser.Caption := 'Top Left: $'+InttoHex(browserpos,1);
end;

procedure TForm1.chkInvalidClick(Sender: TObject);
begin
  DrawBrowser;
end;

procedure TForm1.areaBrowserMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var addr: integer;
begin
  addr := (((Y shr 4) shl 5)+(X shr 4)+(browserpos shr 1)) shl 1; // Get ROM address based on where you click.
  if addr < Length(filearray) then
    begin
    romaddress := addr;
    editAddress.Text := '$'+InttoHex(addr,1);
    LoadPal;
    end;
end;

procedure TForm1.areaBrowserMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var addr: integer;
begin
  addr := (((Y shr 4) shl 5)+(X shr 4)+(browserpos shr 1)) shl 1; // Get ROM address based on where you hover.
  if addr < Length(filearray) then
    lblBrowserMouse.Caption := 'Under Mouse: $'+InttoHex(addr,1)
  else lblBrowserMouse.Caption := 'Under Mouse: x';
end;

procedure TForm1.areaBrowserOutMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  lblBrowserMouse.Caption := 'Under Mouse: x';
end;

procedure TForm1.ClearPal; // Clear palette menu.
begin
  DrawRect(240,240,240,255,areaPal.Left,areaPal.Top,areaPal.Width,areaPal.Height);
  DrawRect(240,240,240,255,areaRGB.Left,areaRGB.Top,areaRGB.Width,areaRGB.Height);
end;

procedure TForm1.DrawPal; // Draw palette menu.
var i: integer;
  asmtxt: array[0..3] of string;
  bits: string;
begin
  for i := 0 to palcount-1 do
    DrawRectMD(GetWord(romaddress+(i shl 1)),areaPal.Left+((i and $f)*25),areaPal.Top+(((i and $f0) shr 4)*40),25,40);
  // Draw box around selected colour.
  DrawBox(0,0,0,255,areaPal.Left+((palselect and $f)*25),areaPal.Top+(((palselect and $f0) shr 4)*40),25,40);
  DrawBox(255,255,255,255,areaPal.Left+((palselect and $f)*25)+1,areaPal.Top+(((palselect and $f0) shr 4)*40)+1,23,38);
  if palselect <> palselect2 then
    begin
    // Draw 2nd box for multi-selection. 
    DrawBox(255,0,0,255,areaPal.Left+((palselect2 and $f)*25),areaPal.Top+(((palselect2 and $f0) shr 4)*40),25,40);
    DrawBox(255,255,0,255,areaPal.Left+((palselect2 and $f)*25)+1,areaPal.Top+(((palselect2 and $f0) shr 4)*40)+1,23,38);
    end;
  DrawRGB;
  imgMain.Refresh;
  memoASM.Lines.Clear; // Clear ASM viewer.
  for i := 0 to ((palcount-1) shr 4)-1 do memoASM.Lines.Add(''); // Add line for each palette line.
  i := 0;
  while i < palcount do // Convert palette hex code to strings.
    begin
    asmtxt[i shr 4] := asmtxt[i shr 4]+'$'+InttoHex(GetWord(romaddress+(i shl 1)),4)+',';
    inc(i);
    end;           
  for i := 0 to ((palcount-1) shr 4) do
    memoASM.Lines[i] := 'dc.w '+Copy(asmtxt[i],1,Length(asmtxt[i])-1); // Show code and trim final comma.
  memoASM.SetFocus;
  memoASM.SelStart := (palselect*6)+(((palselect shr 4)+1)*5)+(palselect shr 4);
  memoASM.SelLength := 5;
  bits := '';
  for i := 0 to 15 do
    bits := InttoStr(GetBit(GetColour(palselect),i))+bits; // Convert colour to string of bits.
  editBits.Enabled := true;
  editBits.Clear; // Clear bit viewer.
  editBits.SelAttributes.Color := clBlack;
  editBits.SelText := Copy(bits,1,4);
  editBits.SelAttributes.Color := clBlue;
  editBits.SelText := Copy(bits,5,3);
  editBits.SelAttributes.Color := clBlack;
  editBits.SelText := Copy(bits,8,1);
  editBits.SelAttributes.Color := clGreen;
  editBits.SelText := Copy(bits,9,3);
  editBits.SelAttributes.Color := clBlack;
  editBits.SelText := Copy(bits,12,1);
  editBits.SelAttributes.Color := clRed;
  editBits.SelText := Copy(bits,13,3);
  editBits.SelAttributes.Color := clBlack;
  editBits.SelText := Copy(bits,16,1);
end;

procedure TForm1.areaPalMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var p: integer;
begin
  if (palcount > 0) and (Button = mbLeft) then
    begin
    p := (X div 25)+((Y div 40) shl 4); // Get colour num based on position of click.
    if p < palcount then palselect := p; // If in range, update menu.
    palselect2 := palselect; // Clear multi-selection.
    DrawPal;
    end;
end;

procedure TForm1.areaPalMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer); // Multi-select by dragging over more than one colour.
var p: integer;
begin
  p := (X div 25)+((Y div 40) shl 4); // Get colour num based on position of click.
  if p < palcount then palselect2 := p; // If in range, update menu.
  if p < palselect then // Swap if selection is backwards.
    begin
    palselect2 := palselect;
    palselect := p;
    end;
  if palcount <> 0 then DrawPal;
end;

procedure TForm1.DrawRGB; // Draw RGB brightness menu.
var i: integer;
  w: word;
begin
  for i := 0 to 7 do // Draw reds.
    DrawRect(lumin[i shl 1],0,0,255,areaRGB.Left+(i*30),areaRGB.Top,30,30);
  for i := 0 to 7 do // Draw greens.
    DrawRect(0,lumin[i shl 1],0,255,areaRGB.Left+(i*30),areaRGB.Top+30,30,30);  
  for i := 0 to 7 do // Draw blues.
    DrawRect(0,0,lumin[i shl 1],255,areaRGB.Left+(i*30),areaRGB.Top+60,30,30);
  w := GetColour(palselect);
  DrawBox2(255,255,0,255,areaRGB.Left+((w and $e)*15),areaRGB.Top,30,30,2);
  DrawBox2(255,128,0,255,areaRGB.Left+(((w and $e0) shr 4)*15),areaRGB.Top+30,30,30,2);
  DrawBox2(255,255,128,255,areaRGB.Left+(((w and $e00) shr 8)*15),areaRGB.Top+60,30,30,2);
end;

procedure TForm1.menuLengthChange(Sender: TObject);
begin
  if menuLength.ItemIndex = 5 then editLength.Visible := true
  else editLength.Visible := false;
end;

procedure TForm1.editLengthKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    '0'..'9', 'a'..'f', 'A'..'F', '$', #8: ; // Allow hex nums, $, backspace.
  else key := #0; // Otherwise do nothing.
  end;
end;

procedure TForm1.editLengthChange(Sender: TObject);
var i: integer;
begin
  if (TryStrtoInt(editLength.Text,i) = false) and (editLength.Text <> '') and (editLength.Text <> '$') then
    editLength.Text := '0';
end;

procedure TForm1.editAddressKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    '0'..'9', 'a'..'f', 'A'..'F', '$', #8: ; // Allow hex nums, $, backspace.
  else key := #0; // Otherwise do nothing.
  end;
end;

procedure TForm1.editAddressChange(Sender: TObject);  
var i: integer;
begin
  if (TryStrtoInt(editAddress.Text,i) = false) and (editAddress.Text <> '') and (editAddress.Text <> '$') then
    if TryStrtoInt('$'+editAddress.Text,i) = true then
      begin
      editAddress.Text := '$'+editAddress.Text; // Insert '$' for hex if that works.
      editAddress.SelStart := Length(editAddress.Text); // Move cursor.
      end
    else editAddress.Text := '0'; // Otherwise reset to 0.
end;

procedure TForm1.btnReloadClick(Sender: TObject);
begin
  if romopen <> '' then
    begin
    if (editAddress.Text = '$') or (editAddress.Text = '') then editAddress.Text := '0';
    romaddress := StrtoInt(editAddress.Text);
    LoadPal;
    end;
end;

procedure TForm1.LoadPal; // Load palette for editing from ROM.
begin
  if menuLength.ItemIndex = 0 then // palcount is Auto.
    begin
    palcount := 0;
    // Increase palcount until it hits an invalid palette or $40.
    while (palcount < $40) and (palcount < romwordcount+1) and (GetWord(romaddress+(palcount shl 1)) and $f111 = 0) do
      inc(palcount);
    if palcount = 0 then palcount := 1; // Force minimum of 1 even if invalid.
    end
  else if menuLength.ItemIndex = 5 then // palcount is user-defined.
    begin
    if (editLength.Text = '$') or (editLength.Text = '') then editLength.Text := '1'; // Make it 1 if blank.
    palcount := StrtoInt(editLength.Text);
    if palcount > $40 then palcount := $40;
    if palcount = 0 then palcount := 1;
    end
  else palcount := menuLength.ItemIndex shl 4; // palcount is $10/$20/$30/$40.
  if palcount > romwordcount-(romaddress shr 1) then palcount := romwordcount-(romaddress shr 1); // Don't overflow file.
  ClearPal;
  palselect := 0;
  palselect2 := 0;
  DrawPal;
end;

procedure TForm1.areaRGBMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var c, extrabits: word;
  y2: integer;
begin
  if palcount > 0 then
    begin
    c := GetColour(palselect);
    extrabits := c and $f111; // Store unused bits.
    y2 := Y div 30; // Get colour row (R/B/G).
    if y2 = 0 then c := (c and $ee0)+((X div 30) shl 1) // Red.
    else if y2 = 1 then c := (c and $e0e)+((X div 30) shl 5) // Green.
    else c := (c and $0ee)+((X div 30) shl 9); // Blue.
    WriteColour(c+extrabits,palselect); // Write to file array.
    DrawPal;
    DrawBrowser;
    end;
end;

procedure TForm1.btnColourClick(Sender: TObject);
var c, extrabits: word;
  r, g, b: byte;
begin
  if dlgColour.Execute and (palcount > 0) then
    begin
    extrabits := GetColour(palselect) and $f111; // Store unused bits.
    r := GetRValue(dlgColour.Color) shr 5; // Get highest 3 bits of 8-bit value.
    g := GetGValue(dlgColour.Color) shr 5;
    b := GetBValue(dlgColour.Color) shr 5;
    c := (r shl 1)+(g shl 5)+(b shl 9)+extrabits; // Combine RGB and re-add unused bits.
    WriteColour(c,palselect); // Write to file array.
    DrawPal;
    DrawBrowser;
    end;
end;

procedure TForm1.btnSaveClick(Sender: TObject);
begin
  if romopen <> '' then SaveFile(romopen);
end;

procedure TForm1.btnSaveAsClick(Sender: TObject);
begin
  if Length(filearray) > 0 then
    if dlgSave.Execute then SaveFile(dlgSave.FileName);
end;

procedure TForm1.barBrowserChange(Sender: TObject);
begin
  browserpos := barBrowser.Position shl 6; // Update browser when scrollbar moves.
  DrawBrowser;
end;

procedure TForm1.btnCopyClick(Sender: TObject);
begin
  if palcount > 0 then
    begin
    SetLength(copybuffer,(palselect2-palselect+1) shl 1); // Size of selection.
    Move(filearray[romaddress+(palselect shl 1)],copybuffer[0],Length(copybuffer)); // Copy.
    end;
end;

procedure TForm1.btnPasteClick(Sender: TObject);
var len: integer;
begin
  len := Length(copybuffer);
  if (palcount > 0) and (len > 0) then
    begin
    if palselect+(len shr 1) > palcount then len := (palcount-palselect) shl 1; // Trim overflow.
    Move(copybuffer[0],filearray[romaddress+(palselect shl 1)],len); // Paste.
    DrawPal;
    DrawBrowser;
    end;
end;

procedure TForm1.btnGradientClick(Sender: TObject);
var stepcount, i, r, g, b: integer;
  c1, c2, extrabits: word;
  stepr, stepg, stepb: single;
begin
  stepcount := palselect2-palselect;
  if (palcount > 0) and (stepcount > 1) then
    begin
    c1 := GetColour(palselect) and $eee; // Get start colour.
    c2 := GetColour(palselect2) and $eee; // Get end colour.
    stepr := ((c2 and $e)-(c1 and $e)) / stepcount; // Get gradient step size for each colour.
    stepg := (((c2 shr 4) and $e)-((c1 shr 4) and $e)) / stepcount;
    stepb := (((c2 shr 8) and $e)-((c1 shr 8) and $e)) / stepcount;
    for i := 1 to stepcount-1 do
      begin                                                                                  
      extrabits := GetColour(palselect+i) and $f111; // Store unused bits.
      r := (Round(stepr*i)+(c1 and $e)) and $e;
      g := (Round(stepg*i)+((c1 shr 4) and $e)) and $e;
      b := (Round(stepb*i)+((c1 shr 8) and $e)) and $e;
      WriteColour(extrabits+(b shl 8)+(g shl 4)+r,palselect+i); // Write to file array.
      end;
    DrawPal;
    DrawBrowser;
    end;
end;

procedure TForm1.btnSwapClick(Sender: TObject);
var c: word;
begin
  if (palcount > 0) and (palselect <> palselect2) then
    begin
    c := GetColour(palselect); // Buffer 1st colour.
    WriteColour(GetColour(palselect2),palselect); // Copy 2nd to 1st.
    WriteColour(c,palselect2); // Copy buffer to 2nd.
    DrawPal;
    DrawBrowser;
    end;
end;

procedure TForm1.btnReverseClick(Sender: TObject);
var i: integer;
  c: word;
begin   
  if (palcount > 0) and (palselect <> palselect2) then
    begin
    for i := 0 to (palselect2-palselect) div 2 do
      begin  
      c := GetColour(palselect+i); // Buffer 1st colour.
      WriteColour(GetColour(palselect2-i),palselect+i); // Copy 2nd to 1st.
      WriteColour(c,palselect2-i); // Copy buffer to 2nd.
      end;
    DrawPal;
    DrawBrowser;
    end;
end;

function TForm1.GetColour(c: integer): word; // Get colour from palette menu.
begin
  result := GetWord(romaddress+(c shl 1));
end;

procedure TForm1.WriteColour(c: word; n: integer); // Write colour on palette menu.
begin
  filearray[romaddress+(n shl 1)] := Hi(c);
  filearray[romaddress+(n shl 1)+1] := Lo(c);
end;

procedure TForm1.btnASMClick(Sender: TObject);
var i, j, p, b: integer;
  line: string;
begin
  if romopen = '' then // Check if no ROM is open.
    begin
    SetLength(filearray,$80); // Create dummy file.
    romwordcount := $40;
    palcount := $40;
    palselect := 0;
    palselect2 := 0;
    romopen := ExtractFilePath(Application.ExeName)+'palette.bin'; // Put file in program folder if saved.
    end;
  p := 0;
  for i := 0 to memoASM.Lines.Count do
    begin
    line := memoASM.Lines[i]; // Get line.
    line := Explode(line,'dc.w',1); // Strip dc.w.
    line := Explode(line,';',0); // Strip comment.
    line := StringReplace(line,#9,'',[rfReplaceAll]); // Strip tabs.
    line := StringReplace(line,' ','',[rfReplaceAll]); // Strip spaces.
    j := 0;
    while (Explode(line,',',j) <> '') and (p < palcount) do
      begin
      if TryStrtoInt(Explode(line,',',j),b) = true then
        WriteColour(StrtoInt(Explode(line,',',j)),p) // Write colour if valid.
      else WriteColour(0,p); // Otherwise write 0 (black).
      inc(j);
      inc(p);
      end;
    end;
  if (romopen = '') and (p > 0) then
    begin
    SetLength(filearray,p shl 1); // Truncate dummy file.
    romwordcount := p;
    palcount := p;
    end;
  if palcount > 0 then
    begin
    DrawPal;
    DrawBrowser;
    end;
end;

procedure TForm1.editBitsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var newc: word;
  bit: integer;
begin
  if (romopen <> '') and (palcount > 0) then
    begin
    newc := GetColour(palselect); // Get initial colour.
    bit := 15-(X div 11); // Which bit was clicked.
    if GetBit(newc,bit) = 0 then newc := newc+(1 shl bit) // Chg bit.
    else newc := newc-(1 shl bit);
    WriteColour(newc,palselect);
    DrawPal;
    DrawBrowser;
    end;
end;

procedure TForm1.menuBrightnessChange(Sender: TObject);
begin
  if romopen <> '' then DrawBrowser; // Redraw browser when brightness setting changes.
  if palcount > 0 then DrawPal;
end;

procedure TForm1.ByteSwapFile; // Byteswap entire file in memory.
var i: integer;
  b: byte;
begin
  for i := 0 to romwordcount-1 do
    begin
    b := filearray[i*2]; // Save 1st byte.
    filearray[i*2] := filearray[(i*2)+1]; // Update 1st byte.
    filearray[(i*2)+1] := b; // Update 2nd byte.
    end;
end;

procedure TForm1.chkLittleClick(Sender: TObject);
begin
  if romopen <> '' then
    begin
    ByteSwapFile;
    DrawBrowser;
    if palcount > 0 then DrawPal;
    end;
end;

procedure TForm1.btnExBINClick(Sender: TObject); // Save current palette as bin.
begin
  if palcount > 0 then if dlgSave.Execute then
    begin
    AssignFile(myfile,dlgSave.FileName);
    FileMode := fmOpenReadWrite;
    ReWrite(myfile,1);
    BlockWrite(myfile,filearray[romaddress],palcount*2);
    CloseFile(myfile);
    end;
end;

procedure TForm1.btnExTPLClick(Sender: TObject); // Save current palette as Tile Layer Pro file.
var i: integer;
begin
  if palcount > 0 then if dlgSaveTPL.Execute then
    begin
    tplarray[0] := $54; // T
    tplarray[1] := $50; // P
    tplarray[2] := $4c; // L
    for i := 0 to palcount-1 do
      begin
      tplarray[4+(i*3)] := lumin[(GetColour(i) and $e)+(menuBrightness.ItemIndex*16)];
      tplarray[4+(i*3)+1] := lumin[((GetColour(i) and $e0) shr 4)+(menuBrightness.ItemIndex*16)];
      tplarray[4+(i*3)+2] := lumin[((GetColour(i) and $e00) shr 8)+(menuBrightness.ItemIndex*16)];
      end; 
    AssignFile(myfile,dlgSaveTPL.FileName);
    FileMode := fmOpenReadWrite;
    ReWrite(myfile,1);
    BlockWrite(myfile,tplarray[0],Length(tplarray));
    CloseFile(myfile);
    end;
end;

procedure TForm1.btnPlayClick(Sender: TObject);
begin
  if btnPlay.Caption = 'Play' then
    begin
    btnPlay.Caption := 'Stop';
    timerAnimation.Enabled := true; // Start timer.
    timerAnimation.Interval := (1000 div 60)*StrtoInt(editAnimation.Text); // Set interval (60fps).
    aniframes := palcount div (menuAnimation.ItemIndex+1); // Number of frames.
    anicurrent := 0;
    DrawRect(240,240,240,255,areaAnimation.Left,areaAnimation.Top,areaAnimation.Width,areaAnimation.Height); // Clear display.
    end
  else
    begin
    btnPlay.Caption := 'Play';  
    timerAnimation.Enabled := false; // Stop timer.
    end;
end;

procedure TForm1.timerAnimationTimer(Sender: TObject);
var i: integer;
begin
  for i := 0 to menuAnimation.ItemIndex do // Draw colours.
    DrawRectMD(GetColour((anicurrent*(menuAnimation.ItemIndex+1))+i),areaAnimation.Left+(i*25),areaAnimation.Top,25,40);
  inc(anicurrent); // Next frame.
  if anicurrent = aniframes then anicurrent := 0; // Reset to 0 if animation has finished.
  imgMain.Refresh;
end;

procedure TForm1.editAnimationKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    '0'..'9', 'a'..'f', 'A'..'F', '$', #8: ; // Allow hex nums, $, backspace.
  else key := #0; // Otherwise do nothing.
  end;
end;

end.
