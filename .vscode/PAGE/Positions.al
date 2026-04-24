page 50049 Positions
{
    Caption = 'Positions';
    DelayedInsert = true;
    PageType = List;
    SourceTable = Position;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin



                        PosCodeChange.RESET;
                        PosCodeChange.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                        PosCodeChange.SETFILTER("Changing Position", '%1', TRUE);
                        PosCodeChange.SETFILTER(Description, '%1', Rec.Description);
                        //posecl.SETFILTER(Description,'%1',Rec.Description);
                        IF PosCodeChange.FINDSET THEN
                            REPEAT
                                EmployeeContractLedger1.RESET;
                                EmployeeContractLedger1.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                                EmployeeContractLedger1.SETFILTER("Employee No.", '%1', PosCodeChange."Employee No.");
                                //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                                IF EmployeeContractLedger1.FIND('-') THEN BEGIN
                                    EmployeeContractLedger1."Position Code" := Rec.Code;
                                    EmployeeContractLedger1.MODIFY;
                                END;
                            UNTIL PosCodeChange.NEXT = 0;



                    end;
                }
                field("Position ID"; "Position ID")
                {
                    ApplicationArea = all;
                }
                field(Order; Order)
                {
                    ApplicationArea = all;
                }
                field("Org. Structure"; "Org. Structure")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Employee Full Name"; "Employee Full Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin

                        pos.RESET;
                        pos.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                        pos.SETFILTER("Changing Position", '%1', TRUE);
                        pos.SETFILTER(Code, '%1', Rec.Code);
                        // pos.SETFILTER(Description,'%1',xRec.Description);
                        pos.SETFILTER("Position ID", '<>%1', Rec."Position ID");
                        IF (pos."Will Be Changed Later" = FALSE) THEN BEGIN
                            IF pos.FIND('-') THEN
                                REPEAT
                                    IF pos.GET(pos.Code, pos."Position ID", pos."Org. Structure", pos.Description)
                                    THEN BEGIN
                                        pos.RENAME(pos.Code, pos."Position ID", pos."Org. Structure", Rec.Description);

                                        pos."Changing Position" := FALSE;
                                    END;
                                UNTIL pos.NEXT = 0;
                        END;
                        posecl.RESET;
                        posecl.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                        posecl.SETFILTER("Changing Position", '%1', TRUE);
                        posecl.SETFILTER(Code, '%1', Rec.Code);
                        //posecl.SETFILTER(Description,'%1',Rec.Description);
                        IF posecl.FINDSET THEN
                            REPEAT
                                EmployeeContractLedger.RESET;
                                EmployeeContractLedger.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                                EmployeeContractLedger.SETFILTER("Employee No.", '%1', posecl."Employee No.");
                                //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                                IF EmployeeContractLedger.FIND('-') THEN BEGIN
                                    EmployeeContractLedger."Position Description" := Rec.Description;
                                    EmployeeContractLedger.MODIFY;
                                END;
                            UNTIL posecl.NEXT = 0;




                    end;
                }





                field("Group Description"; "Group Description")
                {
                    ApplicationArea = all;
                }
                field("Group Code"; "Group Code")
                {
                    ApplicationArea = all;
                }
                field("Department Categ.  Description"; "Department Categ.  Description")
                {
                    ApplicationArea = all;
                }
                field("Department Category"; "Department Category")
                {
                    ApplicationArea = all;
                }
                field("Sector  Description"; "Sector  Description")
                {
                    ApplicationArea = all;
                }
                field(Sector; Sector)
                {
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = all;
                }
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = all;
                    Lookup = true;
                }



                field("Disc. Department Code"; "Disc. Department Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Disc. Department Name"; "Disc. Department Name")
                {
                    ApplicationArea = all;
                }
                field("Management Level"; "Management Level")
                {
                    ApplicationArea = all;
                }
                field("Manager 1 Code"; "Manager 1 Code")
                {
                    ApplicationArea = all;
                    Editable = true;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Manager 1 Full Name"; "Manager 1 Full Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Manager 1  Department Code"; "Manager 1  Department Code")
                {
                    ApplicationArea = all;
                    Caption = 'Manager Department Code';
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Manager 1 Position Code"; "Manager 1 Position Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Manager 1 Position ID"; "Manager 1 Position ID")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Manager 2 Code"; "Manager 2 Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Manager 2 Full Name"; "Manager 2 Full Name")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Manager 2  Department Code"; "Manager 2  Department Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Manager 2 Position Code"; "Manager 2 Position Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Manager 2 Position ID"; "Manager 2 Position ID")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field(Vocation; Vocation)
                {
                    ApplicationArea = all;
                }
                field("Vocation Description"; "Vocation Description")
                {
                    ApplicationArea = all;
                }


                field("Active Position"; "Active Position")
                {
                    ApplicationArea = all;
                }
                field("Manager Is Employee"; "Manager Is Employee")
                {
                    ApplicationArea = all;
                }
                field("PAy grade"; "PAy grade")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {


        }
    }

    actions
    {
        area(processing)
        {
            action("Job description")
            {
                Caption = 'Job description';
                Image = Job;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Job description";
                RunPageLink = "Job position Code" = FIELD(Code), "Org Shema" = field("Org. Structure");
                //   RunPageOnRec = false;


            }
            action("Training catalogue  -Position")
            {
                Caption = 'Training catalogue  -Position';
                Image = PersonInCharge;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /* TC.SETRANGE("Position Code",Code);
                     PAGE.RUN(PAGE::"Training catalogue-Position",TC);*/
                end;
            }
            action("Position Languages")
            {
                Image = Language;
                //ĐK RunObject = Page 50073;
                //ĐKRunPageLink = Field1=FIELD(Code);
            }
            action("Position Qualification")
            {
                Caption = 'Position Qualification';
                Image = QualificationOverview;
                //ĐK RunObject = Page 50074;
                //ĐK RunPageLink = Document No.=FIELD(Code);
            }
        }

    }
    trigger OnOpenPage()
    begin
        OrgShema.RESET;
        OrgShema.SETFILTER(Status, '%1', 0);
        IF OrgShema.FINDLAST THEN BEGIN
            SETFILTER("Org. Structure", '%1', OrgShema.Code);
            REPORT.RUNMODAL(50059, FALSE, TRUE);
        END;




    end;

    trigger OnAfterGetRecord()
    begin
        OrgShema.RESET;
        OrgShema.SETFILTER(Status, '%1', 0);
        IF OrgShema.FINDLAST THEN BEGIN
            SETFILTER("Org. Structure", '%1', OrgShema.Code);
        END;

    end;

    var
        /*  position: Record "50053";
          JobDesc: Record "50066";
          TC: Record ;
          */
        PosCodeChange: Record Position;
        EmployeeContractLedger1: Record "Employee Contract Ledger";
        pos: Record Position;
        posecl: Record Position;
        EmployeeContractLedger: Record "Employee Contract Ledger";
        OrgShema: Record "ORG Shema";
}

