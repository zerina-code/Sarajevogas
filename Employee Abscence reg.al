report 50197 "Employee Absence Reg"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Employee Absence Reg.rdl';
    PreviewMode = Normal;
    dataset
    {
        dataitem(GodineBrojevi; "Integer")
        {
            column(Godine; Godine)
            {
            }
            column(First_Column_No; First_Column_No)
            {
            }
            column(Second_Column_No; Second_Column_No)
            {
            }
            column(Third_Column_No; Third_Column_No)
            {
            }
            column(IndeksKolone; IndeksKolone)
            {
            }
            column(IndeksFirstCount; IndeksFirstCount)
            {
            }
            column(IndeksSecondCount; IndeksSecondCount)
            {
            }
            column(Column1; Column1)
            {
            }
            column(Column2; Column2)
            {
            }
            column(Column3; Column3)
            {
            }
            column(Column4; Column4)
            {
            }
            column(Column5; Column5)
            {
            }
            column(Column6; Column6)
            {
            }
            column(Column7; Column7)
            {
            }
            column(Column8; Column8)
            {
            }
            column(Column9; Column9)
            {
            }
            column(Column10; Column10)
            {
            }
            column(Column11; Column11)
            {
            }
            column(Column12; Column12)
            {
            }
            column(Column13; Column13)
            {
            }
            column(Column14; Column14)
            {
            }
            column(Column15; Column15)
            {
            }
            column(Column16; Column16)
            {
            }
            column(Column17; Column17)
            {
            }
            dataitem(Employee_Absence; "Employee Absence")
            {
                column(Employee_No; "Employee No.")
                {
                }
                column(Cause_Of_Absence; Description)
                {
                }
                column(Hours_Absent; Quantity)
                {
                }
                column(First_Name; First_Name)
                {
                }
                column(Last_Name; Last_Name)
                {
                }
                column(Department_Name; Department_Name)
                {
                }
                column(Troskovi; Troskovi)
                {
                }
                column(UkupniTroskoviLjudi; UkupniTroskoviLjudi)
                {
                }
                column(UkupniTroskoviOrgJed; UkupniTroskoviOrgJed)
                {
                }
                column(UkupniTroskoviOdsustvo; UkupniTroskoviOdsustvo)
                {
                }
                column(TroskoviOdustvoOrgJed; TroskoviOdustvoOrgJed)
                {
                }
                column(TotalTroskovi; TotalTroskovi)
                {
                }
                column(EmployeeOrder; EmployeeOrder)
                {
                }
                column(SatiRad; SatiRad)
                {
                }
                column(SatiOdsustvoSaRada; SatiOdsustvoSaRada)
                {
                }
                column(SatiOstaleOsnoveIsplata; SatiOstaleOsnove)
                {
                }
                column(UkupnoSati; UkupnoSati)
                {
                }
                column(RadKM; RadKM)
                {
                }
                column(OdsustvoSaRadaKM; OdsustvoSaRadaKM)
                {
                }
                column(OstaleOsnoveIsplataKM; OstaleOsnoveIsplataKM)
                {
                }
                column(UkupnoKM; UkupnoKM)
                {
                }
                column(RadUcesce; RadUcesce)
                {
                }
                column(OdsustvoSaRadaUcesce; OdsustvoSaRadaUcesce)
                {
                }
                column(OstaleOsnoveIsplataUcesce; OstaleOsnoveIsplataUcesce)
                {
                }
                column(UkupnoUcesce; UkupnoUcesce)
                {
                }
                column(Selected; Selected)
                {
                }
                column(IndeksSatiRad; IndeksSatiRad)
                {
                }
                column(IndeksSatiOdsustvoSaRada; IndeksSatiOdsustvoSaRada)
                {
                }
                column(IndeksSatiOstaleOsnove; IndeksSatiOstaleOsnove)
                {
                }
                column(IndeksSatiUkupni; IndeksSatiUkupni)
                {
                }
                column(IndeksRadKM; IndeksRadKM)
                {
                }
                column(IndeksOdsustvoSaRadaKM; IndeksOdsustvoSaRadaKM)
                {
                }
                column(IndeksOstaleOsnoveKM; IndeksOstaleOsnoveKM)
                {
                }
                column(IndeksUkupniKM; IndeksUkupniKM)
                {
                }
                column(SatiRadGodinaVeca; SatiRadGodinaVeca)
                {
                }
                column(TotalNetoBezNaknada; TotalNetoBezNaknada)
                {
                }
                column(TotalRazlikaTopliObrokPoSporazumu; TotalRazlikaTopliObrokPoSporazumu)
                {
                }
                column(TotalMinuliRad05; TotalMinuliRad05)
                {
                }
                column(TotalRadniUcinak; TotalRadniUcinak)
                {
                }
                column(TotalPrekoVrRad; TotalPrekoVrRad)
                {
                }
                column(TotalPripravnostRadniNeradniDani; TotalPripravnostRadniNeradniDani)
                {
                }
                column(TotalNocniRad35; TotalNocniRad35)
                {
                }
                column(TotalRadNaDrzavniPraznik; TotalRadNaDrzavniPraznik)
                {
                }
                column(TotalNetoBezNaknadaMinuliRad; TotalNetoBezNaknadaMinuliRad)
                {
                }
                column(TotalPorezNaDohodak; TotalPorezNaDohodak)
                {
                }
                column(TotalNetoNaknadeBezPoreza; TotalNetoNaknadeBezPoreza)
                {
                }
                column(TotalProsjekRadnika12mjeseci; TotalProsjekRadnika12mjeseci)
                {
                }
                column(TotalProsjekNetoBezNaknadeBezMinuliRad; TotalProsjekNetoBezNaknadeBezMinuliRad)
                {
                }
                column(TotalProsjekNetoBezNaknadeSaMinuliRad; TotalProsjekNetoBezNaknadeSaMinuliRad)
                {
                }
                column(TotalProsjekNetoSveNaknade; TotalProsjekNetoSveNaknade)
                {
                }
                column(PK_NoOfEmployees; PK_NoOfEmployees)
                {
                }
                column(NK_NoOfEmployees; NK_NoOfEmployees)
                {
                }
                column(VKV_NoOfEmployees; VKV_NoOfEmployees)
                {
                }
                column(VSS_NoOfEmployees; VSS_NoOfEmployees)
                {
                }
                column(VSHS_NoOfEmployees; VSHS_NoOfEmployees)
                {
                }
                column(KV_NoOfEmployees; KV_NoOfEmployees)
                {
                }
                column(SSS_NoOfEmployees; SSS_NoOfEmployees)
                {
                }
                column(TotalNumberOfEmployees; TotalNumberOfEmployees)
                {
                }
                column(VSSNetoBezNaknada; VSSNetoBezNaknada)
                {
                }
                column(SSSNetoBezNaknada; SSSNetoBezNaknada)
                {
                }
                column(VSHSNetoBezNaknada; VSHSNetoBezNaknada)
                {
                }
                column(VKVNetoBezNaknada; VKVNetoBezNaknada)
                {
                }
                column(KVNetoBezNaknada; KVNetoBezNaknada)
                {
                }
                column(PKNetoBezNaknada; PKNetoBezNaknada)
                {
                }
                column(NKNetoBezNaknada; NKNetoBezNaknada)
                {
                }
                column(VSSRazlikaTopliObrokPoSporazumu; VSSRazlikaTopliObrokPoSporazumu)
                {
                }
                column(VSHSRazlikaTopliObrokPoSporazumu; VSHSRazlikaTopliObrokPoSporazumu)
                {
                }
                column(VKVRazlikaTopliObrokPoSporazumu; VKVRazlikaTopliObrokPoSporazumu)
                {
                }
                column(SSSRazlikaTopliObrokPoSporazumu; SSSRazlikaTopliObrokPoSporazumu)
                {
                }
                column(KVRazlikaTopliObrokPoSporazumu; KVRazlikaTopliObrokPoSporazumu)
                {
                }
                column(PKRazlikaTopliObrokPoSporazumu; PKRazlikaTopliObrokPoSporazumu)
                {
                }
                column(NKRazlikaTopliObrokPoSporazumu; NKRazlikaTopliObrokPoSporazumu)
                {
                }
                column(VSSMinuliRad05; VSSMinuliRad05)
                {
                }
                column(VSHSMinuliRad05; VSHSMinuliRad05)
                {
                }
                column(VKVMinuliRad05; VKVMinuliRad05)
                {
                }
                column(SSSMinuliRad05; SSSMinuliRad05)
                {
                }
                column(KVMinuliRad05; KVMinuliRad05)
                {
                }
                column(PKMinuliRad05; PKMinuliRad05)
                {
                }
                column(NKMinuliRad05; NKMinuliRad05)
                {
                }
                column(VSSRadniUčinak; VSSRadniUčinak)
                {
                }
                column(VSHSRadniUčinak; VSHSRadniUčinak)
                {
                }
                column(VKVRadniUčinak; VKVRadniUčinak)
                {
                }
                column(SSSRadniUčinak; SSSRadniUčinak)
                {
                }
                column(KVRadniUčinak; KVRadniUčinak)
                {
                }
                column(PKRadniUčinak; PKRadniUčinak)
                {
                }
                column(NKRadniUčinak; NKRadniUčinak)
                {
                }
                column(VSSPrekoVremeniRad; VSSPrekoVremeniRad)
                {
                }
                column(VSHSPrekoVremeniRad; VSHSPrekoVremeniRad)
                {
                }
                column(VKVPrekoVremeniRad; VKVPrekoVremeniRad)
                {
                }
                column(SSSPrekoVremeniRad; SSSPrekoVremeniRad)
                {
                }
                column(KVPrekoVremeniRad; KVPrekoVremeniRad)
                {
                }
                column(PKPrekoVremeniRad; PKPrekoVremeniRad)
                {
                }
                column(NKPrekoVremeniRad; NKPrekoVremeniRad)
                {
                }
                column(VSSPripravnostRadniNeradniDani; VSSPripravnostRadniNeradniDani)
                {
                }
                column(VSHSPripravnostRadniNeradniDani; VSHSPripravnostRadniNeradniDani)
                {
                }
                column(VKVPripravnostRadniNeradniDani; VKVPripravnostRadniNeradniDani)
                {
                }
                column(SSSPripravnostRadniNeradniDani; SSSPripravnostRadniNeradniDani)
                {
                }
                column(KVPripravnostRadniNeradniDani; KVPripravnostRadniNeradniDani)
                {
                }
                column(PKPripravnostRadniNeradniDani; PKPripravnostRadniNeradniDani)
                {
                }
                column(NKPripravnostRadniNeradniDani; NKPripravnostRadniNeradniDani)
                {
                }
                column(VSSNocniRad; VSSNocniRad)
                {
                }
                column(VSHSNocniRad; VSHSNocniRad)
                {
                }
                column(VKVNocniRad; VKVNocniRad)
                {
                }
                column(SSSNocniRad; SSSNocniRad)
                {
                }
                column(KVNocniRad; KVNocniRad)
                {
                }
                column(PKNocniRad; PKNocniRad)
                {
                }
                column(NKNocniRad; NKNocniRad)
                {
                }
                column(VSSRadNaDrzavniPraznik; VSSRadNaDrzavniPraznik)
                {
                }
                column(VSHSRadNaDrzavniPraznik; VSHSRadNaDrzavniPraznik)
                {
                }
                column(VKVRadNaDrzavniPraznik; VKVRadNaDrzavniPraznik)
                {
                }
                column(SSSRadNaDrzavniPraznik; SSSRadNaDrzavniPraznik)
                {
                }
                column(KVRadNaDrzavniPraznik; KVRadNaDrzavniPraznik)
                {
                }
                column(PKRadNaDrzavniPraznik; PKRadNaDrzavniPraznik)
                {
                }
                column(NKRadNaDrzavniPraznik; NKRadNaDrzavniPraznik)
                {
                }
                column(VSSNetoBezNaknadaMinuli; VSSNetoBezNaknadaMinuli)
                {
                }
                column(VSHSNetoBezNaknadaMinuli; VSHSNetoBezNaknadaMinuli)
                {
                }
                column(VKVNetoBezNaknadaMinuli; VKVNetoBezNaknadaMinuli)
                {
                }
                column(SSSNetoBezNaknadaMinuli; SSSNetoBezNaknadaMinuli)
                {
                }
                column(KVNetoBezNaknadaMinuli; KVNetoBezNaknadaMinuli)
                {
                }
                column(PKNetoBezNaknadaMinuli; PKNetoBezNaknadaMinuli)
                {
                }
                column(NKNetoBezNaknadaMinuli; NKNetoBezNaknadaMinuli)
                {
                }
                column(VSSPorezNaDohodak; VSSPorezNaDohodak)
                {
                }
                column(VSHSPorezNaDohodak; VSHSPorezNaDohodak)
                {
                }
                column(VKVPorezNaDohodak; VKVPorezNaDohodak)
                {
                }
                column(SSSPorezNaDohodak; SSSPorezNaDohodak)
                {
                }
                column(KVPorezNaDohodak; KVPorezNaDohodak)
                {
                }
                column(PKPorezNaDohodak; PKPorezNaDohodak)
                {
                }
                column(NKPorezNaDohodak; NKPorezNaDohodak)
                {
                }
                column(VSSNetoNaknadeBezPoreza; VSSNetoNaknadeBezPoreza)
                {
                }
                column(VSHSNetoNaknadeBezPoreza; VSHSNetoNaknadeBezPoreza)
                {
                }
                column(VKVNetoNaknadeBezPoreza; VKVNetoNaknadeBezPoreza)
                {
                }
                column(SSSNetoNaknadeBezPoreza; SSSNetoNaknadeBezPoreza)
                {
                }
                column(KVNetoNaknadeBezPoreza; KVNetoNaknadeBezPoreza)
                {
                }
                column(PKNetoNaknadeBezPoreza; PKNetoNaknadeBezPoreza)
                {
                }
                column(NKNetoNaknadeBezPoreza; NKNetoNaknadeBezPoreza)
                {
                }
                column(VSSProsjekRadnika12Mjeseci; VSSProsjekRadnika12Mjeseci)
                {
                }
                column(VSHSProsjekRadnika12Mjeseci; VSHSProsjekRadnika12Mjeseci)
                {
                }
                column(VKVProsjekRadnika12Mjeseci; VKVProsjekRadnika12Mjeseci)
                {
                }
                column(SSSProsjekRadnika12Mjeseci; SSSProsjekRadnika12Mjeseci)
                {
                }
                column(KVProsjekRadnika12Mjeseci; KVProsjekRadnika12Mjeseci)
                {
                }
                column(PKProsjekRadnika12Mjeseci; PKProsjekRadnika12Mjeseci)
                {
                }
                column(NKProsjekRadnika12Mjeseci; NKProsjekRadnika12Mjeseci)
                {
                }
                column(VSSProsjekBezNaknadaBezMinuli; VSSProsjekBezNaknadaBezMinuli)
                {
                }
                column(VSHSProsjekBezNaknadaBezMinuli; VSHSProsjekBezNaknadaBezMinuli)
                {
                }
                column(VKVProsjekBezNaknadaBezMinuli; VKVProsjekBezNaknadaBezMinuli)
                {
                }
                column(SSSProsjekBezNaknadaBezMinuli; SSSProsjekBezNaknadaBezMinuli)
                {
                }
                column(KVProsjekBezNaknadaBezMinuli; KVProsjekBezNaknadaBezMinuli)
                {
                }
                column(PKProsjekBezNaknadaBezMinuli; PKProsjekBezNaknadaBezMinuli)
                {
                }
                column(NKProsjekBezNaknadaBezMinuli; NKProsjekBezNaknadaBezMinuli)
                {
                }
                column(VSSProsjekBezNaknadaMinuli; VSSProsjekBezNaknadaMinuli)
                {
                }
                column(VSHSProsjekBezNaknadaMinuli; VSHSProsjekBezNaknadaMinuli)
                {
                }
                column(VKVProsjekBezNaknadaMinuli; VKVProsjekBezNaknadaMinuli)
                {
                }
                column(SSSProsjekBezNaknadaMinuli; SSSProsjekBezNaknadaMinuli)
                {
                }
                column(KVProsjekBezNaknadaMinuli; KVProsjekBezNaknadaMinuli)
                {
                }
                column(PKProsjekBezNaknadaMinuli; PKProsjekBezNaknadaMinuli)
                {
                }
                column(NKProsjekBezNaknadaMinuli; NKProsjekBezNaknadaMinuli)
                {
                }
                column(VSSProsjekNetoSveNaknade; VSSProsjekNetoSveNaknade)
                {
                }
                column(VSHSProsjekNetoSveNaknade; VSHSProsjekNetoSveNaknade)
                {
                }
                column(VKVProsjekNetoSveNaknade; VKVProsjekNetoSveNaknade)
                {
                }
                column(SSSProsjekNetoSveNaknade; SSSProsjekNetoSveNaknade)
                {
                }
                column(KVProsjekNetoSveNaknade; KVProsjekNetoSveNaknade)
                {
                }
                column(PKProsjekNetoSveNaknade; PKProsjekNetoSveNaknade)
                {
                }
                column(NKProsjekNetoSveNaknade; NKProsjekNetoSveNaknade)
                {
                }

                trigger OnPreDataItem()
                begin
                    Employee_Absence.SetFilter("From Date", '>=%1', FromDate);
                    Employee_Absence.SetFilter("To Date", '<=%1', ToDate);
                    SifreOdsustva := GetCOACodesOdsustvoSaRada();
                    SifreOstaleOsnove := GetCOACodesOstaleOsnoveIsplata();
                    PrekovremeniRadSifre := GetCOACodesPrekovremeniRad();
                    PripravnostSifre := GetCOACodesPripravnost();
                    MinuliRadSifre05 := GetCOACodesMinuliRad05();
                    RadniUcinakSifre := GetCOACodesRadniUcinak();
                    Troskovi := 0;
                    UkupniTroskoviLjudi := 0;
                    UkupniTroskoviOrgJed := 0;
                    UkupniTroskoviOdsustvo := 0;
                    TroskoviOdustvoOrgJed := 0;
                    TotalTroskovi := 0;
                    UkupnoUcesce := 0;
                    IndeksSatiRad := 0;
                    IndeksSatiOdsustvoSaRada := 0;
                    IndeksSatiOstaleOsnove := 0;
                    IndeksSatiUkupni := 0;
                    IndeksRadKM := 0;
                    IndeksOdsustvoSaRadaKM := 0;
                    IndeksOstaleOsnoveKM := 0;
                    IndeksUkupniKM := 0;
                    TotalNetoBezNaknada := 0;
                    TotalRazlikaTopliObrokPoSporazumu := 0;
                    TotalMinuliRad05 := 0;
                    TotalRadniUcinak := 0;
                    TotalPrekoVrRad := 0;
                    TotalPripravnostRadniNeradniDani := 0;
                    TotalNocniRad35 := 0;
                    TotalRadNaDrzavniPraznik := 0;
                    TotalNetoBezNaknadaMinuliRad := 0;
                    TotalPorezNaDohodak := 0;
                    TotalNetoNaknadeBezPoreza := 0;
                    TotalProsjekRadnika12mjeseci := 0;
                    TotalProsjekNetoBezNaknadeBezMinuliRad := 0;
                    TotalProsjekNetoBezNaknadeSaMinuliRad := 0;
                    TotalProsjekNetoSveNaknade := 0;

                    VSS_NoOfEmployees := 0;
                    VSHS_NoOfEmployees := 0;
                    VKV_NoOfEmployees := 0;
                    SSS_NoOfEmployees := 0;
                    KV_NoOfEmployees := 0;
                    PK_NoOfEmployees := 0;
                    NK_NoOfEmployees := 0;

                    VSSNetoBezNaknada := 0;
                    VSHSNetoBezNaknada := 0;
                    VKVNetoBezNaknada := 0;
                    SSSNetoBezNaknada := 0;
                    KVNetoBezNaknada := 0;
                    PKNetoBezNaknada := 0;
                    NKNetoBezNaknada := 0;

                    VSSRazlikaTopliObrokPoSporazumu := 0;
                    VSHSRazlikaTopliObrokPoSporazumu := 0;
                    VKVRazlikaTopliObrokPoSporazumu := 0;
                    SSSRazlikaTopliObrokPoSporazumu := 0;
                    KVRazlikaTopliObrokPoSporazumu := 0;
                    PKRazlikaTopliObrokPoSporazumu := 0;
                    NKRazlikaTopliObrokPoSporazumu := 0;

                    VSSMinuliRad05 := 0;
                    VSHSMinuliRad05 := 0;
                    VKVMinuliRad05 := 0;
                    SSSMinuliRad05 := 0;
                    KVMinuliRad05 := 0;
                    PKMinuliRad05 := 0;
                    NKMinuliRad05 := 0;

                    VSSRadniUčinak := 0;
                    VSHSRadniUčinak := 0;
                    VKVRadniUčinak := 0;
                    SSSRadniUčinak := 0;
                    KVRadniUčinak := 0;
                    PKRadniUčinak := 0;
                    NKRadniUčinak := 0;

                    VSSPrekoVremeniRad := 0;
                    VSHSPrekoVremeniRad := 0;
                    VKVPrekoVremeniRad := 0;
                    SSSPrekoVremeniRad := 0;
                    KVPrekoVremeniRad := 0;
                    PKPrekoVremeniRad := 0;
                    NKPrekoVremeniRad := 0;

                    VSSPripravnostRadniNeradniDani := 0;
                    VSHSPripravnostRadniNeradniDani := 0;
                    VKVPripravnostRadniNeradniDani := 0;
                    SSSPripravnostRadniNeradniDani := 0;
                    KVPripravnostRadniNeradniDani := 0;
                    PKPripravnostRadniNeradniDani := 0;
                    NKPripravnostRadniNeradniDani := 0;

                    VSSNocniRad := 0;
                    VSHSNocniRad := 0;
                    VKVNocniRad := 0;
                    SSSNocniRad := 0;
                    KVNocniRad := 0;
                    PKNocniRad := 0;
                    NKNocniRad := 0;

                    VSSRadNaDrzavniPraznik := 0;
                    VSHSRadNaDrzavniPraznik := 0;
                    VKVRadNaDrzavniPraznik := 0;
                    SSSRadNaDrzavniPraznik := 0;
                    KVRadNaDrzavniPraznik := 0;
                    PKRadNaDrzavniPraznik := 0;
                    NKRadNaDrzavniPraznik := 0;

                    VSSNetoBezNaknadaMinuli := 0;
                    VSHSNetoBezNaknadaMinuli := 0;
                    VKVNetoBezNaknadaMinuli := 0;
                    SSSNetoBezNaknadaMinuli := 0;
                    KVNetoBezNaknadaMinuli := 0;
                    PKNetoBezNaknadaMinuli := 0;
                    NKNetoBezNaknadaMinuli := 0;

                    VSSProsjekBezNaknadaBezMinuli := 0;
                    VSHSProsjekBezNaknadaBezMinuli := 0;
                    VKVProsjekBezNaknadaBezMinuli := 0;
                    SSSProsjekBezNaknadaBezMinuli := 0;
                    KVProsjekBezNaknadaBezMinuli := 0;
                    PKProsjekBezNaknadaBezMinuli := 0;
                    NKProsjekBezNaknadaBezMinuli := 0;

                    VSSProsjekBezNaknadaMinuli := 0;
                    VSHSProsjekBezNaknadaMinuli := 0;
                    VKVProsjekBezNaknadaMinuli := 0;
                    SSSProsjekBezNaknadaMinuli := 0;
                    KVProsjekBezNaknadaMinuli := 0;
                    PKProsjekBezNaknadaMinuli := 0;
                    NKProsjekBezNaknadaMinuli := 0;

                    VSSProsjekNetoSveNaknade := 0;
                    VSHSProsjekNetoSveNaknade := 0;
                    VKVProsjekNetoSveNaknade := 0;
                    SSSProsjekNetoSveNaknade := 0;
                    KVProsjekNetoSveNaknade := 0;
                    PKProsjekNetoSveNaknade := 0;
                    NKProsjekNetoSveNaknade := 0;

                    EmpNoSSSPrevious := '';

                end;

                trigger OnAfterGetRecord();
                begin

                    TotalNumberOfEmployees := 0;
                    if (Selected = Selected::OstvareniSati) then begin
                        Sihtarice.Reset();
                        Sihtarice.SetFilter("Cause of Absence Code", '%1', 'RRD');
                        Sihtarice.SetFilter("From Date", '>=%1', YearStartDate);
                        Sihtarice.SetFilter("To Date", '<=%1', YearEndDate);
                        if Sihtarice.FindSet() then begin
                            Sihtarice.CalcSums(Quantity);
                            SatiRad := Sihtarice.Quantity;
                        end
                        else begin
                            SatiRad := 0;
                        end;
                        Sihtarice.Reset();
                        Sihtarice.SetFilter("Cause of Absence Code", '%1', 'RRD');
                        Sihtarice.SetFilter("From Date", '>=%1', IndeksGodinaVecaStartDate);
                        Sihtarice.SetFilter("To Date", '<=%1', IndeksGodinaVecaEndDate);
                        if Sihtarice.FindSet() then begin
                            Sihtarice.CalcSums(Quantity);
                            SatiRadGodinaVeca := Sihtarice.Quantity;
                        end
                        else begin
                            SatiRadGodinaVeca := 0;
                        end;
                        Sihtarice.Reset();
                        Sihtarice.SetFilter("From Date", '>=%1', YearStartDate);
                        Sihtarice.SetFilter("To Date", '<=%1', YearEndDate);
                        Sihtarice.SetFilter("Cause of Absence Code", SifreOdsustva);
                        if Sihtarice.FindSet() then begin
                            Sihtarice.CalcSums(Quantity);
                            SatiOdsustvoSaRada := Sihtarice.Quantity;
                        end
                        else begin
                            SatiOdsustvoSaRada := 0;
                        end;
                        Sihtarice.Reset();
                        Sihtarice.SetFilter("From Date", '>=%1', IndeksGodinaVecaStartDate);
                        Sihtarice.SetFilter("To Date", '<=%1', IndeksGodinaVecaEndDate);
                        Sihtarice.SetFilter("Cause of Absence Code", SifreOdsustva);
                        if Sihtarice.FindSet() then begin
                            Sihtarice.CalcSums(Quantity);
                            SatiOdsustvoSaRadaGodinaVeca := Sihtarice.Quantity;
                        end
                        else begin
                            SatiOdsustvoSaRadaGodinaVeca := 0;
                        end;
                        Sihtarice.Reset();
                        Sihtarice.SetFilter("From Date", '>=%1', YearStartDate);
                        Sihtarice.SetFilter("To Date", '<=%1', YearEndDate);
                        Sihtarice.SetFilter("Cause of Absence Code", SifreOstaleOsnove);
                        if Sihtarice.FindSet() then begin
                            Sihtarice.CalcSums(Quantity);
                            SatiOstaleOsnove := Sihtarice.Quantity;
                        end
                        else begin
                            SatiOstaleOsnove := 0;
                        end;
                        Sihtarice.Reset();
                        Sihtarice.SetFilter("From Date", '>=%1', IndeksGodinaVecaStartDate);
                        Sihtarice.SetFilter("To Date", '<=%1', IndeksGodinaVecaEndDate);
                        Sihtarice.SetFilter("Cause of Absence Code", SifreOstaleOsnove);
                        if Sihtarice.FindSet() then begin
                            Sihtarice.CalcSums(Quantity);
                            SatiOstaleOsnoveGodinaVeca := Sihtarice.Quantity;
                        end
                        else begin
                            SatiOstaleOsnoveGodinaVeca := 0;
                        end;
                        Sihtarice.Reset();
                        Sihtarice.SetFilter("From Date", '>=%1', YearStartDate);
                        Sihtarice.SetFilter("To Date", '<=%1', YearEndDate);
                        if Sihtarice.FindSet() then begin
                            Sihtarice.CalcSums(Quantity);
                            UkupnoSati := Sihtarice.Quantity;
                        end
                        else begin
                            UkupnoSati := 0;
                        end;
                        Sihtarice.Reset();
                        Sihtarice.SetFilter("From Date", '>=%1', IndeksGodinaVecaStartDate);
                        Sihtarice.SetFilter("To Date", '<=%1', IndeksGodinaVecaEndDate);
                        if Sihtarice.FindSet() then begin
                            Sihtarice.CalcSums(Quantity);
                            UkupnoSatiGodinaVeca := Sihtarice.Quantity;
                        end
                        else begin
                            UkupnoSatiGodinaVeca := 0;
                        end;
                        Trosak.Reset();
                        Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                        Trosak.SetFilter(Description, 'RRD');
                        if Trosak.FindSet() then begin
                            Trosak.CalcSums("Cost Amount (Actual)");
                            RadKM := Trosak."Cost Amount (Actual)";
                        end
                        else begin
                            RadKM := 0;
                        end;
                        Trosak.Reset();
                        Trosak.SetFilter("Posting Date", '%1..%2', IndeksGodinaVecaStartDate, IndeksGodinaVecaEndDate);
                        Trosak.SetFilter(Description, 'RRD');
                        if Trosak.FindSet() then begin
                            Trosak.CalcSums("Cost Amount (Actual)");
                            RadKMGodinaVeca := Trosak."Cost Amount (Actual)";
                        end
                        else begin
                            RadKMGodinaVeca := 0;
                        end;
                        Trosak.Reset();
                        Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                        Trosak.SetFilter(Description, SifreOdsustva);
                        if Trosak.FindSet() then begin
                            Trosak.CalcSums("Cost Amount (Actual)");
                            OdsustvoSaRadaKM := Trosak."Cost Amount (Actual)";
                        end
                        else begin
                            OdsustvoSaRadaKM := 0;
                        end;
                        Trosak.Reset();
                        Trosak.SetFilter("Posting Date", '%1..%2', IndeksGodinaVecaStartDate, IndeksGodinaVecaEndDate);
                        Trosak.SetFilter(Description, SifreOdsustva);
                        if Trosak.FindSet() then begin
                            Trosak.CalcSums("Cost Amount (Actual)");
                            OdsustvoSaRadaKMGodinaVeca := Trosak."Cost Amount (Actual)";
                        end
                        else begin
                            OdsustvoSaRadaKMGodinaVeca := 0;
                        end;
                        Trosak.Reset();
                        Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                        Trosak.SetFilter(Description, SifreOstaleOsnove);
                        if Trosak.FindSet() then begin
                            Trosak.CalcSums("Cost Amount (Actual)");
                            OstaleOsnoveIsplataKM := Trosak."Cost Amount (Actual)";
                        end
                        else begin
                            OstaleOsnoveIsplataKM := 0;
                        end;
                        Trosak.Reset();
                        Trosak.SetFilter("Posting Date", '%1..%2', IndeksGodinaVecaStartDate, IndeksGodinaVecaEndDate);
                        Trosak.SetFilter(Description, SifreOstaleOsnove);
                        if Trosak.FindSet() then begin
                            Trosak.CalcSums("Cost Amount (Actual)");
                            OstaleOsnoveIsplataKMGodinaVeca := Trosak."Cost Amount (Actual)";
                        end
                        else begin
                            OstaleOsnoveIsplataKMGodinaVeca := 0;
                        end;
                        Trosak.Reset();
                        Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                        if Trosak.FindSet() then begin
                            Trosak.CalcSums("Cost Amount (Actual)");
                            UkupnoKM := Trosak."Cost Amount (Actual)";
                        end
                        else begin
                            UkupnoKM := 0;
                        end;
                        Trosak.Reset();
                        Trosak.SetFilter("Posting Date", '%1..%2', IndeksGodinaVecaStartDate, IndeksGodinaVecaEndDate);
                        if Trosak.FindSet() then begin
                            Trosak.CalcSums("Cost Amount (Actual)");
                            UkupnoKMGodinaVeca := Trosak."Cost Amount (Actual)";
                        end
                        else begin
                            UkupnoKMGodinaVeca := 0;
                        end;
                        if (RadKM <> 0) AND (UkupnoKM <> 0) then begin
                            RadUcesce := (RadKM / UkupnoKM) * 100;
                        end
                        else begin
                            RadUcesce := 0;
                        end;
                        if (OdsustvoSaRadaKM <> 0) AND (UkupnoKM <> 0) then begin
                            OdsustvoSaRadaUcesce := (OdsustvoSaRadaKM / UkupnoKM) * 100;
                        end
                        else begin
                            OdsustvoSaRadaUcesce := 0;
                        end;
                        if (OstaleOsnoveIsplataKM <> 0) AND (UkupnoKM <> 0) then begin
                            OstaleOsnoveIsplataUcesce := (OstaleOsnoveIsplataKM / UkupnoKM) * 100;
                        end
                        else begin
                            OstaleOsnoveIsplataUcesce := 0;
                        end;
                        if (SatiRad <> 0) AND (SatiRadGodinaVeca <> 0) then begin
                            IndeksSatiRad := (SatiRadGodinaVeca / SatiRad) * 100;
                        end
                        else begin
                            IndeksSatiRad := 0;
                        end;
                        if (SatiOdsustvoSaRada <> 0) AND (SatiOdsustvoSaRadaGodinaVeca <> 0) then begin
                            IndeksSatiOdsustvoSaRada := (SatiOdsustvoSaRadaGodinaVeca / SatiOdsustvoSaRada) * 100;
                        end
                        else begin
                            IndeksSatiOdsustvoSaRada := 0;
                        end;
                        if (SatiOstaleOsnove <> 0) AND (SatiOstaleOsnoveGodinaVeca <> 0) then begin
                            IndeksSatiOstaleOsnove := (SatiOstaleOsnoveGodinaVeca / SatiOstaleOsnove) * 100;
                        end
                        else begin
                            IndeksSatiOstaleOsnove := 0;
                        end;
                        if (UkupnoSati <> 0) AND (UkupnoSatiGodinaVeca <> 0) then begin
                            IndeksSatiUkupni := (UkupnoSatiGodinaVeca / UkupnoSati) * 100;
                        end
                        else begin
                            IndeksSatiUkupni := 0;
                        end;
                        if (RadKM <> 0) AND (RadKMGodinaVeca <> 0) then begin
                            IndeksRadKM := (RadKMGodinaVeca / RadKM) * 100;
                        end
                        else begin
                            IndeksRadKM := 0;
                        end;
                        if (OdsustvoSaRadaKM <> 0) AND (OdsustvoSaRadaKMGodinaVeca <> 0) then begin
                            IndeksOdsustvoSaRadaKM := (OdsustvoSaRadaKMGodinaVeca / OdsustvoSaRadaKM) * 100;
                        end
                        else begin
                            IndeksOdsustvoSaRadaKM := 0;
                        end;
                        if (OstaleOsnoveIsplataKM <> 0) AND (OstaleOsnoveIsplataKMGodinaVeca <> 0) then begin
                            IndeksOstaleOsnoveKM := (OstaleOsnoveIsplataKMGodinaVeca / OstaleOsnoveIsplataKM) * 100;
                        end
                        else begin
                            IndeksOstaleOsnoveKM := 0;
                        end;
                        if (UkupnoKM <> 0) AND (UkupnoKMGodinaVeca <> 0) then begin
                            IndeksUkupniKM := (UkupnoKMGodinaVeca / UkupnoKM) * 100;
                        end
                        else begin
                            IndeksUkupniKM := 0;
                        end;
                        UkupnoUcesce := RadUcesce + OdsustvoSaRadaUcesce + OstaleOsnoveIsplataUcesce;
                    end
                    else
                        if (Selected = Selected::IzostanciTroskovi) then begin
                            EmployeeRecord.Reset();
                            EmployeeRecord.SetFilter("No.", '%1', Employee_Absence."Employee No.");
                            if EmployeeRecord.FindFirst() then begin
                                First_Name := EmployeeRecord."First Name";
                                Last_Name := EmployeeRecord."Last Name";
                                EmployeeOrder := EmployeeRecord.Order;
                            end
                            else begin
                                First_Name := '';
                                Last_Name := '';
                                EmployeeOrder := 0;
                            end;
                            EmpConLedg.Reset();
                            if NOT (FromDate = 0D) then begin
                                EmpConLedg.SetFilter("Employee No.", '%1', Employee_Absence."Employee No.");
                                EmpConLedg.SetFilter("Starting Date", '<=%1', ToDate);
                                EmpConLedg.SetFilter("Ending Date", '>=%1 |%2', FromDate, 0D);
                                EmpConLedg.SetCurrentKey("Starting Date");
                                EmpConLedg.Ascending(False);
                                if EmpConLedg.FindFirst() then begin
                                    Department_Name := EmpConLedg."Department Name";
                                end
                                else begin
                                    Department_Name := '';
                                end
                            end
                            else begin
                                EmpConLedg.SetFilter("Employee No.", '%1', Employee_Absence."Employee No.");
                                EmpConLedg.SetFilter("Starting Date", '<%1', Today());
                                EmpConLedg.SetCurrentKey("Starting Date");
                                EmpConLedg.Ascending(False);
                                if EmpConLedg.FindFirst() then begin
                                    Department_Name := EmpConLedg."Department Name";
                                end
                                else
                                    Department_Name := '';
                            end;
                            Trosak.Reset();
                            if NOT (FromDate = 0D) then begin
                                Trosak.SetFilter("Employee No.", '%1', Employee_Absence."Employee No.");
                                Trosak.SetFilter("Wage Calculation Type", '%1', Trosak."Wage Calculation Type"::Regular);
                                Trosak.SetFilter(Description, '%1', Employee_Absence."Cause of Absence Code");
                                Trosak.SetFilter("Posting Date", '%1..%2', FromDate, ToDate);
                                if Trosak.FindFirst() then begin
                                    Trosak.CalcSums("Cost Amount (Actual)");
                                    Troskovi := Trosak."Cost Amount (Actual)";
                                end
                                else begin
                                    Troskovi := 0;
                                end;
                            end
                            else begin
                                Trosak.SetFilter("Employee No.", '%1', Employee_Absence."Employee No.");
                                Trosak.SetFilter("Wage Calculation Type", '%1', Trosak."Wage Calculation Type"::Regular);
                                Trosak.SetFilter(Description, '%1', Employee_Absence."Cause of Absence Code");
                                if Trosak.FindFirst() then begin
                                    Trosak.CalcSums("Cost Amount (Actual)");
                                    Troskovi := Trosak."Cost Amount (Actual)";
                                end
                                else begin
                                    Troskovi := 0;
                                end;
                            end;
                            Trosak.Reset();
                            if NOT (FromDate = 0D) then begin
                                Trosak.SetFilter("Employee No.", '%1', Employee_Absence."Employee No.");
                                Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                Trosak.SetFilter("Wage Calculation Type", '%1', Trosak."Wage Calculation Type"::Regular);
                                Trosak.SetFilter("Posting Date", '%1..%2', FromDate, ToDate);
                                if Trosak.FindFirst() then begin
                                    Trosak.CalcSums("Cost Amount (Actual)");
                                    UkupniTroskoviLjudi := Trosak."Cost Amount (Actual)";
                                end
                                else begin
                                    UkupniTroskoviLjudi := 0;
                                end;
                            end
                            else begin
                                Trosak.SetFilter("Employee No.", '%1', Employee_Absence."Employee No.");
                                Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                Trosak.SetFilter("Wage Calculation Type", '%1', Trosak."Wage Calculation Type"::Regular);
                                if Trosak.FindFirst() then begin
                                    Trosak.CalcSums("Cost Amount (Actual)");
                                    UkupniTroskoviLjudi := Trosak."Cost Amount (Actual)";
                                end
                                else begin
                                    UkupniTroskoviLjudi := 0;
                                end;
                            end;
                            Trosak.Reset();
                            if NOT (FromDate = 0D) then begin
                                Trosak.SetFilter("Department Name", '%1', Department_Name);
                                Trosak.SetFilter("Wage Calculation Type", '%1', Trosak."Wage Calculation Type"::Regular);
                                Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                Trosak.SetFilter("Posting Date", '%1..%2', FromDate, ToDate);
                                if Trosak.FindSet() then begin
                                    EmpConLedg.Reset();
                                    EmpConLedg.SetFilter("Department Name", '%1', Department_Name);
                                    if EmpConLedg.FindFirst() then begin
                                        Trosak.CalcSums("Cost Amount (Actual)");
                                        UkupniTroskoviOrgJed := Trosak."Cost Amount (Actual)";
                                    end;
                                end;
                            end
                            else begin
                                Trosak.SetFilter("Department Name", '%1', Department_Name);
                                Trosak.SetFilter("Wage Calculation Type", '%1', Trosak."Wage Calculation Type"::Regular);
                                Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                if Trosak.FindSet() then begin
                                    EmpConLedg.Reset();
                                    EmpConLedg.SetFilter("Department Name", '%1', Department_Name);
                                    if EmpConLedg.FindFirst() then begin
                                        Trosak.CalcSums("Cost Amount (Actual)");
                                        UkupniTroskoviOrgJed := Trosak."Cost Amount (Actual)";
                                    end;
                                end;
                            end;
                            Trosak.Reset();
                            if NOT (FromDate = 0D) then begin
                                Trosak.SetFilter("Department Name", '%1', Department_Name);
                                Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                Trosak.SetFilter("Wage Calculation Type", '%1', Trosak."Wage Calculation Type"::Regular);
                                Trosak.SetFilter(Description, '%1', Employee_Absence."Cause of Absence Code");
                                Trosak.SetFilter("Posting Date", '%1..%2', FromDate, ToDate);
                                if Trosak.FindSet() then begin
                                    EmpConLedg.Reset();
                                    EmpConLedg.SetFilter("Department Name", '%1', Trosak."Department Name");
                                    if EmpConLedg.FindFirst() then begin
                                        Trosak.CalcSums("Cost Amount (Actual)");
                                        TroskoviOdustvoOrgJed := Trosak."Cost Amount (Actual)";
                                    end;
                                end;
                            end
                            else begin
                                Trosak.SetFilter("Department Name", '%1', Department_Name);
                                Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                Trosak.SetFilter("Wage Calculation Type", '%1', Trosak."Wage Calculation Type"::Regular);
                                Trosak.SetFilter(Description, '%1', Employee_Absence."Cause of Absence Code");
                                if Trosak.FindSet() then begin
                                    EmpConLedg.Reset();
                                    EmpConLedg.SetFilter("Department Name", '%1', Trosak."Department Name");
                                    if EmpConLedg.FindFirst() then begin
                                        Trosak.CalcSums("Cost Amount (Actual)");
                                        TroskoviOdustvoOrgJed := Trosak."Cost Amount (Actual)";
                                    end;
                                end;
                            end;
                            Trosak.Reset();
                            if NOT (FromDate = 0D) then begin
                                Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                Trosak.SetFilter("Wage Calculation Type", '%1', Trosak."Wage Calculation Type"::Regular);
                                Trosak.SetFilter(Description, '%1', Employee_Absence."Cause of Absence Code");
                                Trosak.SetFilter("Posting Date", '%1..%2', FromDate, ToDate);
                                if Trosak.FindFirst() then begin
                                    Trosak.CalcSums("Cost Amount (Actual)");
                                    UkupniTroskoviOdsustvo := Trosak."Cost Amount (Actual)";
                                end
                                else begin
                                    UkupniTroskoviOdsustvo := 0;
                                end;
                            end
                            else begin
                                Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                Trosak.SetFilter("Wage Calculation Type", '%1', Trosak."Wage Calculation Type"::Regular);
                                Trosak.SetFilter(Description, '%1', Employee_Absence."Cause of Absence Code");
                                if Trosak.FindFirst() then begin
                                    Trosak.CalcSums("Cost Amount (Actual)");
                                    UkupniTroskoviOdsustvo := Trosak."Cost Amount (Actual)";
                                end
                                else begin
                                    UkupniTroskoviOdsustvo := 0;
                                end;
                            end;
                            Trosak.Reset();
                            if NOT (FromDate = 0D) then begin
                                Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                Trosak.SetFilter("Wage Calculation Type", '%1', Trosak."Wage Calculation Type"::Regular);
                                Trosak.SetFilter("Posting Date", '%1..%2', FromDate, ToDate);
                                if Trosak.FindFirst() then begin
                                    Trosak.CalcSums("Cost Amount (Actual)");
                                    TotalTroskovi := Trosak."Cost Amount (Actual)";
                                end;
                            end
                            else begin
                                Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                Trosak.SetFilter("Wage Calculation Type", '%1', Trosak."Wage Calculation Type"::Regular);
                                if Trosak.FindFirst() then begin
                                    Trosak.CalcSums("Cost Amount (Actual)");
                                    TotalTroskovi := Trosak."Cost Amount (Actual)";
                                end;
                            end;
                        end
                        else
                            if (Selected = Selected::"PoStrucnojSpremi") then begin

                                Trosak.Reset();
                                Trosak.SetFilter(Description, PrekovremeniRadSifre);
                                Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                if Trosak.FindSet() then begin
                                    Trosak.CalcSums("Cost Amount (Netto)");
                                    TotalPrekoVrRad := Trosak."Cost Amount (Netto)";
                                end
                                else begin
                                    TotalPrekoVrRad := 0;
                                end;
                                Trosak.Reset();
                                Trosak.SetFilter(Description, PripravnostSifre);
                                Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                if Trosak.FindSet() then begin
                                    Trosak.CalcSums("Cost Amount (Netto)");
                                    TotalPripravnostRadniNeradniDani := Trosak."Cost Amount (Netto)";
                                end
                                else begin
                                    TotalPripravnostRadniNeradniDani := 0;
                                end;
                                Trosak.Reset();
                                Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Work Experience");
                                Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                if Trosak.FindSet() then begin
                                    Trosak.CalcSums("Cost Amount (Netto)");
                                    TotalMinuliRad05 := Trosak."Cost Amount (Netto)";
                                end
                                else begin
                                    TotalMinuliRad05 := 0;
                                end;
                                Trosak.Reset();
                                Trosak.SetFilter(Description, 'NOĆ');
                                Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                if Trosak.FindSet() then begin
                                    Trosak.CalcSums("Cost Amount (Netto)");
                                    TotalNocniRad35 := Trosak."Cost Amount (Netto)";
                                end
                                else begin
                                    TotalNocniRad35 := 0;
                                end;
                                Trosak.Reset();
                                Trosak.SetFilter(Description, '%1|%2', 'PRD', 'PRN');
                                Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                if Trosak.FindSet() then begin
                                    Trosak.CalcSums("Cost Amount (Netto)");
                                    TotalRadNaDrzavniPraznik := Trosak."Cost Amount (Netto)";
                                end
                                else begin
                                    TotalRadNaDrzavniPraznik := 0;
                                end;
                                Trosak.Reset();
                                Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::Contribution);
                                Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                if Trosak.FindSet() then begin
                                    Trosak.CalcSums("Cost Amount (Netto)");
                                    TotalRadniUcinak := Trosak."Cost Amount (Netto)";
                                end
                                else begin
                                    TotalRadniUcinak := 0;
                                end;
                                Trosak.Reset();
                                Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Meal to pay");
                                Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                if Trosak.FindSet() then begin
                                    Trosak.CalcSums("Cost Amount (Netto)");
                                    TotalRazlikaTopliObrokPoSporazumu := Trosak."Cost Amount (Netto)";
                                end
                                else begin
                                    TotalRazlikaTopliObrokPoSporazumu := 0;
                                end;
                                Trosak.Reset();
                                Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::Tax);
                                Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                if Trosak.FindSet() then begin
                                    Trosak.CalcSums("Cost Amount (Netto)");
                                    TotalPorezNaDohodak := Trosak."Cost Amount (Netto)";
                                end
                                else begin
                                    TotalPorezNaDohodak := 0;
                                end;
                                Trosak.Reset();
                                Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                if Trosak.FindSet() then begin
                                    Trosak.CalcSums("Cost Amount (Netto)");
                                    TotalNetoBezNaknada := Trosak."Cost Amount (Netto)";
                                end
                                else begin
                                    TotalNetoBezNaknada := 0;
                                end;

                                TotalNetoBezNaknadaMinuliRad := TotalNetoBezNaknada + TotalMinuliRad05;
                                TotalNetoNaknadeBezPoreza := TotalNetoBezNaknada + TotalRazlikaTopliObrokPoSporazumu + TotalMinuliRad05 + TotalRadniUcinak + TotalPrekoVrRad + TotalPripravnostRadniNeradniDani + TotalNocniRad35 + TotalRadNaDrzavniPraznik;

                                if (TotalNetoBezNaknada <> 0) AND (TotalProsjekRadnika12mjeseci <> 0) then begin
                                    TotalProsjekNetoBezNaknadeBezMinuliRad := TotalNetoBezNaknada / TotalProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    TotalProsjekNetoBezNaknadeBezMinuliRad := 0;
                                end;
                                if (TotalNetoBezNaknadaMinuliRad <> 0) AND (TotalProsjekRadnika12mjeseci <> 0) then begin
                                    TotalProsjekNetoBezNaknadeSaMinuliRad := TotalNetoBezNaknadaMinuliRad / TotalProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    TotalProsjekNetoBezNaknadeSaMinuliRad := 0;
                                end;
                                if (TotalPorezNaDohodak <> 0) AND (TotalProsjekRadnika12mjeseci <> 0) then begin
                                    TotalProsjekNetoSveNaknade := TotalPorezNaDohodak / TotalProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    TotalProsjekNetoSveNaknade := 0;
                                end;

                                EmployeeRecord.Reset();
                                if EmployeeRecord.FindSet() then
                                    repeat
                                        Sihtarice.Reset();
                                        Sihtarice.SetFilter("Employee No.", '%1', EmployeeRecord."No.");
                                        Sihtarice.SetRange("From Date", YearStartDate, YearEndDate);
                                        if Sihtarice.FindFirst() then begin

                                            AE.Reset();
                                            AE.SetFilter("Employee No.", '%1', EmployeeRecord."No.");
                                            AE.SetFilter(Active, '%1', true);
                                            if AE.FindSet() then begin
                                                TotalNumberOfEmployees += 1;
                                                if (AE."Education Level" = AE."Education Level"::"II stepen  PKV (polukvalificirani radnik)") or
                                                   (AE."Education Level" = AE."Education Level"::"II EQF nivo  NKR (niskokvalificirani radnik)") then begin
                                                    EmpNoPK := AE."Employee No.";
                                                    PK_NoOfEmployees += 1;
                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoPK);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        PKNetoBezNaknada := Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoPK);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Meal to pay");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        PKRazlikaTopliObrokPoSporazumu := Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoPK);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Work Experience");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        PKMinuliRad05 := Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoPK);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::Contribution);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        PKRadniUčinak += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoPK);
                                                    Trosak.SetFilter(Description, PrekovremeniRadSifre);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        PKPrekoVremeniRad += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter(Description, PripravnostSifre);
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoPK);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        PKPripravnostRadniNeradniDani += Trosak."Cost Amount (Netto)";
                                                    end;
                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoPK);
                                                    Trosak.SetFilter(Description, 'NOĆ');
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        PKNocniRad += Trosak."Cost Amount (Netto)";
                                                    end;
                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoPK);
                                                    Trosak.SetFilter(Description, '%1|%2', 'PRD', 'PRN');
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        PKRadNaDrzavniPraznik += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoPK);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::Tax);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        PKPorezNaDohodak += Trosak."Cost Amount (Netto)";
                                                    end;
                                                end;

                                                if (AE."Education Level" = AE."Education Level"::"I stepen NK(nekvalifikovani radnik)") or
                                                   (AE."Education Level" = AE."Education Level"::"I EQF nivo  NK (nekvalificirani radnik)") then begin
                                                    EmpNoNK := AE."Employee No.";
                                                    NK_NoOfEmployees += 1;
                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoNK);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        NKNetoBezNaknada := Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoNK);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Meal to pay");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        NKRazlikaTopliObrokPoSporazumu := Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoNK);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Work Experience");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        NKMinuliRad05 := Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoNK);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::Contribution);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        NKRadniUčinak += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoNK);
                                                    Trosak.SetFilter(Description, PrekovremeniRadSifre);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        NKPrekoVremeniRad += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter(Description, PripravnostSifre);
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoNK);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        NKPripravnostRadniNeradniDani += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoNK);
                                                    Trosak.SetFilter(Description, 'NOĆ');
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        NKNocniRad += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoNK);
                                                    Trosak.SetFilter(Description, '%1|%2', 'PRD', 'PRN');
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        NKRadNaDrzavniPraznik += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoNK);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::Tax);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        NKPorezNaDohodak += Trosak."Cost Amount (Netto)";
                                                    end;

                                                end;

                                                if (AE."Education Level" = AE."Education Level"::"III stepen  KV (kvalificirani radnik - SSS III stepen)") or
                                                   (AE."Education Level" = AE."Education Level"::"III EQF nivo  KV (kvalificirani radnik - SSS III stepen)") then begin
                                                    EmpNoKV := AE."Employee No.";
                                                    KV_NoOfEmployees += 1;
                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoKV);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        KVNetoBezNaknada += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoKV);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Meal to pay");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        KVRazlikaTopliObrokPoSporazumu += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoKV);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Work Experience");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        KVMinuliRad05 += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoKV);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::Contribution);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        KVRadniUčinak += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoKV);
                                                    Trosak.SetFilter(Description, PrekovremeniRadSifre);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        KVPrekoVremeniRad += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter(Description, PripravnostSifre);
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoKV);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        KVPripravnostRadniNeradniDani += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoKV);
                                                    Trosak.SetFilter(Description, 'NOĆ');
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        KVNocniRad += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoKV);
                                                    Trosak.SetFilter(Description, '%1|%2', 'PRD', 'PRN');
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        KVRadNaDrzavniPraznik += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoKV);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::Tax);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        KVPorezNaDohodak += Trosak."Cost Amount (Netto)";
                                                    end;

                                                end;

                                                if (AE."Education Level" = AE."Education Level"::"IV stepen  SSS (srednja stručna sprema - SSS IV stepen)") or
                                                   (AE."Education Level" = AE."Education Level"::"IV EQF nivo  SKR (opće ili specijalizirani kvalificirani radnik)") then begin
                                                    EmpNoSSS := AE."Employee No.";
                                                    SSS_NoOfEmployees += 1;
                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoSSS);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        SSSNetoBezNaknada += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoSSS);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Meal to pay");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        SSSRazlikaTopliObrokPoSporazumu += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoSSS);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Work Experience");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        SSSMinuliRad05 += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoSSS);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::Contribution);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        SSSRadniUčinak += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoSSS);
                                                    Trosak.SetFilter(Description, PrekovremeniRadSifre);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        SSSPrekoVremeniRad += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter(Description, PripravnostSifre);
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoSSS);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        SSSPripravnostRadniNeradniDani += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoSSS);
                                                    Trosak.SetFilter(Description, 'NOĆ');
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        SSSNocniRad += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoSSS);
                                                    Trosak.SetFilter(Description, '%1|%2', 'PRD', 'PRN');
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        SSSRadNaDrzavniPraznik += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoSSS);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::Tax);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        SSSPorezNaDohodak += Trosak."Cost Amount (Netto)";
                                                    end;

                                                end;

                                                if (AE."Education Level" = AE."Education Level"::"V stepen  VKV (visokokvalificiran radnik)") or
                                                   (AE."Education Level" = AE."Education Level"::"V EQF nivo  VKV (visokokvalificiran radnik specijaliziran za određeno zanimanje)") then begin
                                                    EmpNoVKV := AE."Employee No.";
                                                    VKV_NoOfEmployees += 1;
                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVKV);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VKVNetoBezNaknada += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVKV);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Meal to pay");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VKVRazlikaTopliObrokPoSporazumu += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVKV);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Work Experience");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VKVMinuliRad05 += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVKV);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::Contribution);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VKVRadniUčinak += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVKV);
                                                    Trosak.SetFilter(Description, PrekovremeniRadSifre);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VKVPrekoVremeniRad += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter(Description, PripravnostSifre);
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVKV);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VKVPripravnostRadniNeradniDani += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVKV);
                                                    Trosak.SetFilter(Description, 'NOĆ');
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VKVNocniRad += Trosak."Cost Amount (Netto)";
                                                    end;
                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVKV);
                                                    Trosak.SetFilter(Description, '%1|%2', 'PRD', 'PRN');
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VKVRadNaDrzavniPraznik += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVKV);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::Tax);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VKVPorezNaDohodak += Trosak."Cost Amount (Netto)";
                                                    end;
                                                end;

                                                if (AE."Education Level" = AE."Education Level"::"VI stepen  VŠS (viša stručna sprema)") or
                                                   (AE."Education Level" = AE."Education Level"::"VI EQF nivo  BA (prvi ciklus visokog obrazovanja - 180 ECTS)") or
                                                   (AE."Education Level" = AE."Education Level"::"VI EQF nivo  BA (prvi ciklus visokog obrazovanja - 240 ECTS)") then begin
                                                    EmpNoVSHS := AE."Employee No.";
                                                    VSHS_NoOfEmployees += 1;
                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSHS);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSHSNetoBezNaknada += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSHS);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Meal to pay");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSHSRazlikaTopliObrokPoSporazumu += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSHS);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Work Experience");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSHSMinuliRad05 += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSHS);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::Contribution);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSHSRadniUčinak += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSHS);
                                                    Trosak.SetFilter(Description, PrekovremeniRadSifre);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSHSPrekoVremeniRad += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter(Description, PripravnostSifre);
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSHS);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSHSPripravnostRadniNeradniDani += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSHS);
                                                    Trosak.SetFilter(Description, 'NOĆ');
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSHSNocniRad += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSHS);
                                                    Trosak.SetFilter(Description, '%1|%2', 'PRD', 'PRN');
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSHSRadNaDrzavniPraznik += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSHS);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::Tax);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSHSPorezNaDohodak += Trosak."Cost Amount (Netto)";
                                                    end;
                                                end;

                                                if (AE."Education Level" = AE."Education Level"::"VII./1 stepen  VSS (visoka stručna sprema)") or
                                                   (AE."Education Level" = AE."Education Level"::"VII./1 stepen  MR.spec (magistar specijalist)") or
                                                   (AE."Education Level" = AE."Education Level"::"VII EQF nivo  MA (drugi ciklus visokog obrazovanja - 300 ECTS)") or
                                                   (AE."Education Level" = AE."Education Level"::"VII./2 stepen  MR (magistar nauka)") or
                                                   (AE."Education Level" = AE."Education Level"::"VIII stepen  DR (doktor nauka)") or
                                                   (AE."Education Level" = AE."Education Level"::"VIII EQF nivo  DR.sci (treći ciklus visokog obrazovanja - 480 ECTS)") then begin
                                                    EmpNoVSS := AE."Employee No.";
                                                    VSS_NoOfEmployees += 1;
                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSS);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Net Wage");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSSNetoBezNaknada += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSS);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Meal to pay");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSSRazlikaTopliObrokPoSporazumu += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSS);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::"Work Experience");
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSSMinuliRad05 += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSS);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::Contribution);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSSRadniUčinak += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSS);
                                                    Trosak.SetFilter(Description, PrekovremeniRadSifre);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSSPrekoVremeniRad += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter(Description, PripravnostSifre);
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSS);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSSPripravnostRadniNeradniDani += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSS);
                                                    Trosak.SetFilter(Description, 'NOĆ');
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSSNocniRad += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSS);
                                                    Trosak.SetFilter(Description, '%1|%2', 'PRD', 'PRN');
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSSRadNaDrzavniPraznik += Trosak."Cost Amount (Netto)";
                                                    end;

                                                    Trosak.Reset();
                                                    Trosak.SetFilter("Employee No.", '%1', EmpNoVSS);
                                                    Trosak.SetFilter("Entry Type", '%1', Trosak."Entry Type"::Tax);
                                                    Trosak.SetFilter("Posting Date", '%1..%2', YearStartDate, YearEndDate);
                                                    if Trosak.FindSet() then begin
                                                        Trosak.CalcSums("Cost Amount (Netto)");
                                                        VSSPorezNaDohodak += Trosak."Cost Amount (Netto)";
                                                    end;

                                                end;

                                            end;

                                        end;
                                    until EmployeeRecord.Next() = 0;

                                VSSNetoBezNaknadaMinuli := VSSNetoBezNaknada + VSSMinuliRad05;
                                VSHSNetoBezNaknadaMinuli := VSHSNetoBezNaknada + VSHSMinuliRad05;
                                VKVNetoBezNaknadaMinuli := VKVNetoBezNaknada + VKVMinuliRad05;
                                SSSNetoBezNaknadaMinuli := SSSNetoBezNaknada + SSSMinuliRad05;
                                KVNetoBezNaknadaMinuli := KVNetoBezNaknada + KVMinuliRad05;
                                PKNetoBezNaknadaMinuli := PKNetoBezNaknada + PKMinuliRad05;
                                NKNetoBezNaknadaMinuli := NKNetoBezNaknada + NKMinuliRad05;

                                VSSNetoNaknadeBezPoreza := VSSNetoBezNaknada + VSSRazlikaTopliObrokPoSporazumu + VSSMinuliRad05 + VSSRadniUčinak + VSSPrekoVremeniRad + VSSPripravnostRadniNeradniDani + VSSNocniRad + VSSRadNaDrzavniPraznik;
                                VSHSNetoNaknadeBezPoreza := VSHSNetoBezNaknada + VSHSRazlikaTopliObrokPoSporazumu + VSHSMinuliRad05 + VSHSRadniUčinak + VSHSPrekoVremeniRad + VSHSPripravnostRadniNeradniDani + VSHSNocniRad + VSHSRadNaDrzavniPraznik;
                                VKVNetoNaknadeBezPoreza := VKVNetoBezNaknada + VKVRazlikaTopliObrokPoSporazumu + VKVMinuliRad05 + VKVRadniUčinak + VKVPrekoVremeniRad + VKVPripravnostRadniNeradniDani + VKVNocniRad + VKVRadNaDrzavniPraznik;
                                SSSNetoNaknadeBezPoreza := SSSNetoBezNaknada + SSSRazlikaTopliObrokPoSporazumu + SSSMinuliRad05 + SSSRadniUčinak + SSSPrekoVremeniRad + SSSPripravnostRadniNeradniDani + SSSNocniRad + SSSRadNaDrzavniPraznik;
                                KVNetoNaknadeBezPoreza := KVNetoBezNaknada + KVRazlikaTopliObrokPoSporazumu + KVMinuliRad05 + KVRadniUčinak + KVPrekoVremeniRad + KVPripravnostRadniNeradniDani + KVNocniRad + KVRadNaDrzavniPraznik;
                                PKNetoNaknadeBezPoreza := PKNetoBezNaknada + PKRazlikaTopliObrokPoSporazumu + PKMinuliRad05 + PKRadniUčinak + PKPrekoVremeniRad + PKPripravnostRadniNeradniDani + PKNocniRad + PKRadNaDrzavniPraznik;
                                NKNetoNaknadeBezPoreza := NKNetoBezNaknada + NKRazlikaTopliObrokPoSporazumu + NKMinuliRad05 + NKRadniUčinak + NKPrekoVremeniRad + NKPripravnostRadniNeradniDani + NKNocniRad + NKRadNaDrzavniPraznik;

                                if (VSSNetoBezNaknada <> 0) AND (VSSProsjekRadnika12mjeseci <> 0) then begin
                                    VSSProsjekBezNaknadaBezMinuli := VSSNetoBezNaknada / VSSProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    VSSProsjekBezNaknadaBezMinuli := 0;
                                end;

                                if (VSHSNetoBezNaknada <> 0) AND (VSHSProsjekRadnika12mjeseci <> 0) then begin
                                    VSHSProsjekBezNaknadaBezMinuli := VSHSNetoBezNaknada / VSHSProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    VSHSProsjekBezNaknadaBezMinuli := 0;
                                end;

                                if (VKVNetoBezNaknada <> 0) AND (VKVProsjekRadnika12mjeseci <> 0) then begin
                                    VKVProsjekBezNaknadaBezMinuli := VKVNetoBezNaknada / VKVProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    VKVProsjekBezNaknadaBezMinuli := 0;
                                end;

                                if (SSSNetoBezNaknada <> 0) AND (SSSProsjekRadnika12mjeseci <> 0) then begin
                                    SSSProsjekBezNaknadaBezMinuli := SSSNetoBezNaknada / SSSProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    SSSProsjekBezNaknadaBezMinuli := 0;
                                end;

                                if (KVNetoBezNaknada <> 0) AND (KVProsjekRadnika12mjeseci <> 0) then begin
                                    KVProsjekBezNaknadaBezMinuli := KVNetoBezNaknada / KVProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    KVProsjekBezNaknadaBezMinuli := 0;
                                end;

                                if (PKNetoBezNaknada <> 0) AND (PKProsjekRadnika12mjeseci <> 0) then begin
                                    PKProsjekBezNaknadaBezMinuli := PKNetoBezNaknada / PKProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    PKProsjekBezNaknadaBezMinuli := 0;
                                end;

                                if (NKNetoBezNaknada <> 0) AND (NKProsjekRadnika12mjeseci <> 0) then begin
                                    NKProsjekBezNaknadaBezMinuli := NKNetoBezNaknada / NKProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    NKProsjekBezNaknadaBezMinuli := 0;
                                end;

                                if (VSSNetoBezNaknadaMinuli <> 0) AND (VSSProsjekRadnika12mjeseci <> 0) then begin
                                    VSSProsjekBezNaknadaMinuli := VSSNetoBezNaknadaMinuli / VSSProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    VSSProsjekBezNaknadaMinuli := 0;
                                end;

                                if (VSHSNetoBezNaknadaMinuli <> 0) AND (VSHSProsjekRadnika12mjeseci <> 0) then begin
                                    VSHSProsjekBezNaknadaMinuli := VSHSNetoBezNaknadaMinuli / VSHSProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    VSHSProsjekBezNaknadaMinuli := 0;
                                end;

                                if (VKVNetoBezNaknadaMinuli <> 0) AND (VKVProsjekRadnika12mjeseci <> 0) then begin
                                    VKVProsjekBezNaknadaMinuli := VKVNetoBezNaknadaMinuli / VKVProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    VKVProsjekBezNaknadaMinuli := 0;
                                end;

                                if (SSSNetoBezNaknadaMinuli <> 0) AND (SSSProsjekRadnika12mjeseci <> 0) then begin
                                    SSSProsjekBezNaknadaMinuli := SSSNetoBezNaknadaMinuli / SSSProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    SSSProsjekBezNaknadaMinuli := 0;
                                end;

                                if (KVNetoBezNaknadaMinuli <> 0) AND (VSSProsjekRadnika12mjeseci <> 0) then begin
                                    KVProsjekBezNaknadaMinuli := VSSNetoBezNaknadaMinuli / VSSProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    KVProsjekBezNaknadaMinuli := 0;
                                end;


                                if (VSSPorezNaDohodak <> 0) AND (VSSProsjekRadnika12mjeseci <> 0) then begin
                                    VSSProsjekNetoSveNaknade := VSSPorezNaDohodak / VSSProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    VSSProsjekNetoSveNaknade := 0;
                                end;

                                if (VSHSPorezNaDohodak <> 0) AND (VSHSProsjekRadnika12mjeseci <> 0) then begin
                                    VSHSProsjekNetoSveNaknade := VSHSPorezNaDohodak / VSHSProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    VSHSProsjekNetoSveNaknade := 0;
                                end;

                                if (VKVPorezNaDohodak <> 0) AND (VKVProsjekRadnika12mjeseci <> 0) then begin
                                    VKVProsjekNetoSveNaknade := VKVPorezNaDohodak / VKVProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    VKVProsjekNetoSveNaknade := 0;
                                end;

                                if (SSSPorezNaDohodak <> 0) AND (SSSProsjekRadnika12mjeseci <> 0) then begin
                                    SSSProsjekNetoSveNaknade := SSSPorezNaDohodak / SSSProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    SSSProsjekNetoSveNaknade := 0;
                                end;

                                if (KVPorezNaDohodak <> 0) AND (KVProsjekRadnika12mjeseci <> 0) then begin
                                    KVProsjekNetoSveNaknade := KVPorezNaDohodak / KVProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    KVProsjekNetoSveNaknade := 0;
                                end;

                                if (PKPorezNaDohodak <> 0) AND (PKProsjekRadnika12mjeseci <> 0) then begin
                                    PKProsjekNetoSveNaknade := PKPorezNaDohodak / PKProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    PKProsjekNetoSveNaknade := 0;
                                end;

                                if (NKPorezNaDohodak <> 0) AND (NKProsjekRadnika12mjeseci <> 0) then begin
                                    NKProsjekNetoSveNaknade := NKPorezNaDohodak / NKProsjekRadnika12mjeseci / 12;
                                end
                                else begin
                                    NKProsjekNetoSveNaknade := 0;
                                end;

                            end
                end;
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                First_Column_No := 0;
                Second_Column_No := 1;
                Third_Column_No := 2;
                myInt := EndYear - StartYear + 1;
                IndeksKolone := myInt - 1;
                SetFilter(Number, '%1..%2', 1, myInt);
                CurrentYear := StartYear;
                PreviousYear := 0;
                PreviousYear2 := StartYear;
                PreviousIndeks := 0;
                IndeksFirstCount := 10;
                IndeksSecondCount := 11;
                Column1 := 1;
                Column2 := 2;
                Column3 := 3;
                Column4 := 4;
                Column5 := 5;
                Column6 := 6;
                Column7 := 7;
                Column8 := 8;
                Column9 := 9;
                Column10 := 10;
                Column11 := 11;
                Column12 := 12;
                Column13 := 13;
                Column14 := 14;
                Column15 := 15;
                Column16 := 16;
                Column17 := 17;
            end;

            trigger OnAfterGetRecord()
            begin
                Godine := CurrentYear;
                IndeksGodinaVeca := CurrentYear + 1;
                YearStartDate := DMY2DATE(1, 1, Godine);
                YearEndDate := DMY2DATE(31, 12, Godine);
                IndeksGodinaVecaStartDate := DMY2DATE(1, 1, IndeksGodinaVeca);
                IndeksGodinaVecaEndDate := DMY2DATE(31, 12, IndeksGodinaVeca);
                if Godine = StartYear then begin
                    YearStartDate := DMY2DATE(StartDay, StartMonth, Godine);
                    IndeksGodinaVecaStartDate := DMY2DATE(StartDay, StartMonth, IndeksGodinaVeca);
                end;
                if Godine = EndYear then begin
                    YearEndDate := DMY2DATE(EndDay, EndMonth, Godine);
                    IndeksGodinaVecaEndDate := DMY2DATE(EndDay, EndMonth, IndeksGodinaVeca);
                end;
                if CurrentYear < EndYear then begin
                    CurrentYear += 1;
                    IndeksKolone += 1;
                end;
                if Godine <> PreviousYear2 then begin
                    Column2 += 16;
                    Column3 += 16;
                    Column4 += 16;
                    Column5 += 16;
                    Column6 += 16;
                    Column7 += 16;
                    Column8 += 16;
                    Column9 += 16;
                    Column10 += 16;
                    Column11 += 16;
                    Column12 += 16;
                    Column13 += 16;
                    Column14 += 16;
                    Column15 += 16;
                    Column16 += 16;
                    Column17 += 16;
                end;
                PreviousYear2 := Godine;
                if Godine <> PreviousYear then begin
                    First_Column_No += 3;
                    Second_Column_No += 3;
                    Third_Column_No += 3;
                end;
                PreviousYear := Godine;
                if IndeksKolone <> PreviousIndeks then begin
                    IndeksFirstCount += 2;
                    IndeksSecondCount += 2;
                end;
                PreviousIndeks := IndeksKolone;
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
                        OptionCaption = ', Rekapitulacija ostvarenih sati i primanja,Izostanci i Troškovi,Rekapitulacija po stručnoj spremi';
                    }
                }
                group("Odaberi datume")
                {
                    field("FromDate"; FromDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Od datuma';
                        ToolTip = 'Enter the start date.';
                        NotBlank = true;
                        trigger OnValidate()
                        begin
                            if (ToDate <> 0D) AND (FromDate <> 0D) then begin
                                if FromDate > ToDate then
                                    Error('Datum početka ne može biti veći od datuma završetka');
                            end;
                        end;
                    }
                    field("ToDate"; ToDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Do datuma';
                        ToolTip = 'Enter the end date. (not mandatory)';
                        trigger OnValidate()
                        begin
                            if (ToDate <> 0D) AND (FromDate <> 0D) then begin
                                if ToDate < FromDate then
                                    Error('Datum završetka ne može biti manji od datuma početka');
                            end;
                            StartYear := Date2DMY(FromDate, 3);
                            EndYear := Date2DMY(ToDate, 3);
                        end;
                    }
                }
            }
        }
        trigger OnInit()
        var
            ThisYear: Integer;
        begin
            ThisYear := Date2DMY(Today, 3);
            FromDate := DMY2DATE(1, 1, ThisYear - 2);
            ToDate := DMY2DATE(31, 12, ThisYear);
        end;
    }
    trigger OnPreReport()
    begin
        if FromDate = 0D then begin
            Error('Od datuma je obavezno');
        end else begin
            StartDay := Date2DMY(FromDate, 1);
            StartMonth := Date2DMY(FromDate, 2);
            StartYear := Date2DMY(FromDate, 3);
        end;
        if ToDate = 0D then begin
            EndDay := StartDay;
            EndMonth := StartMonth;
            EndYear := StartYear
        end else begin
            EndDay := Date2DMY(ToDate, 1);
            EndMonth := Date2DMY(ToDate, 2);
            EndYear := Date2DMY(ToDate, 3);
        end;
        if (Selected = Selected::" ") then begin
            Error('Izbor izještaja je obavezan')
        end;
    end;

    procedure GetCOACodesOdsustvoSaRada() ResultCOACodes: Text
    var
        COA: Record "Cause of Absence";
    begin
        ResultCOACodes := '';
        COA.Reset();
        COA.SetFilter("Meal Calculated", '%1', false);
        COA.SetFilter("Payment Type", '%1', COA."Payment Type"::"Regular Work");
        if COA.FindSet() then
            repeat
                ResultCOACodes += COA.Code + '|';
            until COA.Next() = 0;
        if StrLen(ResultCOACodes) > 0 then
            ResultCOACodes := DelStr(ResultCOACodes, StrLen(ResultCOACodes), 1);
    end;

    procedure GetCOACodesOstaleOsnoveIsplata() ResultCOACodes: Text
    var
        COA: Record "Cause of Absence";
    begin
        ResultCOACodes := '';
        COA.Reset();
        COA.SetFilter("Payment Type", '<>%1', COA."Payment Type"::"Regular Work");
        if COA.FindSet() then
            repeat
                ResultCOACodes += COA.Code + '|';
            until COA.Next() = 0;
        if StrLen(ResultCOACodes) > 0 then
            ResultCOACodes := DelStr(ResultCOACodes, StrLen(ResultCOACodes), 1);
    end;

    procedure GetCOACodesPrekovremeniRad() ResultCOACodes: Text
    var
        COA: Record "Cause of Absence";
    begin
        ResultCOACodes := '';
        COA.Reset();
        COA.SetFilter("Added To Hour Pool", '%1', true);
        COA.SetFilter("Payment Type", '%1', COA."Payment Type"::"Additional>");
        if COA.FindSet() then
            repeat
                ResultCOACodes += COA.Code + '|';
            until COA.Next() = 0;
        if StrLen(ResultCOACodes) > 0 then
            ResultCOACodes := DelStr(ResultCOACodes, StrLen(ResultCOACodes), 1);
    end;

    procedure GetCOACodesPripravnost() ResultCOACodes: Text
    var
        COA: Record "Cause of Absence";
    begin
        ResultCOACodes := '';
        COA.Reset();
        COA.SetFilter("Added To Hour Pool", '%1', true);
        COA.SetFilter("Payment Type", '%1', COA."Payment Type"::"Regular Work");
        if COA.FindSet() then
            repeat
                ResultCOACodes += COA.Code + '|';
            until COA.Next() = 0;
        if StrLen(ResultCOACodes) > 0 then
            ResultCOACodes := DelStr(ResultCOACodes, StrLen(ResultCOACodes), 1);
    end;

    procedure GetCOACodesMinuliRad05() ResultCOACodesMinuliRad: Text
    var
        COA: Record "Cause of Absence";
    begin
        ResultCOACodesMinuliRad := '';
        COA.Reset();
        COA.SetFilter("Calculate Experience", '%1', true);
        if COA.FindSet() then
            repeat
                ResultCOACodesMinuliRad += COA.Code + '|';
            until COA.Next() = 0;
        if StrLen(ResultCOACodesMinuliRad) > 0 then
            ResultCOACodesMinuliRad := DelStr(ResultCOACodesMinuliRad, StrLen(ResultCOACodesMinuliRad), 1);
    end;

    procedure GetCOACodesRadniUcinak() ResultCOACodesRadniUcinak: Text
    var
        COA: Record "Cause of Absence";
    begin
        ResultCOACodesRadniUcinak := '';
        COA.Reset();
        COA.SetFilter("Payment Type", '%1', COA."Payment Type"::"Work Performance");
        if COA.FindSet() then
            repeat
                ResultCOACodesRadniUcinak += COA.Code + '|';
            until COA.Next() = 0;
        if StrLen(ResultCOACodesRadniUcinak) > 0 then
            ResultCOACodesRadniUcinak := DelStr(ResultCOACodesRadniUcinak, StrLen(ResultCOACodesRadniUcinak), 1);
    end;

    var
        EmpNoSSSPrevious: Code[20];
        PKProsjekNetoSveNaknade: Decimal;
        NKProsjekNetoSveNaknade: Decimal;
        KVProsjekNetoSveNaknade: Decimal;
        SSSProsjekNetoSveNaknade: Decimal;
        VKVProsjekNetoSveNaknade: Decimal;
        VSHSProsjekNetoSveNaknade: Decimal;
        VSSProsjekNetoSveNaknade: Decimal;
        PKProsjekBezNaknadaMinuli: Decimal;
        NKProsjekBezNaknadaMinuli: Decimal;
        KVProsjekBezNaknadaMinuli: Decimal;
        SSSProsjekBezNaknadaMinuli: Decimal;
        VKVProsjekBezNaknadaMinuli: Decimal;
        VSHSProsjekBezNaknadaMinuli: Decimal;
        VSSProsjekBezNaknadaMinuli: Decimal;
        PKProsjekBezNaknadaBezMinuli: Decimal;
        NKProsjekBezNaknadaBezMinuli: Decimal;
        KVProsjekBezNaknadaBezMinuli: Decimal;
        SSSProsjekBezNaknadaBezMinuli: Decimal;
        VKVProsjekBezNaknadaBezMinuli: Decimal;
        VSHSProsjekBezNaknadaBezMinuli: Decimal;
        VSSProsjekBezNaknadaBezMinuli: Decimal;
        PKProsjekRadnika12Mjeseci: Decimal;
        NKProsjekRadnika12Mjeseci: Decimal;
        KVProsjekRadnika12Mjeseci: Decimal;
        SSSProsjekRadnika12Mjeseci: Decimal;
        VKVProsjekRadnika12Mjeseci: Decimal;
        VSHSProsjekRadnika12Mjeseci: Decimal;
        VSSProsjekRadnika12Mjeseci: Decimal;
        PKNetoNaknadeBezPoreza: Decimal;
        NKNetoNaknadeBezPoreza: Decimal;
        KVNetoNaknadeBezPoreza: Decimal;
        SSSNetoNaknadeBezPoreza: Decimal;
        VKVNetoNaknadeBezPoreza: Decimal;
        VSHSNetoNaknadeBezPoreza: Decimal;
        VSSNetoNaknadeBezPoreza: Decimal;
        PKPorezNaDohodak: Decimal;
        NKPorezNaDohodak: Decimal;
        KVPorezNaDohodak: Decimal;
        SSSPorezNaDohodak: Decimal;
        VKVPorezNaDohodak: Decimal;
        VSHSPorezNaDohodak: Decimal;
        VSSPorezNaDohodak: Decimal;
        PKNetoBezNaknadaMinuli: Decimal;
        NKNetoBezNaknadaMinuli: Decimal;
        KVNetoBezNaknadaMinuli: Decimal;
        SSSNetoBezNaknadaMinuli: Decimal;
        VKVNetoBezNaknadaMinuli: Decimal;
        VSHSNetoBezNaknadaMinuli: Decimal;
        VSSNetoBezNaknadaMinuli: Decimal;
        PKRadNaDrzavniPraznik: Decimal;
        NKRadNaDrzavniPraznik: Decimal;
        KVRadNaDrzavniPraznik: Decimal;
        SSSRadNaDrzavniPraznik: Decimal;
        VKVRadNaDrzavniPraznik: Decimal;
        VSHSRadNaDrzavniPraznik: Decimal;
        VSSRadNaDrzavniPraznik: Decimal;
        PKNocniRad: Decimal;
        NKNocniRad: Decimal;
        KVNocniRad: Decimal;
        SSSNocniRad: Decimal;
        VKVNocniRad: Decimal;
        VSHSNocniRad: Decimal;
        VSSNocniRad: Decimal;
        PKPripravnostRadniNeradniDani: Decimal;
        NKPripravnostRadniNeradniDani: Decimal;
        KVPripravnostRadniNeradniDani: Decimal;
        SSSPripravnostRadniNeradniDani: Decimal;
        VKVPripravnostRadniNeradniDani: Decimal;
        VSHSPripravnostRadniNeradniDani: Decimal;
        VSSPripravnostRadniNeradniDani: Decimal;
        PKPrekoVremeniRad: Decimal;
        NKPrekoVremeniRad: Decimal;
        KVPrekoVremeniRad: Decimal;
        SSSPrekoVremeniRad: Decimal;
        VKVPrekoVremeniRad: Decimal;
        VSHSPrekoVremeniRad: Decimal;
        VSSPrekoVremeniRad: Decimal;
        PKRadniUčinak: Decimal;
        NKRadniUčinak: Decimal;
        KVRadniUčinak: Decimal;
        SSSRadniUčinak: Decimal;
        VKVRadniUčinak: Decimal;
        VSHSRadniUčinak: Decimal;
        VSSRadniUčinak: Decimal;
        PKMinuliRad05: Decimal;
        NKMinuliRad05: Decimal;
        KVMinuliRad05: Decimal;
        SSSMinuliRad05: Decimal;
        VKVMinuliRad05: Decimal;
        VSHSMinuliRad05: Decimal;
        VSSMinuliRad05: Decimal;
        PKRazlikaTopliObrokPoSporazumu: Decimal;
        NKRazlikaTopliObrokPoSporazumu: Decimal;
        KVRazlikaTopliObrokPoSporazumu: Decimal;
        SSSRazlikaTopliObrokPoSporazumu: Decimal;
        VKVRazlikaTopliObrokPoSporazumu: Decimal;
        VSHSRazlikaTopliObrokPoSporazumu: Decimal;
        VSSRazlikaTopliObrokPoSporazumu: Decimal;
        PKNetoBezNaknada: Decimal;
        NKNetoBezNaknada: Decimal;
        KVNetoBezNaknada: Decimal;
        SSSNetoBezNaknada: Decimal;
        VKVNetoBezNaknada: Decimal;
        VSHSNetoBezNaknada: Decimal;
        VSSNetoBezNaknada: Decimal;
        EmpNoKV: Code[20];
        EmpNoVKV: Code[20];
        EmpNoSSS: Code[20];
        EmpNoVSHS: Code[20];
        EmpNoVSS: Code[20];
        EmpNoPK: Code[20];
        EmpNoNK: Code[20];
        TotalNumberOfEmployees: Integer;
        VSS_NoOfEmployees: Integer;
        VSHS_NoOfEmployees: Integer;
        VKV_NoOfEmployees: Integer;
        SSS_NoOfEmployees: Integer;
        KV_NoOfEmployees: Integer;
        PK_NoOfEmployees: Integer;
        NK_NoOfEmployees: Integer;
        AE: Record "Additional Education";
        PreviousYear2: Integer;
        EmployeeNo: Code[20];
        EmployeeNoPoGodini: Text;
        Column1: Integer;
        Column2: Integer;
        Column3: Integer;
        Column4: Integer;
        Column5: Integer;
        Column6: Integer;
        Column7: Integer;
        Column8: Integer;
        Column9: Integer;
        Column10: Integer;
        Column11: Integer;
        Column12: Integer;
        Column13: Integer;
        Column14: Integer;
        Column15: Integer;
        Column16: Integer;
        Column17: Integer;
        EmployeeNoPrevious: Code[20];
        RadniUcinakSifre: Text;
        PripravnostSifre: Text;
        MinuliRadSifre05: Text;
        PrekovremeniRadSifre: Text;
        TotalProsjekNetoSveNaknade: Decimal;
        TotalProsjekNetoBezNaknadeSaMinuliRad: Decimal;
        TotalProsjekNetoBezNaknadeBezMinuliRad: Decimal;
        TotalProsjekRadnika12mjeseci: Decimal;
        TotalNetoNaknadeBezPoreza: Decimal;
        TotalPorezNaDohodak: Decimal;
        TotalNetoBezNaknadaMinuliRad: Decimal;
        TotalRadNaDrzavniPraznik: Decimal;
        TotalNocniRad35: Decimal;
        TotalPripravnostRadniNeradniDani: Decimal;
        TotalPrekoVrRad: Decimal;
        TotalRadniUcinak: Decimal;
        TotalMinuliRad05: Decimal;
        TotalRazlikaTopliObrokPoSporazumu: Decimal;
        TotalNetoBezNaknada: Decimal;
        EmployeeRecord: Record Employee;
        EmpConLedg: Record "Employee Contract Ledger";
        Trosak: Record "Wage Value Entry";
        Sihtarice: Record "Employee Absence";
        CauseOfAbsence: Record "Cause of Absence";
        First_Name: Text[100];
        Last_Name: Text[100];
        Department_Name: Text;
        Datumi: Text[250];
        Troskovi: Decimal;
        UkupniTroskoviLjudi: Decimal;
        UkupniTroskoviOrgJed: Decimal;
        UkupniTroskoviOdsustvo: Decimal;
        TroskoviOdustvoOrgJed: Decimal;
        TotalTroskovi: Decimal;
        EmployeeOrder: Integer;
        FromDate: Date;
        ToDate: Date;
        StartYear: Integer;
        EndYear: Integer;
        StartDay: Integer;
        StartMonth: Integer;
        EndDay: Integer;
        EndMonth: Integer;
        Godine: Integer;
        CurrentYear: Integer;
        YearStartDate: Date;
        YearEndDate: Date;
        First_Column_No: Integer;
        Second_Column_No: Integer;
        Third_Column_No: Integer;
        PreviousYear: Integer;
        SatiRad: Decimal;
        SatiOdsustvoSaRada: Decimal;
        SatiOstaleOsnove: Decimal;
        UkupnoSati: Decimal;
        RadKM: Decimal;
        OdsustvoSaRadaKM: Decimal;
        OstaleOsnoveIsplataKM: Decimal;
        UkupnoKM: Decimal;
        RadUcesce: Decimal;
        OdsustvoSaRadaUcesce: Decimal;
        OstaleOsnoveIsplataUcesce: Decimal;
        UkupnoUcesce: Decimal;
        VrstaIzvjestaja: Text;
        Selected: Option " ","OstvareniSati","IzostanciTroskovi","PoStrucnojSpremi";
        SifreOdsustva: Text[256];
        SifreOstaleOsnove: Text[256];
        IndeksKolone: Integer;
        IndeksFirstCount: Integer;
        IndeksSecondCount: Integer;
        PreviousIndeks: Integer;
        IndeksSatiRad: Decimal;
        IndeksSatiOdsustvoSaRada: Decimal;
        IndeksSatiOstaleOsnove: Decimal;
        IndeksSatiUkupni: Decimal;
        IndeksRadKM: Decimal;
        IndeksOdsustvoSaRadaKM: Decimal;
        IndeksOstaleOsnoveKM: Decimal;
        IndeksUkupniKM: Decimal;
        IndeksGodinaVeca: Integer;
        IndeksGodinaVecaStartDate: Date;
        IndeksGodinaVecaEndDate: Date;
        SatiRadGodinaVeca: Decimal;
        SatiOdsustvoSaRadaGodinaVeca: Decimal;
        SatiOstaleOsnoveGodinaVeca: Decimal;
        UkupnoSatiGodinaVeca: Decimal;
        RadKMGodinaVeca: Decimal;
        OdsustvoSaRadaKMGodinaVeca: Decimal;
        OstaleOsnoveIsplataKMGodinaVeca: Decimal;
        UkupnoKMGodinaVeca: Decimal;
}