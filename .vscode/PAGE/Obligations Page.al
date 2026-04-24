page 50175 Obligations2
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Obligation;
    Caption = 'Obligations';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            repeater("L")
            {

                field("No."; "No.")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; "Location Code") { ApplicationArea = all; }

                // field("Date To"; "Date To") { ApplicationArea = all; }
                field("Employee No."; "Employee No.") { ApplicationArea = all; }
                field("Employee Name"; "Employee Name") { ApplicationArea = all; }
                field("Date From"; "Date From") { ApplicationArea = all; }
                field("Obligation type"; "Obligation type")
                {

                }

                field("Responsible Person Name"; "Responsible Person Name") { ApplicationArea = all; }
                field("Responsible Sector"; "Responsible Sector") { }

                field("Contact Name"; "Contact Name") { ApplicationArea = all; Visible = false; }
                field("Use FA Type"; "Use FA Type") { ApplicationArea = all; }

                field("Employee No. - Use FA"; "Employee No. - Use FA") { ApplicationArea = all; }
                field("Employee Name - Use FA"; "Employee Name - Use FA") { ApplicationArea = all; }
                field("Z.Obligation"; "Z.Obligation") { }
                field("R.Obligation"; "R.Obligation") { }

                field(Active; Active) { ApplicationArea = all; }

                field("User ID"; "User ID") { Editable = false; }
                field("User ID Sector"; "User ID Sector") { Editable = false; }
                field("User Position"; "User Position") { Editable = false; }

            }


        }

    }
    actions
    {

        area(Processing)
        {
            action("Obligations Report")
            {
                Caption = 'Obligations Report';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                trigger onaction()
                var
                    myInt: Integer;
                    OB: Record Obligation;
                begin
                    OB.Reset();
                    if Rec."Obligation type" = Rec."Obligation type"::"Zaduženje" then begin
                        OB.SetFilter("Obligation type", '%1', OB."Obligation type"::"Zaduženje");
                        OB.SetFilter("Z.Obligation", '%1', Rec."Z.Obligation");
                    end
                    else begin
                        OB.SetFilter("Obligation type", '%1', OB."Obligation type"::"Razduženje");
                        OB.SetFilter("R.Obligation", '%1', Rec."R.Obligation");

                    end;
                    Report.RunModal(50111, true, true, OB);


                end;
                // RunObject = report "Obligations Report";

            }
        }

    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CalcFields("Customer Name");

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CalcFields("Customer Name");

    end;




    var
        myInt: Integer;
}
