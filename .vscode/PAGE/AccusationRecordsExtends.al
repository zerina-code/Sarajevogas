tableextension 50102 AccusationRecordExtends extends Territory
{

    fields
    {


        field(50000; "Type"; Enum AccusationRecordType)
        {
            Caption = 'Type';

        }
        field(50001; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(50002; "Note"; Text[500])
        {
            Caption = 'Note';
        }
        field(50003; "Accusation"; Code[10])
        {
            Caption = 'Accusation Header';
            TableRelation = "Accusation Header";
        }
        field(50004; "Customer"; Code[10])
        {
            Caption = 'Customer';
            TableRelation = Customer;
        }
        field(50005; "Document No."; Text[100])
        {
            Caption = 'Document No.';
        }
        field(50006; "Status"; Enum AccusationStatus)
        {
            Caption = 'Accusation Status';
            //parnični
            ValuesAllowed = 0, 1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
            25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53
            , 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77;
        }
        field(50007; "Accusation Type"; Enum AccusationType)
        {
            Caption = 'Accusation Type';
        }
        field(50008; "MALS"; Text[200])
        {
            Caption = 'MALS';
        }
        field(50009; "IP"; Text[200])
        {
            Caption = 'IP';
        }
        field(50010; "Date of Next Trial"; Date)
        {
            Caption = 'Date of Next Trial';
        }
        field(50011; "Status_2"; Enum AccusationStatus_2)
        {
            Caption = 'Accusation Status';
            ValuesAllowed = 0, 21, 22, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33;
        }
        field(50012; "Status_3"; Enum AccusationStatus_3)
        {
            Caption = 'Accusation Status';
            ValuesAllowed = 0, 34, 35, 42, 36, 37;
        }
        field(50013; "Archived Date"; Date)
        {
            Caption = 'Archive Date';
        }

    }
    trigger OnInsert()
    var
        gls: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        us: Record "User Setup";
    begin
        gls.GET();
        if gls.FindFirst() then begin
            if Type = Rec.Type::MALS then begin
                //             "Document No." := NoSeriesMgt.GetNextNo(gls."Court Number Entry Series", TODAY, true);
                //         "Code" := "Document No.";
            end
            else
                if Type = Rec.Type::Trial then begin
                    //               "Document No." := NoSeriesMgt.GetNextNo(gls."Hearing Entry Series", TODAY, true);
                    //               "Code" := "Document No.";
                end;
        end;
        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        //        if us.FindFirst() then begin
        //         Accusation := us."Accusation No.";
        //    end;
        if Type = Rec.Type::"Accusation Status" then begin
            Status := AccusationStatus::"Prepared for lawyers";
            Status_2 := AccusationStatus::"Prepared for lawyers";
            Status_3 := AccusationStatus::"Prepared for lawyers";
            //    "Document No." := NoSeriesMgt.GetNextNo(gls."Status Entry Series", TODAY, true);

        end;
        if Type = Rec.Type::"Accusation Type" then begin
            "Accusation Type" := AccusationType::"Litigation Proceedings";
            //      "Document No." := NoSeriesMgt.GetNextNo(gls."Type Entry Series", TODAY, true);

        end;

    end;



}

