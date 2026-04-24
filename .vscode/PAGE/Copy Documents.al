report 50004 "Copy MM or Customer"
{
    Caption = 'Copy MM or Customer';
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(TypeCopyObject; TypeCopyObject)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Type Copy Document';
                        //  ToolTip = 'Specifies the type of document that is processed by the report or batch job.';

                        trigger OnValidate()
                        begin
                            FromObjectNo := '';
                            //  ValidateDocNo;
                        end;
                    }
                    field(FromObjectNo; FromObjectNo)
                    {
                        ApplicationArea = Suite;
                        Caption = 'From Object No';
                        ShowMandatory = true;
                        //    ToolTip = 'Specifies the number of the document that is processed by the report or batch job.';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            LookupDocNo;
                        end;

                        trigger OnValidate()
                        begin
                            //     ValidateDocNo;
                        end;
                    }
                    field(Category; Category)
                    {
                        Caption = 'Category';
                    }
                    field(MMNumber; MMNumber)
                    {
                        Caption = 'MM number';
                    }
                    field(HomeNo; HomeNo)
                    {
                        Caption = 'Home No.';
                    }
                    field(ApartmentNo; ApartmentNo)
                    {
                        Caption = 'Apartment No';
                    }
                    field(Floor; Floor)
                    {
                        Caption = 'Floor';
                    }




                }

            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin


            //      ValidateDocNo;

        end;

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            if CloseAction = ACTION::OK then
                if FromObjectNo = '' then
                    Error(NoNotSerErr);

            ValidateDocNo()
;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        ExactCostReversingMandatory: Boolean;
    begin

        SalesSetup.Get();


    end;

    var
        RecordCustomer: Record "Customer";
        Floor: text[250];
        ApartmentNo: Text[250];
        FirstPart: code[20];
        LastPart: Code[20];
        HomeNo: Text[250];
        FromServiceItem: Record "Service Item";
        MMNumber: Integer;
        RecordServiceItem: Record "Service Item";
        NoSeries: Record "No. Series";

        FromCustomer: Record Customer;

        SalesSetup: Record "Sales & Receivables Setup";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        TypeCopyObject: Enum "Enum Copy Document";
        FromObjectNo: Code[20];
        NoNotSerErr: Label 'Select a document number to continue, or choose Cancel to close the page.';
        Category: enum Category;
        NoSeriesMgt: Codeunit NoSeriesExtented;
        NoSeriesCode: code[20];


    procedure SetRecordCustomer(var NewRecordCustomer: Record Customer)
    begin
        NewRecordCustomer.TestField("No.");
        RecordCustomer := NewRecordCustomer;
    end;

    local procedure ValidateDocNo()
    var
        TypeCopyObject2: Enum "Enum Copy Document";
        BrojMM: Integer;
        SetupDefault: Record "Sales & Receivables Setup";
        NoSeriesRelation: Record "No. Series Relationship";
        ServiceManagement: Record "Service Mgt. Setup";
        DefaultNoSeries: code[20];
        Docno: code[20];


    begin



        for BrojMM := 1 to MMNumber do begin
            if FromObjectNo = '' then begin
                FromServiceItem.Init();

            end else
                if FromObjectNo <> '' then begin

                    case TypeCopyObject of
                        TypeCopyObject::MM:
                            begin
                                FromServiceItem.Init();
                                RecordServiceItem.Get(FromObjectNo);
                                FromServiceItem.TransferFields(RecordServiceItem);
                                FromServiceItem."No." := '';
                                SetupDefault.Get();
                                ServiceManagement.Get();

                                DefaultNoSeries := FilterSeries(ServiceManagement."Service Item Nos.", Category);

                                if DefaultNoSeries = '' then
                                    DefaultNoSeries := ServiceManagement."Service Item Nos.";
                                FromServiceItem."No. Series" := DefaultNoSeries;
                                Docno := NoSeriesMgt.GetNextNo(DefaultNoSeries, TODAY, true);
                                FromServiceItem."No." := Docno;

                                //    NoSeriesMgt.InitSeries(DefaultNoSeries, '', today, FromServiceItem."No.", FromServiceItem."No. Series");
                                FromServiceItem."MM Category" := Category;
                                //KucniBroj

                                if HomeNo <> '' then begin

                                    if BrojMM = 1 then begin
                                        FromServiceItem."Home No." := HomeNo;
                                    end
                                    else begin
                                        HomeNo := IncStr(HomeNo);
                                        FromServiceItem."Home No." := HomeNo;
                                    end;

                                end;

                                if Floor <> '' then begin
                                    if BrojMM = 1 then begin
                                        FromServiceItem.Floor := Floor;
                                    end
                                    else begin
                                        Floor := IncStr(Floor);
                                        FromServiceItem.Floor := Floor;
                                    end;

                                end;

                                if ApartmentNo <> '' then begin
                                    if BrojMM = 1 then begin
                                        FromServiceItem."Apartment No." := ApartmentNo;
                                    end
                                    else begin
                                        ApartmentNo := IncStr(ApartmentNo);
                                        FromServiceItem."Apartment No." := ApartmentNo;
                                    end;


                                end;

                                //Sprat
                                //BrojStana
                                FromServiceItem.Insert(true);
                            end;


                        TypeCopyObject::Customer:


                            begin
                                RecordCustomer.Init();
                                FromCustomer.get(FromObjectNo);
                                RecordCustomer.TransferFields(FromCustomer);
                                RecordCustomer."No." := '';
                                SalesSetup.get;
                                DefaultNoSeries := FilterSeries(SalesSetup."Customer Nos.", Category);
                                if DefaultNoSeries = '' then
                                    DefaultNoSeries := SalesSetup."Customer Nos.";

                                RecordCustomer."No. Series" := DefaultNoSeries;
                                Docno := NoSeriesMgt.GetNextNo(DefaultNoSeries, TODAY, true);
                                RecordCustomer."No." := Docno;

                                // NoSeriesMgt.InitSeries(DefaultNoSeries, '', today, RecordCustomer."No.", RecordCustomer."No. Series");
                                RecordCustomer."Customer Category" := Category;

                                if HomeNo <> '' then begin

                                    if BrojMM = 1 then begin
                                        RecordCustomer."Home No. Customer 2" := HomeNo;
                                        RecordCustomer."Home No. Customer" := HomeNo;
                                    end
                                    else begin
                                        HomeNo := IncStr(HomeNo);
                                        RecordCustomer."Home No. Customer 2" := HomeNo;
                                        RecordCustomer."Home No. Customer" := HomeNo;
                                    end;

                                end;

                                if Floor <> '' then begin
                                    if BrojMM = 1 then begin
                                        RecordCustomer."Floor Customer" := Floor;
                                        RecordCustomer."Floor Customer 2" := Floor;
                                    end
                                    else begin
                                        Floor := IncStr(Floor);
                                        RecordCustomer."Floor Customer" := Floor;
                                        RecordCustomer."Floor Customer 2" := Floor;
                                    end;

                                end;

                                if ApartmentNo <> '' then begin
                                    if BrojMM = 1 then begin
                                        RecordCustomer."Apartment No. Customer" := ApartmentNo;
                                        RecordCustomer."Apartment No. Customer 2" := ApartmentNo;
                                    end
                                    else begin
                                        ApartmentNo := IncStr(ApartmentNo);
                                        RecordCustomer."Apartment No. Customer" := ApartmentNo;
                                        RecordCustomer."Apartment No. Customer 2" := ApartmentNo;
                                    end;
                                end;
                                RecordCustomer.Insert(true);
                            end;
                    end;
                end;

        end;
    end;

    local procedure LookupDocNo()
    begin

        case TypeCopyObject of
            TypeCopyObject::MM:
                begin

                    LookupSalesDoc();
                end;
            TypeCopyObject::"Customer":
                begin
                    LookupPostedShipment();
                end;
        end;

        //  ValidateDocNo();
    end;

    local procedure LookupPostedShipment()
    begin


        if FromObjectNo <> '' then
            FromCustomer.SetFilter("No.", '<>%1', RecordCustomer."No.");
        if PAGE.RunModal(0, FromCustomer) = ACTION::LookupOK then
            FromObjectNo := FromCustomer."No.";
    end;

    local procedure LookupSalesDoc()
    begin


        if FromObjectNo <> '' then
            FromServiceItem.SetFilter("No.", '<>%1', RecordServiceItem."No.");
        if PAGE.RunModal(0, FromServiceItem) = ACTION::LookupOK then
            FromObjectNo := FromServiceItem."No.";


    end;





    local procedure FilterSeries(DefaultCode: Code[20]; CategorySent: Enum Category) DefaultRes: code[20]
    var
        NoSeriesRelationship: Record "No. Series Relationship";
        FindNoSeries: Record "No. Series";

    begin
        NoSeries.Reset();
        NoSeriesRelationship.SetRange(Code, DefaultCode);
        if NoSeriesRelationship.FindSet then
            repeat
                NoSeries.Code := NoSeriesRelationship."Series Code";
                if FindNoSeries.get(NoSeries.Code) then begin
                    if FindNoSeries."Customer Category" = CategorySent then
                        DefaultRes := FindNoSeries.Code;
                end;
                NoSeries.Mark := true;
            until NoSeriesRelationship.Next = 0;

    end;





    procedure SetParameters(NewTypeCopyObject: Enum "Enum Copy Document"; NewFromObjectNo: Code[20]; NewCategory: enum Category;
    NewHome: Code[20]; NewFloor: COde[20]; NewApartmanNo: code[20])
    begin
        TypeCopyObject := NewTypeCopyObject;
        FromObjectNo := NewFromObjectNo;
        Category := NewCategory;
        HomeNo := NewHome;
        Floor := NewFloor;
        ApartmentNo := NewApartmanNo;


    end;



}

