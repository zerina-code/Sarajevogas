table 50132 "Position Menu"
{
    Caption = 'Position';
    DrillDownPageID = "Update Position";
    LookupPageID = "Update Position";


    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            Editable = true;
            NotBlank = true;

            trigger OnValidate()
            var
                HeadOfOrg: Record "Head Of's";
                HeadOf: Record "Head Of's";

            begin

                /*Position.INIT;
                Position.Code:=Code;
                Position.Description:=Description;
                Position."Org. Structure":="Org. Structure";
                Position.INSERT;*/
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

                        /*   ECLC.Reset();
                            ECLC.SetFilter("Position Code", '%1', xRec.Code);
                            ECLC.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                            ECLC.SetFilter("Department Code", Rec."Department Code");
                            if ECLC.FindSet() then
                                repeat
                                    ECLC."Position Code" := Rec.Code;
                                    ECLC.Modify();
                                until ECLC.Next() = 0;

*/
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
            TableRelation = Department.Code WHERE("ORG Shema" = FIELD("Org. Structure"));
            trigger OnValidate()
            var
                myInt: Integer;
                HeadOfOrg: Record "Head Of's";
                HeadOf: Record "Head Of's";
                dep: Record Department;


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
            TableRelation = "ORG Shema";
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
                HeadOfOrg: Record "Head Of's";
                HeadOf: Record "Head Of's";
                dep: Record Department;

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
        field(50370; Sector; Code[30])
        {
            Caption = 'Sector';
            TableRelation = Sector.Code WHERE("Org Shema" = FIELD("Org. Structure"));
        }
        field(50371; "Department Category"; Code[30])
        {
            Caption = 'Department';
            TableRelation = "Department Category".Code WHERE("Org Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin
                ;

            end;
        }
        field(50372; "Group Code"; Code[30])
        {
            Caption = 'Group';
            TableRelation = Group.Code WHERE("Org Shema" = FIELD("Org. Structure"));
        }
        field(50373; "Sector  Description"; Text[250])
        {
            Caption = 'Sector Description';
            Editable = true;
            TableRelation = Sector.Description;

            trigger OnValidate()
            begin
                /* IF (("Team Code"='') AND ("Group Code"='') AND ("Department Category"='') ) THEN BEGIN
                   Department.RESET;
                 Department.SETFILTER ("Sector  Description",'%1',Rec."Sector  Description");
                 Department.SETFILTER("ORG Shema",'%1',Rec."Org. Structure");
                 Department.SETFILTER("Department Type",'%1',8);
                
                     IF Department.FINDFIRST THEN BEGIN
                
                       "Sector  Description":=Department."Sector  Description";
                        IF "Sector  Description"<>'' THEN BEGIN
                
                          VALIDATE("Department Code",Department.Sector);
                
                          VALIDATE(Sector,Department.Sector);
                
                          END;
                  END;
                  END;
                  IF (("Team Code"='') AND ("Group Code"='') AND ("Department Category"='') AND ("Sector  Description"='')) THEN BEGIN
                    Sector:='';
                "Department Category":='';
                "Group Code":='';
                "Team Code":='';
                "Sector  Description":='';
                "Department Categ.  Description":='';
                "Group Description":='';
                "Team Description":='';
                
                  END;
                   SectorR.SETFILTER(Description,'%1',"Sector  Description");
                  IF SectorR.FINDFIRST THEN BEGIN
                    "Sector Identity":=SectorR.Identity;
                    END;
                 DepartmentC.SETFILTER(Description,'%1',"Department Categ.  Description");
                  IF DepartmentC.FINDFIRST THEN BEGIN
                    "Department Category Identity":=DepartmentC.Identity;
                
                    END;
                
                
                
                IF (("Team Description"='') AND ("Group Description"='') AND  ("Department Categ.  Description"='')) THEN BEGIN
                        posDis.RESET;
                       posDis.SETFILTER("Department Code",'%1',Sector);
                       posDis.SETFILTER("Management Level",'%1',"Management Level");
                        posDis.SETFILTER("Sector  Description",'%1',"Sector  Description");
                       IF posDis.FIND('-') THEN BEGIN
                     VALIDATE("Disc. Department Code",posDis."Disc. Department Code");
                     VALIDATE("Disc. Department Name",posDis."Disc. Department Name");
                    END
                    ELSE BEGIN
                     VALIDATE("Disc. Department Code",Sector);
                    VALIDATE("Disc. Department Code","Department Code");
                    END;
                END;
                PosMenuNew.SETFILTER(Code,'%1',Rec.Code);
                PosMenuNew.SETFILTER("Org. Structure",'%1',Rec."Org. Structure");
                PosMenuNew.SETFILTER(Description,'%1',Rec.Description);
                IF PosMenuNew.FIND('-') THEN BEGIN
                  IF PosMenuNew.GET(Code,Description,'',"Org. Structure") THEN
                  PosMenuNew.RENAME(Code,Description,"Department Code","Org. Structure") ;
                END;
                */

            end;
        }
        field(50374; "Department Categ.  Description"; Text[150])
        {
            Caption = 'Department (description)';
            Editable = true;
            TableRelation = "Department Category".Description;

            trigger OnValidate()
            begin
                /*IF (("Team Code"='') AND ("Group Code"='')) THEN BEGIN
                 Department.SETFILTER ("Department Categ.  Description",'%1',"Department Categ.  Description");
                     IF Department.FIND('-') THEN BEGIN
                
                
                        IF "Department Categ.  Description"<>'' THEN BEGIN
                
                          VALIDATE("Department Code",Department."Department Category");
                          VALIDATE("Department Category",Department."Department Category");
                
                          VALIDATE(Sector,Department.Sector);
                          VALIDATE("Sector  Description",Department."Sector  Description");
                          END;
                  END;
                  END;
                  IF (("Team Code"='') AND ("Group Code"='') AND ( "Department Categ.  Description"='')) THEN BEGIN
                    Sector:='';
                "Department Category":='';
                "Group Code":='';
                "Team Code":='';
                "Sector  Description":='';
                "Department Categ.  Description":='';
                "Group Description":='';
                "Team Description":='';
                END;
                
                   SectorR.SETFILTER(Description,'%1',"Sector  Description");
                  IF SectorR.FINDFIRST THEN BEGIN
                    "Sector Identity":=SectorR.Identity;
                    END;
                 DepartmentC.SETFILTER(Description,'%1',"Department Categ.  Description");
                  IF DepartmentC.FINDFIRST THEN BEGIN
                    "Department Category Identity":=DepartmentC.Identity;
                    END;
                
                
                 posDis.RESET;
                        IF (("Team Description"='') AND ("Group Description"='') AND  ("Department Categ.  Description"<>'')) THEN BEGIN
                       posDis.SETFILTER("Department Code",'%1',"Department Category");
                       posDis.SETFILTER("Management Level",'%1',"Management Level");
                        posDis.SETFILTER("Department Categ.  Description",'%1',"Department Categ.  Description");
                       IF posDis.FIND('-') THEN BEGIN
                     VALIDATE("Disc. Department Code",posDis."Disc. Department Code");
                     VALIDATE("Disc. Department Name",posDis."Disc. Department Name");
                    END
                    ELSE BEGIN
                     VALIDATE("Disc. Department Code","Department Category");
                     VALIDATE("Disc. Department Code","Department Code");
                    END;
                    END;
                    "Disc. Department Code":="Department Category";
                    "Disc. Department Name":=posDis."Disc. Department Name";
                    PosMenuNew.SETFILTER(Code,'%1',Rec.Code);
                PosMenuNew.SETFILTER("Org. Structure",'%1',Rec."Org. Structure");
                PosMenuNew.SETFILTER(Description,'%1',Rec.Description);
                IF PosMenuNew.FIND('-') THEN BEGIN
                  IF PosMenuNew.GET(Code,Description,'',"Org. Structure") THEN
                  PosMenuNew.RENAME(Code,Description,"Department Code","Org. Structure") ;
                END;
                */

            end;
        }
        field(50375; "Group Description"; Text[150])
        {
            Caption = 'Group Description';
            Editable = true;
            TableRelation = Group.Description WHERE("Org Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin
                /*IF "Team Code"='' THEN BEGIN
                 Department.SETFILTER ("Group Description",'%1',"Group Description");
                     IF Department.FIND('-') THEN BEGIN
                
                
                        IF "Group Description"<>'' THEN BEGIN
                
                          VALIDATE("Department Code",Department."Group Code");
                          VALIDATE("Group Code",Department."Group Code");
                          VALIDATE("Department Category",Department."Department Category");
                          VALIDATE("Department Categ.  Description",Department."Department Categ.  Description");
                          VALIDATE(Sector,Department.Sector);
                          VALIDATE("Sector  Description",Department."Sector  Description");
                          END;
                  END;
                  END;
                  IF ("Team Description"='') AND ("Group Description"='') THEN BEGIN
                    Sector:='';
                "Department Category":='';
                "Group Code":='';
                "Team Code":='';
                "Sector  Description":='';
                "Department Categ.  Description":='';
                "Group Description":='';
                "Team Description":='';
                END;
                   SectorR.SETFILTER(Description,'%1',"Sector  Description");
                  IF SectorR.FINDFIRST THEN BEGIN
                    "Sector Identity":=SectorR.Identity;
                    END;
                 DepartmentC.SETFILTER(Description,'%1',"Department Categ.  Description");
                  IF DepartmentC.FINDFIRST THEN BEGIN
                    "Department Category Identity":=DepartmentC.Identity;
                    END;
                
                   posDis.RESET;
                       IF (("Team Description"='') AND ("Group Description"<>'')) THEN BEGIN
                
                       posDis.SETFILTER("Department Code",'%1',"Group Code");
                       posDis.SETFILTER("Management Level",'%1',"Management Level");
                       posDis.SETFILTER("Group Description",'%1',"Group Code");
                       IF posDis.FIND('-') THEN BEGIN
                     VALIDATE("Disc. Department Code",posDis."Disc. Department Code");
                     VALIDATE("Disc. Department Name",posDis."Disc. Department Name");
                
                     END
                    ELSE BEGIN
                     VALIDATE("Disc. Department Code","Group Code");
                   VALIDATE("Disc. Department Name","Group Description");
                    END;
                    END;
                    PosMenuNew.SETFILTER(Code,'%1',Rec.Code);
                PosMenuNew.SETFILTER("Org. Structure",'%1',Rec."Org. Structure");
                PosMenuNew.SETFILTER(Description,'%1',Rec.Description);
                IF PosMenuNew.FIND('-') THEN BEGIN
                  IF PosMenuNew.GET(Code,Description,'',"Org. Structure") THEN
                  PosMenuNew.RENAME(Code,Description,"Department Code","Org. Structure") ;
                END;*/

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
                /*Department.SETFILTER ("Team Description",'%1',"Team Description");
                    IF Department.FIND('-') THEN BEGIN

                      "Team Description":=Department."Team Description";
                       IF "Team Description"<>'' THEN BEGIN
                         VALIDATE("Team Code",Department."Team Code");
                         VALIDATE("Department Code",Department."Team Code");
                         VALIDATE("Group Code",Department."Group Code");
                         VALIDATE("Group Description",Department."Group Description");
                         VALIDATE("Department Category",Department."Department Category");
                         VALIDATE("Department Categ.  Description",Department."Department Categ.  Description");
                         VALIDATE(Sector,Department.Sector);
                         VALIDATE("Sector  Description",Department."Sector  Description");
                         END;
                 END;
                 IF "Team Description"='' THEN BEGIN
                Sector:='';
               "Department Category":='';
               "Group Code":='';
               "Team Code":='';
               "Sector  Description":='';
               "Department Categ.  Description":='';
               "Group Description":='';
               "Team Description":='';
               END;


                SectorR.SETFILTER(Description,'%1',"Sector  Description");
                 IF SectorR.FINDFIRST THEN BEGIN
                   "Sector Identity":=SectorR.Identity;
                   END;
                DepartmentC.SETFILTER(Description,'%1',"Department Categ.  Description");
                 IF DepartmentC.FINDFIRST THEN BEGIN
                   "Department Category Identity":=DepartmentC.Identity;
                   END;
                     IF (("Team Description"<>'')) THEN BEGIN

                      posDis.SETFILTER("Department Code",'%1',"Team Code");
                      posDis.SETFILTER("Management Level",'%1',"Management Level");
                      posDis.SETFILTER("Team Description",'%1',"Team Code");
                      IF posDis.FIND('-') THEN BEGIN
                    VALIDATE("Disc. Department Code",posDis."Disc. Department Code");
                   VALIDATE("Disc. Department Name",posDis."Disc. Department Name");
                   END
                   ELSE BEGIN
                    VALIDATE("Disc. Department Code","Team Code");
                   VALIDATE("Disc. Department Name","Team Description");
                   END;
                   END;
                   PosMenuNew.SETFILTER(Code,'%1',Rec.Code);
               PosMenuNew.SETFILTER("Org. Structure",'%1',Rec."Org. Structure");
               PosMenuNew.SETFILTER(Description,'%1',Rec.Description);
               IF PosMenuNew.FIND('-') THEN BEGIN
                 IF PosMenuNew.GET(Code,Description,'',"Org. Structure") THEN
                 PosMenuNew.RENAME(Code,Description,"Department Code","Org. Structure") ;
               END;
               */

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
            Editable = false;
        }
        /*     field(50391; "Role Name"; Text[100])
             {
                 Caption = 'Role Description';
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
                 end;
             }*/
        field(50392; "BJF/GJF"; Option)
        {
            Caption = 'BJF/GJF';
            OptionCaption = ' ,BJF,GJF';
            OptionMembers = " ",BJF,GJF;
        }
        field(50394; "Work Group"; Text[10])
        {
        }
        field(50395; "Minimal Education Level"; enum School)
        {
            Caption = 'Education level';


        }
        field(50396; "Position Menu Identity"; Integer)
        {
            AutoIncrement = true;
        }
        field(50397; "Number of benefits"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Position Benefits" WHERE("Position Code" = FIELD("Code"),
                                                           "Position Name" = FIELD(Description),
                                                           "Org. Structure" = FIELD("Org. Structure")));
            Caption = 'Number of benefits';

        }
        field(500398; "Number of dimension value"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Dimension for position" WHERE("Position Code" = FIELD("Code"),
                                                                "Position Description" = FIELD(Description),
                                                                "ORG Shema" = FIELD("Org. Structure")));
            Caption = 'Number of dimension value';

        }
        field(500399; Grade; Integer)
        {
            Caption = 'Grade';
        }
        field(500402; "Official Translation"; Text[250])
        {
            Caption = 'Official Translation';
        }
        field(500403; "Department Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Department.Description WHERE("ORG Shema" = FIELD("Org. Structure"),
                                                               "Code" = FIELD("Department Code")));
            Caption = 'Department Name';

        }
        field(500404; "ID for GPS"; Integer)
        {
            Caption = 'ID for GPS';
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
            CalcFormula = count("Position Minimal Education" where("Position Code" = field(Code), "Position Name" = field(Description), "Org Shema" = field("Org. Structure")));
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
                ecl: Record "Employee Contract Ledger";
            begin
                //   "Position Coefficient for Wage" := UpdateCoeff(rec."Position complexity", rec."Position Responsibility", rec."Workplace conditions", Rec.Increment);
                ecl.Reset();
                ecl.SetFilter("Position Description", '%1', rec.Description);
                ecl.SetFilter("Position Code", '%1', Rec.Code);
                ecl.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                ecl.SetFilter(Active, '%1', true);
                ecl.SetFilter("Grounds for Term. Description", '%1', '');
                if ecl.FindSet() then
                    repeat
                        ecl."Position complexity" := Rec."Position complexity";
                        ecl.validate("Position Coefficient for Wage", Rec."Position Coefficient for Wage");
                        ecl."Position Responsibility" := Rec."Position Responsibility";
                        ecl."Workplace conditions" := Rec."Workplace conditions";
                        NetoPlate.Reset();
                        NetoPlate.SetFilter("No.", '%1', ecl."Employee No.");
                        NetoPlate.Get(ecl."Employee No.");
                        if NetoPlate."Wage Type" = 'NETO' then
                            ecl.Modify(false)
                        else
                            ecl.Modify();


                    until ecl.Next() = 0;
            end;
        }

        field(500409; "Position Responsibility"; Decimal)

        {
            Caption = 'Position Responsibility';
            trigger OnValidate()
            var
                myInt: Integer;
                ecl: Record "Employee Contract Ledger";

            begin
                //    "Position Coefficient for Wage" := UpdateCoeff(rec."Position complexity", rec."Position Responsibility", rec."Workplace conditions", Rec.Increment);
                ecl.Reset();
                ecl.SetFilter("Position Description", '%1', rec.Description);
                ecl.SetFilter("Position Code", '%1', Rec.Code);
                ecl.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                ecl.SetFilter(Active, '%1', true);
                ecl.SetFilter("Grounds for Term. Description", '%1', '');
                if ecl.FindSet() then
                    repeat
                        ecl."Position complexity" := Rec."Position complexity";
                        ecl."Position Coefficient for Wage" := Rec."Position Coefficient for Wage";
                        ecl."Position Responsibility" := Rec."Position Responsibility";
                        ecl."Workplace conditions" := Rec."Workplace conditions";
                        NetoPlate.Reset();
                        NetoPlate.SetFilter("No.", '%1', ecl."Employee No.");
                        NetoPlate.Get(ecl."Employee No.");
                        if NetoPlate."Wage Type" = 'NETO' then
                            ecl.Modify(false)
                        else
                            ecl.Modify();
                    until ecl.Next() = 0;
            end;
        }

        field(50412; "Increment"; Decimal)
        {
            Caption = 'Increment';

            trigger OnValidate()
            var
                myInt: Integer;
                ecl: Record "Employee Contract Ledger";
            begin

                //   "Position Coefficient for Wage" := UpdateCoeff(rec."Position complexity", rec."Position Responsibility", rec."Workplace conditions", Rec.Increment);
                ecl.Reset();
                ecl.SetFilter("Position Description", '%1', rec.Description);
                ecl.SetFilter("Position Code", '%1', Rec.Code);
                ecl.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                ecl.SetFilter(Active, '%1', true);
                ecl.SetFilter("Grounds for Term. Description", '%1', '');
                if ecl.FindSet() then
                    repeat
                        ecl."Position complexity" := Rec."Position complexity";
                        ecl."Position Coefficient for Wage" := Rec."Position Coefficient for Wage";
                        ecl."Position Responsibility" := Rec."Position Responsibility";
                        ecl."Workplace conditions" := Rec."Workplace conditions";
                        NetoPlate.Reset();
                        NetoPlate.SetFilter("No.", '%1', ecl."Employee No.");
                        NetoPlate.Get(ecl."Employee No.");
                        if NetoPlate."Wage Type" = 'NETO' then
                            ecl.Modify(false)
                        else
                            ecl.Modify();
                    until ecl.Next() = 0;
            end;


        }
        field(50411; "Position Coefficient Director"; Decimal)
        {
            Caption = 'Position Coefficient for Wage';
            DecimalPlaces = 1 : 3;
        }


        field(50410; "Workplace conditions"; Decimal)
        {
            Caption = 'Workplace conditions';
            trigger OnValidate()
            var
                myInt: Integer;
                ecl: Record "Employee Contract Ledger";
            begin
                // "Position Coefficient for Wage" := UpdateCoeff(rec."Position complexity", rec."Position Responsibility", rec."Workplace conditions", Rec.Increment);
                ecl.Reset();
                ecl.SetFilter("Position Description", '%1', rec.Description);
                ecl.SetFilter("Position Code", '%1', Rec.Code);
                ecl.SetFilter("Org. Structure", '%1', Rec."Org. Structure");
                ecl.SetFilter(Active, '%1', true);
                ecl.SetFilter("Grounds for Term. Description", '%1', '');
                if ecl.FindSet() then
                    repeat
                        ecl."Position complexity" := Rec."Position complexity";
                        ecl."Position Coefficient for Wage" := Rec."Position Coefficient for Wage";
                        ecl."Position Responsibility" := Rec."Position Responsibility";
                        ecl."Workplace conditions" := Rec."Workplace conditions";
                        NetoPlate.Reset();
                        NetoPlate.SetFilter("No.", '%1', ecl."Employee No.");
                        NetoPlate.Get(ecl."Employee No.");
                        if NetoPlate."Wage Type" = 'NETO' then
                            ecl.Modify(false)
                        else
                            ecl.Modify();

                    until ecl.Next() = 0;
            end;
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
    var
        myInt: Integer;
        HeadOfOrg: Record "Head Of's";
    begin

        if (rec."Management Level".AsInteger() <> 0) and (Rec."Management Level".AsInteger() <> 6) then begin
            HeadOfOrg.Reset();
            HeadOfOrg.SetFilter("Department Code", '%1', Rec."Department Code");
            HeadOfOrg.SetFilter("Position Code", '%1', Rec.Code);
            HeadOfOrg.SetFilter("ORG Shema", '%1', Rec."Org. Structure");
            HeadOfOrg.SetFilter("Management Level", '%1', Rec."Management Level");
            if HeadOfOrg.FindFirst() then
                HeadOfOrg.Delete();



        end;

    end;

    var
        Position: Record "Position";
        NetoPlate: Record Employee;
        //   RoleT: Record "Role";
        // Roles: Record "Role";
        ECLC: Record "Employee Contract Ledger";

    procedure UpdateCoeff(var Comp: Decimal; var Resp: decimal; var Conditi: Decimal; Increment: Decimal): Decimal
    begin

        //     exit(round(Comp + Comp * ((Resp + Conditi) / 100) + Increment, 0.01, '='));

    end;
}

