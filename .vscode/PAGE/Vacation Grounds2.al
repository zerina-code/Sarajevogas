page 50132 "Vacation Grounds2"
{
    Caption = 'Vacation Ground 2';
    PageType = List;
    SourceTable = "Vacation Ground 2";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = all;
                }
                field("Position Name"; "Position Name")
                {
                    ApplicationArea = all;
                }
                field(Sector; Sector)
                {
                    ApplicationArea = all;
                }
                field("Legal Grounds"; "Legal Grounds")
                {
                    ApplicationArea = all;
                }
                field("Days based on Work experience"; "Days based on Work experience")
                {
                    ApplicationArea = all;
                }
                field("Based on Disabled Child"; "Based on Disabled Child")
                {
                    ApplicationArea = all;
                }
                field("Days based on Disability"; "Days based on Disability")
                {
                    ApplicationArea = all;
                }
                field(MotherWithMoreCH; MotherWithMoreCH)
                {
                    ApplicationArea = all;
                }
                field(Millitary; Millitary)
                {
                    ApplicationArea = all;
                }
                field(SingleParent; SingleParent)
                {
                    ApplicationArea = all;
                }
                field(SpecialCircumstances; SpecialCircumstances)
                {
                    ApplicationArea = all;
                }
                field("Number of days"; "Number of days")
                {
                    ApplicationArea = all;
                }
                field("Total days"; "Total days")
                {
                    ApplicationArea = all;
                }
                /*field("Used Days"; "Used Days")
                {


                }*/
                field("First Part"; "First Part")
                {

                }
                field(Year; Year)
                {
                    ApplicationArea = all;
                }
                field("Starting Date of I part"; "Starting Date of I part")
                {
                    ApplicationArea = all;
                }
                field("Ending Date of I part"; "Ending Date of I part")
                {
                    ApplicationArea = all;
                }
                field("Starting Date of II part"; "Starting Date of II part")
                {
                    ApplicationArea = all;
                }
                field("Ending Date of II part"; "Ending Date of II part")
                {
                    ApplicationArea = all;
                }
                field(Duration; Duration)
                {
                    ApplicationArea = all;
                }
                field("Manager contract"; "Manager contract")
                {
                    ApplicationArea = all;
                }
                field("Insert Date"; "Insert Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Vacation Calculation")
            {
                Caption = 'Vacation Calculation';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Vacation Calculation2";
            }
        }
    }
}

