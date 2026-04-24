pageextension 50136 Files_read extends "Work Types"
{
    layout
    {
        // Add changes to page layout here



        modify(Description) { Visible = false; }
        modify("Unit of Measure Code") { Visible = false; }
        addafter(Code)
        {
            field(Quantity; Quantity) { ApplicationArea = all; }
            field(Price; Price)
            {
                ApplicationArea = all;
            }

            field(Total; Total) { ApplicationArea = all; }
            field("Customer No."; "Customer No.")
            {
                ShowMandatory = true;
                trigger OnValidate()
                var

                    Cus: Record Customer;
                begin
                    IF cus.GET("Customer No.")
                    then
                        MESSAGE(Cus.Name);

                end;
            }
            field("Customer Name"; "Customer Name") { Style = Unfavorable; StyleExpr = Emphasize; }
            field("Payment Method Code"; "Payment Method Code") { }

            field("Driver type"; "Driver type")
            {
                ApplicationArea = all;



            }
            field("Driver ID"; "Driver ID")
            {
                ApplicationArea = all;



                /*    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        EmployeeCNG: Record Employee;
                        EmployeeList: page "Employee List";
                    begin
                        clear(EmployeeList);
                        EmployeeCNG.Reset();
                        EmployeeCNG.SetFilter("CNG Employee", '%1', true);
                        EmployeeList.SetTableView(EmployeeCNG);

                        EmployeeList.LOOKUPMODE(TRUE);
                        IF EmployeeList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            EmployeeList.GETRECORD(EmployeeCNG);
                            rec."Driver ID" := EmployeeCNG."No.";

                        end;
                    end;*/

                trigger OnLookup(var Text: Text): Boolean
                var
                    myInt: Integer;
                    EmployeeCNG: Record Employee;
                    EmployeeList: page "Employee List";
                    EmployeeCNG_C: Record Contact;
                    EmployeeList_C: page "Contact List";
                    CBR: Record "Contact Business Relation";
                begin

                    if "Driver type" = "Driver type"::Internal then begin
                        clear(EmployeeList);
                        EmployeeCNG.Reset();
                        EmployeeCNG.SetFilter("CNG Employee", '%1', true);
                        EmployeeCNG.SetFilter(StatusExt, '%1', EmployeeCNG.StatusExt::Active);
                        EmployeeList.SetTableView(EmployeeCNG);


                        EmployeeList.LOOKUPMODE(TRUE);
                        IF EmployeeList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            EmployeeList.GETRECORD(EmployeeCNG);
                            rec."Driver ID" := EmployeeCNG."No.";
                            Rec."Driver Name" := EmployeeCNG."First Name" + ' ' + EmployeeCNG."Last Name";

                        end;

                    end
                    else begin
                        //kontakt

                        clear(EmployeeList_C);
                        EmployeeCNG_C.Reset();
                        CBR.Reset();
                        CBR.SETFILTER("No.", '%1', "Customer No.");
                        IF CBR.FindFirst() then begin
                            EmployeeCNG_C.SetFilter("Type Relation", '%1', EmployeeCNG_C."Type Relation"::Driver);
                            EmployeeCNG_C.SetFilter("Active CNG", '%1', true);
                            EmployeeCNG_C.SetFilter("Company No.", '%1', CBR."Contact No.");
                            EmployeeList_C.SetTableView(EmployeeCNG_C);


                            EmployeeList_C.LOOKUPMODE(TRUE);
                            IF EmployeeList_C.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                EmployeeList_C.GETRECORD(EmployeeCNG_c);
                                rec."Driver ID" := EmployeeCNG_C."No.";
                                Rec."Driver Name" := EmployeeCNG_c.Name;
                            end;
                        end;

                    end;
                end;
            }
            field("Driver Name"; "Driver Name") { ApplicationArea = all; }
            field("Driver Registration No."; "Driver Registration No.") { ApplicationArea = all; }
            field("Type of vehicle"; "Type of vehicle") { ApplicationArea = all; editable = FALSE; }

        }
    }


    actions
    {


    }

    trigger OnOpenPage()
    begin
        Emphasize := TRUE;
        CurrPage.Editable(true);

    end;

    var
        myInt: Integer;
        Emphasize: Boolean;
}