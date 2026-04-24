report 50083 "Uslovi za odlazak u penziju"
{
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;

    dataset
    {
        dataitem(DataItem1; Employee)
        {
            column(Pager_Employee; Pager)
            {
            }
            column(EducationLevel_Employee; "Education Level")
            {
            }
            /*column(EducationLevelPU_Employee; Employee."Education Level PU")
            {
            }
            column(LevelofGraduation_Employee; Employee."Level of Graduation")
            {
            }*/
            column(No_Employee; "No.")
            {
            }
            column(FirstName_Employee; "First Name")
            {
            }
            column(LastName_Employee; "Last Name")
            {
            }/*
            column(NazivUOJ_Employee; Employee."Naziv UOJ")
            {
            }*/
            column(OrgjedPU_Employee; "Department Code")
            {
            }
            column(Year1_Employee; Year1)
            {
            }
            column(NazivOrgjedPU_Employee; "Department Name")
            {
            }
            column(Year2_Employee; "Year 2")
            {
            }
            column(Year3_Employee; Year3)
            {
            }
            column(Godina1; Godina1)
            {
            }
            column(Godina2; Godina2)
            {
            }
            column(Godina3; Godina3)
            {
            }
            column(Uslov; Uslov)
            {
            }
            column(DatumUslova; DatumUslova)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //provjeriti ima li uslov za staž
                datum := "Birth Date";
                //datum:=CALCDATE('-',TODAY);
                Uslov := '';
                temp1 := 0;


                IF "Birth Date" <> 0D THEN BEGIN
                    Starost := (TODAY - "Birth Date") / 365 DIV 1;
                    mjesecT := DATE2DMY(TODAY, 2);
                    mjesecR := DATE2DMY("Birth Date", 2);
                    UkupniDaniStaza := "Years of Experience" * 365 + "Months of Experience" * 30 + "Days of Experience";
                    razlikaDani := 40 * 365 - UkupniDaniStaza;
                    razlikaStarost := 65 * 365 - (TODAY - "Birth Date");

                END;




                IF (("Years of Experience" = 40)) THEN BEGIN
                    Year3 := TRUE;
                    "Retirement Condition" := 1;
                    MODIFY;
                END

                ELSE
                    IF (("Years of Experience" = 39) AND (Starost < 65) AND (razlikaDani < razlikaStarost)) THEN BEGIN
                        Year1 := TRUE;
                        "Retirement Condition" := 1;
                        MODIFY;

                    END

                    ELSE
                        IF ((Starost = 65) AND ("Years of Experience" >= 20)) THEN BEGIN
                            Year1 := TRUE;
                            DatumUslova := CALCDATE('<65Y>', "Birth Date");
                            "Retirement Condition" := 2;
                            MODIFY;
                        END
                        /*ELSE IF  ("Years of Experience" =36)    THEN BEGIN
                         Year4:=TRUE;
                        "Retirement Condition":=1;
                         MODIFY;

                        END  */

                        ELSE
                            IF ((Starost = 64) AND ("Years of Experience" >= 20)) THEN BEGIN
                                Year1 := TRUE;
                                DatumUslova := CALCDATE('<65Y>', "Birth Date");     //65
                                "Retirement Condition" := 2;
                                MODIFY;
                            END

                            ELSE
                                IF ((Starost = 64) AND ("Years of Experience" < 40)) THEN BEGIN
                                    Year1 := TRUE;
                                    "Retirement Condition" := 2;
                                    DatumUslova := CALCDATE('<65Y>', "Birth Date");
                                    MODIFY;

                                END
                                ELSE
                                    IF ("Years of Experience" = 38) THEN BEGIN
                                        Year1 := TRUE;
                                        "Retirement Condition" := 1;
                                        MODIFY;

                                    END
                                    ELSE
                                        IF ((Starost = 63) AND ("Years of Experience" < 40)) THEN BEGIN
                                            "Year 2" := TRUE;
                                            "Retirement Condition" := 2;
                                            DatumUslova := CALCDATE('<66Y>', "Birth Date");    //66
                                            MODIFY;

                                        END

                                        ELSE
                                            IF ("Years of Experience" = 37) THEN BEGIN
                                                "Year 2" := TRUE;
                                                "Retirement Condition" := 1;
                                                MODIFY;

                                            END

                                            ELSE
                                                IF ((Starost = 62) AND ("Years of Experience" < 40)) THEN BEGIN
                                                    Year3 := TRUE;
                                                    "Retirement Condition" := 2;
                                                    DatumUslova := CALCDATE('<67Y>', "Birth Date");      //67
                                                    MODIFY;

                                                END
                                                ELSE
                                                    IF ("Years of Experience" = 36) THEN BEGIN
                                                        Year3 := TRUE;
                                                        "Retirement Condition" := 1;
                                                        MODIFY;

                                                    END
                                                    ELSE
                                                        IF ((Starost = 61) AND ("Years of Experience" < 40)) THEN BEGIN
                                                            Year4 := TRUE;
                                                            "Retirement Condition" := 2;
                                                            DatumUslova := CALCDATE('<68Y>', "Birth Date");    //68
                                                            MODIFY;

                                                        END

                                                        ELSE
                                                            IF ("Years of Experience" = 35) THEN BEGIN
                                                                Year4 := TRUE;
                                                                "Retirement Condition" := 1;
                                                                MODIFY;

                                                            END;
                //IF "No."= 'ZAPL00197' THEN MESSAGE(FORMAT(Starost));
                //IF ((Year1=FALSE) OR (Year2=FALSE)) THEN
                //CurrReport.SKIP;
                IF Year1 = TRUE THEN BEGIN
                    "Year 2" := FALSE;
                    Year3 := FALSE;
                    Year4 := FALSE;
                END
                ELSE
                    IF (("Year 2" = TRUE) AND (Year1 = FALSE)) THEN BEGIN
                        Year3 := FALSE;
                        Year4 := FALSE;
                    END
                    ELSE
                        IF ((Year3 = TRUE) AND (Year1 = FALSE)) THEN BEGIN
                            "Year 2" := FALSE;
                            Year4 := FALSE;
                        END
                        ELSE
                            IF ((Year4 = TRUE) AND (Year1 = FALSE)) THEN
                                Year3 := FALSE;
                // EK zak. "Year 2" := FALSE;
                MODIFY;

                //ako je uslov za penziju staž datum sticanja uslova je datum na koji se dodaje staž i gleda na koji dan će napuniti 40 godina staža
                //gleda se i uslov da u naredne 3 godine se stiče uslov za penziju
                IF (((Year1 = TRUE) OR ("Year 2" = TRUE) OR (Year3 = TRUE) OR (Year4 = TRUE)) AND ("Retirement Condition" = 1)) THEN BEGIN
                    "Retirement Date" := 0D;
                    MODIFY;
                    temp1 := 0;
                    UkupniDaniStaza := "Years of Experience" * 365 + "Months of Experience" * 30 + "Days of Experience";
                    razlikaDani := 40 * 365 - UkupniDaniStaza;
                    temp1 += razlikaDani;
                    IF temp1 <= 0 THEN BEGIN
                        temp := razlikaDani;

                        "Retirement Date" := CALCDATE('<' + FORMAT(razlikaDani) + 'D>', TODAY);
                        //Pager:=FORMAT(DATE2DMY("Retirement Date",2));
                        MODIFY;
                    END

                    ELSE
                        IF temp1 > 0 THEN BEGIN
                            REPEAT
                                IF temp1 > 9999 THEN BEGIN
                                    MESSAGE('%1', temp1);
                                    broj := 9999;
                                    temp := razlikaDani - broj;
                                    razlikaDani := razlikaDani - temp;
                                    temp1 := temp;
                                    IF "Retirement Date" = 0D THEN BEGIN
                                        "Retirement Date" := CALCDATE('<' + FORMAT(temp) + 'D>', TODAY);
                                        Pager := FORMAT(DATE2DMY("Retirement Date", 2));
                                        // "Retirement Condition":=1;    //novo
                                        MODIFY;
                                    END
                                    ELSE BEGIN
                                        "Retirement Date" := CALCDATE('<' + FORMAT(temp) + 'D>', "Retirement Date");
                                        Pager := FORMAT(DATE2DMY("Retirement Date", 2));
                                        //  "Retirement Condition":=1;    //novo
                                        MODIFY;
                                    END;
                                END
                                ELSE
                                    IF ((temp1 < 9999) OR (temp1 = 9999)) THEN BEGIN
                                        temp := razlikaDani;
                                        temp1 := 0;
                                        IF "Retirement Date" = 0D THEN BEGIN
                                            "Retirement Date" := CALCDATE('<' + FORMAT(temp) + 'D>', TODAY);
                                            Pager := FORMAT(DATE2DMY("Retirement Date", 2));
                                            //"Retirement Condition":=1; //novo
                                            MODIFY;
                                        END
                                        ELSE BEGIN
                                            "Retirement Date" := CALCDATE('<' + FORMAT(temp) + 'D>', "Retirement Date");
                                            Pager := FORMAT(DATE2DMY("Retirement Date", 2));
                                            //"Retirement Condition":=1;  //novo
                                            MODIFY;
                                        END;

                                    END;

                            UNTIL temp1 = 0;
                        END;
                END
                //ako je uslov za penziju godine života datum sticanja uslova je datum rođenja
                ELSE
                    IF (((Year1 = TRUE) OR ("Year 2" = TRUE) OR (Year3 = TRUE) OR (Year4 = TRUE)) AND ("Retirement Condition" = 2)) THEN BEGIN
                        "Retirement Date" := CALCDATE('<65Y>', "Birth Date");
                        Pager := FORMAT(DATE2DMY("Retirement Date", 2));
                        "Retirement Condition" := 2;
                        MODIFY;
                    END;

            end;

            trigger OnPreDataItem()
            begin
                //TODAY:=DMY2DATE(1,1,2015);
                Godina1 := DATE2DMY(TODAY, 3);
                Godina2 := DATE2DMY(TODAY, 3) + 1;
                Godina3 := DATE2DMY(TODAY, 3) + 2;
                Godina4 := DATE2DMY(TODAY, 3) + 3;
                Godina5 := DATE2DMY(TODAY, 3) + 4;
                SETFILTER(Status, '%1', 0);
                SetFilter("Birth Date", '<>%1', 0D);
                //TODAY:=DMY2DATE('<01>',1);
                //TODAY:=DMY2DATE('<01>',2);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        EmployeeRec.SETFILTER("No.", '<>%1', '');
        IF EmployeeRec.FINDFIRST THEN BEGIN
            REPEAT
                EmployeeRec.Year1 := FALSE;
                EmployeeRec."Year 2" := FALSE;
                EmployeeRec.Year3 := FALSE;
                EmployeeRec."Retirement Condition" := 0;
                EmployeeRec."Retirement Date" := 0D;
                EmployeeRec.MODIFY;
            UNTIL EmployeeRec.NEXT = 0;
        END;
    end;

    var
        TODAY1: Date;
        Godina1: Integer;
        Godina2: Integer;
        Godina3: Integer;
        Starost: Integer;
        datum: Date;
        mjesecT: Integer;
        mjesecR: Integer;
        Uslov: Text;
        DatumUslova: Date;
        EmployeeRec: Record Employee;
        UkupniDaniStaza: Integer;
        razlikaDani: Integer;
        temp: Integer;
        temp1: Integer;
        broj: Integer;
        razlikaStarost: Integer;
        Godina4: Integer;
        Godina5: Integer;
        EmployeeC: Record "Employee Contract Ledger";
}

