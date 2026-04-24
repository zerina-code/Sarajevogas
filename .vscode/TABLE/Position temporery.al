table 50134 "Position temporery"
{
    Caption = 'Position';
    DrillDownPageID = "Position temporary sist";
    LookupPageID = "Position temporary sist";

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

                IF Pos.FINDLAST THEN BEGIN
                    EVALUATE(PosIDInt, Pos."Position ID");
                    PosIDInt += 1;
                    "Position ID" := FORMAT(PosIDInt);
                    //  Description:=Pos.Description;
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
                    "Role Name" := Pos."Role Name";
                    /* "Disc. Department Code":=Pos."Disc. Department Code";
                    "Disc. Department Name":=Pos."Disc. Department Name";*/
                END
                ELSE BEGIN
                    "Position ID" := FORMAT(1);
                    ECLSys.RESET;
                    ECLSys.SETFILTER("Position Code", '%1', Code);
                    IF ECLSys.FINDFIRST THEN BEGIN
                        VALIDATE("Disc. Department Code", ECLSys."Department Code");
                    END;
                END;
                IF "Position ID" <> '' THEN
                    EVALUATE(Order, "Position ID");
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
                   { "Employee No.":=ECL."Employee No.";
                    "Employee Full Name":= ECL."Employee Name";}
                    "Position ID":=ECL."Position ID";
                    //ECL."Position ID":="Position ID";
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
                ECL.SETFILTER("Position ID", '%1', "Position ID");
                IF ECL.FINDFIRST THEN BEGIN
                    "Employee No." := ECL."Employee No.";
                    "Employee Full Name" := ECL."Employee Name";
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
            Editable = false;
            TableRelation = "Department temporary".Code WHERE("ORG Shema" = FIELD("Org. Structure"));

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

            end;
        }
        field(4; "Minimal Education Level"; Option)
        {
            Caption = 'Education level';
            OptionCaption = ' ,I Stepen četri razreda osnovne,II Stepen - osnovna škola,III Stepen - SSS srednja škola,IV Stepen - SSS srednja škola,V Stepen - VKV - SSS srednja škola,VI Stepen - VS viša škola,VII Stepen - VSS visoka stručna sprema,VII-1 Stepen - Specijalista,VII-2 Stepen - Magistratura,VIII Stepen - Doktorat  ';
            OptionMembers = " ","NSS - Niža stručna sprema ","SSS - Srednja stručna sprema","KV - Kvalificirani radnik ","VKV - Visoko kvalificirani radnik ","VS - Viša stručna sprema","VSS - Visoka stručna sprema","MR - Magistar","DR - Doktor nauka ";

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

                //PosMenu.SETFILTER(Code,'%1',Code);
                /*PosMenu.SETFILTER(Description,'%1',Description);
                PosMenu.SETFILTER("Org. Structure",'%1',"Org. Structure");
               IF PosMenu.FIND('-') THEN BEGIN
                PosMenu.Description:=Description;
                PosMenu."Org. Structure":="Org. Structure";
                PosMenu.MODIFY;
                END
                ELSE BEGIN
                PosMenu.Code:=Code;
                PosMenu.Description:=Description;
                PosMenu."Department Code":="Department Code";
                PosMenu."Org. Structure":="Org. Structure";
                PosMenu.INSERT;
              END;
              IF xRec.Description<>Rec.Description THEN BEGIN
               PositionMenu1.RESET;
               PositionMenu1.SETFILTER(Description,xRec.Description);
               PositionMenu1.SETFILTER("Org. Structure",'%1',Rec."Org. Structure");
               IF PositionMenu1.FINDFIRST THEN BEGIN
               IF PositionMenu1.GET(Code,xRec.Description,"Department Code","Org. Structure") THEN
               PositionMenu1.DELETE;
               END;
               END;*/

            end;
        }
        field(50008; "Org. Structure"; Code[20])
        {
            Caption = 'Org. Structure';
            TableRelation = "ORG Shema";
        }
        field(50009; Status; enum "Employee Status")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee.Status WHERE("No." = FIELD("Employee No.")));
            Caption = 'Status';


        }
        field(50320; "Manager Department Code"; Code[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position."Department Code" WHERE(Code = FIELD("Manager Position Code"),
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
            TableRelation = Position."Position ID" WHERE(Code = FIELD("Manager Position Code"));

            trigger OnValidate()
            begin
                ECL.RESET;
                ECL.SETFILTER("Org. Structure", '%1', "Org. Structure");
                ECL.SETFILTER("Position Code", '%1', "Manager Position Code");
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
            //     TableRelation = Type;
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
        field(50332; "Manager 1 Name"; Text[50])
        {
            Caption = 'Manager 1 Name';
            Editable = true;
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
                                                                       "Position Code" = FIELD(Code),
                                                                       "Position ID" = FIELD("Position ID")));
        }
        field(50348; "Department Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Department.Description WHERE(Code = FIELD("Department Code"),
                                                               "ORG Shema" = FIELD("Org. Structure")));
            Caption = 'Department Name';

        }
        field(50349; "Manager Department Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Department temporary".Description WHERE(Code = FIELD("Manager Department Code"),
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
            TableRelation = "Department temporary";

            trigger OnValidate()
            begin

                IF "Disc. Department Name" = '' THEN BEGIN
                    SETCURRENTKEY("Department Code");
                    HeadOf.RESET;
                    HeadOf.SETFILTER("Department Code", '%1', "Disc. Department Code");
                    /*
                    HeadOf.SETFILTER("Team Description",'%1',"Team Description");
                    HeadOf.SETFILTER("Group Description",'%1',"Group Description");
                    HeadOf.SETFILTER("Department Categ.  Description",'%1',"Department Categ.  Description");
                    HeadOf.SETFILTER("Sector  Description",'%1',"Sector  Description");*/
                    HeadOf.SETFILTER("ORG Shema", '%1', "Org. Structure");
                    HeadOf.SETFILTER(NonActive, '%1', FALSE);
                    IF HeadOf.FIND('-') THEN BEGIN
                        HeadOf.CALCFIELDS("Employee No.");
                        "Manager 1 Code" := HeadOf."Employee No.";
                    END
                    ELSE BEGIN
                        "Manager 1 Code" := '';
                    END;

                    /*sb DepartmentM.SETFILTER(Code,'%1',"Disc. Department Code");
                    DepartmentM.SETFILTER("ORG Shema",'%1',"Org. Structure");
                    IF DepartmentM.FIND('-') THEN BEGIN
                    "Manager 2  Department Code":=DepartmentM."Managing Org 2";

                    HeadOfM.SETFILTER("Department Code",'%1',"Manager 2  Department Code");
                    HeadOfM.SETFILTER("ORG Shema",'%1',"Org. Structure");
                    HeadOfM.SETFILTER(NonActive,'%1',FALSE);
                    IF HeadOfM.FIND('-') THEN BEGIN
                     HeadOfM.CALCFIELDS("Employee No.");
                    "Manager 2 Code":=HeadOfM."Employee No.";
                    END
                    ELSE BEGIN
                      "Manager 2 Code":='';
                      END;
                    END;
                    IF "Employee No."="Manager 1 Code" THEN "Manager Is Employee":=TRUE;
                    END;*/

                    Position.SETFILTER("Employee No.", '%1', "Manager 1 Code");
                    Position.SETFILTER("Org. Structure", '%1', "Org. Structure");
                    IF Position.FIND('-') THEN BEGIN
                        "Manager 2 Code" := Position."Manager 1 Code";
                        "Manager 2  Department Code" := Position."Disc. Department Code";
                    END
                    ELSE BEGIN
                        "Manager 2 Code" := '';
                        "Manager 2  Department Code" := '';
                    END;
                    IF "Employee No." = "Manager 1 Code" THEN "Manager Is Employee" := TRUE;
                END;

            end;
        }
        field(50352; "Manager 1  Department Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ECL systematization"."Department Code" WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                                                "Employee No." = FIELD("Manager 1 Code")));
            Caption = 'Manager Department Code';

            TableRelation = "Department temporary".Code;
        }
        field(50353; "Manager 1 Position Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ECL systematization"."Position Code" WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                                              "Employee No." = FIELD("Manager 1 Code")));
            Caption = 'Manager Position Code';

            TableRelation = "Position temporery".Code;

            trigger OnValidate()
            begin
                ECL.RESET;
                ECL.SETFILTER("Org. Structure", '%1', "Org. Structure");
                ECL.SETFILTER("Position Code", '%1', "Manager Position Code");
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
            CalcFormula = Lookup("ECL systematization"."Position ID" WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                                            "Employee No." = FIELD("Manager 1 Code")));
            Caption = 'Manager Position ID';


            trigger OnValidate()
            begin
                ECL.RESET;
                ECL.SETFILTER("Org. Structure", '%1', "Org. Structure");
                ECL.SETFILTER("Position Code", '%1', "Manager Position Code");
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
            CalcFormula = Lookup("ECL systematization"."Employee Name" WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                                              "Employee No." = FIELD("Manager 1 Code")));
            Caption = 'Manager Department Code';

            TableRelation = "Department temporary".Code;
        }
        field(50356; "Manager 2  Department Code"; Code[20])
        {
            Caption = 'Manager Department Code';
            FieldClass = Normal;
            TableRelation = "Department temporary".Code;
        }
        field(50357; "Manager 2 Position Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ECL systematization"."Position Code" WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                                              "Employee No." = FIELD("Manager 2 Code")));
            Caption = 'Manager Position Code';

            TableRelation = "Position temporery".Code;

            trigger OnValidate()
            begin
                ECL.RESET;
                ECL.SETFILTER("Org. Structure", '%1', "Org. Structure");
                ECL.SETFILTER("Position Code", '%1', "Manager Position Code");
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
            CalcFormula = Lookup("ECL systematization"."Position ID" WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                                            "Employee No." = FIELD("Manager 2 Code")));
            Caption = 'Manager Position ID';
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                ECL.RESET;
                ECL.SETFILTER("Org. Structure", '%1', "Org. Structure");
                ECL.SETFILTER("Position Code", '%1', "Manager Position Code");
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
            CalcFormula = Lookup("ECL systematization"."Employee Name" WHERE("Org. Structure" = FIELD("Org. Structure"),
                                                                              "Employee No." = FIELD("Manager 2 Code")));
            Caption = 'Manager Department Code';
            FieldClass = FlowField;
            TableRelation = "Department temporary".Code;
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
                                                          "Dimension Value Type" = FILTER('Standard'));

            trigger OnValidate()
            begin
                DimensionName.RESET;
                DimensionName.SETFILTER("Dimension Code", '%1', "Dimension Value Code");
                IF DimensionName.FINDFIRST THEN
                    IF NOT DimMgt.CheckDimValue("Dimension Code", "Dimension Value Code") THEN
                        ERROR(DimMgt.GetDimErr);
            end;
        }
        field(50364; "Dimension  Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Dimension Value".Name WHERE("Dimension Code" = FIELD("Dimension Code"),
                                                               Code = FIELD("Dimension Value Code")));
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
                    IF posDis.FIND('-') THEN BEGIN
                        VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                        VALIDATE("Disc. Department Name", posDis."Disc. Department Name");
                    END
                    ELSE BEGIN
                        VALIDATE("Disc. Department Code", "Team Code");
                        VALIDATE("Disc. Department Name", "Team Description");
                    END;
                END;

                posDis.RESET;
                IF (("Team Description" = '') AND ("Group Description" <> '')) THEN BEGIN

                    posDis.SETFILTER("Department Code", '%1', "Group Code");
                    posDis.SETFILTER("Management Level", '%1', "Management Level");
                    posDis.SETFILTER("Group Description", '%1', "Group Code");
                    IF posDis.FIND('-') THEN BEGIN
                        VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                        VALIDATE("Disc. Department Name", posDis."Disc. Department Name");

                    END
                    ELSE BEGIN
                        VALIDATE("Disc. Department Code", "Group Code");
                        VALIDATE("Disc. Department Name", "Group Description");
                    END;
                END;

                posDis.RESET;
                IF (("Team Description" = '') AND ("Group Description" = '') AND ("Department Categ.  Description" <> '')) THEN BEGIN
                    posDis.SETFILTER("Department Code", '%1', "Department Category");
                    posDis.SETFILTER("Management Level", '%1', "Management Level");
                    posDis.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
                    IF posDis.FIND('-') THEN BEGIN
                        VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                        VALIDATE("Disc. Department Name", posDis."Disc. Department Name");
                    END
                    ELSE BEGIN
                        VALIDATE("Disc. Department Code", "Department Category");
                        VALIDATE("Disc. Department Code", "Department Code");
                    END;
                END;
                IF (("Team Description" = '') AND ("Group Description" = '') AND ("Department Categ.  Description" = '')) THEN BEGIN
                    posDis.RESET;
                    posDis.SETFILTER("Department Code", '%1', Sector);
                    posDis.SETFILTER("Management Level", '%1', "Management Level");
                    posDis.SETFILTER("Sector  Description", '%1', "Sector  Description");
                    IF posDis.FIND('-') THEN BEGIN
                        VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                        VALIDATE("Disc. Department Name", posDis."Disc. Department Name");
                    END
                    ELSE BEGIN
                        VALIDATE("Disc. Department Code", Sector);
                        VALIDATE("Disc. Department Code", "Department Code");
                    END;
                END;
            end;
        }
        field(50366; "Control Function"; Boolean)
        {
            Caption = 'Control Function';
        }
        field(50367; "Key Function"; Boolean)
        {
            Caption = 'Key Function';
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
            TableRelation = "Sector temporary".Code WHERE("Org Shema" = FIELD("Org. Structure"));
        }
        field(50371; "Department Category"; Code[30])
        {
            Caption = 'Department';
            TableRelation = "Department Category temporary".Code WHERE("Org Shema" = FIELD("Org. Structure"),
                                                                        Description = FIELD("Department Categ.  Description"),
                                                                        "Department Type" = FILTER('Department'));

            trigger OnValidate()
            begin
                ;
            end;
        }
        field(50372; "Group Code"; Code[30])
        {
            Caption = 'Group';
            TableRelation = "Group temporary".Code WHERE("Org Shema" = FIELD("Org. Structure"),
                                                          Description = FIELD("Group Description"));
        }
        field(50373; "Sector  Description"; Text[250])
        {
            Caption = 'Sector Description';
            Editable = true;
            TableRelation = "Sector temporary".Description;

            trigger OnValidate()
            begin
                IF (("Team Code" = '') AND ("Group Code" = '') AND ("Department Category" = '')) THEN BEGIN
                    Department.SETFILTER("Sector  Description", '%1', "Sector  Description");
                    IF Department.FIND('-') THEN BEGIN

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
                IF SectorR.FINDFIRST THEN BEGIN
                    "Sector Identity" := SectorR.Identity;
                END;
                DepartmentC.SETFILTER(Description, '%1', "Department Categ.  Description");
                IF DepartmentC.FINDFIRST THEN BEGIN
                    "Department Category Identity" := DepartmentC.Identity;

                END;



                IF (("Team Description" = '') AND ("Group Description" = '') AND ("Department Categ.  Description" = '')) THEN BEGIN
                    posDis.RESET;
                    posDis.SETFILTER("Department Code", '%1', Sector);
                    posDis.SETFILTER("Management Level", '%1', "Management Level");
                    posDis.SETFILTER("Sector  Description", '%1', "Sector  Description");
                    IF posDis.FIND('-') THEN BEGIN
                        VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                        VALIDATE("Disc. Department Name", posDis."Disc. Department Name");
                    END
                    ELSE BEGIN
                        VALIDATE("Disc. Department Code", Sector);
                        VALIDATE("Disc. Department Code", "Department Code");
                    END;
                END;
                PosMenuNew.SETFILTER(Code, '%1', Rec.Code);
                PosMenuNew.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                PosMenuNew.SETFILTER(Description, '%1', Rec.Description);
                IF PosMenuNew.FIND('-') THEN BEGIN
                    IF PosMenuNew.GET(Code, Description, '', "Org. Structure") THEN
                        PosMenuNew.RENAME(Code, Description, "Department Code", "Org. Structure");
                END;
            end;
        }
        field(50374; "Department Categ.  Description"; Text[150])
        {
            Caption = 'Department (description)';
            Editable = true;
            TableRelation = "Department Category temporary".Description;

            trigger OnValidate()
            begin
                IF (("Team Code" = '') AND ("Group Code" = '')) THEN BEGIN
                    Department.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
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
                IF SectorR.FINDFIRST THEN BEGIN
                    "Sector Identity" := SectorR.Identity;
                END;
                DepartmentC.SETFILTER(Description, '%1', "Department Categ.  Description");
                IF DepartmentC.FINDFIRST THEN BEGIN
                    "Department Category Identity" := DepartmentC.Identity;
                END;


                posDis.RESET;
                IF (("Team Description" = '') AND ("Group Description" = '') AND ("Department Categ.  Description" <> '')) THEN BEGIN
                    posDis.SETFILTER("Department Code", '%1', "Department Category");
                    posDis.SETFILTER("Management Level", '%1', "Management Level");
                    posDis.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
                    IF posDis.FIND('-') THEN BEGIN
                        VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                        VALIDATE("Disc. Department Name", posDis."Disc. Department Name");
                    END
                    ELSE BEGIN
                        VALIDATE("Disc. Department Code", "Department Category");
                        VALIDATE("Disc. Department Code", "Department Code");
                    END;
                END;
                "Disc. Department Code" := "Department Category";
                "Disc. Department Name" := posDis."Disc. Department Name";
                PosMenuNew.SETFILTER(Code, '%1', Rec.Code);
                PosMenuNew.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                PosMenuNew.SETFILTER(Description, '%1', Rec.Description);
                IF PosMenuNew.FIND('-') THEN BEGIN
                    IF PosMenuNew.GET(Code, Description, '', "Org. Structure") THEN
                        PosMenuNew.RENAME(Code, Description, "Department Code", "Org. Structure");
                END;
            end;
        }
        field(50375; "Group Description"; Text[150])
        {
            Caption = 'Group Description';
            Editable = true;
            TableRelation = "Group temporary".Description WHERE("Org Shema" = FIELD("Org. Structure"),
                                                                 Code = FIELD("Group Code"));

            trigger OnValidate()
            begin
                IF "Team Code" = '' THEN BEGIN
                    Department.SETFILTER("Group Description", '%1', "Group Description");
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
                IF SectorR.FINDFIRST THEN BEGIN
                    "Sector Identity" := SectorR.Identity;
                END;
                DepartmentC.SETFILTER(Description, '%1', "Department Categ.  Description");
                IF DepartmentC.FINDFIRST THEN BEGIN
                    "Department Category Identity" := DepartmentC.Identity;
                END;

                posDis.RESET;
                IF (("Team Description" = '') AND ("Group Description" <> '')) THEN BEGIN

                    posDis.SETFILTER("Department Code", '%1', "Group Code");
                    posDis.SETFILTER("Management Level", '%1', "Management Level");
                    posDis.SETFILTER("Group Description", '%1', "Group Code");
                    IF posDis.FIND('-') THEN BEGIN
                        VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                        VALIDATE("Disc. Department Name", posDis."Disc. Department Name");

                    END
                    ELSE BEGIN
                        VALIDATE("Disc. Department Code", "Group Code");
                        VALIDATE("Disc. Department Name", "Group Description");
                    END;
                END;
                PosMenuNew.SETFILTER(Code, '%1', Rec.Code);
                PosMenuNew.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                PosMenuNew.SETFILTER(Description, '%1', Rec.Description);
                IF PosMenuNew.FIND('-') THEN BEGIN
                    IF PosMenuNew.GET(Code, Description, '', "Org. Structure") THEN
                        PosMenuNew.RENAME(Code, Description, "Department Code", "Org. Structure");
                END;
            end;
        }
        field(50376; "Team Code"; Code[30])
        {
            Caption = 'Team';
            TableRelation = "Team temporary".Code WHERE("Org Shema" = FIELD("Org. Structure"),
                                                         Name = FIELD("Team Description"));
        }
        field(50377; "Team Description"; Text[100])
        {
            Caption = 'Team Description';
            Editable = true;
            TableRelation = "Team temporary".Name WHERE("Org Shema" = FIELD("Org. Structure"),
                                                         Code = FIELD("Team Code"));

            trigger OnValidate()
            begin
                Department.SETFILTER("Team Description", '%1', "Team Description");
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
                IF SectorR.FINDFIRST THEN BEGIN
                    "Sector Identity" := SectorR.Identity;
                END;
                DepartmentC.SETFILTER(Description, '%1', "Department Categ.  Description");
                IF DepartmentC.FINDFIRST THEN BEGIN
                    "Department Category Identity" := DepartmentC.Identity;
                END;
                IF (("Team Description" <> '')) THEN BEGIN

                    posDis.SETFILTER("Department Code", '%1', "Team Code");
                    posDis.SETFILTER("Management Level", '%1', "Management Level");
                    posDis.SETFILTER("Team Description", '%1', "Team Code");
                    IF posDis.FIND('-') THEN BEGIN
                        VALIDATE("Disc. Department Code", posDis."Disc. Department Code");
                        VALIDATE("Disc. Department Name", posDis."Disc. Department Name");
                    END
                    ELSE BEGIN
                        VALIDATE("Disc. Department Code", "Team Code");
                        VALIDATE("Disc. Department Name", "Team Description");
                    END;
                END;
                PosMenuNew.SETFILTER(Code, '%1', Rec.Code);
                PosMenuNew.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                PosMenuNew.SETFILTER(Description, '%1', Rec.Description);
                IF PosMenuNew.FIND('-') THEN BEGIN
                    IF PosMenuNew.GET(Code, Description, '', "Org. Structure") THEN
                        PosMenuNew.RENAME(Code, Description, "Department Code", "Org. Structure");
                END;
            end;
        }
        field(50378; "Disc. Department Name"; Text[250])
        {
            Caption = 'Disc. Department Name';
            TableRelation = IF ("Team Code" = FILTER(<> ''),
                                "Team Description" = FILTER(<> ''),
                                "Management Level" = FILTER(E | ' ')) "Department temporary"."Team Description" WHERE("ORG Shema" = FIELD("Org. Structure"))
            ELSE
            IF ("Group Code" = FILTER(<> ''),
                                         "Group Description" = FILTER(<> ''),
                                         "Team Code" = FILTER(''),
                                         "Team Description" = FILTER(''),
                                         "Management Level" = FILTER(E | ' ')) "Department temporary"."Group Description" WHERE("ORG Shema" = FIELD("Org. Structure"))
            ELSE
            IF ("Group Code" = FILTER(''),
                                                  "Group Description" = FILTER(''),
                                                  "Department Categ.  Description" = FILTER(<> ''),
                                                  "Department Category" = FILTER(<> ''),
                                                  "Management Level" = FILTER(E | ' ')) "Department temporary"."Department Categ.  Description" WHERE("ORG Shema" = FIELD("Org. Structure"))
            ELSE
            IF (Sector = FILTER(<> ''),
                                                           "Sector  Description" = FILTER(<> ''),
                                                           "Department Category" = FILTER(''),
                                                           "Department Categ.  Description" = FILTER('')) "Department temporary"."Sector  Description" WHERE("ORG Shema" = FIELD("Org. Structure"))
            ELSE
            IF ("Team Code" = FILTER(<> ''),
                                                                    "Team Description" = FILTER(<> ''),
                                                                    "Management Level" = FILTER(<> E),
                                                                    "Management Level" = FILTER(<> ' ')) "Department temporary"."Group Description" WHERE("ORG Shema" = FIELD("Org. Structure"))
            ELSE
            IF ("Group Code" = FILTER(<> ''),
                                                                             "Group Description" = FILTER(<> ''),
                                                                             "Team Code" = FILTER(''),
                                                                             "Team Description" = FILTER(''),
                                                                             "Management Level" = FILTER(<> E),
                                                                             "Management Level" = FILTER(<> ' ')) "Department temporary"."Department Categ.  Description" WHERE("ORG Shema" = FIELD("Org. Structure"))
            ELSE
            IF ("Group Code" = FILTER(''),
                                                                                      "Group Description" = FILTER(''),
                                                                                      "Department Categ.  Description" = FILTER(<> ''),
                                                                                      "Department Category" = FILTER(<> ''),
                                                                                      "Management Level" = FILTER(<> E),
                                                                                      "Management Level" = FILTER(<> ' ')) "Department temporary"."Sector  Description" WHERE("ORG Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin
                /*DepartmentNew.RESET;
                  IF "Disc. Department Code"='D.2.5.' THEN BEGIN
                  DepartmentNew.SETFILTER("Department Categ.  Description",'%1',"Disc. Department Name");
                    END;
                    IF "Disc. Department Code"='D.2.5.1.'THEN BEGIN
                      DepartmentNew.SETFILTER("Group Description",'%1',"Disc. Department Name");
                      END;
                       IF "Disc. Department Code"='D.2.5.1.1.'THEN BEGIN
                      DepartmentNew.SETFILTER("Team Description",'%1',"Disc. Department Name");
                      END;
                      IF "Disc. Department Code"='E.1.X.' THEN BEGIN
                        DepartmentNew.SETFILTER("Department Categ.  Description",'%1',"Disc. Department Name");
                        END;
                         IF  ("Disc. Department Code"<>'D.2.5.') AND ("Disc. Department Code"<>'D.2.5.1.1.') AND ("Disc. Department Code"<>'D.2.5.1.') AND ("Disc. Department Code"<>'E.1.X.' ) THEN BEGIN
                          DepartmentNew.SETFILTER(Description,'%1',"Disc. Department Name");
                           END;
                HeadOf.SETFILTER("Department Code",'%1',"Disc. Department Code");
                
                IF ("Disc. Department Code"='D.2.5.') OR ("Disc. Department Code"='E.1.X.') THEN BEGIN
                HeadOf.SETFILTER("Department Categ.  Description",'%1',"Disc. Department Name");
                HeadOf.SETFILTER("Team Description",'%1','');
                HeadOf.SETFILTER("Group Description",'%1','');
                END;
                
                IF "Disc. Department Code"='D.2.5.1.' THEN BEGIN
                HeadOf.SETFILTER("Department Categ.  Description",'%1',"Department Categ.  Description");
                HeadOf.SETFILTER("Group Description",'%1',"Disc. Department Name");
                HeadOf.SETFILTER("Team Description",'%1','');
                END;
                
                IF "Disc. Department Code"='D.2.5.1.1.' THEN BEGIN
                HeadOf.SETFILTER("Department Categ.  Description",'%1',"Department Categ.  Description");
                HeadOf.SETFILTER("Group Description",'%1',"Group Description");
                HeadOf.SETFILTER("Team Description",'%1',"Disc. Department Name");
                END;
                {
                HeadOf.SETFILTER("Team Description",'%1',"Team Description");
                HeadOf.SETFILTER("Group Description",'%1',"Group Description");
                HeadOf.SETFILTER("Department Categ.  Description",'%1',"Department Categ.  Description");
                HeadOf.SETFILTER("Sector  Description",'%1',"Sector  Description");}
                HeadOf.SETFILTER("ORG Shema",'%1',"Org. Structure");
                HeadOf.SETFILTER(NonActive,'%1',FALSE);
                IF HeadOf.FIND('-') THEN BEGIN
                 HeadOf.CALCFIELDS("Employee No.");
                "Manager 1 Code":=HeadOf."Employee No.";
                END
                ELSE BEGIN
                  "Manager 1 Code":='';
                  END;
                
                {DepartmentM.SETFILTER(Code,'%1',"Disc. Department Code");
                DepartmentM.SETFILTER("ORG Shema",'%1',"Org. Structure");
                IF DepartmentM.FIND('-') THEN BEGIN
                "Manager 2  Department Code":=DepartmentM."Managing Org 2";
                
                HeadOfM.SETFILTER("Department Code",'%1',"Manager 2  Department Code");
                HeadOfM.SETFILTER("ORG Shema",'%1',"Org. Structure");
                HeadOfM.SETFILTER(NonActive,'%1',FALSE);
                IF HeadOfM.FIND('-') THEN BEGIN
                 HeadOfM.CALCFIELDS("Employee No.");
                "Manager 2 Code":=HeadOfM."Employee No.";
                END
                ELSE BEGIN
                  "Manager 2 Code":='';
                  END;
                END;
                IF "Employee No."="Manager 1 Code" THEN "Manager Is Employee":=TRUE;}
                
                Position.SETFILTER("Employee No.",'%1',"Manager 1 Code");
                Position.SETFILTER("Org. Structure",'%1',"Org. Structure");
                IF Position.FIND('-')
                THEN
                "Manager 2 Code":=Position."Manager 1 Code"
                ELSE
                  "Manager 2 Code":='';
                
                IF "Employee No."="Manager 1 Code" THEN "Manager Is Employee":=TRUE;
                
                
                IF "Disc. Department Name"='' THEN BEGIN
                "Disc. Department Code":='';
                END;
                */
                IF (Rec."Management Level".AsInteger() <> 6) OR ("Management Level".AsInteger() <> 0) THEN BEGIN
                    DepartmentNew.RESET;
                    DepartmentNew.SETFILTER(Description, '%1', "Disc. Department Name");
                    DepartmentNew.SETFILTER(Description, '%1', "Disc. Department Name");
                    IF DepartmentNew.FINDFIRST THEN BEGIN
                        HeadOf.SETFILTER(Sector, '%1', DepartmentNew.Sector);
                        HeadOf.SETFILTER("Sector  Description", '%1', DepartmentNew."Sector  Description");
                        HeadOf.SETFILTER("Department Category", '%1', DepartmentNew."Department Category");
                        HeadOf.SETFILTER("Department Categ.  Description", '%1', DepartmentNew."Department Categ.  Description");
                        HeadOf.SETFILTER("Group Code", '%1', DepartmentNew."Group Code");
                        HeadOf.SETFILTER("Group Description", '%1', DepartmentNew."Group Description");
                        HeadOf.SETFILTER("Team Code", '%1', DepartmentNew."Team Code");
                        HeadOf.SETFILTER("Team Description", '%1', DepartmentNew."Team Description");
                        IF HeadOf.FIND('-') THEN BEGIN
                            HeadOf.CALCFIELDS("Employee No.");
                            "Manager 1 Code" := HeadOf."Employee No.";
                        END
                        ELSE BEGIN
                            "Manager 1 Code" := '';
                        END;
                        "Disc. Department Name" := '';
                        VALIDATE("Disc. Department Code", DepartmentNew.Code);
                    END;
                END
                ELSE BEGIN

                    IF "Manager 1 Code" = '' THEN BEGIN

                        DepartmentNew.RESET;
                        DepartmentNew.SETFILTER("Department Categ.  Description", '%1', "Disc. Department Name");
                        DepartmentNew.SETFILTER("Group Code", '%1', '');
                        IF DepartmentNew.FINDFIRST THEN BEGIN
                            HeadOf.SETFILTER(Sector, '%1', DepartmentNew.Sector);
                            HeadOf.SETFILTER("Sector  Description", '%1', DepartmentNew."Sector  Description");
                            HeadOf.SETFILTER("Department Category", '%1', DepartmentNew."Department Category");
                            HeadOf.SETFILTER("Department Categ.  Description", '%1', DepartmentNew."Department Categ.  Description");
                            HeadOf.SETFILTER("Group Code", '%1', DepartmentNew."Group Code");
                            HeadOf.SETFILTER("Group Description", '%1', DepartmentNew."Group Description");
                            HeadOf.SETFILTER("Team Code", '%1', DepartmentNew."Team Code");
                            HeadOf.SETFILTER("Team Description", '%1', DepartmentNew."Team Description");
                            IF HeadOf.FIND('-') THEN BEGIN
                                HeadOf.CALCFIELDS("Employee No.");
                                "Manager 1 Code" := HeadOf."Employee No.";
                            END
                            ELSE BEGIN
                                "Manager 1 Code" := '';
                            END;
                            "Department Code" := DepartmentNew.Code;

                        END;
                    END;
                    IF "Manager 1 Code" = '' THEN BEGIN

                        DepartmentNew.RESET;
                        DepartmentNew.SETFILTER("Group Description", '%1', "Disc. Department Name");
                        DepartmentNew.SETFILTER("Team Code", '%1', '');
                        IF DepartmentNew.FINDFIRST THEN BEGIN
                            HeadOf.SETFILTER(Sector, '%1', DepartmentNew.Sector);
                            HeadOf.SETFILTER("Sector  Description", '%1', DepartmentNew."Sector  Description");
                            HeadOf.SETFILTER("Department Category", '%1', DepartmentNew."Department Category");
                            HeadOf.SETFILTER("Department Categ.  Description", '%1', DepartmentNew."Department Categ.  Description");
                            HeadOf.SETFILTER("Group Code", '%1', DepartmentNew."Group Code");
                            HeadOf.SETFILTER("Group Description", '%1', DepartmentNew."Group Description");
                            HeadOf.SETFILTER("Team Code", '%1', DepartmentNew."Team Code");
                            HeadOf.SETFILTER("Team Description", '%1', DepartmentNew."Team Description");
                            IF HeadOf.FIND('-') THEN BEGIN
                                HeadOf.CALCFIELDS("Employee No.");
                                "Manager 1 Code" := HeadOf."Employee No.";
                            END
                            ELSE BEGIN
                                "Manager 1 Code" := '';
                            END;
                            "Department Code" := DepartmentNew.Code;
                        END;
                    END;
                    IF "Manager 1 Code" = '' THEN BEGIN

                        DepartmentNew.RESET;
                        DepartmentNew.SETFILTER("Team Description", '%1', "Disc. Department Name");
                        IF DepartmentNew.FINDFIRST THEN BEGIN
                            HeadOf.SETFILTER(Sector, '%1', DepartmentNew.Sector);
                            HeadOf.SETFILTER("Sector  Description", '%1', DepartmentNew."Sector  Description");
                            HeadOf.SETFILTER("Department Category", '%1', DepartmentNew."Department Category");
                            HeadOf.SETFILTER("Department Categ.  Description", '%1', DepartmentNew."Department Categ.  Description");
                            HeadOf.SETFILTER("Group Code", '%1', DepartmentNew."Group Code");
                            HeadOf.SETFILTER("Group Description", '%1', DepartmentNew."Group Description");
                            HeadOf.SETFILTER("Team Code", '%1', DepartmentNew."Team Code");
                            HeadOf.SETFILTER("Team Description", '%1', DepartmentNew."Team Description");
                            IF HeadOf.FIND('-') THEN BEGIN
                                HeadOf.CALCFIELDS("Employee No.");
                                "Manager 1 Code" := HeadOf."Employee No.";
                            END
                            ELSE BEGIN
                                "Manager 1 Code" := '';
                            END;

                        END;
                    END;

                    //ako je tim nadji grupu
                    FindLevelHigh.RESET;
                    IF DepartmentNew."Department Type".AsInteger() = 9 THEN BEGIN
                        FindLevelHigh.SETFILTER("Department Type", '%1', 2);
                        FindLevelHigh.SETFILTER("Group Code", '%1', DepartmentNew."Group Code");
                        FindLevelHigh.SETFILTER("Group Description", '%1', DepartmentNew."Group Description");
                        FindLevelHigh.SETFILTER("Department Category", '%1', DepartmentNew."Department Category");
                        FindLevelHigh.SETFILTER("Department Categ.  Description", '%1', DepartmentNew."Department Categ.  Description");
                        FindLevelHigh.SETFILTER(Sector, '%1', DepartmentNew.Sector);
                        FindLevelHigh.SETFILTER("Sector  Description", '%1', DepartmentNew."Sector  Description");
                        IF FindLevelHigh.FINDFIRST THEN BEGIN
                            HeadOf.RESET;
                            HeadOf.SETFILTER(Sector, '%1', FindLevelHigh.Sector);
                            HeadOf.SETFILTER("Sector  Description", '%1', FindLevelHigh."Sector  Description");
                            HeadOf.SETFILTER("Department Category", '%1', FindLevelHigh."Department Category");
                            HeadOf.SETFILTER("Department Categ.  Description", '%1', FindLevelHigh."Department Categ.  Description");
                            HeadOf.SETFILTER("Group Code", '%1', FindLevelHigh."Group Code");
                            HeadOf.SETFILTER("Group Description", '%1', FindLevelHigh."Group Description");
                            HeadOf.SETFILTER("Team Code", '%1', FindLevelHigh."Team Code");
                            HeadOf.SETFILTER("Team Description", '%1', FindLevelHigh."Team Description");
                            IF HeadOf.FINDFIRST THEN BEGIN
                                HeadOf.CALCFIELDS("Employee No.");
                                "Manager 2 Code" := HeadOf."Employee No.";
                                "Manager 2  Department Code" := HeadOf."Department Code";
                            END
                            ELSE BEGIN
                                "Manager 2 Code" := '';
                                "Manager 2  Department Code" := '';
                            END;
                            "Department Code" := DepartmentNew.Code;
                        END;
                    END;
                    //ako je grupa nadji odjel
                    FindLevelHigh.RESET;
                    IF DepartmentNew."Department Type".AsInteger() = 2 THEN BEGIN
                        FindLevelHigh.SETFILTER("Department Type", '%1', 4);
                        FindLevelHigh.SETFILTER("Department Category", '%1', DepartmentNew."Department Category");
                        FindLevelHigh.SETFILTER("Department Categ.  Description", '%1', DepartmentNew."Department Categ.  Description");
                        FindLevelHigh.SETFILTER(Sector, '%1', DepartmentNew.Sector);
                        FindLevelHigh.SETFILTER("Sector  Description", '%1', DepartmentNew."Sector  Description");
                        IF FindLevelHigh.FINDFIRST THEN BEGIN
                            HeadOf.RESET;
                            HeadOf.SETFILTER(Sector, '%1', FindLevelHigh.Sector);
                            HeadOf.SETFILTER("Sector  Description", '%1', FindLevelHigh."Sector  Description");
                            HeadOf.SETFILTER("Department Category", '%1', FindLevelHigh."Department Category");
                            HeadOf.SETFILTER("Department Categ.  Description", '%1', FindLevelHigh."Department Categ.  Description");
                            HeadOf.SETFILTER("Group Code", '%1', FindLevelHigh."Group Code");
                            HeadOf.SETFILTER("Group Description", '%1', FindLevelHigh."Group Description");
                            HeadOf.SETFILTER("Team Code", '%1', FindLevelHigh."Team Code");
                            HeadOf.SETFILTER("Team Description", '%1', FindLevelHigh."Team Description");
                            IF HeadOf.FINDFIRST THEN BEGIN
                                HeadOf.CALCFIELDS("Employee No.");
                                "Manager 2 Code" := HeadOf."Employee No.";
                                "Manager 2  Department Code" := HeadOf."Department Code";
                            END
                            ELSE BEGIN
                                "Manager 2 Code" := '';
                                "Manager 2  Department Code" := '';
                            END;
                            "Department Code" := DepartmentNew.Code;
                        END;
                    END;
                    //ako je odjel nadji sektor
                    FindLevelHigh.RESET;
                    IF DepartmentNew."Department Type".AsInteger() = 4 THEN BEGIN
                        FindLevelHigh.SETFILTER("Department Type", '%1', 8);
                        FindLevelHigh.SETFILTER(Sector, '%1', DepartmentNew.Sector);
                        FindLevelHigh.SETFILTER("Sector  Description", '%1', DepartmentNew."Sector  Description");
                        IF FindLevelHigh.FINDFIRST THEN BEGIN
                            HeadOf.RESET;
                            HeadOf.SETFILTER(Sector, '%1', FindLevelHigh.Sector);
                            HeadOf.SETFILTER("Sector  Description", '%1', FindLevelHigh."Sector  Description");
                            HeadOf.SETFILTER("Department Category", '%1', FindLevelHigh."Department Category");
                            HeadOf.SETFILTER("Department Categ.  Description", '%1', FindLevelHigh."Department Categ.  Description");
                            HeadOf.SETFILTER("Group Code", '%1', FindLevelHigh."Group Code");
                            HeadOf.SETFILTER("Group Description", '%1', FindLevelHigh."Group Description");
                            HeadOf.SETFILTER("Team Code", '%1', FindLevelHigh."Team Code");
                            HeadOf.SETFILTER("Team Description", '%1', FindLevelHigh."Team Description");
                            IF HeadOf.FINDFIRST THEN BEGIN
                                HeadOf.CALCFIELDS("Employee No.");
                                "Manager 2 Code" := HeadOf."Employee No.";
                                "Manager 2  Department Code" := HeadOf."Department Code";
                            END
                            ELSE BEGIN
                                "Manager 2 Code" := '';
                                "Manager 2  Department Code" := '';
                            END;
                            "Department Code" := DepartmentNew.Code;
                        END;
                    END;
                END;


                IF "Manager 1 Code" <> '' THEN BEGIN
                    emp.RESET;
                    emp.SETFILTER("No.", '%1', "Manager 1 Code");
                    IF emp.FINDFIRST THEN
                        "Manager Name 1" := emp."Last Name" + ' ' + emp."First Name";
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
                /*IF ("Changing Position"=TRUE) AND ("Will Be Changed Later"=FALSE) THEN BEGIN
                  Pos.SETFILTER("Org. Structure",'%1',Rec."Org. Structure");
                  Pos.SETFILTER(Code,'%1',Rec.Code);
                  Pos.SETFILTER("Changing Position",'%1',FALSE);
                 // Pos.SETFILTER(Description,'%1',Rec.Description);//DODALA
                  IF Pos.FINDSET THEN REPEAT
                    Pos."Changing Position":=TRUE;
                    Pos.MODIFY(TRUE);
                
                     Pos.GET(Pos.Code,Pos."Position ID",Pos."Org. Structure",Pos.Description);
                    UNTIL Pos.NEXT=0;
                    END;*/

            end;
        }
        field(50383; "Old Code"; Code[20])
        {
        }
        field(50384; "Changing Group"; Boolean)
        {

            FieldClass = FlowField;
            CalcFormula = Lookup(Group."Changing Department" WHERE(Code = FIELD("Department Code"),
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
            CalcFormula = Lookup(TeamT."Changing Department" WHERE(Code = FIELD("Department Code"),
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
            CalcFormula = Lookup("Department Category"."Changing Department" WHERE(Code = FIELD("Department Code"),
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
            CalcFormula = Lookup(Sector."Changing Department" WHERE(Code = FIELD("Department Code"),
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
        field(50391; "Role Name"; Text[100])
        {
            Caption = 'Role Description';
        }
        field(50392; "BJF/GJF"; Option)
        {
            Caption = 'BJF/GJF';
            OptionCaption = ' ,BJF,GJF';
            OptionMembers = " ",BJF,GJF;
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
        field(50399; "Manager Name 1"; Text[50])
        {
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
            "Role Name" := Pos."Role Name";
            "Disc. Department Code" := Pos."Disc. Department Code";
            "Disc. Department Name" := Pos."Disc. Department Name";
        END
        ELSE BEGIN
            "Position ID" := FORMAT(1);

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

        lvarActiveConnection: Variant;
        OrgStr: Record "ORG Shema";
        Pos: Record "Position temporery";
        PosIDInt: Integer;
        PosIDText: Text;
        ECL: Record "ECL systematization";
        Department: Record "Department temporary";
        // SD: Record "Segmentation Data";
        //  WDV: Record "Work Duties Violation";
        // WDVM: Record "Work Duties Violation";
        //WDVR: Record "Work Duties Violation";
        HeadOf: Record "Head Of's temporary";
        DepartmentM: Record "Department temporary";
        HeadOfM: Record "Head Of's temporary";
        DimMgt: Codeunit "DimensionManagement";
        VocationRec: Record "Vocation";
        Position: Record "Position temporery";
        Pos2: Record "Position temporery";
        PosC: Record "Position temporery";
        PosMenu: Record "Position Menu temporary";
        Text000: Label 'You must not delete an active position!';
        posDis: Record "Position temporery";
        PosI: Record "Position temporery";
        SectorR: Record "Sector temporary";
        DepartmentC: Record "Department Category temporary";
        emp: Record "Employee";
        PositionMenu1: Record "Position Menu temporary";
        PosMenuNew: Record "Position Menu temporary";
        PosChangeID: Record "Position temporery";
        ECL1: Record "ECL systematization";
        PositionDisc: Record "Position temporery";
        DepartmentNew: Record "Department temporary";
        ECLSys: Record "ECL systematization";
        FindLevelHigh: Record "Department temporary";
        DimensionName: Record "Dimension Value";
}

