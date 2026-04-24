tableextension 50015 Contact extends Contact
{
    fields
    {
        // Add changes to table fields here
        field(70001; "EU Activity"; text[250])
        {
            Caption = 'EU Activity';
            TableRelation = "MM Activity".Description where(Type = const(EU));
            DataClassification = CustomerContent;
        }
        field(50100; "Municipality Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Municipality Code';
            TableRelation = Municipality.Code where(Type = filter(Regular));
            trigger OnValidate()
            begin
                OnValidateMunicipality();
            end;
        }
        field(50101; "Municipality Name"; Text[250])
        {
            Caption = 'Municipality Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("Municipality Code"), Type = filter(Regular)));
            Editable = false;
        }

        field(50102; "MZ"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Local Community';
            TableRelation = MZ.Code;
        }
        field(50103; "MZ Name"; Text[250])
        {
            Caption = 'MZ Name';
            FieldClass = FlowField;
            CalcFormula = lookup(MZ.Description where(Code = field("MZ")));
            Editable = false;
        }

        field(50104; "Street"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Street';
            TableRelation = Street.Code;
            trigger OnValidate()
            begin
                OnValidateStreet();
            end;
        }

        field(50105; "Street Name"; Text[250])
        {
            Caption = 'Street Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Street.Description where(Code = field("Street")));
            Editable = false;
        }
        field(50109; "Street No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Street No.';
            TableRelation = Street.Code;
            trigger OnValidate()
            begin
                OnValidateStreet();
            end;
        }
        field(90000; "Type Relation"; enum "Contact Business Relation Link To Table")
        {
            Caption = 'Type Relation';
        }
        field(90001; "Group"; text[250])
        {
            Caption = 'Group';
            //   TableRelation = if ("Type Relation" = const(ServiceMan)) Grouping where(Type = const("Service Activity"))

            //     else
            //   if ("Type Relation" = const(ServiceItem)) Grouping;

        }
        field(90002; "Phone - Transfer"; Text[500])
        {
            Caption = 'Phone - Transfer';

        }
        field(90003; "Fax - Transfer"; Text[500])
        {
            Caption = 'Phone - Transfer';

        }
        field(50389; "Active CNG"; Boolean)
        {
            Caption = 'Active CNG';
        }
        field(50390; "Contractor No"; Text[250])
        {
            Caption = 'Contractor';
        }
        field(50391; "Responsible Contact"; text[250])
        {
            Caption = 'Responsible Contact';

        }

        field(50392; "Title Code"; Code[10])
        {
            Caption = 'Title';
            Editable = false;
        }
        field(50393; "Title Description"; Text[120])
        {
            Caption = 'Naziv zvanja';
            TableRelation = Title.Description;

        }
        field(50394; "Education Level"; Enum School)
        {
            Caption = 'Education Level';
        }
        field(50395; "Contract Date to"; Date)
        {
            Caption = 'Contract Date to';
        }
        field(50396; "Owner"; Text[250])
        {
            Caption = 'Owner';
        }
        field(50398; "Rpa"; Boolean)
        {
            Caption = 'Rpa';
        }
        field(50397; "Rpb"; Boolean)
        {
            Caption = 'Rpb';
        }


    }
    trigger Oninsert()
    var
        myInt: Integer;
        UserSetup: Record "User Setup";
    begin

        if Rec."Type Relation" = Rec."Type Relation"::" " then begin
            if UserSetup.Get(UserId) then
                Rec."Type Relation" := UserSetup."Type Relation";
        end;
    end;

    var
        myInt: Integer;

    local procedure OnValidateStreet()
    var
        Stroke: Record Stroke;
    begin
        Stroke.ValidateStreetNo("Street No.", Street, "Municipality Code", MZ);
        Validate("Municipality Code");
        Validate(MZ);
        CalcFields("Street Name", "Municipality Name", "MZ Name");
        Address := StrSubstNo('%1 %2', "Street Name", "Street No.");
    end;

    local procedure OnValidateMunicipality()
    var
        Municipality: Record Municipality;
    begin
        Municipality.ValidateMunicipality("Municipality Code", City, "Post Code");
    end;

}