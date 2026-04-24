page 50133 "Vacation setup history"
{
    Caption = 'Vacation setup history';
    PageType = List;
    SourceTable = "Vacation setup history";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Base Days"; "Base Days")
                {
                    ApplicationArea = all;

                }
                field("Base Days BD"; "Base Days BD")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Base Days RS"; "Base Days RS")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Year; Year)
                {
                    ApplicationArea = all;
                }
                field("Days FBIH"; "Days FBIH")
                {
                    ApplicationArea = all;
                }
                field("Days RS"; "Days RS")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Days BD"; "Days BD")
                {
                    ApplicationArea = all;
                    Caption = '<Dani između dva prekida radnog odnosa (BD)>';
                    Visible = false;
                }
                field("Insert Document No."; "Insert Document No.")
                {
                    ApplicationArea = all;
                    Visible = Simple;
                }
                field("No. series Code"; "No. series Code")
                {
                    ApplicationArea = all;
                    Visible = Simple;
                }
                field("Vacation Descision Date"; "Vacation Descision Date") { }
                field("Vacation Validation Date"; "Vacation Validation Date") { }
                field("Part of Position Description"; "Part of Position Description") { }
                field("Vacation Decision CEO"; "Vacation Decision CEO") { }
                field("Vacation Decision Exe"; "Vacation Decision Exe") { }

            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        myInt: Integer;

    begin

        GeneralL.Get();
        if GeneralL."Is Simple Page" = false
        then
            Simple := false
        else
            Simple := true;



    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        GeneralL.Get();
        if GeneralL."Is Simple Page" = false
        then
            Simple := false
        else
            Simple := true;

    end;

    var
        Simple: Boolean;
        GeneralL: Record "General Ledger Setup";
}

