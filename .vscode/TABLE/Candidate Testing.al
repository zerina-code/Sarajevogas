/*table 50212 "Candidate Testing"
{
    Caption = 'Candidate Testing ';
    // DrillDownPageID = "Candidate Testing List";
    //LookupPageID = "Candidate Testing List";

    fields
    {
        field(1; "Test Date"; Date)
        {
            Caption = 'Test Date';
        }
        field(2; "Test Type"; Option)
        {
            Caption = 'Test type';
            OptionCaption = ',PEPD,PROB,TEST TN,TEST PERSONALLY,ENGLISH TEST,EXPERT TEST,DAT BATERI,TEST EXCEL';
            OptionMembers = ,PEPD,PROB,"TEST TN","TEST PERSONALLY","ENGLISH TEST","EXPERT TEST","DAT BATERI","TEST EXCEL";
        }
        field(3; "Test Subtype"; Option)
        {
            Caption = 'Test Subtype';
            OptionCaption = ',Aptitude test,English test,BFQ,EPQ,CATEL 16P,IT Test,Expert test,Other';
            OptionMembers = ,"Aptitude test","English test",BFQ,EPQ,"CATEL 16P","IT Test","Expert test",Other;
        }
        field(4; "Evaluation of Testing"; Option)
        {
            Caption = 'Evaluation of Testing';
            OptionCaption = ',Below average,Lower average,higher average above average,appropriate profile for further selection, appropriate profile - for another job,not appropriate profile for bank,basic,average,active';
            OptionMembers = ,"Below average","Lower average","higher average above average","appropriate profile for further selection"," appropriate profile - for another job","not appropriate profile for bank",basic,"average",active;
        }
        field(5; "Serial Number"; Integer)
        {
            Caption = 'Serial number';
            TableRelation = Candidates."Serial Number";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; "Serial Number", "Test Date", "Test Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        CandidateTesting.RESET;
        CandidateTesting.SETFILTER("Serial Number", '%1', "Serial Number");
        IF CandidateTesting.COUNT() = 1 THEN BEGIN
            Candidates.RESET;
            Candidates.SETFILTER("Serial Number", '%1', "Serial Number");
            IF Candidates.FINDFIRST THEN BEGIN
                Candidates.Tested := 'NE';
                Candidates.MODIFY;
            END;
        END;
    end;

    trigger OnInsert()
    begin

        Candidates.RESET;
        Candidates.SETFILTER("Serial Number", '%1', "Serial Number");
        IF Candidates.FINDFIRST THEN BEGIN
            IF Candidates.Tested = 'NE' THEN BEGIN
                Candidates.Tested := 'DA';
                Candidates.MODIFY;
            END;
        END
    end;

    var
        Candidates: Record "Candidates";
        CandidateTesting: Record "Candidate Testing";
}

*/