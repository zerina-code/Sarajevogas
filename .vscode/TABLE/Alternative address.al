tableextension 50007 AlternativeAddess_ext extends "Alternative Address"
{
    fields
    {

        modify("Employee No.")
        {
            trigger OnAfterValidate()
            var
                Emp: Record Employee;
            begin
                Emp.Get("Employee No.");
                Name := Emp."First Name";
                "Name 2" := Emp."Last Name";
            end;
        }
        field(500028; "No. Series"; Code[20])
        {
            Caption = 'Brojačana serija';
        }
        modify("Name 2")
        {
            trigger OnAfterValidate()
            var
                Emp: Record Employee;
            begin

            end;

        }





        // Add changes to table fields here
        field(50000; "Municipality Code"; Code[10])
        {
            Caption = 'Municipality Code';
            TableRelation = Municipality.Code where(Type = filter(Regular));

            trigger OnValidate()
            begin
                IF "Municipality Code" <> '' THEN BEGIN
                    Municipality.RESET;
                    Municipality.SETFILTER(Code, "Municipality Code");
                    Municipality.SetFilter(type, '%1', Municipality.Type::Regular);
                    IF Municipality.FINDFIRST THEN
                        "Municipality Name" := Municipality.Name;
                    VALIDATE(City, Municipality.City);
                    PostCode.RESET;
                    PostCode.SETFILTER(City, Municipality.City);
                    IF PostCode.FINDFIRST THEN BEGIN
                        VALIDATE("County Code", PostCode."Canton Code");
                        VALIDATE("Entity Code", PostCode."Entity Code");
                    END;
                    "Place Of Living" := "City CIPS";
                END
                ELSE BEGIN
                    "Municipality Name" := '';
                    VALIDATE(City, '');
                    County := '';
                    "Entity Code" := '';
                    "Place Of Living" := '';
                END;

                IF Active = TRUE THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        // IF "Address Type"="Address Type"::Current THEN BEGIN
                        Employee.Address := Address;
                        Employee."Municipality Code" := "Municipality Code";
                        Employee."Municipality Name" := "Municipality Name";
                        Employee.City := City;
                        Employee."Post Code" := "Post Code";
                        Employee.County := "County Code";
                        Employee."Entity Code" := "Entity Code";
                        Employee."Place Of Living" := "Place Of Living";
                        Employee."Country/Region Code" := "Country/Region Code";
                        /*Employee.MODIFY;
                        END
                        ELSE
                        IF "Address Type"="Address Type"::CIPS THEN BEGIN*/
                        Employee."Address CIPS" := "Address CIPS";
                        Employee."Municipality Code CIPS" := "Municipality Code CIPS";
                        Employee."Municipality Name CIPS" := "Municipality Name CIPS";
                        Employee."City CIPS" := "City CIPS";
                        Employee."Post Code CIPS" := "Post Code CIPS";
                        Employee."County CIPS" := "County Code CIPS";
                        Employee."Entity Code CIPS" := "Entity Code CIPS";
                        Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
                        Employee.MODIFY;
                        // END;
                    END;
                END;
                //  //EmployeeResUpdate.AlternativeAddressFunc(xRec, Rec);

            end;
        }
        field(50001; "Municipality Name"; Text[30])
        {
            Caption = 'Municipality Name';
            Editable = false;
        }
        field(50002; "Entity Code"; Code[10])
        {
            Caption = 'Entity Code';
            TableRelation = Entity.Code;

            trigger OnValidate()
            begin
                IF "Entity Code" <> '' THEN BEGIN
                    "Address Type" := 0;
                    Entity.RESET;
                    Entity.SETFILTER(Code, "Entity Code");
                    IF Entity.FINDFIRST THEN
                        VALIDATE("Country/Region Code", Entity."Country/Region Code");
                END ELSE
                    VALIDATE("Country/Region Code", '');

                IF Active = TRUE THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        //IF "Address Type"="Address Type"::Current THEN BEGIN
                        Employee.Address := Address;
                        Employee."Municipality Code" := "Municipality Code";
                        Employee."Municipality Name" := "Municipality Name";
                        Employee.City := City;
                        Employee."Post Code" := "Post Code";
                        Employee.County := "County Code";
                        Employee."Entity Code" := "Entity Code";
                        Employee."Place Of Living" := "Place Of Living";
                        Employee."Country/Region Code" := "Country/Region Code";
                        /*  Employee.MODIFY;
                          END
                          ELSE
                          IF "Address Type"="Address Type"::CIPS THEN BEGIN*/
                        Employee."Address CIPS" := "Address CIPS";
                        Employee."Municipality Code CIPS" := "Municipality Code CIPS";
                        Employee."Municipality Name CIPS" := "Municipality Name CIPS";
                        Employee."City CIPS" := "City CIPS";
                        Employee."Post Code CIPS" := "Post Code CIPS";
                        Employee."County CIPS" := "County Code CIPS";
                        Employee."Entity Code CIPS" := "Entity Code CIPS";
                        Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
                        Employee.MODIFY;
                        //  END;
                    END;
                END;
                //EmployeeResUpdate.AlternativeAddressFunc(xRec, Rec);

            end;
        }
        field(50003; "Address Type"; Option)
        {
            Caption = 'Address Type';
            OptionCaption = 'Current,CIPS,Both';
            OptionMembers = Current,CIPS," Both";
        }
        field(50004; "Address CIPS"; Text[50])
        {
            Caption = 'Address CIPS';

            trigger OnValidate()
            begin
                IF Active = TRUE THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        // IF "Address Type"="Address Type"::Current THEN BEGIN
                        Employee.Address := Address;
                        Employee."Municipality Code" := "Municipality Code";
                        Employee."Municipality Name" := "Municipality Name";
                        Employee.City := City;
                        Employee."Post Code" := "Post Code";
                        Employee.County := "County Code";
                        Employee."Entity Code" := "Entity Code";
                        Employee."Place Of Living" := "Place Of Living";
                        Employee."Country/Region Code" := "Country/Region Code";
                        /*  Employee.MODIFY;
                          END
                          ELSE
                          IF "Address Type"="Address Type"::CIPS THEN BEGIN*/
                        Employee."Address CIPS" := "Address CIPS";
                        Employee."Municipality Code CIPS" := "Municipality Code CIPS";
                        Employee."Municipality Name CIPS" := "Municipality Name CIPS";
                        Employee."City CIPS" := "City CIPS";
                        Employee."Post Code CIPS" := "Post Code CIPS";
                        Employee."County CIPS" := "County Code CIPS";
                        Employee."Entity Code CIPS" := "Entity Code CIPS";
                        Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
                        IF "Entity Code CIPS" = 'FBIH' THEN
                            Employee."Contribution Category Code" := 'FBIH';
                        IF "Entity Code CIPS" = 'RS' THEN
                            Employee."Contribution Category Code" := 'FBIHRS';
                        IF "Entity Code CIPS" = 'BD' THEN
                            Employee."Contribution Category Code" := 'BDPIOFBIH';
                        Employee.MODIFY;

                        //END;

                    END;
                END;

                //EmployeeResUpdate.AlternativeAddressFunc(xRec, Rec);

            end;
        }
        field(50005; "Municipality Code CIPS"; Code[10])
        {
            Caption = 'Municipality Code';
            TableRelation = Municipality.Code where(Type = filter(Regular));

            trigger OnValidate()
            begin
                IF "Municipality Code CIPS" <> '' THEN BEGIN
                    Municipality.RESET;
                    Municipality.SETFILTER(Code, "Municipality Code CIPS");
                    Municipality.SetFilter(type, '%1', Municipality.Type::Regular);
                    IF Municipality.FINDFIRST THEN
                        "Municipality Name CIPS" := Municipality.Name;
                    VALIDATE("City CIPS", Municipality.City);
                    "Place Of Living" := "City CIPS";
                    PostCode.RESET;
                    PostCode.SETFILTER(City, Municipality.City);
                    IF PostCode.FINDFIRST THEN BEGIN
                        VALIDATE("County Code CIPS", PostCode."Canton Code");
                        VALIDATE("Entity Code CIPS", PostCode."Entity Code");
                    END;
                END
                ELSE BEGIN
                    "Municipality Name CIPS" := '';
                    VALIDATE("City CIPS", '');
                    "County CIPS" := '';
                    "Entity Code CIPS" := '';
                END;

                IF Active = TRUE THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        // IF "Address Type"="Address Type"::Current THEN BEGIN
                        Employee.Address := Address;
                        Employee."Municipality Code" := "Municipality Code";
                        Employee."Municipality Name" := "Municipality Name";
                        Employee.City := City;
                        Employee."Post Code" := "Post Code";
                        Employee.County := "County Code";
                        Employee."Entity Code" := "Entity Code";
                        Employee."Place Of Living" := "Place Of Living";
                        Employee."Country/Region Code" := "Country/Region Code";
                        /*  Employee.MODIFY;
                          END
                          ELSE
                          IF "Address Type"="Address Type"::CIPS THEN BEGIN*/
                        Employee."Address CIPS" := "Address CIPS";
                        Employee."Municipality Code CIPS" := "Municipality Code CIPS";
                        Employee."Municipality Name CIPS" := "Municipality Name CIPS";
                        Employee."City CIPS" := "City CIPS";
                        Employee."Post Code CIPS" := "Post Code CIPS";
                        Employee."County CIPS" := "County Code CIPS";
                        Employee."Entity Code CIPS" := "Entity Code CIPS";
                        Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
                        IF "Entity Code CIPS" = 'FBIH' THEN
                            Employee."Contribution Category Code" := 'FBIH';
                        IF "Entity Code CIPS" = 'RS' THEN
                            Employee."Contribution Category Code" := 'FBIHRS';
                        IF "Entity Code CIPS" = 'BD' THEN
                            Employee."Contribution Category Code" := 'BDPIOFBIH';
                        Employee.MODIFY;
                        // END;
                    END;
                END;

                //EmployeeResUpdate.AlternativeAddressFunc(xRec, Rec);

            end;
        }
        field(50006; "Municipality Name CIPS"; Text[30])
        {
            Caption = 'Municipality Name';
            Editable = false;
        }
        field(50007; "City CIPS"; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code CIPS" = CONST()) "Post Code".City
            ELSE
            IF ("Country/Region Code CIPS" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code CIPS"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity1("City CIPS", "Post Code CIPS", "Country/Region Code CIPS", (CurrFieldNo <> 0) AND GUIALLOWED);
                PostCode.RESET;
                PostCode.SETFILTER(City, "City CIPS");
                IF PostCode.FINDFIRST THEN BEGIN
                    VALIDATE("County Code CIPS", PostCode."Canton Code");
                    VALIDATE("Entity Code CIPS", PostCode."Entity Code");
                END;

                IF Active = TRUE THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        // IF "Address Type"="Address Type"::Current THEN BEGIN
                        Employee.Address := Address;
                        Employee."Municipality Code" := "Municipality Code";
                        Employee."Municipality Name" := "Municipality Name";
                        Employee.City := City;
                        Employee."Post Code" := "Post Code";
                        Employee.County := "County Code";
                        Employee."Entity Code" := "Entity Code";
                        Employee."Place Of Living" := "Place Of Living";
                        Employee."Country/Region Code" := "Country/Region Code";
                        /* Employee.MODIFY;
                         END
                         ELSE
                         IF "Address Type"="Address Type"::CIPS THEN BEGIN*/
                        Employee."Address CIPS" := "Address CIPS";
                        Employee."Municipality Code CIPS" := "Municipality Code CIPS";
                        Employee."Municipality Name CIPS" := "Municipality Name CIPS";
                        Employee."City CIPS" := "City CIPS";
                        Employee."Post Code CIPS" := "Post Code CIPS";
                        Employee."County CIPS" := "County Code CIPS";
                        Employee."Entity Code CIPS" := "Entity Code CIPS";
                        Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
                        IF "Entity Code CIPS" = 'FBIH' THEN
                            Employee."Contribution Category Code" := 'FBIH';
                        IF "Entity Code CIPS" = 'RS' THEN
                            Employee."Contribution Category Code" := 'FBIHRS';
                        IF "Entity Code CIPS" = 'BD' THEN
                            Employee."Contribution Category Code" := 'BDPIOFBIH';
                        Employee.MODIFY;
                        // END;
                    END;
                END;

            end;
        }
        field(50008; "Country/Region Code CIPS"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                IF Active = TRUE THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        // IF "Address Type"="Address Type"::Current THEN BEGIN
                        Employee.Address := Address;
                        Employee."Municipality Code" := "Municipality Code";
                        Employee."Municipality Name" := "Municipality Name";
                        Employee.City := City;
                        Employee."Post Code" := "Post Code";
                        Employee.County := "County Code";
                        Employee."Entity Code" := "Entity Code";
                        Employee."Place Of Living" := "Place Of Living";
                        Employee."Country/Region Code" := "Country/Region Code";
                        /* Employee.MODIFY;
                         END
                         ELSE
                         IF "Address Type"="Address Type"::CIPS THEN BEGIN*/
                        Employee."Address CIPS" := "Address CIPS";
                        Employee."Municipality Code CIPS" := "Municipality Code CIPS";
                        Employee."Municipality Name CIPS" := "Municipality Name CIPS";
                        Employee."City CIPS" := "City CIPS";
                        Employee."Post Code CIPS" := "Post Code CIPS";
                        Employee."County CIPS" := "County Code CIPS";
                        Employee."Entity Code CIPS" := "Entity Code CIPS";
                        Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
                        IF "Entity Code CIPS" = 'FBIH' THEN
                            Employee."Contribution Category Code" := 'FBIH';
                        IF "Entity Code CIPS" = 'RS' THEN
                            Employee."Contribution Category Code" := 'FBIHRS';
                        IF "Entity Code CIPS" = 'BD' THEN
                            Employee."Contribution Category Code" := 'BDPIOFBIH';
                        Employee.MODIFY;
                        // END;
                    END;
                END

            end;
        }
        field(50009; "Post Code CIPS"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code CIPS" = CONST()) "Post Code"
            ELSE
            IF ("Country/Region Code CIPS" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code CIPS"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode1("City CIPS", "Post Code CIPS", "Country/Region Code CIPS", (CurrFieldNo <> 0) AND GUIALLOWED);
                PostCode.RESET;
                PostCode.SETFILTER(Code, "Post Code CIPS");
                IF PostCode.FINDFIRST THEN BEGIN
                    VALIDATE("County Code CIPS", PostCode."Canton Code");
                    VALIDATE("Entity Code CIPS", PostCode."Entity Code");
                END;


                IF Active = TRUE THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        // IF "Address Type"="Address Type"::Current THEN BEGIN
                        Employee.Address := Address;
                        Employee."Municipality Code" := "Municipality Code";
                        Employee."Municipality Name" := "Municipality Name";
                        Employee.City := City;
                        Employee."Place Of Living" := "Place Of Living";
                        Employee."Post Code" := "Post Code";
                        Employee.County := "County Code";
                        Employee."Entity Code" := "Entity Code";
                        Employee."Country/Region Code" := "Country/Region Code";
                        /* Employee.MODIFY;
                         END
                         ELSE
                         IF "Address Type"="Address Type"::CIPS THEN BEGIN*/
                        Employee."Address CIPS" := "Address CIPS";
                        Employee."Municipality Code CIPS" := "Municipality Code CIPS";
                        Employee."Municipality Name CIPS" := "Municipality Name CIPS";
                        Employee."City CIPS" := "City CIPS";
                        Employee."Post Code CIPS" := "Post Code CIPS";
                        Employee."County CIPS" := "County Code CIPS";
                        Employee."Entity Code CIPS" := "Entity Code CIPS";
                        Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
                        IF "Entity Code CIPS" = 'FBIH' THEN
                            Employee."Contribution Category Code" := 'FBIH';
                        IF "Entity Code CIPS" = 'RS' THEN
                            Employee."Contribution Category Code" := 'FBIHRS';
                        IF "Entity Code CIPS" = 'BD' THEN
                            Employee."Contribution Category Code" := 'BDPIOFBIH';
                        Employee.MODIFY;
                        // END;
                    END;
                END;

            end;
        }
        field(50010; "County CIPS"; Text[50])
        {
            Caption = 'County Name';
            Editable = false;
        }
        field(50011; "Entity Code CIPS"; Code[10])
        {
            Caption = 'Entity Code';
            TableRelation = Entity.Code;

            trigger OnValidate()
            begin
                IF "Entity Code CIPS" <> '' THEN BEGIN
                    "Address Type" := 1;
                    Entity.RESET;
                    Entity.SETFILTER(Code, "Entity Code CIPS");
                    IF Entity.FINDFIRST THEN
                        VALIDATE("Country/Region Code CIPS", Entity."Country/Region Code");
                END ELSE
                    VALIDATE("Country/Region Code CIPS", '');

                IF Active = TRUE THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        // IF "Address Type"="Address Type"::Current THEN BEGIN
                        Employee.Address := Address;
                        Employee."Municipality Code" := "Municipality Code";
                        Employee."Municipality Name" := "Municipality Name";
                        Employee.City := City;
                        Employee."Post Code" := "Post Code";
                        Employee.County := "County Code";
                        Employee."Entity Code" := "Entity Code";
                        Employee."Country/Region Code" := "Country/Region Code";
                        Employee."Place Of Living" := "Place Of Living";
                        /* Employee.MODIFY;
                         END
                         ELSE
                         IF "Address Type"="Address Type"::CIPS THEN BEGIN*/
                        Employee."Address CIPS" := "Address CIPS";
                        Employee."Municipality Code CIPS" := "Municipality Code CIPS";
                        Employee."Municipality Name CIPS" := "Municipality Name CIPS";
                        Employee."City CIPS" := "City CIPS";
                        Employee."Post Code CIPS" := "Post Code CIPS";
                        Employee."County CIPS" := "County Code CIPS";
                        Employee."Entity Code CIPS" := "Entity Code CIPS";
                        Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
                        IF "Entity Code CIPS" = 'FBIH' THEN
                            Employee."Contribution Category Code" := 'FBIH';
                        IF "Entity Code CIPS" = 'RS' THEN
                            Employee."Contribution Category Code" := 'FBIHRS';
                        IF "Entity Code CIPS" = 'BD' THEN
                            Employee."Contribution Category Code" := 'BDPIOFBIH';
                        Employee.MODIFY;
                        //END;
                    END;
                END;

            end;
        }
        field(50012; "Date From"; Date)
        {
            Caption = 'Date From';

            trigger OnValidate()
            begin
                /* CloseDate:=Rec."Date From"-1;
                  AA.SETFILTER("Employee No.",'%1',Rec."Employee No.");
                  AA.SETFILTER("Address Type",'%1',"Address Type"::Current);
                     IF AA.COUNT>=1 THEN BEGIN
                        IF AA.FIND('+')
                          THEN AA.VALIDATE("Date To",CloseDate);
                          AA.MODIFY;
                  END;
                  *///AJ zakomentarisala da provjerim da li je to razlog izbacivanja greške

            end;
        }
        field(50013; "Date To"; Date)
        {
            Caption = 'Date To';
        }
        field(50014; "Date From (CIPS)"; Date)
        {
            Caption = 'Date From (CIPS)';

            trigger OnValidate()
            begin

                /*CloseDate1:=Rec."Date From (CIPS)"-1;
                 AltAdd.SETFILTER("Employee No.",'%1',Rec."Employee No.");
                 //AA.SETFILTER("Address Type",'%1',"Address Type"::Current);
                 //IF AltAdd.FINDFIRST THEN BEGIN
                // AltAdd.SETFILTER(Code,'%1',Rec.Code);
                    IF AltAdd.COUNT>=1 THEN BEGIN
                       IF AltAdd.FIND('+')
                       THEN AltAdd.VALIDATE("Date To (CIPS)",CloseDate1);
                       AltAdd.MODIFY;
                    END;
                 //END;*/

                //EmployeeResUpdate.AlternativeAddressFunc(xRec, Rec);

            end;
        }
        field(50015; "Date To (CIPS)"; Date)
        {
            Caption = 'Date To (CIPS)';

            trigger OnValidate()
            begin

                //EmployeeResUpdate.AlternativeAddressFunc(xRec, Rec);
            end;
        }
        field(50017; "County Code"; Code[10])
        {
            Caption = 'County Code';
            TableRelation = Canton.Code;

            trigger OnValidate()
            begin
                IF "County Code" <> '' THEN BEGIN
                    Canton.RESET;
                    Canton.SETFILTER(Code, "County Code");
                    IF Canton.FINDFIRST THEN
                        County := Canton.Description;
                    VALIDATE("Entity Code", Canton."Entity Code");
                END ELSE BEGIN
                    County := '';
                    VALIDATE("Entity Code", '');
                END;

                IF Active = TRUE THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        // IF "Address Type"="Address Type"::Current THEN BEGIN
                        Employee.Address := Address;
                        Employee."Municipality Code" := "Municipality Code";
                        Employee."Municipality Name" := "Municipality Name";
                        Employee.City := City;
                        Employee."Post Code" := "Post Code";
                        Employee.County := "County Code";
                        Employee."Entity Code" := "Entity Code";
                        Employee."Place Of Living" := "Place Of Living";
                        Employee."Country/Region Code" := "Country/Region Code";
                        /*Employee.MODIFY;
                        END
                        ELSE
                        IF "Address Type"="Address Type"::CIPS THEN BEGIN*/
                        Employee."Address CIPS" := "Address CIPS";
                        Employee."Municipality Code CIPS" := "Municipality Code CIPS";
                        Employee."Municipality Name CIPS" := "Municipality Name CIPS";
                        Employee."City CIPS" := "City CIPS";
                        Employee."Post Code CIPS" := "Post Code CIPS";
                        Employee."County CIPS" := "County Code CIPS";
                        Employee."Entity Code CIPS" := "Entity Code CIPS";
                        Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
                        Employee.MODIFY;
                        // END;
                    END;
                END;

            end;
        }
        field(50018; "County Code CIPS"; Code[10])
        {
            Caption = 'County Code CIPS';
            TableRelation = Canton.Code;

            trigger OnValidate()
            begin
                IF "County Code CIPS" <> '' THEN BEGIN
                    Canton.RESET;
                    Canton.SETFILTER(Code, "County Code CIPS");
                    IF Canton.FINDFIRST THEN
                        "County CIPS" := Canton.Description;
                    VALIDATE("Entity Code CIPS", Canton."Entity Code");
                END ELSE BEGIN
                    "County CIPS" := '';
                    VALIDATE("Entity Code CIPS", '');
                END;

                IF Active = TRUE THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        // IF "Address Type"="Address Type"::Current THEN BEGIN
                        Employee.Address := Address;
                        Employee."Municipality Code" := "Municipality Code";
                        Employee."Municipality Name" := "Municipality Name";
                        Employee.City := City;
                        Employee."Post Code" := "Post Code";
                        Employee.County := "County Code";
                        Employee."Entity Code" := "Entity Code";
                        Employee."Country/Region Code" := "Country/Region Code";
                        Employee."Place Of Living" := "Place Of Living";
                        /*Employee.MODIFY;
                        END
                        ELSE
                        IF "Address Type"="Address Type"::CIPS THEN BEGIN*/
                        Employee."Address CIPS" := "Address CIPS";
                        Employee."Municipality Code CIPS" := "Municipality Code CIPS";
                        Employee."Municipality Name CIPS" := "Municipality Name CIPS";
                        Employee."City CIPS" := "City CIPS";
                        Employee."Post Code CIPS" := "Post Code CIPS";
                        Employee."County CIPS" := "County Code CIPS";
                        Employee."Entity Code CIPS" := "Entity Code CIPS";
                        Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
                        Employee.MODIFY;
                        //  END;
                    END;
                END;

            end;
        }
        field(50019; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(50020; Status; enum "Employee Status")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee.Status WHERE("No." = FIELD("Employee No.")));
            Caption = 'Status';

            //OptionCaption = 'Active,Inactive,Unpaid,Terminated';
            //OptionMembers = Active,Inactive,Unpaid,Terminated;
        }
        field(50021; "Employment Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Work Booklet"."Starting Date" WHERE("Current Company" = FILTER(TRUE),
                                                                       "Employee No." = FIELD("Employee No.")));
            Caption = 'Employment Date';

        }
        field(50022; "Insert Date"; Date)
        {
        }
        field(50023; "Place Of Living"; Text[80])
        {
            Caption = 'Place of living';

            trigger OnValidate()
            begin
                IF Active = TRUE THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        // IF "Address Type"="Address Type"::Current THEN BEGIN
                        Employee.Address := Address;
                        Employee."Municipality Code" := "Municipality Code";
                        Employee."Municipality Name" := "Municipality Name";
                        Employee.City := City;
                        Employee."Post Code" := "Post Code";
                        Employee.County := "County Code";
                        Employee."Entity Code" := "Entity Code";
                        Employee."Country/Region Code" := "Country/Region Code";
                        Employee."Place Of Living" := "Place Of Living";
                        /*Employee.MODIFY;
                        END
                        ELSE
                        IF "Address Type"="Address Type"::CIPS THEN BEGIN*/
                        Employee."Address CIPS" := "Address CIPS";
                        Employee."Municipality Code CIPS" := "Municipality Code CIPS";
                        Employee."Municipality Name CIPS" := "Municipality Name CIPS";
                        Employee."City CIPS" := "City CIPS";
                        Employee."Post Code CIPS" := "Post Code CIPS";
                        Employee."County CIPS" := "County Code CIPS";
                        Employee."Entity Code CIPS" := "Entity Code CIPS";
                        Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
                        Employee.MODIFY;
                        //  END;
                    END;
                END;

                //EmployeeResUpdate.AlternativeAddressFunc(xRec, Rec);

            end;
        }
    }

    var
        myInt: Integer;
        PostCode: Record "Post Code";
        Employee: Record "Employee";
        Municipality: Record "Municipality";
        AlternativeAddress: Record "Alternative Address";
        Canton: Record "Canton";
        Entity: Record "Entity";
        //ĐK   PersonalRecords: Record "Personal Records";
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        CloseDate: Date;
        AA: Record "Alternative Address";
        AltAdd: Record "Alternative Address";
        CloseDate1: Date;
        //   PersonalTrack: Record "Personal track report";
        ECL: Record "Employee Contract Ledger";
        // EmployeeResUpdate: Codeunit "Employee/Resource Update 2020";
        UserPersonalization: Record "User Personalization";

    trigger OnInsert()
    var
        myInt: Integer;
        HumanResSetup: Record "Human Resources Setup";
    begin

        Employee.RESET;
        Employee.SETFILTER("No.", "Employee No.");
        IF Employee.FINDFIRST THEN BEGIN

            Employee.Address := Address;
            Employee."Municipality Code" := "Municipality Code";
            Employee."Municipality Name" := "Municipality Name";
            Employee.City := City;
            Employee."Post Code" := "Post Code";
            Employee.County := "County Code";
            Employee."Entity Code" := "Entity Code";
            Employee."Country/Region Code" := "Country/Region Code";


            Employee."Address CIPS" := "Address CIPS";
            Employee."Municipality Code CIPS" := "Municipality Code CIPS";
            Employee."Municipality Name CIPS" := "Municipality Name CIPS";
            Employee."City CIPS" := "City CIPS";
            Employee."Place Of Living" := "Place Of Living";
            Employee."Post Code CIPS" := "Post Code CIPS";
            Employee."County CIPS" := "County Code CIPS";
            Employee."Entity Code CIPS" := "Entity Code CIPS";
            Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
            Employee.MODIFY;

            /*  PersonalRecords.RESET;
              PersonalRecords.SETFILTER("Employee No.", "Employee No.");
              IF PersonalRecords.FINDLAST THEN BEGIN
                  PersonalRecords.Address := "Address CIPS";
                  PersonalRecords.VALIDATE("Municipality Code", "Municipality Code CIPS");
                  PersonalRecords.VALIDATE(City, "City CIPS");
                  PersonalRecords."Country/Region Code" := "Country/Region Code CIPS";
                  PersonalRecords.MODIFY;
              END;*/

        END;

        AlternativeAddress.RESET;
        AlternativeAddress.SETFILTER("Employee No.", "Employee No.");
        IF ((Rec."Address CIPS" = '') AND (Rec.Address <> '')) THEN
            AlternativeAddress.SETFILTER("Address Type", '%1', 0);
        IF ((Rec."Address CIPS" <> '') AND (Rec.Address = '')) THEN
            AlternativeAddress.SETFILTER("Address Type", '%1', 1);
        IF AlternativeAddress.FINDFIRST THEN BEGIN
            REPEAT
                AlternativeAddress.Active := FALSE;
                AlternativeAddress.MODIFY;
            UNTIL AlternativeAddress.NEXT = 0;
        END;
        Active := TRUE;
        "Insert Date" := TODAY;

        IF Code = '' THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("Alternative Address Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."Alternative Address Nos.", xRec."No. Series", 0D, Code, "No. Series");
        END;


        //Code

    end;
}