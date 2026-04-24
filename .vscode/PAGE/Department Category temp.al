table 50139 "Department Category temporary"
{
    Caption = 'Department';
    DrillDownPageID = "Dep.Category temporary sist";
    LookupPageID = "Dep.Category temporary sist";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = false;

            trigger OnValidate()
            begin
                OsPreparation.RESET;
                OsPreparation.SETFILTER(Status, '%1', 2);
                IF OsPreparation.FINDLAST THEN BEGIN
                    "Org Shema" := OsPreparation.Code;
                END
                ELSE BEGIN
                    "Org Shema" := '';
                END;
                DepT.Reset();
                DepT.SETFILTER(Code, '%1', xRec.Code);
                DepT.SETFILTER("ORG Shema", '%1', "Org Shema");
                IF DepT.FINDSET THEN
                    REPEAT
                        IF DepT.GET(xRec.Code, DepT."ORG Shema", DepT."Team Description", DepT."Department Categ.  Description", DepT."Group Description", Rec.Description)
                          THEN
                            DepT.RENAME(Rec.Code, DepT."ORG Shema", DepT."Team Description", DepT."Department Categ.  Description", DepT."Group Description", Rec.Description)
                 UNTIL DepT.NEXT = 0;

                //promjena šifre odjela
                if (xRec.Code <> '') and (Rec."Sector Belongs" <> '') then begin
                    HeadOrg.Reset();
                    HeadOrg.SETFILTER("Department Category", '%1', xRec.Code);
                    HeadOrg.SETFILTER("ORG Shema", '%1', "Org Shema");
                    IF HeadOrg.FINDSET THEN
                        REPEAT
                            //"Department Code", "ORG Shema", "Department Categ.  Description", "Group Description", "Team Description", "Management Level", "Position Code"
                            HeadOrg."Department Category" := Rec.Code;

                            HeadOrg.Modify();


                            if (HeadOrg."Department Categ.  Description" <> '') and (HeadOrg."Group Description" = '') then begin

                                IF HeadU.GET(HeadOrg."Department Code", HeadOrg."ORG Shema", HeadOrg."Department Categ.  Description", HeadOrg."Group Description",
                                 HeadOrg."Team Description", HeadOrg."Management Level", HeadOrg."Position Code")
                                                        THEN
                                    HeadU.RENAME(Rec.Code, HeadOrg."ORG Shema", HeadOrg."Department Categ.  Description", HeadOrg."Group Description",
                              HeadOrg."Team Description", HeadOrg."Management Level", HeadOrg."Position Code")

                            end;
                        until HeadOrg.Next() = 0;

                end;

                /*  if xRec."Department Type"=xRec."Department Type"::"Main office" then
                  "Department Type":="Department Type"::"Main office"
                  else

                  "Department Type" := "Department Type"::"Department Category";*/

                DepT.Reset();
                DepT.SetFilter(Code, '%1', Rec.Code);
                DepT.SetFilter(Description, '%1', rec.Description);
                DepT.SetFilter("ORG Shema", '%1', rec."Org Shema");
                if not DepT.FindFirst() then begin

                    DepT.Init();
                    DepT.Validate("ORG Shema", Rec."Org Shema");
                    DepT.validate(Code, Rec.Code);
                    DepT.validate(Description, Rec.Description);
                    DepT."Department Categ.  Description" := Rec.Description;
                    DepT."Department Category" := rec.Code;

                    SectorF.Reset();
                    SectorF.SetFilter("Org Shema", '%1', rec."Org Shema");
                    SectorF.SetFilter(Description, Rec."Sector Belongs");
                    if SectorF.FindFirst() then begin
                        DepT.Validate("Sector Code", SectorF.Code);
                        DepT.Validate(Sector, SectorF.Code);
                        DepT.Validate("Sector  Description", SectorF.Description);
                    end


                    else begin

                        DepT.Validate("Sector Code", '');
                        DepT.Validate(Sector, '');
                        DepT.Validate("Sector  Description", '');
                    end;



                    DepT."Department Type" := Rec."Department Type";
                    DepT.Insert();


                end


            end;
        }
        field(2; Day; Option)
        {
            Caption = 'Day';
            OptionCaption = 'Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(3; "Work Shift Code"; Code[10])
        {
            Caption = 'Work Shift Code';
            NotBlank = true;
        }
        field(4; "Starting Time"; Time)
        {
            Caption = 'Starting Time';

            trigger OnValidate()
            begin
                /*IF ("Ending Time" = 0T) OR
                   ("Ending Time" < "Starting Time")
                THEN BEGIN
                  ShopCalendar.SETRANGE(Code,Code);
                  ShopCalendar.SETRANGE(Day,Day);
                  ShopCalendar.SETRANGE("Starting Time","Starting Time",235959T);
                  IF ShopCalendar.FINDFIRST THEN
                    "Ending Time" := ShopCalendar."Starting Time"
                  ELSE
                    "Ending Time" := 235959T;
                END;
                CheckRedundancy;
                */

            end;
        }
        field(5; "Ending Time"; Time)
        {
            Caption = 'Ending Time';

            trigger OnValidate()
            begin
                /*IF ("Ending Time" < "Starting Time") AND
                   ("Ending Time" <> 000000T)
                THEN
                  ERROR(Text000,FIELDCAPTION("Ending Time"),FIELDCAPTION("Starting Time"));
                
                CheckRedundancy;
                */

            end;
        }
        field(12; n; Option)
        {
            OptionMembers = ,Percentage,First,Last,"First 1","First 2";
        }
        field(50000; Description; Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin

                DepT.Reset();
                DepT.SETFILTER(Code, '%1', Rec.Code);
                DepT.SETFILTER("ORG Shema", '%1', "Org Shema");

                IF DepT.FINDSET THEN
                    REPEAT
                        IF DepT.GET(Rec.Code, DepT."ORG Shema", DepT."Team Description", DepT."Department Categ.  Description", DepT."Group Description", xRec.Description)
                          THEN BEGIN
                            DepT.RENAME(Rec.Code, DepT."ORG Shema", DepT."Team Description", DepT."Department Categ.  Description", DepT."Group Description", Rec.Description);

                        END;
                    UNTIL DepT.NEXT = 0;



                //promjena naziva odjela

                if (Rec.Code <> '') and (Rec."Sector Belongs" <> '') then begin

                    HeadOrg.Reset();
                    HeadOrg.SETFILTER("Department Categ.  Description", '%1', xRec.Description);
                    HeadOrg.SETFILTER("ORG Shema", '%1', "Org Shema");
                    IF HeadOrg.FINDSET THEN
                        REPEAT
                            //"Department Code", "ORG Shema", "Department Categ.  Description", "Group Description", "Team Description", "Management Level", "Position Code"



                            if (HeadOrg."Department Categ.  Description" <> '') and (HeadOrg."Group Description" = '') then begin

                                IF HeadU.GET(HeadOrg."Department Code", HeadOrg."ORG Shema", HeadOrg."Department Categ.  Description", HeadOrg."Group Description",
                                 HeadOrg."Team Description", HeadOrg."Management Level", HeadOrg."Position Code")
                                                        THEN
                                    HeadU.RENAME(HeadOrg."Department Code", HeadOrg."ORG Shema", Rec.Description, HeadOrg."Group Description",
                              HeadOrg."Team Description", HeadOrg."Management Level", HeadOrg."Position Code")

                            end;
                        until HeadOrg.Next() = 0;
                end;

                DepT.Reset();
                DepT.SetFilter(Code, '%1', Rec.Code);
                DepT.SetFilter(Description, '%1', rec.Description);
                DepT.SetFilter("ORG Shema", '%1', rec."Org Shema");
                if not DepT.FindFirst() then begin

                    DepT.Init();
                    DepT.Validate("ORG Shema", Rec."Org Shema");
                    DepT.validate(Code, Rec.Code);
                    DepT.validate(Description, Rec.Description);
                    DepT."Department Categ.  Description" := Rec.Description;
                    DepT."Department Category" := rec.Code;

                    SectorF.Reset();
                    SectorF.SetFilter("Org Shema", '%1', rec."Org Shema");
                    SectorF.SetFilter(Description, Rec."Sector Belongs");
                    if SectorF.FindFirst() then begin
                        DepT.Validate("Sector Code", SectorF.Code);
                        DepT.Validate(Sector, SectorF.Code);
                        DepT.Validate("Sector  Description", SectorF.Description);
                    end


                    else begin

                        DepT.Validate("Sector Code", '');
                        DepT.Validate(Sector, '');
                        DepT.Validate("Sector  Description", '');
                    end;

                    //dodati promjenu


                end;
            end;



        }
        field(50001; "Org Shema"; Code[10])
        {
            Caption = 'Org Shema';
            TableRelation = "ORG Shema".Code;
        }
        field(50002; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50003; "Order"; Integer)
        {
            Caption = 'Order';
        }
        field(50004; "Changing Department"; Boolean)
        {
            Caption = 'Changing Department';

            trigger OnValidate()
            begin
                /*IF Rec."Changing Department" THEN BEGIN
                  DepT.SETFILTER("ORG Shema",'%1',Rec."ORG Shema");
                  DepT.SETFILTER(Code,'%1',Rec.Code);
                  DepT.SETFILTER("Changing Department",'%1',FALSE);
                  IF DepT.FINDSET THEN REPEAT
                    DepT."Changing Department":=TRUE;
                   DepT.MODIFY(TRUE);
                
                     DepT.GET(DepT.Code,DepT."ORG Shema",DepT."Team Description",DepT."Department Categ.  Description",DepT."Group Description");
                    UNTIL DepT.NEXT=0;
                    END;*/

            end;
        }
        field(50005; "Operator No."; Code[40])
        {
            Caption = 'Operator No.';
            Editable = false;
        }
        field(50006; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50007; Identity; Integer)
        {
            AutoIncrement = true;
            Caption = 'Identity';
        }
        field(50008; "Identity Sector"; Integer)
        {
        }
        field(50010; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            TableRelation = "Dimension temporary"."Dimension Value Code" WHERE("Code" = FIELD("Code"),
                                                                                "Department Categ.  Description" = FIELD(Description),
                                                                                "Department Category" = FIELD("Code"));

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDimValue("Dimension Code","Dimension Value Code") THEN
                  ERROR(DimMgt.GetDimErr);*/
                IF "Dimension Value Code" <> '' THEN BEGIN
                    DimensionNew.SETFILTER("Dimension Value Code", '%1', Rec."Dimension Value Code");
                    IF DimensionNew.FINDFIRST THEN BEGIN
                        DimensionNew.CALCFIELDS("Dimension  Name");
                        "Dimension  Name" := DimensionNew."Dimension  Name";
                    END;
                END
                ELSE BEGIN
                    "Dimension  Name" := '';
                END;

            end;
        }
        field(50011; "Dimension  Name"; Text[250])
        {
            Caption = 'Dimension Code';
            Editable = false;

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDim("Dimension Code") THEN
                  ERROR(DimMgt.GetDimErr);*/

            end;
        }
        field(50013; "Number of dimension value"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Dimension temporary" WHERE("Department Categ.  Description" = FIELD(Description),
                                                             "Department Type" = FIELD("Department Type"),
                                                             "ORG Shema" = FIELD("Org Shema")));
            Caption = 'Number of dimension value';

        }
        field(50014; "Number Of Group levels below"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Department temporary" WHERE("Department Category" = FIELD("Code"),
                                                              "Department Type" = FILTER("Group"),
                                                              "Department Categ.  Description" = FIELD(Description)));
            Caption = 'Number Of Group levels below';

        }
        field(50015; "Number Of Team  levels below"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Department temporary" WHERE("Department Category" = FIELD("Code"),
                                                              "Department Type" = FILTER(Sector),
                                                              "Department Categ.  Description" = FIELD(Description)));
            Caption = 'Number Of Team  levels below';

        }
        field(50016; "Residence/Network"; Option)
        {
            Caption = 'Residence/Network';
            OptionCaption = ' ,Residence,Network';
            OptionMembers = " ",Residence,Network;

            trigger OnValidate()
            begin
                /*IF FORMAT(Rec."Residence/Network")<>'' THEN BEGIN
                  IF Code<>'' THEN BEGIN
                  IF Description<>'' THEN BEGIN
                    DepartmentTemp.RESET;
                    DepartmentTemp.SETFILTER("Department Category",'%1',Rec.Code);
                    DepartmentTemp.SETFILTER("Department Categ.  Description",'%1',Rec.Description);
                    DepartmentTemp.SETFILTER("Department Type",'%1',4);
                    IF DepartmentTemp.FINDFIRST THEN BEGIN
                      DepartmentTemp."Residence/Network":="Residence/Network";
                      DepartmentTemp.MODIFY;
                      END;
                
                END;
                    END;
                       END;*/

            end;
        }
        field(50017; "Department Type"; Enum "Department Type")
        {
            Caption = 'Department Type';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                DepT.Reset();
                DepT.SETFILTER(Code, '%1', Rec.Code);
                DepT.SETFILTER("ORG Shema", '%1', "Org Shema");
                DepT.SetFilter(Description, '%1', Rec.Description);
                IF DepT.FindFirst() then begin
                    DepT."Department Type" := Rec."Department Type";
                    DepT.Modify();
                end;

            end;

        }
        field(50020; LastModified; Text[250])
        {
            Caption = 'Last modified code';
        }
        field(50019; "Name of TC"; Text[250])
        {
            Caption = 'Name of TC';
        }
        field(500400; "Fields for change"; Text[30])
        {
            Caption = 'Fields for change';
        }
        field(500401; IsTrue; Boolean)
        {
        }
        field(500402; "Official Translate of DepCat"; Text[250])
        {
            Caption = 'Official Translate of DepCat';
        }
        field(50018; "Sector Belongs"; Text[250])
        {
            Caption = 'Sector Belongs';
            TableRelation = "Sector temporary".Description;

            trigger Onvalidate()
            var
                myInt: Integer;
            begin

                DepT.Reset();
                DepT.SetFilter(Code, '%1', Rec.Code);
                DepT.SetFilter(Description, '%1', rec.Description);
                DepT.SetFilter("ORG Shema", '%1', rec."Org Shema");
                if DepT.FindFirst() then
                    DepT.Delete();

                DepT.Reset();
                DepT.SetFilter(Code, '%1', Rec.Code);
                DepT.SetFilter(Description, '%1', rec.Description);
                DepT.SetFilter("ORG Shema", '%1', rec."Org Shema");

                if not DepT.FindFirst() then begin

                    DepT.Init();
                    DepT.Validate("ORG Shema", Rec."Org Shema");
                    DepT.validate(Code, Rec.Code);
                    DepT.validate(Description, Rec.Description);
                    DepT."Department Categ.  Description" := Rec.Description;
                    DepT."Department Category" := rec.Code;

                    SectorF.Reset();
                    SectorF.SetFilter("Org Shema", '%1', rec."Org Shema");
                    SectorF.SetFilter(Description, Rec."Sector Belongs");
                    if SectorF.FindFirst() then begin
                        DepT.Validate("Sector Code", SectorF.Code);
                        DepT.Validate(Sector, SectorF.Code);
                        DepT.Validate("Sector  Description", SectorF.Description);
                    end


                    else begin

                        DepT.Validate("Sector Code", '');
                        DepT.Validate(Sector, '');
                        DepT.Validate("Sector  Description", '');
                    end;



                    DepT."Department Type" := Rec."Department Type";
                    DepT.Insert();

                end;
                //sada

                if (xRec.Code <> '') and (Rec."Sector Belongs" <> '') then begin
                    HeadOrg.Reset();
                    HeadOrg.SETFILTER("Department Code", '%1', Rec.Code);
                    HeadOrg.SETFILTER("ORG Shema", '%1', "Org Shema");
                    IF HeadOrg.FindFirst() then begin
                        SectorF.Reset();
                        SectorF.SetFilter("Org Shema", '%1', rec."Org Shema");
                        SectorF.SetFilter(Description, Rec."Sector Belongs");
                        if SectorF.FindFirst() then begin

                            HeadOrg.Validate("Sector  Description", SectorF.Description);
                            HeadOrg.Modify();
                        end;
                    end;




                end;


            end;

        }
        field(500403; "ID for GPS"; Integer)
        {
            Caption = 'ID for GPS';
        }
        field(500404; Ispis; Boolean)
        {
        }
        field(500405; Parent; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Org Shema", Description)
        {
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Description, "Code", "Org Shema")
        {
        }
    }

    trigger OnInsert()
    begin
        //CheckRedundancy;
        IF Code = '' THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("B-1 (with regions) Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."B-1 (with regions) Nos.", xRec."No. Series", 0D, Code, "No. Series");
        END;
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
        OsPreparation.RESET;
        OsPreparation.SETFILTER(Status, '%1', 2);
        IF OsPreparation.FINDLAST THEN BEGIN
            "Org Shema" := OsPreparation.Code;
        END
        ELSE BEGIN
            "Org Shema" := '';
        END;
        "Department Type" := "Department Type"::"Department Category";
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
    end;

    trigger OnRename()
    begin
        //CheckRedundancy;
    end;

    var
        Text000: Label '%1 must be higher than %2.';
        SectorF: Record "Sector temporary";
        HeadOrg: Record "Head Of's temporary";
        HeadU: Record "Head Of's temporary";

        Text001: Label 'There is redundancy in the Shop Calendar. Actual work shift %1 from : %2 to %3. Conflicting work shift %4 from : %5 to %6.';
        ShopCalendar: Record "Department Category";
        DepT: Record "Department temporary";
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Dep: Record "Department";
        DimensionNew: Record "Dimension temporary";
        OsPreparation: Record "ORG Shema";
        SectorFind: Record "Sector temporary";
        String: Text;
        Brojac: Integer;
        i: Integer;
        DepartmentTemp: Record "Department temporary";
        LengthString: Integer;
        SectorFind1: Integer;
        DepartmentTemp1: Record "Department temporary";
        NewDescription: Text;
        TheLastCharacter: Integer;
        TheSame: Integer;
        NewCode: Code[20];
        LastCharacter: Integer;
        CheckPoint: Code[20];
        CodeDifferent: Integer;
        SectorCheckLength: Record "Sector temporary";
        Text002: Label 'This code is wrong';

    local procedure CheckRedundancy()
    var
        ShopCalendar2: Record "Department Category";
        TempShopCalendar: Record "Department Category" temporary;
    begin
        /*ShopCalendar2.SETRANGE(Code,Code);
        ShopCalendar2.SETRANGE(Day,Day);
        IF ShopCalendar2.FIND('-') THEN
          REPEAT
            TempShopCalendar := ShopCalendar2;
            TempShopCalendar.INSERT;
          UNTIL ShopCalendar2.NEXT = 0;
        
        TempShopCalendar := xRec;
        IF TempShopCalendar.DELETE THEN ;
        
        TempShopCalendar.SETRANGE(Code,Code);
        TempShopCalendar.SETRANGE(Day,Day);
        TempShopCalendar.SETRANGE("Starting Time",0T,"Ending Time" - 1);
        TempShopCalendar.SETRANGE("Ending Time","Starting Time" + 1,235959T);
        
        IF TempShopCalendar.FINDFIRST THEN
          ERROR(
            Text001,
            "Work Shift Code",
            "Starting Time",
            "Ending Time",
            TempShopCalendar."Work Shift Code",
            TempShopCalendar."Starting Time",
            TempShopCalendar."Ending Time");
        */

    end;

    procedure SetParam("Code": Code[10]; Description: Text)
    begin
        Code := Rec.Code;
        Description := Rec.Description;
    end;
}

