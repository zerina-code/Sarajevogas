table 50151 Sector
{
    Caption = 'Sector';
    DrillDownPageID = Sector;
    LookupPageID = Sector;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';

            trigger OnValidate()
            begin


                IF Code <> xRec.Code THEN BEGIN
                    Dep.Reset();
                    Dep.SETFILTER(Code, '%1', xRec.Code);
                    Dep.SETFILTER("ORG Shema", '%1', "Org Shema");
                    IF Dep.FINDSET THEN
                        REPEAT
                            IF Dep.GET(xRec.Code, Dep."ORG Shema", Dep."Team Description", Dep."Department Categ.  Description", Dep."Group Description", Rec.Description)
                                                 THEN
                                Dep.RENAME(Rec.Code, Dep."ORG Shema", Dep."Team Description", Dep."Department Categ.  Description", Dep."Group Description", Rec.Description)

                        until Dep.Next() = 0;

                    if xRec.Code <> '' then begin
                        HeadOrg.Reset();
                        HeadOrg.SETFILTER("Sector", '%1', xRec.Code);
                        HeadOrg.SETFILTER("ORG Shema", '%1', "Org Shema");
                        IF HeadOrg.FINDSET THEN
                            REPEAT
                                //"Department Code", "ORG Shema", "Department Categ.  Description", "Group Description", "Team Description", "Management Level", "Position Code"
                                HeadOrg.Sector := Rec.Code;

                                HeadOrg.Modify();


                                if (HeadOrg."Department Categ.  Description" = '') and (HeadOrg."Group Description" = '') then begin

                                    IF HeadU.GET(HeadOrg."Department Code", HeadOrg."ORG Shema", HeadOrg."Department Categ.  Description", HeadOrg."Group Description",
                                     HeadOrg."Team Description", HeadOrg."Management Level", HeadOrg."Position Code")
                                                            THEN
                                        HeadU.RENAME(Rec.Code, HeadOrg."ORG Shema", HeadOrg."Department Categ.  Description", HeadOrg."Group Description",
                                  HeadOrg."Team Description", HeadOrg."Management Level", HeadOrg."Position Code")

                                end;
                            until HeadOrg.Next() = 0;
                    end;


                    "Department Type" := "Department Type"::Sector;

                    //Dep
                    Dep.Reset();
                    Dep.SetFilter(Code, '%1', Rec.Code);
                    Dep.setfilter("ORG Shema", '%1', Rec."Org Shema");
                    if not Dep.FindFirst() then begin
                        Dep.Init();
                        Dep.Validate("ORG Shema", Rec."Org Shema");
                        Dep.validate(Code, Rec.Code);
                        Dep.validate(Description, Rec.Description);
                        dep."Sector Code" := Rec.Code;
                        Dep.Sector := Rec.Code;
                        Dep."Sector  Description" := Rec.Description;
                        Dep."Department Type" := Rec."Department Type";
                        Dep.Insert();

                    end
                    else begin

                        dep."Sector Code" := Rec.Code;
                        Dep.Sector := Rec.Code;
                        Dep."Sector  Description" := Rec.Description;
                        Dep.Modify();

                    end;


                end;


            end;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin

                IF Description <> xRec.Description THEN BEGIN
                    Dep.Reset();
                    Dep.SETFILTER(Description, '%1', xRec.Description);
                    Dep.SETFILTER("ORG Shema", '%1', "Org Shema");
                    IF Dep.FINDSET THEN
                        REPEAT
                            IF Dep.GET(Dep.Code, Dep."ORG Shema", Dep."Team Description", Dep."Department Categ.  Description", Dep."Group Description", xRec.Description)
                                                 THEN
                                Dep.RENAME(Dep.Code, Dep."ORG Shema", Dep."Team Description", Dep."Department Categ.  Description", Dep."Group Description", Rec.Description);
                            Dep.Sector := Rec.Code;
                            Dep."Sector  Description" := Rec.Description;
                            Dep.Modify();

                        until Dep.Next() = 0;


                end;

                if Rec.Code <> '' then begin
                    HeadOrg.Reset();
                    HeadOrg.SetFilter(Sector, '%1', Rec.Code);
                    HeadOrg.SETFILTER("Sector  Description", '%1', xrec.Description);
                    HeadOrg.SETFILTER("ORG Shema", '%1', "Org Shema");
                    IF HeadOrg.FINDSET THEN
                        REPEAT
                            //"Department Code", "ORG Shema", "Department Categ.  Description", "Group Description", "Team Description", "Management Level", "Position Code"
                            HeadOrg."Sector  Description" := Rec.Description;

                            HeadOrg.Modify();



                        until HeadOrg.Next() = 0;
                end;
                //Dep
                Dep.Reset();
                Dep.SetFilter(Description, '%1', Rec.Description);
                Dep.setfilter("ORG Shema", '%1', Rec."Org Shema");
                if not Dep.FindFirst() then begin
                    Dep.Init();
                    Dep.Validate("ORG Shema", Rec."Org Shema");
                    Dep.validate(Code, Rec.Code);
                    Dep.validate(Description, Rec.Description);
                    dep."Sector Code" := Rec.Code;
                    Dep.Sector := Rec.Code;
                    Dep."Sector  Description" := Rec.Description;
                    Dep."Department Type" := Rec."Department Type";
                    Dep.Insert();

                end
                else begin

                    IF Dep.GET(Dep.Code, Dep."ORG Shema", Dep."Team Description", Dep."Department Categ.  Description", Dep."Group Description", xRec.Description)
                                                 THEN
                        Dep.RENAME(Dep.Code, Dep."ORG Shema", Dep."Team Description", Dep."Department Categ.  Description", Dep."Group Description", Rec.Description);

                    dep."Sector Code" := Rec.Code;
                    Dep.Sector := Rec.Code;
                    Dep."Sector  Description" := Rec.Description;
                    Dep.Modify();

                end;


            end;
        }
        field(50000; "Org Shema"; Code[10])
        {
            Caption = 'Org Shema';
            TableRelation = "ORG Shema".Code;
        }
        field(50001; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50002; "Order"; Integer)
        {
            Caption = 'Order';
        }
        field(50004; "Changing Department"; Boolean)
        {
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
            Editable = false;
        }
        field(50011; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            //ĐK TableRelation = "Dimension Value"."Dimension Code" where ()
            //Table60008.Field40 WHERE (Field1=FIELD(Code));

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDimValue("Dimension Code","Dimension Value Code") THEN
                  ERROR(DimMgt.GetDimErr);*/
                /*IF "Dimension Value Code" <>'' THEN BEGIN
                DimensionNew.SETFILTER("Dimension Value Code",'%1',Rec."Dimension Value Code");
                IF DimensionNew.FINDFIRST THEN BEGIN
                DimensionNew.CALCFIELDS("Dimension  Name");
                "Dimension  Name":=DimensionNew."Dimension  Name";
                END;
                END
                ELSE BEGIN
                "Dimension  Name":='';
                END;
                */

            end;
        }
        field(50012; "Dimension  Name"; Text[250])
        {
            Caption = 'Dimension Code';
            Editable = false;

            trigger OnValidate()
            begin

            end;
        }
        field(50016; "Residence/Network"; Option)
        {
            Caption = 'Residence/Network';
            OptionCaption = ' ,Residence,Network';
            OptionMembers = " ",Residence,Network;
        }
        field(50017; "Department Type"; Enum "Department Type")
        {
            Caption = 'Department Type';

        }
        field(50018; Belongs; Text[100])
        {
            Caption = 'belong';
        }
        field(500402; "Official Translate of Sector"; Text[250])
        {
            Caption = 'Official Translate of Sector';
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
            Caption = 'Parent';
            TableRelation = Sector.Description WHERE("Org Shema" = FIELD("ORG Shema"));

        }
        field(500406; CEO; Boolean)
        {


            Caption = 'CEO';
            trigger OnValidate()
            begin
                if CEO = true then
                    "Department Type" := "Department Type"::CEO
                else
                    "Department Type" := "Department Type"::Sector;

            end;

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

    trigger OnDelete()
    begin
        /*
        ShopCalendarWorkDays.SETRANGE(Code,Code);
        ShopCalendarWorkDays.DELETEALL;
        
        ShopCalHoliday.SETRANGE(Code,Code);
        ShopCalHoliday.DELETEALL;
        */
        Dep.Reset();
        Dep.SetFilter(Code, '%1', rec.Code);
        Dep.SetFilter(Description, '%1', Rec.Description);
        Dep.SetFilter("ORG Shema", '%1', rec."Org Shema");
        Dep.SetFilter("Department Type", '%1', Dep."Department Type"::Sector);
        if Dep.FindFirst() then
            Dep.Delete();

    end;

    trigger OnInsert()
    begin
        /*IF Code = '' THEN BEGIN
          HumanResSetup.GET;
          HumanResSetup.TESTFIELD("B-1 Nos.");
          NoSeriesMgt.InitSeries(HumanResSetup."B-1 Nos.",xRec."No. Series",0D,Code,"No. Series");
        END;
        */
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
        if CEO = true then
            "Department Type" := "Department Type"::CEO
        else
            "Department Type" := "Department Type"::Sector;


    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
    end;

    var
        ShopCalendarWorkDays: Record "Department Category";
        ShopCalHoliday: Record "Group";
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Dep: Record "Department";
        HeadU: Record "Head Of's";
        HeadOrg: Record "Head Of's";
}

