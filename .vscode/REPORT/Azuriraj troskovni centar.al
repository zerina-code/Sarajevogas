/*report 50006 "Azuriraj troskovni centar"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Azuriraj troskovni centar.rdlc';

    dataset
    {
        dataitem(DataItem1; "Employee")
        {

            trigger OnAfterGetRecord()
            begin

                ECL.RESET;
                ECL.SETFILTER(Active, '%1', TRUE);
                ECL.SETFILTER("Show Record", '%1', TRUE);
                ECL.SETFILTER("Employee No.", '%1', "No.");
                //ECL.SETFILTER("Grounds for Term. Description",'%1','');
                ECL.SETFILTER("Ending Date", '%1|>=%2', 0D, WORKDATE);
                IF ECL.FINDFIRST THEN BEGIN

                    EmployeeDefaultDimension.RESET;
                    EmployeeDefaultDimension.SETFILTER("No.", '%1', "No.");
                    IF EmployeeDefaultDimension.FINDFIRST THEN
                        EmployeeDefaultDimension.DELETE;

                    EmployeeDefaultDimension.INIT;
                    EmployeeDefaultDimension."No." := "No.";
                    EmployeeDefaultDimension.VALIDATE("No.", "No.");
                    EmployeeDefaultDimension.VALIDATE("Dimension Code", 'TC');
                    EmployeeDefaultDimension."Amount Distribution Coeff." := 1;
                    DimensionForPosition.RESET;
                    DimensionForPosition.SETFILTER("Sector  Description", '%1', ECL."Sector Description");
                    DimensionForPosition.SETFILTER("Department Categ.  Description", '%1', ECL."Department Cat. Description");
                    DimensionForPosition.SETFILTER("Group Description", '%1', ECL."Group Description");
                    DimensionForPosition.SETFILTER("Team Description", '%1', ECL."Team Description");
                    DimensionForPosition.SETFILTER("ORG Shema", '%1', ECL."Org. Structure");
                    DimensionForPosition.SETFILTER("Position Description", '%1', ECL."Position Description");
                    IF DimensionForPosition.FINDFIRST THEN BEGIN
                        EmployeeDefaultDimension.VALIDATE("Dimension Value Code", DimensionForPosition."Dimension Value Code");
                        EmployeeDefaultDimension.INSERT;
                    END;
                END;
            end;

            trigger OnPostDataItem()
            begin
                EmployeeDefaultDimension.RESET;
                IF EmployeeDefaultDimension.FINDSET THEN
                    REPEAT
                        ECL.RESET;
                        ECL.SETFILTER("Employee No.", '%1', EmployeeDefaultDimension."No.");
                        ECL.SETFILTER(Active, '%1', TRUE);
                        ECL.SETFILTER("Show Record", '%1', TRUE);
                        //  ECL.SETFILTER("Grounds for Term. Description",'%1','');
                        ECL.SETFILTER("Ending Date", '%1|>=%2', 0D, WORKDATE);
                        IF ECL.FINDFIRST THEN BEGIN
                            DimensionForPos.RESET;
                            DimensionForPos.SETFILTER("Position Code", '%1', ECL."Position Code");
                            DimensionForPos.SETFILTER("Position Description", '%1', ECL."Position Description");
                            DimensionForPos.SETFILTER("Org Belongs", '%1', ECL."Department Name");
                            DimensionForPos.SETFILTER("Sector  Description", '%1', ECL."Sector Description");
                            DimensionForPos.SETFILTER("Department Categ.  Description", '%1', ECL."Department Cat. Description");
                            DimensionForPos.SETFILTER("Group Description", '%1', ECL."Group Description");
                            DimensionForPos.SETFILTER("Team Description", '%1', ECL."Team Description");
                            DimensionForPos.SETFILTER("ORG Shema", '%1', ECL."Org. Structure");
                            IF DimensionForPos.FINDFIRST THEN BEGIN
                                EmployeeDefaultDimension.VALIDATE("Dimension Value Code", DimensionForPos."Dimension Value Code");
                                EmployeeDefaultDimension.MODIFY;
                            END;
                        END;


                    UNTIL EmployeeDefaultDimension.NEXT = 0;

                OrgShema.RESET;
                OrgShema.SETFILTER(Status, '%1', OrgShema.Status::Active);
                IF OrgShema.FINDFIRST THEN BEGIN
                    DimensionForPosition.RESET;
                    DimensionForPosition.SETFILTER("ORG Shema", '%1', OrgShema.Code);
                    IF DimensionForPosition.FINDSET THEN
                        REPEAT
                            DimensionValue.RESET;
                            DimensionValue.SETFILTER("Dimension Code", '%1', 'TC');
                            DimensionValue.SETFILTER(Code, '%1', DimensionForPosition."Dimension Value Code");
                            DimensionValue.SETFILTER(Status, '%1', DimensionValue.Status::A);
                            IF DimensionValue.FINDFIRST THEN BEGIN
                                IF DimensionForPosition."Dimension  Name" <> DimensionValue.Name THEN BEGIN
                                    DimensionForPosition."Dimension  Name" := DimensionValue.Name;
                                    DimensionForPosition.MODIFY;
                                END;
                            END;


                        UNTIL DimensionForPosition.NEXT = 0;
                END;


                ECL.RESET;
                ECL.SETFILTER(Active, '%1', TRUE);
                ECL.SETFILTER("Show Record", '%1', TRUE);
                IF ECL.FINDSET THEN
                    REPEAT
                        PosBenef.RESET;
                        PosBenef.SETFILTER("Position Code", '%1', ECL."Position Code");
                        PosBenef.SETFILTER("Position Name", '%1', ECL."Position Description");
                        PosBenef.SETFILTER("Org. Structure", '%1', ECL."Org. Structure");
                        IF PosBenef.FINDSET THEN
                            REPEAT
                                mAI.RESET;
                                mAI.SETFILTER("Employee No.", '%1', ECL."Employee No.");
                                mAI.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', ECL."No.");
                                mAI.SETFILTER("Position Code", '%1', ECL."Position Code");
                                mAI.SETFILTER(Amount, '%1', PosBenef.Amount);
                                mAI.SETFILTER("Org Shema", '%1', ECL."Org. Structure");
                                mAI.SETFILTER("Misc. Article Code", '%1', PosBenef.Code);
                                IF NOT mAI.FINDFIRST THEN BEGIN
                                    mAI.INIT;
                                    mAI."Org Shema" := ECL."Org. Structure";
                                    mAI.VALIDATE("Employee No.", ECL."Employee No.");
                                    mAI.VALIDATE("Misc. Article Code", PosBenef.Code);
                                    mAI.Amount := PosBenef.Amount;
                                    mAI."From Date" := ECL."Starting Date";
                                    mAI."To Date" := ECL."Ending Date";
                                    mAI."Emp. Contract Ledg. Entry No." := ECL."No.";
                                    mAI."Position Code" := ECL."Position Code";
                                    mAI.INSERT;

                                END;


                            UNTIL PosBenef.NEXT = 0;


                    UNTIL ECL.NEXT = 0;



                DataItem1.RESET;
                DataItem1.SETFILTER(Status, '%1', DataItem1.Status::Active);
                IF DataItem1.FINDSET THEN
                    REPEAT
                        DataItem1."Termination Date" := 0D;
                        DataItem1.MODIFY;
                  

                    UNTIL DataItem1.NEXT = 0;

                Misc.RESET;
                Misc.SETFILTER(Active, '%1', TRUE);
                IF Misc.FINDSET THEN
                    REPEAT
                        ECL.RESET;
                        ECL.SETFILTER("Employee No.", '%1', Misc."Employee No.");
                        ECL.SETFILTER("No.", '%1', Misc."Emp. Contract Ledg. Entry No.");
                        ECL.SETFILTER("Org. Structure", '%1', Misc."Org Shema");
                        ECL.SETFILTER("Show Record", '%1', TRUE);
                        IF NOT ECL.FINDFIRST THEN
                            Misc.DELETE;
                    UNTIL Misc.NEXT = 0;
                Misc.RESET;
                Misc.SETFILTER(Active, '%1', TRUE);
                IF Misc.FINDSET THEN
                    REPEAT

                        ECL.RESET;
                        ECL.SETFILTER("Employee No.", '%1', Misc."Employee No.");
                        ECL.SETFILTER("No.", '%1', Misc."Emp. Contract Ledg. Entry No.");
                        ECL.SETFILTER("Org. Structure", '%1', Misc."Org Shema");
                        ECL.SETFILTER("Show Record", '%1', TRUE);
                        IF ECL.FINDFIRST THEN BEGIN
                            Misc."From Date" := ECL."Starting Date";
                            Misc."To Date" := ECL."Ending Date";
                            Misc.MODIFY;
                        END;
                    UNTIL Misc.NEXT = 0;

                PositionRec.RESET;
                PositionRec.SETFILTER(Role, '%1', '');
                IF PositionRec.FINDSET THEN
                    REPEAT
                        PositionMenu.RESET;
                        PositionMenu.SETFILTER(Code, '%1', PositionRec.Code);
                        PositionMenu.SETFILTER(Description, '%1', PositionRec.Description);
                        PositionMenu.SETFILTER("Org. Structure", '%1', PositionRec."Org. Structure");
                        PositionMenu.SETFILTER("Department Code", '%1', PositionRec."Department Code");
                        IF PositionMenu.FINDFIRST THEN BEGIN
                            PositionRec.VALIDATE("Role Name", PositionMenu."Role Name");
                            PositionRec.MODIFY;
                        END;
                    UNTIL PositionRec.NEXT = 0;

                PositionRec.RESET;
                PositionRec.SETFILTER("Active Position", '%1', TRUE);
                IF PositionRec.FINDSET THEN
                    REPEAT
                        PositionMenu.RESET;
                        PositionMenu.SETFILTER(Code, '%1', PositionRec.Code);
                        PositionMenu.SETFILTER(Description, '%1', PositionRec.Description);
                        PositionMenu.SETFILTER("Org. Structure", '%1', PositionRec."Org. Structure");
                        PositionMenu.SETFILTER("Department Code", '%1', PositionRec."Department Code");
                        IF PositionMenu.FINDFIRST THEN BEGIN
                            IF PositionMenu."Official Translation" <> PositionRec."Official Translation" THEN BEGIN
                                PositionRec."Official Translation" := PositionMenu."Official Translation";
                                PositionRec.MODIFY;
                            END;
                        END;
                    UNTIL PositionRec.NEXT = 0;

            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Default Dimension", '%1', '');
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

    trigger OnPostReport()
    begin

        Empty.RESET;
        Empty.SETFILTER("Default Dimension", '%1', '');
        IF Empty.FINDSET THEN
            REPEAT
                ECL.RESET;
                ECL.SETFILTER("Show Record", '%1', TRUE);
                ECL.SETFILTER("Employee No.", '%1', Empty."No.");
                ECL.SETFILTER("Starting Date", '<>%1', 0D);
                ECL.SETCURRENTKEY("Starting Date");
                ECL.ASCENDING;
                IF ECL.FINDLAST THEN BEGIN


                    EmployeeDefaultDimension.RESET;
                    EmployeeDefaultDimension.SETFILTER("No.", '%1', ECL."Employee No.");
                    IF EmployeeDefaultDimension.FINDFIRST THEN
                        EmployeeDefaultDimension.DELETE;

                    EmployeeDefaultDimension.INIT;
                    EmployeeDefaultDimension."No." := ECL."Employee No.";
                    EmployeeDefaultDimension.VALIDATE("No.", ECL."Employee No.");
                    EmployeeDefaultDimension.VALIDATE("Dimension Code", 'TC');
                    EmployeeDefaultDimension."Amount Distribution Coeff." := 1;
                    DimensionForPosition.RESET;
                    DimensionForPosition.SETFILTER("Sector  Description", '%1', ECL."Sector Description");
                    DimensionForPosition.SETFILTER("Department Categ.  Description", '%1', ECL."Department Cat. Description");
                    DimensionForPosition.SETFILTER("Group Description", '%1', ECL."Group Description");
                    DimensionForPosition.SETFILTER("Team Description", '%1', ECL."Team Description");
                    DimensionForPosition.SETFILTER("Position Description", '%1', ECL."Position Description");
                    DimensionForPosition.SETFILTER("ORG Shema", '%1', ECL."Org. Structure");
                    IF DimensionForPosition.FINDFIRST THEN BEGIN
                        //EmployeeDefaultDimension.VALIDATE("Dimension Value Code",DimensionForPosition."Dimension Value Code");
                        EmployeeDefaultDimension."Dimension Value Code" := DimensionForPosition."Dimension Value Code";
                        EmployeeDefaultDimension.INSERT;
                    END;
                END;


            UNTIL Empty.NEXT = 0;
    end;

    var
        emp: Record "Employee";
        NewValue: Text;
        Cap: Boolean;
        CurValue: Text;
        Indx: Integer;
        RecDate1: Record "Date";
        LastFoundDate1: Date;
        WPConnSetup: Record "Web portal connection setup";

        lvarActiveConnection: Variant;
        TempDate1: Date;
        // SQLConn: DotNet SqlConnection;
        ConnectionString: Text;
      
        Found1: Boolean;
        CountMonths1: Integer;
        DimensionForPos: Record "Dimension for position";
        CountDays1: Integer;
        ECL: Record "Employee Contract Ledger";
        WT: Option;
        Text: Label 'Brutto';
        bjf: Text;
        OrgDijelovi: Record "ORG Dijelovi";
        "B-1Rec": Record "Sector";
        "B-1WithRegions": Record "Department Category";
        Department2: Record "Department";
        brojac: Integer;
        PosI: Record "Position Menu temporary";
        PosMenu: Record "Position Menu";
        SectorR: Record "Sector";
        Positionirma: Record "Position";
        Municipality: Record "Municipality";
        PostCode: Record "Post Code";
        PosBenef: Record "Position Benefits";
        EmployeeRelative: Record "Employee Relative";
        AE: Record "Additional Education";
        String: Text;
        PositionRec: Record "Position";
        i: Integer;
        j: Integer;
        PositioneXE: Record "Position";
        POS: Record "Position Benefits";
        EmployeeR: Record "Employee";
        EmployeeContractLedger: Record "Employee Contract Ledger";
        EmployeeDefaultDimension: Record "Employee Default Dimension";
        DimensionForPosition: Record "Dimension for position";
        DepCat: Record "Department Category";
        GroupT: Record "Group";
        TeamT: Record "TeamT";
        DimensionOrginalPos: Record "Dimension for position";
        DimensionOrginalPos1: Record "Dimension for position";
        WB: Record "Work Booklet";
        PositionMenu: Record "Position Menu";
        RE: Record "Employee Benefits";
        AA: Record "Alternative Address";
        DimensionValue: Record "Dimension Value";
        Dimensiontem: Record "Dimension temporary";
        Dims: Record "Dimension temporary";
        DimensionValueTable: Record "Dimension Value";
        mAI: Record "Misc. article information new";
        OrgShema: Record "ORG Shema";
        Misc: Record "Misc. article information new";
        Empty: Record "Employee";

    
}

*/