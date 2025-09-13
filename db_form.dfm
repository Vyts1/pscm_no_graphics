object Form2: TForm2
  Left = 216
  Top = 579
  Width = 714
  Height = 386
  Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 706
    Height = 321
    Align = alTop
    DataSource = DataModule1.DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'nId'
        Width = 28
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Material'
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ROms'
        Width = 42
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ROml'
        Width = 42
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CPms'
        Width = 46
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CPml'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Lms'
        Width = 42
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Lml'
        Width = 35
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Tm'
        Width = 36
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TBoil'
        Width = 39
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Lm'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MUml'
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIGml'
        Width = 46
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LBoil'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AW'
        Width = 57
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 152
    Top = 328
    Width = 240
    Height = 25
    DataSource = DataModule1.DataSource1
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 416
    Top = 328
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = BitBtn1Click
  end
end
