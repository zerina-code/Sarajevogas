pageextension 50007 "Customer Details FactBox" extends "Customer Details FactBox"
{
    layout
    {
        modify(AvailableCreditLCY)
        {
            Visible = false;
        }
        addafter(Name)
        {
            field("Customer Category"; Rec."Customer Category")
            {
                ApplicationArea = All;
            }
            field(MM; Rec.MM)
            {
                ApplicationArea = All;
            }
            field(SN; SN)
            {
                Caption = 'Service Order No.';
                trigger OnLookup(var Text: Text): Boolean
                var
                    myInt: Integer;
                    Requests: page Requests;
                begin

                    SH.Reset();
                    SH.SetFilter("Customer No.", '%1', rec."No.");
                    Requests.SetTableView(SH);
                    Requests.Run();

                end;

                trigger OnDrillDown()
                var
                    myInt: Integer;
                    Requests: page Requests;
                    SHF: Record "Service Header";
                begin

                    SH.Reset();
                    SH.SetFilter("Customer No.", '%1', rec."No.");
                    Requests.SetTableView(SH);
                    Requests.Run();

                end;


            }

            field(UGI; UGI)
            {
                Caption = 'UGI';
                trigger OnLookup(var Text: Text): Boolean
                var
                    myInt: Integer;
                    Requests: page "Gas Installation Data";
                begin

                    GID.Reset();
                    GID.SetFilter("Customer No.", '%1', rec."No.");
                    GIDPage.SetTableView(GID);
                    GIDPage.Run();

                end;

                trigger OnDrillDown()
                var
                    myInt: Integer;
                    Requests: page "Gas Installation Data";
                begin

                    GID.Reset();
                    GID.SetFilter("Customer No.", '%1', rec."No.");
                    GIDPage.SetTableView(GID);
                    GIDPage.Run();

                end;


            }


            field(Reading; Reading)
            {
                Caption = 'Reading';
                Style = Unfavorable;

                trigger OnLookup(var Text: Text): Boolean
                var
                    myInt: Integer;
                    CL: Record "Calculation Journal Line";
                    ClList: page "Calculation Entries";
                begin

                    cl.Reset();
                    cl.SetFilter("Customer No.", '%1', rec."No.");
                    cl.SetFilter(Locked, '%1', true);
                    cl.SetFilter("Bill Created", '%1', true);
                    ClList.SetTableView(cl);
                    ClList.run;


                end;


                trigger OnDrillDown()
                var
                    myInt: Integer;
                    CL: Record "Calculation Journal Line";
                    ClList: page "Calculation Entries";
                begin

                    cl.Reset();
                    cl.SetFilter("Customer No.", '%1', rec."No.");
                    cl.SetFilter(Locked, '%1', true);
                    cl.SetFilter("Bill Created", '%1', true);
                    ClList.SetTableView(cl);
                    ClList.run;

                end;


            }
        }
    }



    trigger OnOpenPage()
    var
        myInt: Integer;
        GID: Record "Gas Installation Data";
        opt: Enum Option;
    begin

        SH.Reset();
        SH.SetFilter("Customer No.", '%1', rec."No.");
        if sh.FindFirst() then
            SN := sh.Count
        else
            sn := 0;

        cl.Reset();
        cl.SetFilter("Customer No.", '%1', rec."No.");
        cl.SetFilter(Locked, '%1', true);
        cl.SetFilter("Bill Created", '%1', true);
        cl.SetCurrentKey("GAS- Calculation");
        if cl.FindLast() then
            Reading := cl."New Value"
        else
            Reading := 0;

        GID.Reset();
        GID.SetRange("Customer No.", Rec."No.");
        if GID.FindFirst() then begin
            if GID."Visual inspection of the gas" = opt::Yes then
                UGI := 'Da'
            else
                if GID."Visual inspection of the gas" = opt::No then
                    UGI := 'Ne'
                else
                    if GID."Visual inspection of the gas" = opt::Empty then
                        UGI := '-';
        end;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SH.Reset();
        SH.SetFilter("Customer No.", '%1', rec."No.");
        if sh.FindFirst() then
            SN := sh.Count
        else
            sn := 0;


        cl.Reset();
        cl.SetFilter("Customer No.", '%1', rec."No.");
        cl.SetFilter(Locked, '%1', true);
        cl.SetFilter("New Value", '<>%1', 0);
        cl.SetCurrentKey("GAS- Calculation");
        if cl.FindLast() then
            Reading := cl."New Value"
        else
            Reading := 0;
    end;

    var
        SN: Integer;
        SH: Record "Service Header";
        Reading: Integer;
        CL: Record "Calculation Journal Line";
        GID: Record "Gas Installation Data";
        GIDPage: page "Gas Installation Data";
        UGI: Text;
        MyCurrentCustomer: Code[20];
}
