tableextension 50020 DimesionValueext extends "Dimension Value"
{
    fields
    {
        // Add changes to table fields here
        field(50327; "Cost Type"; Code[20])
        {
            TableRelation = "Cost Type";
        }
        field(50328; Type; Code[20])
        {
            // ĐK TableRelation = Type;
        }
        field(50331; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = ' ,A,N';
            OptionMembers = " ",A,N;
        }
        field(50332; "Entry Date"; Date)
        {
            Caption = 'Entry Date';
        }
        field(50333; "Update Date"; Date)
        {
        }
    }

    var
        myInt: Integer;
}