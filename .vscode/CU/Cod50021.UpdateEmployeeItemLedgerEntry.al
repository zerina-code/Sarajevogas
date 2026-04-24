codeunit 50021 UpdateEmployeeItemLedgerEntry
{
    Permissions = TableData "Item Ledger Entry" = imd;

    procedure UpdateItemLedgerEntry(EmployeeNo: Code[20]; EmployeeName: Text[100]; SklotNo: Code[20]): Boolean
    var
        ILE: Record "Item Ledger Entry";
        ModifiedRecords: Boolean;
        WhseShptLine: Record "Posted Whse. Shipment Line";
        NEPROKNJSKLOTP: Text;
    begin
        ModifiedRecords := false;

        //dodao da ide preko whse shpt line kako bih izbjegao koristenje polja SKLOT NO na tabeli Item Ledger Entry koje je FlowField i usporava rad. 
        WhseShptLine.Reset();
        WhseShptLine.SetFilter("No.", SklotNo);
        if WhseShptLine.FindSet() then begin
            NEPROKNJSKLOTP := WhseShptLine."Posted Source No.";
            ILE.Reset();
            ILE.SetRange("Document No.", NEPROKNJSKLOTP);
            if ILE.FindSet() then
                repeat
                    if ILE."Employee No." = '' then begin
                        ILE."Employee No." := EmployeeNo;
                        ILE."Employee Name" := EmployeeName;
                        ILE.Modify();
                        ModifiedRecords := true;
                    end;
                until ILE.Next() = 0;
        end;
        exit(ModifiedRecords);

    end;
}
