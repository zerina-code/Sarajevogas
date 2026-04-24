table 50171 "Plan RN"

{
    Caption = 'Plan RN';
    DrillDownPageID = "Plan Page";
    LookupPageID = "Plan Page";


    fields
    {
        field(1; Code; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';

        }

        field(2; Year; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Year';

        }
        field(3; "Activity Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Standard Text".Code;
            Caption = 'Activity Code';

            trigger OnValidate()
            var
                myInt: Integer;
                ST: Record "Standard Text";
            begin
                ST.Reset();
                st.SetFilter(Code, '%1', "Activity Code");
                if st.FindFirst() then begin
                    "Activity Name" := st.Description

                end
                else begin
                    "Activity Name" := '';
                end;

            end;

        }
        field(4; "Activity Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Activity Name';

        }
        field(6; "Realised"; Decimal)
        {
            Caption = 'Realised Value';
            FieldClass = FlowField;
            CalcFormula = sum("Service Line"."Quantity RN" where("Posting Date" = field("Plan Filter"), "RN Type" = filter(0), "No." = field("Activity Code"), Description = field("Activity Name")));

        }
        field(5; "Plan Value"; Decimal)
        {
            Caption = 'Plan Value';

        }
        field(7; "Plan Filter"; Date)
        {
            Caption = 'Plan Filter';
            FieldClass = FlowFilter;

        }

    }

    keys
    {
        key(Code; Year, "Activity Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}