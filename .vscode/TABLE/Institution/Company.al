table 50090 "Institution/Company"
{
    Caption = 'Institution/Company';
    DataCaptionFields = "No.", Description;
    LookupPageID = "Institutions/Companies";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    HRSetup.GET;
                    NoSeriesMgt.TestManual(HRSetup."Institution Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(10; Description; Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                "Search Name" := Description;
            end;
        }
        field(11; "Description 2"; Text[250])
        {
            Caption = 'Description 2';
        }
        field(12; "Search Name"; Code[250])
        {
            Caption = 'Search Name';
        }
        field(21; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure";

            trigger OnValidate()
            var
                Item: Record "Item";
                ItemUnitOfMeasure: Record "Item Unit of Measure";
            begin
            end;
        }
        field(22; "Low-Level Code"; Integer)
        {
            Caption = 'Low-Level Code';
            Editable = false;
        }
        field(25; Comment; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Vocation" WHERE("Table Name" = CONST("Production BOM Header"),
                                                "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;

        }
        field(40; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
        }
        field(43; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(45; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'New,Certified,Under Development,Closed';
            OptionMembers = New,Certified,"Under Development",Closed;

            trigger OnValidate()
            var
                //ĐK PlanningAssignment: Record "Total Staff";
                MfgSetup: Record "Manufacturing Setup";
                ProdBOMCheck: Codeunit "Production BOM-Check";
            begin
            end;
        }
        field(50; "Version Nos."; Code[10])
        {
            Caption = 'Version Nos.';
            TableRelation = "No. Series";
        }
        field(51; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50002; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Education,Certification';
            OptionMembers = Education,Certification;
        }
    }

    keys
    {
        key(Key1; "No.", Description)
        {
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Description, "No.")
        {
        }
    }

    trigger OnDelete()
    begin

        MfgComment.SETRANGE("Table Name", MfgComment."Table Name"::"Production BOM Header");
        MfgComment.SETRANGE("No.", "No.");
        MfgComment.DELETEALL;
    end;

    trigger OnInsert()
    begin

        IF "No." = '' THEN BEGIN
            HRSetup.GET;
            HRSetup.TESTFIELD("Institution Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Institution Nos.", HRSetup."Institution Nos.", 0D, "No.", HRSetup."Institution Nos.");
        END;


        "Creation Date" := TODAY;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
    end;

    trigger OnRename()
    begin
        IF Status = Status::Certified THEN
            ERROR(Text002, TABLECAPTION, FIELDCAPTION(Status), FORMAT(Status));
    end;

    var
        Text000: Label 'This Production BOM is being used on Items.';
        Text001: Label 'All versions attached to the BOM will be closed. Close BOM?';
        MfgSetup: Record "Manufacturing Setup";
        Item: Record "Item";
        ProdBOMHeader: Record "Institution/Company";
        ProdBOMVersion: Record "ORG Shema";
        //ĐK   ProdBOMLine: Record "Comission Members";
        MfgComment: Record "Vocation";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Text002: Label 'You cannot rename the %1 when %2 is %3.';
        HRSetup: Record "Human Resources Setup";
        Profession: Record "Profession";

    procedure AssistEdit(OldProdBOMHeader: Record "Institution/Company"): Boolean
    begin
    end;
}

