table 50057 "Employee Training Ledger"
{
    Caption = 'Employee Training Ledger';
    LookupPageId = "Employee Trainings Ledger";
    DrillDownPageId = "Employee Trainings Ledger";




    fields
    {

        field(1; Code; Integer)
        {
            AutoIncrement = true;
            Caption = 'Code';
            Editable = false;


        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";


        }
        field(3; Code2Entry; Integer)
        {
            Caption = 'Training time entry code';
            TableRelation = "Training Time Entry";

            trigger OnValidate()
            begin
                TC.Reset();
                TC.SETFILTER(Code, '%1', Code2Entry);
                IF TC.FIND('-') THEN begin
                    Status := TC.Status;

                    TrainingCatalogue.reset;
                    TrainingCatalogue.SetFilter(TrainingCatalogue.Code, '%1', TC.Code2);
                    if TrainingCatalogue.FindFirst() then begin

                        Code3Catalogue := TrainingCatalogue.Code;
                        Name := TrainingCatalogue.Name;
                        Type := TrainingCatalogue.Type;
                        TypeOF := TrainingCatalogue.TypeOF;
                        "Type of name" := TrainingCatalogue."Type of name";

                        //Location := TrainingCatalogue.Location;
                        Month := TrainingCatalogue.Month;

                    end;



                end;


            end;

        }
        field(4; Code3Catalogue; Integer)
        {
            Caption = 'Training Catalogue Code';
            Editable = false;

        }
        field(5; Name; Text[250])
        {
            Caption = 'Traning Name';
            Editable = false;


        }
        field(6; Type; Option)
        {
            OptionMembers = "-",Interni,Eksterni;
            Caption = 'Type';
            Editable = false;


        }
        field(7; Location; Text[250])
        {
            Caption = 'Location';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Training Time Entry".Location where(Code = field(Code2Entry)));

        }
        field(8; Month; Enum Month)
        {
            Caption = 'Month';
            Editable = false;

        }

        field(9; "Start date of certificate"; Date)
        {
            Caption = 'Start date of certificate';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Training Time Entry"."End date" where(Code = field(Code2Entry)));

        }
        field(10; "End date of certificate"; Date)
        {
            Caption = 'End dateo of certificate';
            trigger OnValidate()
            begin
                if ("End date of certificate" < "Start date of certificate") then
                    Error('Datum kraja važenja certifikata ne može biti manji od datuma početka avženja certifikata.');
            end;

        }
        field(11; Attended; Boolean)
        {

            Caption = 'Attended';

        }
        field(12; "Mandatory"; Boolean)
        {
            Caption = 'Mandatory';
            trigger OnValidate()
            begin
                if Mandatory = true then begin

                    Attended := true;

                end;
            end;

        }
        field(13; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(Employee."First Name" where("No." = field("Employee No.")));

        }
        field(14; "Employee Last Name"; Text[50])
        {
            Caption = 'Employee Last Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Last Name" where("No." = field("Employee No.")));

        }
        field(15; Grade; Integer)
        {
            Caption = 'Grade';

        }
        field(16; Status; Option)
        {
            OptionMembers = " ","In progress",Finished,"In preparation";
            Caption = 'Status';


        }
        field(22; TypeOF; code[20])
        {
            Caption = 'Vrsta treninga';
            TableRelation = "Training Type";
            Editable = false;
        }
        field(23; "Type of name"; Text[250])
        {
            Caption = 'Naziv vrste treninga';
            TableRelation = "Training Type";
            Editable = false;
        }
        field(24; LocationName; Text[250])
        {
            Caption = 'Naziv lokacije';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Training Time Entry"."Location Name" where(Code = field(Code2Entry)));

        }


    }
    keys
    {
        key(Key1; Code)
        {
        }
    }
    var
        TC: Record "Training Time Entry";
        TrainingCatalogue: record "Training Catalogue";


}


