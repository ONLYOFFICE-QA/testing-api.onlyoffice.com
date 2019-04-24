module TestingApiOnlyfficeCom
  class TestData
    # document builder/generated file name
    DEFAULT_BUILDER_FILE_NAME = 'SampleText.docx'.freeze
    DEFAULT_BUILDER_DOCX_FILE_NAME = 'Sample.docx'.freeze
    DEFAULT_BUILDER_XLSX_FILE_NAME = 'Sample.xlsx'.freeze
    # document builder/downloaded library name
    DEFAULT_LIBRARY_LINUX_X64_NAME = 'documentbuilder-x64.tar.gz'.freeze
    DEFAULT_LIBRARY_WINDOWS_X64_NAME = 'documentbuilder-x64.zip'.freeze
    DEFAULT_LIBRARY_WINDOWS_X86_NAME = 'documentbuilder-x86.zip'.freeze
    # document builder/data for document generation
    DEFAULT_NAME = 'John Smith'.freeze
    DEFAULT_COMPANY = 'ONLYOFFICE'.freeze
    DEFAULT_POSITION = 'Commercial director'.freeze
    CUSTOM_NAME = 'Ivan Lebedev'.freeze
    CUSTOM_COMPANY = 'Heartwell'.freeze
    CUSTOM_POSITION = 'QA Engineer'.freeze
    # hash for generation documentation objects
    DOCUMENTATION = { 'Text document API': { Api: %w[CreateBlipFill CreateBlockLvlSdt CreateBullet CreateChart CreateGradientStop
                                                     CreateImage CreateInlineLvlSdt CreateLinearGradientFill CreateNoFill CreateNumbering
                                                     CreateParagraph CreatePatternFill CreatePresetColor CreateRadialGradientFill CreateRGBColor
                                                     CreateRun CreateSchemeColor CreateShape CreateSolidFill CreateStroke CreateTable],
                                             ApiBlockLvlSdt: %w[GetAlias GetClassType GetContent GetLabel GetLock GetTag SetAlias SetLabel
                                                                SetLock SetTag],
                                             ApiBullet: %w[GetClassType],
                                             ApiChart: %w[GetClassType SetHorAxisLablesFontSize SetHorAxisMajorTickMark SetHorAxisMinorTickMark
                                                          SetHorAxisOrientation SetHorAxisTickLabelPosition SetHorAxisTitle SetLegendFontSize SetLegendPos
                                                          SetMajorHorizontalGridlines SetMajorVerticalGridlines SetMinorHorizontalGridlines SetMinorVerticalGridlines
                                                          SetShowDataLabels SetShowPointDataLabel SetTitle SetVerAxisOrientation SetVerAxisTitle SetVertAxisLablesFontSize
                                                          SetVertAxisMajorTickMark SetVertAxisMinorTickMark SetVertAxisTickLabelPosition],
                                             ApiDocument: %w[AddElement CreateNewHistoryPoint CreateNumbering CreateSection CreateStyle GetAllContentControls
                                                             GetClassType GetCommentsReport GetDefaultParaPr GetDefaultStyle GetDefaultTextPr GetElement GetElementsCount
                                                             GetFinalSection GetReviewReport GetStyle InsertContent InsertWatermark Push RemoveAllElements RemoveElement
                                                             SearchAndReplace SetEvenAndOddHdrFtr],
                                             ApiDocumentContent: %w[AddElement GetClassType GetElement GetElementsCount Push RemoveAllElements RemoveElement],
                                             ApiDrawing: %w[GetClassType SetDistances SetHorAlign SetHorPosition SetSize SetVerAlign SetVerPosition SetWrappingStyle],
                                             ApiFill: %w[GetClassType],
                                             ApiGradientStop: %w[GetClassType],
                                             ApiImage: %w[GetClassType],
                                             ApiInlineLvlSdt: %w[AddElement GetAlias GetClassType GetElement GetElementsCount GetLabel GetLock GetTag
                                                                 RemoveAllElements RemoveElement SetAlias SetLabel SetLock SetTag],
                                             ApiNumbering: %w[GetClassType GetLevel],
                                             ApiNumberingLevel: %w[GetClassType GetLevelIndex GetNumbering GetParaPr GetTextPr SetCustomType SetRestart
                                                                   SetStart SetSuff SetTemplateType],
                                             ApiParagraph: %w[AddColumnBreak AddDrawing AddElement AddInlineLvlSdt AddLineBreak AddPageBreak AddPageNumber
                                                              AddPagesCount AddTabStop AddText GetClassType GetElement GetElementsCount GetNumbering GetParagraphMarkTextPr
                                                              GetParaPr RemoveAllElements RemoveElement SetBetweenBorder SetBottomBorder SetBullet SetContextualSpacing
                                                              SetIndFirstLine SetIndLeft SetIndRight SetJc SetKeepLines SetKeepNext SetLeftBorder SetNumbering SetNumPr
                                                              SetPageBreakBefore SetRightBorder SetShd SetSpacingAfter SetSpacingBefore SetSpacingLine SetStyle SetTabs
                                                              SetTopBorder SetWidowControl],
                                             ApiParaPr: %w[GetClassType SetBetweenBorder SetBottomBorder SetBullet SetContextualSpacing SetIndFirstLine SetIndLeft
                                                           SetIndRight SetJc SetKeepLines SetKeepNext SetLeftBorder SetNumPr SetPageBreakBefore SetRightBorder SetShd
                                                           SetSpacingAfter SetSpacingBefore SetSpacingLine SetStyle SetTabs SetTopBorder SetWidowControl],
                                             ApiPresetColor: %w[GetClassType],
                                             ApiRGBColor: %w[GetClassType],
                                             ApiRun: %w[AddColumnBreak AddDrawing AddLineBreak AddPageBreak AddTabStop AddText ClearContent GetClassType GetTextPr
                                                        SetBold SetCaps SetColor SetDoubleStrikeout SetFill SetFontFamily SetFontSize SetHighlight SetItalic SetLanguage
                                                        SetPosition SetShd SetSmallCaps SetSpacing SetStrikeout SetStyle SetUnderline SetVertAlign],
                                             ApiSchemeColor: %w[GetClassType],
                                             ApiSection: %w[GetClassType GetFooter GetHeader RemoveFooter RemoveHeader SetEqualColumns SetFooterDistance
                                                            SetHeaderDistance SetNotEqualColumns SetPageMargins SetPageSize SetTitlePage SetType],
                                             ApiShape: %w[GetClassType GetDocContent SetPaddings SetVerticalTextAlign],
                                             ApiStroke: %w[GetClassType],
                                             ApiStyle: %w[GetClassType GetConditionalTableStyle GetName GetParaPr GetTableCellPr GetTablePr GetTableRowPr
                                                          GetTextPr GetType SetBasedOn SetName],
                                             ApiTable: %w[AddColumn AddRow GetClassType GetRow GetRowsCount MergeCells RemoveColumn RemoveRow SetCellSpacing
                                                          SetJc SetShd SetStyle SetStyleColBandSize SetStyleRowBandSize SetTableBorderBottom SetTableBorderInsideH
                                                          SetTableBorderInsideV SetTableBorderLeft SetTableBorderRight SetTableBorderTop SetTableCellMarginBottom
                                                          SetTableCellMarginLeft SetTableCellMarginRight SetTableCellMarginTop SetTableInd SetTableLayout SetTableLook SetWidth],
                                             ApiTableCell: %w[GetClassType GetContent SetCellBorderBottom SetCellBorderLeft SetCellBorderRight SetCellBorderTop
                                                              SetCellMarginBottom SetCellMarginLeft SetCellMarginRight SetCellMarginTop SetNoWrap SetShd SetTextDirection
                                                              SetVerticalAlign SetWidth],
                                             ApiTableCellPr: %w[GetClassType SetCellBorderBottom SetCellBorderLeft SetCellBorderRight SetCellBorderTop
                                                                SetCellMarginBottom SetCellMarginLeft SetCellMarginRight SetCellMarginTop SetNoWrap SetShd SetTextDirection
                                                                SetVerticalAlign SetWidth],
                                             ApiTablePr: %w[GetClassType SetCellSpacing SetJc SetShd SetStyleColBandSize SetStyleRowBandSize SetTableBorderBottom
                                                            SetTableBorderInsideH SetTableBorderInsideV SetTableBorderLeft SetTableBorderRight SetTableBorderTop
                                                            SetTableCellMarginBottom SetTableCellMarginLeft SetTableCellMarginRight SetTableCellMarginTop SetTableInd SetTableLayout
                                                            SetWidth],
                                             ApiTableRow: %w[GetCell GetCellsCount GetClassType SetHeight SetTableHeader],
                                             ApiTableRowPr: %w[GetClassType SetHeight SetTableHeader],
                                             ApiTableStylePr: %w[GetClassType GetParaPr GetTableCellPr GetTablePr GetTableRowPr GetTextPr GetType],
                                             ApiTextPr: %w[GetClassType SetBold SetCaps SetColor SetDoubleStrikeout SetFill SetFontFamily SetFontSize SetHighlight SetItalic
                                                           SetLanguage SetPosition SetShd SetSmallCaps SetSpacing SetStrikeout SetStyle SetUnderline SetVertAlign],
                                             ApiUniColor: %w[GetClassType],
                                             ApiUnsupported: %w[GetClassType] },
                      'Spreadsheet API': { Api: %w[AddSheet CreateBlipFill CreateBullet CreateColorByName CreateColorFromRGB CreateGradientStop CreateLinearGradientFill
                                                   CreateNoFill CreateNumbering CreateParagraph CreatePatternFill CreatePresetColor CreateRGBColor CreateRun CreateSchemeColor
                                                   CreateSolidFill CreateStroke Format GetActiveSheet GetLocale GetSheet GetSheets GetThemesColors SetLocale SetThemeColors],
                                           ApiBullet: %w[GetClassType],
                                           ApiChart: %w[ApplyChartStyle GetClassType SetHorAxisLablesFontSize SetHorAxisMajorTickMark SetHorAxisMinorTickMark SetHorAxisOrientation
                                                        SetHorAxisTickLabelPosition SetHorAxisTitle SetLegendFontSize SetLegendPos SetMajorHorizontalGridlines
                                                        SetMajorVerticalGridlines SetMinorHorizontalGridlines SetMinorVerticalGridlines SetShowDataLabels SetShowPointDataLabel
                                                        SetTitle SetVerAxisOrientation SetVerAxisTitle SetVertAxisLablesFontSize SetVertAxisMajorTickMark
                                                        SetVertAxisMinorTickMark SetVertAxisTickLabelPosition],
                                           ApiColor: %w[GetClassType],
                                           ApiDocument: %w[AddElement GetElement GetElementsCount Push RemoveAllElements RemoveElement],
                                           ApiDocumentContent: %w[AddElement GetClassType GetElement GetElementsCount Push RemoveAllElements RemoveElement],
                                           ApiDrawing: %w[GetClassType SetPosition SetSize],
                                           ApiFill: %w[GetClassType],
                                           ApiGradientStop: %w[GetClassType],
                                           ApiImage: %w[GetClassType],
                                           ApiParagraph: %w[AddElement AddLineBreak AddTabStop AddText GetClassType GetElement GetElementsCount GetParaPr RemoveAllElements
                                                            RemoveElement SetBullet SetIndFirstLine SetIndLeft SetIndRight SetJc SetSpacingAfter SetSpacingBefore
                                                            SetSpacingLine SetTabs],
                                           ApiParaPr: %w[GetClassType SetBullet SetIndFirstLine SetIndLeft SetIndRight SetJc SetSpacingAfter SetSpacingBefore
                                                         SetSpacingLine SetTabs],
                                           ApiRange: %w[AddComment ForEach GetAddress GetCol GetColumnWidth GetCount GetHidden GetRow GetRowHeight GetValue Merge
                                                        SetAlignHorizontal SetAlignVertical SetBold SetBorders SetColumnWidth SetFillColor SetFontColor SetFontName SetFontSize
                                                        SetHidden SetItalic SetNumberFormat SetOffset SetRowHeight SetStrikeout SetUnderline SetValue SetWrap UnMerge],
                                           ApiRGBColor: %w[GetClassType],
                                           ApiRun: %w[AddLineBreak AddTabStop AddText ClearContent GetTextPr SetBold SetCaps SetDoubleStrikeout SetFill SetFontFamily SetFontSize
                                                      SetItalic SetSmallCaps SetSpacing SetStrikeout SetUnderline SetVertAlign],
                                           ApiSchemeColor: %w[GetClassType],
                                           ApiShape: %w[GetClassType GetDocContent SetVerticalTextAlign],
                                           ApiStroke: %w[GetClassType],
                                           ApiTextPr: %w[GetClassType SetBold SetCaps SetDoubleStrikeout SetFill SetFontFamily SetFontSize SetItalic SetSmallCaps SetSpacing
                                                         SetStrikeout SetUnderline SetVertAlign],
                                           ApiUniColor: %w[GetClassType],
                                           ApiWorksheet: %w[AddChart AddImage AddShape FormatAsTable GetActiveCell GetBottomMargin GetCells GetCols GetIndex GetLeftMargin
                                                            GetName GetPageOrientation GetRange GetRangeByNumber GetRightMargin GetRows GetSelection GetTopMargin GetUsedRange
                                                            GetVisible ReplaceCurrentImage SetBottomMargin SetColumnWidth SetDisplayGridlines SetDisplayHeadings SetLeftMargin
                                                            SetName SetPageOrientation SetRightMargin SetRowHeight SetTopMargin SetVisible] },
                      'Presentation API': { Api: %w[CreateBlipFill CreateBullet CreateChart CreateGradientStop CreateGroup CreateImage CreateLinearGradientFill CreateNoFill
                                                    CreateNumbering CreateParagraph CreatePatternFill CreatePresetColor CreateRadialGradientFill CreateRGBColor CreateRun
                                                    CreateSchemeColor CreateShape CreateSlide CreateSolidFill CreateStroke CreateTable GetPresentation],
                                            ApiBullet: %w[GetClassType],
                                            ApiChart: %w[GetClassType SetHorAxisLablesFontSize SetHorAxisMajorTickMark SetHorAxisMinorTickMark SetHorAxisOrientation
                                                         SetHorAxisTickLabelPosition SetHorAxisTitle SetLegendFontSize SetLegendPos SetMajorHorizontalGridlines
                                                         SetMajorVerticalGridlines SetMinorHorizontalGridlines SetMinorVerticalGridlines SetShowDataLabels SetShowPointDataLabel
                                                         SetTitle SetVerAxisOrientation SetVerAxisTitle SetVertAxisLablesFontSize SetVertAxisMajorTickMark
                                                         SetVertAxisMinorTickMark SetVertAxisTickLabelPosition],
                                            ApiDocument: %w[AddElement GetElement GetElementsCount Push RemoveAllElements RemoveElement],
                                            ApiDocumentContent: %w[AddElement GetClassType GetElement GetElementsCount Push RemoveAllElements RemoveElement],
                                            ApiDrawing: %w[GetClassType SetPosition SetSize],
                                            ApiFill: %w[GetClassType],
                                            ApiGradientStop: %w[GetClassType],
                                            ApiImage: %w[GetClassType],
                                            ApiParagraph: %w[AddElement AddLineBreak AddTabStop AddText GetClassType GetElement GetElementsCount GetParaPr RemoveAllElements
                                                             RemoveElement SetBullet SetIndFirstLine SetIndLeft SetIndRight SetJc SetSpacingAfter SetSpacingBefore
                                                             SetSpacingLine SetTabs],
                                            ApiParaPr: %w[GetClassType SetBullet SetIndFirstLine SetIndLeft SetIndRight SetJc SetSpacingAfter SetSpacingBefore
                                                          SetSpacingLine SetTabs],
                                            ApiPresentation: %w[AddSlide CreateNewHistoryPoint GetClassType GetCurrentSlide GetCurSlideIndex GetSlideByIndex
                                                                ReplaceCurrentImage SetSizes],
                                            ApiPresetColor: %w[GetClassType],
                                            ApiRGBColor: %w[GetClassType],
                                            ApiRun: %w[AddLineBreak AddTabStop AddText ClearContent GetClassType GetTextPr SetBold SetCaps SetDoubleStrikeout SetFill
                                                       SetFontFamily SetFontSize SetItalic SetSmallCaps SetSpacing SetStrikeout SetUnderline SetVertAlign],
                                            ApiSchemeColor: %w[GetClassType],
                                            ApiShape: %w[GetClassType GetDocContent SetVerticalTextAlign],
                                            ApiSlide: %w[AddObject GetClassType GetHeight GetWidth RemoveAllObjects SetBackground],
                                            ApiStroke: %w[GetClassType],
                                            ApiTable: %w[AddColumn AddRow GetClassType GetRow MergeCells RemoveColumn RemoveRow SetShd SetTableLook],
                                            ApiTableCell: %w[GetClassType GetContent SetCellBorderBottom SetCellBorderLeft SetCellBorderRight SetCellBorderTop
                                                             SetCellMarginBottom SetCellMarginLeft SetCellMarginRight SetCellMarginTop SetShd SetTextDirection SetVerticalAlign],
                                            ApiTableRow: %w[GetCell GetCellsCount GetClassType SetHeight],
                                            ApiTextPr: %w[GetClassType SetBold SetCaps SetDoubleStrikeout SetFill SetFontFamily SetFontSize SetItalic SetSmallCaps SetSpacing
                                                          SetStrikeout SetUnderline SetVertAlign],
                                            ApiUniColor: %w[GetClassType] } }.freeze
  end
end
