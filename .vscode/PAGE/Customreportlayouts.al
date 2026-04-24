pageextension 50256 Customreportlayouts extends "Custom Report Layouts"
{
    layout
    {
        addafter("Company Name")
        {
            field("Customer Category"; "Customer Category")
            {
                ApplicationArea = all;
            }
            field("Request Type"; "Request Type") { }
        }
    }
    actions
    {

    }

}
