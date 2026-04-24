report 50186 "Service Order General"
{

    DefaultLayout = RDLC;
    PreviewMode = Normal;
    WordMergeDataItem = "Service Item Line";
    RDLCLayout = './Service Order General.rdl';

    dataset
    {
        dataitem("Service Item Line"; "Service Item Line")
        {
            RequestFilterFields = "Document Date";
            DataItemTableView = sorting("Stroke", "String", "Address", "Street No.");

            column(No_; "Document No.")
            {

            }
            column(No_GEO; ServiceHeaderAdd."No.") { }
            column(CZkPhoneNumber; CZkPhoneNumber) { }

            column(GEO_WorkPlacesOffice; ServiceHeaderAdd."GEO WorkPlaces") { }
            column(Name; ServiceHeaderAdd."Name") { }
            column(CZKRN; CZKRN) { }
            column(BrojKubika; BrojKubika) { }
            column(DateBrojKubika; format(DateBrojKubika, 0, '<day,2>.<month,2>.<year4>')) { }
            column(SigPosText; SigPosText) { }
            column(SigName; SigName) { }
            column(transaction6Name; transaction6Name)
            {

            }
            column(RokPlacanja; RokPlacanja) { }
            column(transaction6; transaction6)
            {

            }
            column(transaction7Name; transaction7Name)
            {

            }

            column(transaction7; transaction7)
            {

            }


            column(transaction8; transaction8)
            {

            }
            column(transaction8Name; transaction8name)
            {

            }
            column(transaction9Name; transaction9name)
            {

            }

            column(transaction9; transaction9)
            {

            }

            column(transaction10; transaction10)
            {

            }
            column(transaction10Name; transaction10name)
            {

            }
            column(transaction4; transaction4)
            {

            }

            column(transaction4Name; transaction4Name)
            {

            }

            column(transaction1Name; transaction1Name)
            {

            }

            column(transaction2Name; transaction2Name)
            {

            }

            column(transaction3Name; transaction3Name)
            {

            }
            column(transaction5Name; transaction5Name)
            {

            }
            column(transaction5; transaction5)
            {

            }

            column(transaction2; transaction2)
            {

            }
            column(transaction1; transaction1)
            {

            }
            column(Comp_PostCode; CompInfo."Post Code") { }
            column(Comp_City; CompInfo.City) { }
            column(Comp_Address; CompInfo.Address) { }



            column(transaction3; transaction3)
            {

            }


            column(registrationNumber; registrationNumber) { }
            column(vatNumber; vatNumber) { }
            column(registrationVATNumber; registrationVATNumber) { }
            column(court; court) { }
            column(activityCode; activityCode) { }
            column(transBBI; transBBI) { }
            column(transIntesa; transIntesa) { }
            column(transRaif; transRaif) { }
            column(transUni; transUni) { }
            column(transactionPrivredna; transactionPrivredna) { }
            column(transUnion; transUnion) { }
            column(courtNumber; courtNumber) { }

            column(PhoneNo; CompInfo."Phone No.")

            {

            }
            column(PhoneNo2; CompInfo."Phone No. 2")
            {

            }
            column(FaxNo; CompInfo."Fax No.")
            {

            }

            column(Picture; CompInfo.Picture)
            {
            }
            column(CompInfo_Disp; CompInfo."Dispatch Center") { }
            column(BillingSIgnatory; CompInfo."Billing Signatory") { }
            column(CEO_Phone; CEO_Phone) { }
            column(KOntaktiAdd; KOntaktiAdd) { }
            column(PhoneAdd; PhoneAdd) { }
            column(EmailAdd; EmailAdd) { }

            column(KOntaktiOrg; KOntaktiOrg) { }
            column(PhoneOrg; PhoneOrg) { }
            column(EmailOrg; EmailOrg) { }
            column(EmailEracunKOntaktiOrg; EmailEracunKOntaktiOrg) { }
            column(EvidentialCode; EvidentialCode) { }
            column(CZKControl; CZKControl) { }
            column(CZKDate; format(CZKDate, 0, '<day,2>.<month,2>.<year4>')) { }
            column(CZKReal; CZKReal) { }
            column(CZKVerif; CZKVerif) { }
            column(Contract_No_; ServiceHeaderAdd."Contract No.") { }
            column(NoteText; TextIspisTrenutno) { }
            column(NoteTextPrevious; TextIspisPrethodni) { }
            column(TextIspisPrethodni2Napomene; TextIspisPrethodni2Napomene) { }
            column(ZaduzenoV; ZaduzenoV) { }
            column(RazduzenoV; RazduzenoV) { }
            column(NoteNapomena; TekstNapomena) { }
            column(NoteKomenar; TekstKomentar) { }
            column(Responsible_Department_Name; ServiceHeaderAdd."Responsible Department Name") { }
            column(CZK_Request_No_; ServiceHeaderAdd."CZK Request No.") { }
            column(Implementation_Time; FORMAT(ServiceHeaderAdd."Implementation Time", 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>')) { }
            column(ContractStart; format(CustLed."Starting Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(ContractDescription; format(CustLed.Description)) { }
            column(GaugeSizeS; AddressMM."Gauge Size") { }
            column(AddressMMSerial; AddressMM."RMS") { }
            column(AddressMMStroke; AddressMM.Stroke) { }
            column(AddressMMString; AddressMM.String) { }
            column(TRImpulse; TRImpulse) { }

            column(AnticorrosiveProtectionDA; AnticorrosiveProtectionDA) { }
            column(AnticorrosiveProtectionNE; AnticorrosiveProtectionNE) { }

            column(FireProtectionDA; FireProtectionDA) { }
            column(FireProtectionNE; FireProtectionNE) { }
            column(FireProtectionNeTreba; FireProtectionNeTreba) { }
            column(OutdoorVentilationDA; OutdoorVentilationDA) { }
            column(OutdoorVentilationNE; OutdoorVentilationNE) { }
            column(OutdoorVentilationNedovoljno; OutdoorVentilationNedovoljno) { }
            column(OutdoorVentilationNijePotrebno; OutdoorVentilationNijePotrebno) { }
            column(GEO_WorkPlaces; ServiceHeaderAdd."GEO WorkPlaces") { }
            column(Saldo; Cust."Balance (LCY)") { }
            column(Stroke_No__2; ServiceHeaderAdd."Stroke No. 2") { }
            column(Stroke_No_; ServiceHeaderAdd."Stroke No.") { }
            column(Customer_String; ServiceHeaderAdd."Customer String") { }
            column(Customer_String_2; ServiceHeaderAdd."Customer String 2") { }
            column(Customer_Category; Customer_Category) { }
            column(Address; ServiceHeaderAdd.Address) { }
            column(AddressStreet; ServiceHeaderAdd."Street No.") { }
            column(Address_2; ServiceHeaderAdd."Address 2") { }
            column(Owner_Address; ServiceHeaderAdd."Owner Address") { }
            column(ServiceHeaderZone; ServiceHeaderAdd."Zone Stroke No.") { }
            column(AddressMMZone; AddressMM."Zone Stroke") { }
            column(DateOfConsumption; format(AddressMM."Date of consumption", 0, '<day,2>.<month,2>.<year4>')) { }
            column(DDCalibration; AddressMM."DD calibration") { }
            column(YearProd; AddressMM."Year of Production") { }
            column(AddressMMRMS; AddressMM.RMS) { }

            column(ReadingValue; ReadingValueText1) { }


            column(DateOfRealisation; format(ServiceHeaderAdd."Done Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(Reading; Reading) { }
            column(RealisationDone; FormatBooleanAsCheckbox(ServiceHeaderAdd."Realisation Done"))
            {
                IncludeCaption = false;
            }
            column(DateOfRealisationP; format(ServiceHeaderAdd."Prep Done Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(RealisationDoneP; FormatBooleanAsCheckbox(ServiceHeaderAdd."Prep Realisation Done"))
            {
                IncludeCaption = false;
            }
            column(RealisationDoneNot; FormatBooleanAsCheckbox(not ServiceHeaderAdd."Realisation Done"))
            {
                IncludeCaption = false;
            }
            column(RealisationDoneNotP; FormatBooleanAsCheckbox(not ServiceHeaderAdd."Prep Realisation Done"))
            {
                IncludeCaption = false;
            }
            column(YNRD; ReturnYesOrNo(ServiceHeaderAdd."Realisation Done")) { }
            column(YNRDP; ReturnYesOrNo(ServiceHeaderAdd."Prep Realisation Done")) { }

            column(ServiceHeaderApartment; ServiceHeaderAdd."Apartment No. 2") { }
            column(ServiceHeaderFloor; ServiceHeaderAdd."Floor 2") { }
            column(ServiceHeaderMunici; ServiceHeaderAdd."Municipality Name") { }
            column(ServiceHeaderMunici2; ServiceHeaderAdd."Municipality Name 2") { }
            column(ZahtjevLastEEExecutionCompanyName; ZahtjevLastEEH."Execution Company Name") { } //naziv izvođača
            column(ZahtjevLastEEHProjectAccordance; ZahtjevLastEEH."Project Accordance") { }
            column(ZahtjevLastEEHProjectAccordanceDare; ' od' + format(ZahtjevLastEEH."Project Accordance Date")) { }
            column(IzvodjacRadova; ZahtjevLastEEH2."Execution Company Name") { }
            column(IzvodjacProtokol; ZahtjevLastEEH2."Execution Protocol No. Text") { }
            column(IzvodjacProtokolDate; ZahtjevLastEEH2."Execution Protocol No.") { }
            column(EEDate; ' od' + format(ZahtjevLastEEH."Document Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(EENo; ZahtjevLastEEH."No.") { }
            column(PovrsinaZaGrijanje; GID."Total Heating Area") { }
            column("Purpose"; GID.Purpose) { }
            column(VizuelniRMS; VizuelniRMS) { }
            column(VizuelniRMSNE; VizuelniRMSNE) { }
            column(VizuelniGAS; VizuelniGAS) { }
            column(VizuelniGASNE; VizuelniGASNE) { }
            column(Licnekarte_niz_novi; Licnekarte_niz_novi) { }

            column(ObservedFlawsRMSChecked; ObservedFlawsRMSChecked) { }

            column(ObservedFlawsRMSUnchecked; ObservedFlawsRMSUnchecked) { }

            column(VisualRMSChecked; VisualRMSChecked) { }

            column(VisualRMSUnchecked; VisualRMSUnchecked) { }
            column(VisualInspectionGasChecked; VisualInspectionGasChecked) { }
            column(VisualInspectionGasUnchecked; VisualInspectionGasUnchecked) { }
            column(NedostaciRMS; NedostaciRMS) { }
            column(NedostaciRMSNE; NedostaciRMSNE) { }
            column(PlombaIspravna; PlombaIspravnaDA) { }
            column(PlombaIspravnaNE; PlombaIspravnaNE) { }
            column(StanjeBrojcanikUGI; StanjeNaBrojcanikuV) { }
            column(CvrstocaaLjudi; gid.Hardness) { }
            column(DueDateG; gid."Due Date") { }
            column(Remark; gid.Remark) { }
            column(Zatecenouotvorenom; Zatecenouotvorenom) { }
            column(Zatecenouozatvoreni; Zatecenouozatvoreni) { }
            column(SpojniElementiPlNE; SpojniElementiPlNE) { }
            column(SpojniElementiPlDA; SpojniElementiPlDA) { }
            column(ZaptivenostDA; ZaptivenostDA) { }
            column(SviOtvoreniNE; SviOtvoreniNE) { }
            column(DetekcijaGasnihDA; DetekcijaGasnihDA) { }
            column(DetekcijaGasnihNE; DetekcijaGasnihNE) { }
            column(Co2Da; Co2Da) { }
            column(Co2Ne; Co2Ne) { }
            column(UGiStatusC; UGiStatusC) { }
            column(UGiStatusC1; UGiStatusC1) { }
            column(UGiStatusC2; UGiStatusC2) { }
            column(SviOtvoreniDA; SviOtvoreniDA) { }
            column(ZaptivenostNE; ZaptivenostNE) { }
            column(RMSObjektDA; RMSObjektDA) { }
            column(RMSObjektNE; RMSObjektNE) { }
            column(RMSIskljucenDa; RMSIskljucenDa) { }

            column(GasPlomba; GasPlomba) { }
            column(GasLisca; GasLisca) { }
            column(GasPlombaSG; GasPlombaSG) { }
            column(GAsIskljucen; GAsIskljucen) { }
            column(GAsIskljucen_Ne; GAsIskljucen_Ne) { }
            column(RMSLisca; RMSLisca) { }
            column(RMSPlomba; RMSPlomba) { }
            column(RMSPlombaSG; RMSPlombaSG) { }
            column(UgiPogonDa; UgiPogonDa) { }
            column(UgiPogonNe; UgiPogonNe) { }
            column(UgiPustena; UgiPustena) { }
            column(UGINijePustena; UGINijePustena) { }
            column(StatusComp; StatusComp) { }
            column(StatusDue; StatusDue) { }
            column(StatusOdg; StatusOdg) { }
            column(StatusPar; StatusPar) { }
            column(StatusStorn; StatusStorn) { }
            column(ReopenNo; ReopenNo) { }
            column(ReopenYes; ReopenYes) { }
            column(DueReopen; DueReopen) { }
            column(StatusUnR; StatusUnR) { }
            column(DueDateStatus; DueDateStatus) { }
            column(AlternativeG; AlternativeG) { }
            column(AlternativeText; gid."Alternative fuel text") { }
            column(PipeConnectionType; gid."Pipe/Connection Type") { }

            column(PipeConnectionText; PipeConnectionText) { }
            column(AnticorrosiveProtection; gid."Anticorrosive protection") { }
            column(ConnectionType; gid."Connection type") { }
            column(ConnectionTypeText; ConnectionTypeText) { }
            column(AlternativeDate; format(gid."Alternative fuel Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(PotvrdaServisera; gid."Gas appliance service") { }

            column(ServiseC; gid."Serviceman Text") { }
            column(PPzGid; gid."Fire Protection") { }
            column(OutdoorVentilation; gid."Outdoor Ventilation") { }
            column(PristupacanDA; PristupacanDA) { }

            column(PristupacanNE; PristupacanNE) { }
            column(ChimneyGid; ChimneyGid) { }
            column(UGIVanPogonaOd; format(UGIVanPogonaOd, 0, '<day,2>.<month,2>.<year4>')) { }

            column(ServiseDate; ' od ' + format(gid."Gas appliance service date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(ElectroC; gid."Attest Text") { }
            column(ElectroCDate; ' od ' + format(gid."Attest date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(ppm1; gid.ppm1) { }
            column(Usability; gid.Usability) { }
            column(UsabilityDA; UsabilityDA) { }
            column(UsabilityNE; UsabilityNE) { }

            column(LocationOfLeakage2; gid."Location of leakage2") { }
            column(ZahtjevLastEEHDesigner_Name; ZahtjevLastEEH."Designer Name") { }
            column(ZahtjevLastEEHDesign_Company; ZahtjevLastEEH."Design Company") { }
            column(ZahtjevLastEEHFirefight_Accordance; ZahtjevLastEEH."Firefight Accordance") { }
            column(ZahtjevLastEEHFirefight_Accordance_No_; ZahtjevLastEEH."Firefight Accordance No.") { }
            column(ZahtjevLastEEHChimney_Expert_Opinion; ZahtjevLastEEH."Chimney Expert Opinion") { }
            column(ZahtjevLastEEHChimney_Expert_Date; ' od' + format(ZahtjevLastEEH."Chimney Expert Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(ZahtjevLastEEHFirefightDate; format(ZahtjevLastEEH."SGPO Date Fire Protection", 0, '<day,2>.<month,2>.<year4>')) { }
            column(GasniAparatiSum; GasniAparatiSum) { }


            column(CustName; Cust.Name) { }
            column(ServiceHeaderPhone; "Phone No. MM") { }
            column(ServiceHeaderPhone2; ServiceHeaderAdd."Phone No. 2") { }
            column(ServiceHeaderAddPhone; ServiceHeaderAdd."Phone No.") { }
            column(CompInfoFax; CompInfo."Fax No.") { }
            column(CompInfo_Fax2; CompInfo.Fax2) { }
            column(CompPage; CompInfo."Home Page")
            {

            }
            column(StatusMm; StatusMm) { }
            column(Ugovora; Ugovora) { }
            column(Meter_Manufacturer_Desc; "Meter Manufacturer Desc") { }
            column(MeterManufacturer; AddressMM."Meter Manufacturer Desc") { }
            column(ProizvRadioModule; ProizvRadioModule) { }
            column(ProizvCorrector; ProizvCorrector) { }
            column(GaugeSizeSC; GaugeSizeSC) { }
            column(GaugeSizeSRadioModule; GaugeSizeSRadioModule) { }
            column(SerialCorrector; SerialCorrector) { }
            column(SerialRadioModule; SerialRadioModule) { }
            column(YearCCorrector; YearCCorrector) { }
            column(YearCRM; YearCRM) { }
            column(YearPCorrector; YearPCorrector) { }
            column(YearPRadioM; YearPRadioM) { }
            column(ReadDateC; ReadDateC) { }
            column(ReadDateRM; ReadDateRM) { }
            column(ReadRC; ReadRC) { }
            column(ReadRRM; ReadRRM) { }
            column(ImpC; ImpC) { }
            column(ImpRM; ImpRM) { }
            column(AddressMMPurpose; AddressMM.Purpose) { }
            column(Narudzbenice; Narudzbenice) { }
            column(Zahtjeva; Zahtjeva) { }
            column(Tekuce; Tekuce) { }
            column(Inter; Inter) { }
            column(Plana; Plana) { }

            column(Korekt; Korekt) { }
            column(InvesticionoOdr; InvesticionoOdr) { }
            column(Responsible_Department; ServiceHeaderAdd."Responsible Department") { }
            column(Work_Order_No_; "Work Order No.")
            {

            }
            column(Request_Department; ServiceHeaderAdd."Request Department") { }

            column(Starting_Time; FORMAT(ServiceHeaderAdd."Starting Time", 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>')) { }
            column(Finishing_Time; FORMAT(ServiceHeaderAdd."Finishing Time", 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>')) { }

            column(Timeofticket; FORMAT(ServiceHeaderAdd."Time of ticket", 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>')) { }
            column(Rokzahtjeva; format(ServiceHeaderAdd."Request Due Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(Dateticket; format(ServiceHeaderAdd."Date of ticket", 0, '<day,2>.<month,2>.<year4>')) { }
            column(Time_of_sender; format(ServiceHeaderAdd."Time of sender", 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>')) { }
            column(Date_of_sender; format(ServiceHeaderAdd."Date of sender", 0, '<day,2>.<month,2>.<year4>')) { }

            // column(Time_of_sender;FORMAT(""Time of sender" 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>')) { }

            //column(Dateofsender; format("Date of sender", 0, '<day,2>.<month,2>.<year4>')) { }

            column(Starting_Date; format(ServiceHeaderAdd."Starting Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(Ending_Date; format(ServiceHeaderAdd."Finishing Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(Geo__Activity_Type; ServiceHeaderAdd."Geo. Activity Type") { }
            column(Request_Group; ServiceHeaderAdd."Request Group") { }
            column(Document_Date; format(ServiceHeaderAdd."Document Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(Document_No_; ServiceHeaderAdd."No.") { }
            column(Evidential_Number; ServiceHeaderAdd."Evidential Number") { }
            column(AddressMMa; AddressMM.Address) { }
            column(StreetMM; AddressMM."Street Name") { }
            column(AddressMMReadinMode; AddressMM."Reading Mode") { }
            column(HomeNoMM; AddressMM."Home No. MM") { }
            column(MunicipalityNameMM; AddressMM."Municipality Name") { }
            column(FloorMM; AddressMM."Floor MM") { }
            column(ApartmentNoMm; AddressMM."Apartment No. MM") { }
            column(StreetNoText; AddressMM."Street No. Text MM") { }
            column(streetSamo; AddressMM."Street No.") { }
            column(AddressMMMjernoMjesto; AddressMM."Service Item No.") { }
            column(Gradevinac; Gradevinac) { }
            column(SefRadilista; SefRadilista) { }
            column(Registration_No_; ServiceHeaderAdd."Registration No.") { }
            column(Registry_Code; ServiceHeaderAdd."Registry Code") { }
            column(Registry_No_; ServiceHeaderAdd."Registry No.") { }
            column(Work_Order_Registry_No_; ServiceHeaderAdd."Work Order Registry No.") { }
            column(BrojRegistraSlovima; ServiceHeaderAdd."Work Order Registry No. letter") { }
            column(Request_Department_Name; ServiceHeaderAdd."Request Department Name") { }
            column(Activity_Type; ServiceHeaderAdd."Activity Type") { }
            column(DueDate; format(ServiceHeaderAdd."Due Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(Customer_No_; "Customer No.") { }

            column(Investor; Investor) { }
            column(BrojRN; BrojRN) { }
            column(VodjaGrupe; VodjaGrupe) { }
            column(ZvanjeVodja; ZvanjeVodja) { }
            column(Comp_Picture; Comp.Picture) { }
            column(SatiOVodja; SatiOVodja) { }
            column(SatiSnimanjeVodja; SatiSnimanjeVodja) { }
            column(CreateP; CreateP) { }
            column(Operator; Operator) { }
            column(SatiOperatorO; SatiOperatorO) { }
            column(SatiOperatorSnimanje; SatiOperatorSnimanje) { }
            column(ZvanjeOperater; ZvanjeOperater) { }
            column(Figurant1; Figurant1) { }
            column(FigurantZvanje; FigurantZvanje) { }
            column(Real__Process; ServiceHeaderAdd."Real. Process. Empl. Name") { }
            column(Real__Contr__Empl__Name; ServiceHeaderAdd."Real. Contr. Empl. Name") { }
            column(Real__ProcessP; ServiceHeaderAdd."Prep. Process. Empl. Name.") { }
            column(Real__Contr__Empl__NameP; ServiceHeaderAdd."Prep. Contr. Empl. Name") { }
            column(Reason_For_Service_Order; ServiceHeaderAdd."Reason For Service Order") { }
            column(Remark_For_Service_Order; ServiceHeaderAdd."Remark For Service Order") { }
            column(Real__Verif__Empl__Name; ServiceHeaderAdd."Real. Verif. Empl. Name") { }
            column(Real__Verif__Empl__NameP; ServiceHeaderAdd."Prep. Verif. Empl. Name") { }
            column(Prep__Contr__Empl__Name; ServiceHeaderAdd."Prep. Contr. Empl. Name") { }

            column(Prep__Process__Empl__Name_; ServiceHeaderAdd."Prep. Process. Empl. Name.") { }
            column(Prep__Verif__Empl__Name; ServiceHeaderAdd."Prep. Verif. Empl. Name") { }
            column(SatiFigurantO; SatiFigurantO) { }
            column(RN_Source; ServiceHeaderAdd."RN Source") { }
            column(SatiFiguratnS; SatiFiguratnS) { }
            column(Figurant2; Figurant2) { }
            column(Figurant2Zvanje; Figurant2Zvanje) { }
            column(SatiFigurant2O; SatiFigurant2O) { }
            column(SatiFiguratn2S; SatiFiguratn2S) { }
            column(Snim_Recording_Marking_Finished; ServiceHeaderAdd."Recording/Marking Finished") { }
            column(Snim_Recording_Method; ServiceHeaderAdd."Recording Method") { }
            column(Snim_DGM_Total_Length; ServiceHeaderAdd."DGM Total Length") { }
            column(Snim_PG_Total_Length; ServiceHeaderAdd."PG Total Length") { }
            column(Snim_Recording_No_of_Connections; ServiceHeaderAdd."No. of Connections") { }
            column(Snim_No__of_Objects; ServiceHeaderAdd."No. of Objects") { }
            column(Snim_No__of_Cutting; ServiceHeaderAdd."No. of Cutting") { }
            column(UnitF1; UnitF1) { }
            column(UnitF2; UnitF2) { }
            column(UnitOp; UnitOp) { }
            column(UnitVodja; UnitVodja) { }
            column(Supervisory_Board; ServiceHeaderAdd."Supervisory Board") { }
            column(Holder_of_works; ServiceHeaderAdd."Holder of works") { }
            column(Snim_Pipeline_Recording; ServiceHeaderAdd."Pipeline Recording") { }
            column(Snim_Rec_Marking_Fully_Finished; ServiceHeaderAdd."Rec/Marking Fully Finished") { }
            column(Snim_Rec_Marking_Start_Date; formaT(ServiceHeaderAdd."Rec/Marking Start Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(Snim_Rec_Marking_End_Date; format(ServiceHeaderAdd."Rec/Marking End Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(Tras_Marking_Finished; ServiceHeaderAdd."Marking Finished") { }
            column(Tras_Marking_Method; ServiceHeaderAdd."Marking Method") { }
            column(Tras_Marking_DGM_Total_Length; ServiceHeaderAdd."Mark DGM Total Length") { }
            column(Tras_Marking_PG_Total_Length; ServiceHeaderAdd."Mark PG Total Length") { }
            column(Tras_Mark_No__of_Connections; ServiceHeaderAdd."Mark No. of Connections") { }
            column(Tras_MarkingFullyFinished; ServiceHeaderAdd."Marking Fully Finished") { }
            column(Tras_Marking_Start_Date; format(ServiceHeaderAdd."Marking Start Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(Tras_Marking_End_Date; format(ServiceHeaderAdd."Marking End Date", 0, '<day,2>.<month,2>.<year4>')) { }

            column(Obilj_Marking_Done; ServiceHeaderAdd."Marking Done") { }

            column(Obilj_Marking_Method_2; ServiceHeaderAdd."Marking Method 2") { }
            column(Obilj_Marking_DGM_Total_Length; ServiceHeaderAdd."Marking DGM Total Length") { }
            column(Obilj_Marking_PG_Total_Length; ServiceHeaderAdd."Marking PG Total Length") { }
            column(Obilj_Marking_No__of_Connections; ServiceHeaderAdd."Marking No. of Connections") { }
            column(Obilj_Marking_Fully_Done; ServiceHeaderAdd."Marking Fully Done") { }
            column(Obilj_Marking_Start_Date___2; format(ServiceHeaderAdd."Marking Start Date - 2", 0, '<day,2>.<month,2>.<year4>')) { }
            column(Obilj_Marking_End_Date_2; format(ServiceHeaderAdd."Marking End Date 2", 0, '<day,2>.<month,2>.<year4>')) { }
            column(Harpoon; ServiceHeaderAdd.Harpoon) { }
            column(Harpoon_R; ServiceHeaderAdd."Harpoon -R")
            { }
            column(Spray; ServiceHeaderAdd.Spray) { }
            column(Spray_R; ServiceHeaderAdd."Spray -R") { }
            column(Bolcna; ServiceHeaderAdd.Bolcna) { }
            column(Bolcna_R; ServiceHeaderAdd."Bolcna -R") { }
            column(Palette; ServiceHeaderAdd.Palette) { }
            column(Palette_R; ServiceHeaderAdd."Palette -R") { }
            column(Trimble_M3; ServiceHeaderAdd."Trimble M3") { }
            column(Trimble_M3_R; ServiceHeaderAdd."Trimble M3 -R") { }
            column(Sokkia_1x; ServiceHeaderAdd."Sokkia 1x") { }
            column(Sokkia_1x_R; ServiceHeaderAdd."Sokkia 1x-R") { }
            column(Zeiss_1x; ServiceHeaderAdd."Zeiss 1x") { }
            column(RNConnection; RNConnection) { }
            column(Zeiss_1x_R; ServiceHeaderAdd."Zeiss 1x-R") { }
            column(Zeiss_REC_ELTA_15; ServiceHeaderAdd."Zeiss REC ELTA 15") { }
            column(Zeiss_REC_ELTA_15_R; ServiceHeaderAdd."Zeiss REC ELTA 15 -R") { }
            column(TRIMBLE_C5; ServiceHeaderAdd."TRIMBLE C5") { }
            column(TRIMBLE_C5_R; ServiceHeaderAdd."TRIMBLE C5 -R") { }
            column(Zeiss_3x; ServiceHeaderAdd."Zeiss 3x") { }
            column(Zeiss_3x_R; ServiceHeaderAdd."Zeiss 3x -R") { }
            column(Sokkia_2_7_m; ServiceHeaderAdd."Sokkia 2.7 m") { }
            column(Sokkia_2_7_m_R; ServiceHeaderAdd."Sokkia 2.7 m -R") { }
            column(Sokkia_3_8_m; ServiceHeaderAdd."Sokkia 3.8 m") { }
            column(Sokkia_3_8_m_R; ServiceHeaderAdd."Sokkia 3.8 m -R") { }
            column(Sokkia_5_m; ServiceHeaderAdd."Sokkia 5 m") { }
            column(Sokkia_5_m_R; ServiceHeaderAdd."Sokkia 5 m -R") { }

            column(Sokkia_SET2030; ServiceHeaderAdd."Sokkia SET2030") { }
            column(Sokkia_SET2030_R; ServiceHeaderAdd."Sokkia SET2030 -R") { }
            column(GPS___Others; ServiceHeaderAdd."GPS - Others") { }
            column(GPS___Others_R; ServiceHeaderAdd."GPS - Others - R") { }
            column(GPS_L1___Promark_3; ServiceHeaderAdd."GPS L1 - Promark 3") { }
            column(GPS_L1___Promark_3_R; ServiceHeaderAdd."GPS L1 - Promark 3 -R") { }
            column(GPS_TRIMBLE_R8S; ServiceHeaderAdd."GPS TRIMBLE R8S") { }
            column(GPS_TRIMBLE_R8S_R; ServiceHeaderAdd."GPS TRIMBLE R8S -R") { }
            column(Wild_1x; ServiceHeaderAdd."Wild 1x") { }
            column(Wild_1x_R; ServiceHeaderAdd."Wild 1x-R") { }
            column(Wild_2_15_m; ServiceHeaderAdd."Wild 2.15 m") { }
            column(Wild_2_15_m_R; ServiceHeaderAdd."Wild 2.15 m -R") { }
            column(pedeset_m; ServiceHeaderAdd."50 m") { }
            column(pedeset_m_R; ServiceHeaderAdd."50 m-R") { }
            column(tridesetm; ServiceHeaderAdd."30 m") { }
            column(tridesetm_R; ServiceHeaderAdd."30 m-R") { }
            column(dvadesetm; ServiceHeaderAdd."20 m") { }
            column(dvadesetm_R; ServiceHeaderAdd."20 m-R") { }
            column(Leica_Disto; ServiceHeaderAdd."Leica Disto") { }
            column(Leica_Disto_R; ServiceHeaderAdd."Leica Disto-R") { }
            column(Accessories_for_Centering; ServiceHeaderAdd."Accessories for Centering") { }
            column(Accessories_for_Centering_R; ServiceHeaderAdd."Accessories for Centering-R") { }
            column(Tersus; ServiceHeaderAdd."GPS Tersus") { }
            column(Topcon; ServiceHeaderAdd."Topcon OS 201") { }
            column(AccExe_Pos; AccExe_Pos) { }
            column(Acc2_Pos_; Acc2_Pos_) { }
            column(AccExeName; AccExeName) { }
            column(Acc2_Name; Acc2_Name) { }
            column(RecommissioningCosts; RecommissioningCosts) { }
            column(SILRowCounter; SILRowCounter) { }

            column(Meter_Manufacturer; "Meter Manufacturer") { }
            column(AddressGEOMM; Address) { }

            column(Municipality_NameGEOMM; "Municipality Name") { }

            dataitem("Service Line"; "Service Line")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                              ORDER(Ascending);

                column(ServiceLineNo; "Service Line"."No.") { }
                column(ServiceDescription; "Service Line".Description) { }
                column(ServiceLineUnitMeasure; "Service Line"."Unit of Measure Code") { }
                column(ServiceLinePlan; "Service Line"."Planned Quantity") { }
                column(ServicePlanRealised; "Service Line".Quantity) { }
                column(ServiceUnitPrice; "Service Line"."Unit Price") { }
                column(ServiceTotal; "Service Line"."Unit Price" * "Service Line".Quantity) { }
                column(SumOfServiceTotal; SumOfServiceTotal) { }


                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SETFILTER(Type, '%1', Type::Item);
                    SumOfServiceTotal := 0;
                    SetFilter("Document No.", '%1', "Service Item Line"."Document No.");

                end;

                trigger OnAfterGetRecord()
                var
                    SL: Record "Service Line";
                    SumUP: Decimal;
                begin
                    SumUP := 0;
                    SL.Reset();
                    SL.CopyFilters("Service Line");
                    IF SL.FindSet() then
                        repeat
                            SumUP += SL."Unit Price" * SL.Quantity;
                        until SL.Next() = 0;
                    SumOfServiceTotal := SumUP;
                end;
            }

            //usluge: 

            dataitem("Service Line Resource"; "Service Line")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                              ORDER(Ascending);

                column(ServiceLineNoRes; "Service Line Resource"."No.") { }
                column(ServiceDescriptionRes; "Service Line Resource".Description) { }
                column(ServiceLineUnitMeasureRes; "Service Line Resource"."Unit of Measure Code") { }
                column(ServiceLinePlanRes; "Service Line Resource"."Planned Quantity") { }
                column(ServicePlanRealisedRes; "Service Line Resource".Quantity) { }
                column(ServiceUnitPriceRes; "Service Line Resource"."Unit Price") { }
                column(ServiceTotalRes; "Service Line Resource"."Unit Price" * "Service Line Resource".Quantity) { }
                column(SumOfServiceTotalRes; SumOfServiceTotalRes) { }

                trigger OnPreDataItem()
                var
                    myInt: Integer;

                begin
                    SETFILTER(Type, '%1|%2', Type::Resource, Type::" ");

                    SetFilter("No.", '<>%1', '');
                    SetFilter("Document No.", '%1', "Service Item Line"."Document No.");

                    //  SetFilter("Resource No.", '<>%1', '');
                    SumOfServiceTotalRes := 0;
                end;

                trigger OnAfterGetRecord()
                var
                    SLR: Record "Service Line";
                    SumUP: Decimal;

                    myInt: Integer;


                begin
                    SumUP := 0;
                    SLR.Reset();
                    SLR.CopyFilters("Service Line Resource");
                    IF SLR.FindSet() then
                        repeat
                            SumUP += SLR."Unit Price" * SLR.Quantity;
                        until SLR.Next() = 0;
                    SumOfServiceTotalRes := SumUP;
                end;


            }

            dataitem("Service Line ResourceEmp"; "Service Line RN")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                              ORDER(Ascending);

                column(ServiceLineResourceEmpNo; "Service Line ResourceEmp"."No.") { }
                column(RequestResourceType1; "Service Line ResourceEmp"."Request Resource Type1") { }
                column(BrojacLjudi; BrojacLjudi) { }
                column(ServiceLineResourceNameEmp; "Service Line ResourceEmp"."Resource Name") { }
                column(ServiceLineResourceEmpUnitofMeasureCode; "Service Line ResourceEmp"."Unit of Measure Code") { }
                column(ServiceLinePlanResourceEmp; "Service Line ResourceEmp"."Planned Quantity") { }
                column(ServicePlanRealisedResourceEmp; "Service Line ResourceEmp".Quantity) { }
                column(ServiceLineResourceEmpUnitPrice; "Service Line ResourceEmp"."Unit Price") { }
                column(ServiceLineResourceEmpTot; "Service Line ResourceEmp"."Unit Price" * "Service Line ResourceEmp".Quantity) { }
                column(ServiceLineResourceEmpResourceName; "Service Line ResourceEmp"."Resource Name") { }
                column(ServiceLineEducationLevelEmp; "Service Line ResourceEmp"."Education Level") { }
                column(SchoolShort; SchoolShort) { }

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SETFILTER(Type, '%1', Type::Resource);
                    SetFilter("Resource No.", '<>%1', '');
                    SetFilter("Document No.", '%1', "Service Item Line"."Document No.");


                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin

                    BrojacLjudi += 1;

                    SchoolShort := "Service Line ResourceEmp"."Education Level";



                end;

            }
            dataitem("Gas Appliance"; "Gas Appliance")
            {

                column(GASDescription; "Gas Appliance".Description) { }
                column(Gas_Appliance_Type; "Gas Appliance Type") { }
                column(Power_To; "Power To") { }
                column(ExcerptArmoredWithAStopper; "Excerpt armored with a stopper") { }

                column(ExcerptArmoredWithAStopperDA; ExcerptArmoredWithAStopperDA) { }

                column(ExcerptArmoredWithAStopperNE; ExcerptArmoredWithAStopperNE) { }
                column(ConstCH4_DA; ConstCH4_DA) { }
                column(ConstCH4_NE; ConstCH4_NE) { }
                column(UGIPutIntoOperation_DA; UGIPutIntoOperation_DA) { }
                column(UGIPutIntoOperation_NE; UGIPutIntoOperation_NE) { }
                column(UsabilityUGI_Empty; UsabilityUGI_Empty) { }
                column(UsabilityUGI_DA; UsabilityUGI_DA) { }
                column(UsabilityUGI_NE; UsabilityUGI_NE) { }

                column(DescriptionB; DescriptionB) { }
                column(DescriptionG; DescriptionG) { }
                column(DescriptionGP; DescriptionGP) { }

                column(GAT_Gas_stove; GAT_Gas_stove) { }
                column(GAT_Gas_heater; GAT_Gas_heater) { }
                column(GAT_Boiler; GAT_Boiler) { }
                column(GAT_Combined_boiler; GAT_Combined_boiler) { }
                column(GAT_Instantaneous_boiler; GAT_Instantaneous_boiler) { }
                column(GAT_Circulating_boiler; GAT_Circulating_boiler) { }
                column(GAT_Condensing_boiler; GAT_Condensing_boiler) { }
                column(GAT_Fireplace; GAT_Fireplace) { }
                column(GAT_Burner; GAT_Burner) { }
                column(GAT_Tiled_stove; GAT_Tiled_stove) { }
                column(GAT_Appliance_without_a_thermocouple; GAT_Appliance_without_a_thermocouple) { }
                column(GAT_Infrared_heater; GAT_Infrared_heater) { }


                column(DescriptionO; DescriptionO) { }
                column(DescriptionKombinovani; DescriptionKombinovani) { }

                column(DescriptionProtocni; DescriptionProtocni) { }
                column(DescriptionCirkularni; DescriptionCirkularni) { }
                column(DescriptionKondezacijski; DescriptionKondezacijski) { }
                column(DescriptionKamin; DescriptionKamin) { }
                column(DescriptionGorionik; DescriptionGorionik) { }
                column(DescriptionKaljevaPec; DescriptionKaljevaPec) { }
                column(DescriptionICGrijalica; DescriptionICGrijalica) { }
                column(DescriptionAparatBezTermoelemnta; DescriptionAparatBezTermoelemnta) { }

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SetFilter("Measure Point No.", '%1', "Service Item Line"."Service Item No.");
                    // SetFilter("Document No.", '%1', "Service Item Line"."Document No.");

                end;


            }

            dataitem("Document Attachment"; "Document Attachment")
            {
                column(Mandatory_Attachment_Type; "Mandatory Attachment Type") { }
                column(YesNoDelivered; Delivered) { }
                column(BrojacMandatory; BrojacMandatory) { }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                    ShFind: record "Service Header";
                begin
                    setfilter("Table ID", '%1', 5940);
                    ShFind.reset;
                    shFind.setfilter("No.", '%1', "Service Item Line"."Document No.");
                    if shFind.findfirst then
                        setfilter("No.", '%1', shFind."CZK Request No.");
                    if strpos(ReportLayout, 'CZK -') <> 0 then
                        setfilter(Delivered, '%1', Delivered::Yes);

                    BrojacMandatory := 0;

                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    BrojacMandatory += 1;

                end;


            }

            dataitem(SCLine; "Service Comment Line")
            {
                column(Comment; SCLine.Comment) { }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                    ShFind: record "Service Header";
                begin
                    SCLine.setfilter("Type", '%1', Type::General);
                    ShFind.reset;
                    shFind.setfilter("No.", '%1', "Service Item Line"."Document No.");
                    SCLine.setfilter("Table Subtype", '%1', "Table Subtype"::"1");
                    SCLine.setfilter("Table Name", '%1', "Table Name"::"Service Header");
                    if shFind.findfirst then
                        SCLine.setfilter("No.", '%1', shFind."No.");
                end;


            }




            //

            dataitem("Service Line Cost"; "Service Line")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                              ORDER(Ascending);

                column(ServiceLineNoCost; "Service Line Cost"."No.") { }
                column(ServiceDescriptionCost; "Service Line Cost".Description) { }
                column(ServiceLineUnitMeasureCost; "Service Line Cost"."Unit of Measure Code") { }
                column(ServiceLinePlanCost; "Service Line Cost"."Planned Quantity") { }
                column(ServicePlanRealisedCost; "Service Line Cost".Quantity) { }
                column(ServiceUnitPriceCost; "Service Line Cost"."Unit Price") { }
                column(ServiceTotalCost; "Service Line Cost"."Unit Price" * "Service Line Cost".Quantity) { }

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SETFILTER(Type, '%1|%2', Type::Cost, Type::"G/L Account");
                    SetFilter("Document No.", '%1', "Service Item Line"."Document No.");


                end;

            }



            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                EMp: Record Employee;
                RecordLink: record "Record Link";
                RecRef: recordref;
                OutStream: outstream;
                SHValue: Record "Status History 2";

                IStream: InStream;
                ServiceItemLineLast: Record "Service Item Line";
                ServiceItemLineLast2: Record "Service Item Line";
                GasApp: Record "Gas Appliance";
                SHCZk: Record "Service Header";
                SHCZKPost: Record "Service Invoice Header";
                SHCZKOrg: record "Service Header";
                ServiceOrg: Record "Service Header";

                TeamLeaderExists: Boolean;
                ServiceLineRN: Record "Service Line RN";

                GAT: Record "Gas Appliance Type";
                GA: Record "Gas Appliance";
                CJL: Record "Calculation Journal Line";
                WorkOrderCounter: Record "Service Item Line";
                Brojac: Integer;
                Godina: Integer;
                SH: Record "Service Header";
                DocDate: Date;
                GodinaFull: Integer;
                YearTwo: Text[2];

                MgmS: Record "Service Mgt. Setup";
                NoSeriesMgt: Codeunit NoSeriesManagement;
                NewNo: Code[20];
                SeriesNo: Code[20];

            begin
                CompInfo.get;
                CompInfo.CalcFields("Billing Signatory");
                CJL.Reset();
                CJL.SetFilter("Customer No.", '%1', "Service Item Line"."Customer No.");
                CJL.SetFilter("Measuring Point Code", '%1', "Service Item Line"."Service Item No. - Relation");
                CJL.SetFilter(Locked, '%1', true);
                cjl.SetFilter("New Value", '<>%1', 0);
                cjl.SetCurrentKey("Calculation Date To");
                cjl.Ascending;
                if cjl.FindLast() then begin
                    BrojKubika := cjl."New Value";
                    DateBrojKubika := cjl."Calculation Date To";
                end
                else begin
                    BrojKubika := 0;
                    DateBrojKubika := 0D;
                end;

                SigPosText := '';
                SigName := '';
                SignatoryPos.reset;
                SignatoryPos.setfilter("No.", '%1', CompInfo."Billing Signatory Emp");

                if SignatoryPos.findfirst then begin

                    ECL.reset;
                    ECL.setfilter("Employee No.", '%1', SignatoryPos."No.");
                    ECL.setfilter("Active", '%1', true);
                    if ecl.findfirst then begin
                        SigPosText := ecl."Position Description";

                    end
                    else begin
                        SigPosText := '';
                    end;

                    SigName := SignatoryPos."First Name" + ' ' + SignatoryPos."Last Name";
                end;

                CompInfo.get;
                CompInfo.CalcFields("Billing Signatory");
                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 1");
                if banacc.FindFirst() then begin

                    transaction1 := banacc."Bank Account No.";
                    transaction1Name := banacc.Name;
                end;


                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 2");
                if banacc.FindFirst() then begin
                    transaction2name := banacc.Name;
                    transaction2 := banacc."Bank Account No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 3");
                if banacc.FindFirst() then begin
                    transaction3Name := banacc.Name;
                    transaction3 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 4");
                if banacc.FindFirst() then begin
                    transaction4Name := banacc.Name;
                    transaction4 := banacc."Bank Account No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 5");
                if banacc.FindFirst() then begin

                    transaction5Name := banacc.Name;
                    transaction5 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 6");
                if banacc.FindFirst() then begin

                    transaction6Name := banacc.Name;
                    transaction6 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 7");
                if banacc.FindFirst() then begin

                    transaction7Name := banacc.Name;
                    transaction7 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 8");
                if banacc.FindFirst() then begin

                    transaction8Name := banacc.Name;
                    transaction8 := banacc."Bank Account No.";
                end;


                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 9");
                if banacc.FindFirst() then begin

                    transaction9Name := banacc.Name;
                    transaction9 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 10");
                if banacc.FindFirst() then begin

                    transaction10Name := banacc.Name;
                    transaction10 := banacc."Bank Account No.";
                end;

                registrationNumber := CompInfo."Registration No.";
                registrationVATNumber := CompInfo."VAT Registration No.";
                courtNumber := CompInfo.MBS;
                court := CompInfo."Registration Text";
                activityCode := CompInfo."Activity Code";
                vatNumber := CompInfo."Tax No.";


                if VodjaGrupeReq <> '' then begin
                    TeamLeaderExists := false;

                    ServiceLineRN.Reset();
                    ServiceLineRN.SetRange("Request Resource Type1", ServiceLineRN."Request Resource Type1"::"Team Leader");
                    ServiceLineRN.SetRange("Resource No.", VodjaGrupeReq);
                    ServiceLineRN.SetRange("Document No.", "Service Item Line"."Document No.");
                    if ServiceLineRN.FindSet() then
                        TeamLeaderExists := true;

                    if not TeamLeaderExists then
                        CurrReport.Skip();


                end;
                //anisa gasni aparati

                GAT_Gas_stove := ' ';
                GAT_Gas_heater := ' ';
                GAT_Boiler := ' ';
                GAT_Combined_boiler := ' ';
                GAT_Instantaneous_boiler := ' ';
                GAT_Circulating_boiler := ' ';
                GAT_Condensing_boiler := ' ';
                GAT_Fireplace := ' ';
                GAT_Burner := ' ';
                GAT_Tiled_stove := ' ';
                GAT_Appliance_without_a_thermocouple := ' ';
                GAT_Infrared_heater := ' ';


                GA.Reset();
                GA.SetFilter("Measure Point No.", '%1', "Service Item Line"."Service Item No.");
                If GA.Findset() then
                    repeat


                        GAT.Reset();
                        GAT.SetFilter(Type, '%1', GAT.Type::"GAS Device");
                        GAT.SetFilter(Description, '%1', GA."Description");


                        if GAT.FindFirst() then begin

                            if GAT."Gas Appliance Type" = GAT."Gas Appliance Type"::"Gas stove" then
                                GAT_Gas_stove := 'X';
                            if GAT."Gas Appliance Type" = GAT."Gas Appliance Type"::"Gas heater" then
                                GAT_Gas_heater := 'X';
                            if GAT."Gas Appliance Type" = GAT."Gas Appliance Type"::Boiler then
                                GAT_Boiler := 'X';
                            if GAT."Gas Appliance Type" = GAT."Gas Appliance Type"::"Combined boiler" then
                                GAT_Combined_boiler := 'X';
                            if GAT."Gas Appliance Type" = GAT."Gas Appliance Type"::"Instantaneous boiler" then
                                GAT_Instantaneous_boiler := 'X';
                            if GAT."Gas Appliance Type" = GAT."Gas Appliance Type"::"Circulating boiler" then
                                GAT_Circulating_boiler := 'X';
                            if GAT."Gas Appliance Type" = GAT."Gas Appliance Type"::"Condensing boiler" then
                                GAT_Condensing_boiler := 'X';
                            if GAT."Gas Appliance Type" = GAT."Gas Appliance Type"::Fireplace then
                                GAT_Fireplace := 'X';
                            if GAT."Gas Appliance Type" = GAT."Gas Appliance Type"::Burner then
                                GAT_Burner := 'X';
                            if GAT."Gas Appliance Type" = GAT."Gas Appliance Type"::"Tiled stove" then
                                GAT_Tiled_stove := 'X';
                            if GAT."Gas Appliance Type" = GAT."Gas Appliance Type"::"Appliance without a thermocouple" then
                                GAT_Appliance_without_a_thermocouple := 'X';
                            if GAT."Gas Appliance Type" = GAT."Gas Appliance Type"::"Infrared heater" then
                                GAT_Infrared_heater := 'X';
                        end;

                    until GA.next() = 0;

                SILRowCounter += 1;
                "Document No." := "Service Item Line"."Document No.";

                //BrojRN := Numbers("Service Item Line"."Document No.");

                GlobalLanguage := 1050;
                RazduzenoV := 0;

                SHCZKOrg.reset;
                SHCZKOrg.setfilter("No.", '%1', "Service Item Line"."Document No.");
                if SHCZKOrg.findfirst then begin

                    ZaduzenoV := 1;
                    SHValue.Reset();
                    SHValue.SetFilter(Active, '%1', true);
                    SHValue.SetFilter("Request No.", '%1', "Service Item Line"."Document No.");
                    SHValue.SetFilter("Source Table", '%1', 5900);
                    SHValue.SetFilter("Request Type", '%1', SHValue."Request Type"::"General Work Order");
                    if SHValue.FindFirst() then begin
                        if SHValue."Information of processing".AsInteger() in [71, 70] then
                            RazduzenoV := 0
                        else
                            RazduzenoV := 1;


                    end;



                    SHCZk.Reset();
                    SHCZk.SetFilter("No.", '%1', SHCZKOrg."CZK Request No.");
                    if SHCZk.findfirst then begin
                        CZKRN := SHCZk."No.";
                        EvidentialCode := SHCZk."Evidential Number";
                        CZKControl := SHCZk."Real. Contr. Empl. Name";
                        CZKVerif := SHCZk."Real. Verif. Empl. Name";
                        CZKDate := SHCZk."Document Date";
                        CZKReal := SHCZk."Real. Process. Empl. Name";


                        RecRef.GETTABLE(SHCZk);
                        TextIspisPrethodni := '';
                        TextIspisPrethodni := GetNote(RecRef);

                        TextIspisPrethodni2Napomene := '';
                        TextIspisPrethodni2Napomene := GetNote2(RecRef);
                        //Message('SHCZk: ' + TextIspisPrethodni);


                        TempTextKomentar := TextIspisPrethodni;
                        TempTextNapomena := TextIspisPrethodni;
                        TekstKomentar := '';
                        TekstNapomena := '';

                        // Obrada za komentare
                        while STRPOS(TempTextKomentar, 'Komentar:') > 0 do begin
                            StartPos := STRPOS(TempTextKomentar, 'Komentar:') + 9;
                            EndPos := STRPOS(COPYSTR(TempTextKomentar, StartPos), 'Napomena:');
                            if EndPos = 0 then
                                EndPos := STRLEN(TempTextKomentar) - StartPos + 1;
                            TekstKomentar := TekstKomentar + DELCHR(COPYSTR(TempTextKomentar, StartPos, EndPos), '<>', ' ') + ' ';
                            TempTextKomentar := COPYSTR(TempTextKomentar, StartPos + EndPos, STRLEN(TempTextKomentar));
                        end;

                        // Obrada za napomene
                        while STRPOS(TempTextNapomena, 'Napomena:') > 0 do begin
                            StartPos := STRPOS(TempTextNapomena, 'Napomena:') + 9;
                            EndPos := STRPOS(COPYSTR(TempTextNapomena, StartPos), 'Komentar:');
                            if EndPos = 0 then
                                EndPos := STRLEN(TempTextNapomena) - StartPos + 1;
                            TekstNapomena := TekstNapomena + DELCHR(COPYSTR(TempTextNapomena, StartPos, EndPos), '<>', ' ') + ' ';
                            TempTextNapomena := COPYSTR(TempTextNapomena, StartPos + EndPos, STRLEN(TempTextNapomena));
                        end;

                        // Čišćenje viška razmaka
                        TekstKomentar := DELCHR(TekstKomentar, '<>', ' ');
                        TekstNapomena := DELCHR(TekstNapomena, '<>', ' ');

                        // Dodavanje razmaka između svakog komentara i napomene
                        TekstKomentar := TekstKomentar;
                        TekstNapomena := TekstNapomena;
                    end
                    else begin
                        SHCZKPost.Reset();
                        SHCZKPost.SetFilter("No.", '%1', SHCZKOrg."CZK Request No.");
                        if SHCZKPost.findfirst then begin
                            CZKRN := SHCZKPost."No.";
                            CZKControl := SHCZKPost."Real. Contr. Empl. Name";
                            CZKVerif := SHCZKPost."Real. Verif. Empl. Name";
                            CZKDate := SHCZKPost."Document Date";
                            CZKReal := SHCZKPost."Real. Process. Empl. Name";
                            TextIspisPrethodni := '';
                            TextIspisPrethodni2Napomene := '';
                            RecRef.GETTABLE(SHCZKOrg);
                            TextIspisPrethodni := GetNote(RecRef);
                            TextIspisPrethodni2Napomene := GetNote2(RecRef);
                            //Message('SHCZKOrg: ' + TextIspisPrethodni);
                        end;

                    end;

                end;
                //ena gasni aparati


                DescriptionG := '';
                DescriptionB := '';
                DescriptionO := '';
                DescriptionGP := '';
                DescriptionKombinovani := '';
                DescriptionProtocni := '';
                DescriptionCirkularni := '';
                DescriptionKondezacijski := '';
                DescriptionKamin := '';
                DescriptionGorionik := '';
                DescriptionKaljevaPec := '';
                DescriptionICGrijalica := '';
                DescriptionAparatBezTermoelemnta := '';
                ExcerptArmoredWithAStopperDA := '';
                ExcerptArmoredWithAStopperNE := '';



                FoundG := false;
                FoundB := false;
                FoundO := false;
                FoundGP := false;
                FoundKom := false;
                FoundProt := false;
                FoundCirk := false;
                FoundKond := false;
                FoundKamin := false;
                FoundGor := false;
                FoundKalj := false;
                FoundGrijal := false;
                FoundAparat := false;



                if "Service Item Line"."Service item No." <> '' then begin
                    GasApp.reset;
                    GasApp.SetFilter("Measure Point No.", '%1', "Service Item Line"."Service Item No.");
                    if GasApp.FindSet() then
                        repeat
                            if GasApp."Power To" <> 0 then
                                GasniAparatiSum += GasApp.Description + ' ' + GasApp."Gas Appliance Type" + ' ' + format(GasApp."Power To") + ' KW' + ','
                            else
                                GasniAparatiSum += GasApp.Description + ' ' + GasApp."Gas Appliance Type" + ' ' + ',';

                            if StrPos(GasApp.Description, 'štednjak') > 0 then
                                FoundG := true
                            else

                                if StrPos(GasApp.Description, 'peć') > 0 then
                                    FoundGP := true
                                else
                                    if StrPos(GasApp.Description, 'bojler') > 0 then
                                        FoundB := true
                                    else
                                        if StrPos(GasApp.Description, 'kombinovani bojler') > 0 then
                                            FoundKom := true
                                        else
                                            if StrPos(GasApp.Description, 'protocni bojler') > 0 then
                                                FoundProt := true
                                            else
                                                if StrPos(GasApp.Description, 'cirkularni bojler') > 0 then
                                                    FoundCirk := true
                                                else
                                                    if StrPos(GasApp.Description, 'Gasni kondenzacijski kombi bojler') > 0 then
                                                        FoundKond := true
                                                    else
                                                        if StrPos(GasApp.Description, 'kamin') > 0 then
                                                            FoundKamin := true
                                                        else
                                                            if StrPos(GasApp.Description, 'gorionik') > 0 then
                                                                FoundGor := true
                                                            else
                                                                if StrPos(GasApp.Description, 'kaljeva pec') > 0 then
                                                                    FoundKalj := true
                                                                else
                                                                    if StrPos(GasApp.Description, 'grijalica') > 0 then
                                                                        FoundGrijal := true
                                                                    else
                                                                        if StrPos(GasApp.Description, 'aparat bez termoelementa') > 0 then
                                                                            FoundAparat := true
                                                                        else
                                                                            FoundO := true;

                        until GasApp.next = 0;

                    if FoundG then
                        DescriptionG := 'X';
                    if FoundB then
                        DescriptionB := 'X';
                    if FoundGP then
                        DescriptionGP := 'X';
                    if FoundKom then begin
                        DescriptionKombinovani := 'X';
                        DescriptionB := 'X';
                    end;
                    if FoundProt then begin
                        DescriptionProtocni := 'X';
                        DescriptionB := 'X';
                    end;
                    if FoundCirk then begin
                        DescriptionCirkularni := 'X';
                        DescriptionB := 'X';
                    end;
                    if FoundKond then begin
                        DescriptionKondezacijski := 'X';
                        DescriptionB := 'X';
                    end;
                    if FoundKamin then begin
                        DescriptionKamin := 'X';
                        DescriptionO := 'X';
                    end;
                    if FoundGor then begin
                        DescriptionGorionik := 'X';
                        DescriptionO := 'X';
                    end;
                    if FoundKalj then begin
                        DescriptionKaljevaPec := 'X';
                        DescriptionO := 'X';
                    end;
                    if FoundGrijal then begin
                        DescriptionICGrijalica := 'X';
                        DescriptionO := 'X';
                    end;
                    if FoundAparat then begin
                        DescriptionAparatBezTermoelemnta := 'X';
                        DescriptionO := 'X';
                    end;
                    if FoundO then
                        DescriptionO := 'X';

                    if GasApp."Excerpt armored with a stopper" then
                        ExcerptArmoredWithAStopperDA := 'X'
                    else
                        ExcerptArmoredWithAStopperNE := 'X';


                    if strlen(GasniAparatiSum) <> 0 then begin
                        GasniAparatiSum := CopyStr(GasniAparatiSum, 1, strlen(GasniAparatiSum) - 1);
                    end;
                end;







                Zatecenouotvorenom := '     ';
                Zatecenouozatvoreni := '     ';
                SpojniElementiPlDA := '     ';
                SpojniElementiPlNE := '     ';
                SviOtvoreniNE := '     ';
                SviOtvoreniDA := '     ';
                RMSObjektDA := '     ';
                PristupacanDA := '     ';
                RMSObjektNE := '     ';
                UgiPogonNe := '     ';
                UgiPogonDA := '     ';
                RMSIskljucenDa := '     ';
                ZaptivenostDA := '     ';
                ZaptivenostNE := '     ';
                DetekcijaGasnihDA := '     ';
                Co2Da := '     ';
                UGiStatusC := '     ';
                UGiStatusC1 := '     ';
                UGiStatusC2 := '     ';
                VoziloTIp := '';
                RegistracijaVozila := '';
                Co2Ne := '     ';
                DetekcijaGasnihNE := '     ';
                ZaptivenostNE := '     ';
                UgiPustena := '     ';
                VizuelniRMS := '     ';
                VizuelniGAS := '     ';
                VizuelniGASNE := '     ';
                VizuelniRMSNE := '     ';
                IzvodjacBaremjedan := '     ';
                GasLisca := '     ';
                GasPlomba := '     ';
                RMSPlomba := '     ';
                RMSLisca := '     ';
                GAsIskljucen := '     ';
                GAsIskljucen_Ne := '     ';
                NedostaciRMS := '     ';
                NedostaciRMSNE := '     ';
                PlombaIspravnaDA := '     ';
                PlombaIspravnaNE := '     ';
                ConstCH4_DA := '     ';
                ConstCH4_NE := '     ';
                UsabilityUGI_Empty := '     ';
                UsabilityUGI_DA := '     ';
                UsabilityUGI_NE := '     ';


                GID.Reset();
                GID.SetFilter("Measure Point No.", '%1', "Service Item Line"."Service Item No.");
                gid.setcurrentkey("Date");
                gid.ascending;
                if gid.findlast then begin
                    PipeConnectionText := format(GID."Pipe/Connection Type");
                    ConnectionTypeText := format(GID."Connection type");
                    StanjeNaBrojcanikuV := format(gid."RMS Reading");
                    if (gid."RMS Reading" = 0) and (gid."Reading Value 0" = false) then
                        StanjeNaBrojcanikuV := '';

                    if gid.Hardness <> '' then begin
                        IzvodjacBaremjedan := gid.Hardness;
                    end
                    else begin
                        if gid.Impermeability <> '' then begin
                            IzvodjacBaremjedan := gid.Impermeability
                        end
                        else begin
                            if gid."Working pressure test" <> '' then begin
                                IzvodjacBaremjedan := gid."Working pressure test"
                            end
                            else begin
                                if gid."Impermeability" <> '' then begin
                                    IzvodjacBaremjedan := gid."Impermeability";
                                end
                                else begin
                                    if gid."Usability" <> '' then begin
                                        IzvodjacBaremjedan := gid."Usability";
                                    end else begin
                                        if gid."Chimney" <> '' then begin
                                            IzvodjacBaremjedan := gid."Chimney";
                                        end
                                        else begin

                                        end;

                                    end;

                                end;

                            end;
                        end;
                    end;

                    if gid."UGI out of operation" = gid."UGI out of operation"::Yes then
                        UGIVanPogonaOd := gid.Date
                    else
                        UGIVanPogonaOd := 0D;





                    /*if gid."Visual inspection of the RMS" = gid."Visual inspection of the RMS"::Empty then begin
                        VizuelniRMS := '     ';
                    end
                    else begin
                        if gid."Visual inspection of the RMS" = gid."Visual inspection of the RMS"::"Yes" then
                            VizuelniRMS := 'X'
                        else
                            VizuelniRMSNE := 'X';
                    end;*/

                    if gid."Visual inspection of the RMS" = gid."Visual inspection of the RMS"::Empty then begin
                        VisualRMSChecked := '';
                        VisualRMSUnchecked := '';

                    end
                    else begin
                        if gid."Visual inspection of the RMS" = gid."Visual inspection of the RMS"::"Yes" then begin
                            VisualRMSChecked := 'X';
                            VisualRMSUnchecked := '';

                        end
                        else begin
                            VisualRMSChecked := '';
                            VisualRMSUnchecked := 'X';
                        end;
                    end;
                    if gid."Anticorrosive protection" = gid."Anticorrosive protection"::" " then begin
                        AnticorrosiveProtectionDA := '';
                        AnticorrosiveProtectionNE := '';
                    end
                    else begin
                        if gid."Anticorrosive protection" = gid."Anticorrosive protection"::Yes then begin
                            AnticorrosiveProtectionDA := 'X';
                            AnticorrosiveProtectionNE := '';
                        end
                        else begin
                            AnticorrosiveProtectionDA := '';
                            AnticorrosiveProtectionNE := 'X';
                        end;
                    end;

                    if gid."Fire Protection" = gid."Fire Protection"::" " then begin
                        FireProtectionDA := '';
                        FireProtectionNE := '';
                        FireProtectionNeTreba := '';
                    end
                    else
                        if gid."Fire Protection" = gid."Fire Protection"::Yes then begin
                            FireProtectionDA := 'X';
                            FireProtectionNE := '';
                            FireProtectionNeTreba := '';
                        end
                        else
                            if gid."Fire Protection" = gid."Fire Protection"::No then begin
                                FireProtectionDA := '';
                                FireProtectionNE := 'X';
                                FireProtectionNeTreba := '';
                            end
                            else
                                if gid."Fire Protection" = gid."Fire Protection"::"No need" then begin
                                    FireProtectionDA := '';
                                    FireProtectionNE := '';
                                    FireProtectionNeTreba := 'X';
                                end;

                    if gid."Outdoor Ventilation" = gid."Outdoor Ventilation"::" " then begin
                        OutdoorVentilationDA := '';
                        OutdoorVentilationNE := '';
                        OutdoorVentilationNijePotrebno := '';
                        OutdoorVentilationNedovoljno := '';
                    end
                    else
                        if gid."Outdoor Ventilation" = gid."Outdoor Ventilation"::Yes then begin
                            OutdoorVentilationDA := 'X';
                            OutdoorVentilationNE := '';
                            OutdoorVentilationNijePotrebno := '';
                        end
                        else
                            if gid."Outdoor Ventilation" = gid."Outdoor Ventilation"::No then begin
                                OutdoorVentilationDA := '';
                                OutdoorVentilationNE := 'X';
                                OutdoorVentilationNijePotrebno := '';
                                OutdoorVentilationNedovoljno := '';
                            end
                            else
                                if gid."Outdoor Ventilation" = gid."Outdoor Ventilation"::"Not Needed" then begin
                                    OutdoorVentilationDA := '';
                                    OutdoorVentilationNE := '';
                                    OutdoorVentilationNijePotrebno := 'X';
                                    OutdoorVentilationNedovoljno := '';
                                end
                                else
                                    if gid."Outdoor Ventilation" = gid."Outdoor Ventilation"::"Insufficient" then begin
                                        OutdoorVentilationDA := '';
                                        OutdoorVentilationNE := '';
                                        OutdoorVentilationNijePotrebno := '';
                                        OutdoorVentilationNedovoljno := 'X';
                                    end;
                    if gid."Const CH4" = gid."Const CH4"::Empty then begin
                        ConstCH4_DA := '';
                        ConstCH4_NE := '';
                    end
                    else begin
                        if gid."Const CH4" = GID."Const CH4"::Yes then begin
                            ConstCH4_DA := 'X';
                            ConstCH4_NE := '';
                        end
                        else begin
                            ConstCH4_DA := '';
                            ConstCH4_NE := 'X';
                        end;
                    end;

                    //
                    if gid."Usability UGI" = gid."Usability UGI"::Empty then begin
                        UsabilityUGI_Empty := 'X';
                        UsabilityUGI_DA := '';
                        UsabilityUGI_NE := '';
                    end
                    else begin
                        if gid."Usability UGI" = gid."Usability UGI"::Yes then begin
                            UsabilityUGI_Empty := '';
                            UsabilityUGI_DA := 'X';
                            UsabilityUGI_NE := '';
                        end
                        else begin
                            UsabilityUGI_Empty := '';
                            UsabilityUGI_DA := '';
                            UsabilityUGI_NE := 'X';
                        end;
                    end;
                    //Ugi put into operation
                    GID.Reset();
                    GID.SetFilter("Measure Point No.", '%1', "Service Item Line"."Service Item No.");
                    GID.SetFilter(Date, '>=%1', "Service Item Line"."Document Date");
                    GID.SetCurrentKey("Date");
                    GID.Ascending(true);

                    if GID.FindLast then begin
                        if GID."UGI put into operation" = GID."UGI put into operation"::Yes then begin
                            UGIPutIntoOperation_DA := (GID."Date");
                        end else begin
                            if GID."UGI out of operation" = GID."UGI out of operation"::Yes then begin
                                UGIPutIntoOperation_NE := (GID."Date");
                            end;
                        end;
                    end else begin
                        UGIPutIntoOperation_DA := 0D;
                        UGIPutIntoOperation_NE := 0D;
                    end;











                    /*if gid."Visual inspection of the gas" = gid."Visual inspection of the gas"::"Empty" then begin
                        VizuelniGASNE := '     ';
                    end
                    else begin

                        if gid."Visual inspection of the gas" = gid."Visual inspection of the gas"::"Yes" then
                            VizuelniGAS := 'X'
                        else
                            VizuelniGASNE := 'X';

                    end;*/
                    if gid."Visual inspection of the gas" = gid."Visual inspection of the gas"::Empty then begin
                        VisualInspectionGasChecked := '';
                        VisualInspectionGasUnchecked := '';
                    end
                    else begin
                        if gid."Visual inspection of the gas" = gid."Visual inspection of the gas"::"Yes" then begin
                            VisualInspectionGasChecked := 'X';
                            VisualInspectionGasUnchecked := '';
                        end
                        else begin
                            VisualInspectionGasChecked := '';
                            VisualInspectionGasUnchecked := 'X';
                        end;
                    end;



                    if gid."The seal is correct" = gid."The seal is correct"::"Empty" then begin
                        PlombaIspravnaDA := '';
                        PlombaIspravnaNE := '';
                    end
                    else begin

                        if gid."The seal is correct" = gid."The seal is correct"::"Yes" then begin
                            PlombaIspravnaDA := 'X';
                            PlombaIspravnaNE := '';
                        end
                        else begin
                            PlombaIspravnaDA := '';
                            PlombaIspravnaNE := 'X';
                        end;
                    end;



                    if gid."Observed flaws in RMS" = gid."Observed flaws in RMS"::"Empty" then begin
                        ObservedFlawsRMSChecked := '';
                        ObservedFlawsRMSUnchecked := '';
                    end
                    else begin
                        if gid."Observed flaws in RMS" = gid."Observed flaws in RMS"::"Yes" then begin
                            ObservedFlawsRMSChecked := 'X';
                            ObservedFlawsRMSUnchecked := '';
                        end
                        else begin
                            ObservedFlawsRMSChecked := '';
                            ObservedFlawsRMSUnchecked := 'X';
                        end;
                    end;


                    if gid."Intervention valve in RMS" = gid."Intervention valve in RMS"::" " then begin
                        Zatecenouotvorenom := '';
                        Zatecenouozatvoreni := '';

                    end
                    else begin

                        if gid."Intervention valve in RMS" = gid."Intervention valve in RMS"::Open then begin
                            Zatecenouotvorenom := 'X';
                            Zatecenouozatvoreni := '';
                        end
                        else begin
                            Zatecenouotvorenom := '';
                            Zatecenouozatvoreni := 'X';
                        end;
                    end;

                    if gid."Connection Elements Locked" = gid."Connection Elements Locked"::"Empty" then begin
                        SpojniElementiPlDA := '';
                        SpojniElementiPlNE := '';
                    end
                    else begin

                        if gid."Connection Elements Locked" = gid."Connection Elements Locked"::"Yes" then begin
                            SpojniElementiPlDA := 'X';
                            SpojniElementiPlNE := '';
                        end

                        else begin
                            SpojniElementiPlDA := '';
                            SpojniElementiPlNE := 'X';
                        end;
                    end;

                    if gid."Gas Station Placement" = gid."Gas Station Placement"::" " then begin
                        RMSObjektDA := '';
                        RMSObjektNE := '';

                    end
                    else begin

                        if gid."Gas Station Placement" = gid."Gas Station Placement"::"In Object"
                        then begin
                            RMSObjektDA := 'X';
                            RMSObjektNE := '';
                        end
                        else begin
                            RMSObjektDA := '';
                            RMSObjektNE := 'X';
                        end;
                    end;

                    if gid."Shutdown on the IV" = gid."Shutdown on the IV"::Empty
                     then begin
                        RMSIskljucenDa := '     ';
                    end

                    else begin

                        if gid."Shutdown on the IV" = gid."Shutdown on the IV"::Yes then
                            RMSIskljucenDa := 'X'
                        else
                            RMSIskljucenDa := '     ';
                    end;

                    RMSPlombaSG := gid."Plomba SG RMS";


                    if gid."RMS Disconn." = gid."RMS Disconn."::Lock then
                        RMSLisca := 'X';
                    if gid."RMS Disconn." = gid."RMS Disconn."::Seal then
                        RMSPlomba := 'X';

                    if gid."Shutdown gas consumer" = gid."Shutdown gas consumer"::Empty then
                        GAsIskljucen := ''
                    else
                        if gid."Shutdown gas consumer" = gid."Shutdown gas consumer"::Yes then
                            GAsIskljucen := 'X'
                        else
                            if gid."Shutdown gas consumer" = gid."Shutdown gas consumer"::No then
                                GAsIskljucen := '';

                    // GAsIskljucen_Ne
                    if gid."Shutdown gas consumer" = gid."Shutdown gas consumer"::Empty then
                        GAsIskljucen_Ne := ''
                    else
                        if gid."Shutdown gas consumer" = gid."Shutdown gas consumer"::Yes then
                            GAsIskljucen_Ne := ''
                        else
                            if gid."Shutdown gas consumer" = gid."Shutdown gas consumer"::No then
                                GAsIskljucen_Ne := 'X';

                    GasPlombaSG := gid."Plomba SG GA";


                    if gid."Shutdown gas consumer by" = gid."Shutdown gas consumer by"::Lock then
                        GasLisca := 'X';

                    if gid."Shutdown gas consumer by" = gid."Shutdown gas consumer by"::Seal then
                        GasPlomba := 'X';


                    // UGI remained in operation
                    if gid."UGI remained in operation" = gid."UGI remained in operation"::Empty then begin
                        UgiPogonDa := '';
                        UgiPogonNE := '';
                    end else begin
                        if gid."UGI remained in operation" = gid."UGI remained in operation"::Yes then begin
                            UgiPogonDa := 'X'; // Ostala u pogonu
                            UgiPogonNE := '';
                        end else begin
                            UgiPogonDa := '';
                            UgiPogonNE := 'X'; // Nije ostala u pogonu
                        end;
                    end;

                    // UGI remained out of order
                    if gid."UGI remained out of order" = gid."UGI remained out of order"::Empty then begin
                        UgiPogonNE := '';
                    end else begin
                        if gid."UGI remained out of order" = gid."UGI remained out of order"::Yes then begin
                            UgiPogonNE := 'X'; // Van pogona
                            UgiPogonDa := '';  // Osiguranje da nije u pogonu
                        end;
                    end;


                    if gid."UGI put into operation" = gid."UGI put into operation"::Empty then begin
                        UgiPustena := '';
                        UGINijePustena := '';
                    end
                    else begin
                        if gid."UGI put into operation" = gid."UGI put into operation"::Yes then begin
                            UgiPustena := 'X';
                            UGINijePustena := '';
                        end
                        else begin
                            UgiPustena := '';
                            UGINijePustena := 'X';
                        end;
                    end;



                    if gid."UGI - affect tightness" = gid."UGI - affect tightness"::Empty then begin
                        ZaptivenostDA := '';
                        ZaptivenostNE := '';

                    end
                    else begin
                        if gid."UGI - affect tightness" = gid."UGI - affect tightness"::Yes then begin
                            ZaptivenostDA := 'X';
                            ZaptivenostNE := '';
                        end
                        else begin
                            ZaptivenostDA := '';
                            ZaptivenostNE := 'X';
                        end;
                    end;
                    if gid."All openings tightly closed" = gid."All openings tightly closed"::"Empty" then begin
                        SviOtvoreniDA := '';
                        SviOtvoreniNE := '';
                    end
                    else begin
                        if gid."All openings tightly closed" = gid."All openings tightly closed"::Yes then begin
                            SviOtvoreniDA := 'X';
                            SviOtvoreniNE := '';
                        end
                        else begin
                            SviOtvoreniDA := '';
                            SviOtvoreniNE := 'X';
                        end;
                    end;

                    if gid."Detection of gas lines" = gid."Detection of gas lines"::Empty then begin
                        DetekcijaGasnihDA := '';
                        DetekcijaGasnihNE := '';
                    end
                    else begin

                        if gid."Detection of gas lines" = gid."Detection of gas lines"::Yes then begin
                            DetekcijaGasnihDA := 'X';
                            DetekcijaGasnihNE := '';
                        end
                        else begin
                            DetekcijaGasnihDA := '';
                            DetekcijaGasnihNE := 'X';
                        end;
                    end;
                    if gid."CO2" = gid."CO2"::Empty then begin
                        Co2Da := '';
                        Co2Ne := '';
                    end
                    else begin
                        if gid."CO2" = gid."CO2"::Yes then begin
                            Co2Da := 'X';
                            Co2Ne := '';
                        end
                        else begin
                            Co2Da := '';
                            Co2Ne := 'X';
                        end;
                    end;

                    if gid."UGI is technically correct" = gid."UGI is technically correct"::Completely then
                        UGiStatusC := 'X';
                    if gid."UGI is technically correct" = gid."UGI is technically correct"::"With flaws" then
                        UGiStatusC1 := 'X';
                    if gid."UGI is technically correct" = gid."UGI is technically correct"::Defective then
                        UGiStatusC2 := 'X';

                    if gid."Accessible for Reading" = gid."Accessible for Reading"::Empty then begin
                        PristupacanDA := '';
                        PristupacanNE := '';
                    end
                    else begin
                        if gid."Accessible for Reading" = gid."Accessible for Reading"::Yes then begin

                            PristupacanDA := 'X';
                            PristupacanNE := '';
                        end
                        else begin
                            PristupacanDA := '';
                            PristupacanNE := 'X';
                        end;
                    end;


                    if gid."Chimney Date" <> 0D then begin
                        ChimneyGid := (gid.Chimney) + ' od ' + format(gid."Chimney Date", 0, '<day,2>.<month,2>.<year4>');
                    end
                    else begin
                        ChimneyGid := '';
                    end;
                end;
                if gid."Alternative Fuel" = gid."Alternative Fuel"::Empty then begin
                    AlternativeG := '     ';
                end
                else begin
                    if gid."Alternative Fuel" = gid."Alternative Fuel"::No then
                        AlternativeG := 'NE'
                    else
                        AlternativeG := 'DA';
                end;

                if gid.Usability <> '' then
                    UsabilityDA := 'X'
                else
                    UsabilityNE := 'X';



                //ZahtjevLastEEH.Reset();
                ServiceItemLineLast.Reset();
                ServiceItemLineLast.SetFilter("Service Item No. - Relation", '%1', "Service Item Line"."Service Item No.");
                ServiceItemLineLast.SetFilter("Request type", '%1', ServiceItemLineLast."Request type"::"Project and Energy Accordance");
                ServiceItemLineLast.setcurrentkey("Response Date");
                if ServiceItemLineLast.FindLast() then begin
                    ZahtjevLastEEH.Reset();
                    ZahtjevLastEEH.SetFilter("No.", '%1', ServiceItemLineLast."Document No.");
                    if ZahtjevLastEEH.FindFirst() then begin

                    end;
                end;

                ServiceItemLineLast2.Reset();
                ServiceItemLineLast2.SetFilter("Service Item No. - Relation", '%1', "Service Item Line"."Service Item No.");
                ServiceItemLineLast2.SetFilter("Request type", '%1', ServiceItemLineLast."Request type"::"Work Execution Request");
                ServiceItemLineLast2.setcurrentkey("Response Date");
                if ServiceItemLineLast2.FindLast() then begin
                    ZahtjevLastEEH2.Reset();
                    ZahtjevLastEEH2.SetFilter("No.", '%1', ServiceItemLineLast."Document No.");
                    if ZahtjevLastEEH2.FindFirst() then begin

                    end;
                end;

                ReopenYes := '   ';
                ReopenNo := '   ';


                // if ServiceHeaderAdd.Get(ServiceHeader."Document Type", ServiceHeader."Document No.") then
                //   ServiceHeaderAdd.CalcFields("CZK Date");
                ServiceHeaderAdd.reset;
                ServiceHeaderAdd.setfilter("No.", '%1', "Service Item Line"."Document No.");
                ServiceHeaderAdd.setfilter("Document Type", '%1', "Service Item Line"."Document Type"::Order);
                if ServiceHeaderAdd.FindFirst() then
                    ServiceHeaderAdd.calcfields("CZK Date", "Municipality Name 2", "MZ Name 2", "Street Name 2", "Municipality Name", "MZ Name", "Street Name", "Owner Municipality Name", "Owner MZ Name", "Owner Street Name", "CZK Date", Status_request, "Due Days Status");
                if "Service Item Line"."MM Category" = "Service Item Line"."MM Category"::Household
                then
                    Customer_Category := 'Domaćinstva';

                if "Service Item Line"."MM Category" = "Service Item Line"."MM Category"::CNG
              then
                    Customer_Category := 'CNG';

                if "Service Item Line"."MM Category" = "Service Item Line"."MM Category"::"Large Economy"
              then
                    Customer_Category := 'Velika privreda';

                if "Service Item Line"."MM Category" = "Service Item Line"."MM Category"::"Small Economy"
              then
                    Customer_Category := 'Mala privreda';

                if "Service Item Line"."MM Category" = "Service Item Line"."MM Category"::"Special Customer"
              then
                    Customer_Category := 'Specijalni kupac';
                if "Service Item Line"."MM Category" = "Service Item Line"."MM Category"::"KJKP Heating plant"
              then
                    Customer_Category := 'KJKP Toplane';
                if ServiceHeaderAdd.Status_request = ServiceHeaderAdd.Status_request::"Completely Realized" then
                    StatusComp := 'X'
                else
                    StatusComp := '   ';

                if ServiceHeaderAdd.Status_request = ServiceHeaderAdd.Status_request::"Realized with deadline" then
                    StatusDue := 'X'
                else
                    StatusDue := '   ';

                if ServiceHeaderAdd.Status_request = ServiceHeaderAdd.Status_request::"Partially Realized" then
                    StatusPar := 'X'
                else
                    StatusPar := '   ';

                if ServiceHeaderAdd.Status_request = ServiceHeaderAdd.Status_request::"Not Realized Unavailable" then
                    StatusUnR := 'X'
                else
                    StatusUnR := '   ';

                if ServiceHeaderAdd.Status_request = ServiceHeaderAdd.Status_request::"Suspended" then
                    StatusOdg := 'X'
                else
                    StatusOdg := '   ';

                if ServiceHeaderAdd.Status_request = ServiceHeaderAdd.Status_request::Reversed then
                    StatusStorn := 'X'
                else
                    StatusStorn := '   ';
                DueDateStatus := ServiceHeaderAdd."Due Days Status";


                if ServiceHeaderAdd."Need to reopen work order" = true then
                    ReopenYes := 'X'
                else
                    ReopenNo := 'X';


                if ServiceHeaderAdd."Due Date" = ServiceHeaderAdd."Document Date" then
                    RokPlacanja := 'Odmah'
                else
                    RokPlacanja := format(ServiceHeaderAdd."Due Date");

                KOntaktiAdd := '';
                PhoneAdd := '';
                EmailAdd := '';
                CZkPhoneNumber := '';

                ContactsLink.Reset();
                ContactsLink.SetFilter("Link to Table", '%1', 1);
                ContactsLink.setfilter("No.", '%1', ServiceHeaderAdd."Bill-to Customer No.");
                if ContactsLink.findfirst then begin

                    COntacts.reset;
                    contacts.setfilter("Type Relation", '%1', Contacts."Type Relation"::Customer);

                    contacts.setfilter("Company No.", '%1', ContactsLink."Contact No.");
                    contacts.setfilter("No.", '<>%1', ContactsLink."Contact No.");
                    if contacts.findfirst then begin
                        KOntaktiAdd := contacts."Name";
                        PhoneAdd := contacts."Phone NO.";
                        EmailAdd := contacts."E-Mail";
                    end;
                end;



                KOntaktiOrg := '';
                PhoneOrg := '';
                EmailOrg := '';


                ContactsLink.Reset();
                ContactsLink.SetFilter("Link to Table", '%1', 1);
                ContactsLink.setfilter("No.", '%1', ServiceHeaderAdd."Bill-to Customer No.");
                if ContactsLink.findfirst then begin

                    COntacts.reset;
                    contacts.setfilter("Type Relation", '%1', Contacts."Type Relation"::Customer);

                    contacts.setfilter("Company No.", '%1', ContactsLink."Contact No.");
                    contacts.setfilter("No.", '%1', ContactsLink."Contact No.");
                    if contacts.findfirst then begin
                        KOntaktiOrg := contacts."Name";
                        PhoneOrg := contacts."Phone NO.";
                        EmailOrg := contacts."E-Mail";
                    end;
                end;

                Licnekarte_niz_novi := '';

                UserM.reset;
                UserM.setfilter("User ID", '%1', USERID);
                if UserM.findfirst then begin
                    CZkPhone.reset;
                    CZkPhone.setfilter("No.", '%1', UserM.CZK);
                    if CZkPhone.findfirst then begin
                        CZkPhoneNumber := CZKPhone."Phone No.";
                    end;
                end;

                LK.Reset(); //ovdje sad kupi lične karte novog korisnika
                LK.SETFILTER(Active, '%1', true);
                LK.SETFILTER("Customer No.", '%1', ServiceHeaderAdd."Bill-to Customer No.");
                IF LK.FindSet() then
                    repeat
                        if Licnekarte_niz_novi = '' then begin
                            if LK."Identity card issuer" <> '' then
                                Licnekarte_niz_novi := LK.Code + ', ' + LK."Identity card issuer"
                            else
                                Licnekarte_niz_novi := LK.Code;
                        end
                    until LK.next() = 0;

                if Licnekarte_niz_novi = '' then
                    Licnekarte_niz_novi := ServiceHeaderAdd."VAT Registration No.";

                DueReopen := ServiceHeaderAdd."Due Days Reopen";
                TextIspisTrenutno := '';

                ServiceOrg.reset;
                ServiceOrg.setfilter("No.", '%1', "Service Item Line"."Document No.");
                if ServiceOrg.findfirst then begin
                    RecRef.GETTABLE(ServiceOrg);
                    TextIspisTrenutno := GetNote(RecRef);
                    TextIspisPrethodni2Napomene := GetNote2(RecRef);
                    //Message('ServiceOrg: ' + TextIspisTrenutno);
                    // TempTextKomentar := TextIspisTrenutno;
                    // TempTextNapomena := TextIspisTrenutno;
                    TempTextKomentar := TextIspisTrenutno;
                    TempTextNapomena := TextIspisTrenutno;
                    TekstKomentar := '';
                    TekstNapomena := '';

                    // Obrada za komentare
                    while STRPOS(TempTextKomentar, 'Komentar:') > 0 do begin
                        StartPos := STRPOS(TempTextKomentar, 'Komentar:') + 9;
                        EndPos := STRPOS(COPYSTR(TempTextKomentar, StartPos), 'Napomena:');
                        if EndPos = 0 then
                            EndPos := STRLEN(TempTextKomentar) - StartPos + 1;
                        TekstKomentar := TekstKomentar + DELCHR(COPYSTR(TempTextKomentar, StartPos, EndPos), '<>', ' ') + ' ';
                        TempTextKomentar := COPYSTR(TempTextKomentar, StartPos + EndPos, STRLEN(TempTextKomentar));
                    end;

                    // Obrada za napomene
                    while STRPOS(TempTextNapomena, 'Napomena:') > 0 do begin
                        StartPos := STRPOS(TempTextNapomena, 'Napomena:') + 9;
                        EndPos := STRPOS(COPYSTR(TempTextNapomena, StartPos), 'Komentar:');
                        if EndPos = 0 then
                            EndPos := STRLEN(TempTextNapomena) - StartPos + 1;
                        TekstNapomena := TekstNapomena + DELCHR(COPYSTR(TempTextNapomena, StartPos, EndPos), '<>', ' ') + ' ';
                        TempTextNapomena := COPYSTR(TempTextNapomena, StartPos + EndPos, STRLEN(TempTextNapomena));
                    end;

                    // Čišćenje viška razmaka
                    TekstKomentar := DELCHR(TekstKomentar, '<>', ' ');
                    TekstNapomena := DELCHR(TekstNapomena, '<>', ' ');

                    // Dodavanje razmaka između svakog komentara i napomene
                    TekstKomentar := TekstKomentar;
                    TekstNapomena := TekstNapomena;

                end;

                CompInfo.get;
                CompInfo.CalcFields("Billing Signatory");
                EmpN.Reset();
                EmpN.SetFilter("No.", '%1', CompInfo."Accusation Responsible Person");
                if EmpN.FindFirst() then begin
                    AccExeName := EmpN."First Name" + ' ' + EmpN."Last Name";
                    ecl.Reset();
                    ecl.SetFilter("Employee No.", '%1', EmpN."No.");
                    ecl.SetFilter(Active, '%1', true);
                    if ecl.FindFirst() then
                        AccExe_Pos := ecl."Position Description";

                end;

                EmpN.Reset();
                EmpN.SetFilter("No.", '%1', CompInfo."Accusation Responsible Person Exe");
                if EmpN.FindFirst() then begin
                    Acc2_Name := EmpN."First Name" + ' ' + EmpN."Last Name";
                    ecl.Reset();
                    ecl.SetFilter("Employee No.", '%1', EmpN."No.");
                    ecl.SetFilter(Active, '%1', true);
                    if ecl.FindFirst() then
                        Acc2_Pos_ := ecl."Position Description";

                end;




                ServiceItemLine.Reset();
                ServiceItemLine.SetFilter("Document No.", '%1', ServiceHeader."No.");
                if ServiceItemLine.FindFirst() then
                    ORG.Reset();
                ORG.SetFilter("Date From", '<=%1', Today);
                ORG.SetFilter(status, '%1', ORG.Status::Active);
                ORG.SetCurrentKey("Date From");
                ORG.Ascending;
                ORG.FindFirst();

                Head.Reset();
                Head.SetFilter("Management Level", '%1', Head."Management Level"::CEO);
                Head.SetFilter("ORG Shema", '%1', ORG.Code);
                if Head.FindFirst() then begin
                    Head.CalcFields("Employee Name", "Employee Last Name", "Employee No.");
                    Head.CalcFields("Position Description");
                    emp.SetFilter("No.", '%1', Head."Employee No.");
                    if emp.FindFirst() then begin
                        CEO_Phone := emp."Company Phone No.";
                    end;
                end;




                Cust.Reset();
                Cust.SetFilter("No.", '%1', "Customer No.");
                if Cust.findfirst then begin
                    Cust.CalcFields("Balance (LCY)");
                    EmailEracunKOntaktiOrg := Cust."E-Mail 2";

                    if res.Get('A.8.4') then begin//2.	Plati troškove ponovnog stavljanja u pogon unutrašnje gasne instalacije od --
                        VATPostingSetup.SetFilter("VAT Prod. Posting Group", '%1', res."VAT Prod. Posting Group");
                        VATPostingSetup.SetFilter("VAT Bus. Posting Group", '%1', Cust."VAT Bus. Posting Group");
                        if VATPostingSetup.FindFirst() then begin
                            price := res."Unit Price";
                            vat := price * (VATPostingSetup."VAT %" / 100);
                            RecommissioningCosts := price + vat;
                        end;
                    end else begin
                        RecommissioningCosts := 0;
                    end;
                end;

                CustLed.Reset();
                CustLed.SetFilter("Customer No.", '%1', "Customer No.");
                CustLed.SetFilter("Starting Date", '<=%1', ServiceHeaderAdd."Document Date");
                CustLed.setcurrentkey("Starting Date");
                CustLed.Ascending;
                if CustLed.FindLast() then
                    Ugovora := '     ';
                Narudzbenice := '     ';
                Zahtjeva := '     ';
                Tekuce := '     ';
                Inter := '     ';
                Plana := '     ';
                Korekt := '     ';
                InvesticionoOdr := '     ';
                /*   if ServiceHeaderAdd."RN Source" = ServiceHeaderAdd."RN Source"::Contract then
                       Ugovora := '  X ';
                   if ServiceHeaderAdd."RN Source" = ServiceHeaderAdd."RN Source"::"Corrective maintenance" then
                       Korekt := '  X ';
                   if ServiceHeaderAdd."RN Source" = ServiceHeaderAdd."RN Source"::"Investment maintenance" then
                       InvesticionoOdr := '  X ';
                   if ServiceHeaderAdd."RN Source" = ServiceHeaderAdd."RN Source"::"Ongoing maintenance" then
                       Tekuce := '  X ';
                   if ServiceHeaderAdd."RN Source" = ServiceHeaderAdd."RN Source"::"Preventive maintenance plan" then
                       Plana := '  X ';
                   if ServiceHeaderAdd."RN Source" = ServiceHeaderAdd."RN Source"::Purchase then
                       Narudzbenice := '  X ';
                   if ServiceHeaderAdd."RN Source" = ServiceHeaderAdd."RN Source"::Request then
                       Zahtjeva := '  X ';
                   if ServiceHeaderAdd."RN Source" = ServiceHeaderAdd."RN Source"::"Request for intervention" then
                       Inter := '  X ';*/

                AddressMM.reset;
                AddressMM.setfilter("Document No.", '%1', "Service Item Line"."Document No.");
                AddressMM.setfilter("Line No.", '%1', "Service Item Line"."Line No.");
                if AddressMM.findfirst then
                    if AddressMM."Type G_R" = AddressMM."Type G_R"::Corrector then begin
                        ProizvCorrector := AddressMM."Meter Manufacturer Desc";
                        GaugeSizeSC := AddressMM."Gauge Size";
                        SerialCorrector := AddressMM."RMS";
                        YearPCorrector := AddressMM."Year of Production";
                        YearCCorrector := AddressMM."DD calibration";
                        ReadRC := AddressMM.Reading;
                        ReadDateC := AddressMM."Date of consumption";


                    end;

                if AddressMM."Type G_R" = AddressMM."Type G_R"::Radio_Module then begin
                    ProizvRadioModule := '';
                    GaugeSizeSRadioModule := format(AddressMM."Type Radio Module");
                    if AddressMM."Radio Module Serial I" <> '' then
                        SerialRadioModule := AddressMM."Radio Module Serial I"
                    else
                        SerialRadioModule := AddressMM."Radio Module Serial II";

                    YearPRadioM := AddressMM."Year of Production RM";
                    YearCRM := 0;
                    ReadRRM := AddressMM.Reading;
                    ReadDateRM := AddressMM."Date of consumption";
                end;

                UserS.reset;
                UserS.SetFilter("User ID", '%1', SystemCreatedBy);
                if users.FindFirst() then begin
                    if EMp.Get(UserS."Employee No. for Wage") then begin
                        CreateP := EMp."First Name" + ' ' + EMp."Last Name"
                    end;
                    CreateP := '';
                end
                else begin
                    CreateP := '';
                end;
                if AddressMM."Reading Mode" = AddressMM."Reading Mode"::"Reading List" then
                    ReadingValueText1 := 'Manuelno očitanje';
                if AddressMM."Reading Mode" = AddressMM."Reading Mode"::Digital then
                    ReadingValueText1 := 'Daljinsko očitanje';

                GaugeF.Reset();
                GaugeF.SetFilter("Inventar number", '%1', AddressMM.RMS);
                gaugeF.setfilter("Customer No.", '%1', AddressMM."Customer No.");
                gaugeF.SetFilter("Measuring Point", '%1', AddressMM."Service Item No. - Relation");
                if GaugeF.FindFirst() then begin
                    TRImpulse := GaugeF."Number of decimals /Tr"

                end
                else begin
                    TRImpulse := 0;
                end;
                if "Type G_R" = "Type G_R"::Corrector then begin

                    CorrecF.Reset();
                    CorrecF.SetFilter("Inventar number", '%1', AddressMM.RMS);
                    CorrecF.setfilter("Customer No.", '%1', AddressMM."Customer No.");
                    CorrecF.SetFilter("Measuring Point", '%1', AddressMM."Service Item No. - Relation");
                    if CorrecF.FindFirst() then begin
                        ImpC := CorrecF."Number of decimals /Tr"

                    end
                    else begin
                        ImpC := 0;
                    end;


                end;

                if "Type G_R" = "Type G_R"::Radio_Module then begin


                    RadioMF.Reset();
                    RadioMF.SetFilter(Code, '%1', AddressMM.Gauge);
                    //     RadioMF.setfilter("Customer No.", '%1', AddressMM."Customer No.");
                    RadioMF.SetFilter("Measuring Point Code", '%1', AddressMM."Service Item No. - Relation");
                    if RadioMF.FindFirst() then begin
                        ImpRM := 0

                    end
                    else begin
                        ImpRM := 0;
                    end;


                end;

                ZahtjevLastEE.reset;
                ZahtjevLastEE.reset;
                ZahtjevLastEE.SetFilter("Service Item No.", '%1', AddressMM."Service Item No.");
                ZahtjevLastEE.setfilter("Request type", '%1', ZahtjevLastEE."Request type"::"Project and Energy Accordance");
                ZahtjevLastEE.setcurrentkey(SystemCreatedAt);
                ZahtjevLastEE.ascending;
                if ZahtjevLastEE.findfirst then
                    ServiceItem.Reset();
                ServiceItem.SetFilter("No.", '%1', AddressMM."Service Item No.");
                if ServiceItem.findfirst then
                    Investor := '';
                SefRadilista := '';
                Gradevinac := '';
                SatiOVodja := 0;
                ServiceItem.CalcFields("Status MM");
                if ServiceItem."Status MM" = ServiceItem."Status MM"::Potential then
                    StatusMm := 'Potencijalan';
                if ServiceItem."Status MM" = ServiceItem."Status MM"::Active then
                    StatusMm := 'Aktivan';
                if ServiceItem."Status MM" = ServiceItem."Status MM"::"Temporarily deregistered" then
                    StatusMm := 'Privremeno odjavljen';

                if ServiceItem."Status MM" = ServiceItem."Status MM"::"Permanently deregistered" then
                    StatusMm := 'Trajno odjavljen';

                if ServiceItem."Measuring point off" = true then
                    StatusMm := 'Isključen';





                geo.reset;
                geo.SetFilter(code, '%1', ServiceHeaderAdd."GEO WorkPlaces Code");
                if geo.FindFirst() then begin
                    Investor := geo."Investor Name";

                end;

                RNConnection := '';


                if (RNConnection = '') and (ServiceHeaderAdd."CZK Request No." <> '') then
                    RNConnection := 'Veza RN: ' + ServiceHeaderAdd."CZK Request No." + '\';

                ServiceConn.Reset();
                ServiceConn.SetFilter("CZK Request No.", '%1', ServiceHeaderAdd."No.");
                ServiceConn.setfilter("Request Type", '%1|%2|%3', ServiceConn."Request Type"::"General Geo. Work Order", ServiceConn."Request Type"::"General Geo. Work Order Office", ServiceConn."Request Type"::"General Work Order");
                if ServiceConn.FindSet() then
                    repeat
                        if ServiceConn."No." <> ServiceHeaderAdd."No." then
                            RNConnection += ServiceConn."No." + '\';
                    until ServiceConn.next = 0;

                if strlen(RNConnection) > 1 then
                    RNConnection := CopyStr(RNConnection, 1, StrLen(RNConnection) - 1);
                Gradevinac := '';
                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type1", '%1', ServiceLineRN."Request Resource Type1"::Constructor);
                if ServiceLineRN.FindSet() then
                    repeat
                        Gradevinac += ServiceLineRN."Resource Name" + ', ';
                    until ServiceLineRN.Next() = 0;

                if StrLen(Gradevinac) > 2 then
                    Gradevinac := copystr(Gradevinac, 1, StrLen(Gradevinac) - 2);

                SefRadilista := '';
                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type1", '%1', ServiceLineRN."Request Resource Type1"::"Construction Manager");
                if ServiceLineRN.FindSet() then
                    repeat
                        SefRadilista += ServiceLineRN."Resource Name" + ', ';
                    until ServiceLineRN.Next() = 0;

                if StrLen(SefRadilista) > 2 then
                    SefRadilista := copystr(SefRadilista, 1, StrLen(SefRadilista) - 2);

                VodjaGrupe := '';

                ZvanjeVodja := '';
                SatiOVodja := 0;
                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type1", '%1', ServiceLineRN."Request Resource Type1"::"Team Leader");
                if ServiceLineRN.FindSet() then
                    repeat
                        VodjaGrupe += ServiceLineRN."Resource Name" + ', ';
                        ZvanjeVodja += format(ServiceLineRN."Education Level") + ', ';
                        SatiOVodja += ServiceLineRN.Quantity;
                        UnitVodja := ServiceLineRN."Unit of Measure Code";
                    until ServiceLineRN.Next() = 0;

                if StrLen(VodjaGrupe) > 2 then
                    VodjaGrupe := copystr(VodjaGrupe, 1, StrLen(VodjaGrupe) - 2);
                if StrLen(ZvanjeVodja) > 2 then
                    ZvanjeVodja := copystr(ZvanjeVodja, 1, StrLen(ZvanjeVodja) - 2);

                ObLg.Reset();
                ObLg.SetFilter("Employee No.", VodjaGrupeReq);
                ObLg.SetFilter(Active, '%1', true);
                ObLg.SetFilter("Obligation type", '%1', ObLg."Obligation type"::"Zaduženje");
                if ObLg.FindFirst() then begin
                    FixeD.Reset();
                    FixeD.SetFilter("No.", '%1', ObLg."No.");
                    if FixeD.findfirst then begin
                        VoziloTIp := format(FixeD."Veichle Type");
                        RegistracijaVozila := FixeD."Registration No.";

                    end;
                end;
                SatiOVodja := 0;
                SatiSnimanjeVodja := 0;

                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type1", '%1', ServiceLineRN."Request Resource Type1"::"Team Leader");
                if ServiceLineRN.FindSet() then
                    repeat
                        if ServiceLineRN.Intent = ServiceLineRN.Intent::Routing then
                            SatiOVodja += ServiceLineRN.Quantity
                        else
                            SatiSnimanjeVodja += ServiceLineRN.Quantity;

                    until ServiceLineRN.Next() = 0;


                Operator := '';
                ZvanjeOperater := '';

                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type1", '<>%1', ServiceLineRN."Request Resource Type1"::"Team Leader");
                if ServiceLineRN.FindSet() then
                    repeat
                        Operator += ServiceLineRN."Resource Name" + ', ';
                        ZvanjeOperater += format(ServiceLineRN."Education Level") + ', ';
                    //     SatiOperatorO += ServiceLine.Quantity;
                    until ServiceLineRN.Next() = 0;

                if StrLen(Operator) > 2 then
                    Operator := copystr(Operator, 1, StrLen(Operator) - 2);

                if StrLen(ZvanjeOperater) > 2 then
                    ZvanjeOperater := copystr(ZvanjeOperater, 1, StrLen(ZvanjeOperater) - 2);

                SatiOperatorO := 0;

                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type1", '%1', ServiceLineRN."Request Resource Type1"::Operator);
                if ServiceLineRN.FindSet() then
                    repeat
                        if ServiceLineRN.Intent = ServiceLineRN.Intent::Routing then
                            SatiOperatorO += ServiceLineRN.Quantity
                        else
                            SatiOperatorSnimanje += ServiceLineRN.Quantity;
                        UnitOp := ServiceLineRN."Unit of Measure Code";

                    until ServiceLineRN.Next() = 0;

                Figurant1 := '';

                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type1", '%1', ServiceLineRN."Request Resource Type1"::Chainhand);
                if ServiceLineRN.FindSet() then
                    repeat
                        Figurant1 += ServiceLineRN."Resource Name" + ', ';
                    //  SatiFigurantO += ServiceLine.Quantity;
                    until ServiceLineRN.Next() = 0;

                if StrLen(Figurant1) > 2 then
                    Figurant1 := copystr(Figurant1, 1, StrLen(Figurant1) - 2);


                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type1", '%1', ServiceLineRN."Request Resource Type1"::Chainhand);
                if ServiceLineRN.FindSet() then
                    repeat
                        if ServiceLineRN.Intent = ServiceLineRN.Intent::Routing then
                            SatiFigurantO += ServiceLineRN.Quantity
                        else
                            SatiFiguratnS += ServiceLineRN.Quantity;
                        UnitF1 := ServiceLineRN."Unit of Measure Code";

                    until ServiceLineRN.Next() = 0;

                Figurant2 := '';

                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type1", '%1', ServiceLineRN."Request Resource Type1"::Chainhand2);
                if ServiceLineRN.FindSet() then
                    repeat

                        Figurant2 += ServiceLineRN."Resource Name" + ', ';
                    //    SatiFigurant2O += ServiceLine.Quantity;
                    until ServiceLineRN.Next() = 0;

                if StrLen(Figurant2) > 2 then
                    Figurant2 := copystr(Figurant2, 1, StrLen(Figurant2) - 2);
                SatiFigurant2O := 0;
                SatiFiguratn2S := 0;

                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type1", '%1', ServiceLineRN."Request Resource Type1"::Chainhand2);
                if ServiceLineRN.FindSet() then
                    repeat
                        if ServiceLineRN.Intent = ServiceLineRN.Intent::Routing then
                            SatiFigurant2O += ServiceLineRN.Quantity
                        else
                            SatiFiguratn2S += ServiceLineRN.Quantity;
                        UnitF2 := ServiceLineRN."Unit of Measure Code";

                    until ServiceLineRN.Next() = 0;

                if "Work Order No." = '' then begin
                    NoSeriesMgt.InitSeries('WORKORDER', '', 0D, NewNo, SeriesNo);
                    SH.Reset();
                    SH.SetRange("No.", "Document No.");
                    SH.SetRange("Document Type", "Document Type");
                    if SH.FindFirst() then
                        DocDate := SH."Document Date"
                    else
                        DocDate := TODAY;

                    Godina := Date2DMY(DocDate, 3);

                    // Godina := Date2DMY(WorkOrderCounter."Document Date", 3);
                    WorkOrderCounter.Reset();
                    WorkOrderCounter.SetRange("Responsible Department", ServiceHeaderAdd."Responsible Department");
                    WorkOrderCounter.SetFilter("Document Date", '%1..%2', DMY2Date(1, 1, Godina),
                                    DMY2Date(31, 12, Godina));

                    YearTwo := COPYSTR(FORMAT(Godina MOD 100 + 100), 2, 2);

                    "Work Order No." := FORMAT(ServiceHeaderAdd."Responsible Department") + ' - ' + NewNo + '/' + YearTwo;
                    Modify(true);

                end;
            end;

            trigger OnPreDataItem()
            begin
                Comp.get;
                Comp.CalcFields(Picture);
                SILRowCounter := 0;

                if "Service Item Line".GetFilter("Document Date") <> '' then begin
                    SetFilter("Document Date", "Service Item Line".GetFilter("Document Date"));

                    SetCurrentKey(Stroke, String, "Street No.");

                end;


            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Option)
                {
                    field(ReportLayout; ReportLayout)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Report Layout';
                        //   TableRelation="Custom Report Layout".Description wher;

                        trigger OnDrillDown()
                        var
                            myInt: Integer;
                            CustomReportLayout: Record "Custom Report Layout";
                            ReportLayoutSelection: Record "Report Layout Selection";
                            CRLPage: Page "Custom Report Layouts";
                            US: Record "User Setup";
                        begin
                            clear(CRLPage);
                            CustomReportLayout.reset;
                            CustomReportLayout.SetFilter("Report ID", '%1', 50186);
                            US.Reset();
                            US.SetFilter("User ID", '%1', UserId);
                            if us.FindFirst() then begin
                                if us.HS = true then begin
                                    CustomReportLayout.SetFilter(Description, 'SMPPO*');
                                end;
                                if us."CZK User" = true then begin
                                    CustomReportLayout.SetFilter(Description, '@*CZK*');
                                end;

                                if (us.HS = false) and (us."CZK User" = false) then
                                    CustomReportLayout.SetFilter(Description, '<>%1', '@*CZK*');
                            end;
                            CRLPage.SetTableView(CustomReportLayout);

                            CRLPage.LOOKUPMODE(TRUE);
                            IF CRLPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                CRLPage.GETRECORD(CustomReportLayout);
                                ReportLayout := CustomReportLayout.Description;
                                ReportLayoutSelection.SetTempLayoutSelected(format(CustomReportLayout.Code));
                            end;
                        end;
                    }
                    field(VodjaGrupeReq; VodjaGrupeReq)
                    {
                        TableRelation = Employee."No.";
                        Caption = 'VodjaGrupeReq';
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    var
        myInt: Integer;
        CL: Record "Custom Report Layout";
    begin
        CL.Reset();
        CL.SetFilter("Report ID", '%1', 50186);
        if cl.FindFirst() then
            ReportLayout := cl.Description;


    end;

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        BrojacLjudi := 0;
    end;

    procedure Numbers(String: Text) BrojRN: Integer
    var
    begin
        pos := 1;

        WHILE (pos <= STRLEN(string)) AND
    (result = '') OR
    ((result <> '') AND
    IsNumeric)
 DO BEGIN
            IsNumeric := string[pos] IN ['0' .. '9', ',', '.', '-', '+'];
            IF IsNumeric THEN
                result := result + FORMAT(string[pos]);
            pos += 1;
        END;
        if result <> '' then
            Evaluate(BrojRN, result);

    end;


    procedure GetNote(RecRef: RecordRef): Text
    var
        RecordLink: Record "Record Link";
        TypeHelper: Codeunit "Type Helper";
        Result: Text;
        RecLinkMngt: Codeunit "Record Link Management";
        NoteText: BigText;

        InStr: InStream;
    begin
        Clear(RecordLink);
        Clear(Result);
        RecordLink.SetRange("Record ID", RecRef.RecordId);
        RecordLink.SetRange(Type, RecordLink.Type::Note);
        RecordLink.SetRange(Company, CompanyName);
        RecordLink.SetCurrentKey(Created);
        RecordLink.Ascending(true);
        if RecordLink.FindSet() then
            repeat
                RecordLink.CalcFields(Note);

                Result += RecLinkMngt.ReadNote(RecordLink);
            until RecordLink.Next() = 0;
        exit(Result);
    end;

    procedure GetNote2(RecRef: RecordRef): Text
    var
        RecordLink: Record "Record Link";
        TypeHelper: Codeunit "Type Helper";
        Result: Text;
        RecLinkMngt: Codeunit "Record Link Management";
        NoteText: BigText;

        InStr: InStream;
        Brojac: Integer;
    begin
        Clear(RecordLink);
        Clear(Result);
        Brojac := 0;
        RecordLink.SetRange("Record ID", RecRef.RecordId);
        RecordLink.SetRange(Type, RecordLink.Type::Note);
        RecordLink.SetRange(Company, CompanyName);
        RecordLink.SetCurrentKey(Created);
        RecordLink.Ascending(true);
        if RecordLink.FindSet() then
            repeat
                Brojac += 1;
                RecordLink.CalcFields(Note);
                if Brojac <= 2 then
                    Result += RecLinkMngt.ReadNote(RecordLink);
            until RecordLink.Next() = 0;
        exit(Result);
    end;



    local procedure FormatBooleanAsCheckbox(IsChecked: Boolean): Text
    begin
        if IsChecked then
            exit('X')
        else
            exit('   ');
    end;

    local procedure ReturnYesOrNo(IsChecked: Boolean): Text
    begin
        if IsChecked then
            exit('DA')
        else
            exit('NE');
    end;

    var
        myInt: Integer;
        GEo: Record "GEO WorkPlace";
        NedostaciRMS: Text;
        KOntaktiAdd: text;
        PhoneAdd: text;
        EmailAdd: Text;
        NedostaciRMSNE: Text;
        UserM: record "User Setup";
        CZkPhoneNumber: text;

        PlombaIspravnaDA: Text;
        PlombaIspravnaNE: Text;
        Customer_Category: text;
        AlternativeG: text;
        CompInfo: record "Company Information";
        AccExe_Pos: Text;
        Acc2_Name: Text;
        ecl: Record "Employee Contract Ledger";
        AccExeName: Text;
        ServiceItemLine: Record "Service Item Line";
        EmpN: record "Employee";
        ServiceHeader: Record "Service Header";
        ORG: Record "ORG Shema";
        Head: Record "Head Of's";
        CEO_Phone: Text[100];
        Acc2_Pos_: Text;
        Investor: Text;

        UnitVodja: Text;

        CreateP: Text;
        UserS: Record "User Setup";
        UnitOp: Text;
        UnitF1: Text;
        UnitF2: Text;
        Ugovora: Text;
        Narudzbenice: Text;
        Zahtjeva: Text;
        Tekuce: Text;
        Inter: Text;
        Plana: Text;
        Korekt: Text;
        InvesticionoOdr: Text;


        ServiceLine: Record "Service Line";
        ServiceLineRN: Record "Service Line RN";
        ServiceItem: Record "Service Item";
        Gradevinac: Text;
        Comp: Record "Company Information";
        SefRadilista: Text;
        VodjaGrupe: Text;
        Operator: Text;

        Figurant1: Text;

        Figurant2: Text;
        pos: Integer;
        pos2: Integer;
        AddressMM: record "Service Item Line";
        result: Text;
        RNConnection: Text;

        IsNumeric: Boolean;
        ZvanjeVodja: Text;
        ZvanjeOperater: Text;
        FigurantZvanje: Text;
        ReportLayout: Text;
        BrojacLjudi: Integer;
        Figurant2Zvanje: Text;
        GID: Record "Gas Installation Data";
        SatiOVodja: Decimal;
        SatiSnimanjeVodja: Decimal;
        CustLed: Record "Customer Ledger Entry";
        SatiOperatorO: Decimal;
        PPzGid: Text;
        ChimneyGid: Text;
        SatiOperatorSnimanje: Decimal;
        SatiFigurantO: Decimal;
        //   ServiceHeader: Record "Service Header";
        Cust: Record Customer;
        SatiFiguratnS: Decimal;
        SatiFigurant2O: Decimal;
        SatiFiguratn2S: Decimal;
        Zatecenouotvorenom: Text;
        ZaptivenostDA: Text;
        ZaptivenostNE: Text;
        DetekcijaGasnihDA: Text;
        Co2Da: Text;
        Co2Ne: Text;
        UGiStatusC: Text;
        UGiStatusC1: Text;
        UGiStatusC2: Text;
        DetekcijaGasnihNE: Text;
        SpojniElementiPlDA: Text;
        SpojniElementiPlNE: Text;
        RMSObjektDA: Text;
        RMSObjektNE: Text;
        PristupacanDA: Text;
        PristupacanNE: Text;
        VizuelniRMS: Text;
        VizuelniRMSNE: Text;

        SviOtvoreniDa: Text;
        SviOtvoreniNE: Text;


        Zatecenouozatvoreni: Text;
        GasniAparatiSum: Text;
        BrojRN: integer;
        ServiceConn: Record "Service Header";
        SchoolShort: enum "School - short";
        CZKRN: Text;
        ReadingValueText1: Text;
        StanjeNaBrojcanikuV: Text;
        ProizvCorrector: Text;
        ProizvRadioModule: Text;

        GaugeSizeSRadioModule: Text;
        Charr: Char;
        GaugeSizeSC: Text;
        SerialCorrector: Text;
        SerialRadioModule: Text;
        YearPCorrector: integer;
        YearPRadioM: Integer;
        YearCCorrector: Integer;
        YearCRM: Integer;
        ReadRC: Integer;
        ReadDateC: Date;
        ReadRRM: Integer;
        ReadDateRM: Date;

        CZKDate: Date;
        ImpC: Decimal;
        ImpRM: Decimal;

        CZKReal: Text;
        CZKControl: Text;
        CZKVerif: Text;
        EducationL: Text;
        ZahtjevLastEE: Record "Service Item Line";
        GaugeF: record gauge;
        CorrecF: Record "El. Volume Corr";
        RadioMF: Record "Radio Module";
        RMSIskljucenDa: Text;
        RMSPlombaSG: Text;
        RMSLisca: Text;
        RMSPlomba: Text;
        IzvodjacBaremjedan: Text;

        GAsIskljucen: Text;
        GAsIskljucen_Ne: Text;
        GasPlombaSG: Text;
        GasLisca: Text;
        GasPlomba: Text;
        VoziloTIp: text[250];
        RegistracijaVozila: text[250];
        ObLg: Record Obligation;
        TextIspisTrenutno: text[1000];
        TextIspisPrethodni: text[1000];
        TextIspisPrethodni2Napomene: text[1000];
        FixeD: Record "Fixed Asset";
        TRImpulse: Decimal;
        ZahtjevLast: Record "Service Item Line";
        ZahtjevLastEEH: Record "Service Header";
        StatusMm: Text;
        ZahtjevLastEEH2: Record "Service Header";
        ZahtjevLastH: Record "Service Header";
        ServiceHeaderAdd: record "Service Header";
        UgiPogonDa: Text;
        UgiPogonNe: Text;
        UgiPustena: Text;


        UGINijePustena: Text;

        StatusComp: Text;
        EvidentialCode: code[20];
        StatusPar: Text;
        StatusDue: Text;
        DueDateStatus: Integer;
        StatusUnR: Text;
        StatusOdg: Text;
        StatusStorn: Text;
        ReopenYes: Text;
        ReopenNo: Text;
        DueReopen: Integer;

        NoteText: bigtext;
        NoteTextPrevious: BigText
;
        NoteText2: bigtext;
        DateOfRealisation: Text;
        RealisationDone: Text;
        YNRD: Text[3]; //YesNoRealisationDone
        VodjaGrupeReq: code[20];
        VizuelniGAS: Text;
        VizuelniGASNE: Text;
        SumOfServiceTotal: decimal;
        SumOfServiceTotalRes: decimal;
        RecommissioningCosts: Decimal;
        res: Record Resource;
        VATPostingSetup: Record "VAT Posting Setup";
        price, vat : Decimal;
        SILRowCounter: Integer;
        UGIVanPogonaOd: Date;
        VisualInspectionGasChecked: Text[10];
        VisualInspectionGasUnchecked: Text[10];

        VisualRMSChecked: Text[10];
        VisualRMSUnchecked: Text[10];


        ObservedFlawsRMSChecked: Text[10];
        ObservedFlawsRMSUnchecked: Text[10];

        AnticorrosiveProtectionDA: Text[10];

        AnticorrosiveProtectionNE: Text[10];

        FireProtectionDA: Text[10];
        FireProtectionNE: Text[10];
        FireProtectionNeTreba: Text[10];

        OutdoorVentilationDA: Text[10];
        OutdoorVentilationNE: Text[10];
        OutdoorVentilationNijePotrebno: Text[10];
        OutdoorVentilationNedovoljno: Text[10];

        UsabilityDA: Text[10];

        UsabilityNE: Text[10];

        DescriptionG: Text[10];
        DescriptionB: Text[10];
        DescriptionO: Text[10];
        DescriptionGP: Text[10];

        GAT_Gas_stove: Text[10];
        GAT_Gas_heater: Text[10];
        GAT_Boiler: Text[10];
        GAT_Combined_boiler: Text[10];
        GAT_Instantaneous_boiler: Text[10];
        GAT_Circulating_boiler: Text[10];
        GAT_Condensing_boiler: Text[10];
        GAT_Fireplace: Text[10];
        GAT_Burner: Text[10];
        GAT_Tiled_stove: Text[10];
        GAT_Appliance_without_a_thermocouple: Text[10];
        GAT_Infrared_heater: Text[10];


        FoundG: Boolean;
        FoundB: Boolean;
        FoundO: Boolean;

        FoundGP: Boolean;

        DescriptionKombinovani: Text[10];
        DescriptionProtocni: Text[10];
        DescriptionCirkularni: Text[10];
        DescriptionKondezacijski: Text[10];

        DescriptionKamin: Text[10];
        DescriptionGorionik: Text[10];
        DescriptionKaljevaPec: Text[10];

        DescriptionICGrijalica: Text[10];

        DescriptionAparatBezTermoelemnta: Text[10];

        FoundKom: Boolean;
        FoundProt: Boolean;
        FoundCirk: Boolean;
        FoundKond: Boolean;
        FoundKamin: Boolean;
        FoundGor: Boolean;
        FoundKalj: Boolean;
        FoundGrijal: Boolean;
        FoundAparat: Boolean;

        ExcerptArmoredWithAStopperDA: Text[10];

        ExcerptArmoredWithAStopperNE: Text[10];
        ConstCH4_DA: Text[10];
        ConstCH4_NE: Text[10];
        UGIPutIntoOperation_DA: Date;
        UGIPutIntoOperation_NE: Date;
        UsabilityUGI_Empty: Text[10];
        UsabilityUGI_DA: Text[10];
        UsabilityUGI_NE: Text[10];

        PipeConnectionText: Text[100];
        ZaduzenoV: Integer;
        RazduzenoV: integer;


        ConnectionTypeText: Text[100];

        TekstNapomena: Text[1000];
        TekstKomentar: Text[1000];
        TempText: Text[1000];
        StartPos: Integer;
        EndPos: Integer;
        Polje1Prethodni: Text[1000];
        Polje2Prethodni: Text[1000];
        TempTextKomentar: Text[1000];
        TempTextNapomena: Text[1000];
        BrojKubika: Decimal;
        DateBrojKubika: date;
        COntacts: Record Contact;
        ContactsLink: record "Contact Business Relation";
        LK: Record "Customer ID";
        Licnekarte_niz_novi: Text;
        SigPosText: text;
        SigName: text;
        CZkPhone: record "Bank Account";
        BrojacMandatory: integer;
        transaction7Name: text[100];
        transaction7: Text[100];
        transaction1Name: text[100];
        transaction2: text[100];
        transaction1: text[100];
        transaction3: text[100];

        transaction3Name: text[100];

        transaction2Name: text[100];
        transaction4Name: text[100];
        transaction4: Text[100];
        transaction5: Text[100];

        transaction5Name: text[100];
        transaction6Name: TEXT[100];
        transaction6: TEXT[100];

        IznosSaldo: Decimal;

        transaction8Name: TEXT[100];
        transaction8: TEXT[100];
        KOntaktiOrg: TEXT[100];
        PhoneOrg: TEXT[100];
        EmailOrg: TEXT[100];
        EmailEracunKOntaktiOrg: TEXT[100];


        transaction9Name: TEXT[100];
        transaction9: TEXT[100];
        transaction10Name: TEXT[100];

        transaction10: TEXT[100];
        SignatoryPos: Record Employee;
        registrationNumber: Text;
        vatNumber: Text;
        registrationVATNumber: Text;
        activityCode: Text;
        court: Text;
        courtNumber: Text;
        transUnion: Text;
        transactionPrivredna: Text;
        RokPlacanja: text[250];
        transRaif: Text;
        transUni: Text;
        transIntesa: Text;
        transBBI: Text;
        banacc: record "Bank Account";


}