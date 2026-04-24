table 50163 "Dimension temp for position"
{
    Caption = 'Dimension temporary';
    //  DrillDownPageID = "Dimensions temp for positions";
    //LookupPageID = "Dimensions temp for positions";

    fields
    {
        field(1; "Position Code"; Code[20])
        {
            Caption = 'Code';

            trigger OnValidate()
            begin

                OrgStr.SETFILTER(Status, '%1', OrgStr.Status::Preparation);
                IF OrgStr.FINDFIRST THEN BEGIN
                    "ORG Shema" := OrgStr.Code;
                END;
                "Dimension Code" := 'TC';

                Belongs := Rec."Position Code" + ' ' + '-' + ' ' + Rec."Position Description";
                Brojac1 := 0;
                StringValue := Rec."Position Code";
                FOR I := 1 TO STRLEN(StringValue) DO BEGIN
                    IF StringValue[I] = '.' THEN BEGIN
                        Brojac1 := Brojac1 + 1;
                        IF Brojac1 = 2 THEN BEGIN
                            SectorPosition := I;
                            IF StringValue[I - 1] = '0' THEN
                                SectorPosition := I - 2;
                        END;
                    END;
                END;
                SectorIdentity.RESET;
                SectorIdentity.SETFILTER(Code, '%1', COPYSTR(Rec."Position Code", 1, SectorPosition));
                IF SectorIdentity.FINDFIRST THEN BEGIN
                    "Sector Identity" := SectorIdentity.Identity;
                END;

                /*
                 String1:=FORMAT(Rec.Code);
                         LengthString:=STRLEN(String1);
                         Brojac:=0;
                         FOR I:=1 TO LengthString DO BEGIN
                         IF String1[I]='.'THEN BEGIN
                            Brojac:=Brojac+1;
                
                                                IF Brojac=2 THEN BEGIN
                                                  "Department Type":=8;
                                                  END;
                                                     IF Brojac=3 THEN BEGIN
                                                  "Department Type":=4;
                                                  END;
                                                    IF Brojac=4 THEN BEGIN
                                                  "Department Type":=2;
                                                  END;
                                                  IF Brojac=5 THEN BEGIN
                                                  "Department Type":=9;
                                                  END;
                                                  IF Brojac=1 THEN BEGIN
                                                  "Department Type":=8;
                                                  END;
                                         END;
                                                     END;
                
                
                IF "Department Type"=8 THEN BEGIN
                Belongs:=FORMAT(Rec.Sector)+' '+'-'+' '+Rec."Sector  Description";
                
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
                DepartmentTempNes.SETFILTER("Sector  Description",'%1',"Sector  Description");
                DepartmentTempNes.SETFILTER("Department Type",'%1',8);
                IF DepartmentTempNes.FINDFIRST THEN BEGIN
                  Code:=DepartmentTempNes.Code;
                  Description:=DepartmentTempNes.Description;
                  Sector:=DepartmentTempNes.Sector;
                  "Sector  Description":=DepartmentTempNes."Sector  Description";
                   Belongs:=FORMAT(Rec.Code)+' '+'-'+' '+Rec.Description;
                   "Dimension Code":='TC';
                
                  END
                  ELSE BEGIN
                    Code:='';
                  Description:='';
                  Sector:='';
                  "Sector  Description":='';
                
                  END;
                END;
                
                {
                IF "Department Type"=4 THEN BEGIN
                  DepartmentTabela.RESET;
                  DepartmentTabela.SETFILTER("Department Type",'%1',4);
                  DepartmentTabela.SETFILTER("Department Categ.  Description",'%1',Rec."Department Categ.  Description");
                  IF DepartmentTabela.FINDFIRST THEN BEGIN
                   Code:=DepartmentTabela.Code;
                    Description:=DepartmentTabela.Description;
                    "Department Category":=Rec.Code;
                    "Department Categ.  Description":=Rec."Department Categ.  Description";
                    Sector:=DepartmentTabela.Sector;
                    "Sector  Description":=DepartmentTabela."Sector  Description";
                    END
                    ELSE BEGIN
                      Code:='';
                    Description:='';
                    "Department Category":='';
                    "Department Categ.  Description":='';
                    Sector:=DepartmentTabela.Sector;
                    "Sector  Description":=DepartmentTabela."Sector  Description";
                    END;
                      END;
                
                
                
                {Sec.RESET;
                DepCat.RESET;
                IF LengthCode=6 THEN BEGIN
                  "Department Type":=4;
                 // Sec.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                  Sec.SETFILTER (Code,'%1',COPYSTR(Code,1,4));
                     IF Sec.FIND('-') THEN BEGIN
                       Sector:=COPYSTR(Code,1,4);//sector short code kopira polje to code
                       "Sector  Description":=Sec.Description;
                
                         IF  ((COPYSTR(Code,1,6)<>'D.2.5.') ) THEN BEGIN
                                IF  ((COPYSTR(Code,1,6)<>'E.1.X.') ) THEN BEGIN
                        // DepCat.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                         DepCat.SETFILTER(Code,'%1',COPYSTR(Code,1,6));
                         IF DepCat.FIND('-') THEN BEGIN
                         "Department Category":=COPYSTR(Code,1,6);
                           "Department Categ.  Description":=DepCat.Description;
                           Description:=DepCat.Description;
                             END
                             ELSE BEGIN
                                "Department Category":='';
                           "Department Categ.  Description":='';
                               END;
                END;
                           END;
                
                     END
                      ELSE BEGIN
                       Sector:='';
                       "Sector  Description":='';
                       "Department Categ.  Description":='';
                       Description:='';
                
                       END;
                END ;}
                
                IF "Department Type"=4 THEN BEGIN
                 DepartmentTempTry1.RESET;
                DepartmentTempTry1.SETFILTER(Code,'%1',Rec.Code);
                 DepartmentTempTry1.SETFILTER("Department Categ.  Description",'%1',Rec."Department Categ.  Description");
                 DepartmentTempTry1.SETFILTER("Department Type",'%1',4);
                 IF DepartmentTempTry1.FINDFIRST THEN BEGIN
                 Sector:=DepartmentTempTry1.Sector;
                 "Department Category":=DepartmentTempTry1."Department Category";
                
                    "Department Categ.  Description":=DepartmentTempTry1."Department Categ.  Description";
                    "Sector  Description":=DepartmentTempTry1."Sector  Description";
                    Description:=DepartmentTempTry1.Description;
                    END;
                    END;
                
                
                
                Sec.RESET;
                DepCat.RESET;
                GR.RESET;
                IF "Department Type"=2 THEN BEGIN
                  "Department Type":=2;
                 // Sec.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                  Sec.SETFILTER (Code,'%1',COPYSTR(Code,1,4));
                     IF Sec.FIND('-') THEN BEGIN
                       Sector:=COPYSTR(Code,1,4);//sector short code kopira polje to code
                       "Sector  Description":=Sec.Description;
                   DepartmentTempTry1.RESET;
                DepartmentTempTry1.SETFILTER(Code,'%1',Rec.Code);
                 DepartmentTempTry1.SETFILTER("Group Description",'%1',Rec."Group Description");
                 IF DepartmentTempTry1.FINDFIRST THEN BEGIN
                 "Department Categ.  Description":=DepartmentTempTry1."Department Categ.  Description";
                  "Department Category":=DepartmentTempTry1."Department Category";
                
                IF "Department Categ.  Description"<>DepartmentTempTry1.Description THEN BEGIN
                Description:='Glavna filijala';
                END;
                 END;
                         IF  ((COPYSTR(Code,1,8)<>'D.2.5.1.') ) THEN BEGIN
                
                       //  DepCat.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                         DepCat.SETFILTER(Code,'%1',COPYSTR(Code,1,6));
                         IF DepCat.FIND('-') THEN BEGIN
                         "Department Category":=COPYSTR(Code,1,6);
                           "Department Categ.  Description":=DepCat.Description;
                             END
                             ELSE BEGIN
                                "Department Category":='';
                           "Department Categ.  Description":='';
                
                END;
                
                        // GR.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                         GR.SETFILTER(Code,'%1',COPYSTR(Code,1,8));
                         IF GR.FIND('-') THEN BEGIN
                         "Group Code":=COPYSTR(Code,1,8);
                           "Group Description":=GR.Description;
                           Description:=GR.Description;
                             END
                             ELSE BEGIN
                                "Group Code":='';
                              "Group Description":='';
                              Description:='';
                
                END;
                
                
                           END;
                
                     END
                      ELSE BEGIN
                       Sector:='';
                       "Sector  Description":='';
                       "Department Categ.  Description":='';
                
                       END;END;
                
                
                
                Sec.RESET;
                DepCat.RESET;
                GR.RESET;
                TEAM.RESET;
                IF "Department Type"=9 THEN BEGIN
                  "Department Type":=9;
                 // Sec.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                  Sec.SETFILTER (Code,'%1',COPYSTR(Code,1,4));
                     IF Sec.FIND('-') THEN BEGIN
                       Sector:=COPYSTR(Code,1,4);//sector short code kopira polje to code
                       "Sector  Description":=Sec.Description;
                
                         IF  ((COPYSTR(Code,1,8)<>'D.2.5.1.') ) THEN BEGIN
                
                        // DepCat.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                         DepCat.SETFILTER(Code,'%1',COPYSTR(Code,1,6));
                         IF DepCat.FIND('-') THEN BEGIN
                         "Department Category":=COPYSTR(Code,1,6);
                           "Department Categ.  Description":=DepCat.Description;
                             END
                             ELSE BEGIN
                                "Department Category":='';
                           "Department Categ.  Description":='';
                
                END;
                
                
                
                
                
                
                        // GR.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                         GR.SETFILTER(Code,'%1',COPYSTR(Code,1,8));
                         IF GR.FIND('-') THEN BEGIN
                         "Group Code":=COPYSTR(Code,1,8);
                           "Group Description":=GR.Description;
                             END
                             ELSE BEGIN
                                "Group Code":='';
                              "Group Description":='';
                
                END;
                
                        //TEAM.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                        TEAM.SETFILTER(Code,'%1',COPYSTR(Code,1,10));
                         IF TEAM.FIND('-') THEN BEGIN
                         "Team Code":=COPYSTR(Code,1,10);
                           "Team Description":=TEAM.Name;
                           Description:=TEAM.Name;
                             END
                             ELSE BEGIN
                                "Team Code":='';
                              "Team Description":='';
                              Description:='';
                
                END;
                           END;
                
                     END
                      ELSE BEGIN
                       Sector:='';
                       "Sector  Description":='';
                       "Department Categ.  Description":='';
                
                       END;END;
                       Sec.RESET;
                DepCat.RESET;
                GR.RESET;
                TEAM.RESET;
                IF "Department Type"=9 THEN BEGIN
                  DepartmentTempTry.SETFILTER(Code,'%1',Rec.Code);
                  DepartmentTempTry.SETFILTER("Team Description",'%1',Rec."Team Description");
                  IF DepartmentTempTry.FINDFIRST THEN BEGIN
                    "Team Code":=Rec.Code;
                    "Team Description":=Rec.Description;
                    "Group Code":=DepartmentTempTry."Group Code";
                    "Group Description":=DepartmentTempTry."Group Description";
                    "Department Category":=DepartmentTempTry."Department Category";
                    "Department Categ.  Description":=DepartmentTempTry."Department Categ.  Description";
                    Sector:=DepartmentTempTry.Sector;
                    "Sector  Description":=DepartmentTempTry."Sector  Description";
                    MODIFY;
                    END
                    ELSE BEGIN
                       "Team Code":='';
                    "Team Description":='';
                    "Group Code":='';
                    "Group Description":='';
                    "Department Category":='';
                    "Department Categ.  Description":='';
                    Sector:='';
                    "Sector  Description":='';
                    END;
                  END;
                
                IF "Department Type"=8 THEN BEGIN
                Belongs:=FORMAT(Rec.Code)+' '+'-'+' '+Rec."Sector  Description";
                END;
                IF "Department Type"=4 THEN BEGIN
                Belongs:=FORMAT(Rec.Code)+' '+'-'+' '+Rec."Department Categ.  Description";
                END;
                //Belongs:=FORMAT(Rec.Code)+' '+'-'+' '+Rec.Description;
                }
                */

            end;
        }
        field(2; "Position Description"; Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                OrgStr.SETFILTER(Status, '%1', OrgStr.Status::Preparation);
                IF OrgStr.FINDFIRST THEN BEGIN
                    "ORG Shema" := OrgStr.Code;
                END;
                Belongs := Rec."Position Code" + ' ' + '-' + ' ' + Rec."Position Description";
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

                /*NewDepartment.SETFILTER(Code,'%1',Rec.Code);
                NewDepartment.SETFILTER(Description,'%1',Rec.Description);
                NewDepartment.SETFILTER("ORG Shema",'%1',"ORG Shema");
                IF NewDepartment.FINDFIRST THEN BEGIN */
                /*IF "Department Type"=4 THEN BEGIN
                  DepartmentCategory.SETFILTER("Org Shema",'%1',"ORG Shema");
                  IF DepartmentCategory.FIND('-') THEN BEGIN
                  DepartmentCategory.INIT;
                  DepartmentCategory.Code:=Rec.Code;
                  DepartmentCategory.Description:=Rec.Description;
                  DepartmentCategory."Org Shema":="ORG Shema";
                  DepartmentCategory.INSERT;
                  END;
                  NewDepartment.SETFILTER(Code,'%1',Rec.Code);
                  NewDepartment.SETFILTER(Description,'%1',Rec.Description);
                  NewDepartment.SETFILTER("ORG Shema",'%1',"ORG Shema");
                  IF NewDepartment.FIND('-') THEN BEGIN
                  "Department Category":=Rec.Code;
                  "Department Categ.  Description":=Rec.Description;
                  END;
                  END;
                  IF "Department Type"=8 THEN BEGIN
                    SectorNew.SETFILTER("Org Shema",'%1',"ORG Shema");
                    IF SectorNew.FIND('-') THEN BEGIN
                      SectorNew.INIT;
                      SectorNew.Code:=Rec.Code;
                      SectorNew.Description:=Rec.Description;
                      SectorNew."Org Shema":="ORG Shema";
                      SectorNew.INSERT;
                      Sector:=Rec.Code;
                     "Sector  Description":=Rec.Description;
                      END;
                      END;
                        IF "Department Type"=2 THEN BEGIN
                        GroupNew.SETFILTER("Org Shema",'%1',"ORG Shema");
                        IF GroupNew.FIND('-') THEN BEGIN
                          GroupNew.INIT;
                          GroupNew.Code:=Rec.Code;
                          GroupNew.Description:=Rec.Description;
                          GroupNew."Org Shema":=Rec."ORG Shema";
                          GroupNew.INSERT;
                          "Group Code":=Rec.Code;
                          "Group Description":=Rec.Description;
                  END;
                  END;
                          IF "Department Type"=9 THEN BEGIN
                            Team1.SETFILTER("Org Shema",'%1',"ORG Shema");
                            IF Team1.FIND('-') THEN BEGIN
                              Team1.INIT;
                              Team1.Code:=Rec.Code;
                              Team1.Description:=Rec.Description;
                              Team1."Org Shema":=Rec."ORG Shema";
                              Team1.INSERT;
                              "Team Code":=Rec.Code;
                              "Team Description":=Rec.Description;
                              END;
                              END;
                               //  END;*/

                /* "Dimension Code":='TC';

              IF "Department Type"=8 THEN BEGIN

                Sec.SETFILTER (Description,'%1',Rec.Description);
                   IF Sec.FIND('-') THEN BEGIN
                     Sector:=Sec.Code;//sector short code kopira polje to code
                     "Sector  Description":=Rec.Description;

                     END
                   ELSE BEGIN
                     Sector:='';
                     "Sector  Description":='';
                     Description:='';

                     END;
              END ;



              {Sec.RESET;
              DepCat.RESET;
              IF LengthCode=6 THEN BEGIN
                "Department Type":=4;
               // Sec.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                Sec.SETFILTER (Code,'%1',COPYSTR(Code,1,4));
                   IF Sec.FIND('-') THEN BEGIN
                     Sector:=COPYSTR(Code,1,4);//sector short code kopira polje to code
                     "Sector  Description":=Sec.Description;

                       IF  ((COPYSTR(Code,1,6)<>'D.2.5.') ) THEN BEGIN
                              IF  ((COPYSTR(Code,1,6)<>'E.1.X.') ) THEN BEGIN
                      // DepCat.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                       DepCat.SETFILTER(Code,'%1',COPYSTR(Code,1,6));
                       IF DepCat.FIND('-') THEN BEGIN
                       "Department Category":=COPYSTR(Code,1,6);
                         "Department Categ.  Description":=DepCat.Description;
                         Description:=DepCat.Description;
                           END
                           ELSE BEGIN
                              "Department Category":='';
                         "Department Categ.  Description":='';
                             END;
              END;
                         END;

                   END
                    ELSE BEGIN
                     Sector:='';
                     "Sector  Description":='';
                     "Department Categ.  Description":='';
                     Description:='';

                     END;
              END ;}

              IF "Department Type"=4   THEN BEGIN
               DepartmentTempTry1.RESET;
               DepartmentTempTry1.SETFILTER("Department Categ.  Description",'%1',Rec.Description);
               DepartmentTempTry1.SETFILTER("Department Type",'%1',4);
               IF DepartmentTempTry1.FINDFIRST THEN BEGIN
               Sector:=DepartmentTempTry1.Sector;
               "Department Category":=DepartmentTempTry1."Department Category";

                  "Department Categ.  Description":=DepartmentTempTry1."Department Categ.  Description";
                  "Sector  Description":=DepartmentTempTry1."Sector  Description";
                  Description:=DepartmentTempTry1.Description;
                  END;
                  END;



              Sec.RESET;
              DepCat.RESET;
              GR.RESET;
              IF "Department Type"=2 THEN BEGIN
                "Department Type":=2;
               // Sec.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                Sec.SETFILTER (Code,'%1',COPYSTR(Code,1,4));
                   IF Sec.FIND('-') THEN BEGIN
                     Sector:=COPYSTR(Code,1,4);//sector short code kopira polje to code
                     "Sector  Description":=Sec.Description;
                 DepartmentTempTry1.RESET;
              DepartmentTempTry1.SETFILTER(Code,'%1',Rec.Code);
               DepartmentTempTry1.SETFILTER("Group Description",'%1',Rec."Group Description");
               IF DepartmentTempTry1.FINDFIRST THEN BEGIN
               "Department Categ.  Description":=DepartmentTempTry1."Department Categ.  Description";
                "Department Category":=DepartmentTempTry1."Department Category";

              IF "Department Categ.  Description"<>DepartmentTempTry1.Description THEN BEGIN
              Description:='Glavna filijala';
              END;
               END;
                       IF  ((COPYSTR(Code,1,8)<>'D.2.5.1.') ) THEN BEGIN

                     //  DepCat.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                       DepCat.SETFILTER(Code,'%1',COPYSTR(Code,1,6));
                       IF DepCat.FIND('-') THEN BEGIN
                       "Department Category":=COPYSTR(Code,1,6);
                         "Department Categ.  Description":=DepCat.Description;
                           END
                           ELSE BEGIN
                              "Department Category":='';
                         "Department Categ.  Description":='';

              END;

                      // GR.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                       GR.SETFILTER(Code,'%1',COPYSTR(Code,1,8));
                       IF GR.FIND('-') THEN BEGIN
                       "Group Code":=COPYSTR(Code,1,8);
                         "Group Description":=GR.Description;
                         Description:=GR.Description;
                           END
                           ELSE BEGIN
                              "Group Code":='';
                            "Group Description":='';
                            Description:='';

              END;


                         END;

                   END
                    ELSE BEGIN
                     Sector:='';
                     "Sector  Description":='';
                     "Department Categ.  Description":='';

                     END;END;



              Sec.RESET;
              DepCat.RESET;
              GR.RESET;
              TEAM.RESET;
              IF "Department Type"=9  THEN BEGIN
                "Department Type":=9;
               // Sec.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                Sec.SETFILTER (Code,'%1',COPYSTR(Code,1,4));
                   IF Sec.FIND('-') THEN BEGIN
                     Sector:=COPYSTR(Code,1,4);//sector short code kopira polje to code
                     "Sector  Description":=Sec.Description;

                       IF  ((COPYSTR(Code,1,8)<>'D.2.5.1.') ) THEN BEGIN

                      // DepCat.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                       DepCat.SETFILTER(Code,'%1',COPYSTR(Code,1,6));
                       IF DepCat.FIND('-') THEN BEGIN
                       "Department Category":=COPYSTR(Code,1,6);
                         "Department Categ.  Description":=DepCat.Description;
                           END
                           ELSE BEGIN
                              "Department Category":='';
                         "Department Categ.  Description":='';

              END;






                      // GR.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                       GR.SETFILTER(Code,'%1',COPYSTR(Code,1,8));
                       IF GR.FIND('-') THEN BEGIN
                       "Group Code":=COPYSTR(Code,1,8);
                         "Group Description":=GR.Description;
                           END
                           ELSE BEGIN
                              "Group Code":='';
                            "Group Description":='';

              END;

                      //TEAM.SETFILTER("Org Shema",'%1',Rec."ORG Shema");
                      TEAM.SETFILTER(Code,'%1',COPYSTR(Code,1,10));
                       IF TEAM.FIND('-') THEN BEGIN
                       "Team Code":=COPYSTR(Code,1,10);
                         "Team Description":=TEAM.Name;
                         Description:=TEAM.Name;
                           END
                           ELSE BEGIN
                              "Team Code":='';
                            "Team Description":='';
                            Description:='';

              END;
                         END;

                   END
                    ELSE BEGIN
                     Sector:='';
                     "Sector  Description":='';
                     "Department Categ.  Description":='';

                     END;END;
                     Sec.RESET;
              DepCat.RESET;
              GR.RESET;
              TEAM.RESET;
              IF "Department Type"=10 THEN BEGIN
                DepartmentTempTry.SETFILTER(Code,'%1',Rec.Code);
                DepartmentTempTry.SETFILTER("Team Description",'%1',Rec."Team Description");
                IF DepartmentTempTry.FINDFIRST THEN BEGIN
                  "Team Code":=Rec.Code;
                  "Team Description":=Rec.Description;
                  "Group Code":=DepartmentTempTry."Group Code";
                  "Group Description":=DepartmentTempTry."Group Description";
                  "Department Category":=DepartmentTempTry."Department Category";
                  "Department Categ.  Description":=DepartmentTempTry."Department Categ.  Description";
                  Sector:=DepartmentTempTry.Sector;
                  "Sector  Description":=DepartmentTempTry."Sector  Description";
                  MODIFY;
                  END
                  ELSE BEGIN
                     "Team Code":='';
                  "Team Description":='';
                  "Group Code":='';
                  "Group Description":='';
                  "Department Category":='';
                  "Department Categ.  Description":='';
                  Sector:='';
                  "Sector  Description":='';
                  END;
                END;

              IF "Department Type"=8 THEN BEGIN
              Belongs:=FORMAT(Rec.Code)+' '+'-'+' '+Rec."Sector  Description";
              END;
              IF "Department Type"=4 THEN BEGIN
              Belongs:=FORMAT(Rec.Code)+' '+'-'+' '+Rec."Department Categ.  Description";
              END;
              IF "Department Type"=9 THEN BEGIN
              Belongs:=FORMAT(Rec.Code)+' '+'-'+' '+Rec."Team Description";
              END;
              //Belongs:=FORMAT(Rec.Code)+' '+'-'+' '+Rec.Description;
              */

            end;
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

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDimValue("Dimension Code","Dimension Value Code") THEN
                  ERROR(DimMgt.GetDimErr);*/
                /* IF "Dimension Value Code"<>''then BEGIN
                 "Dimension Code":='TC'*/
                IF "Dimension Value Code" <> '' THEN BEGIN
                    DimensionValueTable.RESET;
                    DimensionValueTable.SETFILTER(Code, '%1', Rec."Dimension Value Code");
                    IF DimensionValueTable.FINDFIRST THEN BEGIN
                        "Dimension  Name" := DimensionValueTable.Name;
                    END
                    ELSE BEGIN
                        "Dimension  Name" := '';
                    END;
                END;

            end;
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

            trigger OnValidate()
            begin
                /*IF "Department Type"="Department Type"::Department
                  THEN
                  Belongs:=FORMAT(Rec."Department Category")+' '+'-'+' '+Rec."Department Categ.  Description";
                  IF "Department Type"="Department Type"::Group
                  THEN
                  Belongs:=FORMAT(Rec."Group Code")+' '+'-'+' '+Rec."Group Description";
                IF "Department Type"="Department Type"::Team
                  THEN
                  Belongs:=FORMAT(Rec."Team Code")+' '+'-'+' '+Rec."Team Description";
                  IF "Department Type"="Department Type"::Sector
                  THEN
                  Belongs:=FORMAT(Rec.Sector)+' '+'-'+' '+Rec."Sector  Description";*/
                Belongs := Rec."Position Code" + ' ' + '-' + ' ' + Rec."Position Description";

            end;
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
            TableRelation = "Group temporary"."Code" WHERE("Org Shema" = FIELD("ORG Shema"),
                                                          Description = FIELD("Group Description"));
        }
        field(50373; "Sector  Description"; Text[250])
        {
            Caption = 'Sector Description';
            Editable = true;
            TableRelation = "Sector temporary".Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF (("Team Code" = '') AND ("Group Code" = '') AND ("Department Category" = '')) THEN BEGIN
                    Departmenttemp.RESET;
                    Departmenttemp.SETFILTER("Sector  Description", '%1', Rec."Sector  Description");
                    //Departmenttemp.SETFILTER("ORG Shema",'%1',Rec."ORG Shema");
                    Departmenttemp.SETFILTER("Department Type", '%1', 8);

                    IF Departmenttemp.FINDFIRST THEN BEGIN

                        "Sector  Description" := Departmenttemp."Sector  Description";
                        IF "Sector  Description" <> '' THEN BEGIN

                            // VALIDATE("Department Code",Departmenttemp.Sector);
                            Sector := Departmenttemp.Sector;
                            //VALIDATE(Sector,Departmenttemp.Sector);

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


                /*IF (("Team Description"='') AND ("Group Description"='') AND  ("Department Categ.  Description"='')) THEN BEGIN
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
                END;*/

            end;
        }
        field(50374; "Department Categ.  Description"; Text[150])
        {
            Caption = 'Department (description)';
            Editable = true;
            TableRelation = "Department Category temporary".Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF (("Team Code" = '') AND ("Group Code" = '')) THEN BEGIN
                    Departmenttemp.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
                    IF Departmenttemp.FIND('-') THEN BEGIN


                        IF "Department Categ.  Description" <> '' THEN BEGIN

                            //VALIDATE("Department Code",Departmenttemp."Department Category");
                            // VALIDATE("Department Category",Departmenttemp."Department Category");
                            "Department Category" := Departmenttemp."Department Category";
                            Sector := Departmenttemp.Sector;
                            "Sector  Description" := Departmenttemp."Sector  Description";

                            // VALIDATE(Sector,Departmenttemp.Sector);
                            //VALIDATE("Sector  Description",Departmenttemp."Sector  Description");
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


                /*
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
            TableRelation = "Group temporary".Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF "Team Code" = '' THEN BEGIN
                    Departmenttemp.SETFILTER("Group Description", '%1', "Group Description");
                    Departmenttemp.SETFILTER("Department Type", '%1', 2);
                    IF Departmenttemp.FIND('-') THEN BEGIN


                        IF "Group Description" <> '' THEN BEGIN

                            // VALIDATE("Department Code",Departmenttemp."Group Code");
                            /*  VALIDATE("Group Code",Departmenttemp."Group Code");
                              VALIDATE("Department Category",Departmenttemp."Department Category");
                              VALIDATE("Department Categ.  Description",Departmenttemp."Department Categ.  Description");
                              VALIDATE(Sector,Departmenttemp.Sector);
                              VALIDATE("Sector  Description",Departmenttemp."Sector  Description");*/
                            "Group Code" := Departmenttemp."Group Code";
                            Sector := Departmenttemp.Sector;
                            "Sector  Description" := Departmenttemp."Sector  Description";
                            "Department Category" := Departmenttemp."Department Category";
                            "Department Categ.  Description" := Departmenttemp."Department Categ.  Description";
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
                /* SectorR.SETFILTER(Description,'%1',"Sector  Description");
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
            TableRelation = "Team temporary".Code WHERE("Org Shema" = FIELD("ORG Shema"),
                                                         Name = FIELD("Team Description"));
        }
        field(50377; "Team Description"; Text[100])
        {
            Caption = 'Team Description';
            Editable = true;
            TableRelation = "Team temporary".Name WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                Departmenttemp.SETFILTER("Team Description", '%1', "Team Description");
                IF Departmenttemp.FIND('-') THEN BEGIN

                    "Team Description" := Departmenttemp."Team Description";
                    IF "Team Description" <> '' THEN BEGIN
                        /* VALIDATE("Team Code",Departmenttemp."Team Code");
                        // VALIDATE("Department Code",Departmenttemp."Team Code");
                         VALIDATE("Group Code",Departmenttemp."Group Code");
                         VALIDATE("Group Description",Departmenttemp."Group Description");
                         VALIDATE("Department Category",Departmenttemp."Department Category");
                         VALIDATE("Department Categ.  Description",Departmenttemp."Department Categ.  Description");
                         VALIDATE(Sector,Departmenttemp.Sector);
                         VALIDATE("Sector  Description",Departmenttemp."Sector  Description");*/
                        Sector := Departmenttemp.Sector;
                        "Sector  Description" := Departmenttemp."Sector  Description";
                        "Department Category" := Departmenttemp."Department Category";
                        "Department Categ.  Description" := Departmenttemp."Department Categ.  Description";
                        "Group Code" := Departmenttemp."Group Code";
                        "Group Description" := Departmenttemp."Group Description";
                        "Team Code" := Departmenttemp."Team Code";
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


                /*SectorR.SETFILTER(Description,'%1',"Sector  Description");
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
        field(50378; "Org Belongs"; Text[130])
        {
            Caption = 'Org Belongs';
            Editable = true;
            TableRelation = "Department temporary".Description WHERE("Sector Identity" = FIELD("Sector Identity"));

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
                    END;
                END;
                DimensionTempFindTC.RESET;
                DimensionTempFindTC.SETFILTER("Department Type", '%1', DepartmentTempReal."Department Type");
                DimensionTempFindTC.SETFILTER(Description, '%1', "Org Belongs");
                IF DimensionTempFindTC.FINDFIRST THEN BEGIN
                    "Dimension  Name" := DimensionTempFindTC."Dimension  Name";
                    "Dimension Value Code" := DimensionTempFindTC."Dimension Value Code";
                END;
                PositionMenu.RESET;
                PositionMenu.SETFILTER(Code, '%1', "Position Code");
                PositionMenu.SETFILTER(Description, '%1', "Position Description");
                IF PositionMenu.FINDFIRST THEN BEGIN
                    PositionMenu.IsTrue := FALSE;
                    PositionMenu.MODIFY;
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
        /*conn: Automation ;
        comm: Automation ;
        param: Automation ;*/
        lvarActiveConnection: Variant;
        "B-1Rec": Record "Sector temporary";
        "B-1WithRegions": Record "Department Category temporary";
        StreamRec: Record "Group temporary";
        Employee: Record "Employee";
        WC: Record "Wage Calculation";
        ECL: Record "Employee Contract Ledger";
        Department: Record "Department";
        Emp: Record "Employee";
        /*connAdm2: Automation;
        commAdm2: Automation;
        paramAdm2: Automation;*/
        lvarActiveConnectionAdm2: Variant;
        // Position: Record "Confidential Clerks";
        //   Position2: Record "Confidential Clerks";
        OS: Record "ORG Shema";
        TeamRec: Record "Team temporary";
        LengthCode: Integer;
        //  Tip: Record "Type";
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

