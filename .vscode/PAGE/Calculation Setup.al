page 50183 "Calculation Setup"
{
    Caption = 'Calculation Setup';
    PageType = Card;
    SourceTable = "Calculation Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Item No."; "Item No.")
                {

                    ApplicationArea = all;
                }
                field("Item No. 2"; "Item No. 2") { ApplicationArea = all; }
                field("Transfer Items"; "Transfer Items") { }
                field("No. Series Transfer"; "No. Series Transfer") { }
                field("Vendor No."; "Vendor No.") { }
                field("No. series for Proceedings VP"; "No. series for Proceedings VP") { }
                field("No. series for Proceedings VP Reset"; "No. series for Proceedings VP Reset") { }
                field("No. series for Proceedings MP"; "No. series for Proceedings MP") { }
                field("No. series for Proceedings DOM"; "No. series for Proceedings DOM") { }
                field("No. series for Proceedings SP"; "No. series for Proceedings SP") { }
                field("No. series for Proceedings KP"; "No. series for Proceedings KP") { }
                field("No. series for Proceedings CNG"; "No. series for Proceedings CNG") { }
                field("PS Constant"; "PS Constant") { }
                field("TS Constant"; "TS Constant") { }
                field(JEDKS; JEDKS) { }
                field("Absolute zero"; "Absolute zero") { }
                field("Scale factor"; "Scale factor") { }
                field("Calorific power coefficient"; "Calorific power coefficient") { }
                field("Rounding Value Quantity VP"; "Rounding Value Quantity VP") { }
                field("Rounding Value Quantity MP"; "Rounding Value Quantity MP") { }
                field("Rounding Value Quantity DOM"; "Rounding Value Quantity DOM") { }
                field("Rounding Value Quantity KJKP"; "Rounding Value Quantity KJKP") { }
                field("Rounding Value Quantity SP"; "Rounding Value Quantity SP") { }
                field("Rounding Value Quantity CNG"; "Rounding Value Quantity CNG") { }
                field("Compression coefficient"; "Compression coefficient") { }
                field("Atmospheric pressure"; "Atmospheric pressure") { }
                field("% reduction"; "% reduction") { }
                field("War Dabt"; "War Dabt") { }
                field("Reminder amount"; "Reminder amount") { }
                field("Reminder amount VP"; "Reminder amount VP") { }
                field("Reminder amount MP"; "Reminder amount MP") { }

                field("Reminder amount KJKP"; "Reminder amount KJKP") { }
                field("Reminder amount SP"; "Reminder amount SP") { }
                field("Reminder amount CNG"; "Reminder amount CNG") { }
                field(Path; Path) { }
                field("Update Data"; "Update Data") { }
                field("Error for summer"; "Error for summer") { }

            }
            group(Subsidies2)
            {
                Caption = 'Subsidies';
                field("Deminimis Legal act"; "Deminimis Legal act") { }
                field("Deminimis Act Name"; "Deminimis Act Name") { }
                field("Deminimis Act Number"; "Deminimis Act Number") { }
                field("Deminimis Act Date"; "Deminimis Act Date") { }
                field("Deminimis Purpose"; "Deminimis Purpose") { }
                field(Subsidies; Subsidies) { }
                field("Subsidies Resource"; "Subsidies Resource") { }
                field("Aid granting instrument"; "Aid granting instrument") { }
                field("Subsidies Date from"; "Subsidies Date from") { }
                field("Subsidies Date to"; "Subsidies Date to") { }
                field("Deminimis Remark"; "Deminimis Remark") { }
                field("Customer - Subsidies"; "Customer - Subsidies") { ApplicationArea = all; }

            }

            group(ChangePrice)
            {
                Caption = 'ChangePrice';
                field("Change Price"; "Change Price") { }
                field("New Price"; "New Price") { }
            }

            group(DistributionPercentage)
            {
                Caption = 'DistributionPercentage';
                field("Distribution 1"; "Distribution 1") { }
                field("Distribution 2"; "Distribution 2") { }
                field("Distribution 3"; "Distribution 3") { }
                field("Distribution 4"; "Distribution 4") { }
                field("Distribution 5"; "Distribution 5") { }
                field("Distribution 6"; "Distribution 6") { }
                field("Distribution 7"; "Distribution 7") { }
                field("Distribution 8"; "Distribution 8") { }
                field("Distribution 9"; "Distribution 9") { }
                field("Distribution 10"; "Distribution 10") { }
                field("Distribution 11"; "Distribution 11") { }
                field("Distribution 12"; "Distribution 12") { }
            }
        }


    }
    var
        GaugeGet: Record Gauge;

    trigger OnAfterGetRecord()
    begin


    end;

    trigger OnClosePage()
    begin

    end;

    trigger OnInit()
    var
        CalcHeader: Record "Calcuation Header";
    begin


    end;

    trigger OnOpenPage()
    var

    begin




    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //bt

    end;


}

