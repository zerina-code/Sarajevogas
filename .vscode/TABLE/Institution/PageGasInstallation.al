
page 50228 "Gas InstallationsE"


{


    PageType = List;

    SourceTable = GasInstallationsE;

    ApplicationArea = All;

    UsageCategory = Administration;
    Caption = 'Gas InstallationsE';


    layout

    {

        area(content)

        {

            repeater(Control1)

            {

                ShowCaption = false;

                field("Gas Installation No."; "Gas Installation No.")

                {

                    ApplicationArea = All;

                    Visible = true;

                }

                field("Main Asset Comp. No."; "Main Asset Comp. No.")

                {

                    ApplicationArea = All;

                    Visible = true;


                }
                field("Main Asset Comp. Description."; "Main Asset Comp. Description.")
                {
                    ApplicationArea = All;

                    Visible = true;

                }

                field(LineNo; LineNo)

                {

                    ApplicationArea = All;

                    Visible = true;


                }

                field("Serial Number from the Scheme"; "Serial Number from the Scheme")

                {

                    ApplicationArea = All;

                    Visible = true;

                }

            }

        }


    }




    trigger OnOpenPage()
    var
        myInt: Integer;
    begin

        SetCurrentKey(LineNo, "Serial Number from the Scheme")
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetCurrentKey(LineNo, "Serial Number from the Scheme")
    end;


}
