/*table 50080 "Travel Header"
{
    Caption = 'Travel Header';


    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    GLS.GET;
                    NoSeriesMgt.TestManual(GLS."Travel No. Series");

                END;
            end;
        }
        field(2; "Employe No."; Code[10])
        {
            Caption = 'Employe No.';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Employee.SETFILTER("No.", Rec."Employe No.");
                IF Employee.FIND('-') THEN BEGIN
                    "First Name" := Employee."First Name";
                    "Last Name" := Employee."Last Name";
                    "Job Position" := Employee."Job Position"
                END;
            end;
        }
        field(3; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(4; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
        field(5; "Travel Route"; Text[100])
        {
            Caption = 'Travel Route';
        }
        field(6; "Transportation Type"; Option)
        {
            Caption = 'Transportation Type';
            OptionCaption = 'Own Car,Company Car';
            OptionMembers = "Own Car","Company Car";
        }
        field(7; "Start Date"; DateTime)
        {
            Caption = 'Start Date';
        }
        field(8; "End Date"; DateTime)
        {
            Caption = 'End Date';

            trigger OnValidate()
            begin
                "Time spent" := "End Date" - "Start Date";
            end;
        }
        field(9; "Time spent"; Duration)
        {
            Caption = 'Time spent';
            Editable = false;
        }
        field(11; "Daily Allowance (LCY)"; Decimal)
        {
        }
        field(13; "Accomodation Expenses (LCY)"; Decimal)
        {
        }
        field(14; "Fuel expenses (LCY)"; Decimal)
        {
        }
        field(15; "Additional Car Expenses (LCY)"; Decimal)
        {
        }
        field(16; "Other Expenses (LCY)"; Decimal)
        {
        }
        field(17; "Job Position"; Text[50])
        {
            Caption = 'Job Position';
        }
        field(18; "FA No."; Code[10])
        {
            Caption = 'FA No.';
            TableRelation = "Fixed Asset"."No." WHERE("FA Posting Group" = CONST('VOZILA'));

            trigger OnValidate()
            begin
                FA.SETFILTER("No.", Rec."FA No.");
                IF FA.FIND('-') THEN BEGIN
                    "Veichle Weight" := FA."Veichle Weight";
                    "Veichle Load" := FA."Veichle Load";
                    "Veichle Type" := FA."Veichle Type";
                    "Registration No." := FA."Registration No.";
                    "Veichle Brand" := FA."Veichle Brand";
                END;
                "Weight Line" := "Veichle Weight" + "Veichle Load";
            end;
        }
        field(50006; "Veichle Type"; Option)
        {
            Caption = 'Veichle Type';
            Description = 'NK01';
            OptionCaption = ' ,Putničko vozilo,Teretno vozilo,Kombi,Dostavno vozilo,Sanitetsko vozilo,Terensko vozilo,Specijalno teretno vozilo,Specijalno teretno vozilo - hladnjača,Specijalno policijsko vozilo,Kombinovano,Specijalno vozilo';
            OptionMembers = " ",Passenger,Truck,Van,Delivery,Sanitet,Teren,Special,"Special-fridge","Special-police-veichle",Combined,"Special Veichle";
        }
        field(50007; "Veichle Brand"; Option)
        {
            Caption = 'Veichle Model';
            Description = 'NK01';
            OptionCaption = ' ,VW,Seat,Audi,Renault,Toyota,Opel,Mercedes,Mazda,Fiat,Ford';
            OptionMembers = " ",VW,Seat,Audi,Renault,Toyota,Opel,Mercedes;
        }
        field(50009; "Registration No."; Code[20])
        {
            Caption = 'Registration No.';
            Description = 'NK01';
        }
        field(50010; "Chasis No."; Code[20])
        {
            Caption = 'Chasis No.';
            Description = 'NK01';
        }
        field(50011; "Date of Production"; Integer)
        {
            Caption = 'Date of Production';
            Description = 'NK01';
        }
        field(50012; "Engine Volume"; Decimal)
        {
            Caption = 'Engine Volume';
            Description = 'NK01';
        }
        field(50013; "Engine Power"; Decimal)
        {
            Caption = 'Engine Power';
            Description = 'NK01';
        }
        field(50014; "Veichle Weight"; Decimal)
        {
            Caption = 'Veichle Weight';
            Description = 'NK01';
        }
        field(50015; "Veichle Load"; Decimal)
        {
            Caption = 'Veichle Load';
            Description = 'NK01';
        }
        field(50016; "First State Of Odemeter"; Integer)
        {
            Caption = 'First State Of Odemeter';
        }
        field(50017; "End State Of Odemeter"; Integer)
        {
            Caption = 'End State Of Odemeter';

            trigger OnValidate()
            begin
                "Total Distance" := "End State Of Odemeter" - "First State Of Odemeter";
            end;
        }
        field(50018; "Commercialist No."; Code[20])
        {
            Caption = 'Commercialist No.';
            TableRelation = "Salesperson/Purchaser".Code;

            trigger OnValidate()
            begin
                Emp.SETFILTER("No.", Rec."Commercialist No.");
                IF Emp.FIND('-') THEN BEGIN
                    "First Name" := Emp."First Name";
                    "Last Name" := Emp."Last Name";
                    "Job Position" := Emp."Job Position";
                END;
            end;
        }
        field(50019; "Total Distance"; Decimal)
        {
            Caption = 'Total Distance';
            Editable = false;
        }
        field(50020; "Average Fuel Consumption"; Decimal)
        {
            Caption = 'Average Fuel Consumption';

            trigger OnValidate()
            begin
                "Total Est. Fuel Consumtion" := "Average Fuel Consumption" * "Total Distance";
            end;
        }
        field(50021; "Total Est. Fuel Consumtion"; Decimal)
        {
            Caption = 'Total Est. Fuel Consumtion';
            Editable = false;
        }
        field(50022; "Co-Driver No."; Code[20])
        {
            Caption = 'Co-Driver No.';
            Description = 'ASo';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Emp.SETFILTER("No.", Rec."Co-Driver No.");
                IF Emp.FIND('-') THEN BEGIN
                    "Co-Driver First Name" := Emp."First Name";
                    "Co-Driver Last Name" := Emp."Last Name";
                END;
            end;
        }
        field(50023; "Co-Driver First Name"; Text[30])
        {
            Caption = 'Co-Driver First Name';
            Description = 'ASo';
        }
        field(50024; "Co-Driver Last Name"; Text[30])
        {
            Caption = 'Co-Driver Last Name';
            Description = 'ASo';
        }
        field(50025; "Shipping Person No."; Code[20])
        {
            Caption = 'Shipping Person No.';
            Description = 'ASo';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Emp.SETFILTER("No.", Rec."Shipping Person No.");
                IF Emp.FIND('-') THEN BEGIN
                    "Shipping Person First Name" := Emp."First Name";
                    "Shipping Person Last Name" := Emp."Last Name";
                END;
            end;
        }
        field(50026; "Shipping Person First Name"; Text[30])
        {
            Caption = 'Shipping Person First Name';
            Description = 'ASo';
        }
        field(50027; "Shipping Person Last Name"; Text[30])
        {
            Caption = 'Shipping Person Last Name';
            Description = 'ASo';
        }
        field(50028; "Weight Line"; Decimal)
        {
            Caption = 'Weight Line';
            Description = 'ASo';
        }
        field(50029; "Travel Purpose"; Text[250])
        {
            Caption = 'Travel Purpose';
        }
        field(50030; "Approved by"; Code[20])
        {
            Caption = 'Approved by';
            TableRelation = Employee;
        }
        field(50031; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50032; Status; Option)
        {
            OptionCaption = 'Neobrađen,Obrađen';
            OptionMembers = Unprocessed,Processed;
        }
        field(50033; Amount; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum ("Travel Line"."Line Amount (LCY)" WHERE("Document No." = FIELD("No.")));
            Caption = 'Ukupan iznos';
            Editable = false;

        }
        field(50034; "LR Amount"; Decimal)
        {
            CalcFormula = Sum ("Travel Line"."LR Line Amount (LCY)" WHERE("Document No." = FIELD("No.")));
            Caption = 'Ukupan zakonski priznat iznos';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        IF "No." = '' THEN BEGIN
            GLS.GET;
            GLS.TESTFIELD("Travel No. Series");
            NoSeriesMgt.InitSeries(GLS."Travel No. Series", GLS."Travel No. Series", 0D, "No.", GLS."Travel No. Series");
        END;
        "Last Date Modified" := TODAY;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GLS: Record "General Ledger Setup";
        Emp: Record Employee;
        Comm: Record "Salesperson/Purchaser";
        FA: Record "Fixed Asset";
        Employee: Record Employee;
}

*/