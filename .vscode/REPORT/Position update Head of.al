report 50059 "Position update head of's"
{
    Caption = 'Position update head of''s';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(DataItem1; Position)
        {

            trigger OnAfterGetRecord()
            begin
                OrgF.RESET;
                OrgF.SETFILTER(Status, '%1', OrgF.Status::Active);
                IF OrgF.FINDLAST THEN BEGIN
                    OrgC := OrgF.Code;
                END;

                OrgF.RESET;
                OrgF.SETFILTER(Status, '%1', OrgF.Status::Preparation);
                IF OrgF.FINDLAST THEN BEGIN
                    OrgP := OrgF.Code;
                END;


                posC.RESET;
                posC.SETFILTER("Employee No.", '%1', "Employee No.");
                posC.SETFILTER("Org. Structure", '%1', OrgC);
                posC.SETFILTER("Disc. Department Code", '<>%1', '');
                posC.SETFILTER("Active Position", '%1', TRUE);
                IF posC.FINDSET THEN
                    REPEAT
                        IF (posC."Disc. Department Code" <> '') AND (posC."Disc. Department Name" = '') THEN BEGIN
                            posC.VALIDATE("Disc. Department Code", posC."Disc. Department Code");
                            IF posC."Manager 1 Code" <> "Employee No." THEN
                                posC."Manager Is Employee" := FALSE
                            ELSE
                                posC."Manager Is Employee" := TRUE;
                            posC.MODIFY;
                        END
                        ELSE BEGIN
                            posC.VALIDATE("Disc. Department Name", posC."Disc. Department Name");
                            IF posC."Manager 1 Code" <> "Employee No." THEN
                                posC."Manager Is Employee" := FALSE
                            ELSE
                                posC."Manager Is Employee" := TRUE;
                            posC.MODIFY;
                        END;

                    UNTIL posC.NEXT = 0;



                posC.RESET;
                posC.SETFILTER("Employee No.", '%1', "Employee No.");
                posC.SETFILTER("Org. Structure", '%1', OrgP);
                posC.SETFILTER("Disc. Department Code", '<>%1', '');
                IF posC.FINDSET THEN
                    REPEAT
                        IF (posC."Disc. Department Code" <> '') AND (posC."Disc. Department Name" = '') THEN BEGIN
                            posC.VALIDATE("Disc. Department Code", posC."Disc. Department Code");
                            IF posC."Manager 1 Code" <> "Employee No." THEN
                                posC."Manager Is Employee" := FALSE
                            ELSE
                                posC."Manager Is Employee" := TRUE;
                            posC.MODIFY;

                        END
                        ELSE BEGIN
                            posC.VALIDATE("Disc. Department Name", posC."Disc. Department Name");
                            IF posC."Manager 1 Code" <> "Employee No." THEN
                                posC."Manager Is Employee" := FALSE
                            ELSE
                                posC."Manager Is Employee" := TRUE;
                            posC.MODIFY;

                        END;

                    UNTIL posC.NEXT = 0;

                /*posC.RESET;
                posC.SETFILTER("Employee No.",'%1',"Employee No.");
                posC.SETFILTER("Org. Structure",'%1',OrgC);
                posC.SETFILTER("Disc. Department Code",'%1','');
                IF posC.FINDSET THEN REPEAT
                  IF (posC."Management Level"='') OR posC."Management Level"=7 then BEGIN
                  Head.RESET;
                    Head.SETFILTER("ORG Shema",'%1',posC."Org. Structure");
                    Head.SETFILTER("Sector  Description",'%1',posC."Sector  Description");
                    Head.SETFILTER("Department Categ.  Description",'%1',posC."Department Categ.  Description");
                    Head.SETFILTER("Group Description",'%1',posC."Group Description");
                    Head.SETFILTER("Team Description",'%1',posC."Team Description");
                    IF Head.FINDFIRST THEN BEGIN
                      posC."Disc. Department Code":=Head
                
                
                
                UNTIL posC.NEXT=0;*/

            end;

            trigger OnPostDataItem()
            begin
                /*COMMIT;
                Report2.RUN;
                COMMIT;*/

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

    var
        Text000: Label 'It''s wrong code';
        OrgF: Record "ORG Shema";
        OrgC: Code[10];
        posC: Record "Position";
        OrgP: Code[10];
        Head: Record "Head Of's";
        Department: Record "Department";
    //  Report2: Report "303";
}

