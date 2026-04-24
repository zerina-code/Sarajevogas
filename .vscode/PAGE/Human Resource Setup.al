pageextension 50044 HumanResourcesSetup_ext extends "Human Resources Setup"
{
    layout
    {
        addbefore("Employee Nos.")
        {
            field("Primary Key"; "Primary Key")
            {
                ApplicationArea = all;
            }
        }
        modify("Automatically Create Resource")
        {
            Visible = false;
        }
        // Add changes to page layout here
        addafter("Employee Nos.")
        {
            field("Operator Nos."; "Operator Nos.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Personal Documents Nos."; "Personal Documents Nos.")
            {
                ApplicationArea = all;
            }
            field("Work Booklet Nos."; "Work Booklet Nos.")
            {
                ApplicationArea = all;
            }
            field("Alternative Address Nos."; "Alternative Address Nos.")
            {
                ApplicationArea = all;
            }
            field("Disability Nos."; "Disability Nos.")
            {
                ApplicationArea = all;
            }
            field("Institution Nos."; "Institution Nos.")
            {
                ApplicationArea = all;
            }

            field("Instructor Nos."; "Instructor Nos.")
            {
                ApplicationArea = all;
            }

            field("Training Catalogue Nos."; "Training Catalogue Nos.")
            {
                ApplicationArea = all;
            }
            field("Training Nos."; "Training Nos.")
            {
                ApplicationArea = all;
            }
            field("B-1 Nos."; "B-1 Nos.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("B-1 (with regions) Nos."; "B-1 (with regions) Nos.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Stream Nos."; "Stream Nos.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Title Nos"; "Title Nos")
            {
                ApplicationArea = all;
                Visible = true;
            }
            field("Profession Nos"; "Profession Nos")
            {
                ApplicationArea = all;
                Visible = true;
            }
            field("Probation Expire Days"; "Probation Expire Days")
            {
                ApplicationArea = all;


            }
            field("Reaching years in company"; "Reaching years in company")
            {
                ApplicationArea = all;

            }
            field("New employee period"; "New employee period")
            {
                ApplicationArea = all;

            }
            field("Warning Period"; "Warning Period")
            {
                ApplicationArea = all;

            }
            field("Legal Training Expire Days"; "Legal Training Expire Days")
            {
                ApplicationArea = all;
            }
            field("Objective Header Nos."; "Objective Header Nos.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Objective Line Nos."; "Objective Line Nos.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Objective Type Nos."; "Objective Type Nos.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Competency Nos."; "Competency Nos.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Fixed Amount Brutto"; "Fixed Amount Brutto")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Variable Amount Brutto Less"; "Variable Amount Brutto Less")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Variable Amount Brutto Greater"; "Variable Amount Brutto Greater")
            {
                ApplicationArea = all;
                Visible = false;
            }


            group("Expiry setup")
            {
                Caption = 'Expiry setup';
                field("Expiry period (violations)"; "Expiry period (violations)")
                {
                    ApplicationArea = all;
                }
                field("Expiry period (contracts)"; "Expiry period (contracts)")
                {
                    ApplicationArea = all;
                }
                field("Tax Administration Report Days"; "Tax Administration Report Days")
                {
                    ApplicationArea = all;
                }
            }
            group("Code Setup")
            {
                Caption = 'Code Setup';
                field("Company Car Code"; "Company Car Code")
                {
                    ApplicationArea = all;
                }
                field("File Path"; "File Path")
                {
                    ApplicationArea = all;
                }
                field("External Description"; "External Description")
                {
                    ApplicationArea = all;
                }
                field("Default Org Jed"; "Default Org Jed") { ApplicationArea = all; }
            }
            group("E-mail Setup")
            {
                Caption = 'E-mail Setup';
                field("E-mail Sender"; "E-mail Sender")
                {
                    ApplicationArea = all;
                }
                field("E-mail Receiver"; "E-mail Receiver")
                {
                    ApplicationArea = all;
                }
                field("Sender Name"; "Sender Name")

                {
                    ApplicationArea = all;
                }
            }
            group("Hourlyrate managers")
            {
                Caption = 'Hourlyrate managers';
                Visible = false;
                field("Administrator 1"; "Administrator 1")
                {
                    ApplicationArea = all;
                }
                field("Administrator 2"; "Administrator 2")
                {
                    ApplicationArea = all;
                }
                field("Administrator 3"; "Administrator 3")
                {
                    ApplicationArea = all;
                }
                field("Administrator 4"; "Administrator 4")
                {
                    ApplicationArea = all;
                }
                field("Administrator 5"; "Administrator 5")
                {
                    ApplicationArea = all;
                }
                field("Administrator 6"; "Administrator 6")
                {
                    ApplicationArea = all;
                }
                field("Administrator 7"; "Administrator 7")
                {
                    ApplicationArea = all;
                }
                field("Administrator 8"; "Administrator 8")
                {
                    ApplicationArea = all;
                }
                field("Administrator Contact Center"; "Administrator Contact Center")
                {
                    ApplicationArea = all;
                }
            }
            group("Trainings setup")
            {
                Caption = 'Trainings setup';
                Visible = false;
                field("Training Administrator"; "Training Administrator")
                {
                    ApplicationArea = all;
                }
                field("HR Administrator"; "HR Administrator")
                {
                    ApplicationArea = all;
                }
                field("MBO Administrator"; "MBO Administrator")
                {
                    ApplicationArea = all;
                }
            }
            ///  }
        }


    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}