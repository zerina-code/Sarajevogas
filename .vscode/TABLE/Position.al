table 50135 Position
{
    // //8

    Caption = 'Position';
    DrillDownPageID = Positions;
    LookupPageID = Positions;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';

            trigger OnValidate()
            begin
                //IF NOT "Changing Position" THEN BEGIN
                Pos.SETCURRENTKEY(Code, Order);
                Pos.SETFILTER(Code, '%1', Code);
                Pos.SETFILTER("Org. Structure", '%1', "Org. Structure");

                IF Pos.FINDLAST THEN BEGIN
                    EVALUATE(PosIDInt, Pos."Position ID");
                    PosIDInt += 1;
                    "Position ID" := FORMAT(PosIDInt);
                    Description := Pos.Description;
                    "Cube Codes" := Pos."Cube Codes";
                    Type := Pos.Type;
                    "Cost Type" := Pos."Cost Type";
                    "Wellcome E-mail" := Pos."Wellcome E-mail";
                    "E-learning application" := Pos."E-learning application";
                    "E-learning education" := Pos."E-learning education";
                    "Education plan" := Pos."Education plan";
                    Test := Pos.Test;
                    "On Boarding" := Pos."On Boarding";
                    "Attachment 1" := Pos."Attachment 1";
                    "Attachment 2" := Pos."Attachment 2";
                    Agency := Pos.Agency;
                    Vocation := Pos.Vocation;
                    "Vocation Description" := Pos."Vocation Description";
                    "Key Function" := Pos."Key Function";
                    "Control Function" := Pos."Control Function";
                    "BJF/GJF" := Pos."BJF/GJF";
                    Role := Pos.Role;
                    //      "Role Name" := Pos."Role Name";

                END
                ELSE BEGIN
                    "Position ID" := FORMAT(1);
                END;


                PosMenu.RESET;
                PosMenu.SETFILTER(Code, '%1', Code);
                PosMenu.SETFILTER(Description, '%1', Description);
                PosMenu.SETFILTER("Org. Structure", '%1', "Org. Structure");
                IF NOT PosMenu.FINDFIRST THEN BEGIN
                    "Position ID" := FORMAT(1);
                    PositionMenu1.INIT;
                    PositionMenu1.Code := Code;
                    PositionMenu1.Description := Description;
                    PositionMenu1."Department Code" := "Department Code";
                    PositionMenu1."Org. Structure" := "Org. Structure";
                    PositionMenu1.INSERT;

                END;


                /*ECL.RESET;
                ECL.SETFILTER("Org. Structure",'%1', "Org. Structure");
                ECL.SETFILTER("Position Code",'%1', xRec.Code);
                ECL.SETFILTER("Employee Status",'%1', 0);
                ECL.SETFILTER("Position ID",'%1', xRec."Position ID");
                ECL.SETFILTER("Employee No.",'%1',"Employee No.");
                IF ECL.FINDFIRST THEN
                  BEGIN
                  PosChangeID.RESET;
                  PosChangeID.SETFILTER("Changing Position",'%1',TRUE);
                  IF PosChangeID.FINDSET THEN BEGIN
                    "Position ID":=ECL."Position ID";
                
                  END;
                  END;
                  IF "Position ID"<>'' THEN
                EVALUATE(Order,"Position ID");
                  //END;
                 // END;*/

                /*WPConnSetup.FINDFIRST();
                
                
                CREATE(conn, TRUE, TRUE);
                
                conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                          +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
                
                CREATE(comm,TRUE, TRUE);
                
                lvarActiveConnection := conn;
                comm.ActiveConnection := lvarActiveConnection;
                
                comm.CommandText := 'dbo.Position_Insert';
                comm.CommandType := 4;
                comm.CommandTimeout := 0;
                
                param:=comm.CreateParameter('@OldCode', 200, 1, 10, xRec.Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Code', 200, 1, 10, Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Descriptiom', 200, 1, 100, Description);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@DepartmentCode', 200, 1, 10, "Department Code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@EduLevel', 200, 1, 30, "Minimal Education Level");
                comm.Parameters.Append(param);
                
                comm.Execute;
                conn.Close;
                CLEAR(conn);
                CLEAR(comm);*/

            end;
        }
        field(2; "Position ID"; Code[20])
        {
            Caption = 'Position ID';

            trigger OnValidate()
            begin
                ECL.RESET;
                ECL.SETFILTER("Org. Structure", '%1', "Org. Structure");
                ECL.SETFILTER("Position Code", '%1', Code);
                //ECL.SETFILTER("Employee Status",'%1', 0);
                ECL.SETFILTER("Position ID", '%1', "Position ID");
                ECL.SETFILTER(Active, '%1', TRUE);
                IF ECL.FINDFIRST THEN BEGIN
                    "Employee No." := ECL."Employee No.";
                    "Employee Full Name" := ECL."Employee Name";
                END
                ELSE BEGIN
                    "Employee No." := '';
                    "Employee Full Name" := '';
                END;
                IF "Position ID" <> '' THEN
                    EVALUATE(Order, "Position ID");


                /*WPConnSetup.FINDFIRST();
                
                
                CREATE(conn, TRUE, TRUE);
                
                conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                          +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
                
                CREATE(comm,TRUE, TRUE);
                
                lvarActiveConnection := conn;
                comm.ActiveConnection := lvarActiveConnection;
                
                comm.CommandText := 'dbo.Position_Insert';
                comm.CommandType := 4;
                comm.CommandTimeout := 0;
                
                param:=comm.CreateParameter('@OldCode', 200, 1, 10, xRec.Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Code', 200, 1, 10, Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Descriptiom', 200, 1, 100, Description);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@DepartmentCode', 200, 1, 10, "Department Code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@EduLevel', 200, 1, 30, "Minimal Education Level");
                comm.Parameters.Append(param);
                
                comm.Execute;
                conn.Close;
                CLEAR(conn);
                CLEAR(comm);*/

            end;
        }
        field(3; "Department Code"; Code[30])
        {
            Caption = 'Department Code';
            Editable = true;
            TableRelation = Department.Code WHERE("ORG Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin

                /*WPConnSetup.FINDFIRST();
                
                
                CREATE(conn, TRUE, TRUE);
                
                conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                          +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
                
                CREATE(comm,TRUE, TRUE);
                
                lvarActiveConnection := conn;
                comm.ActiveConnection := lvarActiveConnection;
                
                comm.CommandText := 'dbo.Position_Insert';
                comm.CommandType := 4;
                comm.CommandTimeout := 0;
                
                param:=comm.CreateParameter('@OldCode', 200, 1, 10, xRec.Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Code', 200, 1, 10, Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Descriptiom', 200, 1, 100, Description);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@DepartmentCode', 200, 1, 10, "Department Code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@EduLevel', 200, 1, 30, "Minimal Education Level");
                comm.Parameters.Append(param);
                
                comm.Execute;
                conn.Close;
                CLEAR(conn);
                CLEAR(comm);*/

                //NK3.11 "Default Dimension":=Department."ORG Dio"+'-'+"Department Code";


                /*PosMenu.SETFILTER(Code,'%1',Code);
                PosMenu.SETFILTER("Org. Structure",'%1',"Org. Structure");
                IF PosMenu.FIND('-') THEN BEGIN
                 PosMenu.Description:=Description;
                 PosMenu."Org. Structure":="Org. Structure";
                 PosMenu."Department Code":="Department Code";
                 IF Description<>PosMenu.Description THEN
                 PosMenu.MODIFY;
                 END;
                */
                /*PosI.SETFILTER("Department Code","Department Code");
                PosI.SETFILTER(Code,Code);
                IF PosI.FIND('-') THEN BEGIN
                PosMenu.SETFILTER(Code,'%1',PosI.Code);
                PosMenu.SETFILTER("Department Code",PosI."Department Code");
                PosMenu.SETFILTER("Org. Structure",PosI."Org. Structure");
                 IF PosMenu.FIND('-') THEN BEGIN
                 PosI."Position Menu Identity":=PosMenu."Position Menu Identity";
                 END;
                 END;
                 */
                IF ("Department Category" <> '') AND ("Group Code" = '') THEN BEGIN
                    Department.RESET;
                    Department.SETFILTER("ORG Shema", '%1', "Org. Structure");
                    Department.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
                    IF Department.FINDFIRST THEN BEGIN
                        DepartmentNamePage.SETTABLEVIEW(Department);
                        DepartmentNamePage.SETRECORD(Department);
                        DepartmentNamePage.GETRECORD(Department);
                        "Department Name" := Department.Description;
                    END;
                END;

            end;
        }
        field(4; "Minimal Education Level"; Option)
        {
            Caption = 'Education level';
            OptionCaption = ' ,I Stepen četri razreda osnovne,II Stepen - osnovna škola,III Stepen - SSS srednja škola,IV Stepen - SSS srednja škola,V Stepen - VKV - SSS srednja škola,VI Stepen - VS viša škola,VII Stepen - VSS visoka stručna sprema,VII-1 Stepen - Specijalista,VII-2 Stepen - Magistratura,VIII Stepen - Doktorat  ';
            OptionMembers = Empty,NSS,KV,VSS,MR,DR;

            trigger OnValidate()
            begin

                /*WPConnSetup.FINDFIRST();
                
                
                CREATE(conn, TRUE, TRUE);
                
                conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                          +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
                
                CREATE(comm,TRUE, TRUE);
                
                lvarActiveConnection := conn;
                comm.ActiveConnection := lvarActiveConnection;
                
                comm.CommandText := 'dbo.Position_Insert';
                comm.CommandType := 4;
                comm.CommandTimeout := 0;
                
                param:=comm.CreateParameter('@OldCode', 200, 1, 10, xRec.Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Code', 200, 1, 10, Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Descriptiom', 200, 1, 100, Description);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@DepartmentCode', 200, 1, 10, "Department Code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@EduLevel', 200, 1, 30, "Minimal Education Level");
                comm.Parameters.Append(param);
                
                comm.Execute;
                conn.Close;
                CLEAR(conn);
                CLEAR(comm);*/

            end;
        }
        field(5; NSP; Decimal)
        {
        }
        field(6; "PAy grade"; Integer)
        {
        }
        field(50004; "No. of Working Places"; Integer)
        {
            Caption = 'No. of Working Places';
        }
        field(50005; "Education Level"; Option)
        {
            Caption = 'Education level';
            OptionCaption = ' ,I Stepen četiri razreda osnovne,II Stepen - osnovna škola,III Stepen - SSS srednja škola,IV Stepen - SSS srednja škola,V Stepen - VKV - SSS srednja škola,VI Stepen - VS viša škola,VII Stepen - VSS visoka stručna sprema,VII-1 Stepen - Specijalista,VII-2 Stepen - Magistratura,VIII Stepen - Doktorat  ';
            OptionMembers = " ","I Stepen četiri razreda osnovne","II Stepen - osnovna škola","III Stepen - SSS srednja škola","IV Stepen - SSS srednja škola","V Stepen - VKV - SSS srednja škola","VI Stepen - VS viša škola","VII Stepen - VSS visoka stručna sprema","VII-1 Stepen - Specijalista","VII-2 Stepen - Magistratura","VIII Stepen - Doktorat  ";
        }
        field(50007; Description; Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                /*
                Pos.RESET;
                
                BEGIN
                  Pos.SETRANGE(Description,xRec.Description);
                  Pos.SETFILTER("Org. Structure",'%1',Rec."Org. Structure");
                  Pos.SETFILTER(Code,'%1',Rec.Code);
                  IF Pos.FIND('-') THEN REPEAT
                       {Pos2:=Pos;
                       Pos2.RENAME(Pos.Code,Pos."Position ID",Pos."Org. Structure",xRec.Description);
                       Pos2.GET(Pos2.Code,Pos2."Position ID",Pos2."Org. Structure",Pos2.Description);}
                       IF Pos.GET(Pos.Code,Pos."Position ID",Pos."Org. Structure",Pos.Description)
                       THEN
                       Pos.RENAME(Pos.Code,Pos."Position ID",Pos."Org. Structure",xRec.Description);
                    UNTIL Pos.NEXT=0;
                    END;*/
                /*WPConnSetup.FINDFIRST();
                
                
                CREATE(conn, TRUE, TRUE);
                
                conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                          +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
                
                CREATE(comm,TRUE, TRUE);
                
                lvarActiveConnection := conn;
                comm.ActiveConnection := lvarActiveConnection;
                
                comm.CommandText := 'dbo.Position_Insert';
                comm.CommandType := 4;
                comm.CommandTimeout := 0;
                
                param:=comm.CreateParameter('@OldCode', 200, 1, 10, xRec.Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Code', 200, 1, 10, Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Descriptiom', 200, 1, 100, Description);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@DepartmentCode', 200, 1, 10, "Department Code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@EduLevel', 200, 1, 30, "Minimal Education Level");
                comm.Parameters.Append(param);
                
                comm.Execute;
                conn.Close;
                CLEAR(conn);
                CLEAR(comm);*/

                /*NK3.11
                SD.SETFILTER("Position No.",'%1',Code);
                SD.SETFILTER(Description,'%1',Description);
                IF NOT SD.FIND('-') THEN BEGIN
                SD."Position No.":=Code;
                SD.Description:=Description;
                SD.Coefficient:=0;
                SD."Starting Date":=TODAY;
                SD."Segmentation Code":='NESEGMENTIRANO';
                SD.INSERT;
                END;*/

                PosMenu.SETFILTER(Code, '%1', Code);
                PosMenu.SETFILTER(Description, '%1', Description);
                PosMenu.SETFILTER("Org. Structure", '%1', "Org. Structure");
                IF PosMenu.FIND('-') THEN BEGIN
                    IF PositionMenu1.GET(PosMenu.Code, PosMenu.Description, PosMenu."Department Code", PosMenu."Org. Structure") THEN
                        PositionMenu1.RENAME(PosMenu.Code, Description, PosMenu."Department Code", PosMenu."Org. Structure");
                END
                ELSE BEGIN
                    PosMenu.RESET;
                    PosMenu.SETFILTER(Code, '%1', Code);
                    PosMenu.SETFILTER("Org. Structure", '%1', "Org. Structure");
                    IF PosMenu.FINDFIRST THEN BEGIN
                        PosMenu.RENAME(Code, Description, "Department Code", "Org. Structure");
                    END;
                END;
                IF (xRec.Description <> Rec.Description) AND (xRec.Description <> '') THEN BEGIN
                    PositionMenu1.RESET;
                    PositionMenu1.SETFILTER(Description, xRec.Description);
                    PositionMenu1.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                    IF PositionMenu1.FINDFIRST THEN BEGIN
                        IF PositionMenu1.GET(Code, xRec.Description, "Department Code", "Org. Structure") THEN
                            PositionMenu1.DELETE;
                    END;
                END;

            end;
        }
        field(50008; "Org. Structure"; Code[20])
        {
            Caption = 'Org. Structure';
            TableRelation = "ORG Shema";
        }
        field(50009; Status; enum "Employee Status")
        {
            CalcFormula = Lookup(Employee.Status WHERE("No." = FIELD("Employee No.")));
            Caption = 'Status';
            FieldClass = FlowField;

        }
        field(50320; "Manager Department Code"; Code[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position."Department Code" WHERE("Code" = FIELD("Manager Position Code"),
                                                                   "Position ID" = FIELD("Manager Position ID"),
                                                                   "Org. Structure" = FIELD("Org. Structure")));
            Caption = 'Manager Department Code';

            TableRelation = Department.Code;
        }
        field(50321; "Manager Position Code"; Code[20])
        {
            Caption = 'Manager Position Code';
            TableRelation = Position.Code;

            trigger OnValidate()
            begin
                ECL.RESET;
                ECL.SETFILTER("Org. Structure", '%1', "Org. Structure");
                ECL.SETFILTER("Position Code", '%1', "Manager Position Code");
                ECL.SETFILTER("Employee Status", '%1', 0);
                IF "Manager Position ID" <> '' THEN
                    ECL.SETFILTER("Position ID", '%1', "Manager Position ID");
                IF ECL.FINDFIRST THEN BEGIN
                    "Manager 1 Name" := ECL."Employee Name";
                    "Manager 1" := ECL."Employee No.";

                END;
            end;
        }
        field(50322; "Manager Position ID"; Code[20])
        {
            Caption = 'Manager Position ID';
            TableRelation = Position."Position ID" WHERE("Code" = FIELD("Manager Position Code"));

            trigger OnValidate()
            begin
                ECL.RESET;
                ECL.SETFILTER("Org. Structure", '%1', "Org. Structure");
                ECL.SETFILTER("Position Code", '%1', "Manager Position Code");
                ECL.SETFILTER("Employee Status", '%1', 0);
                IF "Manager Position ID" <> '' THEN
                    ECL.SETFILTER("Position ID", '%1', "Manager Position ID");
                IF ECL.FINDFIRST THEN BEGIN
                    "Manager 1 Name" := ECL."Employee Name";
                    "Manager 1" := ECL."Employee No.";
                END;

                /*
                WDV.SETFILTER("Employee No.",'%1',"Employee No.");
                WDV.SETFILTER(Active,'%1',TRUE);
                IF WDV.FIND('-') THEN repeat
                WDV."Department Name":="Department Name";
                CALCFIELDS("Position Description","B-1 (with regions) Description","B-1 Description","Stream Description");
                WDV."Position Description":="Position Description";
                WDV."B-1 (with regions) Description":="B-1 (with regions) Description";
                WDV."B-1 Description":="B-1 Description";
                WDV."Stream Description":="Stream Description";
                UNTIL WDV.NEXT=0;
                
                WDVM.SETFILTER("Employee No.",'%1',"Manager 1");
                WDVM.SETFILTER(Active,'%1',TRUE);
                IF WDVM.FIND('-') THEN repeat
                WDVM."Department Name":="Department Name";
                CALCFIELDS("Position Description","B-1 (with regions) Description","B-1 Description","Stream Description");
                WDVM."Position Description":="Position Description";
                WDVM."B-1 (with regions) Description":="B-1 (with regions) Description";
                WDVM."B-1 Description":="B-1 Description";
                WDVM."Stream Description":="Stream Description";
                UNTIL WDVM.NEXT=0;
                
                WDVR.SETFILTER("Employee No.",'%1',"Manager 1");
                WDVR.SETFILTER(Active,'%1',TRUE);
                IF WDVR.FIND('-') THEN repeat
                WDVR."Department Name":="Department Name";
                CALCFIELDS("Position Description","B-1 (with regions) Description","B-1 Description","Stream Description");
                WDVR."Position Description":="Position Description";
                WDVR."B-1 (with regions) Description":="B-1 (with regions) Description";
                WDVR."B-1 Description":="B-1 Description";
                WDVR."Stream Description":="Stream Description";
                UNTIL WDVR.NEXT=0;*/

            end;
        }
        field(50323; "Manager Department Code 2"; Code[20])
        {
            Caption = 'Manager Department Code 2';
            TableRelation = Department.Code;
        }
        field(50324; "Manager Position Code 2"; Code[20])
        {
            Caption = 'Manager Department Code';
            TableRelation = Position.Code;
        }
        field(50325; "Manager Position ID 2"; Code[20])
        {
            Caption = 'Manager Department ID 2';
            TableRelation = Position."Position ID";
        }
        field(50326; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(50327; "Cost Type"; Code[20])
        {
            TableRelation = "Cost Type";
        }
        field(50328; Type; Code[20])
        {
            //   TableRelation = Type;
        }
        field(50329; "Cube Codes"; Code[30])
        {
            //   TableRelation = "Cube codes";
        }
        field(50330; "Order"; Integer)
        {
            Caption = 'Order';
        }
        field(50331; "Manager 1"; Code[20])
        {
            Caption = 'Manager 1';
            FieldClass = Normal;

            trigger OnValidate()
            begin
                //CALCFIELDS("Manager 1 First Name","Manager 1 Last Name","Manager 1 Position Code");
            end;
        }
        field(50332; "Manager 1 Name"; Text[30])
        {
            Caption = 'Manager 1 Name';
            Editable = true;
            FieldClass = Normal;
        }
        field(50333; "E-learning application"; Boolean)
        {
            Caption = 'E-learning application';
        }
        field(50334; "E-learning education"; Boolean)
        {
            Caption = 'E-learning education';
        }
        field(50335; "On Boarding"; Boolean)
        {
            Caption = 'On Boarding';
        }
        field(50336; "Education plan"; Boolean)
        {
            Caption = 'Education plan';
        }
        field(50337; Test; Boolean)
        {
            Caption = 'Test';
        }
        field(50338; "Employee No."; Code[10])
        {
            Caption = 'Employee No.';
            FieldClass = Normal;
        }
        field(50339; "Employee Full Name"; Text[100])
        {
            Caption = 'Employee Full Name';
            FieldClass = Normal;
        }
        field(50340; "Attachment 1"; Text[250])
        {
            Caption = 'Attachment 1';
        }
        field(50341; "Attachment 2"; Text[250])
        {
            Caption = 'Attachment 2';
        }
        field(50342; "Default Dimension"; Code[10])
        {
            Caption = 'Defaul Dimension';
        }


        field(50345; Systemized; Boolean)
        {
            Caption = 'Systemized';
        }
        field(50346; "Wellcome E-mail"; Boolean)
        {
            Caption = 'Wellcome E-mail';
        }
        field(50347; "Active Position"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Max("Employee Contract Ledger".Active WHERE("Employee No." = FIELD("Employee No."),
                                                                       "Position Code" = FIELD("Code"),
                                                                       "Position Description" = FIELD("Description"),
                                                                       "Department Code" = FIELD("Department Code")));

        }
        field(50348; "Department Name"; Text[250])
        {
            Caption = 'Department Name';
            /*   TableRelation = IF ("Sector  Description" = FILTER(<> ''),
                                   "Department Category" = FILTER('')) Department.Description WHERE("ORG Shema" = FIELD("Org. Structure"),
                                                                                                 "Department Type" = CONST(Sector),
                                                                                                 "Sector  Description" = FIELD("Sector  Description"))
               ELSE
               IF ("Group Description" = FILTER(''),
                                                                                                          "Department Category" = FILTER(<> '')) Department.Description WHERE("ORG Shema" = FIELD("Org. Structure"),
                                                                                                                                                                          "Department Type" = CONST(Department),
                                                                                                                                                                          "Department Categ.  Description" = FIELD("Department Categ.  Description"))
               ELSE
               IF ("Group Description" = FILTER(<> ''),
                                                                                                                                                                                   "Team Code" = FILTER('')) Department.Description WHERE("ORG Shema" = FIELD("Org. Structure"),
                                                                                                                                                                                                                                       "Department Type" = CONST("Group"),
                                                                                                                                                                                                                                       "Group Description" = FIELD("Group Description"))
               ELSE
               IF ("Team Description" = FILTER(<> '')) Department.Description WHERE("ORG Shema" = FIELD("Org. Structure"),
                                                                                                                                                                                                                                                                                                             "Department Type" = CONST("Team"),
                                                                                                                                                                                                                                                                                                             "Team Description" = FIELD("Team Description"));
   */
            trigger OnLookup()
            begin
                IF ("Department Category" <> '') AND ("Group Code" = '') THEN BEGIN
                    Department.RESET;
                    Department.SETFILTER("ORG Shema", '%1', "Org. Structure");
                    Department.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
                    IF Department.FINDFIRST THEN BEGIN
                        DepartmentNamePage.SETTABLEVIEW(Department);
                        DepartmentNamePage.SETRECORD(Department);
                        DepartmentNamePage.GETRECORD(Department);
                        "Department Name" := Department.Description;
                    END;
                END;
            end;
        }
        field(50349; "Manager Department Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Department.Description WHERE("Code" = FIELD("Manager Department Code"),
                                                               "ORG Shema" = FIELD("Org. Structure")));
            Caption = 'Manager Department Name';

        }
        field(50350; "Manager 1 Code"; Code[20])
        {
            Caption = 'Manager 1';
            FieldClass = Normal;

            trigger OnValidate()
            begin
                //CALCFIELDS("Manager 1 First Name","Manager 1 Last Name","Manager 1 Position Code");



                emp.SETFILTER("No.", "Manager 1 Code");
                IF emp.FINDFIRST THEN BEGIN
                    "Manager Name 1" := emp."First Name" + ' ' + emp."Last Name";

                END;
            end;
        }
        field(50351; "Disc. Department Code"; Code[30])
        {
            Caption = 'Department Code';
            Editable = true;
            TableRelation = Department.Code WHERE("ORG Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin
                IF "Management Level".AsInteger() = 2 //EXE ODGOVARA CEO
                  THEN BEGIN
                    HeadOf.RESET;
                    HeadOf.SETFILTER("Management Level", '%1', 1); //PRONA?I CEO (6)
                    HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                    IF HeadOf.FINDFIRST THEN BEGIN
                        HeadOf.CALCFIELDS("Employee No.");
                        "Manager 1 Code" := HeadOf."Employee No.";
                        "Manager 2 Code" := '';
                        "Manager 2  Department Code" := '';
                        "Manager 2 Position Code" := '';
                        "Manager 2 Position ID" := '';
                        "Disc. Department Code" := HeadOf."Department Code";
                        "Disc. Department Name" := '';
                    END
                    ELSE BEGIN
                        "Manager 1 Code" := '';
                        "Manager 2 Code" := '';
                        "Manager 2  Department Code" := '';
                        "Manager 2 Position Code" := '';
                        "Manager 2 Position ID" := '';
                        "Disc. Department Code" := '';
                        "Disc. Department Name" := '';
                    END;
                END;





                IF "Management Level".AsInteger() = 1 //UPRAVAA NIKOM
                THEN BEGIN
                    "Manager 1 Code" := '';
                    "Manager 2 Code" := '';
                    "Disc. Department Code" := '';
                    "Disc. Department Name" := '';
                    "Manager 1  Department Code" := '';
                    "Manager 2  Department Code" := '';
                    "Manager 2 Position Code" := '';
                    "Manager 2 Position ID" := '';
                END;



                IF "Management Level".AsInteger() = 3 THEN BEGIN //B1 ODGOVARA IZVRSNOM DIREKTORU TE ORGANIZACIJE

                    //

                    ExeManager.Reset();
                    ExeManager.SetFilter("ORG Shema", '%1', Rec."Org. Structure");
                    if Rec."Department Category" = '' then
                        ExeManager.SetFilter("Subordinate Org Code", '%1', Rec.Sector);
                    if Rec."Department Categ.  Description" = '' then
                        ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Sector  Description");

                    if (Rec."Group Code" = '') and (rec."Department Category" <> '') then
                        ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Department Category");
                    if (Rec."Group Description" = '') and (Rec."Department Categ.  Description" <> '') then
                        ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Department Categ.  Description");

                    if Rec."Group Code" <> '' then
                        ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Group Code");
                    if Rec."Group Description" <> '' then
                        ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Group Description");



                    if ExeManager.FindFirst() then begin
                        Posa.Reset();
                        Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                        Posa.SetFilter(Code, '%1', ExeManager."Position Code");
                        Posa.SetFilter(Description, '%1', ExeManager."Position Description");
                        if Posa.FindFirst() then begin
                            Uprava := Posa.Code
                        end
                        else begin
                            Posa.Reset();
                            Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                            Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                            if Posa.FindFirst() then
                                Uprava := Posa.Code
                            else
                                Uprava := '';

                        end;


                    end
                    else begin

                        Posa.Reset();
                        Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                        Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                        if Posa.FindFirst() then
                            Uprava := Posa.Code
                        else
                            Uprava := '';
                    end;

                    HeadOf.RESET;
                    HeadOf.RESET;
                    HeadOf.SETFILTER("Position code", '%1', Uprava);
                    HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");

                    IF HeadOf.FINDFIRST THEN BEGIN
                        HeadOf.CALCFIELDS("Employee No.");
                        "Manager 1 Code" := HeadOf."Employee No.";
                        Position.RESET;
                        Position.SETFILTER("Employee No.", '%1', "Manager 1 Code");
                        Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                        IF Position.FINDFIRST THEN BEGIN

                            "Manager 1  Department Code" := Position."Department Code";
                            "Manager 1 Position Code" := Position.Code;
                            "Manager 1 Position ID" := Position."Position ID";
                        END
                        ELSE BEGIN
                            "Manager 1  Department Code" := '';
                            "Manager 1 Position Code" := '';
                            "Manager 1 Position ID" := '';
                        END;
                        if "Disc. Department Code" <> '' then
                            "Disc. Department Code" := HeadOf."Department Code";
                        "Disc. Department Name" := '';
                    END;
                    IF "Manager 1 Code" = '' THEN BEGIN
                        HeadOf.RESET;
                        HeadOf.SETFILTER("Management Level", '%1', 1); //DRUGI NADRE?ENI
                        HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                        IF HeadOf.FINDFIRST THEN BEGIN
                            HeadOf.CALCFIELDS("Employee No.");
                            "Manager 1 Code" := HeadOf."Employee No.";
                            "Manager 1  Department Code" := HeadOf."Department Code";
                            "Manager 1 Position Code" := HeadOf."Position Code";
                            Position.RESET;
                            Position.SETFILTER("Employee No.", '%1', "Manager 1 Code");
                            Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                            IF Position.FINDFIRST THEN BEGIN
                                "Manager 1 Position ID" := Position."Position ID";

                            END;
                        END;
                    END;
                    HeadOf.RESET;
                    HeadOf.SETFILTER("Management Level", '%1', 1); //DRUGI NADRE?ENI
                    HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                    IF HeadOf.FINDFIRST THEN BEGIN
                        HeadOf.CALCFIELDS("Employee No.");
                        "Manager 2 Code" := HeadOf."Employee No.";
                        "Manager 2  Department Code" := HeadOf."Department Code";
                        "Manager 2 Position Code" := HeadOf."Position Code";
                        Position.RESET;
                        Position.SETFILTER("Employee No.", '%1', "Manager 2 Code");
                        Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                        IF Position.FINDFIRST THEN BEGIN
                            "Manager 2 Position ID" := Position."Position ID";

                        END
                        ELSE BEGIN
                            "Manager 2 Position ID" := '';
                            "Manager 2 Position Code" := '';
                        END;

                        "Disc. Department Name" := '';
                        IF "Manager 1 Code" = "Manager 2 Code" THEN BEGIN
                            "Manager 2 Code" := '';
                            "Manager 2 Position Code" := '';
                            "Manager 2  Department Code" := '';
                            "Disc. Department Name" := '';
                            "Manager 2 Position ID" := '';
                        END;
                    END;
                END;




                //AKO JE B2 MO?E I?I LEVELIMA IZNAD UKOLIKO NEMA

                IF ("Management Level".AsInteger() = 4) THEN BEGIN  //EXE ODGOVARA CEO


                    ExeManager.Reset();
                    ExeManager.SetFilter("ORG Shema", '%1', Rec."Org. Structure");
                    if Rec."Department Category" = '' then
                        ExeManager.SetFilter("Subordinate Org Code", '%1', Rec.Sector);
                    if Rec."Department Categ.  Description" = '' then
                        ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Sector  Description");

                    if (Rec."Group Code" = '') and (rec."Department Category" <> '') then
                        ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Department Category");
                    if (Rec."Group Description" = '') and (Rec."Department Categ.  Description" <> '') then
                        ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Department Categ.  Description");

                    if Rec."Group Code" <> '' then
                        ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Group Code");
                    if Rec."Group Description" <> '' then
                        ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Group Description");

                    if ExeManager.FindFirst() then begin
                    end;



                    HeadOf.SETFILTER("Team Code", '%1', '');
                    HeadOf.SETFILTER("Group Code", '%1', '');
                    HeadOf.SETFILTER("Department Category", '%1', '');
                    HeadOf.SETFILTER(Sector, '%1', Sector);
                    HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                    HeadOf.SETFILTER("Management Level", '%1', 3);
                    IF HeadOf.FIND('-') THEN BEGIN
                        HeadOf.CALCFIELDS("Employee No.");
                        "Manager 1 Code" := HeadOf."Employee No.";
                        Position.RESET;
                        Position.SETFILTER("Employee No.", '%1', "Manager 1 Code");
                        Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                        IF Position.FIND('-') THEN BEGIN

                            "Manager 1  Department Code" := Position."Department Code";
                            "Manager 1 Position Code" := Position.Code;
                            "Manager 1 Position ID" := Position."Position ID";

                        END
                        ELSE BEGIN
                            "Manager 1 Code" := '';
                            "Manager 1  Department Code" := '';
                            "Manager 1 Position ID" := '';
                            "Manager 1 Position Code" := '';
                            "Disc. Department Name" := '';

                        END;
                        Position.RESET;
                        Position.SETFILTER("Employee No.", '%1', "Manager 1 Code");
                        Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                        IF Position.FINDFIRST THEN BEGIN
                            Position.CALCFIELDS("Manager 1  Department Code", "Manager 1 Position Code", "Manager 1 Position ID");
                            "Manager 2 Code" := Position."Manager 1 Code";
                            "Manager 2  Department Code" := Position."Manager 1  Department Code";
                            "Manager 2 Position Code" := Position."Manager 1 Position Code";
                            "Manager 2 Position ID" := Position."Manager 1 Position ID";
                        END
                        ELSE BEGIN
                            "Manager 2  Department Code" := '';
                            "Manager 2 Position Code" := '';
                            "Manager 2 Position ID" := '';
                            "Manager 2 Code" := '';
                        END;
                        "Disc. Department Name" := '';
                    END
                    ELSE BEGIN
                        "Manager 1 Code" := '';
                        "Disc. Department Name" := '';
                        "Manager 1  Department Code" := '';
                        "Manager 1 Position Code" := '';
                        "Manager 1 Position ID" := '';
                        "Manager 2 Code" := '';
                        "Manager 2  Department Code" := '';
                        "Manager 2 Position Code" := '';
                        "Manager 2 Position ID" := '';
                    END;







                    //drugi nadre?eni
                    IF "Manager 1 Code" = '' THEN BEGIN

                        FOR i := 1 TO STRLEN("Department Code") DO BEGIN
                            String := "Department Code";
                            IF String[i] = '.' THEN BEGIN
                                Brojac := Brojac + 1;
                                IF Brojac = 1 THEN
                                    PozicijaUprava := i;
                            END;
                        END;
                        HeadOf.RESET;
                        HeadOf.SETFILTER("Department Code", '%1', COPYSTR("Department Code", 1, PozicijaUprava));
                        HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                        IF HeadOf.FIND('-') THEN BEGIN
                            HeadOf.CALCFIELDS("Employee No.");
                            "Manager 2 Code" := HeadOf."Employee No.";
                            Position.RESET;
                            Position.SETFILTER("Employee No.", '%1', "Manager 2 Code");
                            Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                            IF Position.FIND('-') THEN BEGIN

                                "Manager 2  Department Code" := Position."Department Code";
                                "Manager 2 Position Code" := Position.Code;
                                "Manager 2 Position ID" := Position."Position ID";
                            END
                            ELSE BEGIN
                                "Manager 2  Department Code" := '';
                                "Manager 2 Position Code" := '';
                                "Manager 2 Position ID" := '';
                            END;
                        END;
                    END;

                END;





                //AKO JE B3 MO?E BITI LEVELIMA IZNAD
                IF ("Management Level".AsInteger() = 5) THEN BEGIN  //

                    ExeManager.Reset();
                    ExeManager.SetFilter("ORG Shema", '%1', Rec."Org. Structure");

                    if Rec."Department Category" = '' then
                        ExeManager.SetFilter("Subordinate Org Code", '%1', Rec.Sector);
                    if Rec."Department Categ.  Description" = '' then
                        ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Sector  Description");

                    if (Rec."Group Code" = '') and (rec."Department Category" <> '') then
                        ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Department Category");
                    if (Rec."Group Description" = '') and (Rec."Department Categ.  Description" <> '') then
                        ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Department Categ.  Description");

                    if Rec."Group Code" <> '' then
                        ExeManager.SetFilter("Subordinate Org Code", '%1', Rec."Group Code");
                    if Rec."Group Description" <> '' then
                        ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Group Description");
                    if ExeManager.FindFirst() then begin
                        Posa.Reset();
                        Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                        Posa.SetFilter(Code, '%1', ExeManager."Position Code");
                        Posa.SetFilter(Description, '%1', ExeManager."Position Description");
                        if Posa.FindFirst() then begin
                            Uprava := Posa.Code


                        end;
                    end;




                    //ovo je voditelj odjela

                    if Uprava = '' then begin

                        HeadOf.RESET;
                        HeadOf.SETFILTER("Team Code", '%1', '');
                        HeadOf.SETFILTER("Group Code", '%1', '');
                        HeadOf.SETFILTER("Department Category", '%1', "Department Category");
                        HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                        HeadOf.SETFILTER("Management Level", '%1', 4);
                    end

                    else begin
                        HeadOf.Reset();
                        HeadOf.SETFILTER("Position Code", '%1', ExeManager."Position Code");
                        HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                        HeadOf.SETFILTER("Management Level", '<>%1 & <>%2', HeadOf."Management Level"::Empty, HeadOf."Management Level"::E);


                    end;
                    //da mu je nadređeni šef službe
                    IF HeadOf.FIND('-') THEN BEGIN
                        HeadOf.CALCFIELDS("Employee No.");
                        "Manager 1 Code" := HeadOf."Employee No.";
                        "Disc. Department Name" := '';

                        Position.RESET;
                        Position.SETFILTER("Employee No.", '%1', "Manager 1 Code");
                        Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                        IF Position.FIND('-') THEN BEGIN

                            "Manager 1  Department Code" := Position."Department Code";
                            "Manager 1 Position Code" := Position.Code;
                            "Manager 1 Position ID" := Position."Position ID";

                        END;
                        Position.RESET;
                        Position.SETFILTER("Employee No.", '%1', "Manager 1 Code");
                        Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                        IF Position.FINDFIRST THEN BEGIN
                            Position.CALCFIELDS("Manager 1  Department Code", "Manager 1 Position Code", "Manager 1 Position ID");
                            "Manager 2 Code" := Position."Manager 1 Code";
                            "Manager 2  Department Code" := Position."Manager 1  Department Code";
                            "Manager 2 Position Code" := Position."Manager 1 Position Code";
                            "Manager 2 Position ID" := Position."Manager 1 Position ID";
                        END
                        ELSE BEGIN
                            "Manager 2  Department Code" := '';
                            "Manager 2 Code" := '';
                            "Manager 2 Position Code" := '';
                            "Manager 2 Position ID" := '';
                        END;


                    END
                    ELSE BEGIN

                        //ovdje sada ako nema svoj raspored

                        //ako nema službu

                        if (Rec."Department Categ.  Description" = '') and (Rec."Group Description" <> '') then begin

                            //onda bi ona trebala da odgovara ili svom sektoru ili svom izvršiocu ili direktno direktoru
                            //može da odgovara rukovodiocu sektora: 

                            HeadOf.RESET;
                            HeadOf.SETFILTER("Team Code", '%1', '');
                            HeadOf.SETFILTER("Group Code", '%1', '');
                            HeadOf.SETFILTER("Department Category", '%1', '');
                            HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                            HeadOf.SETFILTER("Management Level", '%1', 3);
                            //rukovodilac sektora
                            IF HeadOf.FIND('-') THEN BEGIN
                                HeadOf.CALCFIELDS("Employee No.");
                                "Manager 1 Code" := HeadOf."Employee No.";
                                "Disc. Department Name" := '';

                                Position.RESET;
                                Position.SETFILTER("Employee No.", '%1', "Manager 1 Code");
                                Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                                IF Position.FIND('-') THEN BEGIN

                                    "Manager 1  Department Code" := Position."Department Code";
                                    "Manager 1 Position Code" := Position.Code;
                                    "Manager 1 Position ID" := Position."Position ID";

                                END;
                                Position.RESET;
                                Position.SETFILTER("Employee No.", '%1', "Manager 1 Code");
                                Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                                IF Position.FINDFIRST THEN BEGIN
                                    Position.CALCFIELDS("Manager 1  Department Code", "Manager 1 Position Code", "Manager 1 Position ID");
                                    "Manager 2 Code" := Position."Manager 1 Code";
                                    "Manager 2  Department Code" := Position."Manager 1  Department Code";
                                    "Manager 2 Position Code" := Position."Manager 1 Position Code";
                                    "Manager 2 Position ID" := Position."Manager 1 Position ID";
                                END
                                ELSE BEGIN
                                    "Manager 2  Department Code" := '';
                                    "Manager 2 Code" := '';
                                    "Manager 2 Position Code" := '';
                                    "Manager 2 Position ID" := '';
                                END;
                            end;

                            if "Manager 1 Code" = '' then begin

                                //ako sada može biti samo izvršni ili uprava
                                HeadOf.Reset();
                                ExeManager.Reset();
                                ExeManager.SetFilter("ORG Shema", '%1', Rec."Org. Structure");
                                ExeManager.SetFilter("Subordinate Org Code", '%1', Rec.Sector);
                                ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Sector  Description");
                                if ExeManager.FindFirst() then begin
                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter(Code, '%1', ExeManager."Position Code");
                                    Posa.SetFilter(Description, '%1', ExeManager."Position Description");
                                    if Posa.FindFirst() then begin
                                        Uprava := Posa.Code
                                    end
                                    else begin
                                        Posa.Reset();
                                        Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                        Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                        if Posa.FindFirst() then
                                            Uprava := Posa.Code
                                        else
                                            Uprava := '';

                                    end;
                                end;

                                if Uprava = '' then
                                    HeadOf.SetFilter("Management Level", '%1', HeadOf."Management Level"::CEO)
                                else
                                    HeadOf.SetFilter("Position Code", '%1', Uprava);

                                //dodaj
                                HeadOf.SETFILTER(Sector, '%1', Sector);
                                HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                                if HeadOf.FindFirst() then begin

                                    HeadOf.CALCFIELDS("Employee No.");
                                    "Manager 1 Code" := HeadOf."Employee No.";

                                    Position.RESET;
                                    Position.SETFILTER("Employee No.", '%1', "Manager 1 Code");
                                    Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                                    IF Position.FINDFIRST THEN BEGIN

                                        "Manager 1  Department Code" := Position."Department Code";
                                        "Manager 1 Position Code" := Position.Code;
                                        "Manager 1 Position ID" := Position."Position ID";
                                    END
                                    ELSE BEGIN
                                        "Manager 1  Department Code" := '';
                                        "Manager 1 Position Code" := '';
                                        "Manager 1 Position ID" := '';
                                    END;
                                end;


                            end;






                        end
                        else begin

                            "Manager 1 Code" := '';
                            "Manager 1  Department Code" := '';
                            "Manager 1 Position Code" := '';
                            "Manager 1 Position ID" := '';
                        END;
                    end;



                    IF "Manager 1 Code" = '' THEN BEGIN
                        "Disc. Department Name" := '';
                        FOR i := 1 TO STRLEN("Department Code") DO BEGIN
                            String := "Department Code";
                            IF String[i] = '.' THEN BEGIN
                                Brojac := Brojac + 1;
                                IF Brojac = 2 THEN
                                    PozicijaUprava := i;
                            END;
                        END;
                        HeadOf.RESET;
                        HeadOf.SETFILTER(Sector, '%1', Rec.Sector);
                        HeadOf.SETFILTER("Sector  Description", '%1', Rec."Sector  Description");
                        HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                        IF HeadOf.FIND('-') THEN BEGIN
                            HeadOf.CALCFIELDS("Employee No.");
                            "Manager 2 Code" := HeadOf."Employee No.";
                            Position.RESET;
                            Position.SETFILTER("Employee No.", '%1', "Manager 2 Code");
                            Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                            IF Position.FIND('-') THEN BEGIN

                                "Manager 2  Department Code" := Position."Department Code";
                                "Manager 2 Position Code" := Position.Code;
                                "Manager 2 Position ID" := Position."Position ID";
                            END;

                        END
                        ELSE BEGIN
                            "Manager 2  Department Code" := '';
                            "Manager 2 Position Code" := '';
                            "Manager 2 Position ID" := '';
                        END;

                    END;
                END;









                //AKO JE B4 MO?E BITI LEVELIMA IZNAD
                IF ("Management Level".AsInteger() = 7) THEN BEGIN  //
                    HeadOf.RESET;
                    HeadOf.SETFILTER("Team Code", '%1', '');
                    HeadOf.SETFILTER("Group Code", '%1', "Group Code");
                    HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                    IF HeadOf.FIND('-') THEN BEGIN
                        HeadOf.CALCFIELDS("Employee No.");
                        "Manager 1 Code" := HeadOf."Employee No.";
                        "Disc. Department Name" := '';

                        Position.RESET;
                        Position.SETFILTER("Employee No.", '%1', "Manager 1 Code");
                        Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                        IF Position.FIND('-') THEN BEGIN

                            "Manager 1  Department Code" := Position."Department Code";
                            "Manager 1 Position Code" := Position.Code;
                            "Manager 1 Position ID" := Position."Position ID";
                        END;


                    END
                    ELSE BEGIN
                        "Manager 1 Code" := '';
                        "Manager 1  Department Code" := '';
                        "Manager 1 Position Code" := '';
                        "Manager 1 Position ID" := '';
                    END;
                    Position.RESET;
                    Position.SETFILTER("Employee No.", '%1', "Manager 1 Code");
                    Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                    IF Position.FINDFIRST THEN BEGIN
                        Position.CALCFIELDS("Manager 1  Department Code", "Manager 1 Position Code", "Manager 1 Position ID");
                        "Manager 2 Code" := Position."Manager 1 Code";
                        "Manager 2  Department Code" := Position."Manager 1  Department Code";
                        "Manager 2 Code" := Position."Manager 1 Code";
                        "Manager 2 Position Code" := Position."Manager 1 Position Code";
                        "Manager 2 Position ID" := Position."Manager 1 Position ID";
                    END
                    ELSE BEGIN
                        "Manager 2  Department Code" := '';
                        "Manager 2 Code" := '';
                        "Manager 2 Code" := '';
                        "Manager 2 Position Code" := '';
                        "Manager 2 Position ID" := Position."Manager 1 Position ID";



                    END;
                    IF "Manager 1 Code" = '' THEN BEGIN
                        FOR i := 1 TO STRLEN("Department Code") DO BEGIN
                            String := "Department Code";
                            IF String[i] = '.' THEN BEGIN
                                Brojac := Brojac + 1;
                                IF Brojac = 3 THEN
                                    PozicijaUprava := i;
                            END;
                        END;
                        HeadOf.RESET;
                        HeadOf.SETFILTER("Department Code", '%1', Rec."Department Category");
                        HeadOf.SETFILTER("Sector  Description", '%1', Rec."Sector  Description");
                        HeadOf.SETFILTER(Sector, '%1', Rec.Sector);
                        HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                        IF HeadOf.FIND('-') THEN BEGIN
                            HeadOf.CALCFIELDS("Employee No.");
                            "Manager 2 Code" := HeadOf."Employee No.";
                            Position.RESET;
                            Position.SETFILTER("Employee No.", '%1', "Manager 2 Code");
                            Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                            IF Position.FIND('-') THEN BEGIN
                                "Manager 2  Department Code" := Position."Department Code";
                            END
                            ELSE BEGIN
                                "Manager 2  Department Code" := '';
                            END;
                        END;
                    END;
                END;



                IF ("Management Level".AsInteger() = 0) OR ("Management Level".AsInteger() = 6) THEN BEGIN  //

                    //radnik

                    //ako ima rukovodeća pozicija u listi rukovodioca prema njegovom rasporedu ona može
                    //ili će biti rukovodeća pozicija sljedeći level iznad

                    HeadOf.RESET;
                    HeadOf.SETFILTER("Team Code", '%1', "Team Code");
                    HeadOf.SETFILTER("Group Code", '%1', "Group Code");
                    HeadOf.SETFILTER("Department Category", '%1', "Department Category");
                    HeadOf.SETFILTER(Sector, '%1', Sector);
                    HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                    IF HeadOf.FIND('-') THEN BEGIN

                        Head := true;

                        //Postoji prema rasporedu
                        HeadOf.CALCFIELDS("Employee No.");
                        "Manager 1 Code" := HeadOf."Employee No.";
                        Position.RESET;
                        Position.SETFILTER("Employee No.", '%1', "Manager 1 Code");
                        Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                        IF Position.FINDFIRST THEN BEGIN

                            "Manager 1  Department Code" := Position."Department Code";
                            "Manager 1 Position Code" := Position.Code;
                            "Manager 1 Position ID" := Position."Position ID";
                        END
                        ELSE BEGIN
                            "Manager 1  Department Code" := '';
                            "Manager 1 Position Code" := '';
                            "Manager 1 Position ID" := '';
                        END;

                        "Disc. Department Name" := '';
                    END
                    ELSE BEGIN


                        Head := false;


                        HeadOf.RESET;
                        HeadOf.SETFILTER("Team Code", '%1', "Team Code");
                        if "Group Description" <> '' then begin
                            HeadOf.SETFILTER("Group Code", '%1', '');
                            HeadOf.SetFilter("Department Categ.  Description", '%1', Rec."Department Categ.  Description");
                        end;


                        if ("Department Categ.  Description" <> '') and ("Group Description" = '')
                        then
                            HeadOf.SETFILTER("Department Category", '%1', '');

                        if (("Department Categ.  Description" = '') and ("Group Description" <> '')) or (
                            ("Group Description" = '') and ("Department Categ.  Description" = '')
                        ) then begin

                            if Rec."Management Level" = Rec."Management Level"::EXE then begin
                                HeadOf.SetFilter("Management Level", '%1', HeadOf."Management Level"::CEO);
                            end
                            else begin

                                //ovo samo ako je dio sektora

                                ExeManager.Reset();
                                ExeManager.SetFilter("ORG Shema", '%1', Rec."Org. Structure");
                                ExeManager.SetFilter("Subordinate Org Code", '%1', Rec.Sector);
                                ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Sector  Description");
                                if ExeManager.FindFirst() then begin
                                    Posa.Reset();
                                    Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                    Posa.SetFilter(Code, '%1', ExeManager."Position Code");
                                    Posa.SetFilter(Description, '%1', ExeManager."Position Description");
                                    if Posa.FindFirst() then begin
                                        Uprava := Posa.Code
                                    end
                                    else begin
                                        Posa.Reset();
                                        Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                        Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                        if Posa.FindFirst() then
                                            Uprava := Posa.Code
                                        else
                                            Uprava := '';

                                    end;
                                end;

                                if Uprava = '' then
                                    HeadOf.SetFilter("Management Level", '%1', HeadOf."Management Level"::CEO)
                                else
                                    HeadOf.SetFilter("Position Code", '%1', Uprava);



                            end;
                        end;

                        //ako ne onda ću tražiti izvršnog direktora


                        HeadOf.SETFILTER(Sector, '%1', Sector);
                        HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                        if HeadOf.FindFirst() then begin

                            HeadOf.CALCFIELDS("Employee No.");
                            "Manager 1 Code" := HeadOf."Employee No.";

                            Position.RESET;
                            Position.SETFILTER("Employee No.", '%1', "Manager 1 Code");
                            Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                            IF Position.FINDFIRST THEN BEGIN

                                "Manager 1  Department Code" := Position."Department Code";
                                "Manager 1 Position Code" := Position.Code;
                                "Manager 1 Position ID" := Position."Position ID";
                            END
                            ELSE BEGIN
                                "Manager 1  Department Code" := '';
                                "Manager 1 Position Code" := '';
                                "Manager 1 Position ID" := '';
                            END;

                            "Disc. Department Name" := '';

                        end;

                    END;



                    IF "Team Code" <> '' THEN BEGIN
                        HeadOf.RESET;
                        HeadOf.SETFILTER("Team Code", '%1', '');
                        HeadOf.SETFILTER("Group Code", '%1', "Group Code");
                        HeadOf.SETFILTER("Department Category", '%1', "Department Category");
                        HeadOf.SETFILTER(Sector, '%1', Sector);
                        HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                        IF HeadOf.FIND('-') THEN BEGIN
                            HeadOf.CALCFIELDS("Employee No.");
                            "Manager 2 Code" := HeadOf."Employee No.";
                            Position.RESET;
                            Position.SETFILTER("Employee No.", '%1', "Manager 2 Code");
                            Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                            IF Position.FIND('-') THEN BEGIN
                                "Manager 2  Department Code" := Position."Department Code";
                            END;

                        END
                        ELSE BEGIN
                            "Manager 2 Code" := '';
                            "Manager 2  Department Code" := '';
                        END;
                        IF "Manager 1 Code" = "Manager 2 Code" THEN BEGIN
                            "Manager 2 Code" := '';
                            "Manager 2  Department Code" := '';
                        END;


                    END;

                    //nešto što je odjel
                    IF ("Team Code" = '') AND ("Group Code" <> '') THEN BEGIN

                        if Head = true then begin
                            HeadOf.RESET;
                            HeadOf.SETFILTER("Team Code", '%1', '');
                            HeadOf.SETFILTER("Group Code", '%1', '');
                            HeadOf.SETFILTER("Department Category", '%1', "Department Category");
                            HeadOf.SETFILTER(Sector, '%1', Sector);
                            HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                            IF HeadOf.FIND('-') THEN BEGIN
                                HeadOf.CALCFIELDS("Employee No.");
                                "Manager 2 Code" := HeadOf."Employee No.";
                                Position.RESET;
                                Position.SETFILTER("Employee No.", '%1', "Manager 2 Code");
                                Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                                IF Position.FIND('-') THEN BEGIN

                                    "Manager 2  Department Code" := Position."Department Code";
                                END;

                            END
                            ELSE BEGIN
                                "Manager 2 Code" := '';
                                "Manager 2  Department Code" := '';
                            END;
                            IF "Manager 1 Code" = "Manager 2 Code" THEN BEGIN
                                "Manager 2 Code" := '';
                                "Manager 2  Department Code" := '';
                            END;

                        end
                        else begin

                            //nema rukovodeće pozicije, a bio je odjel. Znači drugi ruko. mu je sektor

                            //kraj
                            HeadOf.RESET;
                            HeadOf.SETFILTER("Team Code", '%1', '');
                            HeadOf.SETFILTER("Group Code", '%1', '');
                            HeadOf.SETFILTER("Department Category", '%1', '');
                            HeadOf.SETFILTER(Sector, '%1', Sector);
                            HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                            IF HeadOf.FIND('-') THEN BEGIN
                                HeadOf.CALCFIELDS("Employee No.");
                                "Manager 2 Code" := HeadOf."Employee No.";
                                Position.RESET;
                                Position.SETFILTER("Employee No.", '%1', "Manager 2 Code");
                                Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                                IF Position.FIND('-') THEN BEGIN

                                    "Manager 2  Department Code" := Position."Department Code";
                                END;

                            END
                            ELSE BEGIN
                                "Manager 2 Code" := '';
                                "Manager 2  Department Code" := '';
                            END;
                            IF "Manager 1 Code" = "Manager 2 Code" THEN BEGIN
                                "Manager 2 Code" := '';
                                "Manager 2  Department Code" := '';
                            END;


                        end;



                    END;



                    IF ("Group Code" = '') AND ("Department Category" <> '') THEN BEGIN


                        HeadOf.RESET;
                        HeadOf.SETFILTER("Team Code", '%1', '');
                        HeadOf.SETFILTER("Group Code", '%1', '');
                        HeadOf.SETFILTER("Department Category", '%1', '');
                        HeadOf.SETFILTER(Sector, '%1', Sector);
                        HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                        IF HeadOf.FIND('-') THEN BEGIN
                            HeadOf.CALCFIELDS("Employee No.");
                            "Manager 2 Code" := HeadOf."Employee No.";
                            Position.RESET;
                            Position.SETFILTER("Employee No.", '%1', "Manager 2 Code");
                            Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                            IF Position.FIND('-') THEN BEGIN

                                "Manager 2  Department Code" := Position."Department Code";
                            END;

                        END
                        ELSE BEGIN
                            "Manager 2 Code" := '';
                            "Manager 2  Department Code" := '';
                        END;
                        IF "Manager 1 Code" = "Manager 2 Code" THEN BEGIN
                            "Manager 2 Code" := '';
                            "Manager 2  Department Code" := '';
                        END;
                    END;


                    IF ("Department Category" = '') AND (Sector <> '') THEN BEGIN

                        //može da mu odgovara sektor ili izvršni ili uprava
                        //znači ako je sektor, prvi nadređeni mu je šef njegovor sektora
                        //drugi nadređeni mu je izvršni

                        ExeManager.Reset();
                        ExeManager.SetFilter("ORG Shema", '%1', Rec."Org. Structure");
                        ExeManager.SetFilter("Subordinate Org Code", '%1', Rec.Sector);
                        ExeManager.SetFilter("Subordinate Org Description", '%1', Rec."Sector  Description");
                        if ExeManager.FindFirst() then begin
                            Posa.Reset();
                            Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                            Posa.SetFilter(Code, '%1', ExeManager."Position Code");
                            Posa.SetFilter(Description, '%1', ExeManager."Position Description");
                            if Posa.FindFirst() then begin
                                Uprava := Posa.Code
                            end
                            else begin
                                Posa.Reset();
                                Posa.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                                Posa.SetFilter("Management Level", '%1', Posa."Management Level"::CEO);

                                if Posa.FindFirst() then
                                    Uprava := Posa.Code
                                else
                                    Uprava := '';

                            end;
                        end;



                        HeadOf.RESET;
                        HeadOf.SETFILTER("Team Code", '%1', '');
                        HeadOf.SETFILTER("Group Code", '%1', '');
                        HeadOf.SETFILTER("Department Category", '%1', '');
                        HeadOf.SETFILTER("position code", '%1', Uprava);
                        HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                        IF HeadOf.FIND('-') THEN BEGIN
                            HeadOf.CALCFIELDS("Employee No.");
                            "Manager 2 Code" := HeadOf."Employee No.";
                            Position.RESET;
                            Position.SETFILTER("Employee No.", '%1', "Manager 2 Code");
                            Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                            IF Position.FIND('-') THEN BEGIN
                                "Manager 2  Department Code" := Position."Department Code";
                            END;

                        END
                        ELSE BEGIN
                            "Manager 2 Code" := '';
                            "Manager 2  Department Code" := '';
                        END;
                        IF "Manager 1 Code" = "Manager 2 Code" THEN BEGIN
                            "Manager 2 Code" := '';
                            "Manager 2  Department Code" := '';
                        END;
                        IF "Manager 2 Code" = '' THEN BEGIN
                            Position.RESET;
                            Position.SETFILTER("Employee No.", '%1', "Manager 1 Code");
                            Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                            IF Position.FIND('-') THEN BEGIN
                                "Manager 2 Code" := Position."Manager 1 Code";
                            END;

                        END;

                    END;

                END;

                /* IF ("Disc. Department Code"<>'') AND ("Disc. Department Name"='')THEN BEGIN
                   HeadOf.RESET;
                   HeadOf.SETFILTER("Department Code",'%1',"Disc. Department Code");
                   HeadOf.SETFILTER("ORG Shema",'%1',"Org. Structure");
                   IF HeadOf.FINDFIRST THEN BEGIN
                    HeadOf.CALCFIELDS("Employee No.");
                    "Manager 1 Code":=HeadOf."Employee No.";
                    Position.RESET;
                 Position.SETFILTER("Employee No.",'%1',"Manager 1 Code");
               Position.SETFILTER("Org. Structure",'%1',"Org. Structure");
               IF Position.FIND('-') THEN BEGIN

               "Manager 1  Department Code":=Position."Department Code";
               "Manager 1 Position Code":=Position.Code;
               "Manager 1 Position ID":=Position."Position ID";

               END;
               IF "Manager 1 Code"<>'' THEN BEGIN
               Position.RESET;
               Position.SETFILTER("Employee No.",'%1',"Manager 1 Code");
               Position.SETFILTER("Org. Structure",'%1',"Org. Structure");
               IF Position.FINDFIRST THEN BEGIN
                   Position.CALCFIELDS("Manager 1  Department Code","Manager 1 Position Code","Manager 1 Position ID");
                 "Manager 2 Code":=Position."Manager 1 Code";
                 "Manager 2  Department Code":=Position."Manager 1  Department Code";
                 "Manager 2 Position Code":=Position."Manager 1 Position Code";
                 "Manager 2 Position ID":=Position."Manager 1 Position ID";
                 END
                 ELSE BEGIN
                   "Manager 2  Department Code":='';
                   "Manager 2 Code":='';
                 "Manager 2 Position Code":='';
                 "Manager 2 Position ID":='';
                   END;


               END
               ELSE BEGIN
                 "Manager 1 Code":='';
                 "Manager 1  Department Code":='';
                 "Manager 1 Position Code":='';
               "Manager 1 Position ID":='';
                 END;
                END;*/
                //END;
                IF "Employee No." = "Manager 1 Code" THEN "Manager Is Employee" := TRUE;
                if ("Disc. Department Code" = '') and ("Disc. Department Name" = '') then begin
                    "Manager 1" := '';
                    "Manager 1  Department Code" := '';
                    "Manager 1 Code" := '';
                    "Manager 1 Position Code" := '';
                    "Manager 1 Position ID" := '';
                    "Manager 2  Department Code" := '';
                    "Manager 2 Code" := '';
                    "Manager 2 Position Code" := '';
                    "Manager 2 Position ID" := '';


                end;
                IF Rec."Management Level" = Rec."Management Level"::CEO then begin
                    "Manager 1" := '';
                    "Manager 1  Department Code" := '';
                    "Manager 1 Code" := '';
                    "Manager 1 Position Code" := '';
                    "Manager 1 Position ID" := '';
                    "Manager 2  Department Code" := '';
                    "Manager 2 Code" := '';
                    "Manager 2 Position Code" := '';
                    "Manager 2 Position ID" := '';

                end;

            end;
        }
        field(50352; "Manager 1  Department Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Department Code" WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                                                     "Employee No." = FIELD("Manager 1 Code"),
                                                                                     "Status" = CONST(Active),
                                                                                     "Show Record" = FILTER(false | true)));
            Caption = 'Manager Department Code';

            TableRelation = Department.Code;
        }
        field(50353; "Manager 1 Position Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Position Code" WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                                                   "Employee No." = FIELD("Manager 1 Code"),
                                                                                   "Status" = CONST(Active),
                                                                                   "Show Record" = FILTER(false | true)));
            Caption = 'Manager Position Code';

            TableRelation = Position.Code WHERE("Org. Structure" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin
                ECL.RESET;
                ECL.SETFILTER("Org. Structure", '%1', "Org. Structure");
                ECL.SETFILTER("Position Code", '%1', "Manager Position Code");
                ECL.SETFILTER("Employee Status", '%1', 0);
                IF "Manager Position ID" <> '' THEN
                    ECL.SETFILTER("Position ID", '%1', "Manager Position ID");
                IF ECL.FINDFIRST THEN BEGIN
                    "Manager 1 Name" := ECL."Employee Name";
                    "Manager 1" := ECL."Employee No.";

                END;
            end;
        }
        field(50354; "Manager 1 Position ID"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Position ID" WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                                                 "Employee No." = FIELD("Manager 1 Code"),
                                                                                 "Status" = CONST(Active),
                                                                                 "Show Record" = FILTER(false | true)));
            Caption = 'Manager Position ID';


            trigger OnValidate()
            begin
                ECL.RESET;
                ECL.SETFILTER("Org. Structure", '%1', "Org. Structure");
                ECL.SETFILTER("Position Code", '%1', "Manager Position Code");
                ECL.SETFILTER("Employee Status", '%1', 0);
                IF "Manager Position ID" <> '' THEN
                    ECL.SETFILTER("Position ID", '%1', "Manager Position ID");
                IF ECL.FINDFIRST THEN BEGIN
                    "Manager 1 Name" := ECL."Employee Name";
                    "Manager 1" := ECL."Employee No.";
                END;

                /*
                WDV.SETFILTER("Employee No.",'%1',"Employee No.");
                WDV.SETFILTER(Active,'%1',TRUE);
                IF WDV.FIND('-') THEN repeat
                WDV."Department Name":="Department Name";
                CALCFIELDS("Position Description","B-1 (with regions) Description","B-1 Description","Stream Description");
                WDV."Position Description":="Position Description";
                WDV."B-1 (with regions) Description":="B-1 (with regions) Description";
                WDV."B-1 Description":="B-1 Description";
                WDV."Stream Description":="Stream Description";
                UNTIL WDV.NEXT=0;
                
                WDVM.SETFILTER("Employee No.",'%1',"Manager 1");
                WDVM.SETFILTER(Active,'%1',TRUE);
                IF WDVM.FIND('-') THEN repeat
                WDVM."Department Name":="Department Name";
                CALCFIELDS("Position Description","B-1 (with regions) Description","B-1 Description","Stream Description");
                WDVM."Position Description":="Position Description";
                WDVM."B-1 (with regions) Description":="B-1 (with regions) Description";
                WDVM."B-1 Description":="B-1 Description";
                WDVM."Stream Description":="Stream Description";
                UNTIL WDVM.NEXT=0;
                
                WDVR.SETFILTER("Employee No.",'%1',"Manager 1");
                WDVR.SETFILTER(Active,'%1',TRUE);
                IF WDVR.FIND('-') THEN repeat
                WDVR."Department Name":="Department Name";
                CALCFIELDS("Position Description","B-1 (with regions) Description","B-1 Description","Stream Description");
                WDVR."Position Description":="Position Description";
                WDVR."B-1 (with regions) Description":="B-1 (with regions) Description";
                WDVR."B-1 Description":="B-1 Description";
                WDVR."Stream Description":="Stream Description";
                UNTIL WDVR.NEXT=0;*/

            end;
        }
        field(50355; "Manager 1 Full Name"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Employee Name" WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                                                   "Employee No." = FIELD("Manager 1 Code"),
                                                                                   "Status" = CONST(Active),
                                                                                  "Show Record" = FILTER(false | true)));
            Caption = 'Manager Department Code';

        }
        field(50356; "Manager 2  Department Code"; Code[20])
        {
            Caption = 'Manager Department Code';
            FieldClass = Normal;
            TableRelation = Department.Code WHERE("ORG Shema" = FIELD("Org. Structure"));
        }
        field(50357; "Manager 2 Position Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Position Code" WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                                                   "Employee No." = FIELD("Manager 2 Code"),
                                                                                   "Status" = CONST(Active),
                                                                                   "Show Record" = FILTER(false | true)));
            Caption = 'Manager Position Code';

            TableRelation = Position.Code WHERE("Org. Structure" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin
                ECL.RESET;
                ECL.SETFILTER("Org. Structure", '%1', "Org. Structure");
                ECL.SETFILTER("Position Code", '%1', "Manager Position Code");
                ECL.SETFILTER("Employee Status", '%1', 0);
                IF "Manager Position ID" <> '' THEN
                    ECL.SETFILTER("Position ID", '%1', "Manager Position ID");
                IF ECL.FINDFIRST THEN BEGIN
                    "Manager 1 Name" := ECL."Employee Name";
                    "Manager 1" := ECL."Employee No.";

                END;
            end;
        }
        field(50358; "Manager 2 Position ID"; Code[20])
        {

            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Position ID" WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                                                 "Employee No." = FIELD("Manager 2 Code"),
                                                                                 "Status" = CONST(Active),
                                                                                 "Show Record" = FILTER(false | true)));
            Caption = 'Manager Position ID';


            trigger OnValidate()
            begin
                ECL.RESET;
                ECL.SETFILTER("Org. Structure", '%1', "Org. Structure");
                ECL.SETFILTER("Position Code", '%1', "Manager Position Code");
                ECL.SETFILTER("Employee Status", '%1', 0);
                IF "Manager Position ID" <> '' THEN
                    ECL.SETFILTER("Position ID", '%1', "Manager Position ID");
                IF ECL.FINDFIRST THEN BEGIN
                    "Manager 1 Name" := ECL."Employee Name";
                    "Manager 1" := ECL."Employee No.";
                END;

                /*
                WDV.SETFILTER("Employee No.",'%1',"Employee No.");
                WDV.SETFILTER(Active,'%1',TRUE);
                IF WDV.FIND('-') THEN repeat
                WDV."Department Name":="Department Name";
                CALCFIELDS("Position Description","B-1 (with regions) Description","B-1 Description","Stream Description");
                WDV."Position Description":="Position Description";
                WDV."B-1 (with regions) Description":="B-1 (with regions) Description";
                WDV."B-1 Description":="B-1 Description";
                WDV."Stream Description":="Stream Description";
                UNTIL WDV.NEXT=0;
                
                WDVM.SETFILTER("Employee No.",'%1',"Manager 1");
                WDVM.SETFILTER(Active,'%1',TRUE);
                IF WDVM.FIND('-') THEN repeat
                WDVM."Department Name":="Department Name";
                CALCFIELDS("Position Description","B-1 (with regions) Description","B-1 Description","Stream Description");
                WDVM."Position Description":="Position Description";
                WDVM."B-1 (with regions) Description":="B-1 (with regions) Description";
                WDVM."B-1 Description":="B-1 Description";
                WDVM."Stream Description":="Stream Description";
                UNTIL WDVM.NEXT=0;
                
                WDVR.SETFILTER("Employee No.",'%1',"Manager 1");
                WDVR.SETFILTER(Active,'%1',TRUE);
                IF WDVR.FIND('-') THEN repeat
                WDVR."Department Name":="Department Name";
                CALCFIELDS("Position Description","B-1 (with regions) Description","B-1 Description","Stream Description");
                WDVR."Position Description":="Position Description";
                WDVR."B-1 (with regions) Description":="B-1 (with regions) Description";
                WDVR."B-1 Description":="B-1 Description";
                WDVR."Stream Description":="Stream Description";
                UNTIL WDVR.NEXT=0;*/

            end;
        }
        field(50359; "Manager 2 Full Name"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Employee Name" WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                                                   "Employee No." = FIELD("Manager 2 Code"),
                                                                                   Status = CONST(Active),
                                                                                   "Show Record" = FILTER(false | true)));
            Caption = 'Manager Department Code';

        }
        field(50360; "Manager 2 Code"; Code[20])
        {
            Caption = 'Manager 1';

            trigger OnValidate()
            begin
                //CALCFIELDS("Manager 1 First Name","Manager 1 Last Name","Manager 1 Position Code");
            end;
        }
        field(50361; "Manager Is Employee"; Boolean)
        {
            Caption = 'Manager Is Employee';
        }
        field(50362; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            Editable = false;
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF NOT DimMgt.CheckDim("Dimension Code") THEN
                    ERROR(DimMgt.GetDimErr);

            end;
        }
        field(50363; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Dimension Code"),
                                                          "Dimension Value Type" = FILTER(Standard));

            trigger OnValidate()
            begin
                DimensionValue.RESET;
                DimensionValue.SETFILTER("Dimension Code", '%1', "Dimension Code");
                IF DimensionValue.FINDFIRST THEN BEGIN
                    /*ĐK   IF NOT DimMgt.CheckDimValue("Dimension Code", "Dimension Value Code", DimensionValue.Name) THEN
                          ERROR(DimMgt.GetDimErr);ĐK*/
                END;
            end;
        }
        field(50364; "Dimension  Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Dimension Value".Name WHERE("Dimension Code" = FIELD("Dimension Code"),
                                                               "Code" = FIELD("Dimension Value Code")));
            Caption = 'Dimension Code';
            Editable = false;


            trigger OnValidate()
            begin
                IF NOT DimMgt.CheckDim("Dimension Code") THEN
                    ERROR(DimMgt.GetDimErr);
            end;
        }
        field(50365; "Management Level"; enum "Management Level")
        {
            Caption = 'Management Level';


            trigger OnValidate()
            begin
                IF (("Team Description" <> '')) THEN BEGIN

                    posDis.SETFILTER("Department Code", '%1', "Team Code");
                    posDis.SETFILTER("Management Level", '%1', "Management Level");
                    posDis.SETFILTER("Team Description", '%1', "Team Code");
                    posDis.SETFILTER("Org. Structure", '%1', "Org. Structure");
                    IF posDis.FIND('-') THEN BEGIN
                        VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                        VALIDATE("Disc. Department Name", posDis."Disc. Department Name");
                    END
                    ELSE BEGIN
                        IF ("Management Level".AsInteger() = 0) OR ("Management Level".AsInteger() = 6) THEN BEGIN
                            VALIDATE("Disc. Department Code", "Team Code");
                            VALIDATE("Disc. Department Name", "Team Description");
                        END
                        ELSE BEGIN
                            VALIDATE("Disc. Department Code", "Group Code");
                            VALIDATE("Disc. Department Name", "Group Description");


                        END;
                    END;
                END;

                posDis.RESET;
                IF (("Team Description" = '') AND ("Group Description" <> '')) THEN BEGIN

                    posDis.SETFILTER("Department Code", '%1', "Group Code");
                    posDis.SETFILTER("Management Level", '%1', "Management Level");
                    posDis.SETFILTER("Group Description", '%1', "Group Code");
                    posDis.SETFILTER("Org. Structure", '%1', "Org. Structure");
                    IF posDis.FIND('-') THEN BEGIN
                        VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                        VALIDATE("Disc. Department Name", posDis."Disc. Department Name");

                    END
                    ELSE BEGIN
                        IF ("Management Level".AsInteger() = 0) OR ("Management Level".AsInteger() = 6) THEN BEGIN
                            VALIDATE("Disc. Department Code", "Group Code");
                            VALIDATE("Disc. Department Name", "Group Description");
                        END
                        ELSE BEGIN
                            VALIDATE("Disc. Department Code", "Department Category");
                            VALIDATE("Disc. Department Name", "Department Categ.  Description");
                        END;
                    END;
                END;

                posDis.RESET;
                IF (("Team Description" = '') AND ("Group Description" = '') AND ("Department Categ.  Description" <> '')) THEN BEGIN
                    posDis.SETFILTER("Department Code", '%1', "Department Category");
                    posDis.SETFILTER("Management Level", '%1', "Management Level");
                    posDis.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
                    posDis.SETFILTER("Org. Structure", '%1', "Org. Structure");
                    IF posDis.FIND('-') THEN BEGIN
                        VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                        VALIDATE("Disc. Department Name", posDis."Disc. Department Name");
                    END
                    ELSE BEGIN
                        IF ("Management Level".AsInteger() = 0) OR ("Management Level".AsInteger() = 6) THEN BEGIN
                            VALIDATE("Disc. Department Code", "Department Category");
                            VALIDATE("Disc. Department Code", "Department Code");
                        END
                        ELSE BEGIN
                            VALIDATE("Disc. Department Code", Sector);
                            VALIDATE("Disc. Department Name", "Sector  Description");
                        END;
                    END;
                END;
                IF (("Team Description" = '') AND ("Group Description" = '') AND ("Department Categ.  Description" = '')) THEN BEGIN
                    posDis.RESET;
                    posDis.SETFILTER("Department Code", '%1', Sector);
                    posDis.SETFILTER("Management Level", '%1', "Management Level");
                    posDis.SETFILTER("Sector  Description", '%1', "Sector  Description");
                    posDis.SETFILTER("Org. Structure", '%1', "Org. Structure");
                    IF posDis.FIND('-') THEN BEGIN
                        VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                        VALIDATE("Disc. Department Name", posDis."Disc. Department Name");
                    END
                    ELSE BEGIN
                        VALIDATE("Disc. Department Code", Sector);
                        VALIDATE("Disc. Department Code", "Department Code");
                    END;
                END;

                PositionMenu1.RESET;
                PositionMenu1.SETFILTER(Code, '%1', Code);
                PositionMenu1.SETFILTER(Description, '%1', Description);
                PositionMenu1.SETFILTER("Department Code", '%1', "Department Code");
                PositionMenu1.SETFILTER("Org. Structure", '%1', "Org. Structure");
                IF PositionMenu1.FINDFIRST THEN BEGIN
                    PositionMenu1."Management Level" := "Management Level";
                    PositionMenu1.MODIFY;
                END;
            end;
        }
        field(50366; "Control Function"; Boolean)
        {
            Caption = 'Control Function';

            trigger OnValidate()
            begin
                PositionMenu1.RESET;
                PositionMenu1.SETFILTER(Code, '%1', Code);
                PositionMenu1.SETFILTER(Description, '%1', Description);
                PositionMenu1.SETFILTER("Department Code", '%1', "Department Code");
                PositionMenu1.SETFILTER("Org. Structure", '%1', "Org. Structure");
                IF PositionMenu1.FINDFIRST THEN BEGIN
                    PositionMenu1."Control Function" := "Control Function";
                    PositionMenu1.MODIFY;
                END;
            end;
        }
        field(50367; "Key Function"; Boolean)
        {
            Caption = 'Key Function';

            trigger OnValidate()
            begin
                PositionMenu1.RESET;
                PositionMenu1.SETFILTER(Code, '%1', Code);
                PositionMenu1.SETFILTER(Description, '%1', Description);
                PositionMenu1.SETFILTER("Department Code", '%1', "Department Code");
                PositionMenu1.SETFILTER("Org. Structure", '%1', "Org. Structure");
                IF PositionMenu1.FINDFIRST THEN BEGIN
                    PositionMenu1."Key Function" := "Key Function";
                    PositionMenu1.MODIFY;
                END;
            end;
        }
        field(50368; "Official Translation"; Text[250])
        {
            Caption = 'Official Translation';
        }
        field(50369; "Free Translation"; Text[250])
        {
            Caption = 'Official Translation';
        }
        field(50370; Sector; Code[30])
        {
            Caption = 'Sector';
            TableRelation = Sector."Code" WHERE("Org Shema" = FIELD("Org. Structure"));
        }
        field(50371; "Department Category"; Code[30])
        {
            Caption = 'Department';
            TableRelation = "Department Category"."Code" WHERE("Org Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin
                ;

            end;
        }
        field(50372; "Group Code"; Code[30])
        {
            Caption = 'Group';
            TableRelation = "Group"."Code" WHERE("Org Shema" = FIELD("Org. Structure"));
        }
        field(50373; "Sector  Description"; Text[250])
        {
            Caption = 'Sector Description';
            Editable = true;
            TableRelation = Sector.Description;

            trigger OnValidate()
            begin
                IF (("Team Code" = '') AND ("Group Code" = '') AND ("Department Category" = '')) THEN BEGIN
                    Department.RESET;
                    Department.SETFILTER("Sector  Description", '%1', Rec."Sector  Description");
                    Department.SETFILTER("ORG Shema", '%1', Rec."Org. Structure");
                    Department.SETFILTER("Department Type", '%1', 8);

                    IF Department.FINDFIRST THEN BEGIN

                        "Sector  Description" := Department."Sector  Description";
                        IF "Sector  Description" <> '' THEN BEGIN

                            VALIDATE("Department Code", Department.Sector);

                            VALIDATE(Sector, Department.Sector);

                        END;
                    END;
                END;
                IF (("Team Code" = '') AND ("Group Code" = '') AND ("Department Category" = '') AND ("Sector  Description" = '')) THEN BEGIN
                    Sector := '';
                    "Department Category" := '';
                    "Group Code" := '';
                    "Team Code" := '';
                    "Sector  Description" := '';
                    "Department Categ.  Description" := '';
                    "Group Description" := '';
                    "Team Description" := '';

                END;
                SectorR.SETFILTER(Description, '%1', "Sector  Description");
                SectorR.SETFILTER("Org Shema", '%1', "Org. Structure");
                IF SectorR.FINDFIRST THEN BEGIN
                    "Sector Identity" := SectorR.Identity;
                END;
                DepartmentC.SETFILTER(Description, '%1', "Department Categ.  Description");
                DepartmentC.SETFILTER("Org Shema", '%1', "Org. Structure");
                IF DepartmentC.FINDFIRST THEN BEGIN
                    "Department Category Identity" := DepartmentC.Identity;

                END;



                IF (("Team Description" = '') AND ("Group Description" = '') AND ("Department Categ.  Description" = '')) THEN BEGIN
                    posDis.RESET;
                    posDis.SETFILTER("Department Code", '%1', Sector);
                    posDis.SETFILTER("Management Level", '%1', "Management Level");
                    posDis.SETFILTER("Sector  Description", '%1', "Sector  Description");
                    posDis.SETFILTER("Org. Structure", '%1', "Org. Structure");
                    IF posDis.FIND('-') THEN BEGIN
                        VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                        VALIDATE("Disc. Department Name", posDis."Disc. Department Name");
                    END
                    ELSE BEGIN
                        IF ("Management Level".AsInteger() = 6) OR ("Management Level".AsInteger() = 0) THEN BEGIN
                            VALIDATE("Disc. Department Code", Sector);
                            VALIDATE("Disc. Department Code", "Department Code");
                        END;
                    END;
                END;
                PosMenuNew.SETFILTER(Code, '%1', Rec.Code);
                PosMenuNew.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                PosMenuNew.SETFILTER(Description, '%1', Rec.Description);
                IF PosMenuNew.FIND('-') THEN BEGIN
                    IF PosMenuNew1.GET(PosMenuNew.Code, PosMenuNew.Description, PosMenuNew."Department Code", PosMenuNew."Org. Structure") THEN BEGIN
                        IF NOT PosRename.GET(PosMenuNew.Code, PosMenuNew.Description, "Department Code", PosMenuNew."Org. Structure") THEN
                            PosMenuNew1.RENAME(PosMenuNew.Code, PosMenuNew.Description, "Department Code", PosMenuNew."Org. Structure");
                    END;
                END;
                IF "Sector  Description" = '' THEN BEGIN
                    Sector := '';
                    "Department Category" := '';
                    "Group Code" := '';
                    "Team Code" := '';
                    "Sector  Description" := '';
                    "Department Categ.  Description" := '';
                    "Group Description" := '';
                    "Team Description" := '';
                    "Department Name" := '';
                    "Disc. Department Code" := '';
                    "Disc. Department Name" := '';
                END;
                IF ("Sector  Description" <> '') AND ("Department Categ.  Description" = '') THEN BEGIN
                    "Department Name" := "Sector  Description";
                END
                ELSE BEGIN
                    "Department Name" := '';
                END;
            end;
        }
        field(50374; "Department Categ.  Description"; Text[150])
        {
            Caption = 'Department (description)';
            Editable = true;
            TableRelation = "Department Category".Description;

            trigger OnValidate()
            begin
                IF (("Team Code" = '') AND ("Group Code" = '')) THEN BEGIN
                    Department.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
                    Department.SETFILTER("ORG Shema", '%1', "Org. Structure");
                    IF Department.FIND('-') THEN BEGIN


                        IF "Department Categ.  Description" <> '' THEN BEGIN

                            VALIDATE("Department Code", Department."Department Category");
                            VALIDATE("Department Category", Department."Department Category");

                            VALIDATE(Sector, Department.Sector);
                            VALIDATE("Sector  Description", Department."Sector  Description");
                        END;
                    END;
                END;
                IF (("Team Code" = '') AND ("Group Code" = '') AND ("Department Categ.  Description" = '')) THEN BEGIN
                    Sector := '';
                    "Department Category" := '';
                    "Group Code" := '';
                    "Team Code" := '';
                    "Sector  Description" := '';
                    "Department Categ.  Description" := '';
                    "Group Description" := '';
                    "Team Description" := '';
                END;

                SectorR.SETFILTER(Description, '%1', "Sector  Description");
                SectorR.SETFILTER("Org Shema", '%1', "Org. Structure");
                IF SectorR.FINDFIRST THEN BEGIN
                    "Sector Identity" := SectorR.Identity;
                END;
                DepartmentC.SETFILTER(Description, '%1', "Department Categ.  Description");
                DepartmentC.SETFILTER("Org Shema", '%1', "Org. Structure");
                IF DepartmentC.FINDFIRST THEN BEGIN
                    "Department Category Identity" := DepartmentC.Identity;
                END;


                posDis.RESET;
                IF (("Team Description" = '') AND ("Group Description" = '') AND ("Department Categ.  Description" <> '')) THEN BEGIN
                    posDis.SETFILTER("Department Code", '%1', "Department Category");
                    posDis.SETFILTER("Management Level", '%1', "Management Level");
                    posDis.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
                    posDis.SETFILTER("Org. Structure", '%1', "Org. Structure");
                    IF posDis.FINDFIRST THEN BEGIN
                        VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                        VALIDATE("Disc. Department Name", posDis."Disc. Department Name");
                    END
                    ELSE BEGIN
                        IF ("Management Level".AsInteger() <> 0) AND ("Management Level".AsInteger() <> 6) THEN
                            VALIDATE("Disc. Department Code", Sector)
                        ELSE
                            VALIDATE("Disc. Department Code", "Department Category");
                        IF ("Management Level".AsInteger() = 0) OR ("Management Level".AsInteger() = 6) THEN
                            VALIDATE("Disc. Department Name", "Department Categ.  Description");
                    END;
                END;
                PosMenuNew.SETFILTER(Code, '%1', Rec.Code);
                PosMenuNew.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                PosMenuNew.SETFILTER(Description, '%1', Rec.Description);
                IF PosMenuNew.FIND('-') THEN BEGIN
                    IF PosMenuNew1.GET(PosMenuNew.Code, PosMenuNew.Description, PosMenuNew."Department Code", PosMenuNew."Org. Structure") THEN BEGIN
                        IF NOT PosRename.GET(PosMenuNew.Code, PosMenuNew.Description, "Department Code", PosMenuNew."Org. Structure") THEN
                            PosMenuNew1.RENAME(PosMenuNew.Code, PosMenuNew.Description, "Department Code", PosMenuNew."Org. Structure");
                    END;
                END;

                IF "Department Categ.  Description" = '' THEN BEGIN
                    Sector := '';
                    "Department Category" := '';
                    "Group Code" := '';
                    "Team Code" := '';
                    "Sector  Description" := '';
                    "Department Categ.  Description" := '';
                    "Group Description" := '';
                    "Team Description" := '';
                    "Department Name" := '';
                    "Disc. Department Code" := '';
                    "Disc. Department Name" := '';
                END;
                IF ("Group Description" = '') AND ("Department Categ.  Description" <> '') THEN BEGIN
                    "Department Name" := "Department Categ.  Description";
                END
                ELSE BEGIN
                    "Department Name" := '';
                END;
            end;
        }
        field(50375; "Group Description"; Text[150])
        {
            Caption = 'Group Description';
            Editable = true;
            TableRelation = "Group".Description WHERE("Org Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin
                IF "Team Code" = '' THEN BEGIN
                    Department.SETFILTER("Group Description", '%1', "Group Description");
                    Department.SETFILTER("ORG Shema", '%1', "Org. Structure");
                    IF Department.FIND('-') THEN BEGIN


                        IF "Group Description" <> '' THEN BEGIN

                            VALIDATE("Department Code", Department."Group Code");
                            VALIDATE("Group Code", Department."Group Code");
                            VALIDATE("Department Category", Department."Department Category");
                            VALIDATE("Department Categ.  Description", Department."Department Categ.  Description");
                            VALIDATE(Sector, Department.Sector);
                            VALIDATE("Sector  Description", Department."Sector  Description");
                        END;
                    END;
                END;
                IF ("Team Description" = '') AND ("Group Description" = '') THEN BEGIN
                    Sector := '';
                    "Department Category" := '';
                    "Group Code" := '';
                    "Team Code" := '';
                    "Sector  Description" := '';
                    "Department Categ.  Description" := '';
                    "Group Description" := '';
                    "Team Description" := '';
                END;
                SectorR.SETFILTER(Description, '%1', "Sector  Description");
                SectorR.SETFILTER("Org Shema", '%1', "Org. Structure");
                IF SectorR.FINDFIRST THEN BEGIN
                    "Sector Identity" := SectorR.Identity;
                END;
                DepartmentC.SETFILTER(Description, '%1', "Department Categ.  Description");
                DepartmentC.SETFILTER("Org Shema", '%1', "Org. Structure");
                IF DepartmentC.FINDFIRST THEN BEGIN
                    "Department Category Identity" := DepartmentC.Identity;
                END;

                posDis.RESET;
                IF (("Team Description" = '') AND ("Group Description" <> '')) THEN BEGIN

                    posDis.SETFILTER("Department Code", '%1', "Group Code");
                    posDis.SETFILTER("Management Level", '%1', "Management Level");
                    posDis.SETFILTER("Group Description", '%1', "Group Code");
                    posDis.SETFILTER("Org. Structure", '%1', "Org. Structure");
                    IF posDis.FIND('-') THEN BEGIN
                        VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                        VALIDATE("Disc. Department Name", posDis."Disc. Department Name");

                    END
                    ELSE BEGIN
                        IF ("Management Level".AsInteger() <> 0) AND ("Management Level".AsInteger() <> 6) THEN
                            VALIDATE("Disc. Department Code", "Department Category")
                        ELSE
                            VALIDATE("Disc. Department Code", "Group Code");
                        IF ("Management Level".AsInteger() = 0) OR ("Management Level".AsInteger() = 6) THEN
                            VALIDATE("Disc. Department Name", "Group Description");
                    END;
                END;
                PosMenuNew.SETFILTER(Code, '%1', Rec.Code);
                PosMenuNew.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                PosMenuNew.SETFILTER(Description, '%1', Rec.Description);
                IF PosMenuNew.FIND('-') THEN BEGIN
                    IF PosMenuNew1.GET(PosMenuNew.Code, PosMenuNew.Description, PosMenuNew."Department Code", PosMenuNew."Org. Structure") THEN BEGIN
                        IF NOT PosRename.GET(PosMenuNew.Code, PosMenuNew.Description, "Department Code", PosMenuNew."Org. Structure") THEN
                            PosMenuNew1.RENAME(PosMenuNew.Code, PosMenuNew.Description, "Department Code", PosMenuNew."Org. Structure");
                    END;
                END;




                IF "Group Description" = '' THEN BEGIN
                    Sector := '';
                    "Department Category" := '';
                    "Group Code" := '';
                    "Team Code" := '';
                    "Sector  Description" := '';
                    "Department Categ.  Description" := '';
                    "Group Description" := '';
                    "Team Description" := '';
                    "Department Name" := '';
                    "Disc. Department Code" := '';
                    "Disc. Department Name" := '';
                END;
                IF ("Group Description" <> '') AND ("Team Description" = '') THEN BEGIN
                    "Department Name" := "Group Description";
                END
                ELSE BEGIN
                    "Department Name" := '';
                END;
            end;
        }
        field(50376; "Team Code"; Code[30])
        {
            Caption = 'Team';
            TableRelation = TeamT."Code" WHERE("Org Shema" = FIELD("Org. Structure"));
        }
        field(50377; "Team Description"; Text[100])
        {
            Caption = 'Team Description';
            Editable = true;
            TableRelation = TeamT.Name WHERE("Org Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin
                Department.SETFILTER("Team Description", '%1', "Team Description");
                Department.SETFILTER("ORG Shema", '%1', "Org. Structure");
                IF Department.FIND('-') THEN BEGIN

                    "Team Description" := Department."Team Description";
                    IF "Team Description" <> '' THEN BEGIN
                        VALIDATE("Team Code", Department."Team Code");
                        VALIDATE("Department Code", Department."Team Code");
                        VALIDATE("Group Code", Department."Group Code");
                        VALIDATE("Group Description", Department."Group Description");
                        VALIDATE("Department Category", Department."Department Category");
                        VALIDATE("Department Categ.  Description", Department."Department Categ.  Description");
                        VALIDATE(Sector, Department.Sector);
                        VALIDATE("Sector  Description", Department."Sector  Description");
                    END;
                END;
                IF "Team Description" = '' THEN BEGIN
                    Sector := '';
                    "Department Category" := '';
                    "Group Code" := '';
                    "Team Code" := '';
                    "Sector  Description" := '';
                    "Department Categ.  Description" := '';
                    "Group Description" := '';
                    "Team Description" := '';
                END;


                SectorR.SETFILTER(Description, '%1', "Sector  Description");
                SectorR.SETFILTER("Org Shema", '%1', "Org. Structure");
                IF SectorR.FINDFIRST THEN BEGIN
                    "Sector Identity" := SectorR.Identity;
                END;
                DepartmentC.SETFILTER(Description, '%1', "Department Categ.  Description");
                DepartmentC.SETFILTER("Org Shema", '%1', "Org. Structure");
                IF DepartmentC.FINDFIRST THEN BEGIN
                    "Department Category Identity" := DepartmentC.Identity;
                END;
                IF (("Team Description" <> '')) THEN BEGIN

                    posDis.SETFILTER("Department Code", '%1', "Team Code");
                    posDis.SETFILTER("Management Level", '%1', "Management Level");
                    posDis.SETFILTER("Team Description", '%1', "Team Code");
                    posDis.SETFILTER("Org. Structure", '%1', "Org. Structure");
                    IF posDis.FIND('-') THEN BEGIN
                        VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                        VALIDATE("Disc. Department Name", posDis."Disc. Department Name");
                    END
                    ELSE BEGIN
                        IF ("Management Level".AsInteger() <> 0) AND ("Management Level".AsInteger() <> 6) THEN
                            VALIDATE("Disc. Department Code", "Group Code")
                        ELSE
                            VALIDATE("Disc. Department Code", "Team Code");
                        IF ("Management Level".AsInteger() = 0) OR ("Management Level".AsInteger() = 6) THEN
                            VALIDATE("Disc. Department Name", "Team Description");
                    END;
                END;
                PosMenuNew.SETFILTER(Code, '%1', Rec.Code);
                PosMenuNew.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                PosMenuNew.SETFILTER(Description, '%1', Rec.Description);
                IF PosMenuNew.FIND('-') THEN BEGIN
                    IF PosMenuNew1.GET(PosMenuNew.Code, PosMenuNew.Description, PosMenuNew."Department Code", PosMenuNew."Org. Structure") THEN BEGIN
                        IF NOT PosRename.GET(PosMenuNew.Code, PosMenuNew.Description, "Department Code", PosMenuNew."Org. Structure") THEN
                            PosMenuNew1.RENAME(PosMenuNew.Code, PosMenuNew.Description, "Department Code", PosMenuNew."Org. Structure");

                    END;
                END;
                IF "Team Description" = '' THEN BEGIN
                    Sector := '';
                    "Department Category" := '';
                    "Group Code" := '';
                    "Team Code" := '';
                    "Sector  Description" := '';
                    "Department Categ.  Description" := '';
                    "Group Description" := '';
                    "Team Description" := '';
                    "Department Name" := '';
                    "Disc. Department Code" := '';
                    "Disc. Department Name" := '';
                END;
                IF "Team Description" <> '' THEN BEGIN
                    "Department Name" := "Team Description";
                END
                ELSE BEGIN
                    "Department Name" := '';
                END;
            end;
        }
        field(50378; "Disc. Department Name"; Text[250])
        {
            Caption = 'Disc. Department Name';
            TableRelation = Department.Description WHERE("ORG Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin

                IF "Disc. Department Name" <> '' THEN BEGIN
                    SectorRec.RESET;
                    SectorRec.SETFILTER(Description, '%1', "Disc. Department Name");
                    SectorRec.SETFILTER("Org Shema", '%1', "Org. Structure");
                    IF SectorRec.FINDFIRST THEN BEGIN
                        DepartmentNew.RESET;
                        DepartmentNew.SETFILTER(Description, '%1', "Disc. Department Name");
                        DepartmentNew.SETFILTER("ORG Shema", '%1', "Org. Structure");
                        IF DepartmentNew.FINDFIRST THEN BEGIN
                            HeadOf.SETFILTER(Sector, '%1', DepartmentNew.Sector);
                            HeadOf.SETFILTER("Sector  Description", '%1', DepartmentNew."Sector  Description");
                            HeadOf.SETFILTER("Department Category", '%1', DepartmentNew."Department Category");
                            HeadOf.SETFILTER("Department Categ.  Description", '%1', DepartmentNew."Department Categ.  Description");
                            HeadOf.SETFILTER("Group Code", '%1', DepartmentNew."Group Code");
                            HeadOf.SETFILTER("Group Description", '%1', DepartmentNew."Group Description");
                            HeadOf.SETFILTER("Team Code", '%1', DepartmentNew."Team Code");
                            HeadOf.SETFILTER("Team Description", '%1', DepartmentNew."Team Description");
                            HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                            IF HeadOf.FIND('-') THEN BEGIN
                                HeadOf.CALCFIELDS("Employee No.");
                                "Manager 1 Code" := HeadOf."Employee No.";
                                "Manager 1  Department Code" := HeadOf."Department Code";
                                Position.RESET;
                                Position.SETFILTER("Employee No.", '%1', "Manager 1 Code");
                                Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                                IF Position.FINDFIRST THEN BEGIN
                                    "Manager 1 Position Code" := Position.Code;
                                    "Manager 1 Position ID" := Position."Position ID";
                                END
                                ELSE BEGIN
                                    "Manager 1 Position Code" := '';
                                    "Manager 1 Position ID" := Position."Position ID";
                                END;



                                "Disc. Department Code" := "Manager 1  Department Code";
                                "Disc. Department Name" := "Disc. Department Name";
                            END
                            ELSE BEGIN
                                "Manager 1 Code" := '';
                                "Manager 1  Department Code" := '';
                                "Manager 2 Code" := '';
                                "Manager 2  Department Code" := '';
                            END;

                            FOR i := 1 TO STRLEN("Disc. Department Code") DO BEGIN
                                String := "Department Code";
                                IF String[i] = '.' THEN BEGIN
                                    Brojac := Brojac + 1;
                                    IF Brojac = 1 THEN
                                        PozicijaUprava := i;
                                END;
                            END;

                            Uprava := COPYSTR("Disc. Department Code", 1, PozicijaUprava);
                            HeadOf.RESET;
                            HeadOf.SETFILTER("Department Code", '%1', Uprava);
                            HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                            IF HeadOf.FINDFIRST THEN BEGIN
                                HeadOf.CALCFIELDS("Employee No.");
                                "Manager 2 Code" := HeadOf."Employee No.";
                                Position.RESET;
                                Position.SETFILTER("Employee No.", '%1', "Manager 2 Code");
                                Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                                IF Position.FINDFIRST THEN BEGIN

                                    "Manager 2  Department Code" := Position."Department Code";
                                    "Manager 2 Position Code" := Position.Code;
                                    "Manager 2 Position ID" := Position."Position ID";
                                END
                                ELSE BEGIN
                                    "Manager 2  Department Code" := '';
                                    "Manager 2 Position Code" := '';
                                    "Manager 2 Position ID" := '';
                                END;
                            END;


                        END;
                    END;

                    DepCat.RESET;
                    DepCat.SETFILTER(Description, '%1', "Disc. Department Name");
                    DepCat.SETFILTER("Org Shema", '%1', "Org. Structure");
                    IF DepCat.FINDFIRST THEN BEGIN
                        DepartmentNew.RESET;
                        DepartmentNew.SETFILTER("Department Categ.  Description", '%1', "Disc. Department Name");
                        DepartmentNew.SETFILTER("Department Type", '%1', 4);
                        DepartmentNew.SETFILTER("ORG Shema", '%1', "Org. Structure");
                        IF DepartmentNew.FINDFIRST THEN BEGIN
                            HeadOf.SETFILTER(Sector, '%1', DepartmentNew.Sector);
                            HeadOf.SETFILTER("Sector  Description", '%1', DepartmentNew."Sector  Description");
                            HeadOf.SETFILTER("Department Category", '%1', DepartmentNew."Department Category");
                            HeadOf.SETFILTER("Department Categ.  Description", '%1', DepartmentNew."Department Categ.  Description");
                            HeadOf.SETFILTER("Group Code", '%1', DepartmentNew."Group Code");
                            HeadOf.SETFILTER("Group Description", '%1', DepartmentNew."Group Description");
                            HeadOf.SETFILTER("Team Code", '%1', DepartmentNew."Team Code");
                            HeadOf.SETFILTER("Team Description", '%1', DepartmentNew."Team Description");
                            HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                            IF HeadOf.FIND('-') THEN BEGIN
                                HeadOf.CALCFIELDS("Employee No.");
                                "Manager 1 Code" := HeadOf."Employee No.";
                                "Manager 1  Department Code" := HeadOf."Department Code";
                                "Disc. Department Code" := "Manager 1  Department Code";
                                "Disc. Department Name" := "Disc. Department Name";
                            END
                            ELSE BEGIN
                                "Manager 1 Code" := '';
                                "Manager 1  Department Code" := '';
                            END;
                            HeadOf.RESET;
                            HeadOf.SETFILTER(Sector, '%1', DepartmentNew.Sector);
                            HeadOf.SETFILTER("Sector  Description", '%1', DepartmentNew."Sector  Description");
                            HeadOf.SETFILTER("Department Category", '%1', '');
                            HeadOf.SETFILTER("Department Categ.  Description", '%1', '');
                            HeadOf.SETFILTER("Group Code", '%1', '');
                            HeadOf.SETFILTER("Group Description", '%1', '');
                            HeadOf.SETFILTER("Team Code", '%1', '');
                            HeadOf.SETFILTER("Team Description", '%1', '');
                            HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                            IF HeadOf.FIND('-') THEN BEGIN
                                HeadOf.CALCFIELDS("Employee No.");
                                "Manager 2 Code" := HeadOf."Employee No.";
                                "Manager 2  Department Code" := HeadOf."Department Code";
                            END
                            ELSE BEGIN
                                "Manager 2 Code" := '';
                                "Manager 2  Department Code" := '';
                            END;


                        END;
                    END;
                    TeamRec.RESET;
                    TeamRec.SETFILTER(Name, '%1', "Disc. Department Name");
                    TeamRec.SETFILTER("Org Shema", '%1', "Org. Structure");
                    IF TeamRec.FINDFIRST THEN BEGIN
                        DepartmentNew.RESET;
                        DepartmentNew.SETFILTER("Team Description", '%1', "Disc. Department Name");
                        DepartmentNew.SETFILTER("Department Type", '%1', 9);
                        DepartmentNew.SETFILTER("ORG Shema", '%1', "Org. Structure");
                        IF DepartmentNew.FINDFIRST THEN BEGIN
                            HeadOf.SETFILTER(Sector, '%1', DepartmentNew.Sector);
                            HeadOf.SETFILTER("Sector  Description", '%1', DepartmentNew."Sector  Description");
                            HeadOf.SETFILTER("Department Category", '%1', DepartmentNew."Department Category");
                            HeadOf.SETFILTER("Department Categ.  Description", '%1', DepartmentNew."Department Categ.  Description");
                            HeadOf.SETFILTER("Group Code", '%1', DepartmentNew."Group Code");
                            HeadOf.SETFILTER("Group Description", '%1', DepartmentNew."Group Description");
                            HeadOf.SETFILTER("Team Code", '%1', DepartmentNew."Team Code");
                            HeadOf.SETFILTER("Team Description", '%1', DepartmentNew."Team Description");
                            HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                            IF HeadOf.FIND('-') THEN BEGIN
                                HeadOf.CALCFIELDS("Employee No.");
                                "Manager 1 Code" := HeadOf."Employee No.";
                                "Manager 1  Department Code" := HeadOf."Department Code";
                                "Disc. Department Code" := "Manager 1  Department Code";
                                "Disc. Department Name" := "Disc. Department Name";
                            END
                            ELSE BEGIN
                                "Manager 1 Code" := '';
                                "Manager 1  Department Code" := '';
                            END;
                            HeadOf.RESET;
                            HeadOf.SETFILTER(Sector, '%1', DepartmentNew.Sector);
                            HeadOf.SETFILTER("Sector  Description", '%1', DepartmentNew."Sector  Description");
                            HeadOf.SETFILTER("Department Category", '%1', DepartmentNew."Department Category");
                            HeadOf.SETFILTER("Department Categ.  Description", '%1', DepartmentNew."Department Categ.  Description");
                            HeadOf.SETFILTER("Group Code", '%1', DepartmentNew."Group Code");
                            HeadOf.SETFILTER("Group Description", '%1', DepartmentNew."Group Description");
                            HeadOf.SETFILTER("Team Code", '%1', '');
                            HeadOf.SETFILTER("Team Description", '%1', '');
                            HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                            IF HeadOf.FIND('-') THEN BEGIN
                                HeadOf.CALCFIELDS("Employee No.");
                                "Manager 2 Code" := HeadOf."Employee No.";
                                "Manager 2  Department Code" := HeadOf."Department Code";
                            END
                            ELSE BEGIN
                                "Manager 1 Code" := '';
                                "Manager 1  Department Code" := '';
                            END;


                        END;
                    END;
                    GroupRec.RESET;
                    GroupRec.SETFILTER(Description, '%1', "Disc. Department Name");
                    GroupRec.SETFILTER("Org Shema", '%1', "Org. Structure");
                    IF GroupRec.FINDFIRST THEN BEGIN
                        DepartmentNew.RESET;
                        DepartmentNew.SETFILTER("Group Description", '%1', "Disc. Department Name");
                        DepartmentNew.SETFILTER("Department Type", '%1', 2);
                        DepartmentNew.SETFILTER("ORG Shema", '%1', "Org. Structure");
                        IF DepartmentNew.FINDFIRST THEN BEGIN
                            HeadOf.SETFILTER(Sector, '%1', DepartmentNew.Sector);
                            HeadOf.SETFILTER("Sector  Description", '%1', DepartmentNew."Sector  Description");
                            HeadOf.SETFILTER("Department Category", '%1', DepartmentNew."Department Category");
                            HeadOf.SETFILTER("Department Categ.  Description", '%1', DepartmentNew."Department Categ.  Description");
                            HeadOf.SETFILTER("Group Code", '%1', DepartmentNew."Group Code");
                            HeadOf.SETFILTER("Group Description", '%1', DepartmentNew."Group Description");
                            HeadOf.SETFILTER("Team Code", '%1', DepartmentNew."Team Code");
                            HeadOf.SETFILTER("Team Description", '%1', DepartmentNew."Team Description");
                            HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                            IF HeadOf.FIND('-') THEN BEGIN
                                HeadOf.CALCFIELDS("Employee No.");
                                "Manager 1 Code" := HeadOf."Employee No.";
                                "Manager 1  Department Code" := HeadOf."Department Code";
                                "Disc. Department Code" := "Manager 1  Department Code";
                                "Disc. Department Name" := "Disc. Department Name";
                            END
                            ELSE BEGIN
                                "Manager 1 Code" := '';
                                "Manager 1  Department Code" := '';
                            END;
                            HeadOf.RESET;
                            HeadOf.SETFILTER(Sector, '%1', DepartmentNew.Sector);
                            HeadOf.SETFILTER("Sector  Description", '%1', DepartmentNew."Sector  Description");
                            HeadOf.SETFILTER("Department Category", '%1', DepartmentNew."Department Category");
                            HeadOf.SETFILTER("Department Categ.  Description", '%1', DepartmentNew."Department Categ.  Description");
                            HeadOf.SETFILTER("Group Code", '%1', '');
                            HeadOf.SETFILTER("Group Description", '%1', '');
                            HeadOf.SETFILTER("Team Code", '%1', '');
                            HeadOf.SETFILTER("Team Description", '%1', '');
                            HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                            IF HeadOf.FIND('-') THEN BEGIN
                                HeadOf.CALCFIELDS("Employee No.");
                                "Manager 2 Code" := HeadOf."Employee No.";
                                "Manager 2  Department Code" := HeadOf."Department Code";
                            END
                            ELSE BEGIN
                                "Manager 1 Code" := '';
                                "Manager 1  Department Code" := '';
                            END;
                        END;
                    END;




                    /*  Position.SETFILTER("Employee No.",'%1',"Manager 1 Code");
               Position.SETFILTER("Org. Structure",'%1',"Org. Structure");
               IF Position.FIND('-') THEN BEGIN
               "Manager 2 Code":=Position."Manager 1 Code";
               "Manager 2  Department Code":=Position."Disc. Department Code";
               END
               ELSE BEGIN
                 "Manager 2 Code":='';
                 "Manager 2  Department Code":='';
                 END;*/

                    IF "Employee No." = "Manager 1 Code" THEN "Manager Is Employee" := TRUE;

                    IF "Manager 1 Code" <> '' THEN BEGIN
                        emp.RESET;
                        emp.SETFILTER("No.", '%1', "Manager 1 Code");
                        IF emp.FINDFIRST THEN
                            "Manager Name 1" := emp."Last Name" + ' ' + emp."First Name";
                    END;
                END;

            end;
        }
        field(50379; Vocation; Code[20])
        {
            Caption = 'Vocation code';
            Editable = false;
            TableRelation = Vocation.Code;
        }
        field(50380; "Vocation Description"; Text[250])
        {
            Caption = 'Vocation description';
            TableRelation = Vocation."Description New";

            trigger OnValidate()
            begin
                IF "Vocation Description" <> '' THEN BEGIN
                    VocationRec.SETFILTER("Description New", '%1', "Vocation Description");
                    IF VocationRec.FINDFIRST THEN BEGIN
                        Vocation := VocationRec.Code;
                    END
                    ELSE BEGIN
                        Vocation := '';
                    END;
                END
                ELSE BEGIN
                    Vocation := '';
                END;
            end;
        }
        field(50381; Agency; Boolean)
        {
            Caption = 'Has Agency';
        }
        field(50382; "Changing Position"; Boolean)
        {
            Caption = 'Changing Position';

            trigger OnValidate()
            begin
                IF ("Changing Position" = TRUE) AND ("Will Be Changed Later" = FALSE) THEN BEGIN
                    Pos.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                    Pos.SETFILTER(Code, '%1', Rec.Code);
                    Pos.SETFILTER("Changing Position", '%1', FALSE);
                    // Pos.SETFILTER(Description,'%1',Rec.Description);//DODALA
                    IF Pos.FINDSET THEN
                        REPEAT
                            Pos."Changing Position" := TRUE;
                            Pos.MODIFY(TRUE);

                            Pos.GET(Pos.Code, Pos."Position ID", Pos."Org. Structure", Pos.Description);
                        UNTIL Pos.NEXT = 0;
                END;
            end;
        }
        field(50383; "Old Code"; Code[20])
        {
        }
        field(50384; "Changing Group"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Group"."Changing Department" WHERE("Code" = FIELD("Department Code"),
                                                                    "Org Shema" = FIELD("Org. Structure")));
            Caption = 'Changing Department';


            trigger OnValidate()
            begin
                /*IF Rec."Changing Department" THEN BEGIN
                  Dep.SETFILTER("ORG Shema",'%1',Rec."ORG Shema");
                  Dep.SETFILTER(Code,'%1',Rec.Code);
                  Dep.SETFILTER("Changing Department",'%1',FALSE);
                  IF Dep.FINDSET THEN REPEAT
                    Dep."Changing Department":=TRUE;
                   Dep.MODIFY(TRUE);
                
                     Dep.GET(Dep.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description");
                    UNTIL Dep.NEXT=0;
                    END;*/

            end;
        }
        field(50385; "Changing Team"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(TeamT."Changing Department" WHERE("Code" = FIELD("Department Code"),
                                                                   "Org Shema" = FIELD("Org. Structure")));
            Caption = 'Changing Department';


            trigger OnValidate()
            begin
                /*IF Rec."Changing Department" THEN BEGIN
                  Dep.SETFILTER("ORG Shema",'%1',Rec."ORG Shema");
                  Dep.SETFILTER(Code,'%1',Rec.Code);
                  Dep.SETFILTER("Changing Department",'%1',FALSE);
                  IF Dep.FINDSET THEN REPEAT
                    Dep."Changing Department":=TRUE;
                   Dep.MODIFY(TRUE);
                
                     Dep.GET(Dep.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description");
                    UNTIL Dep.NEXT=0;
                    END;*/

            end;
        }
        field(50386; "Changing Dep"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Department Category"."Changing Department" WHERE("Code" = FIELD("Department Code"),
                                                                                    "Org Shema" = FIELD("Org. Structure")));
            Caption = 'Changing Department';


            trigger OnValidate()
            begin
                /*IF Rec."Changing Department" THEN BEGIN
                  Dep.SETFILTER("ORG Shema",'%1',Rec."ORG Shema");
                  Dep.SETFILTER(Code,'%1',Rec.Code);
                  Dep.SETFILTER("Changing Department",'%1',FALSE);
                  IF Dep.FINDSET THEN REPEAT
                    Dep."Changing Department":=TRUE;
                   Dep.MODIFY(TRUE);
                
                     Dep.GET(Dep.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description");
                    UNTIL Dep.NEXT=0;
                    END;*/

            end;
        }
        field(50387; "Changing Sector"; Boolean)
        {
            FieldClass = FlowField;


            CalcFormula = Lookup(Sector."Changing Department" WHERE("Code" = FIELD("Department Code"),
                                                                     "Org Shema" = FIELD("Org. Structure")));
            Caption = 'Changing Department';


            trigger OnValidate()
            begin
                /*IF Rec."Changing Department" THEN BEGIN
                  Dep.SETFILTER("ORG Shema",'%1',Rec."ORG Shema");
                  Dep.SETFILTER(Code,'%1',Rec.Code);
                  Dep.SETFILTER("Changing Department",'%1',FALSE);
                  IF Dep.FINDSET THEN REPEAT
                    Dep."Changing Department":=TRUE;
                   Dep.MODIFY(TRUE);
                
                     Dep.GET(Dep.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description");
                    UNTIL Dep.NEXT=0;
                    END;*/

            end;
        }
        field(50388; "Operator No."; Code[40])
        {
            Caption = 'Operator No.';
            Editable = false;
        }
        field(50389; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50390; Role; Code[10])
        {
            Caption = 'Role code';
        }
        /*    field(50391; "Role Name"; Text[100])
            {
                Caption = 'Role Description';
                //    TableRelation = Role.Description WHERE(Status = CONST(A));

                trigger OnValidate()
                begin
                    Roles.RESET;
                    Roles.SETFILTER(Description, '%1', "Role Name");
                    Roles.SETFILTER(Status, '%1', Roles.Status::A);
                    IF Roles.FINDFIRST THEN BEGIN
                        Role := Roles.Code;
                    END
                    ELSE BEGIN
                        Role := '';
                    END;

                    PositionMenu1.RESET;
                    PositionMenu1.SETFILTER(Code, '%1', Code);
                    PositionMenu1.SETFILTER(Description, '%1', Description);
                    PositionMenu1.SETFILTER("Department Code", '%1', "Department Code");
                    PositionMenu1.SETFILTER("Org. Structure", '%1', "Org. Structure");
                    IF PositionMenu1.FINDFIRST THEN BEGIN
                        //      PositionMenu1.VALIDATE("Role Name", "Role Name");
                        //    PositionMenu1.MODIFY;
                    END;
                end;
            }*/
        field(50392; "BJF/GJF"; Option)
        {
            Caption = 'BJF/GJF';
            OptionCaption = ' ,BJF,GJF';
            OptionMembers = " ",BJF,GJF;

            trigger OnValidate()
            begin
                PositionMenu1.RESET;
                PositionMenu1.SETFILTER(Code, '%1', Code);
                PositionMenu1.SETFILTER(Description, '%1', Description);
                PositionMenu1.SETFILTER("Department Code", '%1', "Department Code");
                PositionMenu1.SETFILTER("Org. Structure", '%1', "Org. Structure");
                IF PositionMenu1.FINDFIRST THEN BEGIN
                    PositionMenu1."BJF/GJF" := "BJF/GJF";
                    PositionMenu1.MODIFY;
                END;
            end;
        }
        field(50393; "Will Be Changed Later"; Boolean)
        {
            Caption = 'Will Be Changed Later';

            trigger OnValidate()
            begin
                /*IF Rec."Changing Position" THEN BEGIN
                  Pos.SETFILTER("Org. Structure",'%1',Rec."Org. Structure");
                  Pos.SETFILTER(Code,'%1',Rec.Code);
                  Pos.SETFILTER("Will Be Changed Later",'%1',FALSE);
                  IF Pos.FINDSET THEN REPEAT
                    Pos."Will Be Changed Later":=TRUE;
                    Pos.MODIFY(TRUE);
                     Pos.GET(Pos.Code,Pos."Position ID",Pos."Org. Structure",Pos.Description);
                    UNTIL Pos.NEXT=0;
                    END;*/

            end;
        }
        field(50394; "Work Group"; Text[10])
        {
        }
        field(50395; Identity; Integer)
        {
            AutoIncrement = false;
        }
        field(50396; "Position Menu Identity"; Integer)
        {
        }
        field(50397; "Sector Identity"; Integer)
        {
            BlankZero = true;
        }
        field(50398; "Department Category Identity"; Integer)
        {
            BlankZero = true;
        }
        field(50399; "Manager Name 1"; Text[30])
        {
        }
        field(50400; "The Same Level"; Boolean)
        {
            Caption = 'The Same Level';
        }
        field(50401; "Exe Manager"; Text[250])
        {
            TableRelation = Position."Employee Full Name" WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                                 "Management Level" = FILTER(Exe | CEO));
        }
        field(50402; "Role 2"; Code[10])
        {
            FieldClass = FlowField;

            CalcFormula = Lookup("Position Menu".Role WHERE("Code" = FIELD("Code"),
                                                             Description = FIELD(Description),
                                                             "Org. Structure" = FIELD("Org. Structure"),
                                                             "Department Code" = FIELD("Department Code")));
            Caption = 'Role code';
            Editable = false;

        }
        /*  field(50403; "Role Name 2"; Text[100])
          {
              FieldClass = FlowField;
              CalcFormula = Lookup("Position Menu"."Role Name" WHERE("Code" = FIELD("Code"),
                                                                      Description = FIELD(Description),
                                                                      "Org. Structure" = FIELD("Org. Structure"),
                                                                      "Department Code" = FIELD("Department Code")));
              Caption = 'Role Description';
              Editable = false;

              TableRelation = Role.Description WHERE(Status = CONST(A));

              trigger OnValidate()
              begin
                  Roles.RESET;
                  Roles.SETFILTER(Description, '%1', "Role Name");
                  Roles.SETFILTER(Status, '%1', Roles.Status::A);
                  IF Roles.FINDFIRST THEN BEGIN
                      Role := Roles.Code;
                  END
                  ELSE BEGIN
                      Role := '';
                  END;

                  PositionMenu1.RESET;
                  PositionMenu1.SETFILTER(Code, '%1', Code);
                  PositionMenu1.SETFILTER(Description, '%1', Description);
                  PositionMenu1.SETFILTER("Department Code", '%1', "Department Code");
                  PositionMenu1.SETFILTER("Org. Structure", '%1', "Org. Structure");
                  IF PositionMenu1.FINDFIRST THEN BEGIN
                      PositionMenu1.VALIDATE("Role Name", "Role Name");
                      PositionMenu1.MODIFY;
                  END;
              end;
          }*/
        field(50404; "BJF/GJF 2"; Option)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Position Menu"."BJF/GJF" WHERE("Code" = FIELD("Code"),
                                                                Description = FIELD(Description),
                                                                "Org. Structure" = FIELD("Org. Structure"),
                                                                "Department Code" = FIELD("Department Code")));
            Caption = 'BJF/GJF';
            Editable = false;

            OptionCaption = ' ,BJF,GJF';
            OptionMembers = " ",BJF,GJF;

            trigger OnValidate()
            begin
                PositionMenu1.RESET;
                PositionMenu1.SETFILTER(Code, '%1', Code);
                PositionMenu1.SETFILTER(Description, '%1', Description);
                PositionMenu1.SETFILTER("Department Code", '%1', "Department Code");
                PositionMenu1.SETFILTER("Org. Structure", '%1', "Org. Structure");
                IF PositionMenu1.FINDFIRST THEN BEGIN
                    PositionMenu1."BJF/GJF" := "BJF/GJF";
                    PositionMenu1.MODIFY;
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Code", "Position ID", "Org. Structure", Description)
        {
        }
        key(Key2; Description)
        {
        }
        key(Key3; "Manager 1", "Manager 1 Name")
        {
        }
        key(Key4; "Employee No.", "Employee Full Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Description, "Code")
        {
        }
    }

    trigger OnDelete()
    begin

        /*WPConnSetup.FINDFIRST();
        
        
        CREATE(conn, TRUE, TRUE);
        
        conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                  +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
        
        CREATE(comm,TRUE, TRUE);
        
        lvarActiveConnection := conn;
        comm.ActiveConnection := lvarActiveConnection;
        
        comm.CommandText := 'dbo.Position_Delete';
        comm.CommandType := 4;
        comm.CommandTimeout := 0;
        
        param:=comm.CreateParameter('@Code', 200, 1, 10, Rec.Code);
        comm.Parameters.Append(param);
        
        comm.Execute;
        conn.Close;
        CLEAR(conn);
        CLEAR(comm);*/
        /*IF "Employee No."<> '' THEN BEGIN
        ERROR(Text000);
        END;*/

    end;

    trigger OnInsert()
    begin

        /*WPConnSetup.FINDFIRST();
        
        
        CREATE(conn, TRUE, TRUE);
        
        conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                  +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
        
        CREATE(comm,TRUE, TRUE);
        
        lvarActiveConnection := conn;
        comm.ActiveConnection := lvarActiveConnection;
        
        comm.CommandText := 'dbo.Position_Insert';
        comm.CommandType := 4;
        comm.CommandTimeout := 0;
        
        param:=comm.CreateParameter('@Code', 200, 1, 10, Rec.Code);
        comm.Parameters.Append(param);
        param:=comm.CreateParameter('@Descriptiom', 200, 1, 100,Rec.Description);
        comm.Parameters.Append(param);
        param:=comm.CreateParameter('@DepartmentCode', 200, 1, 10, Rec."Department Code");
        comm.Parameters.Append(param);
        param:=comm.CreateParameter('@EduLevel', 200, 1, 30, Rec."Minimal Education Level");
        comm.Parameters.Append(param);
        
        comm.Execute;
        conn.Close;
        CLEAR(conn);
        CLEAR(comm);*/

        OrgStr.SETFILTER(Status, '%1', OrgStr.Status::Active);
        IF OrgStr.FINDFIRST THEN BEGIN
            "Org. Structure" := OrgStr.Code;
        END;
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
        //IF NOT "Changing Position" THEN BEGIN
        Pos.SETCURRENTKEY(Code, Order);
        Pos.SETFILTER(Code, '%1', Code);

        IF Pos.FINDLAST THEN BEGIN
            EVALUATE(PosIDInt, Pos."Position ID");
            PosIDInt += 1;
            "Position ID" := FORMAT(PosIDInt);
            Description := Pos.Description;
            "Cube Codes" := Pos."Cube Codes";
            Type := Pos.Type;
            "Cost Type" := Pos."Cost Type";
            "Wellcome E-mail" := Pos."Wellcome E-mail";
            "E-learning application" := Pos."E-learning application";
            "E-learning education" := Pos."E-learning education";
            "Education plan" := Pos."Education plan";
            Test := Pos.Test;
            "On Boarding" := Pos."On Boarding";
            "Attachment 1" := Pos."Attachment 1";
            "Attachment 2" := Pos."Attachment 2";

            /* "Team Code":=Pos. "Team Code";
             "Team Description":=Pos."Team Description";
             "Group Code":=Pos. "Group Code";
             "Group Description":=Pos."Group Description";
             "Department Category":=Pos. "Department Category";
             "Department Categ.  Description":=Pos."Department Categ.  Description";
             Sector:=Pos.Sector;
             "Sector  Description":=Pos."Sector  Description";*/
            Agency := Pos.Agency;
            Vocation := Pos.Vocation;
            "Vocation Description" := Pos."Vocation Description";
            "Key Function" := Pos."Key Function";
            "Control Function" := Pos."Control Function";
            "BJF/GJF" := Pos."BJF/GJF";
            Role := Pos.Role;
            //    "Role Name" := Pos."Role Name";
            EVALUATE(Order, "Position ID")


        END
        ELSE BEGIN
            "Position ID" := FORMAT(1);
            EVALUATE(Order, "Position ID");

        END;
        /*ELSE BEGIN
        
        PosMenu.SETFILTER(Code,'%1',Code);
        PosMenu.SETFILTER(Description,'%1',Description);
        IF NOT PosMenu.FINDFIRST THEN BEGIN
          "Position ID":= FORMAT(1);
          PosMenu.INIT;
          PosMenu.Code:=Code;
          PosMenu.Description:=Description;
          PosMenu."Department Code":="Department Code";
          PosMenu."Org. Structure":="Org. Structure";
          PosMenu.INSERT;
          END;
        END;*/
        IF "Position ID" <> '' THEN
            EVALUATE(Order, "Position ID");

        ECL.RESET;
        ECL.SETFILTER("Org. Structure", '%1', "Org. Structure");
        ECL.SETFILTER("Position Code", '%1', Code);
        ECL.SETFILTER("Employee Status", '%1', 0);
        ECL.SETFILTER("Position ID", '%1', "Position ID");
        IF ECL.FINDFIRST THEN BEGIN
            "Employee No." := ECL."Employee No.";
            "Employee Full Name" := ECL."Employee Name";
        END;
        // END;

    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15)
    end;

    var
        WPConnSetup: Record "Web portal connection setup";
        /* conn: Automation;
         comm: Automation;
         param: Automation;*/
        lvarActiveConnection: Variant;
        ExeManager: Record "Exe Manager";
        OrgStr: Record "ORG Shema";
        Pos: Record "Position";
        PosIDInt: Integer;
        PosIDText: Text;
        ECL: Record "Employee Contract Ledger";
        Department: Record "Department";
        // SD: Record "Segmentation Data";
        //     WDV: Record "Work Duties Violation";
        //   WDVM: Record "Work Duties Violation";
        //  WDVR: Record "Work Duties Violation";
        HeadOf: Record "Head Of's";
        DepartmentM: Record "Department";
        HeadOfM: Record "Head Of's";
        DimMgt: Codeunit "DimensionManagement";
        VocationRec: Record "Vocation";
        Head: Boolean;
        Position: Record "Position";
        Pos2: Record "Position";
        PosC: Record "Position";
        Depa: Record Department;
        Posa: Record "Position Menu";
        PosMenu: Record "Position Menu";
        Text000: Label 'You must not delete an active position!';
        posDis: Record "Position";
        PosI: Record "Position";
        SectorR: Record "Sector";
        DepartmentC: Record "Department Category";
        emp: Record "Employee";
        PositionMenu1: Record "Position Menu";
        PosMenuNew: Record "Position Menu";
        PosChangeID: Record "Position";
        ECL1: Record "Employee Contract Ledger";
        PositionDisc: Record "Position";
        DepartmentNew: Record "Department";
        FindLevelHigh: Record "Department";
        FIndDiscDepartmentCode: Record "Department";
        Uprava: Code[20];
        SectorRec: Record "Sector";
        DepCat: Record "Department Category";
        GroupRec: Record "Group";
        TeamRec: Record "TeamT";
        FindLevel: Code[20];
        i: Integer;
        String: Text;
        Brojac: Integer;
        PozicijaUprava: Integer;
        PosMenuNew1: Record "Position Menu";
        //        Roles: Record "Role";
        DepartmentName: Record "Department";
        DepartmentNamePage: Page "Department";
        DimensionValue: Record "Dimension Value";
        PosRename: Record "Position Menu";
        SectorTabela: Record "Sector";
}

