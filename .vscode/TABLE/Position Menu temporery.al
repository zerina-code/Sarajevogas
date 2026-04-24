table 50131 "Position Menu temporary"
{
    Caption = 'Position';
    DrillDownPageID = "Position menu temp";
    LookupPageID = "Position menu temp";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            Editable = true;
            NotBlank = true;

            trigger OnValidate()
            begin
                if (Rec."Management Level".AsInteger() <> 0) and (Rec."Management Level".AsInteger() <> 6) then begin
                    HeadOfOrg.Reset();
                    HeadOfOrg.SetFilter("Position Code", '%1', xRec.Code);
                    HeadOfOrg.SetFilter("ORG Shema", '%1', Rec."Org. Structure");
                    HeadOfOrg.SetFilter("Department Code", Rec."Department Code");
                    if HeadOfOrg.FindFirst then begin
                        if HeadOf.Get(HeadOfOrg."Department Code", HeadOfOrg."ORG Shema",
                         HeadOfOrg."Department Categ.  Description", HeadOfOrg."Group Description", HeadOfOrg."Team Description", HeadOfOrg."Management Level", HeadOfOrg."Position Code")
                           then
                            HeadOf.Rename(HeadOfOrg."Department Code", HeadOfOrg."ORG Shema",
                            HeadOfOrg."Department Categ.  Description", HeadOfOrg."Group Description", HeadOfOrg."Team Description", HeadOfOrg."Management Level", Rec.Code)

                    end;
                end;
            end;



        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            Editable = true;
        }
        field(3; "Department Code"; Code[30])
        {
            Caption = 'Department Code';
            TableRelation = "Department temporary".Code;
            trigger OnValidate()
            var
                myInt: Integer;
                HeadOfOrg: Record "Head Of's temporary";
                HeadOf: Record "Head Of's temporary";
                dep: Record "Department temporary";


            begin

                if (Rec."Management Level".AsInteger() <> 0) and (Rec."Management Level".AsInteger() <> 6) then begin
                    HeadOfOrg.Reset();
                    HeadOfOrg.SetFilter("Department Code", '%1', xRec."Department Code");
                    HeadOfOrg.SetFilter("Position Code", '%1', Rec.Code);
                    HeadOfOrg.SetFilter("ORG Shema", '%1', Rec."Org. Structure");

                    if HeadOfOrg.FindFirst then begin
                        HeadOfOrg.Delete();

                    end;
                    HeadOf.Init();
                    HeadOf."ORG Shema" := Rec."Org. Structure";
                    HeadOf."Management Level" := Rec."Management Level";
                    dep.Reset();
                    dep.SetFilter(Code, '%1', rec."Department Code");
                    dep.SetFilter("ORG Shema", '%1', rec."Org. Structure");
                    if dep.FindFirst() then begin
                        HeadOf.Validate("Group Description", dep."Group Description");
                        HeadOf.Validate("Department Categ.  Description", dep."Department Categ.  Description");
                        HeadOf.Validate("Sector  Description", dep."Sector  Description");
                        HeadOf."Position Code" := Rec.Code;
                        HeadOf.Insert();
                    end;




                end;
            end;
        }
        field(4; "Org. Structure"; Code[20])
        {
            Caption = 'Org. Structure';
        }
        field(50004; "No. of Working Places"; Integer)
        {
            Caption = 'No. of Working Places';
        }
        field(50005; "Sector Identity"; Integer)
        {
            BlankZero = true;
            NotBlank = false;
        }
        field(50365; "Management Level"; enum "Management Level")
        {
            Caption = 'Management Level';

            trigger OnValidate()
            var
                HeadOfOrg: Record "Head Of's temporary";
                HeadOf: Record "Head Of's temporary";
                dep: Record "Department temporary";

            begin

                if (xRec."Management Level".AsInteger() <> 0) and (xRec."Management Level".AsInteger() <> 6) then begin
                    HeadOfOrg.Reset();
                    HeadOfOrg.SetFilter("Department Code", '%1', Rec."Department Code");
                    HeadOfOrg.SetFilter("Position Code", '%1', Rec.Code);
                    HeadOfOrg.SetFilter("ORG Shema", '%1', Rec."Org. Structure");

                    if HeadOfOrg.FindFirst then begin
                        HeadOfOrg.Delete();

                    end;
                end;

                if (Rec."Management Level".AsInteger() <> 0) and (Rec."Management Level".AsInteger() <> 6)
                then begin
                    HeadOf.Init();
                    HeadOf."ORG Shema" := Rec."Org. Structure";
                    HeadOf."Management Level" := Rec."Management Level";
                    dep.Reset();
                    dep.SetFilter(Code, '%1', rec."Department Code");
                    dep.SetFilter("ORG Shema", '%1', rec."Org. Structure");
                    if dep.FindFirst() then begin
                        HeadOf.Validate("Group Description", dep."Group Description");
                        HeadOf.Validate("Department Categ.  Description", dep."Department Categ.  Description");
                        HeadOf.Validate("Sector  Description", dep."Sector  Description");
                        HeadOf.Validate("Position Code", Rec.Code);
                        HeadOf.Insert();
                    end;

                end;




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
        field(50390; Role; Code[20])
        {
            Caption = 'Role code';
            Editable = false;
        }
        /*   field(50391; "Role Name"; Text[100])
           {
               Caption = 'Role Description';
               TableRelation = Role.Description WHERE(Status = FILTER(A));

               trigger OnValidate()
               begin

                   RoleT.RESET;
                   RoleT.SETFILTER(Description, '%1', "Role Name");
                   IF RoleT.FINDFIRST THEN BEGIN
                       Role := RoleT.Code;
                   END
                   ELSE BEGIN
                       Role := '';
                   END;
               end;
           }*/
        field(50392; "BJF/GJF"; Option)
        {
            Caption = 'BJF/GJF';
            OptionCaption = ' ,BJF,GJF';
            OptionMembers = " ",BJF,GJF;
        }
        field(50394; "Work Group"; Text[20])
        {
        }
        field(50395; "Minimal Education Level"; Enum School)
        {
            Caption = 'Education level';

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
        field(50396; "Position Menu Identity"; Integer)
        {
            AutoIncrement = true;
        }
        field(50397; "Number of benefits"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Position Benefits temporery" WHERE("Position Code" = FIELD(Code),
                                                                     "Position Name" = FIELD(Description)));
            Caption = 'Number of benefits';

        }
        field(500398; "Number of dimension value"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Dimension temp for position" WHERE("Position Code" = FIELD(Code),
                                                                     "Position Description" = FIELD(Description)));
            Caption = 'Number of dimension value';

        }
        field(500399; Grade; Integer)
        {
            Caption = 'Grade';
        }
        field(500400; "Fields for change"; Text[30])
        {
            Caption = 'Fields for change';
        }
        field(500401; IsTrue; Boolean)
        {
        }
        field(500402; "Official Translation"; Text[250])
        {
            Caption = 'Official Translation';
        }
        field(500403; "Department Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Department temporary".Description WHERE(Code = FIELD("Department Code"),
                                                                           "ORG Shema" = FIELD("Org. Structure")));
            Caption = 'Department Name';

        }
        field(500405; "School of Graduation"; Text[250])
        {
            Caption = 'School of Graduation';
            TableRelation = "Institution/Company".Description WHERE("Type" = FILTER("Education"));

            trigger OnValidate()
            begin

            end;
        }
        field(500406; "School"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Position Minimal Educ Temp" where("Position Code" = field(Code), "Position Name" = field(Description), "Org Shema" = field("Org. Structure")));
            Caption = 'School';


        }
        field(500407; "Position Coefficient for Wage"; Decimal)
        {
            Caption = 'Position Coefficient for Wage';
        }
        field(500408; "Position complexity"; Decimal)

        {
            Caption = 'Position complexity';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Position Coefficient for Wage" := UpdateCoeff(rec."Position complexity", rec."Position Responsibility", rec."Workplace conditions");

            end;
        }

        field(500409; "Position Responsibility"; Decimal)

        {
            Caption = 'Position Responsibility';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Position Coefficient for Wage" := UpdateCoeff(rec."Position complexity", rec."Position Responsibility", rec."Workplace conditions");

            end;
        }
        field(50410; "Workplace conditions"; Decimal)
        {
            Caption = 'Workplace conditions';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Position Coefficient for Wage" := UpdateCoeff(rec."Position complexity", rec."Position Responsibility", rec."Workplace conditions");

            end;
        }
        field(50411; "Position Coefficient Director"; Decimal)
        {
            Caption = 'Position Coefficient for Wage';
            DecimalPlaces = 1 : 3;
        }
        field(50412; "Increment"; Decimal)
        {
            Caption = 'Increment';
        }
    }

    keys
    {
        key(Key1; "Code", Description, "Department Code", "Org. Structure")
        {
        }
        key(Key2; Description)
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
        ECLSystematization.RESET;
        ECLSystematization.SETFILTER("Position Description", '%1', Rec.Description);
        ECLSystematization.SETFILTER("Position Code", '%1', Rec.Code);
        IF ECLSystematization.FINDSET THEN
            REPEAT


                ECLSystematization.VALIDATE("Position Description", '');
            UNTIL ECLSystematization.NEXT = 0;
        HeadOf.RESET;
        HeadOf.SETFILTER("Position Code", '%1', Rec.Code);
        HeadOf.SETFILTER("Management Level", '%1', Rec."Management Level");
        IF HeadOf.FINDFIRST THEN
            HeadOf.DELETE;
    end;

    var
        Position: Record "Position";
        HeadOfOrg: Record "Head Of's temporary";
        //   RoleT: Record Role;
        ClientFileName: Text;
        ServerFileName: Text;
        FileManagment: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        OsPreparation: Record "ORG Shema";
        String: Code[50];
        I: Integer;
        brojac: Integer;
        SectorFind: Record "Sector temporary";
        PositionMenu: Record "Position Menu temporary";
        SectorLength: Integer;
        ECLSystematization: Record "ECL systematization";
        HeadOf: Record "Head Of's temporary";

    procedure UpdateCoeff(var Comp: Decimal; var Resp: decimal; var Conditi: Decimal): Decimal
    begin

        exit(Comp + Comp * ((Resp + Conditi) / 100));

    end;
}

