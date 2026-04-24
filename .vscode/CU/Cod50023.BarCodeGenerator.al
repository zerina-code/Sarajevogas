codeunit 50023 "QR Code Generator"
{
    Subtype = Normal;

    procedure Generate(InputText: Text; var OutStream: OutStream)
    var
        BarcodeWriter: DotNet "bcwriter";
        BarcodeFormat: DotNet bcformat;
        Bitmap: DotNet btmp;
        MemoryStream: DotNet memstr;
        SeekOrigin: DotNet origin;
        ImageFormat: DotNet imgfmt;
        EncodingOption: DotNet encopt;
        BitMatrix: DotNet bitmatrix;
        QrCodeBitmap: DotNet btmp;
        TransparentBitmap: DotNet btmp;
        Graphics: DotNet gfx;
        Color: DotNet clr;
        x, y : integer;
    begin
        // Inicijalizacija
        BarcodeWriter := BarcodeWriter.BarcodeWriter();
        BarcodeFormat := BarcodeFormat.CODE_128;
        BarcodeWriter.Format := BarcodeFormat;

        EncodingOption := EncodingOption.EncodingOptions();
        EncodingOption.Height := 400;
        EncodingOption.Width := 800;
        BarcodeWriter.Options := EncodingOption;

        BitMatrix := BarcodeWriter.Encode(InputText);
        Bitmap := BarcodeWriter.Write(BitMatrix);

        //podesi transparentnost:
        TransparentBitmap := Bitmap.Clone();
        TransparentBitmap.MakeTransparent(Color.White);
        Graphics := Graphics.FromImage(TransparentBitmap);
        Color := Color.FromArgb(0, 255, 255, 255);

        for x := 0 to TransparentBitmap.Width - 1 do begin
            for y := 0 to TransparentBitmap.Height - 1 do begin
                if TransparentBitmap.GetPixel(x, y).ToArgb() = Color.White.ToArgb() then
                    TransparentBitmap.SetPixel(x, y, Color);
            end;
        end;

        // Spasi Bitmap u MemoryStream
        MemoryStream := MemoryStream.MemoryStream();
        ImageFormat := ImageFormat.Png;
        TransparentBitmap.Save(MemoryStream, ImageFormat);

        // Pretvori MemoryStream u OutStream
        MemoryStream.Seek(0, SeekOrigin."Begin");
        MemoryStream.CopyTo(OutStream);
    end;
}
