report 50000 "Izvjestaj starosna spolna"
{
    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Izvjestaj starosna, spolna, dobna.rdl';

    dataset
    {
        dataitem(DataItem5; "Employee")
        {
            DataItemTableView = WHERE(Status = FILTER(Active));
            column(Sum3; Sum3)
            {
            }
            column(Sum34; Sum34)
            {
            }
            column(Sum45; Sum45)
            {
            }
            column(MaxSum; MaxSum)
            {
            }
            column(Sum5; Sum5)
            {
            }
            column(Sum1; Sum1)
            {
            }
            column(Sum12; Sum12)
            {
            }
            column(Sum2; Sum2)
            {
            }
            column(Sum25; Sum25)
            {
            }
            column(MaxSum2; MaxSum2)
            {
            }
            column(RadniStaz; RadniStaz)
            {
            }
            column(BirthDate; "Birth Date")
            {
            }
            column(Godine; Godine)
            {
            }
            column(Status_Employee; Status)
            {
            }
            column(Years_Employee; "Years of Experience")
            {
            }
            column(Address_CompanyInformation; CompInfo.Address)
            {
            }
            column(Name_CompanyInformation; CompInfo.Name)
            {
            }
            column(Date_CompanyInformation; FORMAT(Date_CompanyInformation, 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(City_CompanyInformation; CompInfo.City)
            {
            }
            column(Gender_Employee; Gender)
            {
                IncludeCaption = true;

            }
            column(Muski; SumMus)
            {
            }
            column(Zenski; SumZen)
            {
            }
            column(Ukupno; SumUkupno)
            {
            }
            column(Sum50; Sum50)
            {
            }
            column(Sum60; Sum60)
            {
            }
            column(DobnaSum; DobnaSum)
            {
            }
            column(Selected; Selected)
            {
            }

            trigger OnAfterGetRecord()
            begin
                    Date_CompanyInformation := TODAY;

                    CompInfo.GET;

                    IF ("Birth Date" <> 0D) THEN
                        Godine := 2022 - DATE2DMY("Birth Date", 3)
                    ELSE
                        Godine := 0;

                    IF (Godine < 30) THEN
                        Sum3 := Sum3 + 1
                    ELSE
                        IF ((Godine >= 30) AND (Godine < 40)) THEN
                            Sum34 := Sum34 + 1
                        ELSE
                            IF ((Godine >= 40) AND (Godine < 50)) THEN
                                Sum45 := Sum45 + 1
                            ELSE
                                IF (Godine >= 50) THEN
                                    Sum5 := Sum5 + 1;

                    MaxSum := Sum3 + Sum34 + Sum45 + Sum5;

                    IF ((Godine >= 50) AND (Godine <= 59)) THEN
                        Sum50 := Sum50 + 1
                    ELSE
                        IF (Godine >= 60) THEN
                            Sum60 := Sum60 + 1;

                    DobnaSum := Sum3 + Sum34 + Sum45 + Sum50 + Sum60;


                    RadniStaz := "Years of Experience";

                    IF (RadniStaz < 10) THEN
                        Sum1 := Sum1 + 1
                    ELSE
                        IF ((RadniStaz >= 10) AND (RadniStaz < 20)) THEN
                            Sum12 := Sum12 + 1
                        ELSE
                            IF ((RadniStaz >= 20) AND (RadniStaz < 25)) THEN
                                Sum2 := Sum2 + 1
                            ELSE
                                Sum25 := Sum25 + 1;

                    MaxSum2 := Sum1 + Sum12 + Sum2 + Sum25;


                    IF (Gender = Gender::Male) THEN
                        SumMus := SumMus + 1
                    ELSE
                        SumZen := SumZen + 1;

                    SumUkupno := SumMus + SumZen;
                
            end;

            trigger OnPreDataItem()
            begin

                Sum3 := 0;
                Sum34 := 0;
                Sum45 := 0;
                Sum5 := 0;
                MaxSum := 0;

                Sum1 := 0;
                Sum12 := 0;
                Sum2 := 0;
                Sum25 := 0;
                MaxSum2 := 0;

                SumMus := 0;
                SumZen := 0;
                SumUkupno := 0;

                Sum50 := 0;
                Sum60 := 0;
                DobnaSum := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Izaberi izvještaj")
                {
                    Caption = 'Izaberi izvještaj';
                    field(Selected; Selected)
                    {
                        Caption = 'Izbor:';
                        OptionCaption = ', Starosna struktura,Spolna struktura,Dobna struktura';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Sum3: Integer;
        Sum34: Integer;
        Sum45: Integer;
        Sum5: Integer;
        MaxSum: Integer;
        Date_CompanyInformation: Date;
        Sum1: Integer;
        Sum12: Integer;
        Sum2: Integer;
        Sum25: Integer;
        MaxSum2: Integer;
        RadniStaz: Integer;
        WorkBooklet: Record "Work Booklet";
        Godine: Integer;
        CompInfo: Record "Company Information";
        SumMus: Integer;
        SumZen: Integer;
        SumUkupno: Integer;
        Sum50: Integer;
        Sum60: Integer;
        DobnaSum: Integer;
        Selected: Option " ","Starosna","Spolna","Dobna";
}

