page 50070 "Employee Trainings Ledger"
{


    Caption = 'Employee Training Ledger';
    PageType = List;
    SourceTable = "Employee Training Ledger";
    RefreshOnActivate = true;
    InsertAllowed = true;


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Code; Code)
                { }
                field("Employee No."; "Employee No.")
                {

                }
                field("Employee Name"; "Employee Name") { }
                field("Employee Last Name"; "Employee Last Name")
                {

                }

                field(Code2Entry; Code2Entry)
                {

                }
                field(Name; Name) { }
                field(Type; Type)
                {

                }
                field(TypeOF; TypeOF) { }
                field("Type of name"; "Type of name") { }
                field(Location; Location) { }
                field(LocationName; LocationName) { }
                field(Month; Month) { }
                field(Attended; Attended) { }
                field(Mandatory; Mandatory) { }
                field(Status; Status) { }
                field(Grade; Grade)
                {

                    trigger OnValidate()
                    begin
                        if (Grade < 0) or (Grade > 10) then begin
                            Error('Unos koji ste naveli je izvan opsega 1-10.');
                        end;
                    end;
                }

                field("Start date of certificate"; "Start date of certificate") { }
                field("End date of certificate"; "End date of certificate") { }



            }
        }


    }
}


