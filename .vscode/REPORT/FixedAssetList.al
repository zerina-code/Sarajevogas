report 50180 FixedAssetList
{
    DefaultLayout = RDLC;
    RDLCLayout = './Fixed Asset - List.rdl';
    Caption = 'Fixed Asset - List';

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "FA Class Code", "FA Subclass Code", "Budgeted Asset";
            column(CompanyName; COMPANYNAME)
            {
            }
            column(DeprBookText; DeprBookText)
            {
            }
            column(FATableCaptionFAFilter; TABLECAPTION + ': ' + FAFilter)
            {
            }
            column(FAFilter; FAFilter)
            {
            }
            column(FANo; "No.")
            {
                IncludeCaption = true;
            }
            column(FADesc; Description)
            {
                IncludeCaption = true;
            }
            column(FAMainAssetComponent; "Main Asset/Component")
            {
            }
            column(BudgetedAssetFieldname; BudgetedAssetFieldname)
            {
            }
            column(FASerialNo; "Serial No.")
            {
            }
            column(FAComponentofMainAsset; "Component of Main Asset")
            {
            }
            column(ComponentFieldname; ComponentFieldname)
            {
            }
            column(FAGlobalDim1Code; "Global Dimension 1 Code")
            {
            }
            column(FAGlobalDim2Code; "Global Dimension 2 Code")
            {
            }
            column(FAClassCode; "FA Class Code")
            {
                IncludeCaption = true;
            }
            column(FASubclassCode; "FA Subclass Code")
            {
                IncludeCaption = true;
            }
            column(FALocationCode; LocDesc)
            {
                IncludeCaption = false;
            }
            column(EmployeeObligation; EmployeeObligation)
            {
                IncludeCaption = false;
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(FAListCaption; FAListCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(rbr; rbr)
            {
            }
            column(ReportDate; TODAY)
            {
            }
            column(OldNo; "Old No.")
            {
                IncludeCaption = true;
            }
            dataitem(DataItem2285; "FA Depreciation Book")
            {
                DataItemTableView = SORTING("FA No.", "Depreciation Book Code");
                column(FADeprBookDeprMethod; "Depreciation Method")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookDeprStartingDate; FORMAT("Depreciation Starting Date"))
                {
                }
                column(FADeprBookFAPostingGroup; "FA Posting Group")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookStraightLine; "Straight-Line %")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookNoofDeprYrs; "No. of Depreciation Years")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookNoofDeprMonths; "No. of Depreciation Months")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookDeprEndingDate; FORMAT("Depreciation Ending Date"))
                {
                }
                column(FADeprBookFixedDeprAmt; "Fixed Depr. Amount")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookDecliningBalance; "Declining-Balance %")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookDeprTableCode; "Depreciation Table Code")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookUserDefinedDeprDt; FORMAT("First User-Defined Depr. Date"))
                {
                }
                column(FADeprBookFinalRoundingAmt; "Final Rounding Amount")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookEndingBookValue; "Ending Book Value")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookFAExchangeRate; "FA Exchange Rate")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookUseFALedgCheck; "Use FA Ledger Check")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookDeprbelowZero; "Depr. below Zero %")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookFDeprAmtbelowZero; "Fixed Depr. Amount below Zero")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookProjProceedDspsl; "Projected Proceeds on Disposal")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookProjDisposalDate; FORMAT("Projected Disposal Date"))
                {
                }
                column(FADeprBookStartingDateCustom; FORMAT("Depr. Starting Date (Custom 1)"))
                {
                }
                column(FADeprBookAccumDeprCustom; "Accum. Depr. % (Custom 1)")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookThisYrCustom; "Depr. This Year % (Custom 1)")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookEndingDateCustom; FORMAT("Depr. Ending Date (Custom 1)"))
                {
                }
                column(FADeprBookPropertyClassCustom; "Property Class (Custom 1)")
                {
                    IncludeCaption = true;
                }
                column(FADeprBookDeprStartDateCaption; FADeprBookDeprStartDateCaptionLbl)
                {
                }
                column(FADeprBookDeprEndDateCaption; FADeprBookDeprEndDateCaptionLbl)
                {
                }
                column(FADeprBookUsrDfndDeprDtCaption; FADeprBookUsrDfndDeprDtCaptionLbl)
                {
                }
                column(FADeprBookProjDisplDateCaption; FADeprBookProjDisplDateCaptionLbl)
                {
                }
                column(FADeprBookStartDateCustomCaption; FADeprBookStartDateCustomCaptionLbl)
                {
                }
                column(FADeprBookEndDateCustomCptn; FADeprBookEndDateCustomCptnLbl)
                {
                }
                column(FAValue; FAValue)
                {
                }

                trigger OnPreDataItem()
                begin
                    SETRANGE("FA No.", "Fixed Asset"."No.");
                    SETRANGE("Depreciation Book Code", DeprBookCode);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*IF Inactive THEN
                     CurrReport.SKIP;*/
                IF "Main Asset/Component" <> "Main Asset/Component"::" " THEN
                    ComponentFieldname := FIELDCAPTION("Component of Main Asset")
                ELSE
                    ComponentFieldname := '';
                IF "Budgeted Asset" THEN
                    BudgetedAssetFieldname := FIELDCAPTION("Budgeted Asset")
                ELSE
                    BudgetedAssetFieldname := '';
                IF "Serial No." <> '' THEN
                    SerialNoFieldname := FIELDCAPTION("Serial No.")
                ELSE
                    SerialNoFieldname := '';
                IF PrintOnlyOnePerPage THEN
                    PageGroupNo := PageGroupNo + 1;
                MainAssetComponent := "Main Asset/Component";
                rbr += 1;


                IF FALoc.GET("FA Location Code") THEN
                    LocDesc := FALoc.Name
                ELSE
                    LocDesc := '';

                /* IF EObligatins.GET("R.Employee Obligation") then
                     EmployeeObligation := EObligatins."Responsible Person Name"
                 ELSE
                     EmployeeObligation := '';*/

                EObligatins.Reset();
                EObligatins.SetFilter("No.", '%1', "No.");
                EObligatins.SetFilter("Location Name", LocDesc);
                IF EObligatins.FindFirst() THEN
                    EmployeeObligation := EObligatins."Responsible Person Name"
                ELSE
                    EmployeeObligation := '';




                FALE.RESET;
                FALE.SetFilter("FA No.", '%1', "Fixed Asset"."No.");
                IF FALE.FindFirst() then
                    repeat
                        FAValue += FALE.Amount;
                    until FALE.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
                rbr := 0;
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
                    field(DeprBookCode; DeprBookCode)
                    {
                        Caption = 'Depreciation Book';
                        TableRelation = "Depreciation Book";
                    }
                    field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
                    {
                        Caption = 'New Page per Asset';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF DeprBookCode = '' THEN BEGIN
                FASetup.GET;
                DeprBookCode := FASetup."Default Depr. Book";
            END;
        end;
    }

    labels
    {
        EntryNo = 'Entry No';
        Qty = 'Quantity';
        MEmbers = 'Members:';
    }

    trigger OnPreReport()
    begin
        DeprBook.GET(DeprBookCode);
        FAFilter := "Fixed Asset".GETFILTERS;
        DeprBookText := STRSUBSTNO('%1%2 %3', DeprBook.TABLECAPTION, ':', DeprBookCode);
    end;

    var
        FASetup: Record 5603;
        DeprBook: Record 5611;
        PrintOnlyOnePerPage: Boolean;
        DeprBookCode: Code[10];
        FAFilter: Text;
        ComponentFieldname: Text[100];
        BudgetedAssetFieldname: Text[100];
        SerialNoFieldname: Text[100];
        DeprBookText: Text[50];
        PageGroupNo: Integer;
        MainAssetComponent: Integer;
        FAListCaptionLbl: Label 'Fixed Asset - List';
        CurrReportPageNoCaptionLbl: Label 'Page';
        FADeprBookDeprStartDateCaptionLbl: Label 'Depreciation Starting Date';
        FADeprBookDeprEndDateCaptionLbl: Label 'Depreciation Ending Date';
        FADeprBookUsrDfndDeprDtCaptionLbl: Label 'First User-Defined Depr. Date';
        FADeprBookProjDisplDateCaptionLbl: Label 'Projected Disposal Date';
        FADeprBookStartDateCustomCaptionLbl: Label 'Depr. Starting Date (Custom 1)';
        FADeprBookEndDateCustomCptnLbl: Label 'Depr. Ending Date (Custom 1)';
        rbr: Integer;
        FALoc: Record 5609;
        LocDesc: Text;
        FALE: record "FA Ledger Entry";
        FAValue: Decimal;
        EmployeeObligation: Text;
        EObligatins: Record Obligation;
}

