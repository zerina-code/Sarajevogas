/*page 50101 "Record Deletion"
{
    // version BCGOLIVE
    InsertAllowed = True; //Add records
    PageType = List;
    Editable = True;
    SourceTable = "Record Deletion Table";
    UsageCategory = Tasks;  //show in the Search Menù - "Record Deletion page"
    //AccessByPermission = page "Record Deletion" = X;  //permissions for Page
    //AccessByPermission = tabledata "Record Deletion Table" = RIMD; //ALL permissions for Table
    ApplicationArea = All;

    Caption = 'Record Deletion';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; "Table ID")
                {
                    ApplicationArea = All;
                    Caption = 'Table ID';
                    ToolTip = 'Insert table no. to Delete';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("START DELETE RECORDS")
            {
                Caption = 'START DELETE RECORDS';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    RecordDeletionMgt: Codeunit "Record Deletion Mgt.";
                begin
                    RecordDeletionMgt.DeleteRecords; //START DELETE RECORDS
                end;

            }
        }
    }
}

*/