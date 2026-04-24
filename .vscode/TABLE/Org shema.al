table 50114 "ORG Shema"
{
    Caption = 'ORG Shema';
    DrillDownPageID = "ORG Shema";
    LookupPageID = "ORG Shema";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Version Code"; Code[20])
        {
            Caption = 'Version Code';
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(10; "Date From"; Date)
        {
            Caption = 'Date From';

            trigger OnValidate()
            begin
                ABsFill.ValidateDate("Date From", "Date To");



                IF "Date From" >= TODAY THEN BEGIN
                    Status := Status::Preparation;
                    "Create date of org.prep" := TODAY;
                    OrgShema.SETFILTER(Status, '%1', 0);
                    IF OrgShema.FINDFIRST THEN BEGIN
                        OrgShema."Date To" := "Date From" - 1;

                        OrgShema.MODIFY;
                    END;
                END;
            end;
        }
        field(21; "Date To"; Date)
        {
            Caption = 'Date To';

            trigger OnValidate()
            var
                Item: Record "Item";
                ItemUnitOfMeasure: Record "Item Unit of Measure";
            begin
                ABsFill.ValidateDate("Date From", "Date To");
                /*IF (Status = Status::Blocked) AND ("Date To" <> xRec."Date To") THEN
                  FIELDERROR(Status);
                Item.SETRANGE("Production BOM No.",Code);
                IF Item.FINDSET THEN
                  REPEAT
                    ItemUnitOfMeasure.GET(Item."No.","Date To");
                  UNTIL Item.NEXT = 0;*/

            end;
        }
        field(22; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(45; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Active,Blocked,Preparation';
            OptionMembers = Active,Blocked,Preparation;

            trigger OnValidate()
            var
                //  ProdBOMHeader: Record "Institution/Company";
                //    PlanningAssignment: Record "Total Staff";
                ProdBOMCheck: Codeunit "Production BOM-Check";
            begin
                /*IF (Status <> xRec.Status) AND (Status = Status::Blocked) THEN BEGIN
                  ProdBOMCheck.ProdBOMLineCheck(Code,"Version Code");
                  TESTFIELD("Date To");
                  ProdBOMHeader.GET(Code);
                  ProdBOMHeader."Low-Level Code" := 0;
                  ProdBOMCheck.Code(ProdBOMHeader,"Version Code");
                  PlanningAssignment.NewBOM(Code);
                END;
                MODIFY(TRUE);
                COMMIT;*/

                IF Status = 2 THEN BEGIN
                    OrgShema.SETFILTER(Status, '%1', 0);
                    IF OrgShema.FINDFIRST THEN BEGIN
                        OrgShema."Date To" := "Date From" - 1;
                        OrgShema.MODIFY;
                    END;
                END;

            end;
        }
        field(50; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                ////
            end;
        }
        field(50000; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(50001; "Change Org"; Boolean)
        {
        }
        field(50002; "Change Dimension"; Boolean)
        {
        }
        field(50003; "Sent Mail Systematization"; Boolean)
        {
        }
        field(50004; "Create date of org.prep"; Date)
        {
        }
        field(50005; "Operator No."; Code[40])
        {
            Caption = 'Operator No.';

            trigger OnValidate()
            begin

                /*IF "Operator No." <> xRec."Operator No." THEN BEGIN
                  HRSetup.GET;
                  NoSeriesMgt.TestManual(HRSetup."Operator Nos.");
                
                END;*/
                "Operator No." := USERID;

            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
    //ĐK    ProdBOMLine: Record "Comission Members";
    begin
        /*ProdBOMLine.SETRANGE("Production BOM No.",Code);
        ProdBOMLine.SETRANGE("Version Code","Version Code");
        ProdBOMLine.DELETEALL(TRUE);
        */

    end;

    trigger OnInsert()
    begin
        /*ProdBOMHeader.GET(Code);
        IF "Version Code" = '' THEN BEGIN
          ProdBOMHeader.TESTFIELD("Version Nos.");
          NoSeriesMgt.InitSeries(ProdBOMHeader."Version Nos.",xRec."No. Series",0D,"Version Code","No. Series");
        END;*/

    end;

    trigger OnModify()
    begin
        //"Last Date Modified" := TODAY;
    end;

    trigger OnRename()
    begin
        /*IF Status = Status::Blocked THEN
          ERROR(Text001,TABLECAPTION,FIELDCAPTION(Status),FORMAT(Status));*/

    end;

    var
        //  ProdBOMHeader: Record "Institution/Company";
        ProdBOMVersion: Record "ORG Shema";
        ABsFill: Codeunit "Absence Fill";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        Text001: Label 'You cannot rename the %1 when %2 is %3.';
        OrgShema: Record "ORG Shema";

    procedure AssistEdit(OldProdBOMVersion: Record "ORG Shema"): Boolean
    begin
        /*WITH ProdBOMVersion DO BEGIN
          ProdBOMVersion := Rec;
          ProdBOMHeader.GET(Code);
          ProdBOMHeader.TESTFIELD("Version Nos.");
          IF NoSeriesMgt.SelectSeries(ProdBOMHeader."Version Nos.",OldProdBOMVersion."No. Series","No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries("Version Code");
            Rec := ProdBOMVersion;
            EXIT(TRUE);
          END;
        END;*/

    end;

    procedure Caption(): Text[100]
    var
    //   ProdBOMHeader: Record "Institution/Company";
    begin
        /*IF GETFILTERS = '' THEN
          EXIT('');
        
        IF NOT ProdBOMHeader.GET(Code) THEN
          EXIT('');
        
        EXIT(
          STRSUBSTNO('%1 %2 %3',
            Code,ProdBOMHeader.Description,"Version Code"));*/

    end;
}

