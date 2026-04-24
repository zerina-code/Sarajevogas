dotnet
{
    assembly("Microsoft.VisualBasic")
    {
        Version = '10.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b03f5f7f11d50a3a';

        type("Microsoft.VisualBasic.DateAndTime"; "DateAndTime")
        {
        }

        type("Microsoft.VisualBasic.FirstDayOfWeek"; "FirstDayOfWeek")
        {
        }

        type("Microsoft.VisualBasic.FirstWeekOfYear"; "FirstWeekOfYear")
        {
        }
    }
    /* assembly("Microsoft.Dynamics.Nav.Integration.Office")
     {
         Version = '17.0.0.0';
         Culture = 'neutral';
         PublicKeyToken = '31bf3856ad364e35';

         type("Microsoft.Dynamics.Nav.Integration.Office.Excel.ExcelHelper"; "ExcelHelper2")
         {
         }
     }*/

    assembly("Microsoft.Office.Interop.Excel")
    {
        Version = '15.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = '71e9bce111e9429c';



        type("Microsoft.Office.Interop.Excel.Workbook"; "Workbook2")
        {
        }

        type("Microsoft.Office.Interop.Excel.Range"; "Range2")
        {
        }

        type("Microsoft.Office.Interop.Excel.AboveAverage"; "AboveAverage2")
        {
        }
        type("Microsoft.Office.Interop.Excel.Application"; "Application2")
        {
        }


        type("Microsoft.Office.Interop.Excel.Workbooks"; "Workbooks2")
        {
        }
    }



    assembly("System")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Diagnostics.Process"; "WShell")
        {
        }

        type("System.Diagnostics.DataReceivedEventArgs"; "DataReceivedEventArgs")
        {
        }

    }
    assembly("System.Windows.Forms")
    {
        Version = '2.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Windows.Forms.SendKeys"; "SendKeys")
        {
        }
    }

    assembly("mscorlib")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Text.StringBuilder"; "StringBuilder2")
        {
        }
        type("System.Reflection.BindingFlags"; "BindingFlags2")
        {
        }
        type("System.Globalization.CultureInfo"; "CultureInfo2")
        {
        }

        type("System.Type"; "Type2")
        {
        }
        type("System.RuntimeTypeHandle"; "RuntimeTypeHandle2")
        {
        }

        type("System.Collections.Generic.List`1"; "List_Of_T2")
        {
        }

        type("System.IO.FileMode"; "FileMode2")
        {
        }

        type("System.Text.Encoding"; "Encoding2")
        {
        }

        type("System.Collections.IEnumerator"; "IEnumerator2")
        {
        }

        type("System.IO.Path"; "Path2")
        {
        }

        type("System.DateTime"; "DateTime2")
        {
        }

        type("System.DateTimeKind"; "DateTimeKind2")
        {
        }

        type("System.Collections.ArrayList"; "ArrayList2")
        {
        }
        type("System.IO.MemoryStream"; "MemoryStream2")
        {
        }

        type(System.IO.MemoryStream; memstr) { }
        type(System.IO.SeekOrigin; origin) { }
    }
    assembly("Microsoft.Office.Interop.Excel")
    {
        Version = '15.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = '71e9bce111e9429c';



        type("Microsoft.Office.Interop.Excel.Workbook"; "Workbook")
        {
        }

        type("Microsoft.Office.Interop.Excel.Application"; "Application")
        {
        }

        type("Microsoft.Office.Interop.Excel.ApplicationClass"; "ApplicationClass2")
        {
        }

        type("Microsoft.Office.Interop.Excel.Workbooks"; "Workbooks")

        {
        }

        type("Microsoft.Office.Interop.Excel.Worksheet"; WorkSheet2)
        {

        }


    }



    assembly("System.Xml")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';
        //System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089
        type("System.Xml.XmlDocument"; SystemXmlDocument)
        {

            //System.Xml.XmlDocument.'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'

        }
        type("System.Xml.XmlNodeList"; SystemXmlNodeList) { }
        type("System.Xml.XmlNodeType"; SystemXmlNodeType) { }
        type("System.Xml.XmlNamedNodeMap"; SystemXmlNamedNodeMap) { }
        type("System.Xml.XmlNode"; SystemNode) { }
        type("System.Xml.XmlNode"; SystemXmlNode) { }
    }

    /*
    assembly("Microsoft.Dynamics.Nav.MX")
    {
        Version = '17.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = '31bf3856ad364e35';

        type("Microsoft.Dynamics.Nav.MX.BarcodeProviders.IBarcodeProvider"; "IBarcodeProvider")
        {
        }

        type("Microsoft.Dynamics.Nav.MX.BarcodeProviders.QRCodeProvider"; "QRCodeProvider")
        {
        }
    }

    assembly("DocumentFormat.OpenXml")
    {
        Version = '2.9.1.0';
        Culture = 'neutral';
        PublicKeyToken = '8fb06cb64d019a17';


        type("DocumentFormat.OpenXml.StringValue"; "StringValue2")
        {
        }

        type("DocumentFormat.OpenXml.UInt32Value"; "UInt32Value2")
        {
        }

        type("DocumentFormat.OpenXml.BooleanValue"; "BooleanValue2")
        {
        }

        type("DocumentFormat.OpenXml.Spreadsheet.Font"; "Font2")
        {
        }

        type("DocumentFormat.OpenXml.Spreadsheet.Color"; "Color2")
        {
        }

        type("DocumentFormat.OpenXml.HexBinaryValue"; "HexBinaryValue2")
        {
        }

        type("DocumentFormat.OpenXml.Spreadsheet.Fonts"; "Fonts2")
        {
        }

        type("DocumentFormat.OpenXml.Spreadsheet.FontName"; "FontName2")
        {
        }

        type("DocumentFormat.OpenXml.Spreadsheet.FontSize"; "FontSize2")
        {
        }

        type("DocumentFormat.OpenXml.DoubleValue"; "DoubleValue2")
        {
        }

        type("DocumentFormat.OpenXml.Spreadsheet.Fill"; "Fill2")
        {
        }

        type("DocumentFormat.OpenXml.Spreadsheet.PatternFill"; "PatternFill2")
        {
        }

        type("DocumentFormat.OpenXml.OpenXmlElement"; "OpenXmlElement2")
        {
        }

        type("DocumentFormat.OpenXml.Spreadsheet.Columns"; "Columns2")
        {
        }

        type("DocumentFormat.OpenXml.Spreadsheet.Column"; "Column2")
        {
        }

        type("DocumentFormat.OpenXml.ByteValue"; "ByteValue2")
        {
        }

        type("DocumentFormat.OpenXml.Spreadsheet.OrientationValues"; "OrientationValues2")
        {
        }

        type("DocumentFormat.OpenXml.Packaging.VmlDrawingPart"; "VmlDrawingPart2")


        {
        }

        type("DocumentFormat.OpenXml.Spreadsheet.Border"; "Border2")
        {
        }

        type("DocumentFormat.OpenXml.Spreadsheet.Bold"; "Bold2")
        {
        }

        type("DocumentFormat.OpenXml.Spreadsheet.Italic"; "Italic2")
        {
        }

        type("DocumentFormat.OpenXml.Spreadsheet.Underline"; "Underline2")
        {
        }

        type("DocumentFormat.OpenXml.Spreadsheet.Worksheet"; "Worksheet0")
        {
        }


        type("DocumentFormat.OpenXml.Spreadsheet.MergeCells"; "MergeCells2")
        {
        }

        type("DocumentFormat.OpenXml.Spreadsheet.MergeCell"; "MergeCell2")
        {
        }
    }
    /* assembly("Microsoft.Dynamics.Nav.OpenXml")
     {
         Version = '17.0.0.0';
         Culture = 'neutral';
         PublicKeyToken = '31bf3856ad364e35';

         type("Microsoft.Dynamics.Nav.OpenXml.Spreadsheet.WorkbookWriter"; "WorkbookWriter2")
         {
         }

         type("Microsoft.Dynamics.Nav.OpenXml.Spreadsheet.WorkbookReader"; "WorkbookReader2")
         {
         }

         type("Microsoft.Dynamics.Nav.OpenXml.Spreadsheet.WorksheetWriter"; "WorksheetWriter2")
         {
         }

         type("Microsoft.Dynamics.Nav.OpenXml.Spreadsheet.WorksheetReader"; "WorksheetReader2")
         {
         }
         type("Microsoft.Dynamics.Nav.OpenXml.Spreadsheet.WorksheetHelper"; "WorksheetHelper2")
         {
         }


         type("Microsoft.Dynamics.Nav.OpenXml.Spreadsheet.CellDecorator"; "CellDecorator2")
         {
         }

         type("Microsoft.Dynamics.Nav.OpenXml.Spreadsheet.CellData"; "CellData2")
         {
         }
     }*/

    assembly("PdfSharp")
    {
        Version = '1.32.2608.0';
        Culture = 'neutral';
        PublicKeyToken = 'f94615aa0424f9eb';

        type("PdfSharp.Pdf.IO.PdfReader"; "PdfReader")
        {
        }

        type("PdfSharp.Pdf.PdfDocument"; "PdfDocument")
        {
        }

        type("PdfSharp.Pdf.Security.PdfSecuritySettings"; "PdfSecuritySettings")
        {
        }

        type("PdfSharp.Pdf.IO.PdfDocumentOpenMode"; "PdfDocumentOpenMode")
        {
        }
    }

    assembly("zxing")
    {
        type(ZXing.BarcodeFormat; bcformat) { }
        type(ZXing.BarcodeWriter; bcwriter) { }
        type(ZXing.Common.BitMatrix; bitmatrix) { }
        type(ZXing.Common.EncodingOptions; encopt) { }
    }
    assembly("System.Drawing")
    {
        type(System.Drawing.Bitmap; btmp) { }
        type(System.Drawing.Imaging.ImageFormat; imgfmt) { }
        type(System.Drawing.Graphics; gfx) { }
        type(System.Drawing.Color; clr) { }
    }


}
