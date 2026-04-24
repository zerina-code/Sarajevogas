pageextension 50257 GLRegisters extends "G/L Registers"

{


    layout
    {

    }
    actions
    {
        modify("G/L Register") { Visible = false; }
        addafter("Trial Balance by Period")
        {
            action(GLRegister)
            {
                ApplicationArea = Suite;
                Caption = 'G/L Register';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "GLRegisterNew";
                ToolTip = 'View posted G/L entries.';
            }
        }
    }



    var
        myInt: Integer;
}