report 50216 "Current Data"
{

    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Current Data.rdl';

    dataset
    {
        dataitem("Service Item"; "Service Item")
        {
            UseTemporary = true;
            column(NameCust; NameCust) { }
            column(IHDate; IHDate) { }
            column(StatusKupca; StatusKupca) { }
            column(StatusMM; StatusMM) { }
            column(No_; CustG."No.") { }
            column(GaugezSize; GaugezSize) { }
            column(GaugeNo; GaugeNo) { }
            column(Serial; Serial) { }
            column(Address; Addressust) { }
            column(Address_2; CustG."Address 2") { }
            column(Street_Customer; CustG."Street Customer") { }
            column(Street_Customer_2; CustG."Street Customer 2") { }
            column(Street_Name_Customer; CustG."Street Name Customer") { }
            column(Street_Name_Customer_2; CustG."Street Name Customer 2") { }
            column(Street_No_; CustG."Street No.") { }
            column(Street_No__2; CustG."Street No. 2") { }
            column(Street_No__Text; CustG."Street No. Text") { }
            column(Street_No_2_Text; CustG."Street No.2 Text") { }
            column(Customer_Stroke; CustG."Customer Stroke") { }
            column(Customer_Stroke_2; CustG."Customer Stroke 2") { }
            column(Zone_stroke; CustG."Zone stroke") { }
            column(Zone_stroke_2; CustG."Zone stroke 2") { }
            column(Customer_String; CustG."Customer String") { }
            column(Customer_String_2; CustG."Customer String 2") { }
            column(Apartment_No__Customer; CustG."Apartment No. Customer") { }
            column(Apartment_No__Customer_2; CustG."Apartment No. Customer 2") { }
            column(Floor_Customer; CustG."Floor Customer") { }
            column(Floor_Customer_2; CustG."Floor Customer 2") { }
            column(Municipality_Code_Customer; CustG."Municipality Code Customer") { }
            column(Municipality_Code_Customer_2; CustG."Municipality Code Customer 2") { }

            column(MZ_Customer; CustG."MZ Customer") { }
            column(MZ_Customer_2; CustG."MZ Customer 2") { }
            column(Post_Code; CustG."Post Code") { }
            column(Post_Code_2; CustG."Post Code 2") { }
            column(City; CustG.City) { }
            column(City_2; CustG."City 2") { }
            column(StreeetMM; "Service Item".Street) { }
            column(StreetNameMM; "Service Item"."Street Name MM") { }
            column(StreetNo; "Service Item"."Street No.") { }
            column(StreetNoText; "Service Item"."Street No. Text") { }
            column(AddressMM; "Service Item"."Address MM") { }
            column(MunicipalityMM; "Service Item"."Municipality Code MM") { }
            column(MunicipalityMmname; "Service Item"."Municipality Name MM") { }
            column(MZMM; "Service Item"."MZ MM") { }
            column(MZMmName; "Service Item"."MZ Name MM") { }
            column(MM_No; "Service Item"."No.") { }

            column(FloorMM; "Service Item".Floor) { }
            column(HomeMM; "Service Item"."Home No.") { }
            column(ApartmentMM; "Service Item"."Apartment No.") { }
            column(StrokeMM; "Service Item"."Measuring Point Stroke") { }
            column(StringMM; "Service Item"."Measuring Point string") { }
            column(ZoneMM; "Service Item"."Zone stroke") { }
            column(MMDescr; "Service Item".Description) { }
            column(Off; "Service Item"."Measuring point off") { }
            column(OffDate; "Service Item"."Measuring point off Date") { }
            column(Remotely; RemDa) { }
            column(RemoteType; "Service Item"."Remotely Type") { }
            column(ReadingMode; "Service Item"."Reading Mode") { }
            column(TypeOfReading; "Service Item"."Type of reading") { }
            column(ContractStart; ContractStart) { }
            column(ContractDesc; ContractDesc) { }
            column(CorrecotrFSerial; CorrecotrFSerial) { }
            column(CorrecotrFYear; CorrecotrFYear) { }
            column(CorrecotrFYearDD; CorrecotrFYearDD) { }
            column(CorrectorModel; CorrectorModel) { }
            column(GaugeM; GaugeM) { }
            column(GaugeMDD; GaugeMDD) { }
            column(GaugeMYear; GaugeMYear) { }
            trigger OnPreDataItem()
            var
                myInt: Integer;
                CustOrg: Record "Service Item";
            begin


                CustOrg.Reset();
                CustOrg.CopyFilters("Service Item");
                if CustOrg.FindSet() then
                    repeat
                        "Service Item".Init();
                        "Service Item".TransferFields(CustOrg);
                        "Service Item".Insert();
                    until CustOrg.Next() = 0;
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;


                SH: Record "Status History";
                SHMM: Record "Status History MM";
                IH: Record "Installation History";
            begin
                GlobalLanguage := 1050;
                ContractStart := 0D;
                ContractDesc := '';
                CustomerContract.Reset();
                CustomerContract.SetFilter("Customer No.", '%1', "Service Item"."Customer No.");
                CustomerContract.SetFilter("Starting Date", '<=%1', WorkDate());
                CustomerContract.SetCurrentKey("Starting Date");
                if CustomerContract.FindLast() then begin
                    ContractStart := CustomerContract."Starting Date";
                    ContractDesc := CustomerContract.Description;
                end;
                GlobalLanguage := 1050;
                CustG.Reset();
                CustG.SetFilter("No.", '%1', "Service Item"."Customer No.");
                if CustG.FindFirst() then begin
                    NameCust := CustG.Name + CustG."Name 2";
                    Addressust := CustG.Address;
                end else begin
                    NameCust := '';
                    Addressust := '';
                    CustG."No." := '';
                    CustG.Address := '';
                    CustG."Address 2" := '';
                    CustG."Street Customer" := '';
                    CustG."Street Customer 2" := '';
                    CustG."Street Name Customer" := '';
                    CustG."Street Name Customer 2" := '';
                    CustG."Street No." := '';
                    CustG."Street No. 2" := '';
                    CustG."Street No. Text" := '';
                    CustG."Street No.2 Text" := '';
                    CustG."Customer Stroke" := 0;
                    CustG."Customer Stroke 2" := 0;
                    CustG."Zone stroke" := 0;
                    CustG."Zone stroke 2" := 0;
                    CustG."Customer String" := 0;
                    CustG."Customer String 2" := 0;
                    CustG."Apartment No. Customer" := '';
                    CustG."Apartment No. Customer 2" := '';
                    CustG."Floor Customer" := '';
                    CustG."Floor Customer 2" := '';
                    CustG."Municipality Code Customer" := '';
                    CustG."Municipality Code Customer 2" := '';

                    CustG."MZ Customer" := '';
                    CustG."MZ Customer 2" := '';
                    CustG."Post Code" := '';
                    CustG."Post Code 2" := '';
                    CustG.City := '';
                    CustG."City 2" := '';


                end;
                if ServiceItem.Remotely = true then
                    RemDa := 'DA'

                else
                    RemDa := 'NE';

                SHMM.Reset();
                SHMM.SetFilter("Measuring Point", '%1', "Service Item"."No.");
                SHMM.SetFilter("Insert Date and Time", '<=%1', CurrentDateTime);
                SHMM.SetFilter(Active, '%1', true);
                SHMM.SetCurrentKey("Insert Date and Time");
                if SHMM.FindLast() then
                    StatusMM := format(SHMM."Information of processing")
                else
                    StatusMM := '';

                GaugezSize := '';
                GaugeM := '';
                GaugeMDD := 0;
                GaugeMYear := 0;
                GaugeNo := '';
                Serial := '';
                SH.Reset();
                sh.SetFilter("Customer No.", '%1', "CustG"."No.");
                sh.SetFilter("Insert Date and Time", '<=%1', CurrentDateTime);
                sh.SetCurrentKey("Insert Date and Time");
                sh.SetFilter(Active, '%1', true);
                if sh.FindLast() then
                    StatusKupca := format(sh."Information of processing")
                else
                    StatusKupca := '';
                IH.Reset();
                IH.SetFilter(Active, '%1', true);
                IH.SetFilter("Customer No.", '%1', "CustG"."No.");
                IH.SetFilter("Measuring Point Code", '%1', "Service Item"."No.");
                ih.SetFilter(Type, '%1', ih.Type::Gauge);
                if ih.FindFirst() then begin
                    GaugeF.Reset();
                    GaugeF.SetFilter(Code, '%1', ih.Code);
                    if GaugeF.FindFirst() then begin
                        GaugezSize := GaugeF."Gauge Size";
                        Serial := GaugeF."Inventar number";
                        GaugeNo := GaugeF.Code;
                        IHDate := ih."Installation Date";
                        GaugeM := GaugeF."Meter Manufacturer Desc";
                        GaugeMYear := GaugeF."Year of Production";
                        GaugeMDD := GaugeF."DD calibration";

                    end;

                end;

                CorrectorModel := '';
                CorrecotrFYear := 0;
                CorrecotrFYearDD := 0;
                CorrecotrFSerial := '';

                IH.Reset();
                IH.SetFilter(Active, '%1', true);
                IH.SetFilter("Customer No.", '%1', "CustG"."No.");
                ih.SetFilter(Type, '%1', ih.Type::Corrector);
                IH.SetFilter("Measuring Point Code", '%1', "Service Item"."No.");
                if ih.FindFirst() then begin
                    CorrecotrF.Reset();
                    CorrecotrF.SetFilter(Code, '%1', ih.Code);
                    if CorrecotrF.FindFirst() then begin
                        CorrectorModel := CorrecotrF.Model;
                        CorrecotrFYear := CorrecotrF."Year of Production";
                        CorrecotrFYearDD := CorrecotrF."DD calibration";
                        CorrecotrFSerial := CorrecotrF."Serial Number";


                    end;

                end;

            end;

        }



    }
    var
        NameCust: text;
        ContractStart: date;
        ContractDesc: Text[250];
        StatusKupca: Text[250];
        ServiceItem: Record "Service Item";
        Serial: text;
        ID: Text;
        GaugeF: Record Gauge;
        GaugeMYear: Decimal;
        Addressust: Text[250];
        GaugeMDD: Decimal;
        CorrecotrF: Record "El. Volume Corr";
        CustomerContract: Record "Customer Ledger Entry";
        GaugezSize: text[250];
        GaugeM: text[250];
        RemDa: text;
        MM_No: text[250];
        CorrectorModel: text[250];
        CorrecotrFYear: Decimal;
        CorrecotrFYearDD: Decimal;
        CorrecotrFSerial: text[250];


        IHDate: date;
        StatusMM: Text;
        StreeetMM: text;
        StreetNameMM: text;
        GaugeNo: text;
        StreetNo: text;
        StreetNoText: Text;
        AddressMM: text;
        CustomerR: Record customer;
        MunicipalityMM: text;
        MunicipalityMmname: text;
        MZMM: text;
        MZMmName: text;
        HomeMM: text;
        FloorMM: text;
        ApartmentMM: text;
        StrokeMM: Integer;
        StringMM: Integer;
        ZoneMM: Integer;
        MMDescr: text;
        CustG: record "CUstomer";

}
