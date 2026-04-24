page 50135 "Radio Module Card"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Radio Module";

    layout
    {
        area(Content)
        {

            group(General)
            {

                field(Code; Code)
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field("Type Radio Module"; "Type Radio Module") { ApplicationArea = all; }
                field("Meter Manufacturer"; "Meter Manufacturer") { ApplicationArea = all; }
                field("Meter Manufacturer Desc"; "Meter Manufacturer Desc") { ApplicationArea = all; }

                field("Serial Number I"; "Serial Number I") { ApplicationArea = all; }
                field("Serial Number II"; "Serial Number II") { ApplicationArea = all; }
                field("Gauge Code"; "Gauge Code") { }
                field("Gauge Description"; "Gauge Description") { Visible = false; }
                field("Measuring Point Code"; "Measuring Point Code") { }

                field("Year of Production"; "Year of Production") { ApplicationArea = all; }

            }
            part(InstallationHistory; "Installation History")

            {
                ApplicationArea = all;
                SubPageLink = Code = field(Code), Type = filter(Radio_Module);
            }

        }




    }
    actions
    {
        area(Processing)
        {
            action(ImportaRadio)
            {
                ApplicationArea = all;
                Caption = 'Import Radio';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    ImportRadio: XmlPort "Radio Import";

                begin
                    ImportRadio.RUN;
                end;
            }
            action(ImportaRadio2)
            {
                ApplicationArea = all;
                Caption = 'Battery replacement update';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var


                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}