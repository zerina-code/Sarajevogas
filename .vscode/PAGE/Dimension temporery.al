table 50050 "Dimension temporary"
{
    // //

    Caption = 'Dimension temporary';
    // DrillDownPageID = "Dimensions temporary";
    //LookupPageID = "Dimensions temporary";

    fields
    {
        field(1; "Code"; Code[30])
        {
            Caption = 'Code';

            trigger OnValidate()
            begin
                /*
                 OrgStr.SETFILTER(Status,'%1',OrgStr.Status::Preparation);
                IF OrgStr.FINDFIRST THEN
                  BEGIN
                    "ORG Shema":=OrgStr.Code;
                  END;
                   "Dimension Code":='TC';
                
                
                
                String1:=FORMAT(Rec.Code);
                         LengthString:=STRLEN(String1);
                         Brojac:=0;
                         FOR I:=1 TO LengthString DO BEGIN
                         IF String1[I]='.'THEN BEGIN
                            Brojac:=Brojac+1;
                
                                                IF Brojac=2 THEN BEGIN
                                                  "Department Type":=8;
                                                  END;
                
                                                  IF Brojac=1 THEN BEGIN
                                                  "Department Type":=8;
                                                  END;
                                         END;
                                                     END;
                
                
                IF "Department Type"=8 THEN BEGIN
                Belongs:=FORMAT(Rec.Code)+' '+'-'+' '+Rec.Description;
                
                 "Dimension Code":='TC';
                FindSector.RESET;
                FindSector.SETFILTER(Code,'%1',Rec.Code);
                IF FindSector.FINDFIRST THEN BEGIN
                "Sector  Description":=FindSector.Description;
                
                  END
                  ELSE BEGIN
                  "Sector  Description":='';
                  Sector:='';
                  END;
                DepartmentTempNes.RESET;
                DepartmentTempNes.SETFILTER(Code,'%1',Rec.Code);
                DepartmentTempNes.SETFILTER("Department Type",'%1',8);
                IF DepartmentTempNes.FINDFIRST THEN BEGIN
                  Code:=DepartmentTempNes.Code;
                  Description:=DepartmentTempNes.Description;
                  Sector:=DepartmentTempNes.Sector;
                  "Sector  Description":=DepartmentTempNes."Sector  Description";
                   Belongs:=FORMAT(Rec.Code)+' '+'-'+' '+DepartmentTempNes."Sector  Description";
                   "Dimension Code":='TC';
                
                  END
                  ELSE BEGIN
                    Code:='';
                  Description:='';
                  Sector:='';
                  "Sector  Description":='';
                
                  END;
                
                
                DimensionsForPositionTC.RESET;
                DimensionsForPositionTC.SETFILTER(Sector,'%1',Rec.Code);
                DimensionsForPositionTC.SETFILTER("Sector  Description",'%1',Rec.Description);
                DimensionsForPositionTC.SETFILTER("Department Category",'%1','');
                DimensionsForPositionTC.SETFILTER("Department Categ.  Description",'%1','');
                DimensionsForPositionTC.SETFILTER("Group Code",'%1','');
                DimensionsForPositionTC.SETFILTER("Group Description",'%1','');
                DimensionsForPositionTC.SETFILTER("Team Code",'%1','');
                DimensionsForPositionTC.SETFILTER("Team Description",'%1','');
                IF DimensionsForPositionTC.FINDSET THEN REPEAT
                 // Position Code,Dimension Value Code,ORG Shema,Position Description -KEY
                  IF DimensionsForPositionTC1.GET(DimensionsForPositionTC."Position Code",DimensionsForPositionTC."Dimension Value Code",DimensionsForPositionTC."ORG Shema",DimensionsForPositionTC."Position Description") THEN BEGIN
                    DimensionsForPositionTC1.RENAME(DimensionsForPositionTC."Position Code",Rec."Dimension Value Code",DimensionsForPositionTC."ORG Shema",DimensionsForPositionTC."Position Description");
                    DimensionsForPositionTC1.VALIDATE("Dimension  Name",Rec."Dimension  Name");
                    DimensionsForPositionTC1.MODIFY;
                    END;
                  UNTIL DimensionsForPositionTC.NEXT=0;
                END;
                */

            end;
        }
        field(2; Description; Text[200])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                OrgStr.SETFILTER(Status, '%1', OrgStr.Status::Preparation);
                IF OrgStr.FINDFIRST THEN BEGIN
                    "ORG Shema" := OrgStr.Code;
                END;

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

               comm.CommandText := 'dbo.Department_Update';
               comm.CommandType := 4;
               comm.CommandTimeout := 0;

               {param:=comm.CreateParameter('@OldCode', 200, 1, 30, xRec.Code);
               comm.Parameters.Append(param);
               param:=comm.CreateParameter('@Code', 200, 1, 30, Code);
               comm.Parameters.Append(param);
               param:=comm.CreateParameter('@Description', 200, 1, 100, Description);
               comm.Parameters.Append(param);}
               param:=comm.CreateParameter('@Type', 200, 1, 30, "Department Type");
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
               END;*/

                Belongs := FORMAT(Rec.Code) + ' ' + '-' + ' ' + Rec.Description;

            end;
        }
        field(7; "ORG Shema"; Code[6])
        {
            Caption = 'Org Schema';
            TableRelation = "ORG Shema".Code;
        }
        field(8; Sector; Code[30])
        {
            Caption = 'Sector';
            TableRelation = "Sector temporary".Code WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin

                OrgStr.SETFILTER(Status, '%1', OrgStr.Status::Preparation);
                IF OrgStr.FINDFIRST THEN BEGIN
                    "ORG Shema" := OrgStr.Code;
                END;
                /*IF Sector<>'' THEN BEGIN
                "B-1Rec".RESET;
                "B-1Rec".SETFILTER(Code,Rec.Sector);
               //"B-1Rec".SETFILTER("Org Shema","ORG Shema");
                IF "B-1Rec".FINDFIRST THEN
                  "Sector  Description":="B-1Rec".Description;
                //"Sector Identity":="B-1Rec".Identity;
                END
                ELSE
                "Sector  Description":='';*/


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
                
                comm.CommandText := 'dbo.Department_Update';
                comm.CommandType := 4;
                comm.CommandTimeout := 0;
                
                {param:=comm.CreateParameter('@OldCode', 200, 1, 30, xRec.Code);
                comm.Parameters.Append(param);}
                {param:=comm.CreateParameter('@Code', 200, 1, 30, Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Description', 200, 1, 100, Description);
                comm.Parameters.Append(param);}
                param:=comm.CreateParameter('@Type', 200, 1, 30, "Department Type");
                comm.Parameters.Append(param);
                
                param:=comm.CreateParameter('@B_1', 200, 1, 30, Sector);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('B_1_description', 200, 1, 250, "Sector  Description");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@B_1_regions', 200, 1, 30,"Department Category");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@B_1_regions_description', 200, 1, 250, "Department Categ.  Description");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@stream', 200, 1, 30,"Group Code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@stream_description', 200, 1, 250, "Group Description");
                comm.Parameters.Append(param);
                comm.Execute;
                conn.Close;
                CLEAR(conn);
                CLEAR(comm);
                END;
                END;*/


                IF Sector <> '' THEN BEGIN
                    IF "Department Type" = "Department Type"::Sector THEN
                        Belongs := FORMAT(Rec.Sector) + ' ' + '-' + ' ' + Rec."Sector  Description";

                    "Dimension Code" := 'TC';
                    FindSector.RESET;
                    FindSector.SETFILTER(Code, '%1', Rec.Sector);
                    IF FindSector.FINDFIRST THEN BEGIN
                        "Sector  Description" := FindSector.Description;

                    END
                    ELSE BEGIN
                        "Sector  Description" := '';
                        Sector := '';
                    END;
                    DepartmentTempNes.RESET;
                    DepartmentTempNes.SETFILTER(Code, '%1', Rec.Sector);
                    DepartmentTempNes.SETFILTER(Description, '%1', Rec."Sector  Description");
                    DepartmentTempNes.SETFILTER("Department Type", '%1', 8);
                    IF DepartmentTempNes.FINDFIRST THEN BEGIN
                        Code := DepartmentTempNes.Code;
                        Description := DepartmentTempNes.Description;
                        Sector := DepartmentTempNes.Sector;
                        "Sector  Description" := DepartmentTempNes."Sector  Description";
                        Belongs := FORMAT(Rec.Sector) + ' ' + '-' + ' ' + Rec."Sector  Description";
                        "Dimension Code" := 'TC';

                    END
                    ELSE BEGIN
                        Code := '';
                        Description := '';
                        Sector := '';
                        "Sector  Description" := '';

                    END;
                    DimensionsForPositionTC.RESET;
                    DimensionsForPositionTC.SETFILTER(Sector, '%1', Rec.Code);
                    DimensionsForPositionTC.SETFILTER("Sector  Description", '%1', Rec.Description);
                    DimensionsForPositionTC.SETFILTER("Department Category", '%1', '');
                    DimensionsForPositionTC.SETFILTER("Department Categ.  Description", '%1', '');
                    DimensionsForPositionTC.SETFILTER("Group Code", '%1', '');
                    DimensionsForPositionTC.SETFILTER("Group Description", '%1', '');
                    DimensionsForPositionTC.SETFILTER("Team Code", '%1', '');
                    DimensionsForPositionTC.SETFILTER("Team Description", '%1', '');
                    IF DimensionsForPositionTC.FINDSET THEN
                        REPEAT
                            // Position Code,Dimension Value Code,ORG Shema,Position Description -KEY
                            IF DimensionsForPositionTC1.GET(DimensionsForPositionTC."Position Code", DimensionsForPositionTC."Dimension Value Code", DimensionsForPositionTC."ORG Shema", DimensionsForPositionTC."Position Description") THEN BEGIN
                                DimensionsForPositionTC1.RENAME(DimensionsForPositionTC."Position Code", Rec."Dimension Value Code", DimensionsForPositionTC."ORG Shema", DimensionsForPositionTC."Position Description");
                                DimensionsForPositionTC1.VALIDATE("Dimension  Name", Rec."Dimension  Name");
                                DimensionsForPositionTC1.MODIFY;
                            END;
                        UNTIL DimensionsForPositionTC.NEXT = 0;

                END;

            end;
        }
        field(9; "Department Category"; Code[30])
        {
            Caption = 'Department';
            Editable = true;
            TableRelation = "Department Category temporary".Code WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin

                IF "Department Category" <> '' THEN BEGIN
                    "B-1WithRegions".RESET;
                    "B-1WithRegions".SETFILTER(Code, "Department Category");
                    //"B-1WithRegions".SETFILTER("Org Shema","ORG Shema");
                    IF "B-1WithRegions".FINDFIRST THEN
                        "Department Categ.  Description" := "B-1WithRegions".Description;
                    "Department Type" := "Department Type"::"Department Category";
                    //"Department Idenity":="B-1WithRegions".Identity;

                END
                ELSE
                    "Department Categ.  Description" := '';
                "Department Type" := "Department Type"::"Department Category";

                IF "Department Type" = "Department Type"::"Department Category" THEN BEGIN
                    Belongs := FORMAT(Rec."Department Category") + ' ' + '-' + ' ' + Rec."Department Categ.  Description";
                END;
                "Dimension Code" := 'TC';
                DimensionsForPositionTC.RESET;
                DimensionsForPositionTC.SETFILTER(Sector, '%1', Sector);
                DimensionsForPositionTC.SETFILTER("Sector  Description", '%1', Rec."Sector  Description");
                DimensionsForPositionTC.SETFILTER("Department Category", '%1', Rec."Department Category");
                DimensionsForPositionTC.SETFILTER("Department Categ.  Description", '%1', Rec."Department Categ.  Description");
                DimensionsForPositionTC.SETFILTER("Group Code", '%1', '');
                DimensionsForPositionTC.SETFILTER("Group Description", '%1', '');
                DimensionsForPositionTC.SETFILTER("Team Code", '%1', '');
                DimensionsForPositionTC.SETFILTER("Team Description", '%1', '');
                IF DimensionsForPositionTC.FINDSET THEN
                    REPEAT
                        // Position Code,Dimension Value Code,ORG Shema,Position Description -KEY
                        IF DimensionsForPositionTC1.GET(DimensionsForPositionTC."Position Code", DimensionsForPositionTC."Dimension Value Code", DimensionsForPositionTC."ORG Shema", DimensionsForPositionTC."Position Description") THEN BEGIN
                            DimensionsForPositionTC1.RENAME(DimensionsForPositionTC."Position Code", Rec."Dimension Value Code", DimensionsForPositionTC."ORG Shema", DimensionsForPositionTC."Position Description");
                            DimensionsForPositionTC1.VALIDATE("Dimension  Name", Rec."Dimension  Name");
                            DimensionsForPositionTC1.MODIFY;
                        END;
                    UNTIL DimensionsForPositionTC.NEXT = 0;

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

              comm.CommandText := 'dbo.Department_Update';
              comm.CommandType := 4;
              comm.CommandTimeout := 0;

              {param:=comm.CreateParameter('@OldCode', 200, 1, 30, xRec.Code);
              comm.Parameters.Append(param);
              param:=comm.CreateParameter('@Code', 200, 1, 30, Code);
              comm.Parameters.Append(param);
              param:=comm.CreateParameter('@Description', 200, 1, 100, Description);
              comm.Parameters.Append(param);}
              param:=comm.CreateParameter('@Type', 200, 1, 30, "Department Type");
              comm.Parameters.Append(param);

              param:=comm.CreateParameter('@B_1', 200, 1, 30, Sector);
              comm.Parameters.Append(param);
              param:=comm.CreateParameter('B_1_description', 200, 1, 250, "Sector  Description");
              comm.Parameters.Append(param);
              param:=comm.CreateParameter('@B_1_regions', 200, 1, 30, "Department Category");
              comm.Parameters.Append(param);
              param:=comm.CreateParameter('@B_1_regions_description', 200, 1, 250, "Department Categ.  Description");
              comm.Parameters.Append(param);
              param:=comm.CreateParameter('@stream', 200, 1, 30,"Group Code");
              comm.Parameters.Append(param);
              param:=comm.CreateParameter('@stream_description', 200, 1, 250, "Group Description");
              comm.Parameters.Append(param);
              comm.Execute;
              conn.Close;
              CLEAR(conn);
              CLEAR(comm);
              END;
              END;*/

            end;
        }
        field(10; "Group Code"; Code[30])
        {
            Caption = 'Group';
            Editable = true;
            TableRelation = "Group temporary".Code WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
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
                
                comm.CommandText := 'dbo.Department_Update';
                comm.CommandType := 4;
                comm.CommandTimeout := 0;
                
                {param:=comm.CreateParameter('@OldCode', 200, 1, 30, xRec.Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Code', 200, 1, 30, Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Description', 200, 1, 100, Description);
                comm.Parameters.Append(param);}
                param:=comm.CreateParameter('@Type', 200, 1, 30, "Department Type");
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
                END;*/

            end;
        }
        field(11; "Sector  Description"; Text[200])
        {
            Caption = 'Sector Description';
            Editable = true;
            TableRelation = "Sector temporary".Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin

                OrgStr.SETFILTER(Status, '%1', OrgStr.Status::Preparation);
                IF OrgStr.FINDFIRST THEN BEGIN
                    "ORG Shema" := OrgStr.Code;
                END;
                IF "Sector  Description" <> '' THEN BEGIN
                    "B-1Rec".RESET;
                    "B-1Rec".SETFILTER(Description, '%1', "Sector  Description");
                    IF "B-1Rec".FINDFIRST THEN
                        Sector := "B-1Rec".Code;

                END
                ELSE BEGIN
                    "Sector  Description" := '';
                    Sector := '';
                END;
                DepartmentTempNes.RESET;
                DepartmentTempNes.SETFILTER("Sector  Description", '%1', Rec."Sector  Description");
                DepartmentTempNes.SETFILTER(Sector, '%1', Rec.Sector);
                DepartmentTempNes.SETFILTER("Department Type", '%1', 8);
                IF DepartmentTempNes.FINDFIRST THEN BEGIN
                    Code := DepartmentTempNes.Code;
                    Description := DepartmentTempNes.Description;
                    Sector := DepartmentTempNes.Sector;
                    "Sector  Description" := DepartmentTempNes."Sector  Description";
                    Belongs := FORMAT(Rec.Sector) + ' ' + '-' + ' ' + Rec."Sector  Description";
                    "Dimension Code" := 'TC';

                END
                ELSE BEGIN
                    Code := '';
                    Description := '';
                    Sector := '';
                    "Sector  Description" := '';
                END;
                DimensionsForPositionTC.RESET;
                DimensionsForPositionTC.SETFILTER(Sector, '%1', Rec.Code);
                DimensionsForPositionTC.SETFILTER("Sector  Description", '%1', Rec.Description);
                DimensionsForPositionTC.SETFILTER("Department Category", '%1', '');
                DimensionsForPositionTC.SETFILTER("Department Categ.  Description", '%1', '');
                DimensionsForPositionTC.SETFILTER("Group Code", '%1', '');
                DimensionsForPositionTC.SETFILTER("Group Description", '%1', '');
                DimensionsForPositionTC.SETFILTER("Team Code", '%1', '');
                DimensionsForPositionTC.SETFILTER("Team Description", '%1', '');
                IF DimensionsForPositionTC.FINDSET THEN
                    REPEAT
                        // Position Code,Dimension Value Code,ORG Shema,Position Description -KEY
                        IF DimensionsForPositionTC1.GET(DimensionsForPositionTC."Position Code", DimensionsForPositionTC."Dimension Value Code", DimensionsForPositionTC."ORG Shema", DimensionsForPositionTC."Position Description") THEN BEGIN
                            DimensionsForPositionTC1.RENAME(DimensionsForPositionTC."Position Code", Rec."Dimension Value Code", DimensionsForPositionTC."ORG Shema", DimensionsForPositionTC."Position Description");
                            DimensionsForPositionTC1.VALIDATE("Dimension  Name", Rec."Dimension  Name");
                            DimensionsForPositionTC1.MODIFY;
                        END;
                    UNTIL DimensionsForPositionTC.NEXT = 0;
            end;
        }
        field(12; "Department Categ.  Description"; Text[85])
        {
            Caption = 'Department (description)';
            Editable = true;
            TableRelation = "Department Category temporary".Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin

                OrgStr.SETFILTER(Status, '%1', OrgStr.Status::Preparation);
                IF OrgStr.FINDFIRST THEN BEGIN
                    "ORG Shema" := OrgStr.Code;
                END;

                IF "Department Categ.  Description" <> '' THEN BEGIN
                    "B-1WithRegions".RESET;
                    "B-1WithRegions".SETFILTER(Description, Rec."Department Categ.  Description");
                    // "B-1WithRegions".SETFILTER("Org Shema","ORG Shema");
                    IF "B-1WithRegions".FINDFIRST THEN
                        "Department Category" := "B-1WithRegions".Code;

                END
                ELSE
                    "Department Category" := '';

                "Department Type" := "Department Type"::"Department Category";
                DepartmentTempNes.RESET;
                DepartmentTempNes.SETFILTER("Department Categ.  Description", '%1', Rec."Department Categ.  Description");
                //DepartmentTempNes.SETFILTER("Department Category",'%1',Rec."Department Category");
                DepartmentTempNes.SETFILTER("Department Type", '%1', 4);
                DepartmentTempNes.SETFILTER("ORG Shema", '%1', "ORG Shema");
                IF DepartmentTempNes.FINDFIRST THEN BEGIN
                    Code := DepartmentTempNes.Code;
                    Description := DepartmentTempNes.Description;
                    Sector := DepartmentTempNes.Sector;
                    "Sector  Description" := DepartmentTempNes."Sector  Description";
                    "Group Code" := DepartmentTempNes."Group Code";
                    "Group Description" := DepartmentTempNes."Group Description";
                    "Team Code" := DepartmentTempNes."Team Code";
                    "Team Description" := DepartmentTempNes."Team Description";
                    Belongs := FORMAT(Rec."Department Category") + ' ' + '-' + ' ' + Rec."Department Categ.  Description";
                    "Dimension Code" := 'TC';
                END
                ELSE BEGIN
                    Code := '';
                    Description := '';
                    Sector := '';
                    "Sector  Description" := '';
                    "Group Code" := '';
                    "Group Description" := '';
                    "Team Code" := '';
                    "Team Description" := '';
                END;
                DimensionsForPositionTC.RESET;
                DimensionsForPositionTC.SETFILTER(Sector, '%1', Sector);
                DimensionsForPositionTC.SETFILTER("Sector  Description", '%1', "Sector  Description");
                DimensionsForPositionTC.SETFILTER("Department Category", '%1', Rec."Department Category");
                DimensionsForPositionTC.SETFILTER("Department Categ.  Description", '%1', Rec."Department Categ.  Description");
                DimensionsForPositionTC.SETFILTER("Group Code", '%1', '');
                DimensionsForPositionTC.SETFILTER("Group Description", '%1', '');
                DimensionsForPositionTC.SETFILTER("Team Code", '%1', '');
                DimensionsForPositionTC.SETFILTER("Team Description", '%1', '');
                IF DimensionsForPositionTC.FINDSET THEN
                    REPEAT
                        // Position Code,Dimension Value Code,ORG Shema,Position Description -KEY
                        IF DimensionsForPositionTC1.GET(DimensionsForPositionTC."Position Code", DimensionsForPositionTC."Dimension Value Code", DimensionsForPositionTC."ORG Shema", DimensionsForPositionTC."Position Description") THEN BEGIN
                            DimensionsForPositionTC1.RENAME(DimensionsForPositionTC."Position Code", Rec."Dimension Value Code", DimensionsForPositionTC."ORG Shema", DimensionsForPositionTC."Position Description");
                            DimensionsForPositionTC1.VALIDATE("Dimension  Name", Rec."Dimension  Name");
                            DimensionsForPositionTC1.MODIFY;
                        END;
                    UNTIL DimensionsForPositionTC.NEXT = 0;
            end;
        }
        field(13; "Group Description"; Text[85])
        {
            Caption = 'Group Description';
            Editable = true;
            TableRelation = "Group temporary".Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                OrgStr.SETFILTER(Status, '%1', OrgStr.Status::Preparation);
                IF OrgStr.FINDFIRST THEN BEGIN
                    "ORG Shema" := OrgStr.Code;
                END;

                IF "Group Description" <> '' THEN BEGIN
                    StreamRec.RESET;
                    StreamRec.SETFILTER(Description, '%1', "Group Description");
                    // "B-1WithRegions".SETFILTER("Org Shema","ORG Shema");
                    IF StreamRec.FINDFIRST THEN
                        "Group Code" := StreamRec.Code;

                END
                ELSE
                    "Group Description" := '';
                "Department Type" := "Department Type"::Group;
                DepartmentTempNes.RESET;
                DepartmentTempNes.SETFILTER("Group Description", '%1', Rec."Group Description");
                DepartmentTempNes.SETFILTER("Group Code", '%1', Rec."Group Code");
                DepartmentTempNes.SETFILTER("Department Type", '%1', 2);
                IF DepartmentTempNes.FINDFIRST THEN BEGIN
                    Code := DepartmentTempNes.Code;
                    Description := DepartmentTempNes.Description;
                    Sector := DepartmentTempNes.Sector;
                    "Sector  Description" := DepartmentTempNes."Sector  Description";
                    "Group Code" := Rec."Group Code";
                    "Group Description" := Rec."Group Description";
                    "Department Category" := DepartmentTempNes."Department Category";
                    "Department Categ.  Description" := DepartmentTempNes."Department Categ.  Description";
                    Belongs := FORMAT(Rec."Group Code") + ' ' + '-' + ' ' + Rec."Group Description";
                    "Dimension Code" := 'TC';


                END
                ELSE BEGIN
                    Code := '';
                    Description := '';
                    Sector := '';
                    "Sector  Description" := '';
                    "Group Code" := '';
                    "Group Description" := '';
                END;
                DimensionsForPositionTC.RESET;
                DimensionsForPositionTC.SETFILTER(Sector, '%1', Sector);
                DimensionsForPositionTC.SETFILTER("Sector  Description", '%1', "Sector  Description");
                DimensionsForPositionTC.SETFILTER("Department Category", '%1', "Department Category");
                DimensionsForPositionTC.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
                DimensionsForPositionTC.SETFILTER("Group Code", '%1', Rec."Group Code");
                DimensionsForPositionTC.SETFILTER("Group Description", '%1', Rec."Group Description");
                DimensionsForPositionTC.SETFILTER("Team Code", '%1', '');
                DimensionsForPositionTC.SETFILTER("Team Description", '%1', '');
                IF DimensionsForPositionTC.FINDSET THEN
                    REPEAT
                        // Position Code,Dimension Value Code,ORG Shema,Position Description -KEY
                        IF DimensionsForPositionTC1.GET(DimensionsForPositionTC."Position Code", DimensionsForPositionTC."Dimension Value Code", DimensionsForPositionTC."ORG Shema", DimensionsForPositionTC."Position Description") THEN BEGIN
                            DimensionsForPositionTC1.RENAME(DimensionsForPositionTC."Position Code", Rec."Dimension Value Code", DimensionsForPositionTC."ORG Shema", DimensionsForPositionTC."Position Description");
                            DimensionsForPositionTC1.VALIDATE("Dimension  Name", Rec."Dimension  Name");
                            DimensionsForPositionTC1.MODIFY;
                        END;
                    UNTIL DimensionsForPositionTC.NEXT = 0;
            end;
        }
        field(21; "Department Type"; enum "Department Type")
        {
            Caption = 'Department Type';

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
            TableRelation = "Dimension Value".Code WHERE(Status = CONST(A));

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDimValue("Dimension Code","Dimension Value Code") THEN
                  ERROR(DimMgt.GetDimErr);*/
                /* IF "Dimension Value Code"<>''then BEGIN
                 "Dimension Code":='TC'*/

                DimensionValueTable.RESET;
                DimensionValueTable.SETFILTER(Code, '%1', Rec."Dimension Value Code");
                IF DimensionValueTable.FINDFIRST THEN
                    "Dimension  Name" := DimensionValueTable.Name
                else
                    "Dimension  Name" := '';
                Validate("Dimension  Name", rec."Dimension  Name");


            end;
        }
        field(41; "Dimension  Name"; Text[250])
        {
            Caption = 'Dimension Code';
            Editable = true;
            FieldClass = Normal;
            TableRelation = "Dimension Value".Name WHERE(Status = CONST(A));

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDim("Dimension Code") THEN
                  ERROR(DimMgt.GetDimErr);*/
                IF "Dimension  Name" <> '' THEN BEGIN
                    DimensionValueTable.RESET;
                    DimensionValueTable.SETFILTER(Name, '%1', Rec."Dimension  Name");
                    IF DimensionValueTable.FINDFIRST THEN BEGIN
                        "Dimension Value Code" := DimensionValueTable.Code;
                    END
                    ELSE BEGIN
                        "Dimension Value Code" := '';
                    END;
                END;
                DimensionForPosition.RESET;
                DimensionForPosition.SETFILTER(Sector, '%1', Sector);
                DimensionForPosition.SETFILTER("Sector  Description", '%1', "Sector  Description");
                DimensionForPosition.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
                DimensionForPosition.SETFILTER("Department Category", '%1', "Department Category");
                DimensionForPosition.SETFILTER("Group Code", '%1', "Group Code");
                DimensionForPosition.SETFILTER("Group Description", '%1', "Group Description");
                DimensionForPosition.SETFILTER("Team Code", '%1', "Team Code");
                DimensionForPosition.SETFILTER("Team Description", '%1', "Team Description");
                IF DimensionForPosition.FINDSET THEN
                    REPEAT
                        DimensionValueTable.RESET;
                        DimensionValueTable.SETFILTER(Name, '%1', Rec."Dimension  Name");
                        IF DimensionValueTable.FINDFIRST THEN BEGIN
                            IF DimensionForPosition1.GET(DimensionForPosition."Position Code", DimensionForPosition."Dimension Value Code", Rec."ORG Shema", DimensionForPosition."Position Description", DimensionForPosition."Org Belongs") THEN BEGIN
                                DimensionForPosition1.RENAME(DimensionForPosition."Position Code", DimensionValueTable.Code, Rec."ORG Shema", DimensionForPosition."Position Description", DimensionForPosition."Org Belongs");
                                DimensionForPosition1."Dimension  Name" := Rec."Dimension  Name";
                                DimensionForPosition1.MODIFY;
                            END
                            ELSE BEGIN
                                DimensionForPosition1."Dimension Value Code" := '';
                                DimensionForPosition1."Dimension  Name" := '';
                                DimensionForPosition1.MODIFY;
                            END;
                        END;
                    UNTIL DimensionForPosition.NEXT = 0;

                IF "Department Type" = "Department Type"::Sector THEN BEGIN
                    SectorTempBelong.RESET;
                    SectorTempBelong.SETFILTER(Code, '%1', Rec.Code);
                    IF SectorTempBelong.FINDSET THEN
                        REPEAT
                            SectorTempBelong.CALCFIELDS("Number of dimension value");
                            IF SectorTempBelong."Number of dimension value" = 0 THEN BEGIN
                                SectorTempBelong1 := SectorTempBelong;
                                SectorTempBelong1."Name of TC" := Rec."Dimension Value Code" + ' ' + '-' + ' ' + Rec."Dimension  Name";
                                SectorTempBelong1.MODIFY;
                            END
                            ELSE BEGIN
                                SectorTempBelong1 := SectorTempBelong;
                                SectorTempBelong1."Name of TC" := '';
                                SectorTempBelong1.MODIFY;
                            END;

                        UNTIL SectorTempBelong.NEXT = 0;
                END;
                /*  IF "Department Type"=4 THEN BEGIN
                  DepTempBelong.RESET;
                  DepTempBelong.SETFILTER(Code,'%1',Rec.Code);
                  IF DepTempBelong.FINDSET THEN REPEAT
                  IF DepTempBelong."Number of dimension value"=0 THEN BEGIN
                  DepTempBelong1:=DepTempBelong;
                  DepTempBelong1."Name of TC":=Rec."Dimension Value Code"+' '+'-'+' '+Rec."Dimension  Name";
                  DepTempBelong1.MODIFY;
                  END
                  ELSE BEGIN
                  DepTempBelong1:=DepTempBelong;
                   DepTempBelong1."Name of TC":='';
                  DepTempBelong1.MODIFY;
                  END;
                    UNTIL DepTempBelong.NEXT=0;
                    END;
                     IF "Department Type"=2 THEN BEGIN
                     GroupTempBelong.RESET;
                 GroupTempBelong.SETFILTER(Description,'%1',Rec.Description);
                  IF GroupTempBelong.FINDSET THEN REPEAT
                  IF GroupTempBelong."Number of dimension value"=0 THEN BEGIN
                  GroupTempBelong1:=GroupTempBelong;
                  GroupTempBelong1."Name of TC":=Rec."Dimension Value Code"+' '+'-'+' '+Rec."Dimension  Name";
                  GroupTempBelong1.MODIFY;
                  END
                  ELSE BEGIN
                  GroupTempBelong1:=GroupTempBelong;
                  GroupTempBelong1."Name of TC":='';
                  GroupTempBelong1.MODIFY;
                  END;
                    UNTIL GroupTempBelong.NEXT=0;
                    END;
                    IF "Department Type"=9 THEN BEGIN
                    TeamTempBelong.RESET;
                     TeamTempBelong.SETFILTER(Name,'%1',Rec.Description);
                  IF TeamTempBelong.FINDSET THEN REPEAT
                  IF TeamTempBelong."Number of dimension value"=0 THEN BEGIN
                  TeamTempBelong1:=TeamTempBelong;
                  TeamTempBelong1."Name of TC":=Rec."Dimension Value Code"+' '+'-'+' '+Rec."Dimension  Name";
                  TeamTempBelong1.MODIFY;
                  END
                  ELSE BEGIN
                   TeamTempBelong1:=TeamTempBelong;
                   TeamTempBelong1."Name of TC":='';
                  TeamTempBelong1.MODIFY;
                  END;
                    UNTIL TeamTempBelong.NEXT=0;
                    END;
                    */
                //Position Code,Dimension Value Code,ORG Shema,Position Description

            end;
        }
        field(43; "Team Code"; Code[30])
        {
            Caption = 'Team';
            TableRelation = "Team temporary".Code WHERE("Org Shema" = FIELD("ORG Shema"));
        }
        field(44; "Team Description"; Text[100])
        {
            Caption = 'Team Description';
            Editable = true;
            TableRelation = "Team temporary".Name WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                OrgStr.SETFILTER(Status, '%1', OrgStr.Status::Preparation);
                IF OrgStr.FINDFIRST THEN BEGIN
                    "ORG Shema" := OrgStr.Code;
                END;

                IF "Team Description" <> '' THEN BEGIN
                    TeamRec.RESET;
                    TeamRec.SETFILTER(Name, '%1', "Team Description");
                    // "B-1WithRegions".SETFILTER("Org Shema","ORG Shema");
                    IF TeamRec.FINDFIRST THEN BEGIN

                        Department1.RESET;
                        Department1.SETFILTER("Team Description", '%1', "Team Description");
                        Department1.SETFILTER("ORG Shema", '%1', "ORG Shema");
                        IF Department1.FINDSET THEN BEGIN
                            Duplicate := Department1.COUNT;
                            IF Duplicate = 2 THEN BEGIN
                                Number := 1;
                                Orginal := STRLEN("Team Description");
                                Department2.SETFILTER("Team Description", '%1', "Team Description");
                                Department2.SETFILTER("ORG Shema", '%1', "ORG Shema");
                                IF Department2.FINDSET THEN
                                    REPEAT
                                        IF Number = 1 THEN
                                            Duzina1 := STRLEN(Department2."Team Description");
                                        IF Number = 2 THEN
                                            Duzina2 := STRLEN(Department2."Team Description");
                                        Number := Number + 1;
                                    UNTIL Department2.NEXT = 0;
                                IF Orginal = Duzina1 THEN BEGIN
                                    Department.RESET;
                                    Department.SETFILTER("Team Description", '%1', "Team Description");
                                    Department.SETFILTER("ORG Shema", '%1', "ORG Shema");
                                    Department.SETFILTER("Entity of Agency", '%1', 2);
                                    IF Department.FIND('-') THEN BEGIN
                                        "Team Description" := Department."Team Description";

                                    END;

                                END;
                                IF Orginal = Duzina2 THEN BEGIN
                                    Department.RESET;
                                    Department.SETFILTER("Team Description", '%1', "Team Description");
                                    Department.SETFILTER("ORG Shema", '%1', "ORG Shema");
                                    Department.SETFILTER("Entity of Agency", '%1', 1);
                                    IF Department.FIND('-') THEN BEGIN
                                        "Team Description" := Department."Team Description";

                                    END;

                                END;
                            END;
                        END;


                    END;



                    TeamRec.RESET;
                    TeamRec.SETFILTER(Name, '%1', "Team Description");
                    TeamRec.SETFILTER("Entity Code", '%1', Department."Entity of Agency");
                    // "B-1WithRegions".SETFILTER("Org Shema","ORG Shema");
                    IF TeamRec.FINDFIRST THEN
                        "Team Code" := TeamRec.Code;

                END
                ELSE
                    "Team Description" := '';
                //ĐK  "Department Type".AsInteger() := 9;
                DepartmentTempNes.RESET;
                DepartmentTempNes.SETFILTER("Team Description", '%1', Rec."Team Description");
                DepartmentTempNes.SETFILTER("Team Code", '%1', Rec."Team Code");
                DepartmentTempNes.SETFILTER("Department Type", '%1', 9);
                IF DepartmentTempNes.FINDFIRST THEN BEGIN
                    Code := DepartmentTempNes.Code;
                    Description := DepartmentTempNes.Description;
                    Sector := DepartmentTempNes.Sector;
                    "Sector  Description" := DepartmentTempNes."Sector  Description";
                    "Group Code" := DepartmentTempNes."Group Code";
                    "Group Description" := DepartmentTempNes."Group Description";
                    "Department Category" := DepartmentTempNes."Department Category";
                    "Department Categ.  Description" := DepartmentTempNes."Department Categ.  Description";
                    "Team Code" := DepartmentTempNes."Team Code";
                    "Team Description" := DepartmentTempNes."Team Description";
                    Belongs := FORMAT(Rec."Team Code") + ' ' + '-' + ' ' + Rec."Team Description";
                    "Dimension Code" := 'TC';

                END
                ELSE BEGIN
                    Code := '';
                    Description := '';
                    Sector := '';
                    "Sector  Description" := '';
                    "Group Code" := '';
                    "Group Description" := '';
                    "Team Code" := '';
                    "Team Description" := '';
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
        field(50005; Belongs; Text[200])
        {
            Caption = 'belong';

            trigger OnValidate()
            begin
                IF "Department Type" = "Department Type"::"Department Category"
                  THEN
                    Belongs := FORMAT(Rec."Department Category") + ' ' + '-' + ' ' + Rec."Department Categ.  Description";
                IF "Department Type" = "Department Type"::Group
                THEN
                    Belongs := FORMAT(Rec."Group Code") + ' ' + '-' + ' ' + Rec."Group Description";
                IF "Department Type".AsInteger() = 9
                  THEN
                    Belongs := FORMAT(Rec."Team Code") + ' ' + '-' + ' ' + Rec."Team Description";
                IF "Department Type" = "Department Type"::Sector
                THEN
                    Belongs := FORMAT(Rec.Sector) + ' ' + '-' + ' ' + Rec."Sector  Description";
            end;
        }
    }

    keys
    {
        key(Key1; "Code", "Dimension Value Code", "Team Description", "Department Categ.  Description", "Group Description", "Group Code", "ORG Shema")
        {
        }
        key(Key2; "Dimension Value Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, Sector, "Department Category", "Group Code", "Sector  Description", "Department Categ.  Description", "Group Description", "Team Code", "Team Description")
        {
        }
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
        FindSector.RESET;
        FindSector.SETFILTER(Code, '%1', Rec.Sector);
        FindSector.SETFILTER(Description, '%1', Rec.Description);
        IF FindSector.FINDFIRST THEN BEGIN
            FindSector.CALCFIELDS("Number of dimension value");
            IF (FindSector."Number of dimension value" >= 2) OR (FindSector."Number of dimension value" = 0) THEN BEGIN
                FindSector."Name of TC" := '';
                FindSector.MODIFY;
            END
            ELSE BEGIN
                DimensionsTempTabela.RESET;
                DimensionsTempTabela.SETFILTER(Code, '%1', Rec.Sector);
                DimensionsTempTabela.SETFILTER(Description, '%1', Rec.Description);
                DimensionsTempTabela.SETFILTER("Dimension Value Code", '<>%1', Rec."Dimension Value Code");
                IF DimensionsTempTabela.FINDFIRST THEN BEGIN
                    FindSector."Name of TC" := DimensionsTempTabela."Dimension Value Code" + ' ' + '-' + ' ' + DimensionsTempTabela."Dimension  Name";
                    FindSector.MODIFY;
                END;
            END;
        END;

        FindOdjel.RESET;
        FindOdjel.SETFILTER(Code, '%1', Rec."Department Category");
        FindOdjel.SETFILTER(Description, '%1', Rec."Department Categ.  Description");
        IF FindOdjel.FINDFIRST THEN BEGIN
            FindOdjel.CALCFIELDS("Number of dimension value");
            IF (FindOdjel."Number of dimension value" >= 2) OR (FindOdjel."Number of dimension value" = 0) THEN BEGIN
                FindOdjel."Name of TC" := '';
                FindOdjel.MODIFY;
            END
            ELSE BEGIN
                DimensionsTempTabela.RESET;
                DimensionsTempTabela.SETFILTER(Code, '%1', Rec."Department Category");
                DimensionsTempTabela.SETFILTER(Description, '%1', Rec."Department Categ.  Description");
                DimensionsTempTabela.SETFILTER("Dimension Value Code", '<>%1', Rec."Dimension Value Code");
                IF DimensionsTempTabela.FINDFIRST THEN BEGIN
                    FindOdjel."Name of TC" := DimensionsTempTabela."Dimension Value Code" + ' ' + '-' + ' ' + DimensionsTempTabela."Dimension  Name";
                    FindOdjel.MODIFY;
                END;
            END;
        END;

        FindGroup.RESET;
        FindGroup.SETFILTER(Code, '%1', Rec."Group Code");
        FindGroup.SETFILTER(Description, '%1', Rec."Group Description");
        IF FindGroup.FINDFIRST THEN BEGIN
            FindGroup.CALCFIELDS("Number of dimension value");
            IF (FindGroup."Number of dimension value" >= 2) OR (FindGroup."Number of dimension value" = 0) THEN BEGIN
                FindGroup."Name of TC" := '';
                FindGroup.MODIFY;
            END
            ELSE BEGIN
                DimensionsTempTabela.RESET;
                DimensionsTempTabela.SETFILTER(Code, '%1', Rec."Group Code");
                DimensionsTempTabela.SETFILTER(Description, '%1', Rec."Group Description");
                DimensionsTempTabela.SETFILTER("Dimension Value Code", '<>%1', Rec."Dimension Value Code");
                IF DimensionsTempTabela.FINDFIRST THEN BEGIN
                    FindGroup."Name of TC" := DimensionsTempTabela."Dimension Value Code" + ' ' + '-' + ' ' + DimensionsTempTabela."Dimension  Name";
                    FindGroup.MODIFY;
                END;
            END;
        END;
        FindTeam.RESET;
        FindTeam.SETFILTER(Code, '%1', Rec."Team Code");
        FindTeam.SETFILTER(Name, '%1', Rec."Team Description");
        IF FindTeam.FINDFIRST THEN BEGIN
            FindTeam.CALCFIELDS("Number of dimension value");
            IF (FindTeam."Number of dimension value" >= 2) OR (FindTeam."Number of dimension value" = 0) THEN BEGIN
                FindTeam."Name of TC" := '';
                FindTeam.MODIFY;
            END
            ELSE BEGIN
                DimensionsTempTabela.RESET;
                DimensionsTempTabela.SETFILTER(Code, '%1', Rec."Team Code");
                DimensionsTempTabela.SETFILTER(Description, '%1', Rec."Team Description");
                DimensionsTempTabela.SETFILTER("Dimension Value Code", '<>%1', Rec."Dimension Value Code");
                IF DimensionsTempTabela.FINDFIRST THEN BEGIN
                    FindTeam."Name of TC" := DimensionsTempTabela."Dimension Value Code" + ' ' + '-' + ' ' + DimensionsTempTabela."Dimension  Name";
                    FindTeam.MODIFY;
                END;
            END;
        END;

    end;

    trigger OnInsert()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);


        /*OrgStr.SETFILTER(Status,'%1',OrgStr.Status::Preparation);
        IF OrgStr.FINDFIRST THEN
          BEGIN
            "ORG Shema":=OrgStr.Code;
          END;
          IF COMPANYNAME='SB' THEN BEGIN*/


        /* OS.SETFILTER(Code,'%1',"ORG Shema");
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
        FindSector.RESET;
        FindSector.SETFILTER(Code, '%1', Rec.Sector);
        FindSector.SETFILTER(Description, '%1', Rec.Description);
        IF FindSector.FINDFIRST THEN BEGIN
            FindSector."Name of TC" := Rec."Dimension Code" + ' ' + '-' + ' ' + Rec."Dimension  Name";
            FindSector.MODIFY;
        END;
    end;

    var
        WPConnSetup: Record "Web portal connection setup";
        /*conn: Automation;
        comm: Automation;
        param: Automation;*/
        lvarActiveConnection: Variant;
        "B-1Rec": Record "Sector temporary";
        "B-1WithRegions": Record "Department Category temporary";
        StreamRec: Record "Group temporary";
        Employee: Record "Employee";
        WC: Record "Wage Calculation";
        ECL: Record "Employee Contract Ledger";
        Department: Record "Department temporary";
        Emp: Record "Employee";
        /*connAdm2: Automation;
        commAdm2: Automation;
        paramAdm2: Automation;*/
        lvarActiveConnectionAdm2: Variant;
        //   Position: Record "Confidential Clerks";
        //   Position2: Record "Confidential Clerks";
        OS: Record "ORG Shema";
        TeamRec: Record "Team temporary";
        LengthCode: Integer;
        //    Tip: Record "Type";
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
        DimensionForPosition: Record "Dimension temp for position";
        DimensionForPosition1: Record "Dimension temp for position";
        DimensionsForPositionTC: Record "Dimension temp for position";
        DimensionsForPositionTC1: Record "Dimension temp for position";
        FindOdjel: Record "Department Category temporary";
        DimensionsTempTabela: Record "Dimension temporary";
        SectorTempBelong1: Record "Sector temporary";
        DepTempBelong: Record "Department Category temporary";
        DepTempBelong1: Record "Department Category temporary";
        SectorTempBelong: Record "Sector temporary";
        GroupTempBelong: Record "Group temporary";
        GroupTempBelong1: Record "Group temporary";
        TeamTempBelong: Record "Team temporary";
        TeamTempBelong1: Record "Team temporary";
        FindGroup: Record "Group temporary";
        FindTeam: Record "Team temporary";
        Department1: Record "Department temporary";
        Duplicate: Integer;
        Department2: Record "Department temporary";
        Duzina1: Integer;
        Duzina2: Integer;
        Number: Integer;
        Orginal: Integer;
}

