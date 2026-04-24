tableextension 50030 FixedAsset extends "Fixed Asset"
{
    fields
    {
        // Add changes to table fields here
        field(50014; "Veichle Weight"; Decimal)
        {
            Caption = 'Veichle Weight';
            Description = 'NK01';
        }
        field(50015; "Veichle Load"; Decimal)
        {
            Caption = 'Veichle Load';
            Description = 'NK01';
        }
        field(50006; "Veichle Type"; Option)
        {
            Caption = 'Veichle Type';
            Description = 'NK01';
            OptionCaption = ' ,Putničko vozilo,Teretno vozilo,Kombi,Dostavno vozilo,Sanitetsko vozilo,Terensko vozilo,Specijalno teretno vozilo,Specijalno teretno vozilo - hladnjača,Specijalno policijsko vozilo,Kombinovano,Specijalno vozilo';
            OptionMembers = " ",Passenger,Truck,Van,Delivery,Sanitet,Teren,Special,"Special-fridge","Special-police-veichle",Combined,"Special Veichle";
        }
        field(50009; "Registration No."; Code[20])
        {
            Caption = 'Registration No.';
            Description = 'NK01';
        }
        field(50007; "Veichle Brand"; Option)
        {
            Caption = 'Veichle Model';
            Description = 'NK01';
            OptionCaption = ' ,VW,Seat,Audi,Renault,Toyota,Opel,Mercedes,Mazda,Fiat,Ford';
            OptionMembers = " ",VW,Seat,Audi,Renault,Toyota,Opel,Mercedes;
        }
        field(50010; "Chasis No."; Code[20])
        {
            Caption = 'Chasis No.';
        }
        field(50011; "Date of Production"; Integer)
        {
            Caption = 'Date of Production';
        }
        field(50012; "Engine Volume"; Decimal)
        {
            Caption = 'Engine Volume';
        }
        field(50013; "Engine Power"; Decimal)
        {
            Caption = 'Engine Power';
        }
        field(50018; "Souce of investment"; Option)

        {
            caption = 'Souce of investment';
            OptionCaption = ' ,Procurement with own funds,Procurement from donated funds,Combined procurement';
            OptionMembers = " ","Procurement with own funds","Procurement from donated funds","Combined procurement";
        }
        field(50019; "Donation Percentage"; Decimal)
        {
            Caption = 'Donation Percentage';
            MinValue = 0;
            MaxValue = 100;
        }

        field(50020; "No. particles"; Text[250])
        {
            Caption = 'No. particles';

        }
        field(50021; "No. measurer"; BigInteger)
        {
            Caption = 'No. measurer';

        }
        field(50022; "Pipe Length"; Decimal)
        {
            Caption = 'Pipe Length"';

        }
        field(50023; "No. square footage"; decimal)
        {
            Caption = 'No. square footage';
        }
        field(50024; "R.Employee Obligation"; Code[20])
        {
            Caption = 'R.Employee Obligation';
            TableRelation = Obligation."Responsible Person Name" where("No." = field("No."), Active = filter(true), Type = filter(Employee));
        }
        field(50025; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Obligation."Customer No." where("No." = field("No."), Active = filter(true), Type = filter(Customer));
        }
        field(50026; "Customer Name"; Text[250])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
        }
        field(50027; "Straight-Line %"; Decimal) //ED
        {
            Caption = 'Straight-Line %';
        }
        field(50028; "Gas Station Type"; Text[50])
        {
            Caption = 'Gas Station Type';
            DataClassification = CustomerContent;
            TableRelation = "Gas Station Type".Description;
        }
        field(50029; "Feed Section"; Text[50])
        {
            Caption = 'Feed Section';
            DataClassification = CustomerContent;
            TableRelation = "Feed Section".Description;
        }
        field(50030; "Box"; Text[50])
        {
            Caption = 'Box';
            DataClassification = CustomerContent;
            TableRelation = "Types Of Diseases".Description where(Types = filter(Box));
        }
        field(50031; "Gas Station Parameters"; Integer)
        {
            Caption = 'Gas Station Parameters';
            FieldClass = FlowField;
            CalcFormula = count("Gas Station Parameter" where("Gas Station No." = field("No.")));
            Editable = false;
        }
        field(50032; "Gas Installation Data"; Integer)
        {
            Caption = 'Gas Installation Data';
            FieldClass = FlowField;
            CalcFormula = count("Gas Installation Data" where("Gas Station No." = field("No.")));
            Editable = false;
        }
        // field(50035; "Work Pressure"; Text[250])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Work Pressure', Comment = 'Radni pritisak';
        // }
        field(50034; "Mark"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Mark', Comment = 'Oznaka';
        }
        field(50035; "Gas Station No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Gas Station No.', Comment = 'Br. gasnog postrojenja';
            TableRelation = "Fixed Asset";
        }
        field(50036; "Capacity"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Capacity', Comment = 'Kapacitet';
        }
        field(50037; "Installation Year"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Installation Year', Comment = 'Godina ugradnje';
        }
        field(50038; "Inbound Pressure"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Inbound Pressure', Comment = 'Ulazni pritisak';
        }
        field(50039; "Outbound Pressure"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Outbound Pressure', Comment = 'Izlazni pritisak';
        }
        field(50040; "Blocking Pressure"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Blocking Pressure', Comment = 'Pritisak blokiranja';
        }
        field(50041; "Venting Pressure"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Venting Pressure', Comment = 'Pritisak oduška';
        }
        field(50042; "Schema ML File"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'Schema ML File', Comment = 'Datoteka sheme ML';
        }
        field(50043; "Schema ML"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Schema ML', Comment = 'Shema ML';
            Editable = false;
        }
        field(50044; "Station Schema File"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'Station Schema File', Comment = 'Datoteka sheme stanice';
        }
        field(50045; "Station Schema"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Station Schema', Comment = 'Shema stanice';
            Editable = false;
        }
        field(50046; "Owner No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Owner No.', Comment = 'Br. vlasnika';
            TableRelation = Contact;
        }
        field(50100; "Municipality Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Municipality Code';
            TableRelation = Municipality.Code where(Type = filter(Regular));
        }
        field(50101; "Municipality Name"; Text[250])
        {
            Caption = 'Municipality Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("Municipality Code"), Type = filter(Regular)));
            Editable = false;
        }

        field(50102; "MZ"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Local Community';
            TableRelation = MZ.Code;
        }
        field(50103; "MZ Name"; Text[250])
        {
            Caption = 'MZ Name';
            FieldClass = FlowField;
            CalcFormula = lookup(MZ.Description where(Code = field("MZ")));
            Editable = false;
        }

        field(50104; "Street"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Street';
            TableRelation = Street.Code;
            trigger OnValidate()
            var
                myInt: Integer;
                StreetText: text[20];
                StreetInteger: integer;
                Stroke: Record Stroke;
                Even: Boolean;
                TestSubsCu: Codeunit TestSubsCu;
            begin
                if (Street <> '') and ("Home No." <> '') then begin

                    StreetText := TestSubsCu.RemoveLetter("Street");
                    Evaluate(StreetInteger, StreetText);
                    Even := TestSubsCu.EvenOrOdd(StreetInteger);
                    if Even = true then begin
                        Stroke.Reset();
                        Stroke.SetFilter(Street, '%1', Street);
                        Stroke.SetFilter("Even stroke from", '<=%1', StreetInteger);
                        Stroke.SetFilter("Even stroke to", '>=%1', StreetInteger);
                        if Stroke.FindFirst() then begin
                            Rec.Validate("Municipality Code", Stroke."Municipality Code");
                            Rec.Validate(MZ, Stroke."MZ-Code");

                        end
                        else begin
                            "Municipality Code" := '';
                            MZ := '';


                        end;
                        //tražim parne

                    end
                    else begin

                        Stroke.Reset();
                        Stroke.SetFilter("Odd stroke from", '<=%1', StreetInteger);
                        Stroke.SetFilter("Odd stroke to", '>=%1', StreetInteger);
                        Stroke.SetFilter(Street, '%1', "Street");
                        if Stroke.FindFirst() then begin
                            Rec.Validate("Municipality Code", Stroke."Municipality Code");
                            Rec.Validate(MZ, Stroke."MZ-Code");
                        end
                        else begin
                            "Municipality Code" := '';
                            MZ := '';

                        end;


                    end;
                end
                else begin

                    "Municipality Code" := '';
                    MZ := '';


                end;
                CalcFields("Street Name");

                Address := "Street Name" + ' ' + "Home No.";



            end;

        }


        field(50; Address; Text[100])
        {

            Caption = 'Address';
        }

        field(50105; "Street Name"; Text[250])
        {
            Caption = 'Street Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Street.Description where(Code = field("Street")));
            Editable = false;
        }
        field(50106; "Home No."; Code[5])
        {
            DataClassification = CustomerContent;
            Caption = 'Home No.';
            //  TableRelation = Street."Home No." where(Code = field("Street"));

            trigger OnValidate()
            var

                myInt: Integer;
                StreetText: text[20];
                StreetInteger: integer;
                Stroke: Record Stroke;
                Even: Boolean;
                TestSubsCu: Codeunit TestSubsCu;
            begin
                if (Street <> '') and ("Home No." <> '') then begin

                    StreetText := TestSubsCu.RemoveLetter("Street");
                    Evaluate(StreetInteger, StreetText);
                    Even := TestSubsCu.EvenOrOdd(StreetInteger);
                    if Even = true then begin
                        Stroke.Reset();
                        Stroke.SetFilter(Street, '%1', Street);
                        Stroke.SetFilter("Even stroke from", '<=%1', StreetInteger);
                        Stroke.SetFilter("Even stroke to", '>=%1', StreetInteger);
                        if Stroke.FindFirst() then begin
                            Rec.Validate("Municipality Code", Stroke."Municipality Code");
                            Rec.Validate(MZ, Stroke."MZ-Code");

                        end
                        else begin
                            "Municipality Code" := '';
                            MZ := '';


                        end;
                        //tražim parne

                    end
                    else begin

                        Stroke.Reset();
                        Stroke.SetFilter("Odd stroke from", '<=%1', StreetInteger);
                        Stroke.SetFilter("Odd stroke to", '>=%1', StreetInteger);
                        Stroke.SetFilter(Street, '%1', "Street");
                        if Stroke.FindFirst() then begin
                            Rec.Validate("Municipality Code", Stroke."Municipality Code");
                            Rec.Validate(MZ, Stroke."MZ-Code");
                        end
                        else begin
                            "Municipality Code" := '';
                            MZ := '';

                        end;


                    end;
                end
                else begin

                    "Municipality Code" := '';
                    MZ := '';


                end;
                CalcFields("Street Name");

                Address := "Street Name" + ' ' + "Home No.";



            end;


        }

        field(50107; "Old No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Old No.';
        }

        field(50108; "Disposed Of"; Date) //ED
        {
            Caption = 'Disposed Of';
            FieldClass = FlowField;
            CalcFormula = lookup("FA Depreciation Book"."Disposal Date" where("Fa No." = field("No.")));
        }
        field(50109; "Depreciation Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Depreciation Group', Comment = 'Šifra amortizacione grupe';
            TableRelation = "Insurance Type"."Code";

            trigger OnValidate()
            begin
                FADB.SetFilter("FA No.", '%1', "No.");
                If FADB.FindFirst()
                then begin
                    IT.SETFILTER(Code, '%1', "Depreciation Group");
                    IF IT.FindFirst() then begin
                        FADB.VALIDATE("Straight-Line %", IT.Percentage);
                        "Straight-Line %" := IT.Percentage;
                    end
                    else
                        "Straight-Line %" := ' ';
                end;
                FADB.Modify();
            end;
        }
        field(50110; "Class Code"; Code[20])
        {
            Caption = 'Class Code', Comment = 'Šifra klase';
            TableRelation = "Item Category"."Code" where("Code Category Text" = const(4));
            trigger OnValidate()
            begin
                ItemCategoryTable.Reset();
                ItemCategoryTable.SetFilter(Code, '%1', "Class Code");
                if ItemCategoryTable.FindFirst() then;
                "Class Description" := ItemCategoryTable.Description;
            end;
        }

        field(50111; "Class Description"; Text[100])
        {
            Caption = 'Item Category Decription', Comment = 'Opis klase';
        }


        field(50112; "Group Code"; Code[50])
        {
            Caption = 'Item Group';
            TableRelation = "Item Group" where("Code Category Text" = const(4),
            "Category Code" = field("Class Code"));

            trigger OnValidate()
            begin
                ItemGroupTable.Reset();
                ItemGroupTable.SetFilter("Category Code", '%1', "Class Code");
                ItemGroupTable.SetFilter("Group Code", '%1', "Group Code");
                if ItemGroupTable.FindFirst() then;
                "Group Description" := ItemGroupTable."Group Description";
            end;
        }


        field(50113; "Group Description"; Text[100])
        {
            Caption = 'Item Group Decription', Comment = 'Opis grupe';
        }


        field(50114; "Subgroup"; Code[50])
        {
            Caption = 'Subgroup', Comment = 'Šifra podgrupe';
            TableRelation = ItemSubgroup where("Code Category Text" = const(4),
            "Class Code" = field("Class Code"),
            "Group Code" = field("Group Code"));

            trigger OnValidate()
            begin
                ItemSubgroupTable.Reset();
                ItemSubgroupTable.SetFilter("Class Code", '%1', "Class Code");
                ItemSubgroupTable.SetFilter("Group Code", '%1', "Group Code");
                ItemSubgroupTable.SetFilter("Subgroup Code", '%1', "Subgroup");
                if ItemSubgroupTable.FindFirst() then
                    "Subgroup Description" := ItemSubgroupTable."Subgroup Description";
            end;
        }
        field(50115; "Subgroup Description"; Text[100])
        {
            Caption = 'Subgroup Decription', Comment = 'Opis podgrupe';
        }

        field(50116; "SS number"; Text[100])
        {
            Caption = 'SS number', Comment = 'Broj SSa';
        }
        //R
        field(50117; "Engine Number"; Code[100])
        {
            Caption = 'Engine Number', Comment = 'Broj motora';
        }
        field(50118; "Number of apartments"; Integer)
        {
            Caption = 'Number of apartments', Comment = 'Broj stanova';
        }
        field(50119; "Purch. value"; Decimal) //R
        {
            FieldClass = FlowField;
            Caption = 'Purchase value';
            //TableRelation = "FA Ledger Entry" where("FA Posting Type" = const(0));
            CalcFormula = lookup("FA Ledger Entry".Amount where("FA Posting Type" = const("Acquisition Cost"),
            "FA No." = field("No."), "Part of Book Value" = filter(true), "Depreciation Book Code" = filter('AMORT')));
        }
        field(50120; "Value correction"; Decimal) //R
        {
            FieldClass = FlowField;
            Caption = 'Value correction';
            CalcFormula = sum("FA Ledger Entry".Amount where("FA Posting Type" = const(Depreciation),
            "FA No." = field("No."), "Part of Book Value" = filter(true), "Depreciation Book Code" = filter('AMORT')));
        }
        field(50121; "Write-Down"; Decimal) //R
        {
            FieldClass = FlowField;
            Caption = 'Write-Down';
            CalcFormula = lookup("FA Ledger Entry".Amount where("FA Posting Type" = const("Write-Down"),
            "FA No." = field("No."), "Part of Book Value" = filter(true), "Depreciation Book Code" = filter('AMORT')));
        }
        field(50122; "Appreciation"; Decimal) //R
        {
            FieldClass = FlowField;
            Caption = 'Appreciation';
            CalcFormula = lookup("FA Ledger Entry".Amount where("FA Posting Type" = const(Appreciation),
            "FA No." = field("No."), "Part of Book Value" = filter(true), "Depreciation Book Code" = filter('AMORT')));
        }
        field(50123; "Activation Date"; Date) //R
        {
            FieldClass = Normal;
            Caption = 'Activation Date';

        }
        field(50124; "FA Posting Date"; Date) //R
        {
            FieldClass = FlowField;
            Caption = 'FA Posting Date';
            CalcFormula = lookup("FA Ledger Entry"."FA Posting Date" where("FA Posting Type" = const("Acquisition Cost"),
            "FA No." = field("No."), "Part of Book Value" = filter(true), "Depreciation Book Code" = filter('AMORT')));
        }
        field(50125; "FA Depreciation Date"; Date) //R
        {
            FieldClass = FlowField;
            Caption = 'FA Depreciation Date';
            CalcFormula = lookup("FA Ledger Entry"."FA Posting Date" where("FA No." = field("No."), "FA Posting Category" = const(Disposal)));
        }
        field(50126; "Posted Whse. Receipt Line."; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Posted Whse. Receipt Line.';
            CalcFormula = sum("Posted Whse. Receipt Line".Quantity where("Item No." = field("No.")));
        }



    }

    var
        myInt: Integer;
        FADB: Record "FA Depreciation Book";
        IT: Record "Insurance Type";
        ItemCategoryTable: Record "Item Category";
        ItemGroupTable: Record "Item Group";
        ItemSubgroupTable: Record ItemSubgroup;


    trigger OnAfterDelete()
    var
        GasInstallationData: Record "Gas Installation Data";
    begin
        GasInstallationData.SetRange("Gas Station No.", "No.");
        GasInstallationData.DeleteAll(true);
    end;

    trigger OnAfterModify()
    begin
        FADB.SetFilter("FA No.", '%1', "No.");
        If FADB.FindFirst()
        then begin
            IT.SETFILTER(Code, '%1', "Depreciation Group");
            IF IT.FindFirst() then begin
                FADB.VALIDATE("Straight-Line %", IT.Percentage);
                FADB.Modify();
            end;
        end;
    end;




    var
        CanModify1: Boolean;
        IsModifying: Boolean;
        UserPersonalization: Record "User Personalization";

}