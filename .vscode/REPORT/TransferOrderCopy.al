report 50124 "Transfer Order Copy"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TransferOrderCopy.rdl';
    Caption = 'Transfer Order';

    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Transfer-from Code", "Transfer-to Code";
            RequestFilterHeading = 'Transfer Order';
            column(No_TransferHdr; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(ResponsibleExtName; ResponsibleExtName)
                {

                }
                column(ResponsibleExtPos; ResponsibleExtPos)
                {

                }
                column(ResponsibleExtUnit; ResponsibleExtUnit)
                {

                }
                dataitem(PageLoop; "Integer")
                {


                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column("No"; "Transfer Header"."No.")
                    {

                    }
                    column(TransferFrom; "Transfer Header"."Transfer-from Name")
                    {

                    }
                    column(TransferTo; "Transfer Header"."Transfer-to Name")
                    {

                    }
                    column(TransferOrderDate; "Transfer Header"."Receipt Date")
                    {

                    }
                    column(TodayFormatted; FORMAT(TODAY))
                    {
                    }
                    column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                    {
                    }
                    column(CopyCaption; StrSubstNo(Text001, CopyText))
                    {
                    }
                    column(TransferToAddr1; TransferToAddr[1])
                    {
                    }
                    column(TransferFromAddr1; TransferFromAddr[1])
                    {
                    }
                    column(TransferToAddr2; TransferToAddr[2])
                    {
                    }
                    column(TransferFromAddr2; TransferFromAddr[2])
                    {
                    }
                    column(TransferToAddr3; TransferToAddr[3])
                    {
                    }
                    column(TransferFromAddr3; TransferFromAddr[3])
                    {
                    }
                    column(TransferToAddr4; TransferToAddr[4])
                    {
                    }
                    column(TransferFromAddr4; TransferFromAddr[4])
                    {
                    }
                    column(TransferToAddr5; TransferToAddr[5])
                    {
                    }
                    column(TransferToAddr6; TransferToAddr[6])
                    {
                    }

                    column(InTransitCode_TransHdr; "Transfer Header"."In-Transit Code")
                    {
                        IncludeCaption = true;
                    }
                    column(PostingDate_TransHdr; "Transfer Header"."Posting Date")
                    {
                    }
                    column(TransferToAddr7; TransferToAddr[7])
                    {
                    }
                    column(TransferToAddr8; TransferToAddr[8])
                    {
                    }
                    column(TransferFromAddr5; TransferFromAddr[5])
                    {
                    }
                    column(TransferFromAddr6; TransferFromAddr[6])
                    {
                    }
                    column(PageCaption; StrSubstNo(Text002, ''))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(ShptMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Transfer Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(Number_DimensionLoop1; Number)
                        {
                        }
                        column(HdrDimensionsCaption; HdrDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FindSet then
                                    CurrReport.Break();
                            end else
                                if not Continue then
                                    CurrReport.Break();

                            Clear(DimText);
                            Continue := false;
                            repeat
                                OldDimText := DimText;
                                if DimText = '' then
                                    DimText := StrSubstNo('%1 - %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText :=
                                      StrSubstNo(
                                        '%1; %2 - %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                end;
                            until DimSetEntry1.Next = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then
                                CurrReport.Break();
                        end;
                    }
                    dataitem("Transfer Line"; "Transfer Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Transfer Header";
                        DataItemTableView = SORTING("Document No.", "Line No.") WHERE("Derived From Line No." = CONST(0));
                        column(ItemNo_TransLine; "Item No.")
                        {
                            IncludeCaption = true;
                        }
                        column(Desc_TransLine; Description)
                        {
                            IncludeCaption = true;
                        }
                        column(Qty_TransLine; Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(UOM_TransLine; "Unit of Measure")
                        {
                            IncludeCaption = true;
                        }
                        column(Qty_TransLineShipped; "Quantity Shipped")
                        {
                            IncludeCaption = true;
                        }
                        column(QtyReceived_TransLine; "Quantity Received")
                        {
                            IncludeCaption = true;
                        }
                        column(TransFromBinCode_TransLine; "Transfer-from Bin Code")
                        {
                            IncludeCaption = true;
                        }
                        column(TransToBinCode_TransLine; "Transfer-To Bin Code")
                        {
                            IncludeCaption = true;
                        }
                        column(LineNo_TransLine; "Line No.")
                        {
                        }
                        column(RowCounter; RowCounter) { }
                        column(RowCounterInWords; RowCounterInWords) { }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(DimText2; DimText)
                            {
                            }
                            column(Number_DimensionLoop2; Number)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FindSet then
                                        CurrReport.Break();
                                end else
                                    if not Continue then
                                        CurrReport.Break();

                                Clear(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := StrSubstNo('%1 - %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText :=
                                          StrSubstNo(
                                            '%1; %2 - %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until DimSetEntry2.Next = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.Break();
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            DimSetEntry2.SetRange("Dimension Set ID", "Dimension Set ID");
                            RowCounter += 1;
                            LastRowCounter := RowCounter;
                            RowCounterInWords := NumberToWords(LastRowCounter);
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    Location.reset();
                    Location.SetFilter("Code", '%1', "Transfer Header"."Transfer-from Code");
                    //     Location.SetFilter("Responsible Person Exit Position", '%1', "Transfer Shipment Header"."Responsible Person Exit Position");
                    //    Location.SetFilter("Responsible Person Exit Unit", '%1', "Transfer Shipment Header"."Responsible Person Exit Unit");
                    if Location.FindFirst() then begin
                        // if "Transfer-from Code" = "Transfer Shipment Line"."Transfer-from Code" then begin
                        ResponsibleExtName := location."Responsible Person Exit Name";
                        ResponsibleExtPos := location."Responsible Person E Position";
                        ResponsibleExtUnit := location."Responsible Person Exit Unit";

                        //   end;
                    end;
                    if Number > 1 then begin
                        CopyText := Text000;
                        OutputNo += 1;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");
                FormatAddr.TransferHeaderTransferFrom(TransferFromAddr, "Transfer Header");
                FormatAddr.TransferHeaderTransferTo(TransferToAddr, "Transfer Header");

                if not ShipmentMethod.Get("Shipment Method Code") then
                    ShipmentMethod.Init();
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                RowCounter := 0;
                LastRowCounter := 0;
                RowCounterInWords := '';
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Location;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = Location;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if you want the printed report to show information that is only for internal use.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        PostingDateCaption = 'Posting Date';
        ShptMethodDescCaption = 'Shipment Method';
    }

    procedure NumberToWords(Number: Integer): Text
    var
        Units: array[9] of Text[20];
        Teens: array[9] of Text[20];
        Tens: array[9] of Text[20];
        Hundreds: array[9] of Text[20];
        Thousands: array[9] of Text[30];
        ResultText: Text[1024];
        UnitPart: Integer;
        TeenPart: Integer;
        TenPart: Integer;
        HundredPart: Integer;
        ThousandPart: Integer;
    begin
        //Inicijalizacija nizova:
        Units[1] := 'jedan';
        Units[2] := 'dva';
        Units[3] := 'tri';
        Units[4] := 'četiri';
        Units[5] := 'pet';
        Units[6] := 'šest';
        Units[7] := 'sedam';
        Units[8] := 'osam';
        Units[9] := 'devet';

        Teens[1] := 'jedanaest';
        Teens[2] := 'dvanaest';
        Teens[3] := 'trinaest';
        Teens[4] := 'četrnaest';
        Teens[5] := 'petnaest';
        Teens[6] := 'šesnaest';
        Teens[7] := 'sedamnaest';
        Teens[8] := 'osamnaest';
        Teens[9] := 'devetnaest';

        Tens[1] := 'deset';
        Tens[2] := 'dvadeset';
        Tens[3] := 'trideset';
        Tens[4] := 'četrdeset';
        Tens[5] := 'pedeset';
        Tens[6] := 'šezdeset';
        Tens[7] := 'sedamdeset';
        Tens[8] := 'osamdeset';
        Tens[9] := 'devedeset';

        Hundreds[1] := 'sto';
        Hundreds[2] := 'dvije stotine';
        Hundreds[3] := 'tri stotine';
        Hundreds[4] := 'četiri stotine';
        Hundreds[5] := 'pet stotina';
        Hundreds[6] := 'šest stotina';
        Hundreds[7] := 'sedam stotina';
        Hundreds[8] := 'osam stotina';
        Hundreds[9] := 'devet stotina';

        Thousands[1] := 'hiljadu';
        Thousands[2] := 'dvije hiljade';
        Thousands[3] := 'tri hiljade';
        Thousands[4] := 'četiri hiljade';
        Thousands[5] := 'pet hiljada';
        Thousands[6] := 'šest hiljada';
        Thousands[7] := 'sedam hiljada';
        Thousands[8] := 'osam hiljada';
        Thousands[9] := 'devet hiljada';

        // Provjeri 0
        if Number = 0 then
            exit('Nula');

        // Procesiraj hiljade
        ThousandPart := Number DIV 1000;
        if ThousandPart > 0 then begin
            ResultText := Thousands[ThousandPart] + ' ';
            Number := Number MOD 1000;
        end;

        // Procesiraj stotinjke
        HundredPart := Number DIV 100;
        if HundredPart > 0 then begin
            ResultText := ResultText + Hundreds[HundredPart] + ' ';
            Number := Number MOD 100;
        end;

        // Procesiraj desetice i jedinice
        TenPart := Number DIV 10;
        UnitPart := Number MOD 10;

        // Specijalni slučajevi za 11-19
        if (TenPart = 1) and (UnitPart > 0) then
            exit(ResultText + Teens[UnitPart]);

        if TenPart = 1 then
            exit(ResultText + Tens[TenPart]);

        if TenPart > 0 then
            ResultText := ResultText + Tens[TenPart];

        if (TenPart > 0) and (UnitPart > 0) then
            ResultText := ResultText + ' i ';

        if UnitPart > 0 then
            ResultText := ResultText + Units[UnitPart];

        exit(ResultText);
    end;

    var
        ResponsibleExtName: Text[150];
        ResponsibleExtPos: Text[150];
        ResponsibleExtUnit: Text[150];
        CurrReportPageNoCaptionLbl: Label 'Page';
        Text000: Label 'COPY';
        Text001: Label 'Transfer Order %1';
        Text002: Label 'Page %1';
        ShipmentMethod: Record "Shipment Method";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        FormatAddr: Codeunit "Format Address";
        TransferFromAddr: array[8] of Text[100];
        TransferToAddr: array[8] of Text[100];
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        OutputNo: Integer;
        HdrDimensionsCaptionLbl: Label 'Header Dimensions';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        location: Record Location;
        RowCounter: Integer;
        LastRowCounter: Integer;
        RowCounterInWords: Text;
}

