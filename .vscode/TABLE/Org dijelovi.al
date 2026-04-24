table 50113 "ORG Dijelovi"
{
    // //nk

    Caption = 'ORG. Part';
    LookupPageID = "ORG Dijelovi";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'ID.';
            NotBlank = false;
        }
        field(2; Description; Text[70])
        {
            Caption = 'Name.';
        }
        field(4; "Municipality Code"; Code[20])
        {
            Caption = 'Municipality Code.';
            TableRelation = Municipality where(Type = filter(Regular));

            trigger OnValidate()
            begin
                /*IF "Municipality Code"<>'' THEN BEGIN
                  Municipality.RESET;
                  Municipality.SETFILTER(Code,"Municipality Code");
                  IF Municipality.FINDFIRST THEN
                     City:=Municipality.City;
                  Municipality.CALCFIELDS("Entity Code");
                  VALIDATE("Entity Code",Municipality."Entity Code");
                  g   PostCode.RESET;
                     PostCode.SETFILTER(City,Municipality.City);
                     IF PostCode.FINDFIRST THEN BEGIN
                       VALIDATE("Post Code",PostCode.Code);
                      END;
                  END
                  ELSE BEGIN
                  City:='';
                  "Post Code":=' ';
                  "Entity Code":='';
                  END*/



                IF Rec."Branch Agency" = 1 THEN BEGIN
                    ECL.RESET;
                    ECL.SETFILTER("GF of work Description", '1%', Rec.Description);
                    ECL.SETFILTER(Active, '%1', TRUE);
                    IF ECL.FINDSET THEN
                        REPEAT
                            ECL.VALIDATE("GF of work Description", Rec.Description);
                            ECL.MODIFY;
                            Employee.RESET;
                            Employee.SETFILTER("No.", '%1', ECL."Employee No.");
                            IF Employee.FINDFIRST THEN BEGIN
                                ECL.CALCFIELDS("Org Entity Code");
                                Employee."Org Entity Code" := Rec."Entity Code";
                                Employee.MODIFY;
                            END;

                        UNTIL ECL.NEXT = 0;
                END;
                IF Rec."Branch Agency" = 2 THEN BEGIN
                    ECL.RESET;
                    ECL.SETFILTER("Org Unit Name", '1%', Rec.Description);
                    ECL.SETFILTER(Active, '%1', TRUE);
                    IF ECL.FINDSET THEN
                        REPEAT
                            ECL.VALIDATE("Org Unit Name", Rec.Description);
                            ECL.MODIFY;
                            Employee.RESET;
                            Employee.SETFILTER("No.", '%1', ECL."Employee No.");
                            IF Employee.FINDFIRST THEN BEGIN
                                ECL.CALCFIELDS("Org Entity Code");
                                Employee."Org Entity Code" := Rec."Entity Code";
                                Employee.MODIFY;
                            END;

                        UNTIL ECL.NEXT = 0;
                END;

            end;
        }
        field(5; "Refer To Number"; Text[50])
        {
            Caption = 'Refer To Number';
        }
        field(20; "Version Code"; Text[30])
        {
            Caption = 'Residence';
        }
        field(21; "Registration No."; Text[30])
        {
            Caption = 'Registration No.';
            NotBlank = true;
        }
        field(50000; Telephone; Text[30])
        {
            Caption = 'Telephone';
        }
        field(50001; "Bank Account No."; Text[30])
        {
            Caption = 'Account No';
        }
        field(50002; Address; Text[100])
        {
            Caption = 'Address';

            trigger OnValidate()
            begin

                //ECL.CALCFIELDS("Org Dio");
                //ECL.SETFILTER(Status,'%1',0);
                ECL.SETFILTER(Active, '%1', TRUE);
                ECL.SETFILTER("Org Dio", Rec.Code);
                IF ECL.FINDFIRST THEN
                    REPEAT
                        ECL."Department Address" := Address;
                        ECL.MODIFY;
                    UNTIL ECL.NEXT = 0;

                IF Rec."Branch Agency" = 1 THEN BEGIN
                    ECL.RESET;
                    ECL.SETFILTER("GF of work Description", '1%', Rec.Description);
                    ECL.SETFILTER(Active, '%1', TRUE);
                    IF ECL.FINDSET THEN
                        REPEAT
                            ECL.VALIDATE("GF of work Description", Rec.Description);
                            ECL.MODIFY;
                            Employee.RESET;
                            Employee.SETFILTER("No.", '%1', ECL."Employee No.");
                            IF Employee.FINDFIRST THEN BEGIN
                                ECL.CALCFIELDS("Org Entity Code");
                                Employee."Org Entity Code" := Rec."Entity Code";
                                Employee.MODIFY;
                            END;

                        UNTIL ECL.NEXT = 0;
                END;
                IF Rec."Branch Agency" = 2 THEN BEGIN
                    ECL.RESET;
                    ECL.SETFILTER("Org Unit Name", '1%', Rec.Description);
                    ECL.SETFILTER(Active, '%1', TRUE);
                    IF ECL.FINDSET THEN
                        REPEAT
                            ECL.VALIDATE("Org Unit Name", Rec.Description);
                            ECL.MODIFY;
                            Employee.RESET;
                            Employee.SETFILTER("No.", '%1', ECL."Employee No.");
                            IF Employee.FINDFIRST THEN BEGIN
                                ECL.CALCFIELDS("Org Entity Code");
                                Employee."Org Entity Code" := Rec."Entity Code";
                                Employee.MODIFY;
                            END;

                        UNTIL ECL.NEXT = 0;
                END;
            end;
        }
        field(50003; "Industrial Classification"; Text[30])
        {
            Caption = 'Industrial Classification';
        }
        field(50004; "Industrial Classification Name"; Text[250])
        {
            Caption = 'Industrial Classification Name';
        }
        field(50005; "ORG ID"; Text[30])
        {
            Caption = 'Department ID';
        }
        field(50006; "ORG Shema"; Code[10])
        {
            Caption = 'Org Schema';
            TableRelation = "ORG Shema".Code;
        }
        field(50007; City; Text[30])
        {
            Caption = 'City';

            trigger OnValidate()
            begin
                IF Rec."Branch Agency" = 1 THEN BEGIN
                    ECL.RESET;
                    ECL.SETFILTER("GF of work Description", '1%', Rec.Description);
                    ECL.SETFILTER(Active, '%1', TRUE);
                    IF ECL.FINDSET THEN
                        REPEAT
                            ECL.VALIDATE("GF of work Description", Rec.Description);
                            ECL.MODIFY;
                            Employee.RESET;
                            Employee.SETFILTER("No.", '%1', ECL."Employee No.");
                            IF Employee.FINDFIRST THEN BEGIN
                                ECL.CALCFIELDS("Org Entity Code");
                                Employee."Org Entity Code" := Rec."Entity Code";
                                Employee.MODIFY;
                            END;

                        UNTIL ECL.NEXT = 0;
                END;
                IF Rec."Branch Agency" = 2 THEN BEGIN
                    ECL.RESET;
                    ECL.SETFILTER("Org Unit Name", '1%', Rec.Description);
                    ECL.SETFILTER(Active, '%1', TRUE);
                    IF ECL.FINDSET THEN
                        REPEAT
                            ECL.VALIDATE("Org Unit Name", Rec.Description);
                            ECL.MODIFY;
                            Employee.RESET;
                            Employee.SETFILTER("No.", '%1', ECL."Employee No.");
                            IF Employee.FINDFIRST THEN BEGIN
                                ECL.CALCFIELDS("Org Entity Code");
                                Employee."Org Entity Code" := Rec."Entity Code";
                                Employee.MODIFY;
                            END;

                        UNTIL ECL.NEXT = 0;
                END;
            end;
        }
        field(50008; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
        }
        field(50009; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(50010; "Order"; Integer)
        {
            Caption = 'Order';
        }
        field(50011; "Branch Agency"; Option)
        {
            Caption = 'Branch Agency';
            OptionCaption = ' ,Branch,Agency';
            OptionMembers = " ",Branch,Agency;
        }
        field(50012; "Regionalni Head Office"; Option)
        {
            Caption = 'Regional office/Head Office';
            OptionCaption = ' ,Regional office,Head office';
            OptionMembers = " ","Regional Head Office","Head office";

            trigger OnValidate()
            begin
                IF Rec."Branch Agency" = 1 THEN BEGIN
                    ECL.RESET;
                    ECL.SETFILTER("GF of work Description", '1%', Rec.Description);
                    ECL.SETFILTER(Active, '%1', TRUE);
                    IF ECL.FINDSET THEN
                        REPEAT
                            ECL.VALIDATE("GF of work Description", Rec.Description);
                            ECL.MODIFY;
                            Employee.RESET;
                            Employee.SETFILTER("No.", '%1', ECL."Employee No.");
                            IF Employee.FINDFIRST THEN BEGIN
                                ECL.CALCFIELDS("Org Entity Code");
                                Employee."Org Entity Code" := Rec."Entity Code";
                                Employee.MODIFY;
                            END;

                        UNTIL ECL.NEXT = 0;
                END;
                IF Rec."Branch Agency" = 2 THEN BEGIN
                    ECL.RESET;
                    ECL.SETFILTER("Org Unit Name", '1%', Rec.Description);
                    ECL.SETFILTER(Active, '%1', TRUE);
                    IF ECL.FINDSET THEN
                        REPEAT
                            ECL.VALIDATE("Org Unit Name", Rec.Description);
                            ECL.MODIFY;
                            Employee.RESET;
                            Employee.SETFILTER("No.", '%1', ECL."Employee No.");
                            IF Employee.FINDFIRST THEN BEGIN
                                ECL.CALCFIELDS("Org Entity Code");
                                Employee."Org Entity Code" := Rec."Entity Code";
                                Employee.MODIFY;
                            END;

                        UNTIL ECL.NEXT = 0;
                END;
            end;
        }
        field(50013; GF; Text[30])
        {
        }
        field(50014; Region; Integer)
        {
            BlankZero = true;
            Caption = 'Region';
            NotBlank = false;
        }
        field(50015; "Entity Code"; Code[10])
        {
            Caption = 'Entity Code';
            Editable = true;

            trigger OnValidate()
            begin
                IF Rec."Branch Agency" = 1 THEN BEGIN
                    ECL.RESET;
                    ECL.SETFILTER("GF of work Description", '1%', Rec.Description);
                    ECL.SETFILTER(Active, '%1', TRUE);
                    IF ECL.FINDSET THEN
                        REPEAT
                            ECL.VALIDATE("GF of work Description", Rec.Description);
                            ECL.MODIFY;
                            Employee.RESET;
                            Employee.SETFILTER("No.", '%1', ECL."Employee No.");
                            IF Employee.FINDFIRST THEN BEGIN
                                Employee."Org Entity Code" := Rec."Entity Code";
                                Employee.MODIFY;
                            END;

                        UNTIL ECL.NEXT = 0;
                END;
                IF Rec."Branch Agency" = 2 THEN BEGIN
                    ECL.RESET;
                    ECL.SETFILTER("Org Unit Name", '%1', Rec.Description);
                    ECL.SETFILTER(Active, '%1', TRUE);
                    IF ECL.FINDSET THEN
                        REPEAT
                            ECL.VALIDATE("Org Unit Name", Rec.Description);
                            ECL.MODIFY;
                            Employee.RESET;
                            Employee.SETFILTER("No.", '%1', ECL."Employee No.");
                            IF Employee.FINDFIRST THEN BEGIN
                                ECL.CALCFIELDS("Org Entity Code");
                                Employee."Org Entity Code" := Rec."Entity Code";
                                Employee.MODIFY;
                            END;

                        UNTIL ECL.NEXT = 0;
                END;
            end;
        }
        field(50016; "Municipality Code for salary"; Code[20])
        {
            Caption = 'Municipality Code for salary';
            TableRelation = Municipality where(Type = filter(Regular));

            trigger OnValidate()
            begin
                IF Rec."Branch Agency" = 1 THEN BEGIN
                    ECL.RESET;
                    ECL.SETFILTER("GF of work Description", '1%', Rec.Description);
                    ECL.SETFILTER(Active, '%1', TRUE);
                    IF ECL.FINDSET THEN
                        REPEAT
                            ECL.VALIDATE("GF of work Description", Rec.Description);
                            ECL.MODIFY;
                            Employee.RESET;
                            Employee.SETFILTER("No.", '%1', ECL."Employee No.");
                            IF Employee.FINDFIRST THEN BEGIN
                                ECL.CALCFIELDS("Org Entity Code", "Municipality Code for salary");
                                Employee."Org Entity Code" := Rec."Entity Code";
                                Employee."Municipality Code for salary" := ECL."Municipality Code for salary";

                                Employee.MODIFY;
                            END;

                        UNTIL ECL.NEXT = 0;
                END;
                IF Rec."Branch Agency" = 2 THEN BEGIN
                    ECL.RESET;
                    ECL.SETFILTER("Org Unit Name", '1%', Rec.Description);
                    ECL.SETFILTER(Active, '%1', TRUE);
                    IF ECL.FINDSET THEN
                        REPEAT
                            ECL.VALIDATE("Org Unit Name", Rec.Description);
                            ECL.MODIFY;
                            Employee.RESET;
                            Employee.SETFILTER("No.", '%1', ECL."Employee No.");
                            IF Employee.FINDFIRST THEN BEGIN
                                ECL.CALCFIELDS("Org Entity Code", "Municipality Code for salary");
                                Employee."Org Entity Code" := Rec."Entity Code";
                                Employee."Municipality Code for salary" := ECL."Municipality Code for salary";

                                Employee.MODIFY;
                            END;

                        UNTIL ECL.NEXT = 0;
                END;
            end;
        }
        field(50017; "Municipality Code of agency"; Code[20])
        {
            Caption = 'Municipality Code of agency.';
            TableRelation = Municipality where(Type = filter(Regular));

            trigger OnValidate()
            begin
                IF "Municipality Code of agency" <> '' THEN BEGIN
                    Municipality.RESET;
                    Municipality.SETFILTER(Code, "Municipality Code of agency");
                    Municipality.SetFilter(type, '%1', Municipality.Type::Regular);
                    IF Municipality.FINDFIRST THEN begin
                        City := Municipality.City;
                        Canton := Municipality."Canton Code";
                    end
                    else begin
                        City := '';
                        Canton := '';
                    end;
                    Municipality.CALCFIELDS("Entity Code");
                    VALIDATE("Entity Code", Municipality."Entity Code");
                    PostCode.RESET;
                    PostCode.SETFILTER(City, Municipality.City);
                    IF PostCode.FINDFIRST THEN BEGIN
                        VALIDATE("Post Code", PostCode.Code);
                    END;
                END
                ELSE BEGIN
                    City := '';
                    "Post Code" := ' ';
                    "Entity Code" := '';
                END;


                IF Rec."Branch Agency" = 1 THEN BEGIN
                    ECL.RESET;
                    ECL.SETFILTER("GF of work Description", '1%', Rec.Description);
                    ECL.SETFILTER(Active, '%1', TRUE);
                    IF ECL.FINDSET THEN
                        REPEAT
                            ECL.VALIDATE("GF of work Description", Rec.Description);
                            ECL.MODIFY;
                            Employee.RESET;
                            Employee.SETFILTER("No.", '%1', ECL."Employee No.");
                            IF Employee.FINDFIRST THEN BEGIN
                                ECL.CALCFIELDS("Org Entity Code", "Municipality Code for salary");
                                Employee."Org Entity Code" := Rec."Entity Code";
                                Employee."Municipality Code for salary" := ECL."Municipality Code for salary";

                                Employee.MODIFY;
                            END;

                        UNTIL ECL.NEXT = 0;
                END;
                IF Rec."Branch Agency" = 2 THEN BEGIN
                    ECL.RESET;
                    ECL.SETFILTER("Org Unit Name", '1%', Rec.Description);
                    ECL.SETFILTER(Active, '%1', TRUE);
                    IF ECL.FINDSET THEN
                        REPEAT
                            ECL.VALIDATE("Org Unit Name", Rec.Description);
                            ECL.MODIFY;
                            Employee.RESET;
                            Employee.SETFILTER("No.", '%1', ECL."Employee No.");
                            IF Employee.FINDFIRST THEN BEGIN
                                ECL.CALCFIELDS("Org Entity Code", "Municipality Code for salary");
                                Employee."Org Entity Code" := Rec."Entity Code";
                                Employee."Municipality Code for salary" := ECL."Municipality Code for salary";

                                Employee.MODIFY;
                            END;

                        UNTIL ECL.NEXT = 0;
                END;
            end;
        }
        field(50018; "JIB Contributes"; Text[30])
        {
            Caption = 'JIB Contributes';
        }
        field(50019; "Municipality Code for reg."; Code[20])
        {
            Caption = 'Municipality Code for registration';
            TableRelation = Municipality where(Type = filter(Regular));
        }
        field(50020; Change; Text[150])
        {
        }
        field(50021; "For Calculation 4"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50022; "For Calculation 5"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50023; "For Calculation 6"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50024; "For Calculation 7"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50025; "For Calculation FA"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50026; "For Calculation FA 2"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50027; "For Calculation FA 3"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50028; "For Calculation 8"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50029; "For Calculation 9"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50030; "For Calculation 10"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50031; "For Calculation 11"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50032; "For Calculation 12"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50033; "For Calculation 13"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50034; "For Calculation"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50035; "For Calculation 2"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50036; "For Calculation 3"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50037; "For Calculation 14"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50038; "For Calculation 15"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50040; "For Calculation 16"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50041; "Canton"; Code[10])
        {
            Caption = 'For Calculation';
            TableRelation = Canton.Code;
        }
        field(50042; "Municipality Code CIPS"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Code", GF, Description, "Municipality Code CIPS")
        {
        }
        key(Key2; GF)
        {
        }
        key(Key3; Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Description, "Code", GF)
        {
        }
    }

    trigger OnInsert()
    begin
        /*EVALUATE(Order,Code);*/

    end;

    var
        ECL: Record "Employee Contract Ledger";
        PostCode: Record "Post Code";
        Municipality: Record "Municipality";
        Employee: Record "Employee";

    procedure Caption(): Text[100]
    var
    //    RtngHeader: Record "Payment Order by Branch Office";
    begin
        IF GETFILTERS = '' THEN
            EXIT('');

        IF Code = '' THEN
            EXIT('');

        //        RtngHeader.GET(Code);

        //  EXIT(
        //  STRSUBSTNO('%1 %2 %3',
        //  Code, RtngHeader.SvrhaDoznake1, "Registration No."));
    end;
}

