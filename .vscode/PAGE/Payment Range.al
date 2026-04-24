/*page 50091 "Payment range"
{
    Caption = 'Payment range';
    DelayedInsert = true;
    InsertAllowed = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Payment range";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("K")
            {
                field("Pay Grade"; "Pay Grade")
                {
                    ApplicationArea = all;
                }
                field(Region; Region)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Min Region"; "Min Region")
                {
                    ApplicationArea = all;
                }
                field("Mid Region"; "Mid Region")
                {
                    ApplicationArea = all;
                }
                field("Max Region"; "Max Region")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        SortMethod: Option " ",Item,"Shelf/Bin No.","Due Date";

    local procedure ShowBinContents()
    var
        BinContent: Record "Bin Content";
    begin
    end;

    procedure PutAwayCreate()
    var
        WhseInternalPutAwayHeader: Record "Whse. Internal Put-away Header";
        WhseInternalPutAwayLine: Record "Whse. Internal Put-away Line";
        ReleaseWhseInternalPutAway: Codeunit "Whse. Int. Put-away Release";
    begin
    end;

    local procedure GetActualSortMethod(): Decimal
    var
        WhseInternalPutAwayHeader: Record "Whse. Internal Put-away Header";
    begin
    end;

    local procedure ItemNoOnAfterValidate()
    begin
    end;

    local procedure FromBinCodeOnAfterValidate()
    begin
    end;

    local procedure DueDateOnAfterValidate()
    begin
    end;
}

*/