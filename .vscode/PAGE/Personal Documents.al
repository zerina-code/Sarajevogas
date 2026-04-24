page 50093 "Personal Documents"
{
    Caption = 'Personal Documents';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Personal Documents";
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
                    Editable = false;

                }
                field("Citizenship Option"; "Citizenship Option")
                {
                    ApplicationArea = all;
                    Visible = isVisibleCitizenshipOption;
                }
                field(Citizenship; Citizenship)
                {
                    ApplicationArea = all;
                    Visible = isVisibleCitizenship;
                    LookupPageId = "Citizenship Description";
                }
                field("Citizenship Description"; "Citizenship Description")
                {
                    ApplicationArea = all;
                    Visible = isVisibleCitizenship;
                }
                field("ID Card No."; "ID Card No.")
                {
                    ApplicationArea = all;
                    Visible = isVisibleIDCardNo;
                }
                field("Passport No."; "Passport No.")
                {
                    ApplicationArea = all;
                    Visible = isVisiblePassportNo;
                }
                field(Nationality; Nationality)
                {
                    ApplicationArea = all;
                    Visible = isVisibleNationality;
                }
                field("Nationality Description"; "Nationality Description")
                {
                    ApplicationArea = all;
                    Visible = isVisibleNationality;
                }
                field("Social Security No."; "Social Security No.")
                {
                    ApplicationArea = all;
                    Visible = isVisibleSocialSecurityNo;
                }
                field("Residence Permit"; "Residence Permit")
                {
                    ApplicationArea = all;
                    Visible = isVisibleResidencePermit;
                }
                field("Work Permit"; "Work Permit")
                {
                    ApplicationArea = all;
                    Visible = isVisibleWorkPermit;
                }
                field("Type Of Work Permit"; "Type Of Work Permit")
                {
                    ApplicationArea = all;
                    Visible = isVisibleWorkPermit;
                }
                field("Date From"; "Date From")
                {
                    ApplicationArea = all;
                }
                field("Date To"; "Date To")
                {
                    ApplicationArea = all;
                }

                field("Employee  First Name"; "Employee  First Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Employee Last Name"; "Employee Last Name")
                {
                    ApplicationArea = all;
                }
                field(Active; Active)
                {
                    ApplicationArea = all;
                }
                field("Team Name"; "Team Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Group Name"; "Group Name")
                {
                    ApplicationArea = all;
                }
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = all;
                }
                field("Sector Name"; "Sector Name")
                {
                    ApplicationArea = all;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = all;
                    Caption = 'Last Date Modified';
                }
                field(Switch; Switch)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        Filter := Rec.GETFILTER(Switch);

        IF (Filter = 'Citizenship') OR (Filter = 'Državljanstvo') THEN BEGIN
            isVisibleCitizenshipOption := TRUE;
            isVisibleCitizenship := TRUE;
            isVisibleIDCardNo := FALSE;
            isVisibleNationality := FALSE;
            isVisiblePassportNo := FALSE;
            isVisibleResidencePermit := FALSE;
            isVisibleSocialSecurityNo := FALSE;
            isVisibleWorkPermit := FALSE;
        END
        ELSE
            IF (Filter = 'Passport') OR (Filter = 'Pasoš') THEN BEGIN
                isVisibleCitizenshipOption := TRUE;
                isVisibleCitizenship := FALSE;
                isVisibleIDCardNo := FALSE;
                isVisibleNationality := FALSE;
                isVisiblePassportNo := TRUE;
                isVisibleResidencePermit := FALSE;
                isVisibleSocialSecurityNo := FALSE;
                isVisibleWorkPermit := FALSE;
            END
            ELSE
                IF (Filter = 'Social Security') OR (Filter = 'Socijalno osiguranje') THEN BEGIN
                    isVisibleCitizenshipOption := FALSE;
                    isVisibleCitizenship := FALSE;
                    isVisibleIDCardNo := FALSE;
                    isVisibleNationality := FALSE;
                    isVisiblePassportNo := FALSE;
                    isVisibleResidencePermit := FALSE;
                    isVisibleSocialSecurityNo := TRUE;
                    isVisibleWorkPermit := FALSE;
                END
                ELSE
                    IF (Filter = 'Residence Permit') OR (Filter = 'Boravišna dozvola') THEN BEGIN
                        isVisibleCitizenshipOption := FALSE;
                        isVisibleCitizenship := FALSE;
                        isVisibleIDCardNo := FALSE;
                        isVisibleNationality := FALSE;
                        isVisiblePassportNo := FALSE;
                        isVisibleResidencePermit := TRUE;
                        isVisibleSocialSecurityNo := FALSE;
                        isVisibleWorkPermit := FALSE;
                    END
                    ELSE
                        IF (Filter = 'Work Permit') OR (Filter = 'Radna dozvola') THEN BEGIN
                            isVisibleCitizenshipOption := FALSE;
                            isVisibleCitizenship := FALSE;
                            isVisibleIDCardNo := FALSE;
                            isVisibleNationality := FALSE;
                            isVisiblePassportNo := FALSE;
                            isVisibleResidencePermit := FALSE;
                            isVisibleSocialSecurityNo := FALSE;
                            isVisibleWorkPermit := TRUE;
                        END
                        ELSE
                            IF (Filter = 'IDCard') OR (Filter = 'Lična karta') THEN BEGIN
                                isVisibleCitizenshipOption := FALSE;
                                isVisibleCitizenship := FALSE;
                                isVisibleIDCardNo := TRUE;
                                isVisibleNationality := FALSE;
                                isVisiblePassportNo := FALSE;
                                isVisibleResidencePermit := FALSE;
                                isVisibleSocialSecurityNo := FALSE;
                                isVisibleWorkPermit := FALSE;
                            END
                            ELSE
                                IF (Filter = 'Nationality') OR (Filter = 'Nacionalnost') THEN BEGIN
                                    isVisibleCitizenshipOption := FALSE;
                                    isVisibleCitizenship := FALSE;
                                    isVisibleIDCardNo := FALSE;
                                    isVisibleNationality := TRUE;
                                    isVisiblePassportNo := FALSE;
                                    isVisibleResidencePermit := FALSE;
                                    isVisibleSocialSecurityNo := FALSE;
                                    isVisibleWorkPermit := FALSE;
                                END
                                ELSE BEGIN
                                    isVisibleCitizenshipOption := TRUE;
                                    isVisibleCitizenship := TRUE;
                                    isVisibleIDCardNo := TRUE;
                                    isVisibleNationality := TRUE;
                                    isVisiblePassportNo := TRUE;
                                    isVisibleResidencePermit := TRUE;
                                    isVisibleSocialSecurityNo := TRUE;
                                    isVisibleWorkPermit := TRUE;
                                END;
    end;

    var
        [InDataSet]
        isVisibleCitizenship: Boolean;
        [InDataSet]
        isVisibleNationality: Boolean;
        [InDataSet]
        isVisibleIDCardNo: Boolean;
        [InDataSet]
        isVisiblePassportNo: Boolean;
        [InDataSet]
        isVisibleSocialSecurityNo: Boolean;
        [InDataSet]
        isVisibleResidencePermit: Boolean;
        [InDataSet]
        isVisibleWorkPermit: Boolean;
        "Filter": Text;
        isVisibleCitizenshipOption: Boolean;
        "Personal Documents": Record "Personal Documents";
}

