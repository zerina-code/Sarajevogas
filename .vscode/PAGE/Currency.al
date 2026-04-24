pageextension 50027 Currency extends Currencies
{
    layout
    {
        // Add changes to page layout here


    }




    actions
    {
        addafter("Adjust Exchange Rate")
        {
            action("Import Currency ER")
            {
                Caption = 'Import Currency ER';
                Image = ImportExport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = xmlport "Impor Currency Exchange Rate";

                trigger OnAction()
                begin
                    CurrPage.UPDATE;
                end;


            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin


    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //EMC1.0 end


    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin


    end;
}

