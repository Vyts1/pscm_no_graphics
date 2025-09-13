object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 150
  Width = 215
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Materials.mdb;Persi' +
      'st Security Info=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 16
  end
  object ADOTable1: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    TableDirect = True
    TableName = 'Material properties'
    Left = 96
    Top = 16
    object ADOTable1nId: TAutoIncField
      FieldName = 'nId'
      KeyFields = 'nId'
      ReadOnly = True
    end
    object ADOTable1Material: TWideStringField
      FieldName = 'Material'
      Size = 50
    end
    object ADOTable1ROms: TFloatField
      FieldName = 'ROms'
    end
    object ADOTable1ROml: TFloatField
      FieldName = 'ROml'
    end
    object ADOTable1CPms: TFloatField
      FieldName = 'CPms'
    end
    object ADOTable1CPml: TFloatField
      FieldName = 'CPml'
    end
    object ADOTable1Lms: TFloatField
      FieldName = 'Lms'
    end
    object ADOTable1Lml: TFloatField
      FieldName = 'Lml'
    end
    object ADOTable1Tm: TFloatField
      FieldName = 'Tm'
    end
    object ADOTable1TBoil: TFloatField
      FieldName = 'TBoil'
    end
    object ADOTable1Lm: TFloatField
      FieldName = 'Lm'
    end
    object ADOTable1MUml: TFloatField
      FieldName = 'MUml'
    end
    object ADOTable1SIGml: TFloatField
      FieldName = 'SIGml'
    end
    object ADOTable1LBoil: TFloatField
      FieldName = 'LBoil'
    end
    object ADOTable1AW: TFloatField
      FieldName = 'AW'
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 32
    Top = 72
  end
end
