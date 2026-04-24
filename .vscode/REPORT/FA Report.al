report 50117 "FA Report"
{
    PreviewMode = Normal;

    //ED

    dataset
    {
        dataitem(DataItem1; "FA Depreciation Book")
        {
            trigger OnAfterGetRecord()
            begin
                /* if DataItem1."Depreciation Starting Date" = OldDate then begin
                     DataItem1."Depreciation Starting Date" := NewDate;
                     DataItem1.Modify();
                 end;*/
                DataItem1."Depreciation Starting Date" := NewDate;
                DataItem1.Modify();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(OldDate; OldDate)
                {
                    Caption = 'Stari datum';
                }
                field(NewDate; NewDate)
                {
                    Caption = 'Novi datum';
                }
            }
        }
    }

    var
        NewDate: Date;
        OldDate: Date;
}

