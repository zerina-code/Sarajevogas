page 50050 "Update Position"
{
    Caption = 'Update Position';
    PageType = List;
    SourceTable = "Position Menu";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Official Translation"; "Official Translation")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                /*   field("Role Name"; "Role Name")
                   {
                       ApplicationArea = all;
                       Visible = false;
                   }*/
                field(Role; Role)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("BJF/GJF"; "BJF/GJF")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Management Level"; "Management Level")
                {
                    ApplicationArea = all;
                }
                field("Key Function"; "Key Function")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Control Function"; "Control Function")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Minimal Education Level"; "Minimal Education Level")
                {
                    Visible = false;

                }
                field(Grade; Grade)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Number of benefits"; "Number of benefits")
                {


                    Visible = false;


                    ApplicationArea = all;
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin

                        PositionBenefTable.RESET;
                        PositionBenefTable.SETFILTER("Position Code", Rec.Code);
                        PositionBenefTable.SETFILTER("Position Name", Description);
                        PositionBenefTable.SETFILTER("Org. Structure", rec."Org. Structure");
                        //   PositionBenefPage.SETTABLEVIEW(PositionBenefTable);
                        // PositionBenefPage.RUN;
                        CurrPage.UPDATE;

                    end;
                }
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = all;
                }
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Org. Structure"; "Org. Structure")
                {
                    ApplicationArea = all;
                }
                field(School; School)
                {
                    ApplicationArea = all;
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        UpdatePostTable.RESET;
                        UpdatePostTable.SETFILTER("Position Code", Rec.Code);
                        UpdatePostTable.SETFILTER("Position Name", Description);
                        UpdatePostTable.SETFILTER("Org Shema", rec."Org. Structure");
                        UpdatePositionPage.SETTABLEVIEW(UpdatePostTable);
                        UpdatePositionPage.RUN;
                        CurrPage.UPDATE;

                    end;

                }
                field("Position complexity"; "Position complexity")
                {
                    ApplicationArea = all;
                    Visible = IsWageAllowed;
                }
                field("Position Responsibility"; "Position Responsibility")
                {
                    ApplicationArea = all;
                    Visible = IsWageAllowed;
                }
                field("Workplace conditions"; "Workplace conditions")
                {
                    ApplicationArea = all;
                    Visible = IsWageAllowed;
                }
                field(Increment; Increment)
                {
                    ApplicationArea = ALL;
                    Visible = IsWageAllowed;
                }
                field("Position Coefficient for Wage"; "Position Coefficient for Wage")
                {
                    ApplicationArea = all;
                    // Editable = false;
                    Visible = IsWageAllowed;
                }
                field("Position Coefficient Director"; "Position Coefficient Director")
                {
                    ApplicationArea = all;
                    Visible = IsWageAllowed;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            /*   action("Job description")
               {
                   Caption = 'Job description';
                   Image = Job;
                   Promoted = true;
                   PromotedIsBig = true;
                   RunObject = Page "Job description";
                   RunPageLink = "Job position Code" = FIELD(Code), "Org Shema" = field("Org. Structure");
                   RunPageOnRec = false;


               }
   */
            /*ĐK action("Update Positions")
             {
                 Caption = 'Update Positions';
                 Image = "Report";
                 Promoted = true;
                 PromotedCategory = Process;
                 ApplicationArea = all;
                 PromotedIsBig = true;

                 trigger OnAction()
                 begin
                     IF NOT DimensionForReport.ISEMPTY THEN
                         DimensionForReport.DELETEALL;



                     DimensionCopy.RESET;
                     DimensionCopy.SETFILTER("Position Code", '%1', Rec.Code);
                     DimensionCopy.SETFILTER("Position Description", '%1', Rec.Description);
                     DimensionCopy.SETFILTER("ORG Shema", '%1', Rec."Org. Structure");
                     Department.RESET;
                     Department.SETFILTER(Code, '%1', Rec."Department Code");
                     Department.SETFILTER("ORG Shema", '%1', Rec."Org. Structure");
                     IF Department.FINDFIRST THEN
                         DimensionCopy.SETFILTER("Org Belongs", '%1', Department.Description);
                     IF DimensionCopy.FINDSET THEN
                         REPEAT
                             DimensionForReport.INIT;
                             DimensionForReport.TRANSFERFIELDS(DimensionCopy);
                             DimensionForReport.INSERT;
                         UNTIL DimensionCopy.NEXT = 0;
                     COMMIT;

                     IF NOT PositonBenefitsReport.ISEMPTY THEN
                         PositonBenefitsReport.DELETEALL;
                     BenefitsOrginal.RESET;
                     BenefitsOrginal.SETFILTER("Position Code", '%1', Rec.Code);
                     BenefitsOrginal.SETFILTER("Position Name", '%1', Rec.Description);
                     BenefitsOrginal.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                     IF BenefitsOrginal.FINDSET THEN
                         REPEAT
                             PositonBenefitsReport.INIT;
                             PositonBenefitsReport.TRANSFERFIELDS(BenefitsOrginal);
                             PositonBenefitsReport.INSERT;
                         UNTIL BenefitsOrginal.NEXT = 0;
                     COMMIT;

                     PositionMenuOrg.RESET;
                     PositionMenuOrg.SETFILTER(Code, '%1', Rec.Code);
                     PositionMenuOrg.SETFILTER(Description, '%1', Rec.Description);
                     PositionMenuOrg.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                     PositionMenuOrg.SETFILTER("Department Code", '%1', Rec."Department Code");
                     IF PositionMenuOrg.FINDFIRST THEN BEGIN
                         DimensionPos.RESET;
                         DimensionPos.SETFILTER("Position Code", '%1', Rec.Code);
                         DimensionPos.SETFILTER("Position Description", '%1', Rec.Description);
                         DimensionPos.SETFILTER("ORG Shema", '%1', Rec."Org. Structure");
                         Department.RESET;
                         Department.SETFILTER(Code, '%1', Rec."Department Code");
                         Department.SETFILTER("ORG Shema", '%1', Rec."Org. Structure");
                         IF Department.FINDFIRST THEN
                             DimensionPos.SETFILTER("Org Belongs", '%1', Department.Description);
                         IF DimensionPos.FIND('-') THEN
                             Troskovni := DimensionPos."Dimension  Name"
                         ELSE
                             Troskovni := '';
                         Department.RESET;
                         Department.SETFILTER(Code, '%1', Rec."Department Code");
                         Department.SETFILTER("ORG Shema", '%1', Rec."Org. Structure");
                         IF Department.FINDFIRST THEN
                             ReportActiveSys.SetParam(PositionMenuOrg.Code, PositionMenuOrg.Description, PositionMenuOrg.Grade, PositionMenuOrg."Role Name",
                            PositionMenuOrg."BJF/GJF", PositionMenuOrg."Control Function", PositionMenuOrg."Key Function", PositionMenuOrg."Management Level", PositionMenuOrg."Org. Structure",
                             Rec."Department Code", PositionMenuOrg."Official Translation", Troskovni, Department.Description);
                         ReportActiveSys.RUN;
                     END;
                 end;
             }*/
        }
    }

    trigger OnInit()
    var
        UTemp: Record "User Setup";
    begin
        UTemp.Reset();
        UTemp.SetFilter("User ID", '%1', UserId);
        if UTemp.FindFirst() then
            IsWageAllowed := UTemp."Wage Allowed";
    end;

    trigger OnOpenPage()
    begin
        OrgShema.RESET;
        OrgShema.SETFILTER(Status, '%1', 0);
        IF OrgShema.FINDLAST THEN BEGIN
            SETFILTER("Org. Structure", '%1', OrgShema.Code);
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
        OrgShema: Record "Org Shema";
        position: Record "Position";
        //    JobDesc: Record "Job description";
        // TC: Record "Training TC";
        OS: Record "Org Shema";
        pos: Record "Position";
        Pos2: Record "Position";
        posC: Record "Position";
        //R_Pos: Report "Position change";
        OldCode: Code[20];
        PositionNow: Record "Position";
        PositionStart: Record "Position";
        PositionMenu: Record "Position Menu";
        EmployeeContractLedger: Record "Employee Contract Ledger";
        pos1: Record "Position";
        posecl: Record "Position";
        PosCodeECL: Record "Position";
        EmployeeContractLedger1: Record "Employee Contract Ledger";
        PosCode: Record "Position";
        PosNew: Record "Position";
        PosCodeChange: Record "Position";
        DimensionForReport: Record "Dimension Pos for report";
        DimensionCopy: Record "Dimension for position";
        PositonBenefitsReport: Record "Position Benefits report";
        BenefitsOrginal: Record "Position Benefits";
        PositionMenuOrg: Record "Position Menu";
        // ReportActiveSys: Report "Active Systemization";
        DimensionPos: Record "Dimension for position";
        Troskovni: Text;
        DimensionForReport5: Record "Dimension for report";
        DimensionCopy5: Record "Dimension temporary";
        Department: Record "Department";
        UpdatePostTable: Record "Position Minimal Education";
        UpdatePositionPage: page "Positions Minimal Education";
        PositionBenefTable: Record "Position Benefits";
        IsWageAllowed: Boolean;
    //    PositionBenefPage: page "Position Benefits";
}

