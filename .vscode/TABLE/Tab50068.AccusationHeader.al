table 50068 "Accusation Header"
{
    DataClassification = ToBeClassified;
    Caption = 'Accusation Header';
    DrillDownPageID = "Accusation Document List";
    LookupPageID = "Accusation Document List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
        }
        field(2; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer No.';
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if Customer.Get("Customer No.") then
                    Validate("Customer Name", Customer.Name);
                if Customer.FindFirst() then begin
                    "Way of Delivery" := Customer."Way of Sending Reminder";
                    if "Way of Delivery" = AccusationDelivery::"Via Email" then begin
                        "Delivered via Email" := true;
                    end
                    else
                        if "Way of Delivery" = AccusationDelivery::"Via Post Office" then begin
                            "Delivered via Post" := true;
                        end;
                    "Category" := Customer."Customer Category";
                end;
            end;
        }
        field(3; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Name';
            Editable = false;
            TableRelation = Customer.Name where("No." = field("Customer No."));
        }
        field(4; "Note"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Note';
        }
        field(5; "Interest"; Decimal)
        {
            Caption = 'Interest';
            DataClassification = ToBeClassified;
        }

        field(6; "Court number"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Territory where(Type = filter(MALS));


        }
        field(122; "Actual Court Number"; Text[50])

        {
            Caption = 'Actual Court Number';


        }
        field(7; "Document Date"; Date)
        {
            Caption = 'Date';
            trigger OnValidate()
            var
                customer: Record Customer;
                Year: Integer;
                Month: Integer;
                Day: Integer;
            begin
                Year := Date2DMY("Document Date", 3);
                Month := Date2DMY("Document Date", 2);
                Day := Date2DMY("Document Date", 1);
                customer.SetFilter("No.", '%1', Rec."Customer No.");
                if customer.FindFirst() then begin
                    if customer."Customer Category" = Category::Household then begin
                        "Statue of Limitation Date" := DMY2Date(Day, Month, Year + 1);
                    end
                    else begin
                        "Statue of Limitation Date" := DMY2Date(Day, Month, Year + 3);
                    end;
                end;
            end;
        }
        field(11; Status; Enum AccusationStatus)
        {
            Caption = 'Status';

            trigger OnValidate()
            begin
                Validate("Status Date", Today);
            end;
        }
        field(12; "Status Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Status Date';
        }
        field(13; "Send on E-mail"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Send on E-mail';
        }
        field(14; "Reminder"; Enum ReminderType)
        {
            Caption = 'Reminder';
        }
        field(15; "Date of sent reminder"; Date)
        {
            Caption = 'Date of sent reminder';
        }
        field(16; "Document No."; Text[100])
        {
            Caption = 'Document No.';
        }
        field(17; "Reminder sent"; Boolean)
        {
            Caption = 'Reminder sent';
        }

        field(19; "Debt"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Debt';
            Editable = false;
        }
        field(20; "Actual Hearing"; Code[30])
        {
            Caption = 'Actual Hearing';
            Editable = false;
            TableRelation = Territory;

        }

        field(22; Hearing; Code[30])
        {
            Caption = 'Hearing';
            TableRelation = Territory where(Type = filter(Trial));

        }
        field(23; "Way of Delivery"; Enum AccusationDelivery)
        {
            Caption = 'Way of Delivery';
            Editable = false;
        }
        field(24; "Current Accusation Type"; Enum AccusationType)
        {
            Caption = 'Accusation Type';

        }
        field(25; "Accusation Type"; Code[20])
        {
            Caption = 'Accusation Type';
            TableRelation = Territory where(Type = filter("Accusation Type"));
        }
        field(26; "Accusation Status"; Code[20])
        {
            Caption = 'Accusation Status';
            TableRelation = Territory where(Type = filter("Accusation Status"));

        }
        field(27; "Delivered via Email"; Boolean)
        {
            Caption = 'Delivered via Email';
        }
        field(28; "Delivered via Post"; Boolean)
        {
            Caption = 'Delivered via Post';
        }
        field(29; "History"; Code[20])
        {
            Caption = 'History';
            TableRelation = Territory where(Type = filter("History"));
        }
        field(30; "Withdrawn"; Boolean)
        {
            Caption = 'Withdrawn';
            Editable = false;
        }
        field(65; "Archive"; Boolean)
        {
            Caption = 'Archive';
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
                AL: Record "Accusation Line";
            begin
                al.Reset();
                al.SetFilter("Document No.", '%1', rec."No.");
                if al.FindSet() then
                    repeat
                        al.Archived := rec.Archive;
                        al.Modify();
                    until al.Next() = 0;

            end;
        }
        field(61; "Archive date"; Date)
        {
            Caption = 'Archive date';
        }
        field(31; "Interest given by Court Order"; Decimal)
        {
            Caption = 'Interest given by Court Order';
        }
        field(32; "Appealed for interest withdrawal"; Boolean)
        {
            Caption = 'Appealed for interest withdrawal';

        }
        field(33; "Date of Appeal for withdrawal"; Date)
        {
            Caption = 'Date of Appeal for withdrawal';
        }
        field(34; "Date of Withdrawal"; Date)
        {
            Caption = 'Date of Withdrawal';
        }
        field(35; Created; Boolean)
        {
            Caption = 'Created';
        }
        field(36; "Statue of Limitation Date"; Date)
        {
            Caption = 'Statue of Limitation Date';
        }
        field(37; "Date of Court Decision"; Date)
        {
            Caption = 'Date of Court Decision';
        }
        field(38; "Date of Accusation"; Date)
        {
            Caption = 'Datum tužbe';
            trigger OnValidate()
            var
                gls: Record "General Ledger Setup";
                us: Record "User Setup";
                accStatus: Record Territory;
                NoSeriesMgt: Codeunit NoSeriesExtented;
            begin
                gls.Get();
                if gls.FindFirst() then begin
                    accStatus.Accusation := Rec."No.";
                    accStatus.Type := AccusationRecordType::"Accusation Status";
                    accStatus.Date := Today();
                    accStatus.Status := AccusationStatus::"Accusation Ready for sending to court";
                    accStatus.Code := NoSeriesMgt.GetNextNo(gls."Status Entry Series", TODAY, true);
                    accStatus."Document No." := accStatus.Code;
                    accStatus.Insert();
                end
            end;
        }
        field(39; "Description"; Text[500])
        {
            Caption = 'Description';
        }
        field(40; "Reprogrammed Debt"; Boolean)
        {
            Caption = 'Reprogrammed Debt';
        }
        field(41; "Debt paid under 10 days"; Boolean)
        {
            Caption = 'Debt paid under 10 days';
        }
        field(42; "Only debt paid"; Boolean)
        {
            Caption = 'Only debt paid';
        }
        field(43; "Debt and court expenses paid"; Boolean)
        {
            Caption = 'Debt and court expenses paid';
        }
        field(44; "Interest paid"; Boolean)
        {
            Caption = 'Interest paid';
        }
        field(45; "Category"; Enum Category)
        {
            Caption = 'Customer Category';
        }
        field(46; "Accusation Referal Person"; Code[50])
        {
            Caption = 'Referal Person';

        }

        field(47; "Reminder No."; Code[20])
        {
            Caption = 'Reminder No.';
            TableRelation = "Reminder Header";
        }
        field(48; "Court Expenses Amount"; Decimal)
        {
            Caption = 'Court Expenses Amount';
            FieldClass = FlowField;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Document Type" = filter(Payment), "Entry Type" = filter(Application)));


        }
        field(49; "Interest amount paid-Transfer"; Decimal)
        {
            Caption = 'Interest amount paid - Transfer';

        }
        field(50; "Interest amount paid"; Decimal)
        {
            Caption = 'Interest amount paid';
        }
        field(55; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(56; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(57; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(59; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("Customer No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(111; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            TableRelation = Currency;
        }
        field(112; "Interest Rate Doument No."; Text[200])
        {
            Caption = 'Interest Rate Document No.';

        }
        field(113; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
        }

        field(115; "Court Expenses Payment Date"; Date)
        {
            Caption = 'Court Expenses Payment Date';
        }
        field(116; "IP"; Code[20])
        {
            Caption = 'IP';
            TableRelation = Territory where(Type = filter("IP"));

        }
        field(117; "Current IP"; Text[50])
        {
            Caption = 'Current IP';
        }
        field(118; "Court Expenses Amount Paid"; Decimal)
        {
            Caption = 'Court Expenses Amount Paid';

        }
        field(119; "Court Number Record"; Text[100])
        {
            Caption = 'Court Number Record';
        }
        field(120; "Date of Interest Payment"; Date)
        {
            Caption = 'Date Of Interest Payment';
        }
        field(121; "Reprogrammed Debt Date"; date)
        {
            Caption = 'Reprogrammed Debt Date';
        }

        field(123; "Bill Category"; enum "Bill Category ")
        {
            Caption = 'Bill Category';
            FieldClass = FlowField;
            CalcFormula = lookup("Accusation Line"."Bill Category" where("Document No." = field("No.")));

        }
        field(124; "Protocol No."; COde[20])
        {
            Caption = 'Protocl No.';
        }
        field(125; "Court Expenses Amt - Transfer"; Decimal)
        {
            Caption = 'Court Expenses Amt - Transfer';

        }
        field(126; "Court Expenses Amt Paid - Tr"; Decimal) //Tr: short for Transfer
        {
            Caption = 'Court Expenses Amt Paid - Tr';
        }

    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        SalesHeader: Record "Sales Header";


    trigger OnInsert()

    var
        gls: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
    begin
        gls.GET();
        if gls.FindFirst() then begin
            "No." := NoSeriesMgt.GetNextNo(gls."Accusation Entry Series", TODAY, true);
            "Document No." := "No.";
            Reminder := ReminderType::"Before the Accusation";
            "Accusation Referal Person" := UserId;
        end

    end;


    trigger OnModify()
    begin
        "Accusation Referal Person" := UserId;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;


}