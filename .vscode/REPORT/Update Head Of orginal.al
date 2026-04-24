/*report 50106 "Update Head Of orginal"
{
    DefaultLayout = RDLC;
    //Đk
    RDLCLayout = './Update Head Of orginal.rdlc';

    dataset
    {
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
        OrgShema.RESET;
        OrgShema.SETFILTER(Status, '%1', OrgShema.Status::Active);
        IF OrgShema.FINDFIRST THEN BEGIN
            HeadOf.RESET;
            HeadOf.SETFILTER("Employee No.", '%1', '');
            HeadOf.SETFILTER("ORG Shema", '%1', OrgShema.Code);
            IF HeadOf.FINDSET THEN
                REPEAT
                    DimensionCopy.RESET;
                    DimensionCopy.SETFILTER("Sector  Description", '%1', HeadOf."Sector  Description");
                    DimensionCopy.SETFILTER("Department Categ.  Description", '%1', HeadOf."Department Categ.  Description");
                    DimensionCopy.SETFILTER("Group Description", '%1', HeadOf."Group Description");
                    DimensionCopy.SETFILTER("Team Description", '%1', HeadOf."Team Description");
                    DimensionCopy.SETFILTER("ORG Shema", '%1', HeadOf."ORG Shema");
                    IF DimensionCopy.FINDSET THEN
                        REPEAT

                            PositionMenuFind.RESET;
                            PositionMenuFind.SETFILTER("Management Level", '%1', HeadOf."Management Level");
                            PositionMenuFind.SETFILTER(Code, '%1', DimensionCopy."Position Code");
                            PositionMenuFind.SETFILTER(Description, '%1', DimensionCopy."Position Description");
                            PositionMenuFind.SETFILTER("Org. Structure", '%1', OrgShema.Code);
                            PositionMenuFind.SETCURRENTKEY(Code);
                            IF PositionMenuFind.FINDSET THEN BEGIN

                                ECLFind.RESET;
                                ECLFind.SETFILTER("Sector Description", '%1', HeadOf."Sector  Description");
                                ECLFind.SETFILTER("Department Cat. Description", '%1', HeadOf."Department Categ.  Description");
                                ECLFind.SETFILTER("Group Description", '%1', HeadOf."Group Description");
                                ECLFind.SETFILTER("Team Description", '%1', HeadOf."Team Description");

                                ECLFind.SETFILTER(Active, '%1', TRUE);
                                ECLFind.SETFILTER("Show Record", '%1', TRUE);
                                ECLFind.SETFILTER(Status, '%1', ECLFind.Status::Active);
                                ECLFind.SETFILTER("Position Code", '%1', PositionMenuFind.Code);
                                ECLFind.SETFILTER("Org. Structure", '%1', PositionMenuFind."Org. Structure");
                                IF ECLFind.FINDFIRST THEN BEGIN
                                    HeadOf."Position Code" := PositionMenuFind.Code;
                                    HeadOf.MODIFY;
                                END;

                                //Department Code,ORG Shema,Department Categ.  Description,Group Description,Team Description
                            END;

                        UNTIL DimensionCopy.NEXT = 0;
                UNTIL HeadOf.NEXT = 0;
        END;
    end;

    var
        DepartmentTemp: Record "Department";
        HeadCheck: Record "Head Of's";
        DimensionCopy: Record "Dimension for position";
        PositionMenuFind: Record "Position Menu";
        FindSek: Boolean;
        FindOdjel: Boolean;
        FindGrupa: Boolean;
        FindTim: Boolean;
        HeadOf: Record "Head Of's";
        OrgShema: Record "ORG Shema";
        HeaoffGet: Record "Head Of's";
        ECLFind: Record "Employee Contract Ledger";
}

*/