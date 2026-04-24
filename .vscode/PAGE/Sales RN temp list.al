page 50197 "Service Line RN Temp"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Service Line RN Temp";
    Caption = 'Service Line RN Temp';

    layout
    {
        area(Content)
        {
            repeater("")
            {
                //field(Intent; Intent) { Visible = VisibleGeo; }
                field("Request Resource Type"; "Request Resource Type")
                {
                    Caption = 'Request Resource Desc';
                    Visible = VisibleGeo;
                }
                field("Request Resource Type1"; "Request Resource Type1")
                {
                    Caption = 'Request Resource Desc';
                    Visible = not VisibleGeo;
                }
                field("Resource Connection Type"; "Resource Connection Type")
                {
                    Caption = 'Resource Conn Type';
                }
                field("Resource No."; "Resource No.")
                {
                    Caption = 'Resource No.';
                }

                field("Resource Name"; "Resource Name")
                {
                    Caption = 'Resource Name';
                }
                field("Education Level"; "Education Level") { }
                //   field("Unit of Measure Code"; "Unit of Measure Code") { }
                //    field("Unit of Measure Code2"; "Unit of Measure Code2") { }
                field("Planned Quantity"; "Planned Quantity")
                {
                    Caption = 'Planned Quantity';
                }

                field("Resource Quantity"; "Resource Quantity")
                {
                    Caption = 'Quantity';
                }



            }
        }
    }

    trigger OnInit()
    var
        myInt: Integer;
    begin
        Type := Type::Resource;


    end;


    procedure GetLineNo(): Integer
    var
        ServLine: Record "Service Line RN Temp";
    begin
        if "Line No." <> 0 then
            // if not ServLine.Get("Document Type", "Document No.", "Line No.") then
            //   exit("Line No.");

            ServLine.SetRange("Massive Code", "Massive Code");
        if ServLine.FindLast() then
            exit(ServLine."Line No." + 10000);
        exit(10000);
    end;


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        VisiGeo.Get(UserId);
        VisibleGeo := VisiGeo.GEO;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        VisiGeo.Get(UserId);
        VisibleGeo := VisiGeo.GEO;
    end;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Line No." := GetLineNo();
    end;


    var
        myInt: Integer;
        VisiGeo: Record "User Setup";
        VisibleGeo: Boolean;
}