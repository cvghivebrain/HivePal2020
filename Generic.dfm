object Form1: TForm1
  Left = 192
  Top = 124
  BorderStyle = bsSingle
  Caption = 'HivePal 2.2'
  ClientHeight = 657
  ClientWidth = 953
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010000000000000680500001600000028000000100000002000
    0000010008000000000040010000000000000000000000000000000000000000
    0000FFFFFF0000FF00000000FF00FF0000008080800040404000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000404
    0404040404040505050505050505040404040404040406060606060606060404
    0404040404040505050505050505040404040404040406060606060606060404
    0404040404040505050505050505040404040404040406060606060606060404
    0404040404040505050505050505040404040404040406060606060606060303
    0303030303030202020202020202030303030303030302020202020202020303
    0303030303030202020202020202030303030303030302020202020202020303
    0303030303030202020202020202030303030303030302020202020202020303
    0303030303030202020202020202030303030303030302020202020202020000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object imgMain: TImage
    Left = 0
    Top = 0
    Width = 57
    Height = 57
  end
  object areaPal: TImage
    Left = 8
    Top = 136
    Width = 400
    Height = 160
    OnMouseDown = areaPalMouseDown
    OnMouseUp = areaPalMouseUp
  end
  object areaRGB: TImage
    Left = 8
    Top = 336
    Width = 240
    Height = 90
    OnMouseDown = areaRGBMouseDown
  end
  object lblLength: TLabel
    Left = 192
    Top = 8
    Width = 33
    Height = 13
    Caption = 'Length'
  end
  object lblBrowser: TLabel
    Left = 416
    Top = 16
    Width = 58
    Height = 13
    Caption = 'Top Left: $0'
  end
  object lblBrowserMouse: TLabel
    Left = 520
    Top = 16
    Width = 75
    Height = 13
    Caption = 'Under Mouse: x'
  end
  object areaBrowserOut: TImage
    Left = 400
    Top = 8
    Width = 553
    Height = 561
    OnMouseMove = areaBrowserOutMouseMove
  end
  object areaBrowser: TImage
    Left = 416
    Top = 32
    Width = 512
    Height = 512
    OnMouseDown = areaBrowserMouseDown
    OnMouseMove = areaBrowserMouseMove
  end
  object Bevel2: TBevel
    Left = 8
    Top = 456
    Width = 401
    Height = 9
  end
  object lblBrightness: TLabel
    Left = 192
    Top = 88
    Width = 49
    Height = 13
    Caption = 'Brightness'
  end
  object lblAnimation: TLabel
    Left = 8
    Top = 472
    Width = 77
    Height = 13
    Caption = 'Animation Width'
  end
  object areaAnimation: TImage
    Left = 256
    Top = 472
    Width = 150
    Height = 40
  end
  object chkInvalid: TCheckBox
    Left = 720
    Top = 8
    Width = 129
    Height = 17
    Caption = 'Show Invalid Palettes'
    TabOrder = 0
    OnClick = chkInvalidClick
  end
  object btnCopy: TButton
    Left = 8
    Top = 304
    Width = 73
    Height = 25
    Caption = 'Copy'
    TabOrder = 1
    OnClick = btnCopyClick
  end
  object btnPaste: TButton
    Left = 88
    Top = 304
    Width = 73
    Height = 25
    Caption = 'Paste'
    TabOrder = 2
    OnClick = btnPasteClick
  end
  object btnGradient: TButton
    Left = 168
    Top = 304
    Width = 73
    Height = 25
    Caption = 'Gradient'
    TabOrder = 3
    OnClick = btnGradientClick
  end
  object btnLoad: TButton
    Left = 8
    Top = 8
    Width = 169
    Height = 49
    Caption = 'Load File or ROM'
    TabOrder = 4
    WordWrap = True
    OnClick = btnLoadClick
  end
  object btnSave: TButton
    Left = 8
    Top = 64
    Width = 81
    Height = 49
    Caption = 'Save Changes'
    TabOrder = 5
    OnClick = btnSaveClick
  end
  object btnSaveAs: TButton
    Left = 96
    Top = 64
    Width = 81
    Height = 49
    Caption = 'Save File As...'
    TabOrder = 6
    OnClick = btnSaveAsClick
  end
  object menuLength: TComboBox
    Left = 192
    Top = 24
    Width = 65
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 7
    Text = 'Auto'
    OnChange = menuLengthChange
    Items.Strings = (
      'Auto'
      '$10'
      '$20'
      '$30'
      '$40'
      'Other')
  end
  object editAddress: TLabeledEdit
    Left = 192
    Top = 64
    Width = 121
    Height = 21
    EditLabel.Width = 109
    EditLabel.Height = 13
    EditLabel.Caption = 'Address (add $ for hex)'
    TabOrder = 8
    OnChange = editAddressChange
    OnKeyPress = editAddressKeyPress
  end
  object memoASM: TMemo
    Left = 8
    Top = 552
    Width = 937
    Height = 97
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object editLength: TEdit
    Left = 264
    Top = 24
    Width = 65
    Height = 21
    TabOrder = 10
    Visible = False
    OnChange = editLengthChange
    OnKeyPress = editLengthKeyPress
  end
  object btnReload: TButton
    Left = 320
    Top = 64
    Width = 57
    Height = 25
    Caption = 'Load'
    TabOrder = 11
    OnClick = btnReloadClick
  end
  object btnColour: TButton
    Left = 256
    Top = 336
    Width = 145
    Height = 41
    Caption = 'Advanced Colour Menu...'
    TabOrder = 12
    OnClick = btnColourClick
  end
  object barBrowser: TScrollBar
    Left = 929
    Top = 32
    Width = 17
    Height = 513
    Enabled = False
    Kind = sbVertical
    LargeChange = 32
    Max = 0
    PageSize = 0
    TabOrder = 13
    OnChange = barBrowserChange
  end
  object btnSwap: TButton
    Left = 248
    Top = 304
    Width = 73
    Height = 25
    Caption = 'Swap'
    TabOrder = 14
    OnClick = btnSwapClick
  end
  object btnReverse: TButton
    Left = 328
    Top = 304
    Width = 73
    Height = 25
    Caption = 'Reverse'
    TabOrder = 15
    OnClick = btnReverseClick
  end
  object btnASM: TButton
    Left = 8
    Top = 520
    Width = 161
    Height = 25
    Caption = 'Update ASM Changes to Palette'
    TabOrder = 16
    OnClick = btnASMClick
  end
  object editBits: TRichEdit
    Left = 8
    Top = 432
    Width = 185
    Height = 17
    Cursor = crArrow
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clBtnFace
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    Lines.Strings = (
      '0000000000000000')
    ParentFont = False
    TabOrder = 17
    OnMouseDown = editBitsMouseDown
  end
  object menuBrightness: TComboBox
    Left = 192
    Top = 104
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 18
    Text = 'Real'
    OnChange = menuBrightnessChange
    Items.Strings = (
      'Real'
      'Shadow'
      'Highlight'
      'Genecyst')
  end
  object chkLittle: TCheckBox
    Left = 856
    Top = 8
    Width = 89
    Height = 17
    Caption = 'Little Endian'
    TabOrder = 19
    OnClick = chkLittleClick
  end
  object btnExBIN: TButton
    Left = 264
    Top = 384
    Width = 65
    Height = 25
    Caption = 'Export BIN'
    TabOrder = 20
    OnClick = btnExBINClick
  end
  object btnExTPL: TButton
    Left = 336
    Top = 384
    Width = 65
    Height = 25
    Caption = 'Export TPL'
    TabOrder = 21
    OnClick = btnExTPLClick
  end
  object menuAnimation: TComboBox
    Left = 8
    Top = 488
    Width = 97
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 22
    Text = '1'
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6')
  end
  object editAnimation: TLabeledEdit
    Left = 112
    Top = 488
    Width = 97
    Height = 21
    EditLabel.Width = 62
    EditLabel.Height = 13
    EditLabel.Caption = 'Delay (60fps)'
    TabOrder = 23
    OnKeyPress = editAnimationKeyPress
  end
  object btnPlay: TButton
    Left = 216
    Top = 480
    Width = 33
    Height = 33
    Caption = 'Play'
    TabOrder = 24
    OnClick = btnPlayClick
  end
  object dlgOpen: TOpenDialog
    Left = 344
    Top = 512
  end
  object dlgColour: TColorDialog
    Left = 376
    Top = 512
  end
  object dlgSave: TSaveDialog
    Left = 312
    Top = 512
  end
  object dlgSaveTPL: TSaveDialog
    DefaultExt = 'tpl'
    Filter = 'Tile Layer Pro Palette|*.tpl'
    Left = 280
    Top = 512
  end
  object timerAnimation: TTimer
    Enabled = False
    OnTimer = timerAnimationTimer
    Left = 248
    Top = 512
  end
end
