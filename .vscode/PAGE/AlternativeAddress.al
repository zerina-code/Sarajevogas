pageextension 50010 AlternativeAddress extends "Alternative Address Card"
{
    layout
    {
        // Add changes to page layout here
        modify(Code)
        {
            Visible = false;
        }
        Modify("Country/Region Code")
        {
            Editable = false;
            //ĐK Sarajevogas:
        }

        modify(Name)
        {
            Visible = false;
        }
        modify("Address 2")
        {
            Visible = false;
        }
        modify("Phone No.")
        {
            Visible = false;
        }
        modify(Communication)
        {
            Visible = false;
        }


        addafter(Code)
        {

            group("CIPS Address")
            {
                Caption = 'CIPS Address';
                Editable = VisibleCIPS;
                Visible = VisibleCIPS;
                field("Address CIPS"; "Address CIPS")
                {
                    Enabled = true;
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Municipality Code CIPS"; "Municipality Code CIPS")
                {
                    ApplicationArea = all;
                }
                field("Date From (CIPS)"; "Date From (CIPS)")
                {
                    ApplicationArea = all;
                }
                field("Date To (CIPS)"; "Date To (CIPS)")
                {
                    ApplicationArea = all;
                }
                field("Municipality Name CIPS"; "Municipality Name CIPS")
                {
                    Enabled = true;
                    ApplicationArea = all;
                }
                field("Place Of Living"; "Place Of Living")
                {
                    ApplicationArea = all;
                }

                field("City CIPS"; "City CIPS")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Post Code CIPS"; "Post Code CIPS")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("County Code CIPS"; "County Code CIPS")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("County CIPS"; "County CIPS")
                {
                    ApplicationArea = all;
                }
                field("Entity Code CIPS"; "Entity Code CIPS")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Country/Region Code CIPS"; "Country/Region Code CIPS")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Active; Active)
                {
                    ApplicationArea = all;
                }
            }
            group("Current Address")
            {
                Caption = 'Current Address';
                Editable = true;


                field("Municipality Code"; "Municipality Code")
                {
                    ApplicationArea = all;
                }
                field("Date From"; "Date From")
                {
                    ApplicationArea = all;
                }
                field("Date To"; "Date To")
                {
                    ApplicationArea = all;
                }
                field("Municipality Name"; "Municipality Name")
                {
                    ApplicationArea = all;
                }


                field("County Code"; "County Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Entity Code"; "Entity Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

            }


        }
        movebefore("Municipality Code"; Address)
        moveafter("Municipality Name"; City)
        modify(City)
        {
            Editable = false;
            ApplicationArea = all;
        }
        moveafter(City; "Post Code")
        modify("Post Code")
        {
            Editable = false;
            ApplicationArea = all;
        }
        moveafter("County Code"; County)


    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        VisibleCurrent: Boolean;
        VisibleCIPS: Boolean;
        AA: Record "Alternative Address";
        "Filter": Text[250];

    trigger OnOpenPage()
    begin
        Filter := Rec.GETFILTER("Address Type");

        IF (Filter = 'Current') OR (Filter = 'Stvarna') THEN BEGIN
            VisibleCurrent := TRUE;
            VisibleCIPS := FALSE;
        END
        ELSE
            IF Filter = 'CIPS' THEN BEGIN
                VisibleCurrent := FALSE;
                VisibleCIPS := TRUE;
            END
            ELSE BEGIN
                VisibleCurrent := FALSE;
                VisibleCIPS := TRUE;
            END;


        /*
        IF "Address Type"="Address Type"::Current THEN BEGIN
          VisibleCurrent:=TRUE;
          VisibleCIPS:=FALSE;
          END
          ELSE BEGIN
            VisibleCurrent:=FALSE;
            VisibleCIPS:=TRUE;
            END;
        
        */

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        /*ĐK IF ((Rec."Address CIPS"='') AND (Rec.Address<>'')) THEN BEGIN
        AA.SETFILTER("Employee No.",'%1',Rec."Employee No.");
        AA.SETFILTER("Address CIPS",'<>%1','');
        IF AA.FIND('+') THEN BEGIN
          Rec.VALIDATE("Address CIPS",AA."Address CIPS");
            Rec.VALIDATE("Municipality Code CIPS",AA."Municipality Code CIPS");
            Rec.VALIDATE("Date From (CIPS)",AA."Date From (CIPS)");
            Rec.VALIDATE("Date To (CIPS)",AA."Date To (CIPS)");
            Rec.VALIDATE("Address Type",0);
            Rec.Active:=TRUE;
          Rec.MODIFY;
          END;
          END;
        
        IF ((Rec."Address CIPS"<>'') AND (Rec.Address='')) THEN BEGIN
        AA.SETFILTER("Employee No.",'%1',Rec."Employee No.");
        AA.SETFILTER(Address,'<>%1','');
        IF AA.FIND('+') THEN BEGIN
          Rec.VALIDATE(Address,AA.Address);
            Rec.VALIDATE("Municipality Code",AA."Municipality Code");
            Rec.VALIDATE("Date From",AA."Date From");
            Rec.VALIDATE("Date To",AA."Date To");
            Rec.Active:=TRUE;
            Rec.VALIDATE("Address Type",1);
          Rec.MODIFY;
          END;
          END;
          */

    end;

}