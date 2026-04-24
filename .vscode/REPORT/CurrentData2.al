report 50219 "Current Data 2"
{

    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Current Data 2.rdl';

    dataset
    {

        dataitem(Customer; Customer)
        {

            column(No_; Customer."No.") { }
            column(NameCust; NameCust) { }
            column(StatusKupca; StatusKupca) { }
            column(Address; Addressust) { }
            column(Address_2; "Address 2") { }
            column(Street_Customer; "Street Customer") { }
            column(Street_Customer_2; "Street Customer 2") { }
            column(Street_Name_Customer; "Street Name Customer") { }
            column(Street_Name_Customer_2; "Street Name Customer 2") { }
            column(Street_No_; "Street No.") { }
            column(Street_No__2; "Street No. 2") { }
            column(Street_No__Text; "Street No. Text") { }
            column(Street_No_2_Text; "Street No.2 Text") { }
            column(Customer_Stroke; "Customer Stroke") { }
            column(Customer_Stroke_2; "Customer Stroke 2") { }
            column(Zone_stroke; "Zone stroke") { }
            column(Zone_stroke_2; "Zone stroke 2") { }
            column(Customer_String; "Customer String") { }
            column(Customer_String_2; "Customer String 2") { }
            column(Apartment_No__Customer; "Apartment No. Customer") { }
            column(Apartment_No__Customer_2; "Apartment No. Customer 2") { }
            column(Floor_Customer; "Floor Customer") { }
            column(Floor_Customer_2; "Floor Customer 2") { }
            column(Municipality_Code_Customer; "Municipality Code Customer") { }
            column(Municipality_Code_Customer_2; "Municipality Code Customer 2") { }

            column(MZ_Customer; "MZ Customer") { }
            column(MZ_Customer_2; "MZ Customer 2") { }
            column(Post_Code; "Post Code") { }
            column(Post_Code_2; "Post Code 2") { }
            column(City; City) { }
            column(City_2; "City 2") { }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetFilter("MM Exsist", '%1', false);

            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                SH: Record "Status History";
            begin


                NameCust := Name + "Name 2";
                Addressust := Address;

                SH.Reset();
                sh.SetFilter("Customer No.", '%1', "No.");
                sh.SetFilter("Insert Date and Time", '<=%1', CurrentDateTime);
                sh.SetCurrentKey("Insert Date and Time");
                sh.SetFilter(Active, '%1', true);
                if sh.FindLast() then
                    StatusKupca := format(sh."Information of processing")
                else
                    StatusKupca := '';

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
