table 50162 "Dimension Pos for report"
{
    Caption = 'Dimension temporary';
    //DrillDownPageID = "Dimensions for pos reports";
    //LookupPageID = "Dimensions for pos reports";

    fields
    {
        field(1; "Position Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Position Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(7; "ORG Shema"; Code[6])
        {
            Caption = 'Org Schema';
            TableRelation = "ORG Shema".Code;
        }
        field(39; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            Editable = false;

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDim("Dimension Code") THEN
                  ERROR(DimMgt.GetDimErr);*/

            end;
        }
        field(40; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            Editable = true;
        }
        field(41; "Dimension  Name"; Text[100])
        {
            Caption = 'Dimension Code';
            Editable = true;
            TableRelation = "Dimension Value".Name WHERE(Status = CONST(A));

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDim("Dimension Code") THEN
                  ERROR(DimMgt.GetDimErr);*/
                IF "Dimension  Name" <> '' THEN BEGIN
                    DimensionValueTable.RESET;
                    DimensionValueTable.SETFILTER(Name, '%1', Rec."Dimension  Name");
                    DimensionValueTable.SETFILTER(Status, '%1', DimensionValueTable.Status::A);
                    IF DimensionValueTable.FINDFIRST THEN BEGIN
                        "Dimension Value Code" := DimensionValueTable.Code;
                    END
                    ELSE BEGIN
                        "Dimension Value Code" := '';
                    END;
                END;

            end;
        }
        field(50003; "Operator No."; Code[40])
        {
            Caption = 'Operator No.';
            Editable = false;
        }
        field(50004; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50005; Belongs; Text[250])
        {
            Caption = 'belong';
        }
        field(50370; Sector; Code[30])
        {
            Caption = 'Sector';
            TableRelation = "Sector temporary".Code WHERE("Org Shema" = FIELD("ORG Shema"));
        }
        field(50371; "Department Category"; Code[30])
        {
            Caption = 'Department';
            TableRelation = "Department Category temporary".Code WHERE("Org Shema" = FIELD("ORG Shema"),
                                                                        Description = FIELD("Department Categ.  Description"));

            trigger OnValidate()
            begin
                ;
            end;
        }
        field(50372; "Group Code"; Code[30])
        {
            Caption = 'Group';
            TableRelation = "Group temporary".Code WHERE("Org Shema" = FIELD("ORG Shema"),
                                                          Description = FIELD("Group Description"));
        }
        field(50373; "Sector  Description"; Text[250])
        {
            Caption = 'Sector Description';
            Editable = true;
            TableRelation = "Sector temporary".Description WHERE("Org Shema" = FIELD("ORG Shema"));
        }
        field(50374; "Department Categ.  Description"; Text[150])
        {
            Caption = 'Department (description)';
            Editable = true;
            TableRelation = "Department Category temporary".Description WHERE("Org Shema" = FIELD("ORG Shema"));
        }
        field(50375; "Group Description"; Text[150])
        {
            Caption = 'Group Description';
            Editable = true;
            TableRelation = "Group temporary".Description WHERE("Org Shema" = FIELD("ORG Shema"));
        }
        field(50376; "Team Code"; Code[30])
        {
            Caption = 'Team';
            TableRelation = "Team temporary".Code WHERE("Org Shema" = FIELD("ORG Shema"),
                                                         Name = FIELD("Team Description"));
        }
        field(50377; "Team Description"; Text[100])
        {
            Caption = 'Team Description';
            Editable = true;
            TableRelation = "Team temporary".Name WHERE("Org Shema" = FIELD("ORG Shema"));
        }
        field(50378; "Org Belongs"; Text[130])
        {
            Caption = 'Org Belongs';
            Editable = true;
            TableRelation = "Department temporary".Description;

            trigger OnValidate()
            begin
                IF "Org Belongs" <> '' THEN BEGIN
                    DepartmentTempReal.RESET;
                    DepartmentTempReal.SETFILTER(Description, '%1', "Org Belongs");
                    IF DepartmentTempReal.FINDFIRST THEN BEGIN
                        Sector := DepartmentTempReal.Sector;
                        "Sector  Description" := DepartmentTempReal."Sector  Description";
                        "Department Category" := DepartmentTempReal."Department Category";
                        "Department Categ.  Description" := DepartmentTempReal."Department Categ.  Description";
                        "Group Code" := DepartmentTempReal."Group Code";
                        "Group Description" := DepartmentTempReal."Group Description";
                        "Team Code" := DepartmentTempReal."Team Code";
                        "Team Description" := DepartmentTempReal."Team Description";
                        "Sector Identity" := DepartmentTempReal."Sector Identity";
                    END;

                    DimensionTempFindTC.RESET;
                    DimensionTempFindTC.SETFILTER(Sector, '%1', Sector);
                    DimensionTempFindTC.SETFILTER("Sector  Description", '%1', "Sector  Description");
                    DimensionTempFindTC.SETFILTER("Department Category", '%1', "Department Category");
                    DimensionTempFindTC.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
                    DimensionTempFindTC.SETFILTER("Group Code", '%1', "Group Code");
                    DimensionTempFindTC.SETFILTER("Group Description", '%1', "Group Description");
                    DimensionTempFindTC.SETFILTER("Team Code", '%1', "Team Code");
                    DimensionTempFindTC.SETFILTER("Team Description", '%1', "Team Description");
                    IF DimensionTempFindTC.FINDFIRST THEN BEGIN
                        "Dimension  Name" := DimensionTempFindTC."Dimension  Name";
                        VALIDATE("Dimension  Name", "Dimension  Name");
                    END;
                END;
            end;
        }
        field(500378; "Sector Identity"; Integer)
        {
            BlankZero = true;
            NotBlank = false;
        }
    }

    keys
    {
        key(Key1; "Position Code", "Dimension Value Code", "ORG Shema", "Position Description", "Org Belongs")
        {
        }
        key(Key2; "Dimension Value Code")
        {
        }
        key(Key3; "Position Description")
        {
        }
    }

    fieldgroups
    {

    }

    trigger OnDelete()
    begin
        /*IF COMPANYNAME='SB' THEN BEGIN
               OS.SETFILTER(Code,'%1',"ORG Shema");
          OS.SETFILTER(Status,'%1',OS.Status::Active);
      IF OS.FINDFIRST THEN BEGIN
      WPConnSetup.FINDFIRST();


      CREATE(conn, TRUE, TRUE);

      conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));

      CREATE(comm,TRUE, TRUE);

      lvarActiveConnection := conn;
      comm.ActiveConnection := lvarActiveConnection;

      comm.CommandText := 'dbo.Department_Delete';
      comm.CommandType := 4;
      comm.CommandTimeout := 0;

      {param:=comm.CreateParameter('@Code', 200, 1, 30, Rec.Code);
      comm.Parameters.Append(param);}

      comm.Execute;
      conn.Close;
      CLEAR(conn);
      CLEAR(comm);
      END;
      END;
      "Last Date Modified" := TODAY;
      //"Operator No.":=COPYSTR(USERID,1,15)
      Dimension.SETFILTER(Code,'%1','TC');
      IF Dimension.FINDFIRST THEN BEGIN
      "Dimension Code":=Dimension.Code;
      END
      ELSE BEGIN
      "Dimension Code":='';
      END;
      */
        Rec.DELETE;

    end;

    trigger OnInsert()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);


        OrgStr.SETFILTER(Status, '%1', OrgStr.Status::Preparation);
        IF OrgStr.FINDFIRST THEN BEGIN
            "ORG Shema" := OrgStr.Code;
        END;
        /* IF COMPANYNAME='SB' THEN BEGIN


            OS.SETFILTER(Code,'%1',"ORG Shema");
           OS.SETFILTER(Status,'%1',OS.Status::Active);
       IF OS.FINDFIRST THEN BEGIN
       WPConnSetup.FINDFIRST();


       CREATE(conn, TRUE, TRUE);

       conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                 +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));

       CREATE(comm,TRUE, TRUE);

       lvarActiveConnection := conn;
       comm.ActiveConnection := lvarActiveConnection;

       comm.CommandText := 'dbo.Department_Insert';
       comm.CommandType := 4;
       comm.CommandTimeout := 0;


       param:=comm.CreateParameter('@Code', 200, 1, 30, Code);
       comm.Parameters.Append(param);
       param:=comm.CreateParameter('@Description', 200, 1, 100, Description);
       comm.Parameters.Append(param);
       param:=comm.CreateParameter('@Type', 200, 1, 30,"Department Type");
       comm.Parameters.Append(param);
       param:=comm.CreateParameter('@B_1', 200, 1, 30, Sector);
       comm.Parameters.Append(param);
       param:=comm.CreateParameter('B_1_description', 200, 1, 250, "Sector  Description");
       comm.Parameters.Append(param);
       param:=comm.CreateParameter('@B_1_regions', 200, 1, 30, "Department Category");
       comm.Parameters.Append(param);
       param:=comm.CreateParameter('@B_1_regions_description', 200, 1, 250, "Department Categ.  Description");
       comm.Parameters.Append(param);
       param:=comm.CreateParameter('@stream', 200, 1, 30, "Group Code");
       comm.Parameters.Append(param);
       param:=comm.CreateParameter('@stream_description', 200, 1, 250, "Group Description");
       comm.Parameters.Append(param);
       comm.Execute;
       conn.Close;
       CLEAR(conn);
       CLEAR(comm);

       END;
       END;
       */

    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
    end;

    var
        WPConnSetup: Record "Web portal connection setup";

        "B-1Rec": Record "Sector temporary";
        "B-1WithRegions": Record "Department Category temporary";
        StreamRec: Record "Group temporary";
        Employee: Record "Employee";
        WC: Record "Wage Calculation";
        ECL: Record "Employee Contract Ledger";
        Department: Record "Department";
        Emp: Record "Employee";

        // Position: Record "Confidential Clerks";
        //  Position2: Record "Confidential Clerks";
        OS: Record "ORG Shema";
        TeamRec: Record "Team temporary";
        LengthCode: Integer;
        // Tip: Record "Type";
        Dep: Record "Department temporary";
        DC: Record "Department Category temporary";
        TEAM: Record "Team temporary";
        GR: Record "Group temporary";
        SectorR: Record "Sector temporary";
        NewDepartment: Record "Department temporary";
        DepartmentCategory: Record "Department Category temporary";
        SectorNew: Record "Sector temporary";
        GroupNew: Record "Group temporary";
        Team1: Record "Team temporary";
        DepartmentCheck: Record "Department temporary";
        DepartmentValidate: Record "Department temporary";
        OrgStr: Record "ORG Shema";
        Sec: Record "Sector temporary";
        DepCat: Record "Department Category temporary";
        Dimension: Record "Dimension";
        DepartmentTempTry: Record "Department temporary";
        DepartmentTempTry1: Record "Department temporary";
        DimensionNew: Record "Dimension temporary";
        DimensionNewTemp: Record "Dimension temporary";
        DepartmentTempNes: Record "Department temporary";
        String: Text;
        Brojac: Integer;
        String1: Text;
        LengthString: Integer;
        I: Integer;
        DepartmentTabela: Record "Department temporary";
        FindSector: Record "Sector temporary";
        DimensionValueTable: Record "Dimension Value";
        Departmenttemp: Record "Department temporary";
        SectorPosition: Integer;
        Brojac1: Integer;
        ii: Integer;
        StringValue: Code[50];
        SectorIdentity: Record "Sector temporary";
        DepartmentTempReal: Record "Department temporary";
        DimensionTempFindTC: Record "Dimension temporary";
        PositionMenu: Record "Position Menu temporary";
}

