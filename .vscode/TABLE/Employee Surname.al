table 50070 "Employee Surname"
{
    Caption = 'Employee Surname';
    DrillDownPageID = "Employee Surname";
    LookupPageID = "Employee Surname";

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
            TableRelation = Employee;
            //drazen
        }
        field(2; "Last Name"; Text[50])
        {
            Caption = 'Last Name';

            trigger OnValidate()
            begin

                /*EmployeeSurname.SETFILTER("No.",'%1',"No.");
                EmployeeSurname.SETFILTER("Last Name",'<>%1',Rec."Last Name");
               IF EmployeeSurname.COUNT>=1 THEN BEGIN
                IF EmployeeSurname.FIND('-') THEN BEGIN
                  EmployeeSurname.Old:=TRUE;
                  EmployeeSurname.MODIFY;
                  END;
                END;*/

            end;
        }
        field(50000; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = true;
        }
        field(50001; "First Name"; Text[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."First Name" WHERE("No." = FIELD("No.")));
            Caption = 'First Name';
            Editable = false;



            trigger OnValidate()
            begin
                /*WPConnSetup.FINDFIRST();
                CREATE(conn, TRUE, TRUE);
                
                conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                          +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
                
                CREATE(comm,TRUE, TRUE);
                
                lvarActiveConnection := conn;
                comm.ActiveConnection := lvarActiveConnection;
                
                comm.CommandText := 'dbo.Employee_Update';
                comm.CommandType := 4;
                comm.CommandTimeout := 0;
                
                param:=comm.CreateParameter('@OldEmployee_no', 200,1,30, xRec."No.");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Employee_no', 200,1,30, "No.");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Email', 200, 1, 30,"E-Mail");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@FirstName', 200, 1, 30,"First Name");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@LastName', 200, 1, 30, "Last Name");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Address', 200, 1, 30, Address);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@PostCode', 200, 1, 30, "Post Code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@City', 200, 1, 30, City);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@PhoneNo', 200, 1, 30, "Phone No.");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Position', 200, 1, 30, "Position Code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Sector', 200, 1, 10, "Department code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@ManagerNo', 200, 1, 30, "Manager No.");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Status', 200, 1, 30, Status);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@EmploymentDate', 7,1,0, "Employment Date");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@InactiveDate', 7,1,0, "Inactive Date");
                comm.Parameters.Append(param);
                
                comm.Execute;
                conn.Close;
                CLEAR(conn);
                CLEAR(comm);
                */

                /*Employee.SETFILTER("No.","No.");
                      IF Employee.FINDFIRST THEN BEGIN
                      WC.RESET;
                      WC.SETFILTER("Employee No.","No.");
                      IF WC.FINDFIRST() THEN
                       BEGIN
                        WC."First Name":="First Name";
                        WC.MODIFY;
                       END;
                      END;*/

            end;
        }
        field(50002; "Old Surname"; Text[80])
        {
            Caption = 'Old Surname';
        }
        field(50003; "Number Of Surnames"; Integer)
        {
            Caption = 'Number Of Surnames';
            FieldClass = Normal;
        }
        field(50004; "Line No."; Code[10])
        {
        }
        field(50006; Old; Boolean)
        {
        }
        field(50007; "Old Email Adress"; Text[200])
        {
        }
        field(50008; "New Email Adress"; Text[200])
        {
        }
        field(50009; LineNo; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "No.", "Last Name")
        {
        }
        key(Key2; "Last Date Modified")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Last Date Modified" := TODAY;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
    end;

    var
        Oldsurname: Text[100];
        EmployeeSurname: Record "Employee Surname";
        Employee: Record "Employee";
        Text014: Label 'Company E-mail is already used';
}

