page 50230 Logs
{
    Caption = 'Logs';
    Editable = false;
    PageType = List;
    SourceTable = Logs;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer Old"; "Customer Old") { }
                field("Customer New"; "Customer New") { }
                field("MM Old"; "MM Old") { }
                field("MM New"; "MM New") { }
                field(SystemCreatedAt; SystemCreatedAt) { }
                field(SystemCreatedBy; SystemCreatedBy) { }
            }
        }
    }








}