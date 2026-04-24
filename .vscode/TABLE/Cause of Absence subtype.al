/*table 50217 "Cause of Absence Subtype"
{
    DrillDownPageID = "Cause of Absence Subtype";
    LookupPageID = "Cause of Absence Subtype";

    fields
    {
        field(1; "Cause of Absence Code"; Code[10])
        {
            Caption = 'Code';
            TableRelation = "Cause of Absence".Code;
        }
        field(2; "Code"; Text[30])
        {
            Caption = 'Code2';

            trigger OnValidate()
            begin
               

            end;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(50000; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50001; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50002; "Employee No. Filter"; Code[20])
        {
            Caption = 'Employee No. Filter';
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(50003; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(50004; "Total Absence (Base)"; Decimal)
        {
            CalcFormula = Sum("Employee Absence"."Quantity (Base)" WHERE("Cause of Absence Code" = FIELD(Code),
                                                                          "Employee No." = FIELD("Employee No. Filter"),
                                                                          "From Date" = FIELD("Date Filter")));
            Caption = 'Total Absence (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; Level; Option)
        {
            Caption = 'Level';
            OptionCaption = 'Administrator,Parent,Timesheet Administrator,Timesheet manager,Employee';
            OptionMembers = Administrator,Parent,"Timesheet Administrator","Timesheet manager",Employee;
        }
        field(50006; Status; Option)
        {
            OptionCaption = 'R_REDOVNO,G - GODIŠNJI ODMOR,V – VJERSKI PRAZNIK,P – PLACENO ODSUSTVO,S – SMRTNI SLUCAJ,SD – SLOBODAN DAN,PU - PLACENO ODSUSTVO UZ ODLUKU UPRAVE,NU – NEPLACENO ODSUSTVO UZ ODLUKU UPRAVE,B – BOLOVANJE - BOLEST,D – DRŽAVNI PRAZNIK,NE – NEOPRAVDANO ODSUSTVO,B – BOLOVANJE - CUVANJE TRUDNOCE,B – BOLOVANJA,B – BOLOVANJE NJEGA CLANA OBITELJI,P – OSTALA PLAĆENA ODSUSTVA,SL- SLUŽBENI PUT,B – PORODILJSKO ODSUSTVO,S – SUSPENZIJA,P – PRAZNIK,R – DODATNO,PR –  PREKOVREMENI RAD,B – BOLOVANJE - POVREDA NA RADU';
            OptionMembers = R_REDOVNO,"G - GODIŠNJI ODMOR","V – VJERSKI PRAZNIK","P – PLACENO ODSUSTVO","S – SMRTNI SLUCAJ","SD – SLOBODAN DAN","PU - PLACENO ODSUSTVO UZ ODLUKU UPRAVE","NU – NEPLACENO ODSUSTVO UZ ODLUKU UPRAVE","B – BOLOVANJE - BOLEST","D – DRŽAVNI PRAZNIK","NE – NEOPRAVDANO ODSUSTVO","B – BOLOVANJE - CUVANJE TRUDNOCE","B – BOLOVANJA","B – BOLOVANJE NJEGA CLANA OBITELJI","P – OSTALA PLAĆENA ODSUSTVA","SL- SLUŽBENI PUT","B – PORODILJSKO ODSUSTVO","S – SUSPENZIJA","P – PRAZNIK","R – DODATNO","PR –  PREKOVREMENI RAD","B – BOLOVANJE - POVREDA NA RADU";

            trigger OnValidate()
            begin
               

            end;
        }
        field(50007; "Allowed Days"; Integer)
        {
            Caption = 'Allowed Days';
        }
    }

    keys
    {
        key(Key1; "Cause of Absence Code", "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
      

    end;

    trigger OnInsert()
    begin
       

    end;

    var
        WPConnSetup: Record "Web portal connection setup";

}
*/
