page 50058 "Trainings Catalogue"
{

    Caption = 'Katalog treninga';
    PageType = List;
    SourceTable = "Training Catalogue";
    RefreshOnActivate = true;
    InsertAllowed = true;


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                    Editable = false;


                }
                field(Name; Name)
                { }
                field(TypeOF; TypeOF)
                {

                    trigger OnValidate()



                    begin
                        Trainingtype.Reset();
                        Trainingtype.SetFilter(Code, '%1', TypeOF);
                        if Trainingtype.FindFirst() then begin

                            "Type of name" := Trainingtype.Description;
                        end;

                    end;
                }
                field("Type of name"; "Type of name") { }
                field(Type; Type)
                {

                }
                //field(Location; Location) { }
                field(Month; Month) { }
                field(Year; Year)
                {

                }



            }
        }




    }
    actions
    {
        area(processing)
        {
            action("Training Time Entries")
            {
                Caption = 'Training Time Entries';
                ApplicationArea = all;
                Image = Hierarchy;
                PromotedIsBig = true;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    TTE: Record "Training Time Entry";
                    TTEPage: Page "Training Time Entries";
                begin
                    TTE.Reset();
                    TTE.SetFilter(Code2, '%1', Rec.Code);
                    TTEPage.SetTableView(TTE);
                    TTEPage.Run();

                end;

            }
        }
    }
    var
        Trainingtype: Record "Training Type";
}