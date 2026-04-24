report 50184 "Service Order GEO"
{

    DefaultLayout = RDLC;
    PreviewMode = Normal;
    WordMergeDataItem = "Service Item Line";
    RDLCLayout = './Service Order GEO.rdl';

    dataset
    {
        dataitem("Service Item Line"; "Service Item Line")
        {
            RequestFilterFields = "Document Date";
            column(No_; "Document No.")
            {

            }
            column(CZKRN; CZKRN) { }
            column(EvidentialCode; EvidentialCode) { }
            column(EvidentialDate; EvidentialDate) { }
            column(CZKControl; CZKControl) { }
            column(CZKDate; format(CZKDate, 0, '<day,2>.<month,2>.<year4>')) { }
            column(CZKReal; CZKReal) { }
            column(CZKVerif; CZKVerif) { }

            column(NoteText; TextIspisTrenutno) { }
            column(TextIspisTrenutnotras; TextIspisTrenutnotras) { }
            column(NoteSnimanje; format(NoteSnimanje)) { }
            column(NoteTextTrasiranje; format(NoteTextTrasiranje)) { }
            column(Responsible_Department_Name; ServiceHeaderAdd."Responsible Department Name") { }
            column(ContractStart; format(CustLed."Starting Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(GaugeSizeS; AddressMM."Gauge Size") { }
            column(AddressMMSerial; AddressMM."RMS") { }
            column(AddressMMStroke; AddressMM.Stroke) { }
            column(AddressMMString; AddressMM.String) { }
            column(TRImpulse; TRImpulse) { }



            column(GEO_WorkPlaces; ServiceHeaderAdd."GEO WorkPlaces") { }
            column(GeoManager; ServiceHeaderAdd."Construction Manager Name") { }
            column(Saldo; Cust."Balance (LCY)") { }
            column(Stroke_No__2; ServiceHeaderAdd."Stroke No. 2") { }
            column(Stroke_No_; ServiceHeaderAdd."Stroke No.") { }
            column(Customer_String; ServiceHeaderAdd."Customer String") { }
            column(Customer_String_2; ServiceHeaderAdd."Customer String 2") { }
            column(Customer_Category; Customer_Category) { }
            column(Address; ServiceHeaderAdd.Address) { }
            column(Address_2; ServiceHeaderAdd."Address 2") { }
            column(Owner_Address; ServiceHeaderAdd."Owner Address") { }
            column(AddressMMZone; AddressMM."Zone Stroke") { }
            column(DateOfConsumption; format(AddressMM."Date of consumption", 0, '<day,2>.<month,2>.<year4>')) { }
            column(DDCalibration; AddressMM."DD calibration") { }
            column(YearProd; AddressMM."Year of Production") { }
            column(AddressMMRMS; AddressMM.RMS) { }

            column(ReadingValue; ReadingValueText1) { }

            column(DateOfRealisation; format(ServiceHeaderAdd."Done Date", 0, '<day,2>.<month,2>.<year4>')) { }
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
            column(ServiceHeaderMunici; "Municipality Name") { }
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
            column(VizuelniRMS; VizuelniRMS) { }
            column(VizuelniRMSNE; VizuelniRMSNE) { }
            column(VizuelniGAS; VizuelniGAS) { }
            column(VizuelniGASNE; VizuelniGASNE) { }
            column(NedostaciRMS; NedostaciRMS) { }
            column(NedostaciRMSNE; NedostaciRMSNE) { }
            column(PlombaIspravna; PlombaIspravnaDA) { }
            column(PlombaIspravnaNE; PlombaIspravnaNE) { }
            column(StanjeBrojcanikUGI; StanjeNaBrojcanikuV) { }
            column(CvrstocaaLjudi; gid.Hardness) { }
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
            column(RMSLisca; RMSLisca) { }
            column(RMSPlomba; RMSPlomba) { }
            column(RMSPlombaSG; RMSPlombaSG) { }
            column(UgiPogonDa; UgiPogonDa) { }
            column(UgiPogonNe; UgiPogonNe) { }
            column(UgiPustena; UgiPustena) { }
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
            column(AlternativeDate; format(gid."Alternative fuel Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(PotvrdaServisera; gid."Gas appliance service") { }

            column(ServiseC; gid."Serviceman Text") { }
            column(PPzGid; gid."Fire Protection") { }
            column(PristupacanDA; PristupacanDA) { }
            column(ChimneyGid; ChimneyGid) { }

            column(ServiseDate; ' od' + format(gid."Gas appliance service date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(ElectroC; gid."Attest Text") { }
            column(ElectroCDate; ' od' + format(gid."Attest date", 0, '<day,2>.<month,2>.<year4>')) { }

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
            column(StatusMm; StatusMm) { }
            column(Ugovora; Ugovora) { }
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
            column(Request_Department; ServiceHeaderAdd."Request Department") { }
            column(Starting_Time; FORMAT(ServiceHeaderAdd."Starting Time", 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>')) { }
            column(Finishing_Time; FORMAT(ServiceHeaderAdd."Finishing Time", 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>')) { }

            column(Timeofticket; FORMAT(ServiceHeaderAdd."Time of ticket", 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>')) { }

            column(Dateticket; format(ServiceHeaderAdd."Date of ticket", 0, '<day,2>.<month,2>.<year4>')) { }
            column(Time_of_sender; format(ServiceHeaderAdd."Time of sender", 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>')) { }
            column(Date_of_sender; format(ServiceHeaderAdd."Date of sender", 0, '<day,2>.<month,2>.<year4>')) { }

            // column(Time_of_sender;FORMAT(""Time of sender" 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>')) { }

            //column(Dateofsender; format("Date of sender", 0, '<day,2>.<month,2>.<year4>')) { }

            column(Starting_Date; format(ServiceHeaderAdd."Starting Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(Ending_Date; format(ServiceHeaderAdd."Finishing Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(Geo__Activity_Type; ServiceHeaderAdd."Geo. Activity Type") { }
            column(GeoContact; ServiceHeaderAdd."Contact Geo") { }
            column(ConstructionManagerName; ServiceHeaderAdd."Construction Manager Name") { }
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
            column(SefRadilista; ServiceHeaderAdd."Construction Manager Name") { }
            column(SefRadilista2; SefRadilista) { }
            column(Registration_No_; ServiceHeaderAdd."Registration No.") { }
            column(Registry_Code; ServiceHeaderAdd."Registry Code") { }
            column(Registry_No_; ServiceHeaderAdd."Registry No.") { }
            column(Work_Order_Registry_No_; ServiceHeaderAdd."Work Order Registry No.") { }
            column(BrojRegistratoraSlovima; ServiceHeaderAdd."Work Order Registry No. letter") { }
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
            column(Real__Process__Empl__Name; ServiceHeaderAdd."Real. Process. Empl. Name") { }
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
            column(ServiceHeaderAddFolder; ServiceHeaderAdd."Folder yes") { }
            column(UnitF1; UnitF1) { }
            column(UnitF2; UnitF2) { }
            column(UnitOp; UnitOp) { }
            column(UnitVodja; UnitVodja) { }
            column(Supervisory_Board; ServiceHeaderAdd."Supervisory Board") { }
            column(Holder_of_works; ServiceHeaderAdd."Holder of works") { }
            column(Snim_Pipeline_Recording; ServiceHeaderAdd."Pipeline Recording") { }
            column(Snim_Rec_Marking_Fully_Finished; ServiceHeaderAdd."Rec/Marking Fully Finished") { }
            column(Snim_Rec_Marking_Start_Date; ServiceHeaderAdd."Rec/Marking Start Date") { }
            column(Snim_Rec_Marking_End_Date; ServiceHeaderAdd."Rec/Marking End Date") { }
            column(Tras_Marking_Finished; ServiceHeaderAdd."Marking Finished") { }
            column(Tras_Marking_Method; ServiceHeaderAdd."Mark Method") { }
            column(Tras_Marking_DGM_Total_Length; ServiceHeaderAdd."Mark DGM Total Length") { }
            column(Tras_Marking_PG_Total_Length; ServiceHeaderAdd."Mark PG Total Length") { }
            column(Tras_Mark_No__of_Connections; ServiceHeaderAdd."Mark No. of Connections") { }
            column(Tras_MarkingFullyFinished; ServiceHeaderAdd."Marking Fully Finished") { }
            column(Tras_Marking_Start_Date; ServiceHeaderAdd."Marking Start Date") { }
            column(Tras_Marking_End_Date; ServiceHeaderAdd."Marking End Date") { }

            column(Obilj_Marking_Done; ServiceHeaderAdd."Marking Done") { }

            column(Obilj_Marking_Method_2; ServiceHeaderAdd."Marking Method 2") { }
            column(Obilj_Marking_DGM_Total_Length; ServiceHeaderAdd."Marking DGM Total Length") { }
            column(Obilj_Marking_PG_Total_Length; ServiceHeaderAdd."Marking PG Total Length") { }
            column(Obilj_Marking_No__of_Connections; ServiceHeaderAdd."Marking No. of Connections") { }
            column(Obilj_Marking_Fully_Done; ServiceHeaderAdd."Marking Fully Done") { }
            column(Obilj_Marking_Start_Date___2; ServiceHeaderAdd."Marking Start Date - 2") { }
            column(Obilj_Marking_End_Date_2; ServiceHeaderAdd."Marking End Date 2") { }
            column(Harpoon_O; ServiceHeaderAdd."Harpoon -O") { }
            column(Harpoon; ServiceHeaderAdd.Harpoon) { }
            column(Harpoon_R; ServiceHeaderAdd."Harpoon -R")
            { }
            column(Spray_O; ServiceHeaderAdd."Spray -O") { }
            column(Spray; ServiceHeaderAdd.Spray) { }
            column(Spray_R; ServiceHeaderAdd."Spray -R") { }
            column(Bolcna_O; ServiceHeaderAdd."Bolcna -O") { }
            column(Bolcna; ServiceHeaderAdd.Bolcna) { }
            column(Bolcna_R; ServiceHeaderAdd."Bolcna -R") { }
            column(Palette_O; ServiceHeaderAdd."Palette -O") { }
            column(Palette; ServiceHeaderAdd.Palette) { }
            column(Palette_R; ServiceHeaderAdd."Palette -R") { }
            column(Trimble_M3_O; ServiceHeaderAdd."Trimble M3 -O") { }
            column(Trimble_M3; ServiceHeaderAdd."Trimble M3") { }
            column(Trimble_M3_R; ServiceHeaderAdd."Trimble M3 -R") { }
            column(Sokkia_1x_O; ServiceHeaderAdd."Sokkia 1x-O") { }
            column(Sokkia_1x; ServiceHeaderAdd."Sokkia 1x") { }
            column(Sokkia_1x_R; ServiceHeaderAdd."Sokkia 1x-R") { }
            column(Zeiss_1x_O; ServiceHeaderAdd."Zeiss 1x-O") { }
            column(Zeiss_1x; ServiceHeaderAdd."Zeiss 1x") { }
            column(RNConnection; RNConnection) { }
            column(Zeiss_1x_R; ServiceHeaderAdd."Zeiss 1x-R") { }

            column(Zeiss_REC_ELTA_15_O; ServiceHeaderAdd."Zeiss REC ELTA 15 -O") { }
            column(Zeiss_REC_ELTA_15; ServiceHeaderAdd."Zeiss REC ELTA 15") { }
            column(Zeiss_REC_ELTA_15_R; ServiceHeaderAdd."Zeiss REC ELTA 15 -R") { }
            column(TRIMBLE_C5_O; ServiceHeaderAdd."TRIMBLE C5 -O") { }
            column(TRIMBLE_C5; ServiceHeaderAdd."TRIMBLE C5") { }
            column(TRIMBLE_C5_R; ServiceHeaderAdd."TRIMBLE C5 -R") { }
            column(Zeiss_3x_O; ServiceHeaderAdd."Zeiss 3x -O") { }
            column(Zeiss_3x; ServiceHeaderAdd."Zeiss 3x") { }
            column(Zeiss_3x_R; ServiceHeaderAdd."Zeiss 3x -R") { }
            column(Sokkia_2_7_m_O; ServiceHeaderAdd."Sokkia 2.7 m -O") { }
            column(Sokkia_2_7_m; ServiceHeaderAdd."Sokkia 2.7 m") { }
            column(Sokkia_2_7_m_R; ServiceHeaderAdd."Sokkia 2.7 m -R") { }
            column(Sokkia_3_8_m_O; ServiceHeaderAdd."Sokkia 3.8 m -O") { }
            column(Sokkia_3_8_m; ServiceHeaderAdd."Sokkia 3.8 m") { }
            column(Sokkia_3_8_m_R; ServiceHeaderAdd."Sokkia 3.8 m -R") { }
            column(Sokkia_5_m_O; ServiceHeaderAdd."Sokkia 5 m -O") { }
            column(Sokkia_5_m; ServiceHeaderAdd."Sokkia 5 m") { }
            column(Sokkia_5_m_R; ServiceHeaderAdd."Sokkia 5 m -R") { }
            column(Sokkia_SET2030_O; ServiceHeaderAdd."Sokkia SET2030 -O") { }
            column(Sokkia_SET2030; ServiceHeaderAdd."Sokkia SET2030") { }
            column(Sokkia_SET2030_R; ServiceHeaderAdd."Sokkia SET2030 -R") { }
            column(GPS_Others_O; ServiceHeaderAdd."GPS - Others - O") { }
            column(GPS___Others; ServiceHeaderAdd."GPS - Others") { }
            column(GPS___Others_R; ServiceHeaderAdd."GPS - Others - R") { }
            column(GPS_L1_Promark_3_O; ServiceHeaderAdd."GPS L1 - Promark 3 -O") { }
            column(GPS_L1___Promark_3; ServiceHeaderAdd."GPS L1 - Promark 3") { }
            column(GPS_L1___Promark_3_R; ServiceHeaderAdd."GPS L1 - Promark 3 -R") { }
            column(GPS_TRIMBLE_R8S_O; ServiceHeaderAdd."GPS TRIMBLE R8S -O") { }
            column(GPS_TRIMBLE_R8S; ServiceHeaderAdd."GPS TRIMBLE R8S") { }
            column(GPS_TRIMBLE_R8S_R; ServiceHeaderAdd."GPS TRIMBLE R8S -R") { }
            column(Wild_1x_O; ServiceHeaderAdd."Wild 1x-O") { }
            column(Wild_1x; ServiceHeaderAdd."Wild 1x") { }
            column(Wild_1x_R; ServiceHeaderAdd."Wild 1x-R") { }
            column(Wild_2_15_m_O; ServiceHeaderAdd."Wild 2.15 m -O") { }
            column(Wild_2_15_m; ServiceHeaderAdd."Wild 2.15 m") { }
            column(Wild_2_15_m_R; ServiceHeaderAdd."Wild 2.15 m -R") { }
            column(pedeset_m_O; ServiceHeaderAdd."50 m-O") { }
            column(pedeset_m; ServiceHeaderAdd."50 m") { }
            column(pedeset_m_R; ServiceHeaderAdd."50 m-R") { }
            column(tridesetm_O; ServiceHeaderAdd."30 m-O") { }
            column(tridesetm; ServiceHeaderAdd."30 m") { }
            column(tridesetm_R; ServiceHeaderAdd."30 m-R") { }
            column(dvadesetm_O; ServiceHeaderAdd."20 m-O") { }
            column(dvadesetm; ServiceHeaderAdd."20 m") { }
            column(dvadesetm_R; ServiceHeaderAdd."20 m-R") { }
            column(Leica_Disto_O; ServiceHeaderAdd."Leica Disto-O") { }
            column(Leica_Disto; ServiceHeaderAdd."Leica Disto") { }
            column(Leica_Disto_R; ServiceHeaderAdd."Leica Disto-R") { }
            column(Accessories_for_Centering_O; ServiceHeaderAdd."Accessories for Centering-O") { }
            column(Accessories_for_Centering; ServiceHeaderAdd."Accessories for Centering") { }
            column(Accessories_for_Centering_R; ServiceHeaderAdd."Accessories for Centering-R") { }
            column(Tersus; ServiceHeaderAdd."GPS Tersus") { }
            column(Tersus_S; ServiceHeaderAdd."GPS Tersus (S)") { }
            column(Tersus_T; ServiceHeaderAdd."GPS Tersus (T)") { }
            column(Tapcon; ServiceHeaderAdd."Topcon OS 201") { }
            column(Tapcon_S; ServiceHeaderAdd."Topcon OS 201 (S)") { }
            column(Tapcon_T; ServiceHeaderAdd."Topcon OS 201 (T)") { }

            column(Topcon1X; ServiceHeaderAdd."Topcon 1x") { }
            column(Topcon1X_S; ServiceHeaderAdd."Topcon 1x (S)") { }
            column(Topcon1X_T; ServiceHeaderAdd."Topcon 1x (T)") { }

            column(Topcon2m; ServiceHeaderAdd."Topcon 2.15m") { }
            column(Topcon2m_S; ServiceHeaderAdd."Topcon 2.15m (S)") { }
            column(Topcon2m_T; ServiceHeaderAdd."Topcon 2.15m (T)") { }


            column(AccExe_Pos; AccExe_Pos) { }
            column(Acc2_Pos_; Acc2_Pos_) { }
            column(AccExeName; AccExeName) { }
            column(Acc2_Name; Acc2_Name) { }
            column(RecommissioningCosts; RecommissioningCosts) { }
            column(SILRowCounter; SILRowCounter) { }

            column(GEOConstructorManagerName; ServiceHeaderAdd."GEO Constructor Manager Name") { }

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
                    //  SetFilter("Resource No.", '<>%1', '');
                    SumOfServiceTotalRes := 0;
                end;

                trigger OnAfterGetRecord()
                var
                    SLR: Record "Service Line";
                    SumUP: Decimal;
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

            dataitem("Service Line ResourceEmp"; "Service Line")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                              ORDER(Ascending);

                column(ServiceLineResourceEmpNo; "Service Line ResourceEmp"."No.") { }
                column(RequestResourceType1; "Service Line ResourceEmp"."Request Resource Type") { }
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
            }

            dataitem("Document Attachment"; "Document Attachment")
            {
                column(Mandatory_Attachment_Type; "Mandatory Attachment Type") { }
                column(YesNoDelivered; Delivered) { }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                    ShFind: record "Service Header";
                begin
                    setfilter("Table ID", '%1', 5901);
                    ShFind.reset;
                    shFind.setfilter("No.", '%1', "Service Item Line"."Document No.");
                    if shFind.findfirst then
                        setfilter("No.", '%1', shFind."CZK Request No.");

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

                end;

            }



            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                EMp: Record Employee;
                RecordLink: record "Record Link";
                RecRef: recordref;
                OutStream: outstream;

                IStream: InStream;
                ServiceItemLineLast: Record "Service Item Line";
                ServiceItemLineLast2: Record "Service Item Line";
                GasApp: Record "Gas Appliance";
                SHCZk: Record "Service Header";
                SHCZKPost: Record "Service Invoice Header";
                SHCZKOrg: record "Service Header";
                ServiceOrg: Record "Service Header";

            begin
                SILRowCounter += 1;
                "Document No." := "Service Item Line"."Document No.";

                //BrojRN := Numbers("Service Item Line"."Document No.");

                GlobalLanguage := 1050;

                SHCZKOrg.reset;
                SHCZKOrg.setfilter("No.", '%1', "Service Item Line"."Document No.");
                if SHCZKOrg.findfirst then begin


                    SHCZk.Reset();
                    SHCZk.SetFilter("No.", '%1', SHCZKOrg."CZK Request No.");
                    if SHCZk.findfirst then begin
                        CZKRN := SHCZk."No.";
                        EvidentialCode := SHCZk."Evidential Number";

                        CZKControl := SHCZk."Real. Contr. Empl. Name";
                        CZKVerif := SHCZk."Real. Verif. Empl. Name";
                        CZKDate := SHCZk."Document Date";
                        CZKReal := SHCZk."Real. Process. Empl. Name";

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

                        end;

                    end;

                end;
                if "Service Item Line"."Service item No." <> '' then begin
                    GasApp.reset;
                    GasApp.SetFilter("Measure Point No.", '%1', "Service Item Line"."Service Item No.");
                    if GasApp.FindSet() then
                        repeat
                            if GasApp."Power To" <> 0 then
                                GasniAparatiSum += GasApp.Description + ' ' + GasApp."Gas Appliance Type" + ' ' + format(GasApp."Power To") + ' KW' + ','
                            else
                                GasniAparatiSum += GasApp.Description + ' ' + GasApp."Gas Appliance Type" + ' ' + ',';
                        until GasApp.next = 0;
                    if strlen(GasniAparatiSum) <> 0 then begin
                        GasniAparatiSum := CopyStr(GasniAparatiSum, 1, strlen(GasniAparatiSum) - 1);
                    end;
                end;

                Zatecenouotvorenom := '';
                Zatecenouozatvoreni := '';
                SpojniElementiPlDA := '';
                SpojniElementiPlNE := '';
                SviOtvoreniNE := '';
                SviOtvoreniDA := '';
                RMSObjektDA := '';
                PristupacanDA := '';
                RMSObjektNE := '';
                UgiPogonNe := '';
                UgiPogonDA := '';
                RMSIskljucenDa := '';
                ZaptivenostDA := '';
                ZaptivenostNE := '';
                DetekcijaGasnihDA := '';
                Co2Da := '';
                UGiStatusC := '';
                UGiStatusC1 := '';
                UGiStatusC2 := '';
                Co2Ne := '';
                DetekcijaGasnihNE := '';
                ZaptivenostNE := '';
                UgiPustena := '';
                VizuelniRMS := '';
                VizuelniGAS := '';
                VizuelniGASNE := '';
                VizuelniRMSNE := '';
                IzvodjacBaremjedan := '';
                GID.Reset();
                GID.SetFilter("Measure Point No.", '%1', "Service Item Line"."Service Item No.");
                gid.setcurrentkey("Date");
                gid.ascending;
                if gid.findlast then begin

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

                    if gid."Visual inspection of the RMS" = gid."Visual inspection of the RMS"::Empty then begin
                        VizuelniRMS := '';
                    end
                    else begin
                        if gid."Visual inspection of the RMS" = gid."Visual inspection of the RMS"::"Yes" then
                            VizuelniRMS := 'X'
                        else
                            VizuelniRMSNE := 'X';
                    end;

                    if gid."Visual inspection of the gas" = gid."Visual inspection of the gas"::"Empty" then begin
                        VizuelniGASNE := '';
                    end
                    else begin

                        if gid."Visual inspection of the gas" = gid."Visual inspection of the gas"::"Yes" then
                            VizuelniGAS := 'X'
                        else
                            VizuelniGASNE := 'X';

                    end;


                    if gid."The seal is correct" = gid."The seal is correct"::"Empty" then begin
                        PlombaIspravnaDA := '';
                    end
                    else begin

                        if gid."The seal is correct" = gid."The seal is correct"::"Yes" then
                            PlombaIspravnaDA := 'X'
                        else
                            PlombaIspravnaNE := 'X';
                    end;



                    if gid."Observed flaws in RMS" = gid."Observed flaws in RMS"::"Empty" then begin
                        NedostaciRMS := '';
                    end
                    else begin
                        if gid."Observed flaws in RMS" = gid."Observed flaws in RMS"::"Yes" then
                            NedostaciRMS := 'X'
                        else
                            NedostaciRMSNE := 'X';
                    end;
                    if gid."Intervention valve in RMS" = gid."Intervention valve in RMS"::" " then begin
                        Zatecenouotvorenom := '';
                    end
                    else begin

                        if gid."Intervention valve in RMS" = gid."Intervention valve in RMS"::Open then
                            Zatecenouotvorenom := 'X'
                        else
                            Zatecenouozatvoreni := 'X';
                    end;

                    if gid."Connection Elements Locked" = gid."Connection Elements Locked"::"Empty" then begin
                        SpojniElementiPlDA := '';
                    end
                    else begin

                        if gid."Connection Elements Locked" = gid."Connection Elements Locked"::"Yes" then
                            SpojniElementiPlDA := 'X'
                        else
                            SpojniElementiPlNE := 'X';
                    end;

                    if gid."Gas Station Placement" = gid."Gas Station Placement"::" " then begin
                        RMSObjektDA := '';
                    end
                    else begin

                        if gid."Gas Station Placement" = gid."Gas Station Placement"::"In Object"
                        then
                            RMSObjektDA := 'X'
                        else
                            RMSObjektNE := 'X';
                    end;

                    if gid."Shutdown on the IV" = gid."Shutdown on the IV"::Empty
                     then begin
                        RMSIskljucenDa := '';
                    end

                    else begin

                        if gid."Shutdown on the IV" = gid."Shutdown on the IV"::Yes then
                            RMSIskljucenDa := 'X'
                        else
                            RMSIskljucenDa := '';
                    end;

                    RMSPlombaSG := gid."Plomba SG RMS";


                    if gid."RMS Disconn." = gid."RMS Disconn."::Lock then
                        RMSLisca := 'X';
                    if gid."RMS Disconn." = gid."RMS Disconn."::Seal then
                        RMSPlomba := 'X';

                    if gid."Shutdown gas consumer" = gid."Shutdown gas consumer"::Empty
                     then begin
                        GAsIskljucen := '';
                    end
                    else begin
                        if gid."Shutdown gas consumer" = gid."Shutdown gas consumer"::Empty then
                            GAsIskljucen := 'X'
                        else
                            GAsIskljucen := '';
                    end;

                    GasPlombaSG := gid."Plomba SG GA";


                    if gid."Shutdown gas consumer by" = gid."Shutdown gas consumer by"::Lock then
                        GasLisca := 'X';
                    if gid."Shutdown gas consumer by" = gid."Shutdown gas consumer by"::Seal then
                        GasPlomba := 'X';

                    if gid."UGI remained in operation" = gid."UGI remained in operation"::Empty then begin
                        UgiPogonDa := '';
                    end
                    else begin

                        if gid."UGI remained in operation" = gid."UGI remained in operation"::"Yes" then
                            UgiPogonDa := 'X'//ostala u pogonu
                        else
                            UgiPogonNE := 'X';
                    end;

                    if gid."UGI remained out of order" = gid."UGI remained out of order"::Empty then begin
                        UgiPogonNE := '';
                    end
                    else begin
                        if gid."UGI remained out of order" = gid."UGI remained out of order"::Yes then
                            //provjeriti pogon
                            UgiPogonNe := '';
                    end;

                    if gid."UGI put into operation" = gid."UGI put into operation"::Empty then begin
                        UgiPustena := '';
                    end
                    else begin
                        if gid."UGI put into operation" = gid."UGI put into operation"::Yes then
                            UgiPustena := 'X'
                        else
                            UgiPustena := '';
                    end;
                    if gid."UGI put into operation" = gid."UGI put into operation"::Yes then
                        UgiPustena := 'X';

                    if gid."UGI - affect tightness" = gid."UGI - affect tightness"::Yes then
                        ZaptivenostDA := 'X'
                    else
                        ZaptivenostNE := 'X';


                    if gid."All openings tightly closed" = gid."All openings tightly closed"::Yes then
                        SviOtvoreniDA := 'X'
                    else
                        SviOtvoreniNE := 'X';

                    if gid."Detection of gas lines" = gid."Detection of gas lines"::Yes then
                        DetekcijaGasnihDA := 'X'
                    else
                        DetekcijaGasnihNE := 'X';

                    if gid."CO2" = gid."CO2"::Yes then
                        Co2Da := 'X'
                    else
                        Co2Ne := 'X';

                    if gid."UGI is technically correct" = gid."UGI is technically correct"::Completely then
                        UGiStatusC := 'X';
                    if gid."UGI is technically correct" = gid."UGI is technically correct"::"With flaws" then
                        UGiStatusC1 := 'X';
                    if gid."UGI is technically correct" = gid."UGI is technically correct"::Defective then
                        UGiStatusC2 := 'X';

                    if gid."Accessible for Reading" = gid."Accessible for Reading"::Yes

                    then
                        PristupacanDA := 'X'

                    else
                        PristupacanDA := '';


                    if gid."Chimney Date" <> 0D then begin
                        ChimneyGid := (gid.Chimney) + ' ' + format(gid."Chimney Date", 0, '<day,2>.<month,2>.<year4>');
                    end
                    else begin
                        ChimneyGid := '';
                    end;
                end;
                if gid."Alternative Fuel" = gid."Alternative Fuel"::Empty then begin
                    AlternativeG := '';
                end
                else begin
                    if gid."Alternative Fuel" = gid."Alternative Fuel"::No then
                        AlternativeG := 'NE'
                    else
                        AlternativeG := 'DA';
                end;
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

                ReopenYes := '';
                ReopenNo := '';


                // if ServiceHeaderAdd.Get(ServiceHeader."Document Type", ServiceHeader."Document No.") then
                //   ServiceHeaderAdd.CalcFields("CZK Date");
                ServiceHeaderAdd.reset;
                ServiceHeaderAdd.setfilter("No.", '%1', "Service Item Line"."Document No.");
                ServiceHeaderAdd.setfilter("Document Type", '%1', "Service Item Line"."Document Type");
                ServiceHeaderAdd.FindFirst();
                ServiceHeaderAdd.calcfields("CZK Date", "Municipality Name 2", "MZ Name 2", "Street Name 2", "Municipality Name", "MZ Name", "Street Name", "Owner Municipality Name", "Owner MZ Name", "Owner Street Name", "CZK Date", Status_request, "Due Days Status");
                if ServiceHeaderAdd."Customer Category" = ServiceHeaderAdd."Customer Category"::Household
                then
                    Customer_Category := 'Domaćinstva';

                if ServiceHeaderAdd."Customer Category" = ServiceHeaderAdd."Customer Category"::CNG
              then
                    Customer_Category := 'CNG';

                if ServiceHeaderAdd."Customer Category" = ServiceHeaderAdd."Customer Category"::"Large Economy"
              then
                    Customer_Category := 'Velika privreda';

                if ServiceHeaderAdd."Customer Category" = ServiceHeaderAdd."Customer Category"::"Small Economy"
              then
                    Customer_Category := 'Mala privreda';

                if ServiceHeaderAdd."Customer Category" = ServiceHeaderAdd."Customer Category"::"Special Customer"
              then
                    Customer_Category := 'Specijalni kupac';
                if ServiceHeaderAdd."Customer Category" = ServiceHeaderAdd."Customer Category"::"KJKP Heating plant"
              then
                    Customer_Category := 'KJKP Toplane';
                if ServiceHeaderAdd.Status_request = ServiceHeaderAdd.Status_request::"Completely Realized" then
                    StatusComp := 'X';

                if ServiceHeaderAdd.Status_request = ServiceHeaderAdd.Status_request::"Realized with deadline" then
                    StatusDue := 'X';

                if ServiceHeaderAdd.Status_request = ServiceHeaderAdd.Status_request::"Partially Realized" then
                    StatusPar := 'X';

                if ServiceHeaderAdd.Status_request = ServiceHeaderAdd.Status_request::"Not Realized Unavailable" then
                    StatusUnR := 'X';

                if ServiceHeaderAdd.Status_request = ServiceHeaderAdd.Status_request::"Suspended" then
                    StatusOdg := 'X';

                if ServiceHeaderAdd.Status_request = ServiceHeaderAdd.Status_request::Reversed then
                    StatusStorn := 'X';
                DueDateStatus := ServiceHeaderAdd."Due Days Status";


                if ServiceHeaderAdd."Need to reopen work order" = true then
                    ReopenYes := 'X'
                else
                    ReopenNo := 'X';

                DueReopen := ServiceHeaderAdd."Due Days Reopen";



                /*  ServiceOrg.reset;
                  ServiceOrg.setfilter("No.", '%1', "Service Item Line"."Document No.");
                  if ServiceOrg.findfirst then begin
                      RecordLink.Reset;
                      RecRef.GETTABLE(ServiceOrg);
                      RecordLink.SetFilter("Record ID", '%1', RecRef.RECORDID);
                      //  RecordLink.SetRange(type, RecordLink.Type::Note);
                      RecordLink.SetCurrentKey(Created);
                      RecordLink.Ascending;
                      if RecordLink.findset then
                          repeat
                              RecordLink.CALCFIELDS(Note);
                              IF RecordLink.Note.HASVALUE THEN BEGIN

                                  CLEAR(NoteText);
                                  Clear(NoteTextBig);
                                  RecordLink.Note.CREATEINSTREAM(IStream, TextEncoding::UTF8);
                                  NoteText := NoteText + TypeHelper.ReadAsTextWithSeparator(IStream, TypeHelper.LFSeparator());
                                  //   IStream.READ(NoteText);


                                  //   NoteTextBig.GETSUBTEXT(NoteText, 1000);
                              END;




                          until RecordLink.Next() = 0;
                  end;*/

                TextIspisTrenutno := '';

                TextIspisTrenutnotras := '';
                ServiceOrg.reset;
                ServiceOrg.setfilter("No.", '%1', "Service Item Line"."Document No.");
                if ServiceOrg.findfirst then begin
                    RecRef.GETTABLE(ServiceOrg);
                    TextIspisTrenutno := GetNote(RecRef);

                    TextIspisTrenutnotras := GetNoteTrasiranje(RecRef);


                    //Message('ServiceOrg: ' + TextIspisTrenutno);
                end;





                CompInfo.get;
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
                /*     if ServiceHeaderAdd."RN Source" = ServiceHeaderAdd."RN Source"::Contract then
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


                if ServiceHeaderAdd."Marking Finished" = true then begin
                    NoteTextTrasiranje := NoteText;
                end;


                if ServiceHeaderAdd."Recording/Marking Finished" = true then begin
                    NoteSnimanje := NoteText;
                end;


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
                    ProizvRadioModule := AddressMM."Meter Manufacturer Desc";
                    GaugeSizeSRadioModule := AddressMM."Gauge Size";
                    SerialRadioModule := AddressMM."RMS";
                    YearPRadioM := AddressMM."Year of Production";
                    YearCRM := AddressMM."DD calibration";
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
                    ReadingValueText1 := 'Očitačka lista';
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

                SatiOVodja := 0;
                SatiSnimanjeVodja := 0;
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

                Investor := ServiceHeaderAdd."Investor Name";

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

                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type", '%1', ServiceLineRN."Request Resource Type"::Constructor);
                if ServiceLineRN.FindSet() then
                    repeat
                        if StrPos(Gradevinac, ServiceLineRN."Resource Name") = 0 then
                            Gradevinac += ServiceLineRN."Resource Name" + ', ';
                    until ServiceLineRN.Next() = 0;

                if StrLen(Gradevinac) > 2 then
                    Gradevinac := copystr(Gradevinac, 1, StrLen(Gradevinac) - 2);

                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type", '%1', ServiceLineRN."Request Resource Type"::"Construction Manager");
                if ServiceLineRN.FindSet() then
                    repeat
                        if StrPos(SefRadilista, ServiceLineRN."Resource Name") = 0 then
                            SefRadilista += ServiceLineRN."Resource Name" + ', ';
                    until ServiceLineRN.Next() = 0;

                if StrLen(SefRadilista) > 2 then
                    SefRadilista := copystr(SefRadilista, 1, StrLen(SefRadilista) - 2);


                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type", '%1', ServiceLineRN."Request Resource Type"::"Team Leader");
                if ServiceLineRN.FindSet() then
                    repeat
                        if StrPos(VodjaGrupe, ServiceLineRN."Resource Name") = 0 then
                            VodjaGrupe += ServiceLineRN."Resource Name" + ', ';
                        if StrPos(ZvanjeVodja, format(ServiceLineRN."Education Level")) = 0 then
                            ZvanjeVodja += format(ServiceLineRN."Education Level") + ', ';
                        SatiOVodja += ServiceLineRN.Quantity;
                        UnitVodja := ServiceLineRN."Unit of Measure Code";
                    until ServiceLineRN.Next() = 0;

                if StrLen(VodjaGrupe) > 2 then
                    VodjaGrupe := copystr(VodjaGrupe, 1, StrLen(VodjaGrupe) - 2);
                if StrLen(ZvanjeVodja) > 2 then
                    ZvanjeVodja := copystr(ZvanjeVodja, 1, StrLen(ZvanjeVodja) - 2);

                SatiOVodja := 0;
                SatiSnimanjeVodja := 0;
                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type", '%1', ServiceLineRN."Request Resource Type"::"Team Leader");
                if ServiceLineRN.FindSet() then
                    repeat
                        //   if ServiceLineRN.Intent = ServiceLineRN.Intent::Routing then
                        if ServiceLineRN.Intent IN [ServiceLineRN.Intent::Routing, ServiceLineRN.Intent::Marking] then
                            SatiOVodja += ServiceLineRN.Quantity
                        else
                            SatiSnimanjeVodja += ServiceLineRN.Quantity;

                    until ServiceLineRN.Next() = 0;





                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type", '%1', ServiceLineRN."Request Resource Type"::Operator);
                if ServiceLineRN.FindSet() then
                    repeat
                        if StrPos(Operator, ServiceLineRN."Resource Name") = 0 then
                            Operator += ServiceLineRN."Resource Name" + ', ';
                        if StrPos(ZvanjeOperater, format(ServiceLineRN."Education Level")) = 0 then
                            ZvanjeOperater += format(ServiceLineRN."Education Level") + ', ';
                    //     SatiOperatorO += ServiceLine.Quantity;
                    until ServiceLineRN.Next() = 0;

                if StrLen(Operator) > 2 then
                    Operator := copystr(Operator, 1, StrLen(Operator) - 2);

                if StrLen(ZvanjeOperater) > 2 then
                    ZvanjeOperater := copystr(ZvanjeOperater, 1, StrLen(ZvanjeOperater) - 2);



                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type", '%1', ServiceLineRN."Request Resource Type"::Operator);
                if ServiceLineRN.FindSet() then
                    repeat
                        //   if ServiceLineRN.Intent = ServiceLineRN.Intent::Routing then
                        if ServiceLineRN.Intent IN [ServiceLineRN.Intent::Routing, ServiceLineRN.Intent::Marking] then
                            SatiOperatorO += ServiceLineRN.Quantity
                        else
                            SatiOperatorSnimanje += ServiceLineRN.Quantity;
                        UnitOp := ServiceLineRN."Unit of Measure Code";

                    until ServiceLineRN.Next() = 0;



                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type", '%1', ServiceLineRN."Request Resource Type"::Chainhand);
                if ServiceLineRN.FindSet() then
                    repeat
                        if StrPos(Figurant1, ServiceLineRN."Resource Name") = 0 then
                            Figurant1 += ServiceLineRN."Resource Name" + ', ';

                        if StrPos(FigurantZvanje, format(ServiceLineRN."Education Level")) = 0 then
                            FigurantZvanje += format(ServiceLineRN."Education Level") + ', ';
                    //  SatiFigurantO += ServiceLine.Quantity;
                    until ServiceLineRN.Next() = 0;

                if StrLen(Figurant1) > 2 then
                    Figurant1 := copystr(Figurant1, 1, StrLen(Figurant1) - 2);
                if StrLen(FigurantZvanje) > 2 then
                    FigurantZvanje := CopyStr(FigurantZvanje, 1, StrLen(FigurantZvanje) - 2);


                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type", '%1', ServiceLineRN."Request Resource Type"::Chainhand);
                if ServiceLineRN.FindSet() then
                    repeat
                        //  if ServiceLineRN.Intent = ServiceLineRN.Intent::Routing then
                        if ServiceLineRN.Intent IN [ServiceLineRN.Intent::Routing, ServiceLineRN.Intent::Marking] then
                            SatiFigurantO += ServiceLineRN.Quantity
                        else
                            SatiFiguratnS += ServiceLineRN.Quantity;
                        UnitF1 := ServiceLineRN."Unit of Measure Code";

                    until ServiceLineRN.Next() = 0;



                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type", '%1', ServiceLineRN."Request Resource Type"::Chainhand2);
                if ServiceLineRN.FindSet() then
                    repeat
                        if StrPos(Figurant2, ServiceLineRN."Resource Name") = 0 then
                            Figurant2 += ServiceLineRN."Resource Name" + ', ';

                        if StrPos(Figurant2Zvanje, format(ServiceLineRN."Education Level")) = 0 then
                            Figurant2Zvanje += format(ServiceLineRN."Education Level") + ', ';
                    //    SatiFigurant2O += ServiceLine.Quantity;
                    until ServiceLineRN.Next() = 0;

                if StrLen(Figurant2) > 2 then
                    Figurant2 := copystr(Figurant2, 1, StrLen(Figurant2) - 2);
                if StrLen(Figurant2Zvanje) > 2 then
                    FigurantZvanje := CopyStr(FigurantZvanje, 1, StrLen(FigurantZvanje) - 2);



                ServiceLineRN.reset;
                ServiceLineRN.SetFilter("Document No.", '%1', "Service Item Line"."Document No.");
                ServiceLineRN.SetFilter("Request Resource Type", '%1', ServiceLineRN."Request Resource Type"::Chainhand2);
                if ServiceLineRN.FindSet() then
                    repeat
                        // if ServiceLineRN.Intent = ServiceLineRN.Intent::Routing then
                        if ServiceLineRN.Intent IN [ServiceLineRN.Intent::Routing, ServiceLineRN.Intent::Marking] then
                            SatiFigurant2O += ServiceLineRN.Quantity
                        else
                            SatiFiguratn2S += ServiceLineRN.Quantity;
                        UnitF2 := ServiceLineRN."Unit of Measure Code";

                    until ServiceLineRN.Next() = 0;


            end;

            trigger OnPreDataItem()
            begin
                Comp.get;
                Comp.CalcFields(Picture);
                SILRowCounter := 0;
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
                        Visible = false;
                        //   TableRelation="Custom Report Layout".Description wher;

                        trigger OnDrillDown()
                        var
                            myInt: Integer;
                            CustomReportLayout: Record "Custom Report Layout";
                            ReportLayoutSelection: Record "Report Layout Selection";
                            CRLPage: Page "Custom Report Layouts";
                        begin
                            clear(CRLPage);
                            CustomReportLayout.reset;
                            CustomReportLayout.SetFilter("Report ID", '%1', 50184);
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
                        visible = false;
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
        CL.SetFilter("Report ID", '%1', 50184);
        if cl.FindFirst() then
            ReportLayout := cl.Description;

    end;

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        BrojacLjudi := 0;
    end;

    procedure GetNote(RecRef: RecordRef): Text
    var
        RecordLink: Record "Record Link";
        TypeHelper: Codeunit "Type Helper";
        Result: Text;
        RecLinkMngt: Codeunit "Record Link Management";
        NoteText: BigText;
        Snim: Text;
        InStr: InStream;
    begin
        Clear(RecordLink);
        Clear(Result);
        RecordLink.SetRange("Record ID", RecRef.RecordId);
        RecordLink.SetRange(Type, RecordLink.Type::Note);
        RecordLink.SetRange(Company, CompanyName);
        if RecordLink.FindSet() then
            repeat
                RecordLink.CalcFields(Note);
                Snim := RecLinkMngt.ReadNote(RecordLink);
                if strpos(Snim, 'Snimanje:') <> 0 then
                    Result += RecLinkMngt.ReadNote(RecordLink);
            until RecordLink.Next() = 0;
        exit(Result);
    end;

    procedure GetNoteTrasiranje(RecRef: RecordRef): Text
    var
        RecordLink: Record "Record Link";
        TypeHelper: Codeunit "Type Helper";
        Result: Text;
        RecLinkMngt: Codeunit "Record Link Management";
        NoteText: BigText;
        Snim: Text;
        InStr: InStream;
    begin
        Clear(RecordLink);
        Clear(Result);
        RecordLink.SetRange("Record ID", RecRef.RecordId);
        RecordLink.SetRange(Type, RecordLink.Type::Note);
        RecordLink.SetRange(Company, CompanyName);
        if RecordLink.FindSet() then
            repeat
                RecordLink.CalcFields(Note);
                Snim := RecLinkMngt.ReadNote(RecordLink);
                if strpos(Snim, 'Snimanje:') = 0 then
                    Result += RecLinkMngt.ReadNote(RecordLink);
            until RecordLink.Next() = 0;
        exit(Result);
    end;


    procedure Numbers(String: Text[1000]) BrojRN: Integer
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

    local procedure FormatBooleanAsCheckbox(IsChecked: Boolean): Text
    begin
        if IsChecked then
            exit('[X]  ')
        else
            exit('[ ]  ');
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
        NedostaciRMS: Text[1000];
        NedostaciRMSNE: Text[1000];

        PlombaIspravnaDA: Text[1000];
        PlombaIspravnaNE: Text[1000];
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
        Investor: Text[1000];

        UnitVodja: Text[1000];

        CreateP: Text[1000];
        UserS: Record "User Setup";
        UnitOp: Text[1000];
        UnitF1: Text[1000];
        UnitF2: Text[1000];
        Ugovora: Text[1000];
        Narudzbenice: Text[1000];
        Zahtjeva: Text[1000];
        Tekuce: Text[1000];
        Inter: Text[1000];
        Plana: Text[1000];
        Korekt: Text[1000];
        InvesticionoOdr: Text[1000];


        ServiceLine: Record "Service Line";
        ServiceLineRN: Record "Service Line";
        ServiceItem: Record "Service Item";
        Gradevinac: Text[1000];
        Comp: Record "Company Information";
        SefRadilista: Text[1000];
        VodjaGrupe: Text[1000];
        Operator: Text[1000];

        Figurant1: Text[1000];

        Figurant2: Text[1000];
        pos: Integer;
        pos2: Integer;
        AddressMM: record "Service Item Line";
        result: Text[1000];
        RNConnection: Text[1000];

        IsNumeric: Boolean;
        ZvanjeVodja: Text[1000];
        ZvanjeOperater: Text[1000];
        FigurantZvanje: Text[1000];
        ReportLayout: Text[1000];
        BrojacLjudi: Integer;
        Figurant2Zvanje: Text[1000];
        GID: Record "Gas Installation Data";
        SatiOVodja: Decimal;
        SatiSnimanjeVodja: Decimal;
        CustLed: Record "Customer Ledger Entry";
        SatiOperatorO: Decimal;
        PPzGid: Text[1000];
        ChimneyGid: Text[1000];
        SatiOperatorSnimanje: Decimal;
        SatiFigurantO: Decimal;
        //   ServiceHeader: Record "Service Header";
        Cust: Record Customer;
        SatiFiguratnS: Decimal;
        SatiFigurant2O: Decimal;
        SatiFiguratn2S: Decimal;
        Zatecenouotvorenom: Text[1000];
        ZaptivenostDA: Text[1000];
        ZaptivenostNE: Text[1000];
        DetekcijaGasnihDA: Text[1000];
        Co2Da: Text[1000];
        Co2Ne: Text[1000];
        UGiStatusC: Text[1000];
        UGiStatusC1: Text[1000];
        UGiStatusC2: Text[1000];
        DetekcijaGasnihNE: Text[1000];
        SpojniElementiPlDA: Text[1000];
        SpojniElementiPlNE: Text[1000];
        RMSObjektDA: Text[1000];
        RMSObjektNE: Text[1000];
        PristupacanDA: Text[1000];
        VizuelniRMS: Text[1000];
        VizuelniRMSNE: Text[1000];

        SviOtvoreniDa: Text[1000];
        SviOtvoreniNE: Text[1000];
        RecordLinkeManagement: Codeunit "Record Link Management";


        Zatecenouozatvoreni: Text[1000];
        GasniAparatiSum: Text[1000];
        BrojRN: integer;
        ServiceConn: Record "Service Header";
        SchoolShort: enum "School - short";
        CZKRN: Text[1000];
        EvidentialDate: Date;
        EvidentialCode: COde[20];
        ReadingValueText1: Text[1000];
        StanjeNaBrojcanikuV: Text[1000];
        ProizvCorrector: Text[1000];
        ProizvRadioModule: Text[1000];

        GaugeSizeSRadioModule: Text[1000];
        GaugeSizeSC: Text[1000];
        SerialCorrector: Text[1000];
        SerialRadioModule: Text[1000];
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

        CZKReal: Text[1000];
        CZKControl: Text[1000];
        CZKVerif: Text[1000];
        EducationL: Text[1000];
        ZahtjevLastEE: Record "Service Item Line";
        GaugeF: record gauge;
        CorrecF: Record "El. Volume Corr";
        RadioMF: Record "Radio Module";
        RMSIskljucenDa: Text[1000];
        RMSPlombaSG: Text[1000];
        RMSLisca: Text[1000];
        RMSPlomba: Text[1000];
        IzvodjacBaremjedan: Text[1000];

        GAsIskljucen: Text[1000];
        GasPlombaSG: Text[1000];
        GasLisca: Text[1000];
        GasPlomba: Text[1000];
        TRImpulse: Decimal;
        ZahtjevLast: Record "Service Item Line";
        ZahtjevLastEEH: Record "Service Header";
        StatusMm: Text[1000];
        ZahtjevLastEEH2: Record "Service Header";
        ZahtjevLastH: Record "Service Header";
        ServiceHeaderAdd: record "Service Header";
        UgiPogonDa: Text[1000];
        UgiPogonNe: Text[1000];
        UgiPustena: Text[1000];
        StatusComp: Text[1000];
        StatusPar: Text[1000];
        StatusDue: Text[1000];
        DueDateStatus: Integer;
        StatusUnR: Text[1000];
        StatusOdg: Text[1000];
        StatusStorn: Text[1000];
        ReopenYes: Text[1000];
        ReopenNo: Text[1000];
        DueReopen: Integer;

        NoteText: Text;
        NoteTextBig: BigText;
        NoteSnimanje: Text;
        NoteTextTrasiranje: Text;

        NoteText2: bigtext;

        TypeHelper: Codeunit "Type Helper";
        DateOfRealisation: Text;
        RealisationDone: Text;
        YNRD: Text[3]; //YesNoRealisationDone
        VodjaGrupeReq: code[20];
        VizuelniGAS: Text[1000];
        VizuelniGASNE: Text[1000];
        SumOfServiceTotal: decimal;
        SumOfServiceTotalRes: decimal;
        RecommissioningCosts: Decimal;
        res: Record Resource;
        VATPostingSetup: Record "VAT Posting Setup";
        price, vat : Decimal;
        SILRowCounter: Integer;
        TextIspisTrenutno: text;
        TextIspisTrenutnoTras: text;
}