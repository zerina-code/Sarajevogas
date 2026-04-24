report 50102 "ZR-OU-00-25-02"
{
    Caption = 'ZR-OU-00-25-02', Locked = true;
    DefaultLayout = Word;
    WordLayout = '.\.vscode\REPORT\WORD\ZR-OU-00-25-02.docx';
    dataset
    {
        dataitem(ServiceHeader; "Service Header")
        {
            column(No_; "No.")
            {

            }
            column(CZKR; "No.")
            {

            }
            column(RD; "Responsible Department")
            {

            }
            column(Name; Name)
            {

            }
            column(Street; Address)
            {

            }
            column(Municipality; "Municipality Name")
            {

            }
            column(City; City)
            {

            }
            column(Phone_No_; "Phone No.")
            {

            }
            column(CZKD; Format("Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {

            }
            column(Request_Due_Date; Format("Request Due Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {

            }
            column(Owner_St; "Owner Street Name")
            {

            }
            column(Owner_StNo; "Owner Street No.")
            {

            }
            column(Owner_Municipality_Name; "Owner Municipality Name")
            {

            }
            dataitem("Document Attachment"; "Document Attachment")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = SORTING("ID")
                                             ORDER(Ascending);

                column(Mandatory_Attachment_Type; "Mandatory Attachment Type")
                { }
                column(Brojac; Brojac) { }

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;

                begin
                    Brojac += 1;

                end;

            }

            dataitem("Service Comment Line"; "Service Comment Line")
            {

                DataItemLink = "No." = field("No.");

                column(Comment; Comment) { }
                column(ShowComment; ShowComment) { }


            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {

                field(ShowComment; ShowComment)
                {
                    Caption = 'ShowComment';
                }

            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        Brojac: Integer;
        ShowComment: Boolean;
}
