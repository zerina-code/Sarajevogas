/*table 50066 "Employee Picture"
{
    Caption = 'Employee Picture';
    DrillDownPageID = 5202;
    LookupPageID = 5202;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Code';
            NotBlank = false;
            TableRelation = Employee;
        }
        field(2; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
     
        field(50010; Picture1; BLOB)
        {
            SubType = Bitmap;
        }
        field(50011; Picture2; BLOB)
        {
            SubType = Bitmap;
        }
        field(50013; Picture3; BLOB)
        {
            SubType = Bitmap;
        }
        field(50014; Picture4; BLOB)
        {
            SubType = Bitmap;
        }
        field(50015; Picture5; BLOB)
        {
            SubType = Bitmap;
        }
        field(50016; Picture6; BLOB)
        {
            SubType = Bitmap;
        }
    }

    keys
    {
        key(Key1; "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }
}

*/