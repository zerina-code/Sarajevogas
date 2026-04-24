pageextension 50037 FixedList extends "Fixed Asset List"
{
    layout
    {
        // Add changes to page layout here
        modify(Acquired)
        {
            Visible = false;
        }
        modify("No.")
        {
            Visible = true;
            Caption = 'Inventory number';
        }


        addafter("No.")
        {
            field("Serial No."; "Serial No.") { }
            field(Mark; Mark) { }
            field(Street; Street) { }
            field("Street Name"; "Street Name") { }
            field("Home No."; "Home No.") { }
            field(Address; Address) { }
            field("Municipality Code"; "Municipality Code") { }
            field("Municipality Name"; "Municipality Name") { }
            field(MZ; MZ) { }
            field("MZ Name"; "MZ Name") { }
        }
        addafter("Serial No.")
        {
            field("Class Code"; "Class Code") { }
        }
        addafter("Class Code")
        {
            field("Group Code"; "Group Code") { }
        }
        addafter("Group Code")
        {
            field(Subgroup; Subgroup) { }
        }
        addafter(Subgroup)
        {
            field("SS number"; "SS number") { }

        }
        addafter("SS number")
        {


            field("Purchase Value"; "Purch. value") { }

        }


        addafter("FA Location Code")
        {
            field("FA Posting Date"; "FA Posting Date")
            {
                ApplicationArea = all;
                DrillDown = true;
                trigger OnDrillDown()
                var
                    OrderNO: Integer;
                begin
                    FALedgerEntry.Reset();
                    FALedgerEntry.SetFilter("FA No.", '%1', "No.");
                    FALedgerEntry.SetFilter("Part of Book Value", '%1', true);
                    FALedgerEntry.SetFilter("Depreciation Book Code", '%1', 'AMORT');
                    FALedgerEntry.SetFilter("FA Posting Type", '%1', FALedgerEntry."FA Posting Type"::"Acquisition Cost");
                    FALedgerEntry.SetCurrentKey("FA Posting Date");
                    Ascending;
                    OrderNO := 0;
                    if FALedgerEntry.FINDSET then
                        repeat
                            if (FALedgerEntry."Entry No." < OrderNO) or (OrderNO = 0) then
                                OrderNO := FALedgerEntry."Entry No.";
                        until FALedgerEntry.NEXT = 0;
                    FALedgerEntry.SetFilter("Entry No.", '%1', OrderNO);

                    FALedgerEntries.SetTableView(FALedgerEntry);
                    FALedgerEntries.Run();
                    CurrPage.Update();
                end;
            }

            field("Activation Date"; "Activation Date") { }
            field("FA Depreciation Date"; "FA Depreciation Date") { ApplicationArea = all; }
            field("Posted Whse. Receipt Line."; "Posted Whse. Receipt Line.")
            {
                Editable = false;
                trigger OnDrillDown()
                var
                    myInt: Integer;
                    PW: Record "Posted Whse. Receipt Line";
                    PWPage: Page "Posted Whse. Receipt";
                    PHeader: Record "Posted Whse. Receipt Header";
                begin
                    pw.Reset();
                    pw.SetFilter("Item No.", '%1', "No.");
                    pw.SetCurrentKey("Posting Date");
                    PW.Ascending;
                    if pw.FindLast() then begin
                        PHeader.Reset();
                        PHeader.SetFilter("No.", '%1', pw."No.");
                        if PHeader.findfirst then begin
                            PWPage.SetTableView(PHeader);
                            PWPage.Run();
                        end;
                    end;


                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    myInt: Integer;
                    PW: Record "Posted Whse. Receipt Line";
                    PWPage: Page "Posted Whse. Receipt";
                    PHeader: Record "Posted Whse. Receipt Header";
                begin
                    pw.Reset();
                    pw.SetFilter("Item No.", '%1', "No.");
                    pw.SetCurrentKey("Posting Date");
                    PW.Ascending;
                    if pw.FindLast() then begin
                        PHeader.Reset();
                        PHeader.SetFilter("No.", '%1', pw."No.");
                        if PHeader.findfirst then begin
                            PWPage.SetTableView(PHeader);
                            PWPage.Run();
                        end;
                    end;


                end;

            }
        }


        addafter(Subgroup)
        {
            field("FA Posting Group"; "FA Posting Group")
            {
                trigger OnDrillDown()
                var
                    GLE: Record "G/L Entry";
                    PageGLE: page "General Ledger Entries";
                begin

                    GLE.Reset();
                    GLE.SetFilter("G/L Account No.", '%1', Rec."FA Posting Group");
                    GLE.SetFilter("Source No.", '%1', Rec."No.");
                    if GLE.FindSet() then begin
                        PageGLE.SetTableView(GLE);
                        PageGLE.run;
                    end;
                end;
            }
        }

    }

    actions
    {
        addafter("Fixed Assets List")
        {
            action("Fixed Assets List-list")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Fixed Assets List-lis';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report FixedAssetList;
                ToolTip = 'View the list of fixed assets that exist in the system .';

            }
        }

        /* addafter("C&opy Fixed Asset")
         {
             action("Import FA Groups")
             {
                 ApplicationArea = All;
                 Caption = 'Import FA Groups', Comment = 'Importuj grupe';
                 Image = ImportCodes;
                 Promoted = true;
                 PromotedCategory = Process;
              
                     ImportFA: XmlPort "Import FA groups";
                 begin
                     ImportFA.RUN();
                 end;
             }

         }*/

        addafter("C&opy Fixed Asset")
        {
            action("Delete FA")
            {
                ApplicationArea = All;
                Caption = 'Delete FA', Comment = 'Obriši FA';
                Image = ImportCodes;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    FA: Record "Fixed Asset";
                    FADB: Record "FA Depreciation Book";
                begin
                    FA.DELETEALL;
                    FADB.DELETEALL;
                end;
            }

        }

        addafter("C&opy Fixed Asset")
        {
            action("Set Depreciation Date")
            {
                Caption = 'Set Depreciation Date';
                Image = FixedAssets;
                ApplicationArea = all;
                PromotedIsBig = true;
                Promoted = true;

                trigger OnAction()
                var
                    FAReport: Report "FA Report";


                begin
                    FAReport.RUN;
                end;
            }

        }
        addafter("Set Depreciation Date")
        {
            action("Import KnjGrOS")
            {
                ApplicationArea = All;
                Caption = 'Import KnjGrOS', Comment = 'Importuj knj. grupe';
                Image = ImportCodes;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ImportFA: XmlPort "Import knj.gr.os.";
                begin
                    ImportFA.RUN();
                end;
            }

        }
        addafter("Import KnjGrOS")
        {
            action("Import Description")
            {
                ApplicationArea = All;
                Caption = 'Import Description', Comment = 'Importuj opise';
                Image = ImportCodes;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ImportDesc: XmlPort "Import CGS Description";
                begin
                    ImportDesc.RUN();
                end;
            }
            action("Validate Employee")
            {
                ApplicationArea = All;
                Caption = 'Validacija', Comment = 'Validacija';
                Image = ImportCodes;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ImportFA: XmlPort "FA Import";
                begin
                    // Obl.SETFILTER("Employee No.", '<>%1', '');
                    // IF Obl.FindFirst() then
                    //    Obl.VALIDATE("Employee No.", Obl."Employee No.");
                    ImportFA.RUN();

                end;
            }


        }
    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CalcFields("MZ Name", "Street Name", "Municipality Name", "Posted Whse. Receipt Line.");

    end;

    trigger OnOpenPage()
    var
        BrojStavke: Integer;

    begin
        CalcFields("MZ Name", "Street Name", "Municipality Name", "Posted Whse. Receipt Line.");
        SETFilter("Disposed Of", '%1', 0D);
        BrojStavke := 0;
        //R  
        FALedgerEntry.Reset();
        FALedgerEntry.SetFilter("FA No.", '%1', "No.");
        FALedgerEntry.SetFilter("Part of Book Value", '%1', true);
        FALedgerEntry.SetFilter("Depreciation Book Code", '%1', 'AMORT');
        FALedgerEntry.SetFilter("FA Posting Type", '%1', FALedgerEntry."FA Posting Type"::"Acquisition Cost");
        FALedgerEntry.SetCurrentKey("FA Posting Date");
        Ascending;

        if FALedgerEntry.FindFirst() then begin
            BrojStavke := FALedgerEntry."Entry No.";
            "FA Posting Date" := FALedgerEntry."FA Posting Date";
        end
        else begin
            BrojStavke := 0;
            "FA Posting Date" := 0D;
        end;

        // permissions-EK
        /*US.Reset();
        US.SetFilter("User ID", '%1', USERID);
        //  US.SetFilter(US.MM_UGI_OS, '%1', false);
        if US.FindFirst() then begin
            CanModify := US.MM_UGI_OS;
            if CanModify then begin
                FILTERGROUP(2);
                // set your filter here
              //  SetFilter("Veichle Type",'<>%1', "Veichle Type"::" ");
                // SetFilter("Gas Station Type", '<>''');
              //  SetFilter(veic);
              SetFilter("Veichle Type",'<>%1',"Veichle Type"::" ");
SetFilter("Gas Station Type",'<>%1','');

                FILTERGROUP(0);
            end;
        end;*/



    end;






    var
        myInt: Integer;
        FALedgerEntry: Record "FA Ledger Entry";
        FALedgerEntries: Page "FA Ledger Entries";
        US: Record "User Setup";
        CanModify: Boolean;
        UserPersonalization: Record "User Personalization";
        IsBookkeeper: Boolean;
        CanModify1: Boolean;
}