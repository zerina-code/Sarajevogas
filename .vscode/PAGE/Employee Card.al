pageextension 50032 EmployeeCard extends "Employee Card"
{




    layout
    {

        modify(Control1900383207)
        {
            Visible = true;
        }
        modify(General)
        {
            Visible = ShowContractType;
        }
        modify("No.")
        {
            ApplicationArea = all;

        }





        modify("Emplymt. Contract Code")
        {

            ApplicationArea = all;
            Visible = false;
        }




        modify(Payments)
        {
            Visible = false;

        }
        modify("Phone No.2")
        {
            Visible = false;
        }
        modify("Privacy Blocked")
        {
            Visible = false;

        }
        modify("Middle Name")
        {
            visible = false;
        }


        modify(Personal)
        {
            Visible = false;
        }
        modify("Mobile Phone No.")
        {
            ShowCaption = false;
        }

        modify("Phone No.")
        {
            showcaption = false;
        }
        modify("Company E-Mail")
        {
            ShowCaption = false;
        }

        modify("Job Title")
        {
            Visible = false;
        }
        modify("Address & Contact")
        {
            Visible = false;

        }
        modify(Administration)
        {
            Visible = false;
        }

        /*addafter("Address & Contact")
        {
            group("Potential Employe")
            {
                Caption = 'Potential Employe';
                field("Potential Employee"; Rec."Potential Employee")
                {
                    ApplicationArea = all;
                }
                field("Potential Base Status"; Rec."Potential Base Status")
                {
                    ApplicationArea = all;
                }
                field("Documentation delivered"; Rec."Documentation delivered")
                {
                    ApplicationArea = all;
                }
                field("Invited to interview"; Rec."Invited to interview")
                {
                    ApplicationArea = all;
                }
                field("Appropriate candidate"; Rec."Appropriate candidate")
                {
                    ApplicationArea = all;
                }
                field("Inappropriate candidate"; Rec."Inappropriate candidate")
                {
                    ApplicationArea = all;
                }
            }
        }*/




        addafter("Address & Contact")
        {
            group("Brought experience ")
            {

                Caption = 'Brought experience';
                //The GridLayout property is only supported on controls of type Grid
                grid("Brought experience  ")
                {

                    GridLayout = Rows;
                    group("Brought experience   ")
                    {



                        Caption = 'Brought experience';




                        field("Brought Years of Experience"; "Brought Years of Experience")
                        {
                            Editable = false;
                            Caption = 'Brought Years Card';





                        }
                        field("Brought Months of Experience"; "Brought Months of Experience")
                        {
                            Editable = false;
                            Caption = 'Brought Months Card';
                        }
                        field("Brought Days of Experience"; "Brought Days of Experience")
                        {
                            Editable = false;
                            Caption = 'Brought Days Card';
                        }
                    }
                    group("Brought Years in Company")
                    {



                        Caption = 'Brought Years in Curr. Company';

                        field("Brought Years of Exp. in Curr."; "Brought Years of Exp. in Curr.")
                        {
                            Editable = false;
                            Caption = 'Brought Years Comp Card';
                        }
                        field("Brought Months of Exp. in Curr."; "Brought Months of Exp.in Curr.")
                        {
                            Editable = false;
                            Caption = 'Brought Months Comp Card';
                        }
                        field("Brought Days of Exp. in Curr."; "Brought Days of Exp.in Curr.")
                        {
                            Editable = false;
                            Caption = 'Brought Days Comp Card';
                        }
                    }
                    group("Brought Total")
                    {



                        Caption = 'Brought Total';

                        field("Brought Years Total"; "Brought Years Total")
                        {
                            Editable = false;
                            Caption = 'Brought Years Total Card';
                        }
                        field("Brought Months Total"; "Brought Months Total")
                        {
                            Editable = false;
                            Caption = 'Brought Months Total Card';
                        }
                        field("Brought Days Total"; "Brought Days Total")
                        {
                            Editable = false;
                            Caption = 'Brought Days Total Card';
                        }
                    }




                }



            }
            group("Current Company")
            {

                Caption = 'Work Experience in Company';
                //BH 01 start
                grid("Work Experience in Company")
                {
                    GridLayout = Rows;

                    group("Experience in Company")
                    {
                        Caption = 'Experience in Company';

                        field("Years of Experience in Company"; "Years of Experience in Company")
                        {
                            Editable = false;
                        }
                        field("Months of Exp. in Company"; "Months of Exp. in Company")
                        {
                            Editable = false;
                        }
                        field("Days of Experience in Company"; "Days of Experience in Company")
                        {
                            Editable = false;
                        }

                    }
                    group("Current Total")
                    {
                        Caption = 'Current Total';

                        field("Current Years Total"; "Current Years Total")
                        {
                            Editable = false;
                        }
                        field("Current Months Total"; "Current Months Total")
                        {
                            Editable = false;
                        }
                        field("Current Days Total"; "Current Days Total")
                        {
                            Editable = false;
                        }

                    }


                }
                //BH 01 end

            }
            Group("Total experience")

            {
                Caption = 'Total experice Dzana';

                fixed("Total")
                {


                    Caption = 'Total experience';
                    group("Godine")
                    {

                        field("Years of Experience"; "Years of Experience")
                        {
                            Editable = false;
                            Caption = 'Total Years Card';
                        }
                    }
                    group("Mjeseci")
                    {
                        field("Months of Experience"; "Months of Experience")
                        {
                            Editable = false;
                            Caption = 'Total Months Card';
                        }
                    }
                    group("Dani")
                    {
                        field("Days of Experience"; "Days of Experience")
                        {
                            Editable = false;
                            Caption = 'Total Days Card';
                        }
                    }
                }
            }
            group("MILITARY EXPERIENCE")
            {

                Caption = 'Military Experience';
                //BH 01 start
                grid("Experience with military")
                {
                    GridLayout = Rows;
                    group("Military service")
                    {



                        Caption = 'Military service';

                        field("Military Years of Service"; "Military Years of Service")
                        {
                            Editable = false;
                            Caption = 'Military Years Card';
                        }
                        field("Military Months of Service"; "Military Months of Service")
                        {
                            Editable = false;
                            Caption = 'Military Months Card';
                        }
                        field("Military Days of Service"; "Military Days of Service")
                        {
                            Editable = false;
                            Caption = 'Military Days Card';
                        }
                    }

                    group("Work experience with military")
                    {



                        Caption = 'Work experience with military';

                        field("Years with military"; "Years with military")
                        {
                            Editable = false;
                            Caption = 'With Military Years Card';
                        }
                        field("Months with military"; "Months with military")
                        {
                            Editable = false;
                            Caption = 'With Military Months Card';
                        }
                        field("Days with military"; "Days with military")
                        {
                            Editable = false;
                            Caption = 'With Military Days Card';
                        }
                    }




                }
                //BH 01 end

            }



            group("Family")
            {
                Caption = 'Family information';
                group("Family - parents")
                {
                    Caption = 'Parents Information';

                    field("Father Name"; "Father Name")
                    {
                        ApplicationArea = all;
                        DrillDown = true;
                        trigger OnDrillDown()
                        var
                            UserSetup: Record "User Setup";
                            t: Record "Document Attachment";
                        begin
                            UserSetup.Reset();
                            UserSetup.SetFilter("User ID", '%1', USERID);
                            if not UserSetup.FindFirst() then begin
                                UserSetup.Init();
                                UserSetup.Validate("User ID", UserId);
                                UserSetup.Insert();

                            end
                            else begin
                                UserSetup."Open Value" := 'Father';
                                UserSetup.Modify();

                            end;

                            EmployeeRelative.RESET;
                            EmployeeRelative.SETFILTER("Employee No.", "No.");
                            EmployeeRelative.SETFILTER(Relation, 'Father');
                            EmployeeRelativePage.SETTABLEVIEW(EmployeeRelative);
                            EmployeeRelativePage.RUN;
                            CurrPage.UPDATE;



                        end;

                    }
                    field("Mother Name"; "Mother Name")
                    {
                        ApplicationArea = all;
                        DrillDown = true;
                        trigger OnDrillDown()
                        var
                            UserSetup: Record "User Setup";
                        begin
                            UserSetup.Reset();
                            UserSetup.SetFilter("User ID", '%1', USERID);
                            if not UserSetup.FindFirst() then begin
                                UserSetup.Init();
                                UserSetup.Validate("User ID", UserId);
                                UserSetup.Insert();

                            end
                            else begin
                                UserSetup."Open Value" := 'Mother';
                                UserSetup.Modify();

                            end;

                            EmployeeRelative.RESET;
                            EmployeeRelative.SETFILTER("Employee No.", "No.");
                            EmployeeRelative.SETFILTER(Relation, 'Mother');
                            EmployeeRelativePage.SETTABLEVIEW(EmployeeRelative);
                            EmployeeRelativePage.RUN;
                            CurrPage.UPDATE;

                        end;
                    }
                    field("Mother Maiden Name"; "Mother Maiden Name")
                    {
                        ApplicationArea = all;
                        DrillDown = true;
                        trigger OnDrillDown()
                        var
                            UserSetup: Record "User Setup";
                        begin
                            UserSetup.Reset();
                            UserSetup.SetFilter("User ID", '%1', USERID);
                            if not UserSetup.FindFirst() then begin
                                UserSetup.Init();
                                UserSetup.Validate("User ID", UserId);
                                UserSetup.Insert();

                            end
                            else begin
                                UserSetup."Open Value" := 'Mother';
                                UserSetup.Modify();

                            end;
                            EmployeeRelative.RESET;
                            EmployeeRelative.SETFILTER("Employee No.", "No.");
                            EmployeeRelative.SETFILTER(Relation, 'Mother');
                            EmployeeRelativePage.SETTABLEVIEW(EmployeeRelative);
                            EmployeeRelativePage.RUN;
                            CurrPage.UPDATE;




                        end;
                    }


                }




                group("Family - status")
                {
                    Caption = 'Family status';
                    field("Marital status"; Rec."Marital status")
                    {
                        ApplicationArea = all;
                    }

                    field("Number of Children"; "Number of Children")
                    {
                        ApplicationArea = all;
                        trigger OnDrillDown()
                        var
                            UserSetup: Record "User Setup";
                        begin
                            CurrPage.Update(true);
                            SELECTLATESTVERSION;
                            UserSetup.Reset();
                            UserSetup.SetFilter("User ID", '%1', USERID);
                            if not UserSetup.FindFirst() then begin
                                UserSetup.Init();
                                UserSetup.Validate("User ID", UserId);
                                UserSetup.Insert();

                            end
                            else begin
                                UserSetup."Open Value" := 'Child';
                                UserSetup.Modify();

                            end;

                            EmployeeRelative.RESET;
                            EmployeeRelative.SETFILTER("Employee No.", "No.");
                            EmployeeRelative.SETFILTER(Relation, 'Child');
                            EmployeeRelativePage.SETTABLEVIEW(EmployeeRelative);
                            EmployeeRelativePage.RUN;
                            CurrPage.UPDATE(true);


                        end;

                        //ovo sigurno

                    }
                    field("Spouse Name"; "Spouse Name")
                    {
                        ApplicationArea = all;
                        DrillDown = true;
                        trigger OnDrillDown()
                        var
                            UserSetup: Record "User Setup";
                        begin

                            UserSetup.Reset();
                            UserSetup.SetFilter("User ID", '%1', USERID);
                            if not UserSetup.FindFirst() then begin
                                UserSetup.Init();
                                UserSetup.Validate("User ID", UserId);
                                UserSetup.Insert();

                            end
                            else begin
                                UserSetup."Open Value" := 'Spouse';
                                UserSetup.Modify();

                            end;

                            EmployeeRelative.RESET;
                            EmployeeRelative.SETFILTER("Employee No.", "No.");
                            EmployeeRelative.SETFILTER(Relation, 'Spouse');
                            EmployeeRelativePage.SETTABLEVIEW(EmployeeRelative);
                            EmployeeRelativePage.RUN;
                            CurrPage.UPDATE;


                        end;
                    }

                    //ED 02 START
                    field("Single parent/adopter"; "Single parent/adopter")
                    {
                        Editable = true;
                    }
                    //ED 02 END
                }

                /*group("Relatives Group")
                {
                    Caption = 'Relative group';
                    field("Relatives Employees"; "Relatives Employees")
                    {
                        ApplicationArea = all;
                        /*     DrillDown = true;
                             Lookup = true;
                             trigger OnDrillDown()
                             begin
                                 EmployeeRelative.RESET;
                                 EmployeeRelative.SETFILTER("Employee No.", "No.");
                                 EmployeeRelative.SETFILTER(Relation, 'Spouse');
                                 EmployeeRelativePage.SETTABLEVIEW(EmployeeRelative);
                                 EmployeeRelativePage.RUN;
                                 CurrPage.UPDATE;
                             end;
                             trigger OnLookup(var Text: Text): Boolean
                             begin
                                 EmployeeRelative.RESET;
                                 EmployeeRelative.SETFILTER("Employee No.", "No.");
                                 EmployeeRelative.SETFILTER(Relation, 'Spouse');
                                 EmployeeRelativePage.SETTABLEVIEW(EmployeeRelative);
                                 EmployeeRelativePage.RUN;
                                 CurrPage.UPDATE;
                             end;*/
            }


            group(Communication)
            {
                Caption = 'Communication';
                Visible = Show;
                group(Phone1)
                {
                    Caption = 'Home Number Group';

                    grid("Phone No.3")
                    {
                        Caption = 'Phone No.';
                        GridLayout = Rows;

                        field("Country/Region Code Home"; "Country/Region Code Home")
                        {
                            ShowCaption = false;

                            ApplicationArea = all;
                        }
                        field("Dial Code Home"; "Dial Code Home")
                        {
                            ShowCaption = false;
                            ApplicationArea = all;
                        }





                    }
                }
                group(Mobile)
                {
                    Caption = 'Mobile Number Group';

                    grid("Mobile Phone No.3")
                    {
                        Caption = 'Mobile Phone No.';
                        GridLayout = Rows;

                        field("Country/Region Code Mobile"; "Country/Region Code Mobile")
                        {
                            ShowCaption = false;
                            ApplicationArea = all;
                        }
                        field("Dial Code Mobile"; "Dial Code Mobile")
                        {
                            ShowCaption = false;
                            ApplicationArea = all;
                        }

                    }
                }
                group(Company)
                {
                    Caption = 'Company Number Group';
                    grid("Phone No.4")
                    {
                        Caption = 'Phone No.';
                        GridLayout = Rows;

                        field("Country/Region Code Company H"; "Country/Region Code Company H")
                        {
                            ShowCaption = false;
                            ApplicationArea = all;
                        }
                        field("Dial Code Company Home"; "Dial Code Company Home")
                        {
                            ShowCaption = false;
                            ApplicationArea = all;
                        }
                        field("Phone No. for Company"; "Phone No. for Company")
                        {
                            Caption = 'Phone No.';
                            Importance = Standard;
                            ShowCaption = false;
                            ApplicationArea = all;
                        }

                    }
                }
                group(MobileHome)
                {
                    Caption = 'Mobile Private Number Group';
                    grid("Mobile Phone No.2")
                    {
                        Caption = 'Mobile Phone No.';
                        GridLayout = Rows;

                        field("Country/Region Code Company M"; "Country/Region Code Company M")
                        {
                            ShowCaption = false;
                            ApplicationArea = all;
                        }
                        field("Dial Code Company Mobile"; "Dial Code Company Mobile")
                        {
                            ShowCaption = false;
                            ApplicationArea = all;
                        }
                        field("Mobile Phone No. for Company"; "Mobile Phone No. for Company")
                        {
                            Caption = 'Mobile Phone No. for Company';
                            Importance = Standard;
                            ShowCaption = false;
                            ApplicationArea = all;
                        }

                    }
                }
                field("Company Phone No."; "Company Phone No.")
                {
                    Importance = Standard;
                    Visible = false;
                }
                field("Company Mobile Phone No."; "Company Mobile Phone No.")
                {
                    Importance = Standard;
                    Visible = false;
                    ApplicationArea = all;
                }

                group("Email")
                {
                    Caption = 'Email';
                    grid("Company E-mail2")
                    {
                        Caption = 'Company E-mail';
                        GridLayout = Rows;

                        field("E-mail user"; "E-mail user")
                        {
                            Importance = Standard;
                            ShowCaption = false;
                            Visible = true;
                            ApplicationArea = all;
                        }



                    }

                }


                field("Related Person to be informed"; "Related Person to be informed")
                {
                    //ĐK  Caption = 'Related Person to be informed';
                    ApplicationArea = all;
                }
                field("Relationship with Related Per."; "Relationship with Related Per.")
                {
                    ApplicationArea = all;
                }




                group(Emergency)
                {
                    Caption = 'Emergency';

                    grid("Tel. No. Of Related Person")
                    {
                        Caption = 'Tel. No. Of Related Person';
                        GridLayout = Rows;

                        field("Country/Region Code Emergency"; "Country/Region Code Emergency")
                        {
                            ApplicationArea = all;
                            ShowCaption = false;
                        }
                        field("Dial Code Emergency"; "Dial Code Emergency")
                        {
                            ShowCaption = false;
                            ApplicationArea = all;
                        }
                        field("Phone No. Emergency"; "Phone No. Emergency")
                        {
                            ApplicationArea = all;
                            //ĐK Caption = 'Mobile Phone No. for Company';
                            Importance = Standard;
                            ShowCaption = false;
                        }

                    }
                }
            }
            group("Personal Documents")
            {
                Caption = 'Personal Documents';
                Editable = show;
                Visible = true;
                field("ID No."; "ID No.")
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        PersonalDocuments.RESET;
                        PersonalDocuments.SETFILTER("Employee No.", "No.");
                        PersonalDocuments.SETFILTER(Switch, 'IDCard');
                        PersonalDocuments.SETFILTER(Active, '%1', TRUE);
                        IF PersonalDocuments.FINDFIRST THEN BEGIN
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END
                        ELSE BEGIN
                            PersonalDocuments.RESET;
                            PersonalDocuments.SETFILTER("Employee No.", "No.");
                            PersonalDocuments.SETFILTER(Switch, 'IDCard');
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field("Insurence number"; "Insurence number")
                {

                }
                field("Citizenship Description";
                PersonalDocumentsCit1."Citizenship Description")
                {
                    ApplicationArea = all;
                    Caption = 'Citizenship 1';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        PersonalDocuments.RESET;
                        PersonalDocuments.SETFILTER("Employee No.", "No.");
                        PersonalDocuments.SETFILTER(Switch, 'Citizenship');
                        PersonalDocuments.SETFILTER("Citizenship Option", 'Primary');
                        PersonalDocuments.SETFILTER(Active, '%1', TRUE);
                        IF PersonalDocuments.FINDFIRST THEN BEGIN
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END
                        ELSE BEGIN
                            PersonalDocuments.RESET;
                            PersonalDocuments.SETFILTER("Employee No.", "No.");
                            PersonalDocuments.SETFILTER(Switch, 'Citizenship');
                            PersonalDocuments.SETFILTER("Citizenship Option", 'Primary');
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field("Passport No."; "Passport No.")
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        PersonalDocuments.RESET;
                        PersonalDocuments.SETFILTER("Employee No.", "No.");
                        PersonalDocuments.SETFILTER(Switch, 'Passport');
                        PersonalDocuments.SETFILTER("Citizenship Option", 'Primary');
                        PersonalDocuments.SETFILTER(Active, '%1', TRUE);
                        IF PersonalDocuments.FINDFIRST THEN BEGIN
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END
                        ELSE BEGIN
                            PersonalDocuments.RESET;
                            PersonalDocuments.SETFILTER("Employee No.", "No.");
                            PersonalDocuments.SETFILTER(Switch, 'Passport');
                            PersonalDocuments.SETFILTER("Citizenship Option", 'Primary');
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field("Citizenship Description2";
                PersonalDocumentsCit2."Citizenship Description")
                {
                    ApplicationArea = all;
                    Caption = 'Citizenship 2';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        PersonalDocuments.RESET;
                        PersonalDocuments.SETFILTER("Employee No.", "No.");
                        PersonalDocuments.SETFILTER(Switch, 'Citizenship');
                        PersonalDocuments.SETFILTER("Citizenship Option", 'Secondary');
                        PersonalDocuments.SETFILTER(Active, '%1', TRUE);
                        IF PersonalDocuments.FINDFIRST THEN BEGIN
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END
                        ELSE BEGIN
                            PersonalDocuments.RESET;
                            PersonalDocuments.SETFILTER("Employee No.", "No.");
                            PersonalDocuments.SETFILTER(Switch, 'Citizenship');
                            PersonalDocuments.SETFILTER("Citizenship Option", 'Secondary');
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field("Additional Passport No."; "Additional Passport No.")
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        PersonalDocuments.RESET;
                        PersonalDocuments.SETFILTER("Employee No.", "No.");
                        PersonalDocuments.SETFILTER(Switch, 'Passport');
                        PersonalDocuments.SETFILTER("Citizenship Option", 'Secondary');
                        PersonalDocuments.SETFILTER(Active, '%1', TRUE);
                        IF PersonalDocuments.FINDFIRST THEN BEGIN
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END
                        ELSE BEGIN
                            PersonalDocuments.RESET;
                            PersonalDocuments.SETFILTER("Employee No.", "No.");
                            PersonalDocuments.SETFILTER(Switch, 'Passport');
                            PersonalDocuments.SETFILTER("Citizenship Option", 'Secondary');
                            PersonalDocuments.SETFILTER(Active, '%1', TRUE);
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field("Nationality Description";
                PersonalDocumentsNat."Nationality Description")
                {
                    Caption = 'Nationallity';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        PersonalDocuments.RESET;
                        PersonalDocuments.SETFILTER("Employee No.", "No.");
                        PersonalDocuments.SETFILTER(Switch, 'Nationality');
                        PersonalDocuments.SETFILTER(Active, '%1', TRUE);
                        IF PersonalDocuments.FINDFIRST THEN BEGIN
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END
                        ELSE BEGIN
                            PersonalDocuments.RESET;
                            PersonalDocuments.SETFILTER("Employee No.", "No.");
                            PersonalDocuments.SETFILTER(Switch, 'Nationality');
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END;
                        CurrPage.UPDATE;
                    end;
                }

                field("Work Booklet No."; "Work Booklet No.")
                {

                    ApplicationArea = all;
                    Visible = false;
                    trigger OnDrillDown()
                    begin
                        WorkBooklet.RESET;
                        WorkBooklet.SETFILTER("Employee No.", "No.");
                        WorkBookletPage.SETTABLEVIEW(WorkBooklet);
                        WorkBookletPage.RUN;
                        CurrPage.UPDATE;
                        SelectLatestVersion();

                    end;

                }
                field("Work Experience Document"; "Work Experience Document")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        WorkBooklet.RESET;
                        WorkBooklet.SETFILTER("Employee No.", "No.");
                        WorkBookletPage.SETTABLEVIEW(WorkBooklet);
                        WorkBookletPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field("Driving Licence"; "Driving Licence")
                {
                    ApplicationArea = all;
                }
                field("Driving Llicence Category"; "Driving Llicence Category")
                {
                    ApplicationArea = all;
                }
                field("Active Driver"; "Active Driver")
                {
                    ApplicationArea = all;
                }
                field("Residence Permit"; "Residence Permit")
                {
                    ApplicationArea = all;
                    Visible = false;


                    trigger OnDrillDown()
                    begin
                        PersonalDocuments.RESET;
                        PersonalDocuments.SETFILTER("Employee No.", "No.");
                        PersonalDocuments.SETFILTER(Switch, 'Residence Permit');
                        PersonalDocuments.SETFILTER(Active, '%1', TRUE);
                        IF PersonalDocuments.FINDFIRST THEN BEGIN
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END
                        ELSE BEGIN
                            PersonalDocuments.RESET;
                            PersonalDocuments.SETFILTER("Employee No.", "No.");
                            PersonalDocuments.SETFILTER(Switch, 'Residence Permit');
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field("Residence Permit Expiry Date"; "Residence Permit Expiry Date")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        PersonalDocuments.RESET;
                        PersonalDocuments.SETFILTER("Employee No.", "No.");
                        PersonalDocuments.SETFILTER(Switch, 'Residence Permit');
                        PersonalDocuments.SETFILTER(Active, '%1', TRUE);
                        IF PersonalDocuments.FINDFIRST THEN BEGIN
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END
                        ELSE BEGIN
                            PersonalDocuments.RESET;
                            PersonalDocuments.SETFILTER("Employee No.", "No.");
                            PersonalDocuments.SETFILTER(Switch, 'Residence Permit');
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field("Work Permit"; "Work Permit")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        PersonalDocuments.RESET;
                        PersonalDocuments.SETFILTER("Employee No.", "No.");
                        PersonalDocuments.SETFILTER(Switch, 'Work Permit');
                        PersonalDocuments.SETFILTER(Active, '%1', TRUE);
                        IF PersonalDocuments.FINDFIRST THEN BEGIN
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END
                        ELSE BEGIN
                            PersonalDocuments.RESET;
                            PersonalDocuments.SETFILTER("Employee No.", "No.");
                            PersonalDocuments.SETFILTER(Switch, 'Work Permit');
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field("Type Of Work Permit"; "Type Of Work Permit")
                {
                    ApplicationArea = all;
                    Visible = false;
                    Enabled = "Work Permit";

                    trigger OnDrillDown()
                    begin
                        PersonalDocuments.RESET;
                        PersonalDocuments.SETFILTER("Employee No.", "No.");
                        PersonalDocuments.SETFILTER(Switch, 'Work Permit');
                        PersonalDocuments.SETFILTER(Active, '%1', TRUE);
                        IF PersonalDocuments.FINDFIRST THEN BEGIN
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END
                        ELSE BEGIN
                            PersonalDocuments.RESET;
                            PersonalDocuments.SETFILTER("Employee No.", "No.");
                            PersonalDocuments.SETFILTER(Switch, 'Work Permit');
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field("Work Permit Expiry Date"; "Work Permit Expiry Date")
                {

                    ApplicationArea = all;
                    Visible = false;
                    trigger OnDrillDown()
                    begin
                        PersonalDocuments.RESET;
                        PersonalDocuments.SETFILTER("Employee No.", "No.");
                        PersonalDocuments.SETFILTER(Switch, 'Work Permit');
                        PersonalDocuments.SETFILTER(Active, '%1', TRUE);
                        IF PersonalDocuments.FINDFIRST THEN BEGIN
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END
                        ELSE BEGIN
                            PersonalDocuments.RESET;
                            PersonalDocuments.SETFILTER("Employee No.", "No.");
                            PersonalDocuments.SETFILTER(Switch, 'Work Permit');
                            PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                            PersonalDocumentsPage.RUN;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field("Additional rights millitary"; "Additional rights millitary")
                {
                    ApplicationArea = all;
                }
                field("Blood Donor"; "Blood Donor")
                {
                    ApplicationArea = all;
                }
                field("Blood Donation History"; "Blood Donation History")
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    var
                        EmployeeDon: Record "Employee Diseases";
                        EBD: Page "Employee Bood Donations";
                    begin
                        EmployeeDon.RESET;
                        EmployeeDon.SETFILTER("Employee No.", "No.");
                        EmployeeDon.SETFILTER(Types, '%1', EmployeeDon.Types::"Employee Bood Donations");
                        EmployeeDon.SETFILTER(Active, '%1', TRUE);
                        IF EmployeeDon.FINDFIRST THEN BEGIN
                            EBD.SETTABLEVIEW(EmployeeDon);
                            EBD.RUN;
                        END
                        ELSE BEGIN
                            EmployeeDon.RESET;
                            EmployeeDon.SETFILTER("Employee No.", "No.");
                            EmployeeDon.SETFILTER(Types, '%1', EmployeeDon.Types::"Employee Bood Donations");
                            EBD.SETTABLEVIEW(EmployeeDon);
                            EBD.RUN;

                        END;
                        CurrPage.UPDATE;
                    end;

                    //"Employee 
                }
                field("Blood Type"; "Blood Type")
                {
                    ApplicationArea = all;
                }
            }
            group(Education)
            {
                Caption = 'Education';
                Editable = show;
                Visible = true;
                group(Education2)
                {
                    Caption = 'Education';
                    field("Education Level"; "Education Level")
                    {
                        ApplicationArea = all;
                        Importance = Promoted;
                        Editable = false;

                        trigger OnDrillDown()
                        begin
                            EducationHistory.RESET;
                            EducationHistory.SETFILTER("Employee No.", "No.");
                            EducationHistory.SETFILTER(Active, '%1', TRUE);
                            //EducationHistory.SETFILTER(Finished,'%1',TRUE);
                            IF EducationHistory.FINDFIRST THEN BEGIN
                                EducationHistoryPage.SETTABLEVIEW(EducationHistory);
                                EducationHistoryPage.RUN;
                            END
                            ELSE BEGIN
                                EducationHistory.RESET;
                                EducationHistory.SETFILTER("Employee No.", "No.");
                                EducationHistoryPage.SETTABLEVIEW(EducationHistory);
                                EducationHistoryPage.RUN;
                            END;
                            CurrPage.UPDATE;
                        end;
                    }
                    field("School of Graduation"; "School of Graduation")
                    {
                        ApplicationArea = all;
                        Importance = Promoted;
                        Editable = false;

                        trigger OnDrillDown()
                        begin
                            EducationHistory.RESET;
                            EducationHistory.SETFILTER("Employee No.", "No.");
                            EducationHistory.SETFILTER(Active, '%1', TRUE);
                            IF EducationHistory.FINDFIRST THEN BEGIN
                                EducationHistoryPage.SETTABLEVIEW(EducationHistory);
                                EducationHistoryPage.RUN;
                            END
                            ELSE BEGIN
                                EducationHistory.RESET;
                                EducationHistory.SETFILTER("Employee No.", "No.");
                                EducationHistoryPage.SETTABLEVIEW(EducationHistory);
                                EducationHistoryPage.RUN;
                            END;
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Major of Graduation"; "Major of Graduation")
                    {
                        ApplicationArea = all;
                        Editable = false;

                        trigger OnDrillDown()
                        begin
                            EducationHistory.RESET;
                            EducationHistory.SETFILTER("Employee No.", "No.");
                            EducationHistory.SETFILTER(Active, '%1', TRUE);
                            IF EducationHistory.FINDFIRST THEN BEGIN
                                EducationHistoryPage.SETTABLEVIEW(EducationHistory);
                                EducationHistoryPage.RUN;
                            END
                            ELSE BEGIN
                                EducationHistory.RESET;
                                EducationHistory.SETFILTER("Employee No.", "No.");
                                EducationHistoryPage.SETTABLEVIEW(EducationHistory);
                                EducationHistoryPage.RUN;
                            END;
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Title Description"; "Title Description")
                    {
                        ApplicationArea = all;

                        Editable = false;
                        Importance = Promoted;

                        trigger OnDrillDown()
                        begin
                            EducationHistory.RESET;
                            EducationHistory.SETFILTER("Employee No.", "No.");
                            EducationHistory.SETFILTER(Active, '%1', TRUE);
                            IF EducationHistory.FINDFIRST THEN BEGIN
                                EducationHistoryPage.SETTABLEVIEW(EducationHistory);
                                EducationHistoryPage.RUN;
                            END
                            ELSE BEGIN
                                EducationHistory.RESET;
                                EducationHistory.SETFILTER("Employee No.", "No.");
                                EducationHistoryPage.SETTABLEVIEW(EducationHistory);
                                EducationHistoryPage.RUN;
                            END;
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Vocation Description";
                    AdditionalEducation."Vocation Description")
                    {
                        ApplicationArea = all;
                        Caption = 'Vocation Description';
                        Editable = false;
                        Visible = false;

                        trigger OnDrillDown()
                        begin
                            EducationHistory.RESET;
                            EducationHistory.SETFILTER("Employee No.", "No.");
                            EducationHistory.SETFILTER(Active, '%1', TRUE);
                            IF EducationHistory.FINDFIRST THEN BEGIN
                                EducationHistoryPage.SETTABLEVIEW(EducationHistory);
                                EducationHistoryPage.RUN;
                            END
                            ELSE BEGIN
                                EducationHistory.RESET;
                                EducationHistory.SETFILTER("Employee No.", "No.");
                                EducationHistoryPage.SETTABLEVIEW(EducationHistory);
                                EducationHistoryPage.RUN;
                            END;
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Profession Description";
                    AdditionalEducation."Profession Description")
                    {
                        ApplicationArea = all;
                        Caption = 'Profession Description';
                        Editable = false;

                        trigger OnDrillDown()
                        begin
                            EducationHistory.RESET;
                            EducationHistory.SETFILTER("Employee No.", "No.");
                            EducationHistory.SETFILTER(Active, '%1', TRUE);
                            IF EducationHistory.FINDFIRST THEN BEGIN
                                EducationHistoryPage.SETTABLEVIEW(EducationHistory);
                                EducationHistoryPage.RUN;
                            END
                            ELSE BEGIN
                                EducationHistory.RESET;
                                EducationHistory.SETFILTER("Employee No.", "No.");
                                EducationHistoryPage.SETTABLEVIEW(EducationHistory);
                                EducationHistoryPage.RUN;
                            END;
                            CurrPage.UPDATE;
                        end;
                    }
                }
                group(Qualifications)
                {
                    Caption = 'Qualifications';
                    field("Employee Qualifications"; "Employee Qualifications")
                    {
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        var
                            EmployeeQ: Record "Employee Qualification";
                            Employee_Qualifications_HR: Page Employee_Qualifications_HR;
                        begin

                            UserS.Reset();
                            UserS.SetFilter("User ID", '%1', UserId);
                            if UserS.FindFirst() then begin
                                UserS."Qualification Type" := UserS."Qualification Type"::Certification;
                                users.modify;

                            end;


                            EmployeeQ.RESET;
                            EmployeeQ.SETFILTER("Employee No.", "No.");
                            EmployeeQ.SetFilter(Switch, '%1', EmployeeQ.Switch::Certification);
                            EmployeeQ.SetFilter(Active, '%1', true);
                            IF EmployeeQ.FINDFIRST THEN BEGIN
                                Employee_Qualifications_HR.SETTABLEVIEW(EmployeeQ);
                                Employee_Qualifications_HR.RUN;
                            END
                            ELSE BEGIN
                                EmployeeQ.RESET;
                                EmployeeQ.SETFILTER("Employee No.", "No.");
                                EmployeeQ.SetFilter(Switch, '%1', EmployeeQ.Switch::Certification);
                                Employee_Qualifications_HR.SETTABLEVIEW(EmployeeQ);
                                Employee_Qualifications_HR.RUN;

                            END;
                        end;
                    }
                }
                group("Employee Languages")
                {
                    Caption = 'Employee Languages';
                    field("Employee LanguagesE"; "Employee Languages")
                    {
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        var
                            EmployeeQ: Record "Employee Qualification";
                            Employee_Qualifications_HR: Page Employee_Qualifications_HR;
                        begin

                            UserS.Reset();
                            UserS.SetFilter("User ID", '%1', UserId);
                            if UserS.FindFirst() then begin
                                UserS."Qualification Type" := UserS."Qualification Type"::Languages;
                                users.modify;

                            end;

                            EmployeeQ.RESET;
                            EmployeeQ.SETFILTER("Employee No.", "No.");
                            EmployeeQ.SetFilter(Switch, '%1', EmployeeQ.Switch::Languages);
                            EmployeeQ.SetFilter(Active, '%1', true);
                            IF EmployeeQ.FINDFIRST THEN BEGIN
                                Employee_Qualifications_HR.SETTABLEVIEW(EmployeeQ);
                                Employee_Qualifications_HR.RUN;
                            END
                            ELSE BEGIN
                                EmployeeQ.RESET;
                                EmployeeQ.SETFILTER("Employee No.", "No.");
                                EmployeeQ.SetFilter(Switch, '%1', EmployeeQ.Switch::Languages);
                                Employee_Qualifications_HR.SETTABLEVIEW(EmployeeQ);
                                Employee_Qualifications_HR.RUN;

                            END;
                        end;
                    }
                }
                group("Employee Computer Knowledge3")
                {
                    Caption = 'Employee Computer Knowledge';
                    field("Employee Computer Knowledge"; "Employee Computer Knowledge")
                    {
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        var
                            EmployeeQ: Record "Employee Qualification";
                            Employee_Qualifications_HR: Page Employee_Qualifications_HR;
                        begin

                            UserS.Reset();
                            UserS.SetFilter("User ID", '%1', UserId);
                            if UserS.FindFirst() then begin
                                UserS."Qualification Type" := UserS."Qualification Type"::"Computer Knowledge";
                                users.modify;

                            end;
                            EmployeeQ.RESET;
                            EmployeeQ.SETFILTER("Employee No.", "No.");
                            EmployeeQ.SetFilter(Switch, '%1', EmployeeQ.Switch::"Computer Knowledge");
                            EmployeeQ.SetFilter(Active, '%1', true);
                            IF EmployeeQ.FINDFIRST THEN BEGIN
                                Employee_Qualifications_HR.SETTABLEVIEW(EmployeeQ);
                                Employee_Qualifications_HR.RUN;
                            END
                            ELSE BEGIN
                                EmployeeQ.RESET;
                                EmployeeQ.SETFILTER("Employee No.", "No.");
                                EmployeeQ.SetFilter(Switch, '%1', EmployeeQ.Switch::"Computer Knowledge");
                                Employee_Qualifications_HR.SETTABLEVIEW(EmployeeQ);
                                Employee_Qualifications_HR.RUN;

                            END;
                        end;
                    }
                }
            }
            group("Health Condition")
            {
                Caption = 'Health Condition';
                Editable = show;
                Visible = true;
                field("Disabled Person"; "Disabled Person")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Visible = true;

                    trigger OnDrillDown()
                    begin
                        EmployeeDisability.RESET;
                        EmployeeDisability.SETFILTER("Employee No.", "No.");
                        EmployeeDisability.SETFILTER(Active, '%1', TRUE);
                        EmployeeDisabilityPage.SETTABLEVIEW(EmployeeDisability);
                        EmployeeDisabilityPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(EmployeeDisabilityDescription;
                EmployeeDisability1.Description)
                {
                    ApplicationArea = all;
                    Caption = 'Disability Description';
                    Editable = false;
                    Importance = Promoted;

                    trigger OnDrillDown()
                    begin
                        EmployeeDisability.RESET;
                        EmployeeDisability.SETFILTER("Employee No.", "No.");
                        EmployeeDisability.SETFILTER(Active, '%1', TRUE);
                        EmployeeDisabilityPage.SETTABLEVIEW(EmployeeDisability);
                        EmployeeDisabilityPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field("Level of Disability";
                EmployeeDisability1."Level of Disability")
                {
                    Caption = 'Level of Disability';
                    Editable = false;
                    ApplicationArea = all;
                    Importance = Promoted;

                    trigger OnDrillDown()
                    begin
                        EmployeeDisability.RESET;
                        EmployeeDisability.SETFILTER("Employee No.", "No.");
                        EmployeeDisability.SETFILTER(Active, '%1', TRUE);
                        EmployeeDisabilityPage.SETTABLEVIEW(EmployeeDisability);
                        EmployeeDisabilityPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field("Chronic Disease"; "Chronic Disease")
                {
                    ApplicationArea = all;
                }
                field("Employee Diseases"; "Employee Diseases")
                {
                    ApplicationArea = all;
                }
                field("Disabled Child"; "Disabled Child")
                {
                    ApplicationArea = all;
                }
            }
            /*group("Solidarity Fund")
            {
                Caption = 'Solidarity Fund';
                field("Internal Solidarity Fund"; "Internal Solidarity Fund")
                {
                    ApplicationArea = all;
                }
                field("Int. Solidarity Fund Date From"; "Int. Solidarity Fund Date From")
                {
                    ApplicationArea = all;
                }
                field("Int. Solidarity Fund Date To"; "Int. Solidarity Fund Date To")
                {
                    ApplicationArea = all;
                }
                field("External Solidarity Fund"; "External Solidarity Fund")
                {
                    ApplicationArea = all;
                }
                field("Ext. Solidarity Fund Date From"; "Ext. Solidarity Fund Date From")
                {
                    ApplicationArea = all;
                }
                field("Ext. Solidarity Fund Date To"; "Ext. Solidarity Fund Date To")
                {
                    ApplicationArea = all;
                }
            }
            group("Additional Work Activity2")
            {
                Caption = 'Additional Work Activity';
                Editable = show;
                Visible = show;
                field("Additional Work Activity"; "Additional Work Activity")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    trigger OnDrillDown()
                    begin
                        EmployeeActivities.RESET;
                        EmployeeActivities.SETFILTER("Employee No.", "No.");
                        EmployeeActivities.SETFILTER(Active, '%1', TRUE);
                        EmployeeActivitiesPage.SETTABLEVIEW(EmployeeActivities);
                        EmployeeActivitiesPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                /*field(Description;
                EmployeeActivities1.Description)
                {
                    Caption = 'Additional Activity Description';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        EmployeeActivities.RESET;
                        EmployeeActivities.SETFILTER("Employee No.", "No.");
                        EmployeeActivities.SETFILTER(Active, '%1', TRUE);
                        EmployeeActivitiesPage.SETTABLEVIEW(EmployeeActivities);
                        EmployeeActivitiesPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field("Additional Work Activity Res."; "Additional Work Activity Res.")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        EmployeeActivities.RESET;
                        EmployeeActivities.SETFILTER("Employee No.", "No.");
                        EmployeeActivities.SETFILTER(Active, '%1', TRUE);
                        EmployeeActivitiesPage.SETTABLEVIEW(EmployeeActivities);
                        EmployeeActivitiesPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field("Add. Work Activity Remark"; "Add. Work Activity Remark")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        EmployeeActivities.RESET;
                        EmployeeActivities.SETFILTER("Employee No.", "No.");
                        EmployeeActivities.SETFILTER(Active, '%1', TRUE);
                        EmployeeActivitiesPage.SETTABLEVIEW(EmployeeActivities);
                        EmployeeActivitiesPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field("Date From";
                EmployeeActivities1."Date From")
                {
                    ApplicationArea = all;
                    Caption = 'Date From';
                    Editable = false;
                    Importance = Promoted;
                    trigger OnDrillDown()
                    begin
                        EmployeeActivities.RESET;
                        EmployeeActivities.SETFILTER("Employee No.", "No.");
                        EmployeeActivities.SETFILTER(Active, '%1', TRUE);
                        EmployeeActivitiesPage.SETTABLEVIEW(EmployeeActivities);
                        EmployeeActivitiesPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field("Date To";
                EmployeeActivities1."Date To")
                {
                    ApplicationArea = all;
                    Caption = 'Date To';
                    Editable = false;
                    Importance = Promoted;
                    trigger OnDrillDown()
                    begin
                        EmployeeActivities.RESET;
                        EmployeeActivities.SETFILTER("Employee No.", "No.");
                        EmployeeActivities.SETFILTER(Active, '%1', TRUE);
                        EmployeeActivitiesPage.SETTABLEVIEW(EmployeeActivities);
                        EmployeeActivitiesPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
            }*/
            group("Employment Abroad")
            {

                Caption = 'Employment Abroad';
                Editable = show;
                Visible = false;
                field("Employment AbroadECL";
                EmployeeContractLedger."Employment Abroad")
                {
                    Caption = 'Employment Abroad';
                    Editable = false;
                    Importance = Promoted;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER("Employment Abroad", '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(StartDate; StartDate)
                {
                    Caption = 'Date From';
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = true;
                    Importance = Promoted;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER("Employment Abroad", '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(EndDate; EndDate)
                {
                    Caption = 'Date To';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER("Employment Abroad", '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field("Employment Abroad City";
                EmployeeContractLedger."Employment Abroad City")
                {
                    Caption = 'Employment Abroad City';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER("Employment Abroad", '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field("Empl. Abroad Country/Region";
                EmployeeContractLedger."Empl.Abroad Country/Region")
                {
                    ApplicationArea = all;
                    Caption = 'Employment Abroad Country/Region';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER("Employment Abroad", '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field("Employment Abroad Remark"; "Employment Abroad Remark")
                {
                    ApplicationArea = all;
                    Caption = 'Employment Abroad Remark';
                    MultiLine = true;
                }
            }


            group(PLATE)
            {

                //ĐK
                group("Bank data")

                {

                    Caption = 'Bank Data';
                    field("WEP with military"; "WEP with military")
                    {
                        ApplicationArea
                        = all;
                    }
                    field("Work Experience Percentage"; Rec."Work Experience Percentage")
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field("Send PayList"; "Send PayList")
                    {
                        ApplicationArea = all;
                    }
                    field("Contact Center"; "Contact Center")
                    {
                        ApplicationArea = all;
                        Visible = false;
                    }
                    field("Bank No."; Rec."Bank No.")
                    {
                        Caption = 'Bank No.';
                        ApplicationArea = all;
                    }
                    field("Bank Account Code"; "Bank Account Code")
                    {
                        ApplicationArea = all;

                    }

                    field("Bank Account No.2"; Rec."Bank Account No.")

                    {
                        Caption = 'Bank Account No.';
                        ApplicationArea = all;
                        //ĐK  TableRelation = "Wage/Reduction Bank Accounts"."No.";
                        Visible = false;
                    }
                    field("Party No."; "Party No.")
                    {

                    }
                    field("Refer To Number"; Rec."Refer To Number")
                    {
                        ApplicationArea = all;
                        Visible = false;
                    }


                }
                group(General2)
                {
                    Caption = 'General';

                    //The GridLayout property is only supported on controls of type Grid

                    field("Hours In Day"; Rec."Hours In Day")
                    {
                        ApplicationArea = all;
                    }
                    field("Transport Allowance"; "Transport Allowance")
                    {
                        ApplicationArea = all;

                    }
                    field("Transport Amount Planned"; "Transport Amount Planned")
                    {
                        ApplicationArea = all;
                    }

                    field("Transport Amount"; Rec."Transport Amount")
                    {
                        ApplicationArea = all;
                    }
                    field("Municipality Code for salary"; "Municipality Code for salary")
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field("Org Entity Code"; "Org Entity Code")
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }

                    field("For Calculation"; Rec."For Calculation")
                    {
                        ApplicationArea = all;
                    }
                    field("Calculate Wage Addition"; "Calculate Wage Addition")
                    {
                        ApplicationArea = all;
                    }
                    field(Meal; Rec.Meal)
                    {
                        ApplicationArea = all;
                    }
                    field("Wage Type"; "Wage Type")
                    {
                        ApplicationArea = all;

                    }

                    field("Operator No."; "Operator No.")
                    {
                        ApplicationArea = all;
                        Visible = false;
                    }



                }
                group("PORESKA OLAKŠICA")
                {
                    field("Tax Deduction"; Rec."Tax Deduction")
                    {
                        ApplicationArea = all;
                    }
                    field("Benefit Coefficient"; "Benefit Coefficient")
                    {
                        ApplicationArea = all;
                        DrillDown = true;
                        trigger OnDrillDown()
                        begin
                            WageCalc.RESET;
                            WageCalc.SETFILTER("Employee No.", "No.");
                            WageCalcSub.SETTABLEVIEW(WageCalc);
                            WageCalcSub.RUN;
                            CurrPage.UPDATE;
                        end;


                    }

                    field("Tax Deduction Amount"; Rec."Tax Deduction Amount")
                    {
                        Editable = false;
                        ApplicationArea = all;
                    }
                    field("Iznos poreske kartice"; "Iznos poreske kartice")
                    {
                        ApplicationArea = all;
                        Visible = false;
                    }
                    field("Iznos ličnog odbitka"; "Iznos ličnog odbitka")
                    {
                        ApplicationArea = all;
                        Visible = false;
                    }
                }
                group(Posting)
                {
                    Caption = 'Posting';


                    field("Contribution Category Code"; Rec."Contribution Category Code")
                    {
                        ApplicationArea = all;

                    }
                    field("Wage Posting Group"; Rec."Wage Posting Group")
                    {
                        ApplicationArea = all;

                    }


                }



                //ĐK

            }
            /*group(Union)
            {
                Caption = 'Union';
                Visible = show;
                field("Union Member"; "Union Member")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        UnionEmployees.RESET;
                        UnionEmployees.SETFILTER("Employee No.", "No.");
                        UnionEmployees.SETFILTER(Active, '%1', TRUE);
                        UnionEmployeesPage.SETTABLEVIEW(UnionEmployees);
                        UnionEmployeesPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(Unions; Unions)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
            group("Additional Payments")
            {
                Caption = 'Additional Payments';
                Visible = show2;
                group("Incentive Current Month3")
                {
                    Caption = 'Incentive Current Month';
                    field("Incentive Current Month"; "Incentive Current Month")
                    {
                        Caption = 'Incentive Current Month';
                        Editable = false;
                        ApplicationArea = all;
                        trigger OnDrillDown()
                        begin
                            WA.RESET;
                            WA.SETFILTER("Employee No.", "No.");
                            WA.SETFILTER("Wage Addition Type", '%1', 'INC*');
                            WA.SETRANGE("Closing Date", ThisMonthFirst, ThisMonthLast);
                            WAPage.SETTABLEVIEW(WA);
                            WAPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Incentive Current Month Brutto"; "Incentive Current Month Brutto")
                    {
                        Caption = 'Incentive Current Month';
                        Editable = false;
                        ApplicationArea = all;
                        trigger OnDrillDown()
                        begin
                            WA.RESET;
                            WA.SETFILTER("Employee No.", "No.");
                            WA.SETFILTER("Wage Addition Type", '%1', 'INC*');
                            WA.SETRANGE("Closing Date", ThisMonthFirst, ThisMonthLast);
                            WAPage.SETTABLEVIEW(WA);
                            WAPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Month Of Current Incentive"; "Month Of Current Incentive")
                    {
                        Editable = false;
                        ApplicationArea = all;
                        Caption = 'Month od Current Incentive';
                        trigger OnDrillDown()
                        begin
                            WA.RESET;
                            WA.SETFILTER("Employee No.", "No.");
                            WA.SETFILTER("Wage Addition Type", '%1', 'INC*');
                            WA.SETRANGE("Closing Date", ThisMonthFirst, ThisMonthLast);
                            WAPage.SETTABLEVIEW(WA);
                            WAPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Year Of Current Incentive"; "Year Of Current Incentive")
                    {
                        Editable = false;
                        ApplicationArea = all;
                        Caption = 'Year od Current Incentive';
                        trigger OnDrillDown()
                        begin
                            WA.RESET;
                            WA.SETFILTER("Employee No.", "No.");
                            WA.SETFILTER("Wage Addition Type", '%1', 'INC*');
                            WA.SETRANGE("Closing Date", ThisMonthFirst, ThisMonthLast);
                            WAPage.SETTABLEVIEW(WA);
                            WAPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                }
                group("Incentive Current Month2")
                {
                    Caption = 'Incentive Current Month';
                    Visible = show2;
                    field("Incentive Cumulative"; "Incentive Cumulative")
                    {
                        Caption = 'Incentive Cumulative';
                        Editable = false;
                        ApplicationArea = all;
                        trigger OnDrillDown()
                        begin
                            WA.RESET;
                            WA.SETFILTER("Employee No.", "No.");
                            WA.SETFILTER("Wage Addition Type", '%1', 'INC*');
                            WAPage.SETTABLEVIEW(WA);
                            WAPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Incentive Cumulative Brutto"; "Incentive Cumulative Brutto")
                    {
                        Editable = false;
                        ApplicationArea = all;
                        Caption = 'Incentive cumulativ Brutto';
                        trigger OnDrillDown()
                        begin
                            WA.RESET;
                            WA.SETFILTER("Employee No.", "No.");
                            WA.SETFILTER("Wage Addition Type", '%1', 'INC*');
                            WAPage.SETTABLEVIEW(WA);
                            WAPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Year Of Cumulative Incentive"; "Year Of Cumulative Incentive")
                    {
                        Editable = false;
                        ApplicationArea = all;
                        Caption = 'Year incentive cumulativ Brutto';
                        trigger OnDrillDown()
                        begin
                            WA.RESET;
                            WA.SETFILTER("Employee No.", "No.");
                            WA.SETFILTER("Wage Addition Type", '%1', 'INC*');
                            WAPage.SETTABLEVIEW(WA);
                            WAPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Number of Paid ncentives"; "Number of Paid ncentives")
                    {
                        Editable = false;
                        ApplicationArea = all;
                        Caption = 'Number of Paid incentives';
                        trigger OnDrillDown()
                        begin
                            WA.RESET;
                            WA.SETFILTER("Employee No.", "No.");
                            WA.SETFILTER("Wage Addition Type", '%1', 'INC*');
                            WAPage.SETTABLEVIEW(WA);
                            WAPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                }
            }
            group("Additional Payments Bonus")
            {
                Caption = 'Additional Payments';
                group(Regres3)
                {
                    Caption = 'Regres';
                    field("Bonus Current Month"; "Bonus Current Month")
                    {
                        ApplicationArea = all;
                        Caption = 'Regres Cumulative';
                        Editable = false;
                        trigger OnDrillDown()
                        begin
                            WA.RESET;
                            WA.SETFILTER("Employee No.", "No.");
                            WA.SETFILTER(Regres, '%1', TRUE);
                            WAPage.SETTABLEVIEW(WA);
                            WAPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Bonus Cumulative Brutto"; "Bonus Cumulative Brutto")
                    {
                        Editable = false;
                        ApplicationArea = all;
                        Caption = 'Bonus Cumulative brutto';
                        trigger OnDrillDown()
                        begin
                            WA.RESET;
                            WA.SETFILTER("Employee No.", "No.");
                            WA.SETFILTER(Regres, '%1', TRUE);
                            WAPage.SETTABLEVIEW(WA);
                            WAPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Bonus Payment Date"; "Bonus Payment Date")
                    {
                        Editable = false;
                        ApplicationArea = all;
                        Caption = 'Bonus Payment Date';
                        trigger OnDrillDown()
                        begin
                            WA.RESET;
                            WA.SETFILTER("Employee No.", "No.");
                            WA.SETFILTER(Regres, '%1', TRUE);
                            WAPage.SETTABLEVIEW(WA);
                            WAPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                }
            }
            group("Additional Payments Regres")
            {
                Caption = 'Additional Payments';
                Visible = show2;
                group(Regres2)
                {
                    Caption = 'Regres';
                    Visible = show2;
                    field("Regres Cumulative"; "Regres Cumulative")
                    {
                        ApplicationArea = all;
                        Caption = 'Regres Cumulative';
                        Editable = false;
                        trigger OnDrillDown()
                        begin
                            WA.RESET;
                            WA.SETFILTER("Employee No.", "No.");
                            WA.SETFILTER(Regres, '%1', TRUE);
                            WAPage.SETTABLEVIEW(WA);
                            WAPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Regres Cumulative Brutto"; "Regres Cumulative Brutto")
                    {
                        Editable = false;
                        ApplicationArea = all;
                        Caption = 'Regres Cumulative brutto';
                        trigger OnDrillDown()
                        begin
                            WA.RESET;
                            WA.SETFILTER("Employee No.", "No.");
                            WA.SETFILTER(Regres, '%1', TRUE);
                            WAPage.SETTABLEVIEW(WA);
                            WAPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Regres Payment Date"; "Regres Payment Date")
                    {
                        Editable = false;
                        ApplicationArea = all;
                        Caption = 'Regres Payment date';
                        trigger OnDrillDown()
                        begin
                            WA.RESET;
                            WA.SETFILTER("Employee No.", "No.");
                            WA.SETFILTER(Regres, '%1', TRUE);
                            WAPage.SETTABLEVIEW(WA);
                            WAPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(Regres; Regres)
                    {
                        ApplicationArea = all;
                        Caption = 'Regres yes';
                    }
                    field("Regres Date"; "Regres Date")
                    {
                        ApplicationArea = all;
                        Caption = 'Regres Date';
                        trigger OnValidate()
                        begin
                            CurrPage.UPDATE;
                        end;
                    }
                }
            }*/

        }


        /*addafter("Brought Days of Experience")
        {
            Group("Total experience Company3")
            {
                Caption = 'Year Total experience';
                field("Years of Experience"; "Years of Experience")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Months of Experience"; "Months of Experience")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Days of Experience"; "Days of Experience")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
        }*/


        addafter("No.")
        {
            field("Old Number"; "Old Number")
            {
                ApplicationArea = all;
                Visible = true;
            }

            field("CNG Employee"; "CNG Employee") { ApplicationArea = all; Visible = Visib; }
            field("Registration No."; "Registration No.")
            {
                ApplicationArea = All;
                Visible = Visib;

            }

        }

        addafter("No.")
        {
            field("Internal ID"; "Internal ID")
            {
                ApplicationArea = all;
            }

            /*field("Employee with 2 JIB"; "Employee with 2 JIB")
            {
                ApplicationArea = all;
            }*/


            field("Employee ID"; Rec."Employee ID")
            {
                Caption = 'Employee ID';
                ShowMandatory = true;
                ApplicationArea = all;
            }




            field("Employee User Name"; "Employee User Name")
            {
                ApplicationArea = all;
                Lookup = true;
                DrillDown = true;
                Visible = false;
                trigger OnLookup(var Text: Text): Boolean



                var
                    UserSetup: Record "User Setup";
                    UserSetupPage: page "User Setup";
                begin

                    UserSetup.Reset();
                    UserSetup.SetFilter("User ID", '%1', USERID);
                    if UserSetup.FindFirst() then begin
                        UserSetup.UserEmp := Rec."No.";
                        UserSetup.Modify();
                    end;


                end;

                trigger OnDrillDown()
                var
                    UserSetup: Record "User Setup";
                    UserSetupPage: page "User Setup";
                begin

                    UserSetup.Reset();
                    UserSetup.SetFilter("User ID", '%1', USERID);
                    if UserSetup.FindFirst() then begin

                        UserSetup.UserEmp := Rec."No.";
                        UserSetup.Modify();
                    end;

                    UserSetup.RESET;
                    UserSetup.SETFILTER("Employee No.", "No.");
                    UserSetupPage.SETTABLEVIEW(UserSetup);
                    UserSetupPage.RUN;

                    CurrPage.UPDATE;



                end;



            }

        }
        modify("Search Name")
        {
            Visible = false;
        }
        addafter("Last Name")
        {
            field(StatusExt; StatusExt)
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    if (StatusExt = StatusExt::"External employee") or (StatusExt = StatusExt::Practicians)
     or (StatusExt = StatusExt::"Temporary Contract") or (StatusExt = StatusExt::Volonteer) then
                        ShowContractType := true
                    else
                        ShowContractType := false;
                    if ShowContractType = true then
                        ShowContractType2 := false
                    else
                        ShowContractType2 := true;
                    CurrPage.Update(true);

                end;
            }
            field("Temporary Contract Type"; "Temporary Contract Type")
            {
                Visible = ShowContractType;

            }
            field("External employer Status"; "External employer Status")
            {
                Visible = ShowContractType;

            }

            /*field("External employer Status"; "External employer Status")
            {
                ApplicationArea = all;
            }
            field("Returned to Company"; "Returned to Company")
            {
                ApplicationArea = all;
                DrillDown = true;
                trigger OnDrillDown()
                begin
                    WorkBooklet.RESET;
                    WorkBooklet.SETFILTER("Employee No.", "No.");
                    WorkBooklet.SETFILTER("Current Company", '%1', TRUE);
                    WorkBookletPage.SETTABLEVIEW(WorkBooklet);
                    WorkBookletPage.RUN;
                    CurrPage.UPDATE;
                end;
            }*/

        }




        addlast(General)
        {
            group("Birth Information")
            {
                Caption = 'Birth Information';


                field(Age; Age)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Municipality Code of Birth"; "Municipality Code of Birth")
                {
                    ApplicationArea = all;

                }
                field("Municipality Name of Birth"; "Municipality Name of Birth")
                {
                    ApplicationArea = all;
                }
                field("City of Birth"; "City of Birth")
                {
                    ApplicationArea = all;
                }
                field("Place of birth"; "Place of birth")
                {
                    ApplicationArea = all;
                }
                field("Country/Region Code of Birth"; "Country/Region Code of Birth")
                {

                    ApplicationArea = all;
                }

            }
        }

        addafter("Birth Information")
        {
            group("Address information")
            {
                Caption = 'Address information';

                field("Address CIPS"; "Address CIPS")
                {
                    ApplicationArea = all;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        AlternativeAddress: Record "Alternative Address";
                        AlternativeAddressList: Page "Alternative Address List";
                    begin
                        AlternativeAddress.RESET;
                        AlternativeAddress.SETFILTER("Employee No.", "No.");
                        //AlternativeAddress.SETFILTER("Address Type",'CIPS');
                        AlternativeAddress.SETFILTER(Active, '%1', TRUE);
                        AlternativeAddressList.SETTABLEVIEW(AlternativeAddress);
                        AlternativeAddressList.RUN;
                        CurrPage.UPDATE;

                    end;
                }
                field("Place Of Living"; "Place Of Living")
                {
                    ApplicationArea = all;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        AlternativeAddress: Record "Alternative Address";
                        AlternativeAddressList: Page "Alternative Address List";
                    begin
                        AlternativeAddress.RESET;
                        AlternativeAddress.SETFILTER("Employee No.", "No.");
                        //AlternativeAddress.SETFILTER("Address Type",'CIPS');
                        AlternativeAddress.SETFILTER(Active, '%1', TRUE);
                        AlternativeAddressList.SETTABLEVIEW(AlternativeAddress);
                        AlternativeAddressList.RUN;
                        CurrPage.UPDATE;

                    end;
                }
                field("Municipality Code CIPS"; "Municipality Code CIPS")
                {
                    ApplicationArea = all;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        AlternativeAddress: Record "Alternative Address";
                        AlternativeAddressList: Page "Alternative Address List";
                    begin
                        AlternativeAddress.RESET;
                        AlternativeAddress.SETFILTER("Employee No.", "No.");
                        //AlternativeAddress.SETFILTER("Address Type",'CIPS');
                        AlternativeAddress.SETFILTER(Active, '%1', TRUE);
                        AlternativeAddressList.SETTABLEVIEW(AlternativeAddress);
                        AlternativeAddressList.RUN;
                        CurrPage.UPDATE;

                    end;
                }
                field("Municipality Name CIPS"; "Municipality Name CIPS")
                {
                    ApplicationArea = all;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        AlternativeAddress: Record "Alternative Address";
                        AlternativeAddressList: Page "Alternative Address List";
                    begin
                        AlternativeAddress.RESET;
                        AlternativeAddress.SETFILTER("Employee No.", "No.");
                        //AlternativeAddress.SETFILTER("Address Type",'CIPS');
                        AlternativeAddress.SETFILTER(Active, '%1', TRUE);
                        AlternativeAddressList.SETTABLEVIEW(AlternativeAddress);
                        AlternativeAddressList.RUN;
                        CurrPage.UPDATE;

                    end;
                }
                field("City CIPS"; "City CIPS")
                {
                    ApplicationArea = all;
                    Editable = false;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        AlternativeAddress: Record "Alternative Address";
                        AlternativeAddressList: Page "Alternative Address List";
                    begin
                        AlternativeAddress.RESET;
                        AlternativeAddress.SETFILTER("Employee No.", "No.");
                        //AlternativeAddress.SETFILTER("Address Type",'CIPS');
                        AlternativeAddress.SETFILTER(Active, '%1', TRUE);
                        AlternativeAddressList.SETTABLEVIEW(AlternativeAddress);
                        AlternativeAddressList.RUN;
                        CurrPage.UPDATE;

                    end;
                }
                field("Post Code CIPS"; "Post Code CIPS")
                {
                    ApplicationArea = all;
                    DrillDown = true;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        AlternativeAddress: Record "Alternative Address";
                        AlternativeAddressList: Page "Alternative Address List";
                    begin
                        AlternativeAddress.RESET;
                        AlternativeAddress.SETFILTER("Employee No.", "No.");
                        //AlternativeAddress.SETFILTER("Address Type",'CIPS');
                        AlternativeAddress.SETFILTER(Active, '%1', TRUE);
                        AlternativeAddressList.SETTABLEVIEW(AlternativeAddress);
                        AlternativeAddressList.RUN;
                        CurrPage.UPDATE;

                    end;
                }
            }
        }
        addafter("Address information")
        {
            group("Position Information")
            {

                Caption = 'Position Information';


                field(EmployeeContractLedgerPositionCode; EmployeeContractLedger."Position Code")
                {
                    Caption = 'Position Code';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(EmployeeContractLedgerPositionDescription; EmployeeContractLedger."Position Description")
                {
                    Caption = 'Position Description';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                        IF EmployeeContractLedger.FINDFIRST THEN BEGIN
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                        END
                        ELSE BEGIN
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                        END;
                        CurrPage.UPDATE;
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                        IF EmployeeContractLedger.FINDFIRST THEN BEGIN
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                        END
                        ELSE BEGIN
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                        END;
                        CurrPage.UPDATE;

                    end;
                }
                /*field(DepartmentName; EmployeeContractLedger."Department Name")
                {
                    Caption = 'Department Name';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(SectorDescription; EmployeeContractLedger."Sector Description")
                {
                    Caption = 'Sector Description';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(Služba; EmployeeContractLedger."Department Cat. Description")
                {
                    Caption = 'Služba';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(Odjel; EmployeeContractLedger."Group Description")
                {
                    Caption = 'Odjel';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(StatusP; EmployeeContractLedger.Status)
                {
                    Caption = 'Status';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }*/
                field(Smjena; EmployeeContractLedger."Rad u smjenama")
                {
                    Caption = 'Rad u smjenama';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin

                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(Management1; EmployeeContractLedger."Manager 1 Last Name" + ' ' + EmployeeContractLedger."Manager 1 First Name")
                {
                    Caption = 'Superior 1';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        CurrPage.UPDATE(TRUE);
                        SELECTLATESTVERSION;

                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE(true);
                    end;



                }

                field(Manager2; EmployeeContractLedger."Manager 2 Last Name" + ' ' + EmployeeContractLedger."Manager 2 First Name")
                {
                    Caption = 'Superior 2';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;


                    trigger OnDrillDown()
                    begin

                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }

                field(ECLManagementLevel; EmployeeContractLedger."Management Level")
                {
                    Caption = 'Management Level';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin

                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(EmployeeContractLedgerSector; EmployeeContractLedger.Sector)
                {
                    Caption = 'Sector';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLSectorDescription; "Sector Description")
                {
                    Caption = 'Sector';
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        CurrPage.Update();
                        SelectLatestVersion();
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLDepartmentCode; EmployeeContractLedger."Department Code")
                {
                    Caption = 'Department Code';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLDepartmentName; EmployeeContractLedger."Department Name")
                {
                    Caption = 'Department Name';
                    Editable = false;
                    Enabled = true;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                        IF EmployeeContractLedger.FINDFIRST THEN BEGIN
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                        END
                        ELSE BEGIN
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLDepartmentCategory; EmployeeContractLedger."Department Category")
                {
                    Caption = 'Department Category';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLDepartmentCatDescription; EmployeeContractLedger."Department Cat. Description")
                {
                    Caption = 'B-1 (with regions) Description';
                    Editable = false;
                    Enabled = true;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLGroup; EmployeeContractLedger.Group)
                {
                    Caption = 'Group';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLGroupDescription; EmployeeContractLedger."Group Description")
                {
                    Caption = 'Stream Description';
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                /*
                field(ECLTeam; EmployeeContractLedger.Team)
                {
                    Caption = 'Team';
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLTeamDescription; EmployeeContractLedger."Team Description")
                {
                    Caption = 'Team Description';
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLManager1FirstNameLastName; EmployeeContractLedger."Manager 1 First Name" + ' ' + EmployeeContractLedger."Manager 1 Last Name")
                {
                    Caption = 'Manager Full Name';
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        Emp.RESET;
                        Emp.SETFILTER("First Name", '%1', EmployeeContractLedger."Manager 1 First Name");
                        Emp.SETFILTER("Last Name", '%1', EmployeeContractLedger."Manager 1 Last Name");
                        EmpPage.SETTABLEVIEW(Emp);
                        EmpPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }*/
                field(ECLDepartmentCity; EmployeeContractLedger."Department City")
                {
                    Caption = 'Department City';
                    Editable = false;
                    Enabled = true;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLDepartmentAddress; EmployeeContractLedger."Department Address")
                {
                    Caption = 'Department Address';
                    Editable = false;
                    Enabled = true;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLOrgDio; EmployeeContractLedger."Org Dio")
                {
                    Caption = 'Org. Part';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        OrgDijelovi.RESET;
                        OrgDijelovi.SETFILTER(Code, EmployeeContractLedger."Org Dio");
                        OrgDijeloviPage.SETTABLEVIEW(OrgDijelovi);
                        OrgDijeloviPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLOrgDioName; EmployeeContractLedger."Org Dio Name")
                {
                    Caption = 'Org Dio Name';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        OrgDijelovi.RESET;
                        OrgDijelovi.SETFILTER(Code, EmployeeContractLedger."Org Dio");
                        OrgDijeloviPage.SETTABLEVIEW(OrgDijelovi);
                        OrgDijeloviPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLGFradacode; EmployeeContractLedger."GF rada code")
                {
                    Caption = 'GF of work';
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        OrgDijelovi.RESET;
                        OrgDijelovi.SETFILTER(Code, EmployeeContractLedger."Org Dio");
                        OrgDijeloviPage.SETTABLEVIEW(OrgDijelovi);
                        OrgDijeloviPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field("Default Dimension"; "Default Dimension")
                {
                    Editable = false;
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Default Dimension Name"; "Default Dimension Name")
                {
                    Editable = false;
                    Importance = Promoted;
                    MultiLine = false;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                    Width = 250;
                }
                /*field("Employee Benefits"; "Employee Benefits")
                {
                    ApplicationArea = all;
                }
                /*field("Job Violations"; "Job Violations")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnDrillDown()
                    begin
                        WDV.RESET;
                        WDV.SETFILTER("Employee No.", "No.");
                        WDVPAge.SETTABLEVIEW(WDV);
                        WDVPAge.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field("Disciplinary Measured"; "Disciplinary Measured")
                {
                    ApplicationArea = all;
                }
                field(Awards; Awards)
                {
                    DrillDownPageID = "Employee Award List";
                    LookupPageID = "Employee Award List";
                    ApplicationArea = all;
                }*/
                /*field(Clauses; Clauses)
                {
                    DrillDownPageID = Clauses;
                    LookupPageID = Clauses;
                    ApplicationArea = all;
                }
                field("Lawsuits/Labor Disputes"; "Lawsuits/Labor Disputes")
                {
                    DrillDownPageID = "Lawsuits/Labor Disputes List";
                    ApplicationArea = all;
                    LookupPageID = "Lawsuits/Labor Disputes List";
                }*/



            }
        }




        addafter(General)
        {
            group(Administration2)
            {
                Caption = 'Administration of Employment';
                group(Administration3)
                {

                    Caption = 'Administration';
                    field(EmploymentDate; EmploymentDate)
                    {
                        Caption = 'Employment Date';
                        Editable = false;
                        Importance = Promoted;
                        ShowMandatory = true;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin
                            /*EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.","No.");
                            EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;*/

                            WorkBooklet.RESET;
                            WorkBooklet.SETFILTER("Employee No.", "No.");
                            WorkBooklet.SETFILTER(Active, '%1', TRUE);
                            WorkBooklet.SETFILTER("Hours change", '%1', FALSE);
                            WorkBookletPage.SETTABLEVIEW(WorkBooklet);
                            WorkBookletPage.RUN;
                            CurrPage.UPDATE;

                        end;

                        trigger OnValidate()
                        begin
                            /*IF "Employment Date" > "Probation Period Start" THEN
                            ERROR(Text010);  */

                        end;
                    }
                    /*field("Employment Date2"; "Employment Date")
                    {
                        ApplicationArea = all;
                    }*/


                    field(EmployeeContractLedgerBrutto; EmployeeContractLedger.Brutto)
                    {
                        Caption = 'Brutoo';
                        Editable = false;
                        Importance = Promoted;
                        Visible = show2;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerNetto; EmployeeContractLedger.Netto)
                    {
                        Caption = 'Netto';
                        Editable = false;
                        Importance = Promoted;
                        ApplicationArea = all;
                        //  Visible = show2;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerTotalNetto; EmployeeContractLedger."Total Netto")
                    {
                        Caption = 'Total Netto';
                        Editable = false;
                        ApplicationArea = all;
                        // Visible = show2;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerWageType; EmployeeContractLedger."Wage Type")
                    {
                        Caption = 'Wage Type';
                        Editable = false;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }

                    field("<Work Experience Percentage Copy>"; "Work Experience Percentage")
                    {
                        Caption = 'Work Experience Percentage';
                        Editable = false;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin
                            WageCalc.RESET;
                            WageCalc.SETFILTER("Employee No.", "No.");
                            WageCalcSub.SETTABLEVIEW(WageCalc);
                            WageCalcSub.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerFirstTimeEmployed; EmployeeContractLedger."First Time Employed")
                    {
                        Caption = 'First Time Employed';
                        Editable = false;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerWayofEmployment; EmployeeContractLedger."Way of Employment")
                    {
                        Caption = 'Way of Employment';
                        Editable = false;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerPrentice; EmployeeContractLedger.Prentice)
                    {
                        Caption = 'Prentice';
                        Editable = false;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    /*field("Professional Examination Date"; "Professional Examination Date")
                    {
                        ApplicationArea = all;
                    }
                    field("Professional Exam. Result"; "Professional Exam. Result")
                    {
                        ApplicationArea = all;
                    }*/
                    field(EmployeeContractLedgerEngagementType; EmployeeContractLedger."Contract Type Name")
                    {
                        Caption = 'Contract Type';
                        ApplicationArea = all;
                        Editable = false;
                        Importance = Promoted;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerStartingDate; EmployeeContractLedger."Starting Date")
                    {
                        Caption = 'Starting Date';
                        Editable = false;
                        Importance = Promoted;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerEndingDate; EmployeeContractLedger."Ending Date")
                    {
                        Caption = 'Ending Date';
                        Editable = false;
                        Importance = Promoted;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin

                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                }

            }
        }

        addbefore(Administration2)
        {
            group(GeneralTEST)
            {
                Caption = 'General';
                Visible = ShowContractType2;

                field("No.2"; "No.")
                {
                    ApplicationArea = All;
                }
                field("Old Number2"; "Old Number") { ApplicationArea = all; }
                field("CNG Employee2"; "CNG Employee") { ApplicationArea = all; Visible = Visib; }
                field("Registration No.2"; "Registration No.")
                {
                    ApplicationArea = All;
                    Visible = Visib;
                }
                field("Internal ID2"; "Internal ID")
                {
                    ApplicationArea = all;

                }

                field("Employee ID2"; "Employee ID")
                {
                    ApplicationArea = all;
                }
                field("First Name2"; "First Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name2"; "Last Name")
                {
                    ApplicationArea = all;
                }
                field(StatusExt2; StatusExt)
                {
                    ApplicationArea = all;
                }
                field("Temporary Contract Type2"; "Temporary Contract Type")
                {
                    Visible = ShowContractType;

                }
                field("External employer Status2"; "External employer Status")
                {
                    Visible = ShowContractType;

                }

                field(Gender3; Gender)
                {

                }

            }
        }

        addlast(GeneralTEST)
        {
            group("Birth Information2")
            {
                Caption = 'Birth Information';
                field("Birth Date2"; "Birth Date")
                {
                    ApplicationArea = all;

                }

                field(Age2; Age)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Municipality Code of Birth2"; "Municipality Code of Birth")
                {
                    ApplicationArea = all;

                }
                field("Municipality Name of Birth2"; "Municipality Name of Birth")
                {
                    ApplicationArea = all;
                }
                field("City of Birth2"; "City of Birth")
                {
                    ApplicationArea = all;
                }
                field("Place of birth2"; "Place of birth")
                {
                    ApplicationArea = all;
                }
                field("Country/Region Code of Birth2"; "Country/Region Code of Birth")
                {

                    ApplicationArea = all;
                }

            }
        }



        addafter("Birth Information2")
        {
            group("Address information2")
            {
                Caption = 'Address information';

                field("Address CIPS2"; "Address CIPS")
                {
                    ApplicationArea = all;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        AlternativeAddress: Record "Alternative Address";
                        AlternativeAddressList: Page "Alternative Address List";
                    begin
                        AlternativeAddress.RESET;
                        AlternativeAddress.SETFILTER("Employee No.", "No.");
                        //AlternativeAddress.SETFILTER("Address Type",'CIPS');
                        AlternativeAddress.SETFILTER(Active, '%1', TRUE);
                        AlternativeAddressList.SETTABLEVIEW(AlternativeAddress);
                        AlternativeAddressList.RUN;
                        CurrPage.UPDATE;

                    end;
                }
                field("Place Of Living2"; "Place Of Living")
                {
                    ApplicationArea = all;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        AlternativeAddress: Record "Alternative Address";
                        AlternativeAddressList: Page "Alternative Address List";
                    begin
                        AlternativeAddress.RESET;
                        AlternativeAddress.SETFILTER("Employee No.", "No.");
                        //AlternativeAddress.SETFILTER("Address Type",'CIPS');
                        AlternativeAddress.SETFILTER(Active, '%1', TRUE);
                        AlternativeAddressList.SETTABLEVIEW(AlternativeAddress);
                        AlternativeAddressList.RUN;
                        CurrPage.UPDATE;

                    end;
                }
                field("Municipality Code CIPS2"; "Municipality Code CIPS")
                {
                    ApplicationArea = all;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        AlternativeAddress: Record "Alternative Address";
                        AlternativeAddressList: Page "Alternative Address List";
                    begin
                        AlternativeAddress.RESET;
                        AlternativeAddress.SETFILTER("Employee No.", "No.");
                        //AlternativeAddress.SETFILTER("Address Type",'CIPS');
                        AlternativeAddress.SETFILTER(Active, '%1', TRUE);
                        AlternativeAddressList.SETTABLEVIEW(AlternativeAddress);
                        AlternativeAddressList.RUN;
                        CurrPage.UPDATE;

                    end;
                }
                field("Municipality Name CIPS2"; "Municipality Name CIPS")
                {
                    ApplicationArea = all;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        AlternativeAddress: Record "Alternative Address";
                        AlternativeAddressList: Page "Alternative Address List";
                    begin
                        AlternativeAddress.RESET;
                        AlternativeAddress.SETFILTER("Employee No.", "No.");
                        //AlternativeAddress.SETFILTER("Address Type",'CIPS');
                        AlternativeAddress.SETFILTER(Active, '%1', TRUE);
                        AlternativeAddressList.SETTABLEVIEW(AlternativeAddress);
                        AlternativeAddressList.RUN;
                        CurrPage.UPDATE;

                    end;
                }
                field("City CIPS2"; "City CIPS")
                {
                    ApplicationArea = all;
                    Editable = false;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        AlternativeAddress: Record "Alternative Address";
                        AlternativeAddressList: Page "Alternative Address List";
                    begin
                        AlternativeAddress.RESET;
                        AlternativeAddress.SETFILTER("Employee No.", "No.");
                        //AlternativeAddress.SETFILTER("Address Type",'CIPS');
                        AlternativeAddress.SETFILTER(Active, '%1', TRUE);
                        AlternativeAddressList.SETTABLEVIEW(AlternativeAddress);
                        AlternativeAddressList.RUN;
                        CurrPage.UPDATE;

                    end;
                }
                field("Post Code CIPS2"; "Post Code CIPS")
                {
                    ApplicationArea = all;
                    DrillDown = true;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        AlternativeAddress: Record "Alternative Address";
                        AlternativeAddressList: Page "Alternative Address List";
                    begin
                        AlternativeAddress.RESET;
                        AlternativeAddress.SETFILTER("Employee No.", "No.");
                        //AlternativeAddress.SETFILTER("Address Type",'CIPS');
                        AlternativeAddress.SETFILTER(Active, '%1', TRUE);
                        AlternativeAddressList.SETTABLEVIEW(AlternativeAddress);
                        AlternativeAddressList.RUN;
                        CurrPage.UPDATE;

                    end;
                }
            }
        }
        addafter("Address information2")
        {
            group("Position Information2")
            {

                Caption = 'Position Information';


                field(EmployeeContractLedgerPositionCode2; EmployeeContractLedger."Position Code")
                {
                    Caption = 'Position Code';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(EmployeeContractLedgerPositionDescription2; EmployeeContractLedger."Position Description")
                {
                    Caption = 'Position Description';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                        IF EmployeeContractLedger.FINDFIRST THEN BEGIN
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                        END
                        ELSE BEGIN
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                        END;
                        CurrPage.UPDATE;
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                        IF EmployeeContractLedger.FINDFIRST THEN BEGIN
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                        END
                        ELSE BEGIN
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                        END;
                        CurrPage.UPDATE;

                    end;
                }
                /*field(DepartmentName; EmployeeContractLedger."Department Name")
                {
                    Caption = 'Department Name';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(SectorDescription; EmployeeContractLedger."Sector Description")
                {
                    Caption = 'Sector Description';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(Služba; EmployeeContractLedger."Department Cat. Description")
                {
                    Caption = 'Služba';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(Odjel; EmployeeContractLedger."Group Description")
                {
                    Caption = 'Odjel';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(StatusP; EmployeeContractLedger.Status)
                {
                    Caption = 'Status';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }*/
                field(Smjena2; EmployeeContractLedger."Rad u smjenama")
                {
                    Caption = 'Rad u smjenama';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin

                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(Management1_2; EmployeeContractLedger."Manager 1 Last Name" + ' ' + EmployeeContractLedger."Manager 1 First Name")
                {
                    Caption = 'Superior 1';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        CurrPage.UPDATE(TRUE);
                        SELECTLATESTVERSION;

                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE(true);
                    end;



                }

                field(Manager2_2; EmployeeContractLedger."Manager 2 Last Name" + ' ' + EmployeeContractLedger."Manager 2 First Name")
                {
                    Caption = 'Superior 2';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;


                    trigger OnDrillDown()
                    begin

                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }

                field(ECLManagementLevel_2; EmployeeContractLedger."Management Level")
                {
                    Caption = 'Management Level';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin

                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(EmployeeContractLedgerSector_2; EmployeeContractLedger.Sector)
                {
                    Caption = 'Sector';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLSectorDescription_2; "Sector Description")
                {
                    Caption = 'Sector';
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        CurrPage.Update();
                        SelectLatestVersion();
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLDepartmentCode_2; EmployeeContractLedger."Department Code")
                {
                    Caption = 'Department Code';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLDepartmentName_2; EmployeeContractLedger."Department Name")
                {
                    Caption = 'Department Name';
                    Editable = false;
                    Enabled = true;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                        IF EmployeeContractLedger.FINDFIRST THEN BEGIN
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                        END
                        ELSE BEGIN
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLDepartmentCategory_2; EmployeeContractLedger."Department Category")
                {
                    Caption = 'Department Category';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLDepartmentCatDescription_2; EmployeeContractLedger."Department Cat. Description")
                {
                    Caption = 'B-1 (with regions) Description';
                    Editable = false;
                    Enabled = true;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLGroup_2; EmployeeContractLedger.Group)
                {
                    Caption = 'Group';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLGroupDescription_2; EmployeeContractLedger."Group Description")
                {
                    Caption = 'Stream Description';
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                /*
                field(ECLTeam; EmployeeContractLedger.Team)
                {
                    Caption = 'Team';
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLTeamDescription; EmployeeContractLedger."Team Description")
                {
                    Caption = 'Team Description';
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLManager1FirstNameLastName; EmployeeContractLedger."Manager 1 First Name" + ' ' + EmployeeContractLedger."Manager 1 Last Name")
                {
                    Caption = 'Manager Full Name';
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        Emp.RESET;
                        Emp.SETFILTER("First Name", '%1', EmployeeContractLedger."Manager 1 First Name");
                        Emp.SETFILTER("Last Name", '%1', EmployeeContractLedger."Manager 1 Last Name");
                        EmpPage.SETTABLEVIEW(Emp);
                        EmpPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }*/
                field(ECLDepartmentCity_2; EmployeeContractLedger."Department City")
                {
                    Caption = 'Department City';
                    Editable = false;
                    Enabled = true;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLDepartmentAddress_2; EmployeeContractLedger."Department Address")
                {
                    Caption = 'Department Address';
                    Editable = false;
                    Enabled = true;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLOrgDio_2; EmployeeContractLedger."Org Dio")
                {
                    Caption = 'Org. Part';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        OrgDijelovi.RESET;
                        OrgDijelovi.SETFILTER(Code, EmployeeContractLedger."Org Dio");
                        OrgDijeloviPage.SETTABLEVIEW(OrgDijelovi);
                        OrgDijeloviPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLOrgDioName_2; EmployeeContractLedger."Org Dio Name")
                {
                    Caption = 'Org Dio Name';
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        OrgDijelovi.RESET;
                        OrgDijelovi.SETFILTER(Code, EmployeeContractLedger."Org Dio");
                        OrgDijeloviPage.SETTABLEVIEW(OrgDijelovi);
                        OrgDijeloviPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(ECLGFradacode_2; EmployeeContractLedger."GF rada code")
                {
                    Caption = 'GF of work';
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        OrgDijelovi.RESET;
                        OrgDijelovi.SETFILTER(Code, EmployeeContractLedger."Org Dio");
                        OrgDijeloviPage.SETTABLEVIEW(OrgDijelovi);
                        OrgDijeloviPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field("Default Dimension_2"; "Default Dimension")
                {
                    Editable = false;
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Default Dimension Name_2"; "Default Dimension Name")
                {
                    Editable = false;
                    Importance = Promoted;
                    MultiLine = false;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                    Width = 250;
                }
                /*field("Employee Benefits"; "Employee Benefits")
                {
                    ApplicationArea = all;
                }
                /*field("Job Violations"; "Job Violations")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnDrillDown()
                    begin
                        WDV.RESET;
                        WDV.SETFILTER("Employee No.", "No.");
                        WDVPAge.SETTABLEVIEW(WDV);
                        WDVPAge.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field("Disciplinary Measured"; "Disciplinary Measured")
                {
                    ApplicationArea = all;
                }
                field(Awards; Awards)
                {
                    DrillDownPageID = "Employee Award List";
                    LookupPageID = "Employee Award List";
                    ApplicationArea = all;
                }*/
                /*field(Clauses; Clauses)
                {
                    DrillDownPageID = Clauses;
                    LookupPageID = Clauses;
                    ApplicationArea = all;
                }
                field("Lawsuits/Labor Disputes"; "Lawsuits/Labor Disputes")
                {
                    DrillDownPageID = "Lawsuits/Labor Disputes List";
                    ApplicationArea = all;
                    LookupPageID = "Lawsuits/Labor Disputes List";
                }*/



            }
        }


        addafter(Administration2)
        {
            group("Employment End")
            {
                Caption = 'Employment End';
                // Editable = show;
                Visible = true;



                group("Termination of Employment")
                {
                    Caption = 'Termination of Employment';
                    field(TerminationDate; TerminationDate)
                    {
                        Caption = 'Ending Date';
                        Editable = false;
                        ApplicationArea = all;


                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER("Ending Date", '<>%1', 0D);
                            EmployeeContractLedger.SetFilter(Active, '%1', true);
                            EmployeeContractLedger.SetFilter("Grounds for Term. Description", '<>%1', '');
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    /*field("Termination Date2"; "Termination Date")
                    {
                        ApplicationArea = all;
                    }*/
                    field(EmployeeContractLedgerMannerofTermDescription; EmployeeContractLedger."Manner of Term. Description")
                    {
                        Caption = 'Manner of Termination Description';
                        Editable = false;
                        ApplicationArea = all;


                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER("Ending Date", '<>%1', 0D);
                            EmployeeContractLedger.SetFilter(Active, '%1', true);
                            EmployeeContractLedger.SetFilter("Manner of Term. Description", '<>%1', '');
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerGroundsforTermDescription; EmployeeContractLedger."Grounds for Term. Description")
                    {
                        Caption = 'Grounds for Termination Description';
                        Editable = false;
                        ApplicationArea = all;


                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER("Ending Date", '<>%1', 0D);
                            EmployeeContractLedger.SetFilter(Active, '%1', true);
                            EmployeeContractLedger.SetFilter("Grounds for Term. Description", '<>%1', '');
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);


                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    /*field(EmployeeContractLedgerExitInterview; EmployeeContractLedger."Exit Interview")
                    {
                        Caption = 'Exit Interview';
                        Editable = false;
                        ApplicationArea = all;
                        //   Visible = show;
                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER("Ending Date", '<>%1', 0D);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }*/
                }
                group(Inactivity)

                {
                    Caption = 'Inactivity';

                    field("Maner of termination"; EmployeeContractLedger."Manner of Term. Code")
                    {
                        Caption = 'Reason for termination';
                        Editable = false;
                        ApplicationArea = all;

                        //   Visible = show;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER("Contract Type Name", '%1', 'MIROVANJE');
                            EmployeeContractLedger.SetFilter(Active, '%1', true);
                            EmployeeContractLedger.SetFilter("Show Record", '%1', true);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerGroundsforTerm; EmployeeContractLedger."Grounds for Term. Description")
                    {
                        Caption = 'Grounds for Termination Description';
                        Editable = false;
                        ApplicationArea = all;


                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            //EmployeeContractLedger.SETFILTER("Ending Date", '<>%1', 0D);
                            EmployeeContractLedger.SetFilter("Show Record", '%1', true);
                            EmployeeContractLedger.SetFilter("Manner of Term. Code", '%1', 'MIROVANJE');
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EndingDate; EmployeeContractLedger."Ending Date")
                    {
                        Caption = 'Ending date of retirement';
                        Editable = false;
                        ApplicationArea = all;

                        //   Visible = show;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER("Contract Type Name", '%1', 'MIROVANJE');
                            EmployeeContractLedger.SetFilter("Show Record", '%1', true);
                            EmployeeContractLedger.SetFilter(Active, '%1', true);
                            EmployeeContractLedger.SetFilter("Show Record", '%1', true);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                }
            }
        }

        movebefore(Age; "Birth Date")
        //movebefore("Number of Children"; "Marital status")
        movebefore("Operator No."; "Last Date Modified")

        movebefore("Wage Type"; "Emplymt. Contract Code")
        moveafter("Wage Posting Group"; "Employee Posting Group")


        addafter("Country/Region Code")
        {
            field("Municipality Code"; Rec."Municipality Code")
            {
                ApplicationArea = all;

            }
            /*  field(County2; Canton)
              {
              }
              */
            field("Entity Code"; Rec."Entity Code")
            {
                ApplicationArea = all;

            }
        }


        addafter("Social Security No.")
        {


            field("Hard Work conditions"; Rec."Hard Work conditions")
            {
                ApplicationArea = all;

            }

            field("ID Issued in"; Rec."ID Issued in")
            {
                ApplicationArea = all;

            }




        }
        addafter("Salespers./Purch. Code")
        {
            field("Short Term Contract"; Rec."Short Term Contract")
            {

                ApplicationArea = all;
            }
            field("Short Term Contract Start Date"; Rec."Short Term Contract Start Date")
            {
                ApplicationArea = all;
            }
            field("Short Term Contract End Date"; Rec."Short Term Contract End Date")
            {
                ApplicationArea = all;
            }
        }


        addafter(Gender)
        {










            /*field(Size; Rec.Size)
            {
                ApplicationArea = all;
            }*/
            //field("Clothing size"; Rec."Clothing size") { ApplicationArea = all; }
            //field("Shoe size"; Rec."Shoe size") { ApplicationArea = all; }
            // field("Last Date Modified2"; Rec."Last Date Modified") { ApplicationArea = all; }
            //field("Salesperson Code"; Rec."Salesperson Code") { ApplicationArea = all; Visible = false; }
        }

        moveafter("E-mail user"; "Company E-Mail")
        moveafter("Dial Code Mobile"; "Mobile Phone No.")
        moveafter("Dial Code Home"; "Phone No.")
        movebefore("Related Person to be informed"; "E-Mail")


    }



    actions
    {
        // Add changes to page actions here




        modify("&Picture")
        {
            Promoted = false;
        }
        modify("Co&mments")
        {
            Promoted = false;
        }

        modify(Dimensions)
        {
            Promoted = false;
        }
        modify("&Confidential Information")
        {
            Promoted = false;
            Visible = false;
        }
        modify("Q&ualifications")
        {
            Promoted = false;
        }
        modify("A&bsences")
        {
            Promoted = false;
        }
        modify("Ledger E&ntries")
        {
            Promoted = false;
            Visible = false;
        }
        modify(Attachments)
        {
            Promoted = false;
            Visible = false;
        }
        modify(PayEmployee)
        {
            Promoted = false;
            Visible = false;
        }
        modify(Contact)
        {
            Promoted = false;
            Visible = false;
        }


        modify(AlternativeAddresses)
        {
            Visible = false;
        }
        modify("Misc. Articles &Overview")
        {
            Visible = false;
        }
        modify("Absences by Ca&tegories")
        {
            Visible = false;
        }
        modify("Co&nfidential Info. Overview")
        {
            Visible = false;
        }


        addafter(Dimensions)
        {

            // Add changes to page actions here
            action("Wage amount")
            {
                Caption = 'Wage Amounts';
                Image = AmountByPeriod;
                RunObject = page "Wage Amounts";
                ApplicationArea = all;
                RunPageLink = "Employee No." = field("No.");
                Promoted = true;
            }

            action("Employee Default dimension")
            {
                Caption = 'Employee Default dimension';
                ApplicationArea = all;
                Image = Dimensions;
                RunObject = page "Employee Default Dimension";
                RunPageLink = "No." = field("No.");
                Promoted = true;

            }




        }
        addafter("&Picture")
        {
            /*action("Import picture")
            {
                Caption = 'Import picture';
                ApplicationArea = all;
                Image = Picture;
                RunObject = report picture_import;
            }*/


        }
        modify("Mi&sc. Article Information")
        {
            Visible = false;
        }


        addafter("&Relatives")
        {
            //List of Surnames

            action("List of Surnames")
            {
                Caption = 'List of Surnames';

                ApplicationArea = all;
                Image = List;
                RunObject = Page "Employee Surname";
                RunPageLink = "No." = field("No.");
                Promoted = true;


            }

            action(Nationality)
            {
                Caption = 'Nationality';
                Image = Customer;
                ApplicationArea = all;
                RunObject = Page "Personal Documents";
                RunPageLink = "Employee No." = FIELD("No."),
                                      Switch = FILTER('Nationality');

                Promoted = true;
            }
            action(Citizenship)
            {
                Caption = 'Citizenship';
                Image = Card;
                ApplicationArea = all;
                RunObject = Page "Personal Documents";
                RunPageLink = "Employee No." = FIELD("No."),
                                      Switch = FILTER('Citizenship');

                Promoted = true;
            }
            action(Passport)
            {
                Caption = 'Passport';
                Image = Certificate;
                ApplicationArea = all;
                RunObject = Page "Personal Documents";
                RunPageLink = "Employee No." = FIELD("No."),
                                      Switch = FILTER('Passport');
                Promoted = true;
            }
            action("Residence Permit2")
            {
                Caption = 'Residence Permit';
                Image = ClosePeriod;
                Visible = false;
                ApplicationArea = all;
                RunObject = Page "Personal Documents";
                RunPageLink = "Employee No." = FIELD("No."),
                                      Switch = FILTER('Residence Permit');
                Promoted = true;
            }
            action("Social Security")
            {
                Caption = 'Social Security';
                Image = SocialSecurity;
                ApplicationArea = all;
                RunObject = Page "Personal Documents";
                RunPageLink = "Employee No." = FIELD("No."),
                                      Switch = FILTER('Social Security');
                Promoted = true;
            }
            action("ID Card")
            {
                Caption = 'ID Card';
                Image = Indent;
                RunObject = Page "Personal Documents";
                ApplicationArea = all;
                RunPageLink = "Employee No." = FIELD("No."),
                                      Switch = FILTER('IDCard');
                Promoted = true;
            }
            action("Work Permit2")
            {
                Caption = 'Work Permit';
                Visible = false;
                Image = WorkCenter;
                RunObject = Page "Personal Documents";
                ApplicationArea = all;
                RunPageLink = "Employee No." = FIELD("No."),
                                      Switch = FILTER('Work Permit');
                Promoted = true;
            }
            /*action("Brought Work experience")
            {
                Caption = 'Brought Work experience';
                Image = CalendarChanged;
                RunObject = Page "Brought Work experience";
                ApplicationArea = all;
            }*/
            action("Work Booklet3")
            {
                Caption = 'Work Booklet';
                Image = Workdays;
                ApplicationArea = all;
                /*RunObject = Page "Work booklet";
                RunPageLink = "Employee No." = FIELD("No.");*/
                RunPageMode = View;
                Promoted = true;
                //ĐK


                trigger OnAction()
                begin
                    CurrPage.UPDATE(TRUE);
                    SELECTLATESTVERSION;
                    CLEAR(WOrkB);
                    WorkBooklet.RESET;
                    WorkBooklet.SETFILTER("Employee No.", '%1', "No.");
                    WOrkB.SETTABLEVIEW(WorkBooklet);
                    WOrkB.RUNMODAL;
                    CurrPage.UPDATE(TRUE);
                    //MESSAGE(FORMAT("Years of Experience in Company"));
                end;

            }
            action("Alternative Addresses (Current)")
            {
                Caption = 'Alternative Addresses';
                Image = AlternativeAddress;
                ApplicationArea = all;
                RunObject = Page "Alternative Address List";
                RunPageLink = "Employee No." = FIELD("No."),
                                      "Address Type" = FILTER('Current');
                Promoted = true;
            }
            action("Alternative Addresses (CIPS)")
            {
                Caption = 'Alternative Addresses (CIPS)';
                Image = AlternativeAddress;
                ApplicationArea = all;
                RunObject = Page "Alternative Address List";
                RunPageLink = "Employee No." = FIELD("No."),
                                      "Address Type" = FILTER(CIPS);
                Promoted = true;
            }
            action("Page Employee Contract Ledger")
            {
                Caption = 'Employee Contract Ledger';
                Image = ContractPayment;
                ApplicationArea = all;
                RunObject = Page "Employee Contract Ledger";
                RunPageLink = "Employee No." = FIELD("No.");
                RunPageMode = Edit;
                RunPageView = WHERE("Show Record" = FILTER(true));
                Visible = true;
                Promoted = true;
            }
            /*action("Career Development")
            {
                Caption = 'Career Development';
                Image = MovementWorksheet;
                ApplicationArea = all;
                RunObject = Page "Career Development";
                RunPageLink = "Employee No." = FIELD("No.");
                Visible = false;
            }*/
            action(Qualifications2)
            {
                Caption = 'Qualifications';
                Image = Certificate;
                ApplicationArea = all;
                RunObject = Page "Employee Qualifications";
                RunPageLink = "Employee No." = FIELD("No.");
                Promoted = true;
            }
            /*action("Additional Activity")
            {
                Caption = 'Additional Activity';
                Image = "Action";
                ApplicationArea = all;
                RunObject = Page "Employee Activities";
                RunPageLink = "Employee No." = FIELD("No.");
            }*/
            action(Unions2)
            {
                Caption = 'Unions';
                Image = EmployeeAgreement;
                ApplicationArea = all;
                RunObject = Page "Union Employees";
                RunPageLink = "Employee No." = FIELD("No.");
                Promoted = true;
            }
            action("Employee Diseases2")
            {
                Caption = 'Employee Diseases';
                Image = Category;
                ApplicationArea = all;
                RunObject = Page "Employee Diseases";
                RunPageLink = "Employee No." = FIELD("No.");
                Promoted = true;
            }
            action("Employee Blood Donors")
            {
                Caption = 'Employee Blood Donors';
                Image = AddAction;
                ApplicationArea = all;
                RunObject = Page "Employee Bood Donations";
                RunPageLink = "Employee No." = FIELD("No.");
                Promoted = true;
            }
            action("Employee Level Of Disability")
            {
                Caption = 'Employee Level Of Disability';
                Image = Job;
                ApplicationArea = all;
                RunObject = Page "Employee Level Of Disability";
                RunPageLink = "Employee No." = FIELD("No.");
                Promoted = true;
            }
            action(Languages)
            {
                Caption = 'Employee languages';
                Image = Language;
                ApplicationArea = all;
                RunObject = Page "Employee languages";
                RunPageLink = "Employee No." = FIELD("No.");
                Promoted = true;
            }
            action("Employee Computer Knowledge2")
            {
                Caption = 'Employee Computer Knowledge';
                Image = Account;
                RunObject = Page "Employee Qualifications";
                RunPageLink = "Employee No." = FIELD("No.");
                Promoted = true;
            }
            action("Page Misc. Article Information")
            {
                Caption = 'Misc. Article Information';
                Image = Filed;
                ApplicationArea = all;
                RunObject = Page "Misc Article Informations";
                RunPageLink = "Employee No." = FIELD("No.");
                Promoted = true;
            }
            action("Education History")
            {
                Caption = 'Education History';
                Image = Employee;
                Promoted = true;
                ApplicationArea = all;
                RunPageLink = "Employee No." = FIELD("No.");
                RunObject = Page "Education History";

                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = false;

            }

            /*action("Health Check")
            {
                Caption = 'Health Check';
                Image = Receipt;
                ApplicationArea = all;
                RunObject = Page "Health Check";
                RunPageLink = "Employee No" = FIELD("No.");
            }*/

            //ED 01 START
            action("Employee absence")
            {
                Caption = 'Employee Absence';
                Image = Workdays;
                RunObject = page "Employee Absence";
                RunPageLink = "Employee No." = FIELD("No.");
                Promoted = true;
            }

            action("Work performance")
            {
                Caption = 'Work performance';
                Image = Evaluate;
                //    RunObject = page "Work performance";
                //  RunPageLink = "Employee No." = FIELD("No.");
                Promoted = true;
                Visible = false;

            }

            //ED 01 END

        }
        addafter("Employee absence")
        {
            action(Rješenja)
            {
                Caption = 'Rješenja';
                Image = Report;
                //ĐK   RunObject = report VacationDecision;
                ApplicationArea = all;
                //RunPageLink = "Employee No." = field("Employee No.");

                Promoted = true;

                trigger OnAction()
                begin
                    Vacation.Reset();
                    Vacation.SetFilter("Employee No.", Rec."No.");

                    VacationDecisionR.SETTABLEVIEW(Vacation);
                    VacationDecisionR.RUN;


                end;

            }
            action("Employee Training Ledger")
            {

                Caption = 'Employee Training Ledger';
                Image = Ledger;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = page "Employee Trainings Ledger";
                RunPageLink = "Employee No." = field("Employee No.");
            }



        }

    }


    trigger OnOpenPage()
    var
        UserS: Record "User Setup";
        ECl: Record "Employee Contract Ledger";
        HR: Record "Human Resources Setup";
        UTemp: Record "User Setup";
        HRAllowed: Boolean;
        WagesAllowed: Boolean;
        CU: Codeunit TestSubsCu;
    begin


        UTemp.Reset();
        UTemp.SetFilter("User ID", '%1', UserId);
        if UTemp.FindFirst() then
            HRAllowed := UTemp.HR;
        WagesAllowed := UTemp."Wage Allowed";

        /*if NOT HRAllowed then
            Error(CU.HRNotAllowed());


        if NOT WagesAllowed then
            Error(CU.WagesNotAllowed());*/

        if NOT HRAllowed AND NOT WagesAllowed and not UTemp."CNG Administrator" then
            Error(CU.HRNotAllowed());



        UserS.Reset();
        UserS.setfilter("User ID", '%1', USERID);
        UserS.SetFilter("CNG Administrator", '%1', true);
        if users.FindFirst() then
            Visib := true
        else
            Visib := false;


        ECl.Reset();
        HR.get;
        ECl.SetFilter("Position Description", '<>%1', '');
        ECl.SetFilter(Active, '%1', true);
        ECl.SetFilter("Show Record", '%1', true);
        if ecl.FindSet() then
            repeat
            //   ECl.Validate("Position Description", ECl."Position Description");
            //ECl.Modify();


            until ecl.Next() = 0;


        UserPersonalisation.RESET;
        UserPersonalisation.SETFILTER("User ID", USERID);
        IF UserPersonalisation.FINDFIRST THEN BEGIN
            IF ((UserPersonalisation."Profile ID" <> 'PAYROLL')) THEN
                show := TRUE
            ELSE
                show := FALSE;
        END;
        if (StatusExt = StatusExt::"External employee") or (StatusExt = StatusExt::Practicians)
        or (StatusExt = StatusExt::"Temporary Contract") or (StatusExt = StatusExt::Volonteer) then
            ShowContractType := true
        else
            ShowContractType := false;
        UserS.Reset();
        UserS.SetFilter("User ID", '%1', UserId);
        if UserS.FindFirst() then begin
            if UserS."Employee Status" = true
            then
                ShowContractType := false
            else
                ShowContractType := true;
        end;

        if ShowContractType = true then
            ShowContractType2 := false
        else
            ShowContractType2 := true;

        UserPersonalisation2.RESET;
        UserPersonalisation2.SETFILTER("User ID", USERID);
        IF UserPersonalisation2.FINDFIRST THEN BEGIN
            IF ((UserPersonalisation2."Profile ID" <> 'LEGAL')) THEN
                show2 := TRUE
            ELSE
                show2 := FALSE;
        END;

        IF "Birth Date" <> 0D THEN
            VALIDATE("Birth Date", Rec."Birth Date");


        IF "No." <> '' THEN BEGIN
            EmployeeContractLedger.RESET;
            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
            IF EmployeeContractLedger.FINDFIRST THEN BEGIN
                IF EmployeeContractLedger."Employment Abroad" = FALSE THEN
                    EmploymentAbroadVisible := TRUE
                ELSE
                    EmploymentAbroadVisible := FALSE;
                IF EmployeeContractLedger."Ending Date" = 0D THEN
                    TerminationVisible := TRUE
                ELSE
                    TerminationVisible := FALSE;
            END;
        END;

        TerminationDate := 0D;
        IF "No." <> '' THEN BEGIN
            EmployeeContractLedger.RESET;
            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
            IF EmployeeContractLedger.FINDLAST THEN BEGIN
                EmployeeContractLedger.CALCFIELDS("Minimal Education Level");
                EmployeeContractLedger.CALCFIELDS("Residence/Network", "Manager 1 First Name", "Manager 1 Last Name");
                EmployeeContractLedger.CALCFIELDS("Phisical Org Dio", "Phisical Org Dio Name", "Org Dio Name");
                IF (EmployeeContractLedger."Grounds for Term. Code" <> '') AND (EmployeeContractLedger."Ending Date" <> 0D) THEN
                    TerminationDate := EmployeeContractLedger."Ending Date"
                ELSE
                    TerminationDate := 0D;
                /*showMC := EmployeeContractLedger."Manager Contract";
                Position.RESET;
                Position.SETFILTER("Employee No.", '%1', "No.");
                IF Position.FINDLAST THEN BEGIN
                    //Position.CALCFIELDS("SAP 1");
                    //Position.CALCFIELDS("SAP 2");
                    ManagementLevel := '';
                    SegmentationGroup.RESET;
                    SegmentationGroup.SETFILTER("Position No.", '%1', Position.Code);
                    SegmentationGroup.SETFILTER("Segmentation Name", '%1', EmployeeContractLedger."Position Description");
                    SegmentationGroup.SETFILTER(Coefficient, '<>%1', 0);
                    SegmentationGroup.SETFILTER("Ending Date", '%1', 0D);
                    IF SegmentationGroup.FIND('+') THEN
                        ManagementLevel := FORMAT(SegmentationGroup."Management Level");*/


                //ContractType:='';
                /*
                EC.SETFILTER(Code,'%1',EmployeeContractLedger."Contract Type");
                IF EC.FIND('-')
                  THEN ContractType:=EC.Description
                ELSE
                  ContractType:='';*/



            END
            ELSE BEGIN
                EmployeeContractLedger.RESET;
                EmployeeContractLedger."Position Code" := '';
                EmployeeContractLedger."Position Description" := '';
                EmployeeContractLedger."Minimal Education Level" := 0;

                EmployeeContractLedger."Department Code" := '';
                EmployeeContractLedger."Department Name" := '';
                EmployeeContractLedger."Department Address" := '';
                EmployeeContractLedger."Department City" := '';
                EmployeeContractLedger."Sector Description" := '';
                EmployeeContractLedger."Department Cat. Description" := '';
                EmployeeContractLedger."Group Description" := '';
                EmployeeContractLedger."Team Description" := '';
                EmployeeContractLedger.Sector := '';
                EmployeeContractLedger."Department Category" := '';
                EmployeeContractLedger.Group := '';
                EmployeeContractLedger.Team := '';
                // EmployeeContractLedger."Management L
                EmployeeContractLedger."Management Level" := EmployeeContractLedger."Management Level"::Empty;
            END;

        END;

        IF "No." <> '' THEN BEGIN
            EmployeeCIPSAddress.RESET;
            EmployeeCIPSAddress.SETFILTER("Employee No.", '%1', "No.");
            IF EmployeeCIPSAddress.FINDFIRST THEN BEGIN
                IF EmployeeCIPSAddress."Entity Code CIPS" = 'RS' THEN
                    IsVisible := TRUE
                ELSE
                    IsVisible := FALSE;

            END;
        END;





        IF "No." <> '' THEN BEGIN
            WorkBooklet.RESET;
            WorkBooklet.SETFILTER("Employee No.", "No.");
            WorkBooklet.SETFILTER("Current Company", '%1', TRUE);
            WorkBooklet.SETFILTER("Hours change", '%1', FALSE);
            IF WorkBooklet.FINDLAST THEN;
        END;

        IF "No." <> '' THEN BEGIN
            AdditionalEducation.RESET;
            AdditionalEducation.SETFILTER("Employee No.", "No.");
            AdditionalEducation.SETFILTER(Active, '%1', TRUE);
            //AdditionalEducation.SETFILTER(Finished,'%1',TRUE);
            IF AdditionalEducation.FINDFIRST THEN;
            IF NOT AdditionalEducation.FINDFIRST THEN BEGIN
                AdditionalEducation."Vocation Description" := '';
                AdditionalEducation."Profession Description" := '';
            END;
        END;

        IF "No." <> '' THEN BEGIN
            PersonalDocumentsCit1.RESET;
            PersonalDocumentsCit1.SETFILTER("Employee No.", "No.");
            PersonalDocumentsCit1.SETFILTER(Switch, 'Citizenship');
            PersonalDocumentsCit1.SETFILTER("Citizenship Option", 'Primary');
            PersonalDocumentsCit1.SETFILTER(Active, '%1', TRUE);
            IF PersonalDocumentsCit1.FINDFIRST THEN;
            IF NOT PersonalDocumentsCit1.FINDFIRST THEN PersonalDocumentsCit1."Citizenship Description" := '';


        END;


        IF "No." <> '' THEN BEGIN
            PersonalDocumentsCit2.RESET;
            PersonalDocumentsCit2.SETFILTER("Employee No.", "No.");
            PersonalDocumentsCit2.SETFILTER(Switch, 'Citizenship');
            PersonalDocumentsCit2.SETFILTER("Citizenship Option", 'Secondary');
            PersonalDocumentsCit2.SETFILTER(Active, '%1', TRUE);
            IF PersonalDocumentsCit2.FINDFIRST THEN;
            IF NOT PersonalDocumentsCit2.FINDFIRST THEN PersonalDocumentsCit2."Citizenship Description" := '';
        END;

        IF "No." <> '' THEN BEGIN
            PersonalDocumentsNat.RESET;
            PersonalDocumentsNat.SETFILTER("Employee No.", "No.");
            PersonalDocumentsNat.SETFILTER(Switch, 'Nationality');
            PersonalDocumentsNat.SETFILTER(Active, '%1', TRUE);
            IF PersonalDocumentsNat.FINDFIRST THEN;
        END;

        IF "No." <> '' THEN BEGIN
            EmployeeDisability1.RESET;
            EmployeeDisability1.SETFILTER("Employee No.", "No.");
            EmployeeDisability1.SETFILTER(Active, '%1', TRUE);
            IF EmployeeDisability1.FINDFIRST THEN;
            IF NOT EmployeeDisability1.FINDFIRST THEN BEGIN
                EmployeeDisability1."Level of Disability" := '';
                EmployeeDisability1.Description := '';
            END;
        END;

        /*IF "No." <> '' THEN BEGIN
            EmployeeActivities1.RESET;
            EmployeeActivities1.SETFILTER("Employee No.", "No.");
            EmployeeActivities1.SETFILTER(Active, '%1', TRUE);
            IF EmployeeActivities1.FINDFIRST THEN;
            IF NOT EmployeeActivities1.FINDFIRST THEN BEGIN
                EmployeeActivities1.Description := '';
                EmployeeActivities1."Date From" := 0D;
                EmployeeActivities1."Date To" := 0D;
            END;
        END;*/

        IF "No." <> '' THEN BEGIN
            UnionEmployees1.RESET;
            UnionEmployees1.SETFILTER("Employee No.", "No.");
            UnionEmployees1.SetFilter(Types, '%1', UnionEmployees1.Types::"Union Employees");
            UnionEmployees1.SETFILTER(Active, '%1', TRUE);
            IF UnionEmployees1.FINDFIRST THEN;
            IF NOT UnionEmployees1.FINDFIRST THEN
                UnionEmployees1."Union Name" := '';
        END;

        IF "No." <> '' THEN BEGIN
            EmployeeRelative.RESET;
            EmployeeRelative.SETFILTER("Relative's Employee No.", '%1', '');
            EmployeeRelative.SETFILTER("Employee No.", '%1', "No.");
            IF EmployeeRelative.FINDSET THEN
                RelativesEmployees := EmployeeRelative.COUNT;
        END;

        MotherName := '';
        MothersMaidenName := '';
        EmployeeRelative.SETFILTER("Employee No.", "No.");
        EmployeeRelative.SETFILTER(Relation, 'Mother');
        IF EmployeeRelative.FIND('+') THEN BEGIN
            MotherName := EmployeeRelative."First Name";
            MothersMaidenName := EmployeeRelative."Mother's Maiden Name";
        END
        ELSE BEGIN
            MotherName := '';
            MothersMaidenName := '';
        END;

        EmployeeContractLedger.RESET;
        IF EmployeeContractLedger."Employment Abroad" = TRUE THEN BEGIN
            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
            IF EmployeeContractLedger.FINDLAST THEN BEGIN
                StartDate := EmployeeContractLedger."Starting Date";
                EndDate := EmployeeContractLedger."Ending Date";
            END;
        END
        ELSE BEGIN
            StartDate := 0D;
            EndDate := 0D;
        END;

        EmploymentDate := 0D;
        wb.RESET;
        wb.SETFILTER("Employee No.", "No.");
        wb.SETFILTER("Current Company", '%1', TRUE);
        wb.SETCURRENTKEY("Starting Date");
        wb.SETFILTER("Hours change", '%1', FALSE);
        wb.ASCENDING;
        IF wb.FINDLAST THEN BEGIN
            EmploymentDate := wb."Starting Date"
        END
        ELSE BEGIN
            EmploymentDate := 0D;
        END;


        if GlobalLanguage = 1033 then
            ThisMonthFirst := CALCDATE('-CM', WORKDATE)
        else
            ThisMonthFirst := CALCDATE('-SM;', WORKDATE);

        if GlobalLanguage = 1033 then
            ThisMonthLast := CALCDATE('CM', WORKDATE)
        else
            ThisMonthLast := CALCDATE('SM', ThisMonthFirst);


        if GlobalLanguage = 1033 then
            NextMonthFirst := CALCDATE('CM', ThisMonthLast)
        else
            NextMonthFirst := CALCDATE('+SD', ThisMonthLast);


        if GlobalLanguage = 1033 then
            NextMonthLast := CALCDATE('CM', NextMonthFirst)
        else
            NextMonthLast := CALCDATE('SM', NextMonthFirst);

        if GlobalLanguage = 1033 then
            ThisYearFirst := CALCDATE('-CY', WORKDATE)
        else
            ThisYearFirst := CALCDATE('-SG;', WORKDATE);

        if GlobalLanguage = 1033 then
            ThisYearLast := CALCDATE('CY', WORKDATE)
        else
            ThisYearLast := CALCDATE('SG;', WORKDATE);
        SETRANGE("Date Filter 2", ThisMonthFirst, ThisMonthLast);
        SETRANGE("Date Filter 3", ThisYearFirst, ThisYearLast);
        //SETRANGE("Year Filter",ThisYear);
        "Year Filter" := ThisYear;

        SelectLatestVersion();

    end;

    trigger OnAfterGetCurrRecord()
    begin
        if (StatusExt = StatusExt::"External employee") or (StatusExt = StatusExt::Practicians)
   or (StatusExt = StatusExt::"Temporary Contract") or (StatusExt = StatusExt::Volonteer) then
            ShowContractType := true
        else
            ShowContractType := false;
        if ShowContractType = true then
            ShowContractType2 := false
        else
            ShowContractType2 := true;
    end;


    //

    trigger OnAfterGetRecord()

    begin
        UserS.Reset();
        UserS.setfilter("User ID", '%1', USERID);
        UserS.SetFilter("CNG Administrator", '%1', true);
        if users.FindFirst() then
            Visib := true
        else
            Visib := false;

        IF "Birth Date" <> 0D THEN BEGIN
            DayOfWeekInput := 2;
            WeekOfYearInput := 1;
            AgeT := (TODAY - "Birth Date") / 365.2425;
            Age := AgeT DIV 1;
        END
        ELSE BEGIN

            Age := 0;
        END;
        CalcFields("Employee User Name");

        if "No." <> '' then begin

            if (StatusExt = StatusExt::"External employee") or (StatusExt = StatusExt::Practicians)
                  or (StatusExt = StatusExt::"Temporary Contract") or (StatusExt = StatusExt::Volonteer) then
                ShowContractType := true
            else
                ShowContractType := false;

            if ShowContractType = true
            then
                ShowContractType2 := false
            else
                ShowContractType2 := true;
        end;
        TerminationDate := 0D;
        IF "No." <> '' THEN BEGIN
            EmployeeContractLedger.RESET;
            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
            IF EmployeeContractLedger.FINDLAST THEN BEGIN
                EmployeeContractLedger.CALCFIELDS("Minimal Education Level");
                EmployeeContractLedger.CALCFIELDS("Residence/Network", "Manager 1 First Name", "Manager 1 Last Name", "Manager 2 First Name", "Manager 2 Last Name");
                EmployeeContractLedger.CALCFIELDS("Phisical Org Dio", "Phisical Org Dio Name", "Org Dio Name");
                showMC := EmployeeContractLedger."Manager Contract";
                IF (EmployeeContractLedger."Grounds for Term. Code" <> '') AND (EmployeeContractLedger."Ending Date" <> 0D) THEN
                    TerminationDate := EmployeeContractLedger."Ending Date"
                ELSE
                    TerminationDate := 0D;
                /*Position.RESET;
                Position.SETFILTER("Employee No.", '%1', "No.");
                IF Position.FINDLAST THEN BEGIN
                    Position.CALCFIELDS("SAP 1");
                    Position.CALCFIELDS("SAP 2");
                    ManagementLevel := '';
                    SegmentationGroup.RESET;
                    SegmentationGroup.SETFILTER("Position No.", '%1', Position.Code);
                    SegmentationGroup.SETFILTER("Segmentation Name", '%1', EmployeeContractLedger."Position Description");
                    SegmentationGroup.SETFILTER(Coefficient, '<>%1', 0);
                    SegmentationGroup.SETFILTER("Ending Date", '%1', 0D);
                    IF SegmentationGroup.FIND('+') THEN
                        ManagementLevel := FORMAT(SegmentationGroup."Management Level");
                END;*/

                ContractType := '';
                EC.SETFILTER(Code, '%1', EmployeeContractLedger."Contract Type");
                IF EC.FIND('-')
                  THEN
                    ContractType := EC.Description
                ELSE
                    ContractType := '';

            END
            ELSE BEGIN
                EmployeeContractLedger."Ending Date" := 0D;
                EmployeeContractLedger."Manner of Term. Description" := '';
                EmployeeContractLedger."Grounds for Term. Description" := '';
                EmployeeContractLedger."Exit Interview" := FALSE;
                EmployeeContractLedger.Brutto := 0;
                EmployeeContractLedger.Netto := 0;
                EmployeeContractLedger."Wage Type" := 0;
                EmployeeContractLedger."First Time Employed" := FALSE;
                EmployeeContractLedger."Way of Employment" := 0;
                EmployeeContractLedger.Prentice := FALSE;
                EmployeeContractLedger."Contract Type" := '';
                EmployeeContractLedger."Starting Date" := 0D;
                EmployeeContractLedger."Testing Period" := FALSE;
                EmployeeContractLedger."Testing Period Ending Date" := 0D;
                EmployeeContractLedger."Testing Period Starting Date" := 0D;
                EmployeeContractLedger."Testing Period Successful" := 0;
                EmployeeContractLedger.IS := FALSE;
                EmployeeContractLedger."IS Date From" := 0D;
                EmployeeContractLedger."IS Date To" := 0D;
                EmployeeContractLedger."Control Function" := FALSE;
                EmployeeContractLedger."Control Function From" := 0D;
                EmployeeContractLedger."Control Function To" := 0D;
                EmployeeContractLedger."Additional Benefits" := FALSE;
                EmployeeContractLedger."Prohibition of Competition" := FALSE;

                EmployeeContractLedger."POC Starting Date" := 0D;
                EmployeeContractLedger."POC Ending Date" := 0D;
                EmployeeContractLedger."Position Code" := '';
                EmployeeContractLedger."Position Description" := '';
                EmployeeContractLedger."Minimal Education Level" := 0;

                EmployeeContractLedger."Department Code" := '';
                EmployeeContractLedger."Department Name" := '';
                EmployeeContractLedger."Department Address" := '';
                EmployeeContractLedger."Department City" := '';
                EmployeeContractLedger."Sector Description" := '';
                EmployeeContractLedger."Department Cat. Description" := '';
                EmployeeContractLedger."Group Description" := '';
                EmployeeContractLedger."Team Description" := '';
                EmployeeContractLedger.Sector := '';
                EmployeeContractLedger."Department Category" := '';
                EmployeeContractLedger.Group := '';
                EmployeeContractLedger.Team := '';
                EmployeeContractLedger.Sector := '';
                EmployeeContractLedger."Department Category" := '';
                EmployeeContractLedger.Group := '';
                EmployeeContractLedger.Team := '';
                EmployeeContractLedger."Management Level" := EmployeeContractLedger."Management Level"::Empty;
                EmployeeContractLedger.RESET;
            END;
        END;
        /*
        BEGIN
        IF EmployeeContractLedger."Employment Abroad"=FALSE THEN
          EmploymentAbroadVisible:=TRUE
          ELSE
          EmploymentAbroadVisible:=FALSE;
        IF EmployeeContractLedger."Ending Date"=0D THEN
          TerminationVisible:=TRUE
          ELSE
          TerminationVisible:=FALSE;
        END;
        END;
        */
        IF "No." <> '' THEN BEGIN
            WorkBooklet.RESET;
            WorkBooklet.SETFILTER("Employee No.", "No.");
            WorkBooklet.SETFILTER("Current Company", '%1', TRUE);
            WorkBooklet.SETFILTER("Hours change", '%1', FALSE);
            IF WorkBooklet.FINDLAST THEN;
        END;



        IF "No." <> '' THEN BEGIN
            AdditionalEducation.RESET;
            AdditionalEducation.SETFILTER("Employee No.", "No.");
            AdditionalEducation.SETFILTER(Active, '%1', TRUE);
            IF AdditionalEducation.FINDLAST THEN;
            IF NOT AdditionalEducation.FINDFIRST THEN BEGIN
                AdditionalEducation."Vocation Description" := '';
                AdditionalEducation."Profession Description" := '';
            END;
        END;

        IF "No." <> '' THEN BEGIN
            PersonalDocumentsCit1.RESET;
            PersonalDocumentsCit1.SETFILTER("Employee No.", "No.");
            PersonalDocumentsCit1.SETFILTER(Switch, 'Citizenship');
            PersonalDocumentsCit1.SETFILTER("Citizenship Option", 'Primary');
            PersonalDocumentsCit1.SETFILTER(Active, '%1', TRUE);
            IF PersonalDocumentsCit1.FINDFIRST THEN;
            IF NOT PersonalDocumentsCit1.FINDFIRST THEN PersonalDocumentsCit1."Citizenship Description" := '';
        END;

        IF "No." <> '' THEN BEGIN
            PersonalDocumentsCit2.RESET;
            PersonalDocumentsCit2.SETFILTER("Employee No.", "No.");
            PersonalDocumentsCit2.SETFILTER(Switch, 'Citizenship');
            PersonalDocumentsCit2.SETFILTER("Citizenship Option", 'Secondary');
            PersonalDocumentsCit2.SETFILTER(Active, '%1', TRUE);
            IF PersonalDocumentsCit2.FINDFIRST THEN;
            IF NOT PersonalDocumentsCit2.FINDFIRST THEN PersonalDocumentsCit2."Citizenship Description" := '';
        END;

        IF "No." <> '' THEN BEGIN
            PersonalDocumentsNat.RESET;
            PersonalDocumentsNat.SETFILTER("Employee No.", "No.");
            PersonalDocumentsNat.SETFILTER(Switch, 'Nationality');
            PersonalDocumentsNat.SETFILTER(Active, '%1', TRUE);
            IF PersonalDocumentsNat.FINDFIRST THEN;
        END;

        IF "No." <> '' THEN BEGIN
            EmployeeDisability1.RESET;
            EmployeeDisability1.SETFILTER("Employee No.", "No.");
            EmployeeDisability1.SETFILTER(Active, '%1', TRUE);
            IF EmployeeDisability1.FINDFIRST THEN;
            IF NOT EmployeeDisability1.FINDFIRST THEN BEGIN
                EmployeeDisability1."Level of Disability" := '';
                EmployeeDisability1.Description := '';
            END;
        END;

        /*IF "No." <> '' THEN BEGIN
            EmployeeActivities1.RESET;
            EmployeeActivities1.SETFILTER("Employee No.", "No.");
            EmployeeActivities1.SETFILTER(Active, '%1', TRUE);
            IF EmployeeActivities1.FINDFIRST THEN;
            IF NOT EmployeeActivities1.FINDFIRST THEN BEGIN
                EmployeeActivities1.Description := '';
                EmployeeActivities1."Date From" := 0D;
                EmployeeActivities1."Date To" := 0D;
            END;
        END;*/
        EmploymentDate := 0D;
        wb.RESET;
        wb.SETFILTER("Employee No.", "No.");
        wb.SETFILTER("Current Company", '%1', TRUE);
        wb.SETCURRENTKEY("Starting Date");
        wb.SETFILTER("Hours change", '%1', FALSE);
        wb.ASCENDING;
        IF wb.FINDLAST THEN BEGIN
            EmploymentDate := wb."Starting Date"
        END
        ELSE BEGIN
            EmploymentDate := 0D;
        END;
        IF "No." <> '' THEN BEGIN
            UnionEmployees1.RESET;
            UnionEmployees1.SETFILTER("Employee No.", "No.");
            UnionEmployees1.SETFILTER(Active, '%1', TRUE);
            UnionEmployees1.SetFilter(Types, '%1', UnionEmployees1.Types::"Union Employees");
            IF UnionEmployees1.FINDFIRST THEN;
            IF NOT UnionEmployees1.FINDFIRST THEN
                UnionEmployees1."Union Name" := '';
        END;

        /* CareerDevelopment.RESET;
         CareerDevelopment.SETFILTER("Employee No.", "No.");
         IF CareerDevelopment.FINDLAST THEN;*/
        SelectLatestVersion();

    end;

    trigger OnModifyRecord(): Boolean
    var
        myInt: Integer;
        Text011: Label 'Would you like to save the changes?';
    begin
        IF NOT CONFIRM(Text011, FALSE) THEN BEGIN
            Rec := xRec;
            xRec.TRANSFERFIELDS(Rec);
            CurrPage.UPDATE(FALSE);


        end;
    end;




    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
    begin
        //NK 2506.18 
        IF ("No." <> '') AND ("Employee ID" <> '') THEN BEGIN
            TESTFIELD("First Name");
            TESTFIELD("Last Name");
            TESTFIELD("Employee ID");
            TESTFIELD("Address CIPS");
            TESTFIELD("Entity Code CIPS");
            if Rec."Temporary Contract Type" = Rec."Temporary Contract Type"::"  " then
                TESTFIELD("Hours In Day");
        END;

    end;





    var
        myInt: Integer;
        ShowContractType: Boolean;
        ShowContractType2: Boolean;

        WOrkB: Page "Work booklet";
        StartDate: Date;
        WA: Record "Wage Addition";
        UnionEmployees: record "Employee Diseases";
        UnionEmployeesPage: page "Union Employees";
        UserPersonalisation: Record "User Personalization";
        UserPersonalisation2: record "User Personalization";
        showMC: Boolean;
        Visib: Boolean;
        TerminationVisible: Boolean;
        EmploymentAbroadVisible: Boolean;
        EducationHistory: Record "Additional Education";
        EducationHistoryPage: Page "Education History";
        EmployeeDisability: record "Employee Level Of Disability";
        /*  EmployeeActivitiesPage: page "Employee Activities";
          EmployeeActivities: Record "Employee Activities";
  */
        EmployeeDisabilityPage: page "Employee Level Of Disability";
        EndDate: Date;
        AdditionalEducation: record "Additional Education";
        PersonalDocumentsPage: Page "Personal Documents";
        EmployeeDisability1: Record "Employee Level Of Disability";
        //EmployeeActivities1: Record "Employee Activities";
        PersonalDocumentsNat: Record "Personal Documents";
        show2: Boolean;
        show: Boolean;
        emp: Record employee;
        PersonalDocumentsCit2: Record "Personal Documents";
        PersonalDocumentsCit1: Record "Personal Documents";
        OrgDijelovi: Record "ORG Dijelovi";
        EmpPage: Page "Employee Card";
        OrgDijeloviPage: Page "ORG Dijelovi";
        //SegmentationGroup2: record "Segmentation Data";
        //SegmentationGroup: record "Segmentation Data";
        wb: record "Work Booklet";
        ThisYearLast: Date;

        DayOfWeekInput: DotNet FirstDayOfWeek;
        WeekOfYearInput: DotNet FirstWeekOfYear;
        ThisMonthFirst: Date;
        WAPage: page "Wage Addition Calculated";
        ThisYearFirst: Date;
        AgeT: Decimal;
        ThisYear: Integer;
        EC: Record "Employment Contract";
        //CareerDevelopment: record "Career Development";
        ContractType: Text[250];
        MothersMaidenName: Text[100];
        FathersName: Text[100];
        EmployeeCard: Page "Employee Card";
        MotherName: Text[100];
        ThisMonthLast: Date;
        NextMonthFirst: Date;
        NextMonthLast: Date;
        EmployeeCIPSAddress: Record "Alternative Address";
        RelativesEmployees: Integer;
        EmployeeRelative: Record "Employee Relative";
        EmployeeRelativePage: Page "Employee Relatives";
        UnionEmployees1: Record "Employee Diseases";
        //   WDV: Record "Work Duties Violation";
        //WDVPAge: Page "Job Violations";
        ManagementLevel: Code[10];
        Position: Record Position;
        TerminationDate: Date;
        EmployeeContractLedger: Record "Employee Contract Ledger";
        EmployeeContractLedgerPage: Page "Employee Contract Ledger";
        hide: Boolean;
        enable: Boolean;
        WorkBooklet: Record "Work Booklet";
        UserS: Record "User Setup";
        isVisible: Boolean;
        WageCalculation: Record "Wage Calculation";
        WorkBookletPage: page "Work booklet";
        WageCalcSub: Page "Wage Calculation Subform";
        WageCalc: Record "Wage Calculation";
        Text010: Label 'Probation period start date cannot be before employment date.';
        EmploymentDate: Date;
        employee: Record Employee;
        PersonalDocuments: record "Personal Documents";
        VacationDecisionR: Report VacationDecision;
        Vacation: record "Vacation Ground 2";
}