/*report 50079 "Selection by Month 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Selection by Month 2.rdlc';

    dataset
    {
        dataitem(DataItem1; "Posting")
        {
            column(No_Posting; DataItem1."No.")
            {
            }
            column(HiringManager_Posting; DataItem1."Hiring Manager")
            {
            }
            column(ContactPerson_Posting; DataItem1."Contact Person")
            {
            }
            column(NumberofCandidates_Posting; DataItem1."Number of Candidates")
            {
            }
            column(PublishedDate_Posting; DataItem1."Published Date")
            {
            }
            column(ClosingDate_Posting; DataItem1."Closing Date")
            {
            }
            column(Status_Posting; DataItem1.Status)
            {
            }
            column(Position_Posting; DataItem1.Position)
            {
            }
            column(Grade_Posting; DataItem1.Grade)
            {
            }
            column(RollCode_Posting; DataItem1."Roll Code")
            {
            }
            column(Benefits_Posting; DataItem1.Benefits)
            {
            }
            column(DepartmentName_Posting; DataItem1."Department Name")
            {
            }
            column(ManagementLevel_Posting; DataItem1."Management Level")
            {
            }
            column(NameoftheCompany_Posting; DataItem1."Name of the Company")
            {
            }
            column(NumberAppliedCandidates_Posting; DataItem1."Number Applied Candidates")
            {
            }
            column(DepartmentCode_Posting; DataItem1."Department Code")
            {
            }
            column(OrgStructure_Posting; DataItem1."Org. Structure")
            {
            }
            column(PositionCode_Posting; DataItem1."Position Code")
            {
            }
            column(OrgSheme_Posting; DataItem1."Org Sheme")
            {
            }
            column(EmploymentDate_Posting; DataItem1."Employment Date")
            {
            }
            column(AverageNumberOfDays; AverageNumberOfDays)
            {
            }
            column(DateTime; DateTime)
            {
            }
            column(UserName; UserName)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(Selection_Posting; DataItem1.Selection)
            {
            }

            trigger OnPreDataItem()
            begin
                DataItem1.SETFILTER("Published Date", '>=%1', DateFrom);
                DataItem1.SETFILTER("Closing Date", '<=%1', DateTo);
            end;
        }
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
                    field(Month; DateFrom)
                    {
                        ApplicationArea = all;
                        Caption = 'Date from';
                    }
                    field(Year; DateTo)
                    {
                        ApplicationArea = all;
                        Caption = 'Date to';
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
        LblNo = 'No';
        LblHiringManager = 'Hiring manager';
        LblContactPerson = 'Contact Person ';
        LblNumberofCandidates = 'Number of Candidates';
        LblPublishedDate = 'Published Date';
        LblEmploymentDate = 'Employment Date';
        LblClosingDate = 'Closing Date';
        LblStatus = 'Status';
        LblPosition = 'Position';
        LblGrade = 'Grade';
        LblRollCode = 'Roll Code';
        LblDepartmentName = 'Department Name';
        LblManagementLevel = 'Management Level';
        LblNameoftheCompany = 'Name of the Company';
        LblNumberAppliedCandidates = 'Number Applied Candidates';
        LblAverageValue = 'Average Value';
    }

    trigger OnPreReport()
    begin
        DateTime := CURRENTDATETIME;
        User.RESET;
        User.SETFILTER("User Name", '%1', USERID);
        IF User.FINDFIRST THEN
            UserName := User."Full Name";
        Filter := 'Filter: ' + FORMAT(DateFrom) + '. godine do ' + FORMAT(DateTo) + '. godine';
    end;

    var
        AverageNumberOfDays: Decimal;
        DateFrom: Date;
        DateTo: Date;
        DateTime: DateTime;
        UserName: Text;
        "Filter": Text;
        User: Record User;
}

*/