table 50056 "XML Wage Calculation"
{
    Caption = 'XML Wage Calculation';
    //ĐK
    //đ

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Description = 'Primary Key';
            //LL
        }
        field(20; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(30; "Month Of Calculation"; Integer)
        {
            Caption = 'Month of Calculation';
            Description = 'Month in which the wage is calculated';
        }
        field(31; "Year Of Calculation"; Integer)
        {
            Caption = 'Year Of Calculation';
            Description = 'Year in which the wage is calculated';
        }
        field(40; "Month Of Wage"; Integer)
        {
            Caption = 'Month of Wage';
            Description = 'Month for which the wage is calculated and paid';
        }
        field(45; "Year Of Wage"; Integer)
        {
            Caption = 'Year of Wage';
            Description = 'Year for which the wage is calculated and paid';
        }
        field(64; "Base Tax Deduction"; Decimal)
        {
            Caption = 'Base Tax Deduction';
            Description = 'Base tax deduction for employee';
        }
        field(65; "Tax Deductions"; Decimal)
        {
            Caption = 'Tax Deductions';
            Description = 'Total tax deduction for employee';
        }
        field(70; "Work Experience Brutto"; Decimal)
        {
            Caption = 'Work Experience Brutto';
            Description = 'If work experience is calculated, brutto amount by which wage is increased';
        }
        field(75; Brutto; Decimal)
        {
            Caption = 'Brutto';
        }
        field(90; "Net Wage"; Decimal)
        {
            Caption = 'Net Wage';
            Description = 'Net wage before reduction';
        }
        field(95; "Untaxable Wage"; Decimal)
        {
            Caption = 'Untaxable Wage';
            Description = 'Amount of wage to which tax is not applied';
        }
        field(100; "Tax Basis"; Decimal)
        {
            Caption = 'Tax Basis';
            Description = 'Amount of wage on basis of which tax and city tax are calculated';
        }
        field(105; Tax; Decimal)
        {
            Caption = 'Tax';
        }
        field(115; "Final Net Wage"; Decimal)
        {
            Caption = 'Final Net Wage';
        }
        field(175; "Indirect Wage Addition Amount"; Decimal)
        {
            Caption = 'Indirect Wage Addition Amount';
            Description = '2.0';
        }
        field(300; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            Description = 'When was the wage paid';
        }
        field(301; "Hour Pool"; Integer)
        {
            Caption = 'Hour Pool';
            Description = 'Broj radnih sati';
        }
        field(302; "Taxible Wage Additions"; Decimal)
        {
            Caption = 'Taxible Wage Additions';
            Description = 'Vrijednost primanja u stvarima i uslugama';
        }
        field(303; "PIO Amount From"; Decimal)
        {
            Caption = 'PIO Amount From';
            Description = 'Uplaceni iznos za PIO na teret osiguranika iz osnovice';
        }
        field(304; "ZO Amount From"; Decimal)
        {
            Caption = 'ZO Amount From';
            Description = 'Uplaceni iznos za ZO na teret osiguranika iz osnovice';
        }
        field(305; "Unemployment Amount From"; Decimal)
        {
            Caption = 'Unemployment Amount From';
            Description = 'Uplaceni iznos za osigur. od nezaposlenosti na teret osiguranika iz osnovice';
        }
        field(306; "Personal Deduction Factor"; Decimal)
        {
            Caption = 'Personal Deduction Factor';
            Description = 'Ukupni faktor ličnog odbitka';
        }
        field(308; "PIO Amount On"; Decimal)
        {
            Caption = 'PIO Amount On';
            Description = 'Uplaceni iznos za PIO na osnovicu';
        }
        field(309; "ZO Amount On"; Decimal)
        {
            Caption = 'ZO Amount On';
            Description = 'Uplaceni iznos za ZO na osnovicu';
        }
        field(310; "Unemployment Amount On"; Decimal)
        {
            Caption = 'Unemployment Amount On';
            Description = 'Uplaceni iznos za osigur. od nezaposlenosti na osnovicu';
        }
        field(311; "ZO Additions"; Decimal)
        {
            Caption = 'ZO Additions';
            Description = 'Uplaceni iznos za dodatne doprinose za ZO na teret poslodavca';
        }
        field(312; "Sick Hour Pool"; Integer)
        {
            Caption = 'Sick Hour Pool';
            Description = 'Broj radnih sati na bolovanju';
        }
        field(313; Use; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }
}

