report 50082 "Send Pay Lists via e-mail"
{
    Caption = 'Send Pay Lists via e-mail';
    ProcessingOnly = true;
    ShowPrintStatus = false;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Date and year")
                {
                    Caption = 'Month and year';
                    field(Month; Month)
                    {
                        Caption = 'Month';
                        ApplicationArea = all;
                    }
                    field(Year; Year)
                    {
                        Caption = 'Year';
                        ApplicationArea = all;
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

    trigger OnPostReport()
    begin
        MESSAGE(Text001);
    end;

    trigger OnPreReport()
    begin

        WH.RESET;
        WH.SETRANGE("Month Of Wage", Month);
        WH.SETRANGE("Year Of Wage", Year);

        IF NOT WH.FIND('-') THEN ERROR('Ne postoji obračun plata!');

        Calc.RESET;
        Calc.SETRANGE("Month Of Wage", Month);
        Calc.SETRANGE("Year of Wage", Year);
        Calc.SETFILTER("Send pay list", '%1', FALSE);
        IF Calc.FIND('-') THEN
            REPEAT
                CLEAR(R_PayList);
                CLEAR(FileManagement);
                CLEAR(Mail);

                T_Employee.RESET;
                T_Employee.SETFILTER("No.", Calc."Employee No.");

                T_Employee.FINDFIRST;
                IF T_Employee."Send PayList" = TRUE THEN BEGIN
                    WageSetup.GET;
                    R_PayList.SetPayList(Month, Year);
                    R_PayList.SETTABLEVIEW(T_Employee);
                    Clear(Recipients);
                    CLEAR(FileManagement);
                    //filename:='C:\Temp\PayList-'+T_Employee."First Name"+' '+T_Employee."Last Name"+'.pdf';
                    filename := WageSetup."Export Report Path" + T_Employee."First Name" + ' ' + T_Employee."Last Name" + '.pdf';
                    R_PayList.SAVEASPDF(filename);

                    PathDoc := Encription.CreatePdfWithPasswordForEmployee(filename, T_Employee, Month, Year);

                    FileManagement.DownloadToFile(filename, filename);

                    //ĐK  Encription.CreatePdfWithPasswordForEmployee(filename, T_Employee);

                    //T_Employee.CALCFIELDS("Company E-Mail");

                    SMTPSetup.GET;


                    Recipients.Add(T_Employee."Company E-Mail");
                    WageSetup.get();
                    SMTPMail.CreateMessage(WageSetup."Send Name e-mail", WageSetup."Send e-mail", Recipients, 'Platna lista ' + FORMAT(Month) + '.' + FORMAT(Year), '', TRUE);

                    filename := WageSetup."Export Report Path" + T_Employee."First Name" + ' ' + T_Employee."Last Name" + '.pdf';


                    SMTPMail.AddAttachment(PathDoc, T_Employee."First Name" + ' ' + T_Employee."Last Name" + '.pdf');
                    // SMTPMail.TrySend();
                    SMTPMail.Send();
                    Calc."Send pay list" := TRUE;
                    Calc.MODIFY;
                    ERASE(filename);

                END;


            UNTIL Calc.NEXT = 0;
    end;

    trigger OnInitReport()
    var
        WageAllowed: Boolean;
        UTemp: Record "User Setup";
        CU: Codeunit TestSubsCu;
    begin
        UTemp.Reset();
        UTemp.SetFilter("User ID", '%1', UserId);
        if UTemp.FindFirst() then
            WageAllowed := UTemp."Wage Allowed";

        if NOT WageAllowed then
            Error(CU.WagesNotAllowed());
    end;

    var
        Year: Integer;
        Month: Integer;
        //ĐK Encription: Codeunit EncryptPDF;
        Recipients: List of [Text];
        R_SendPayListByEmail: Report "Pay List Final";
        R_PayList: Report "Pay List Final";
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        Mail: Codeunit Mail;
        WH: Record "Wage Header";
        Calc: Record "Wage Calculation";
        FileManagement: Codeunit "File Management";
        T_Employee: Record "Employee";
        filename: Text;
        Text001: Label 'PayLists sent.';
        WageSetup: Record "Wage Setup";
        PathDoc: Text[1000];
        Encription: Codeunit EncryptPDF;

    local procedure CheckValidEmailAdress(var mail: Integer)
    begin

    end;
}

