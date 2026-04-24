/*table 50179 "Previous Work Experience"
{
    Caption = 'Previous Work Experience';

    fields
    {
        field(1; Employer; Text[200])
        {
            Caption = 'Employer';
        }
        field(2; "Former Workplace"; Text[200])
        {
            Caption = 'Former Workplace';
        }
        field(3; "Period From"; Date)
        {
            Caption = 'Period From';
        }
        field(4; "Period To"; Date)
        {
            Caption = 'Period To';
        }
          field(5; "Job Desription"; Integer)
          {
              FieldClass = FlowField;
              CalcFormula = Count("Candidate Job Description" WHERE("Serial Number" = FIELD("Serial Number")));
              Caption = 'Job Desription';
              Editable = false;

          }
           field(6; "Serial Number"; Integer)
            {
                Caption = 'Serial number';
                TableRelation = Candidates."Serial Number";
                //This property is currently not supported
                //TestTableRelation = false;
                ValidateTableRelation = false;
            }
    }

    keys
    {
        key(Key1; Employer, "Serial Number", "Former Workplace")
        {
        }
    }

    fieldgroups
    {
    }
}

*/