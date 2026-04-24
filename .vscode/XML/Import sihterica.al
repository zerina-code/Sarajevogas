xmlport 50035 "Import sihterica"
{
    Caption = 'Uvoz satnica';
    Direction = Import;
    FieldDelimiter = 'None';
    FieldSeparator = ';';
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("Employee"; "Employee")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'EmployeeAbsence';
                UseTemporary = false;
                textelement(EmpNo)
                {
                    MinOccurs = Zero;
                }
                textelement(Name)
                {
                    MinOccurs = Zero;
                }

                textelement(AbsCode4)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode5)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode6)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode7)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode8)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode9)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode10)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode11)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode12)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode13)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode14)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode15)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode16)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode17)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode18)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode19)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode20)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode21)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode22)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode23)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode24)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode25)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode26)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode27)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode28)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode29)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode30)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode31)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode32)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode33)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode34)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode35)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode36)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode37)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode38)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode39)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode40)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode41)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode42)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode43)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode44)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode45)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode46)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode47)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode48)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode49)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode50)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode51)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode52)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode53)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode54)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode55)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode56)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode57)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode58)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode59)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode60)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode61)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode62)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode63)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode64)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode65)
                {
                    MinOccurs = Zero;
                }







                trigger OnAfterInsertRecord()
                begin
                    lineno += 1;

                    IF lineno = 3
                    THEN
                        monthYCode := CopyStr(Name, 8, strlen(Name));

                    IF lineno = 4
              THEN begin
                        yearCode := CopyStr(Name, 8, strlen(Name));
                        evaluate(year, yearCode);
                    end;


                    if strpos(monthYCode, 'Januar') <> 0 then
                        mjesec := 1;
                    if strpos(monthYCode, 'Februar') <> 0 then
                        mjesec := 2;
                    if strpos(monthYCode, 'Mart') <> 0 then
                        mjesec := 3;
                    if strpos(monthYCode, 'April') <> 0 then
                        mjesec := 4;
                    if strpos(monthYCode, 'Maj') <> 0 then
                        mjesec := 5;
                    if strpos(monthYCode, 'Juni') <> 0 then
                        mjesec := 6;
                    if strpos(monthYCode, 'Juli') <> 0 then
                        mjesec := 7;
                    if strpos(monthYCode, 'August') <> 0 then
                        mjesec := 8;
                    if strpos(monthYCode, 'Septembar') <> 0 then
                        mjesec := 9;
                    if strpos(monthYCode, 'Oktobar') <> 0 then
                        mjesec := 10;
                    if strpos(monthYCode, 'Novembar') <> 0 then
                        mjesec := 11;
                    if strpos(monthYCode, 'Decembar') <> 0 then
                        mjesec := 12;

                    monthYCode := format(mjesec) + '.' + Format(year);


                    IF NOT ((COPYSTR(EmpNo, 1, 1) = '1') OR (COPYSTR(EmpNo, 1, 1) = '2') OR (COPYSTR(EmpNo, 1, 1) = '3') OR (COPYSTR(EmpNo, 1, 1) = '4') OR (COPYSTR(EmpNo, 1, 1) = '5')
                      OR (COPYSTR(EmpNo, 1, 1) = '6') OR (COPYSTR(EmpNo, 1, 1) = '7') OR (COPYSTR(EmpNo, 1, 1) = '8') OR (COPYSTR(EmpNo, 1, 1) = '9')) THEN
                        currXMLport.SKIP
                    else
                        Brojaccc := 1;





                    BEGIN
                        FOR i := 4 TO 139 DO BEGIN



                            CASE i OF

                                4:
                                    IF (AbsCode4 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode4 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode4);
                                            if Evaluate(Preko, AbsCode4) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode4 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                5:
                                    IF (AbsCode5 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF

(AbsCode5 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode5);
                                            if Evaluate(Preko, AbsCode5) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode5 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                6:
                                    IF (AbsCode6 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode6 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode6);
                                            if Evaluate(Preko, AbsCode6) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode6 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                7:
                                    IF (AbsCode7 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode7 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode7);
                                            if Evaluate(Preko, AbsCode7) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode7 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                8:
                                    IF (AbsCode8 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode8 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode8);
                                            if Evaluate(Preko, AbsCode8) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode8 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                9:
                                    IF (AbsCode9 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode9 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode9);
                                            if Evaluate(Preko, AbsCode9) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode9 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;

                                10:
                                    IF (AbsCode10 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode10 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode10);
                                            if Evaluate(Preko, AbsCode10) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode10 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                11:
                                    IF (AbsCode11 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode11 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode11);
                                            if Evaluate(Preko, AbsCode11) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode11 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                12:
                                    IF (AbsCode12 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode12 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode12);
                                            if Evaluate(Preko, AbsCode12) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode12 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                13:
                                    IF (AbsCode13 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode13 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode13);
                                            if Evaluate(Preko, AbsCode13) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode13 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                14:
                                    IF (AbsCode14 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode14 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode14);
                                            if Evaluate(Preko, AbsCode14) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode14 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                15:
                                    IF (AbsCode15 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode15 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode15);
                                            if Evaluate(Preko, AbsCode15) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode15 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                16:
                                    IF (AbsCode16 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode16 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode16);
                                            if Evaluate(Preko, AbsCode16) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode16 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                17:
                                    IF (AbsCode17 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode17 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode17);
                                            if Evaluate(Preko, AbsCode17) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode17 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                18:
                                    IF (AbsCode18 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode18 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode18);
                                            if Evaluate(Preko, AbsCode18) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode18 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                19:
                                    IF (AbsCode19 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode19 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode19);
                                            if Evaluate(Preko, AbsCode19) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode19 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                20:
                                    IF (AbsCode20 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode20 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode20);
                                            if Evaluate(Preko, AbsCode20) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode20 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                21:
                                    IF (AbsCode21 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode21 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode21);
                                            if Evaluate(Preko, AbsCode21) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode21 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                22:
                                    IF (AbsCode22 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode22 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode22);
                                            if Evaluate(Preko, AbsCode22) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode22 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                23:
                                    IF (AbsCode23 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode23 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode23);
                                            if Evaluate(Preko, AbsCode23) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode23 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                24:
                                    IF (AbsCode24 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode24 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode24);
                                            if Evaluate(Preko, AbsCode24) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode24 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                25:
                                    IF (AbsCode25 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode25 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode25);
                                            if Evaluate(Preko, AbsCode25) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode25 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                26:
                                    IF (AbsCode26 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode26 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode26);
                                            if Evaluate(Preko, AbsCode26) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode26 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                27:
                                    IF (AbsCode27 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode27 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode27);
                                            if Evaluate(Preko, AbsCode27) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode27 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                28:
                                    IF (AbsCode28 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode28 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode28);
                                            if Evaluate(Preko, AbsCode28) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode28 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                29:
                                    IF (AbsCode29 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode29 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode29);
                                            if Evaluate(Preko, AbsCode29) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode29 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                30:
                                    IF (AbsCode30 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode30 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode30);
                                            if Evaluate(Preko, AbsCode30) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode30 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                31:
                                    IF (AbsCode31 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode31 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode31);
                                            if Evaluate(Preko, AbsCode31) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode31 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                32:
                                    IF (AbsCode32 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode32 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode32);
                                            if Evaluate(Preko, AbsCode32) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode32 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;

                                33:
                                    IF (AbsCode33 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode33 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode33);
                                            if Evaluate(Preko, AbsCode33) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode33 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;

                                34:
                                    IF (AbsCode34 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode34 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode34);
                                            if Evaluate(Preko, AbsCode34) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode34 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;

                                35:
                                    IF (AbsCode35 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode35 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode35);
                                            if Evaluate(Preko, AbsCode35) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode35 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                36:
                                    IF (AbsCode36 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode36 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode36);
                                            if Evaluate(Preko, AbsCode36) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode36 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                37:
                                    IF (AbsCode37 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode37 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode37);
                                            if Evaluate(Preko, AbsCode37) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode37 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                38:
                                    IF (AbsCode38 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode38 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode38);
                                            if Evaluate(Preko, AbsCode38) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode38 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                39:
                                    IF (AbsCode39 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode39 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode39);
                                            if Evaluate(Preko, AbsCode39) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode39 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                40:
                                    IF (AbsCode40 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode40 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode40);
                                            if Evaluate(Preko, AbsCode40) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode40 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                41:
                                    IF (AbsCode41 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode41 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode41);
                                            if Evaluate(Preko, AbsCode41) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode41 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                42:
                                    IF (AbsCode42 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode42 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode42);
                                            if Evaluate(Preko, AbsCode42) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode42 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                43:
                                    IF (AbsCode43 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode43 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode43);
                                            if Evaluate(Preko, AbsCode43) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode43 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                44:
                                    IF (AbsCode44 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode44 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode44);
                                            if Evaluate(Preko, AbsCode44) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode44 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                45:
                                    IF (AbsCode45 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode45 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode45);
                                            if Evaluate(Preko, AbsCode45) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode45 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                46:
                                    IF (AbsCode46 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode46 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode46);
                                            if Evaluate(Preko, AbsCode46) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode46 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                47:
                                    IF (AbsCode47 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode47 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode47);
                                            if Evaluate(Preko, AbsCode47) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode47 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                48:
                                    IF (AbsCode48 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode48 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode48);
                                            if Evaluate(Preko, AbsCode48) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode48 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                49:
                                    IF (AbsCode49 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode49 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode49);
                                            if Evaluate(Preko, AbsCode49) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode49 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                50:
                                    IF (AbsCode50 = '') THEN
                                        MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode50 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode50);
                                            if Evaluate(Preko, AbsCode50) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode50 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                51:

                                    IF
(AbsCode51 <> '') THEN BEGIN
                                        EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                        SetLinepr(AbsCode51);
                                        if Evaluate(Preko, AbsCode51) then begin
                                            Brojaccc := Brojaccc + 1;
                                        end
                                        else begin
                                            if AbsCode51 = '-' then
                                                Brojaccc := Brojaccc + 1;
                                        end;
                                    END;

                                52:

                                    IF
(AbsCode52 <> '') THEN BEGIN
                                        EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                        SetLinepr(AbsCode52);
                                        if Evaluate(Preko, AbsCode52) then begin
                                            Brojaccc := Brojaccc + 1;
                                        end
                                        else begin
                                            if AbsCode52 = '-' then
                                                Brojaccc := Brojaccc + 1;
                                        end;
                                    END;
                                53:
                                    IF (AbsCode53 = '') THEN
                                        Message('Polje nije uneseno u šihtaricama!') ELSE
                                        IF
(AbsCode53 <> '') THEN BEGIN
                                            EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                            SetLinepr(AbsCode53);
                                            if Evaluate(Preko, AbsCode53) then begin
                                                Brojaccc := Brojaccc + 1;
                                            end
                                            else begin
                                                if AbsCode53 = '-' then
                                                    Brojaccc := Brojaccc + 1;
                                            end;
                                        END;
                                54:

                                    IF
(AbsCode54 <> '') and (AbsCode54 <> '-') THEN BEGIN
                                        EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                        SetLinepr(AbsCode54);
                                        if Evaluate(Preko, AbsCode54) then begin
                                            Brojaccc := Brojaccc + 1;
                                        end
                                        else begin
                                            if AbsCode54 = '-' then
                                                Brojaccc := Brojaccc + 1;
                                        end;
                                    END;
                                55:

                                    IF
(AbsCode55 <> '') and (AbsCode55 <> '-') THEN BEGIN
                                        EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                        SetLinepr(AbsCode55);
                                        if Evaluate(Preko, AbsCode55) then begin
                                            Brojaccc := Brojaccc + 1;
                                        end
                                        else begin
                                            if AbsCode55 = '-' then
                                                Brojaccc := Brojaccc + 1;
                                        end;
                                    END;
                                56:
                                    // IF (AbsCode56 = '') THEN
                                    //   MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                    If (AbsCode56 <> '') and (AbsCode56 <> '-') THEN BEGIN
                                        EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                        SetLinepr(AbsCode56);
                                        if Evaluate(Preko, AbsCode56) then begin
                                            Brojaccc := Brojaccc + 1;
                                        end
                                        else begin
                                            if AbsCode56 = '-' then
                                                Brojaccc := Brojaccc + 1;
                                        end;
                                    END;
                                57:

                                    IF
                                    (AbsCode57 <> '') and (AbsCode57 <> '-') THEN BEGIN
                                        EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                        SetLinepr(AbsCode57);
                                        if Evaluate(Preko, AbsCode57) then begin
                                            Brojaccc := Brojaccc + 1;
                                        end
                                        else begin
                                            if AbsCode57 = '-' then
                                                Brojaccc := Brojaccc + 1;
                                        end;
                                    END;

                                58:
                                    IF (AbsCode58 <> '') and (AbsCode58 <> '-') THEN BEGIN
                                        EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                        SetLinepr(AbsCode58);
                                        if Evaluate(Preko, AbsCode58) then begin
                                            Brojaccc := Brojaccc + 1;
                                        end
                                        else begin
                                            if AbsCode58 = '-' then
                                                Brojaccc := Brojaccc + 1;
                                        end;
                                    END;
                                59:
                                    IF (AbsCode59 <> '') and (AbsCode59 <> '-') THEN BEGIN
                                        EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                        SetLinepr(AbsCode59);
                                        if Evaluate(Preko, AbsCode59) then begin
                                            Brojaccc := Brojaccc + 1;
                                        end
                                        else begin
                                            if AbsCode59 = '-' then
                                                Brojaccc := Brojaccc + 1;
                                        end;
                                    END;
                                60:
                                    IF (AbsCode60 <> '') and (AbsCode60 <> '-') THEN BEGIN
                                        EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                        SetLinepr(AbsCode60);
                                        if Evaluate(Preko, AbsCode60) then begin
                                            Brojaccc := Brojaccc + 1;
                                        end
                                        else begin
                                            if AbsCode60 = '-' then
                                                Brojaccc := Brojaccc + 1;
                                        end;
                                    END;
                                61:
                                    IF (AbsCode61 <> '') and (AbsCode61 <> '-') THEN BEGIN
                                        EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                        SetLinepr(AbsCode61);
                                        if Evaluate(Preko, AbsCode61) then begin
                                            Brojaccc := Brojaccc + 1;
                                        end
                                        else begin
                                            if AbsCode61 = '-' then
                                                Brojaccc := Brojaccc + 1;
                                        end;
                                    END;

                                62:
                                    IF (AbsCode62 <> '') and (AbsCode62 <> '-') THEN BEGIN
                                        EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                        SetLinepr(AbsCode62);
                                        if Evaluate(Preko, AbsCode62) then begin
                                            Brojaccc := Brojaccc + 1;
                                        end
                                        else begin
                                            if AbsCode62 = '-' then
                                                Brojaccc := Brojaccc + 1;
                                        end;
                                    END;
                                63:
                                    IF (AbsCode63 <> '') and (AbsCode63 <> '-') THEN BEGIN
                                        EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                        SetLinepr(AbsCode63);
                                        if Evaluate(Preko, AbsCode63) then begin
                                            Brojaccc := Brojaccc + 1;
                                        end
                                        else begin
                                            if AbsCode63 = '-' then
                                                Brojaccc := Brojaccc + 1;
                                        end;
                                    END;
                                64:
                                    IF (AbsCode64 <> '') and (AbsCode64 <> '-') THEN BEGIN
                                        EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                        SetLinepr(AbsCode64);
                                        if Evaluate(Preko, AbsCode64) then begin
                                            Brojaccc := Brojaccc + 1;
                                        end
                                        else begin
                                            if AbsCode64 = '-' then
                                                Brojaccc := Brojaccc + 1;
                                        end;
                                    END;
                                65:
                                    IF (AbsCode65 <> '') and (AbsCode65 <> '-') THEN BEGIN
                                        EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                        SetLinepr(AbsCode65);
                                        if Evaluate(Preko, AbsCode65) then begin
                                            Brojaccc := Brojaccc + 1;
                                        end
                                        else begin
                                            if AbsCode65 = '-' then
                                                Brojaccc := Brojaccc + 1;
                                        end;
                                    END;




                            /*      32:
                                      IF COPYSTR(EmpNo, 1, 5) <> 'SIFRA' THEN BEGIN
                                          IF NOT (AbsCode32 = '') THEN BEGIN
                                              IF (AbsCode32 = '') THEN
                                                  MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                                  IF
  (AbsCode32 <> '') THEN BEGIN
                                                      EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                                      SetLinepr(AbsCode32);
                                                  END;
                                          END;
                                      END;

                                  33:
                                      IF COPYSTR(EmpNo, 1, 5) <> 'SIFRA' THEN BEGIN
                                          IF NOT (AbsCode33 = '') THEN BEGIN
                                              IF (AbsCode33 = '') THEN
                                                  MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                                  IF
  (AbsCode33 <> '') THEN BEGIN
                                                      EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                                      SetLinepr(AbsCode33);
                                                  END;
                                          END;
                                      END;



                                  34:
                                      IF COPYSTR(EmpNo, 1, 5) <> 'SIFRA' THEN BEGIN
                                          IF NOT (AbsCode34 = '') THEN BEGIN
                                              IF (AbsCode34 = '') THEN
                                                  MESSAGE('Polje nije uneseno u šihtaricama!') ELSE
                                                  IF
  (AbsCode34 <> '') THEN BEGIN
                                                      EVALUATE(mydate, FORMAT(Brojaccc) + '.' + monthYCode);
                                                      SetLinepr(AbsCode34);
                                                  END;
                                          END;
                                      END;
                                  35:
                                      IF WS."Add. Columns" THEN BEGIN
                                          IF AbsCode35 <> '' THEN SetLinepr(AbsCode35) ELSE currXMLport.SKIP;
                                      END;
                                  36:
                                      IF WS."Add. Columns" THEN BEGIN
                                          IF AbsCode36 <> '' THEN SetLinepr(AbsCode36) ELSE currXMLport.SKIP;
                                      END;
                                  37:
                                      IF WS."Add. Columns" THEN BEGIN
                                          IF AbsCode37 <> '' THEN SetLinepr(AbsCode37) ELSE currXMLport.SKIP;
                                      END;*/

                            END;
                        END;
                    END;

                end;
            }
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

    trigger OnPostXmlPort()
    begin
        IF j <> 0 THEN
            MESSAGE('Import je završen!!!')
        //ELSE ERROR('Import je prekinut, provjerite da li importujete pravi file (*.csv)');
    end;

    trigger OnPreXmlPort()
    begin
        //HoursInDay:=8; //!!!!!!!!!!!!!!!!!!  ?????
        //WS.GET(WS."Overtime Code");
        k := 0;
    end;

    var
        EA: Record "Employee Absence";
        Brojaccc: Integer;
        Preko: Integer;
        emp: Record "Employee";
        Provjera: Boolean;
        SifraBr: Decimal;
        WS: Record "Wage Setup";
        mydate: Date;
        CA: Record "Cause of Absence";
        j: Integer;
        krm: Decimal;
        kp: Decimal;
        ExLine: Code[10];
        k: Decimal;
        month: Integer;
        year: Integer;
        HourPool: Decimal;
        AbsenceFill: Codeunit "Absence Fill";
        pomocni: Decimal;
        acc: Decimal;
        kol: Decimal;
        lineno: Integer;
        monthYCode: Text[30];
        i: Integer;
        yearCode: Text[50];
        mjesec: Integer;
        Text000: Label 'Satnica za ovaj mjesec je već uvezena.';

    procedure SetLinepr(ac: Text[20])
    var
        CauseOfAbsence: Record "Cause of Absence";
        employee: Record Employee;
        IntSum: Decimal;
    begin
        /*EA.SETFILTER("Employee No.",'%1', EmpNo);
        EA.SETFILTER("From Date",'%1', mydate);
        IF NOT EA.FIND('-') THEN */
        BEGIN
            if ac <> '-' then begin
                EA.INIT;

                EA."Employee No." := EmpNo;
                employee.get(EmpNo);
                EA.VALIDATE("Unit of Measure Code", 'SAT');
                EA.VALIDATE("Employee No.");
                if Evaluate(IntSum, ac) then begin
                    CauseOfAbsence.Reset();
                    CauseOfAbsence.SetFilter("Added To Hour Pool", '%1', true);
                    if CauseOfAbsence.FindFirst() then begin
                        EA."Cause of Absence Code" := CauseOfAbsence.Code;
                        EA.VALIDATE(Quantity, IntSum);
                        EA.VALIDATE("Quantity (Base)", IntSum);

                    end;
                end
                else begin
                    EA."Cause of Absence Code" := ac;
                    EA.VALIDATE(Quantity, employee."Hours In Day");
                    EA.VALIDATE("Quantity (Base)", employee."Hours In Day");
                end;

                EA."From Date" := mydate;
                EA."To Date" := mydate;


                CauseOfAbsence.reset;
                CauseOfAbsence.Get(Ea."Cause of Absence Code");
                EA."Short Code" := CauseOfAbsence."Short Code";
                Ea.Description := CauseOfAbsence.Description;

                EA."Cause of Absence Code Corr." := EA."Cause of Absence Code";
                ea."Short Code Corrections" := EA."Short Code";
                EA."Correction Quantity" := EA.Quantity;
                if EA."Cause of Absence Code" = 'G_1' then
                    Ea."Vacation from Year" := Date2DMY(mydate, 3);
                if EA."Cause of Absence Code" = 'G_2' then
                    Ea."Vacation from Year" := Date2DMY(mydate, 3) - 1;

                if (EA."Cause of Absence Code" <> '') and (EA.Quantity <> 0) then
                    EA.INSERT(TRUE);

                j := j + 1;

            END;
        end;
    end;

}

