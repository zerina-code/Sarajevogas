page 50167 "GEO Part 2"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Service Line RN";
    Caption = 'EE Consents';

    layout
    {
        area(Content)
        {
            repeater("")
            {
                field(Intent; Intent) { Visible = VisibleGeo; }
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
                field("Unit of Measure Code2"; "Unit of Measure Code2") { }
                field("Planned Quantity"; "Planned Quantity")
                {
                    Caption = 'Planned Quantity';
                }

                field("Resource Quantity"; "Resource Quantity")
                {
                    Caption = 'Quantity';
                }
                field("Fixed Asset OS"; "Fixed Asset OS") { }
                field("Fixed Asset Mark"; "Fixed Asset Mark") { }

            }
        }
    }

    trigger OnInit()
    var
        myInt: Integer;
    begin
        Type := Type::Resource;


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