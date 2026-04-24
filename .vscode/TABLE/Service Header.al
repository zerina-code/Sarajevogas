tableextension 50065 ServiceHeaderExtends extends "Service Header"
{
    //UGI = Unutrašnja gasna instalacija
    //IKP = Interni kontrolni pregled
    //MRS = Mjerno-regulacioni set
    //DGM = Distributivna gasna mreža
    fields
    {

        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }

        modify("Starting Date")
        {
            trigger OnBeforeValidate()
            var
                myInt: Integer;
                ServItemLine: Record "Service Item Line";
                US: Record "User Setup";
            begin

                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                if US.FindFirst() then begin
                    if US.HS = true then begin
                        us.StartEmpty := rec."Starting Time";
                        us.EndEmpty := rec."Finishing Time";
                        us.Modify();
                    end;
                    Commit();
                end;
                if "Starting Date" < "Order Date" then begin
                    "Order Date" := "Starting Date";
                end;

                ServItemLine.Reset();
                ServItemLine.SetCurrentKey("Document Type", "Document No.", "Starting Date");
                ServItemLine.SetRange("Document Type", "Document Type");
                ServItemLine.SetRange("Document No.", "No.");
                ServItemLine.SetFilter("Starting Date", '<>%1', 0D);
                if ServItemLine.Find('-') then
                    repeat
                        if ServItemLine."Starting Date" < "Starting Date" then begin
                            ServItemLine."Starting Date" := "Starting Date";
                            ServItemLine.Modify();
                        end;
                    until ServItemLine.Next = 0;


            end;


            trigger OnAfterValidate()
            var
                US: Record "User Setup";
            begin

                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                if US.FindFirst() then begin
                    if US.HS = true then begin
                        rec."Starting Time" := us.StartEmpty;
                        rec."Finishing Time" := us.EndEmpty;
                        us.Modify();
                        Commit();
                    end;
                end;

            end;


        }
        modify("Document Date")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //  Validate("Posting Date", "Document Date");
            end;
        }
        field(50023; "Department Code"; Code[20])
        {
            Caption = 'Department Code';

        }

        modify("Bill-to Customer No.")
        {
            //EK

            trigger OnAfterValidate()
            var
                BillToCustomer: Record Customer;
            begin

                if "Bill-to Customer No." <> '' then begin

                    if BillToCustomer.Get("Bill-to Customer No.") then begin

                        "Bill-to Registration No." := BillToCustomer."Registration No.";

                        "Bill-to VAT Registration No." := BillToCustomer."VAT Registration No.";

                    end else begin

                        "Bill-to Registration No." := '';
                        "Bill-to VAT Registration No." := '';
                    end;
                end else begin

                    "Bill-to Registration No." := '';
                    "Bill-to VAT Registration No." := '';
                end;
            end;
        }



        modify("Starting Time")
        {


            trigger OnBeforeValidate()
            var
                myInt: Integer;

            begin

                //EK

                if ("Starting Time" = 0T) then begin
                    BackupFinishingTime := xRec."Finishing Time"; // Sačuvaj stari Finishing Time
                    BackupFinishingDate := xRec."Finishing Date"; // Sačuvaj stari Finishing Date

                    // Obriši Finishing Time i Finishing Date
                    "Finishing Time" := 0T;
                    "Finishing Date" := 0D;
                end;

                //

                if ("Starting Date" = "Finishing Date") and
                     ("Starting Time" > "Finishing Time")
                  then
                    "Finishing Time" := "Starting Time";

                if ("Starting Date" = "Order Date") and
                   ("Starting Time" < "Order Time")
                then
                    "Order Time" := "Starting Time";


            end;

            trigger OnAfterValidate()
            begin

                if ("Starting Time" = 0T) then begin
                    "Finishing Time" := BackupFinishingTime;
                    "Finishing Date" := BackupFinishingDate;
                end;
            end;
        }
        modify("Finishing Date")
        {
            trigger OnBeforeValidate()
            var
                myInt: Integer;
                ServItemLine: Record "Service Item Line";
                US: Record "User Setup";
            begin

                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                if US.FindFirst() then begin
                    if US.HS = true then begin
                        rec."Starting Time" := us.StartEmpty;
                        rec."Finishing Time" := us.EndEmpty;
                        us.Modify();
                        Commit();
                    end;
                end;



                if "Finishing Date" <> 0D then begin
                    if "Finishing Date" < "Starting Date" then
                        "Finishing Date" := "Starting Date";

                    if "Finishing Date" < "Order Date" then
                        "Order Date" := "Finishing Date";

                    ServItemLine.Reset();
                    ServItemLine.SetCurrentKey("Document Type", "Document No.", "Finishing Date");
                    ServItemLine.SetRange("Document Type", "Document Type");
                    ServItemLine.SetRange("Document No.", "No.");
                    ServItemLine.SetFilter("Finishing Date", '<>%1', 0D);
                    if ServItemLine.Find('-') then
                        repeat
                            if ServItemLine."Finishing Date" > "Finishing Date" then begin
                                ServItemLine."Finishing Date" := "Finishing Date";
                                ServItemLine.Modify();
                            end;
                        until ServItemLine.Next = 0;

                end;
            end;

            trigger OnAfterValidate()
            var
                US: Record "User Setup";
            begin

                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                if US.FindFirst() then begin
                    if US.HS = true then begin
                        rec."Starting Time" := us.StartEmpty;
                        rec."Finishing Time" := us.EndEmpty;
                        us.Modify();
                        Commit();
                    end;
                end;

            end;
        }

        modify("Finishing Time")
        {

            trigger OnBeforeValidate()
            var
                myInt: Integer;
                ServItemLine: Record "Service Item Line";
            begin

                if "Finishing Time" <> 0T then begin
                    if ("Starting Date" = "Finishing Date") and
                       ("Finishing Time" < "Starting Time")
                    then
                        "Finishing Time" := "Starting Time";

                    if ("Finishing Date" = "Order Date") and
                       ("Finishing Time" < "Order Time")
                    then
                        "Order Time" := "Finishing Time";

                    ServItemLine.Reset();
                    ServItemLine.SetCurrentKey("Document Type", "Document No.", "Finishing Date");
                    ServItemLine.SetRange("Document Type", "Document Type");
                    ServItemLine.SetRange("Document No.", "No.");
                    ServItemLine.SetFilter("Finishing Date", '<>%1', 0D);
                    if ServItemLine.Find('-') then
                        repeat
                            if (ServItemLine."Finishing Date" = "Finishing Date") and
                               (ServItemLine."Finishing Time" > "Finishing Time")
                            then begin
                                ServItemLine."Finishing Time" := "Finishing Time";
                                ServItemLine.modify;
                            end;
                        until ServItemLine.Next = 0;
                end;
            end;
        }

        modify("Customer No.")
        {
            trigger OnAfterValidate()
            begin
                OnAfterValidateCustomerNo();
            end;
        }
        //    VAT Base (retro.)
        field(50000; "VAT Date"; Date)
        {

            DataClassification = ToBeClassified;

        }
        field(500001; "Implementation Time"; Time)
        {

            DataClassification = ToBeClassified;

        }
        field(60000; "Request Type"; Enum "Request Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Request Type';

            trigger OnValidate()
            var
                myInt: Integer;
                CZKRe: Record "Service Header";
            begin

                if rec."Request Type" = rec."Request Type"::"Information on Connection" then begin
                    CZKRe.Reset();
                    CZKRe.SetFilter("No.", '%1', "CZK Request No.");
                    if CZKRe.FindFirst() then begin
                        if CZKRe."Request Type" <> CZKRe."Request Type"::"Information Issuing Request" then begin
                            CZKRe."Request Type" := CZKRe."Request Type"::"Information Issuing Request";
                            CZKRe.Modify();
                        end;
                    end;
                end;


                if rec."Request Type" = rec."Request Type"::"Location Accordance Issuing Information" then begin
                    CZKRe.Reset();
                    CZKRe.SetFilter("No.", '%1', "CZK Request No.");
                    if CZKRe.FindFirst() then begin
                        if CZKRe."Request Type" <> CZKRe."Request Type"::"Location Accordance Issuing Request" then begin
                            CZKRe."Request Type" := CZKRe."Request Type"::"Location Accordance Issuing Request";
                            CZKRe.Modify();
                        end;
                    end;
                end;



                if rec."Request Type" = rec."Request Type"::"Project and Energy Accordance" then begin
                    CZKRe.Reset();
                    CZKRe.SetFilter("No.", '%1', "CZK Request No.");
                    if CZKRe.FindFirst() then begin
                        if CZKRe."Request Type" <> CZKRe."Request Type"::"Project overview Request" then begin
                            CZKRe."Request Type" := CZKRe."Request Type"::"Project overview Request";
                            CZKRe.Modify();
                        end;
                    end;
                end;


                if rec."Request Type" = rec."Request Type"::"Route Accordance Issuing Information" then begin
                    CZKRe.Reset();
                    CZKRe.SetFilter("No.", '%1', "CZK Request No.");
                    if CZKRe.FindFirst() then begin
                        if CZKRe."Request Type" <> CZKRe."Request Type"::"Route Accordance Issuing Request" then begin
                            CZKRe."Request Type" := CZKRe."Request Type"::"Route Accordance Issuing Request";
                            CZKRe.Modify();
                        end;
                    end;
                end;


                if rec."Request Type" = rec."Request Type"::"Spatial plan Accordance Issuing Information" then begin
                    CZKRe.Reset();
                    CZKRe.SetFilter("No.", '%1', "CZK Request No.");
                    if CZKRe.FindFirst() then begin
                        if CZKRe."Request Type" <> CZKRe."Request Type"::"Spatial plan Accordance Issuing Request" then begin
                            CZKRe."Request Type" := CZKRe."Request Type"::"Spatial plan Accordance Issuing Request";
                            CZKRe.Modify();
                        end;
                    end;
                end;

            end;
        }
        field(60001; "Request Group"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Request Group';
            TableRelation = "Request Group".Description;
        }
        field(60002; "Work Order Type"; enum "Work Order Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order Type';
        }
        field(60003; "Remote Reading Device"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Remote Reading Device';
            TableRelation = "Remote Reading Device".Description;
        }
        field(60004; "Chimney Man"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Chimnay Man';
            TableRelation = Contact;
        }
        field(60005; "Pipeline Recording"; enum "Pipeline Recording")
        {
            DataClassification = CustomerContent;
            Caption = 'Pipeline Recording';
        }
        field(60006; Activity; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Activity';
            TableRelation = "Request Activity".Description;
        }
        field(60007; "Activity Type"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Activity Type';
            TableRelation = "Activity Type".Description where("Group request" = field("Request Group"));
        }
        field(60008; "Geo. Activity Type"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Geo. Activity Type';
            TableRelation = "Geo. Activity Type".Description;
        }
        field(60009; "Recording Method"; enum "Recording Method")
        {
            DataClassification = CustomerContent;
            Caption = 'Recording Method';
        }
        field(60010; "Marking Method"; enum "Recording Method")
        {
            DataClassification = CustomerContent;
            Caption = 'Marking Method';
        }
        field(60011; "Designer Connection Type"; enum "Resource Connection Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Designer Connection Type';
            trigger OnValidate()
            begin
                TestField("Designer No.", '');
            end;
        }
        field(60012; "Designer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Designer No.';
            TableRelation = if ("Designer Connection Type" = const(Internal)) Employee
            else
            if ("Designer Connection Type" = const(External)) Contact where("Type Relation" = const(Designer));
            trigger OnValidate()
            begin
                OnValidateDesignerNo();
            end;
        }
        field(60013; "Project"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Project';
            TableRelation = "Project".Description;
            trigger OnValidate()
            var
                myInt: Integer;
                Proe: Record Project;

            begin
                Proe.Reset();
                Proe.SetFilter(Description, '%1', rec.Project);
                if Proe.FindFirst() then begin
                    "Project Date" := Proe."Project Date";
                end
                else begin
                    "Project Date" := 0D;
                end;

            end;
        }
        field(60014; Grouping; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Grouping';
            // TableRelation = Grouping.Description;
        }
        field(60015; "Excavation"; enum "Excavation")
        {
            DataClassification = CustomerContent;
            Caption = 'Excavation';
        }

        field(60016; "Previous Gas"; enum "Previous Gas")
        {
            DataClassification = CustomerContent;
            Caption = 'Previous Gas';
        }
        field(60017; "Prep. Process. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparation - Processing Employee No.';
            TableRelation = Employee;
            trigger OnValidate()
            var
                myInt: Integer;

            begin
                "Prep. Process. Empl. Name." := FindEmployee("Prep. Process. Empl. No.");
            end;
        }
        field(60018; "Prep. Contr. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparation - Controlling Employee No.';
            TableRelation = Employee;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

                "Prep. Contr. Empl. Name" := FindEmployee("Prep. Contr. Empl. No.");
            end;
        }
        field(60019; "Prep. Verif. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparation - Verification Employee No.';
            TableRelation = Employee;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Prep. Verif. Empl. Name" := FindEmployee("Prep. Verif. Empl. No.");

            end;
        }
        field(60020; "Real. Process. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Processing Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            var
                myInt: Integer;
                E: Record Employee;
            begin
                "Real. Process. Empl. Name" := FindEmployee("Real. Process. Empl. No.");
                validate("Employee Responsible", "Real. Process. Empl. No.");
                Validate(Initials, FindEmployeeInitials("Real. Process. Empl. No."));

            end;
        }
        field(50198; "Customer No. previous"; Code[20])
        {
            Caption = 'Customer No. previous';
        }


        field(60021; "Real. Contr. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Controlling Employee No.';
            TableRelation = Employee;


            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Real. Contr. Empl. Name" := FindEmployee("Real. Contr. Empl. No.");
                validate("Employee Control Responsible", "Real. Contr. Empl. No.");

            end;

        }
        field(60022; "Real. Verif. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Verification Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Real. Verif. Empl. Name" := FindEmployee("Real. Verif. Empl. No.");
                validate("Employee Prepare Responsible", "Real. Verif. Empl. No.");

            end;
        }
        field(60023; "Accord No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Accord No.';
            TableRelation = "Service Header"."No." where("Document Type" = const(Order));
        }
        field(60024; "Owner No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Owner No.';
            TableRelation = Contact where("Type Relation" = const(Owner));
            trigger OnValidate()
            begin
                OnValidateOwnerNo();
            end;
        }
        field(60025; "Work Order Requester"; enum "Work Order Requester")
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order Requester';
        }
        field(60026; "Designer Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Designer Phone No.';
        }
        field(60027; "Designer Email"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Designer Email';
        }
        field(60028; "Municipality Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Municipality Code';
            TableRelation = Municipality.Code where(type = filter(Regular));
            trigger OnValidate()
            begin
                OnValidateMunicipality();
            end;
        }
        field(60029; "Municipality Name"; Text[250])
        {
            Caption = 'Municipality Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("Municipality Code"), type = filter(Regular)));
            Editable = false;
        }

        field(60030; "MZ"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Local Community';
            TableRelation = MZ.Code;
        }
        field(60031; "MZ Name"; Text[250])
        {
            Caption = 'MZ Name';
            FieldClass = FlowField;
            CalcFormula = lookup(MZ.Description where(Code = field("MZ")));
            Editable = false;
        }

        field(60032; "Street"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Street';
            TableRelation = Street.Code;
            trigger OnValidate()
            begin
                OnValidateStreet();
            end;
        }

        field(60033; "Street Name"; Text[250])
        {
            Caption = 'Street Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Street.Description where(Code = field("Street")));
            Editable = false;
        }
        field(60034; "Street No."; Code[20])
        {
            Caption = 'Street No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                OnValidateStreet();
            end;
        }
        field(60037; "Project. Route"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Project. Route';
        }
        field(60038; "CZK Request No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'CZK Request No.';
            TableRelation = "Service Header"."No." where("Document Type" = const(Order));

        }
        field(60039; "Request ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Request ID';
            Editable = false;

            //automatski se dodjeljuje Redni broj/godina
        }
        field(60040; "Owner Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Owner Name';
        }
        field(60041; "Owner Municipality Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Municipality Code';
            TableRelation = Municipality.Code where(Type = filter(Regular));
        }
        field(60042; "Owner Municipality Name"; Text[250])
        {
            Caption = 'Municipality Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("Owner Municipality Code"), Type = filter(Regular)));
            Editable = false;
        }

        field(60043; "Owner MZ"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Local Community';
            TableRelation = MZ.Code;
        }
        field(60044; "Owner MZ Name"; Text[250])
        {
            Caption = 'MZ Name';
            FieldClass = FlowField;
            CalcFormula = lookup(MZ.Description where(Code = field("Owner MZ")));
            Editable = false;
        }

        field(60045; "Owner Street"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Street';
            TableRelation = Street.Code;
            trigger OnValidate()
            begin
                OnValidateOwnerStreet();
            end;
        }

        field(60046; "Owner Street Name"; Text[250])
        {
            Caption = 'Street Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Street.Description where(Code = field("Owner Street")));
            Editable = false;
        }
        field(60047; "Owner Street No."; Code[20])
        {
            Caption = 'Street No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                OnValidateOwnerStreet();
            end;
        }
        field(60048; "Owner Address"; Text[100])
        {
            Caption = 'Owner Address';
            DataClassification = CustomerContent;
        }
        field(60050; "Work Order Due Date"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order Due Date', Comment = 'Rok za obradu radnog naloga';
        }
        field(60051; "Work Order Registry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order Registry No.', Comment = 'Broj u registratoru';
        }
        field(60052; "Work Order Request No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order Request No.', Comment = 'Veza na radni nalog';
            TableRelation = "Service Header"."No." where("Document Type" = const(Order), "Request Type" = const("General Work Order"));
        }
        field(60053; "Work Order Request Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order Request Date', Comment = 'Datum veze radnog naloga';
        }
        field(60054; "Work Order Emergency"; enum "Work Order Emergency")
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order Emergency', Comment = 'Hitnost prijave';
        }
        field(60055; "Execution Company No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Execution Company No.', Comment = 'Br. izvođača';
            TableRelation = Contact where("Type Relation" = const(Contractor));
            trigger OnValidate()
            begin
                OnValidateExecutionCompanyNo();
                "Contractor No" := "Execution Company No.";
            end;
        }
        field(60056; "Execution Company Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Execution Company Name', Comment = 'Naziv izvođača';
        }
        field(60057; "Execution Address"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Execution Company Address', Comment = 'Sjedište izvođača';
        }
        field(60058; "Execution Company Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Execution Company Phone No.', Comment = 'Br. telefona izvođača';
        }
        field(60059; "Work Execution Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Work Execution Date', Comment = 'Datum izvođenja radova';
        }
        field(60060; "Planned W. Exec. Starting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Planned Work Exec. Starting Date', Comment = 'Planirani datum početka radova';
        }
        field(60061; "Planned W. Exec. Ending Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Planned Work Exec. Ending Date', Comment = 'Planirani datum završetka radova';
        }
        field(60062; "CZK Date"; Date)
        {
            Caption = 'CZK Date', Comment = 'Datum prijema u CZK';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Document Date" where("No." = field("CZK Request No."), "Document Type" = const(Order)));
            Editable = false;
        }

        field(60063; "Sent to ZIK"; Date)
        {
            Caption = 'Sent to ZIK', Comment = 'Poslano u ZIK';
            // DataClassification = CustomerContent;
            //    FieldClass=FlowField;
            //  CalcFormula=lookup("Service Header"."Sent to ZIK" where ("CZK Request No."=field("CZK Request No."),"Request Type"=filter("General Geo. Work Order Office"),
            //"Sent to ZIK"=filter(<>'')));


        }
        field(60064; "Received from ZIK"; Date)
        {
            Caption = 'Received from ZIK', Comment = 'Preuzeto iz ZIK';
            // DataClassification = CustomerContent;
            //  FieldClass=FlowField;
            //CalcFormula=lookup("Service Header"."Received from ZIK" where ("CZK Request No."=field("CZK Request No."),"Request Type"=filter("General Geo. Work Order Office"),
            //"Received from ZIK"=filter(<>'')));
        }
        field(60065; "Field Work Planned"; Date)
        {
            Caption = 'Field Work Planned', Comment = 'Plan izlaska na teren';
            DataClassification = CustomerContent;
        }
        field(60066; "Excavation Permit"; Boolean)
        {
            Caption = 'Excavation Permit', Comment = 'Dozvola za prokop';
            DataClassification = CustomerContent;
        }
        field(60067; "Legal Property Note"; Text[250])
        {
            Caption = 'Legal Property Note', Comment = 'Rješavanje imovinsko-pravnih odnosa';
            DataClassification = CustomerContent;
        }
        field(60068; "Employee Responsible"; Code[20])
        {
            Caption = 'Employee Responsible', Comment = 'Odgovorni zaposlenik';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }



        field(60069; "Processing Date"; Date)
        {
            Caption = 'Processing Date', Comment = 'Datum obrade';
            DataClassification = CustomerContent;
        }
        field(60070; "Request File"; Blob)
        {
            Caption = 'Request File', Comment = 'Datoteka zahtjeva';
            DataClassification = CustomerContent;
        }
        field(60071; "Request File Name"; Text[100])
        {
            Caption = 'Request File Name', Comment = 'Naziv priložene datoteke';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60072; "Responsible Department"; Code[20])
        {
            Caption = 'Responsible Department', Comment = 'Odgovorna org. jedinica';
            DataClassification = CustomerContent;
            TableRelation = Department.Code;
            trigger OnValidate()
            var
                myInt: Integer;
                Departmetn: Record Department;
                OrgSH: Record "ORG Shema";

                OrgJed: Record Department;
            begin



                OrgSH.Reset();
                OrgSH.SetFilter("Date From", '<=%1', today);
                OrgSH.SetCurrentKey("Date From");
                OrgSH.Ascending;
                Departmetn.Reset();
                if orgsh.FindLast() then
                    Departmetn.SetFilter("ORG Shema", '%1', OrgSH.Code);
                Departmetn.SetFilter(Code, '%1', "Responsible Department");
                if Departmetn.FindFirst() then
                    "Responsible Department Name" := Departmetn.Description
                else
                    "Responsible Department Name" := '';

                if "Holder of works" = '' then
                    "Holder of works" := "Responsible Department Name";

                OrgJed.Reset();
                OrgJed.SetFilter("ORG Shema", '%1', OrgSH.Code);
                OrgJed.SetFilter(Code, '%1', "Responsible Department");
                if orgjed.FindFirst() then begin
                    Rec.validate("Real. Process. Empl. No.", OrgJed."Signatory 1");
                    Rec.validate("Real. Verif. Empl. No.", OrgJed."Signatory 1 Position");
                    Rec.validate("Real. Contr. Empl. No.", OrgJed."Signatory 2");
                    Rec.validate("Prep. Process. Empl. No.", OrgJed."Prip Realisation");
                    //  if ServiceHeader."Real. Verif. Empl. No." = '' then
                    Rec.validate("Prep. Contr. Empl. No.", OrgJed."Prip Control");
                    //  if ServiceHeader."Real. Contr. Empl. No." = '' then
                    Rec.validate("Prep. Verif. Empl. No.", OrgJed."Prip Verif");

                end;

            end;
        }
        field(60073; "IKP Realisation"; Integer)
        {
            Caption = 'IKP Realisation', Comment = 'Realizacija IKP';
            DataClassification = CustomerContent;
        }
        field(60074; Deadline; Integer)
        {
            Caption = 'Deadline', Comment = 'Rok dana';
            DataClassification = CustomerContent;
        }
        field(60075; "Realisation in Days"; Integer)
        {
            Caption = 'Realisation in Days', Comment = 'Broj dana realizacije';
            DataClassification = CustomerContent;
        }
        field(60076; Dued; Integer)
        {
            Caption = 'Dued', Comment = 'Zaduženo';
            DataClassification = CustomerContent;
        }
        field(60077; Realized; Integer)
        {
            Caption = 'Realized', Comment = 'Realizovano';
            DataClassification = CustomerContent;
        }
        field(60078; "Realisation Date"; Date)
        {
            Caption = 'Realization Date', Comment = 'Datum realizacije';
            DataClassification = CustomerContent;
        }
        field(60079; "ID Network"; Text[250])
        {
            Caption = 'ID Network', Comment = 'ID mreža';
            DataClassification = CustomerContent;
        }
        field(60080; "ID Vertical"; Text[250])
        {
            Caption = 'ID Vertical', Comment = 'ID vertikala';
            DataClassification = CustomerContent;
        }
        field(60081; "Recording/Marking Finished"; Boolean)
        {
            Caption = 'Finished', Comment = 'Završeno';
            DataClassification = CustomerContent;
        }
        field(60082; "DGM Total Length"; Decimal)
        {
            Caption = 'DGM Total Length', Comment = 'Ukupna dužina DGM';
            DataClassification = CustomerContent;
        }
        field(60083; "PG Total Length"; Decimal)
        {
            Caption = 'PG Total Length', Comment = 'Ukupna dužina PG';
            DataClassification = CustomerContent;
        }
        field(60084; "No. of Connections"; Integer)
        {
            Caption = 'No. of Connections', Comment = 'Broj priključaka';
            DataClassification = CustomerContent;
        }
        field(60085; "No. of Objects"; Integer)
        {
            Caption = 'No. of Objects', Comment = 'Broj objekata';
            DataClassification = CustomerContent;
        }
        field(60086; "No. of Cutting"; Integer)
        {
            Caption = 'No. of Cutting', Comment = 'Broj šlicanja';
            DataClassification = CustomerContent;
        }
        field(60087; "Rec/Marking Fully Finished"; Boolean)
        {
            Caption = 'Fully Finished', Comment = 'Završeno u cijelosti';
            DataClassification = CustomerContent;
        }
        field(60088; "Rec/Marking Start Date"; DateTime)
        {
            Caption = 'Start Date', Comment = 'Vrijeme početka';
            DataClassification = CustomerContent;
        }
        field(60089; "Rec/Marking End Date"; DateTime)
        {
            Caption = 'End Date', Comment = 'Vrijeme završetka';
            DataClassification = CustomerContent;
        }
        field(60090; "EU Activity"; text[250])
        {
            Caption = 'EU Activity';
            TableRelation = "MM Activity".Description where(Type = const(EU));
            DataClassification = CustomerContent;
        }
        field(60091; "Designer Name"; Text[100])
        {
            Caption = 'Designer Name';
            DataClassification = CustomerContent;
        }
        field(60092; Heating; Boolean)
        {
            Caption = 'Heating';
            DataClassification = CustomerContent;
        }
        field(60093; "Request Due Date"; Date)
        {
            Caption = 'Request Due Date';
            DataClassification = CustomerContent;
        }
        field(60094; "Last DateTime Modified"; DateTime)
        {
            Caption = 'Last DateTime Modified', Comment = 'Vrijeme zadnje izmjene';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60095; "Last Modified by User"; Code[50])
        {
            Caption = 'Last Modified by User', Comment = 'Korisnik zadnje izmjene';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70028; "Municipality Code 2"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Municipality Code';
            TableRelation = Municipality.Code where(Type = filter(Regular));
            trigger OnValidate()
            begin
                OnValidateMunicipality2();
            end;
        }
        field(70029; "Municipality Name 2"; Text[250])
        {
            Caption = 'Municipality Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("Municipality Code 2"), Type = filter(Regular)));
            Editable = false;
        }

        field(70030; "MZ 2"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Local Community';
            TableRelation = MZ.Code;
        }
        field(70031; "MZ Name 2"; Text[250])
        {
            Caption = 'MZ Name';
            FieldClass = FlowField;
            CalcFormula = lookup(MZ.Description where(Code = field("MZ 2")));
            Editable = false;
        }

        field(70032; "Street 2"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Street';
            TableRelation = Street.Code;
            trigger OnValidate()
            begin
                OnValidateStreet2();
            end;
        }

        field(70033; "Street Name 2"; Text[250])
        {
            Caption = 'Street Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Street.Description where(Code = field("Street 2")));
            Editable = false;
        }
        field(70034; "Street No. 2"; Code[20])
        {
            Caption = 'Street No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                OnValidateStreet2();
            end;
        }
        field(70035; "City 2"; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(70036; "Post Code 2"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
        }
        field(70037; "Stroke No."; Integer)
        {
            Caption = 'Stroke No.';
            DataClassification = CustomerContent;
        }
        field(70038; "Customer String"; Integer)
        {
            Caption = 'Customer String';
            DataClassification = CustomerContent;
        }
        field(70039; "Zone Stroke No."; Integer)
        {
            Caption = 'Zone Stroke No.';
            DataClassification = CustomerContent;
        }
        field(70040; "Stroke No. 2"; Integer)
        {
            Caption = 'Stroke No.';
            DataClassification = CustomerContent;
        }
        field(70041; "Customer String 2"; Integer)
        {
            Caption = 'Customer String';
            DataClassification = CustomerContent;
        }
        field(70042; "Zone Stroke No. 2"; Integer)
        {
            Caption = 'Zone Stroke No.';
            DataClassification = CustomerContent;
        }
        field(70043; "Floor 2"; Code[20])
        {
            Caption = 'Floor';
            DataClassification = CustomerContent;
        }
        field(70044; "Apartment No. 2"; Code[5])
        {
            Caption = 'Apartment No.';
            DataClassification = CustomerContent;
        }
        field(70045; "Customer Category"; Enum Category)
        {
            Caption = 'Customer Category';
            DataClassification = CustomerContent;
        }

        field(70047; "Responsible Department Name"; Text[150])
        {
            Caption = 'Responsible Department Name';
            //  FieldClass = FlowField;
            //   CalcFormula = lookup(Department.Description where(Code = field("Responsible Department")));
            Editable = false;
        }
        field(70048; "Area Dimension"; Text[80])
        {
            Caption = 'Area Dimension', Comment = 'Površina';
            DataClassification = CustomerContent;
        }
        field(70050; "kW Power"; Decimal)
        {
            Caption = 'kW Power';
            DataClassification = CustomerContent;
        }
        field(70051; "Land"; Text[80])
        {
            Caption = 'Land', Comment = 'Parcela';
            DataClassification = CustomerContent;
        }
        field(70052; "Proforma Paid"; Boolean)
        {
            Caption = 'Proforma Paid', Comment = 'Plaćeno po profakturi';
            DataClassification = CustomerContent;
        }



        field(70938; "Advance Created"; Boolean)
        {
            Caption = 'Advance Created', Comment = 'Kreiran avans';
            DataClassification = CustomerContent;
        }

        field(70939; "Advance No."; Code[20])
        {
            Caption = 'Advance No.', Comment = 'Avans kreiran za ovu fakturu';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."No." where("CZK Request" = field("No."), Prepayment = filter(true)));
        }

        field(70940; "Credit M.Advance No."; Code[20])
        {
            Caption = 'Sales Cr.Memo Header Advance', Comment = 'Storno avansa za ovu fakturu';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Cr.Memo Header"."No." where("CZK Request" = field("No."), Prepayment = filter(true)));
        }
        field(70941; "Credit Memo Created"; Boolean)
        {
            Caption = 'Credit Memo Created', Comment = 'Kreiran storno avansa';
            DataClassification = CustomerContent;
        }





        field(70053; "SGPO Date Fire Protection"; Date)
        {
            Caption = 'SGPO Date Fire Protection', Comment = 'Dostavljeno SGPO na stručno mišljenje - protivpožarna zaštita';
            DataClassification = CustomerContent;
        }
        field(70054; "SGPO Date El. Installation"; Date)
        {
            Caption = 'SGPO Date El. Installation', Comment = 'Dostavljeno SGPO na stručno mišljenje - el. instalacija';
        }

        field(70056; "Pickup Date"; Date)
        {
            Caption = 'Pickup Date', Comment = 'Datum preuzimanja';
            DataClassification = CustomerContent;
        }
        field(70057; "No. of Project Accordances"; Integer)
        {
            Caption = 'No. of Project Accordances', Comment = 'Broj saglanosti na projekat';
            DataClassification = CustomerContent;
        }
        field(70058; "No. of El. Accord. per Project"; Integer)
        {
            Caption = 'No. of El. Accord. per Project', Comment = 'Broj el. saglasnosti po projektu';
            DataClassification = CustomerContent;
        }
        field(70059; "Firefight Accordance"; Text[250])
        {
            Caption = 'Firefight Accordance', Comment = 'Protipožarna saglasnost';
            DataClassification = CustomerContent;
        }
        field(70060; "El. Accordance Date"; Date)
        {
            Caption = 'El. Accordance Date', Comment = 'Datum el. energetske saglasnosti';
            DataClassification = CustomerContent;
        }
        field(70061; "Project Accordance Date"; Date)
        {
            Caption = 'Project Accordance Date', Comment = 'Datum saglasnosti na projekat';
            DataClassification = CustomerContent;
        }
        field(70062; "UGI Project Name"; Text[250])
        {
            Caption = 'UGI Project Name', Comment = 'Naziv projekta UGI';
            DataClassification = CustomerContent;
            TableRelation = Project.Description;
            trigger OnValidate()
            var
                myInt: Integer;
                Pr: Record Project;
            begin
                pr.Reset();
                pr.SetFilter(Description, '%1', "UGI Project Name");
                if pr.FindFirst() then begin
                    "UGI Project Creation Date" := pr."Project Date";
                    "Investor Code" := pr."Investor Code";
                    "Investor Name" := pr."Investor Name";
                end
                else begin
                    "UGI Project Creation Date" := 0D;
                    "Investor Code" := '';
                    "Investor Name" := '';
                end;
            end;
        }
        field(70063; "Service Line Diameter"; Text[250])
        {
            Caption = 'Service Line Diameter', Comment = 'Prečnik servisnog voda';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Char: DotNet Char;
                i: Integer;
            begin
                for i := 1 to StrLen("Service Line Diameter") do begin
                    if Char.IsLetter("Service Line Diameter"[i]) or ("Service Line Diameter"[i] = '.') then
                        FieldError("Service Line Diameter", ServiceLineDiameterCannotContainsLetters);
                end;
            end;

        }

        field(70064; "DGM Diameter"; Decimal)
        {
            Caption = 'DGM Diameter', Comment = 'Prečnik DGM';
            DataClassification = CustomerContent;
        }
        field(70065; "G Gauge Size"; Text[250])
        {
            Caption = 'G Gauge Size', Comment = 'Veličina G mjerača';
            DataClassification = CustomerContent;
            //  TableRelation = "Types Of Diseases" where(Types = filter("Gauge size"));
        }
        field(70066; "Measure Point Pressure"; Text[250])
        {
            Caption = 'Measure Point Pressure', Comment = 'Pritisak na mjestu mjerenja';
            DataClassification = CustomerContent;
        }
        field(70067; "Design Company"; Text[250])
        {
            Caption = 'Design Company', Comment = 'Projektantska firma';
            DataClassification = CustomerContent;
            // TableRelation = Contact.Name where("Type Relation" = filter(Designer));
        }
        field(70068; "UGI Project Creation Date"; Date)
        {
            Caption = 'UGI Project Creation Date', Comment = 'Datum izrade UGI projekta';
        }
        field(70069; "Information Number"; Code[20])
        {
            Caption = 'Information Number', Comment = 'Broj infromacije';
            DataClassification = CustomerContent;
            //TableRelation = "Temp Service Header"."No." where("Customer No." = field("Customer No."), "Request Type" = filter("Information on Connection"));

            trigger OnLookup()
            var
                TempR: Page "Temp Requests";
            begin
                FillTempServiceHeaderTable(); // popuni Temp tabelu
                TempServiceHeader.Reset();
                TempR.SetTableView(TempServiceHeader);
                TempR.LookupMode(true);
                if TempR.RunModal() = ACTION::LookupOK then begin
                    TempR.GetRecord(TempServiceHeader);
                    Rec."Information Number" := TempServiceHeader."No.";
                    Rec."Source Table Inf Number" := TempServiceHeader."Source Table";
                    Rec.Validate("Information Number");
                end;
            end;

            trigger OnValidate()
            var
                myInt: Integer;
                SH: record "Service Header";
                SIH: Record "Service Invoice Header";
            begin
                if Rec."Information Number" <> '' then begin
                    if Rec."Source Table Inf Number" = Format(DATABASE::"Service Header") then begin
                        SH.reset;
                        SH.SetFilter("No.", '%1', "Information Number");
                        if sh.FindFirst() then begin
                            rec."kW Power" := sh."kW Power";
                            rec.Land := sh.Land;
                            rec."Catastral Municipality" := sh."Catastral Municipality";
                            rec."Catastral Municipality Name" := sh."Catastral Municipality Name";
                            rec."DGM Diameter" := sh."DGM Diameter";
                            rec.validate("Service Line Diameter", sh."Service Line Diameter");
                            rec.validate("Measure Point Pressure", sh."Measure Point Pressure");
                            rec.validate("G Gauge Size", sh."G Gauge Size");
                        end;
                    end else
                        if Rec."Source Table Inf Number" = Format(DATABASE::"Service Invoice Header") then begin
                            SIH.reset;
                            SIH.SetFilter("No.", '%1', "Information Number");
                            if SIH.FindFirst() then begin
                                rec."kW Power" := SIH."kW Power";
                                rec.Land := SIH.Land;
                                rec."Catastral Municipality" := SIH."Catastral Municipality";
                                rec."Catastral Municipality Name" := SIH."Catastral Municipality Name";
                                rec."DGM Diameter" := SIH."DGM Diameter";
                                rec."Service Line Diameter" := FORMAT(SIH."Service Line Diameter");
                                rec.validate("Measure Point Pressure", SIH."Measure Point Pressure");
                                rec.validate("G Gauge Size", SIH."G Gauge Size");
                            end;
                        end;
                end else begin
                    //Ako je polje broj informacije prazno, tada i obriši vrijednosti iz ovih polja:
                    rec."kW Power" := 0;
                    rec.Land := '';
                    rec."Catastral Municipality" := '';
                    rec."Catastral Municipality Name" := '';
                    rec."DGM Diameter" := 0;
                    rec."Service Line Diameter" := '';
                    //rec.validate("Measure Point Pressure", ENUM::Pressure::" ");ž
                    rec.validate("Measure Point Pressure", '');
                    rec.validate("G Gauge Size", '');
                end;
            end;
        }
        field(70070; "Project Accordance"; Text[250])
        {
            Caption = 'Project Accordance', Comment = 'Saglanost na projekat nadležne institucije';
            DataClassification = CustomerContent;
        }
        field(70071; "Chimney Expert Opinion"; Text[250])
        {
            Caption = 'Chimney Expert Opinion', Comment = 'Stručni nalaz dimnjačara';
            DataClassification = CustomerContent;
        }
        field(70072; "Request Department"; Code[20])
        {
            Caption = 'Request Department', Comment = 'Org. jedinica pošiljaoca';
            DataClassification = CustomerContent;
            TableRelation = Department.Code;

            trigger OnValidate()
            var
                myInt: Integer;
                Departmetn: Record Department;
                OrgSH: Record "ORG Shema";
            begin
                OrgSH.Reset();
                OrgSH.SetFilter("Date From", '<=%1', today);
                OrgSH.SetCurrentKey("Date From");
                OrgSH.Ascending;
                Departmetn.Reset();
                if orgsh.FindLast() then
                    Departmetn.SetFilter("ORG Shema", '%1', OrgSH.Code);
                Departmetn.SetFilter(Code, '%1', "Request Department");
                if Departmetn.FindFirst() then
                    "Request Department Name" := Departmetn.Description
                else
                    "Request Department Name" := '';

            end;
        }
        field(70073; "Request Department Name"; Text[150])
        {
            Caption = 'Request Department Name', Comment = 'Naziv org. jedinice pošiljaoca';
            //  FieldClass = FlowField;
            //  CalcFormula = lookup(Department.Description where(Code = field("Request Department")));
            Editable = false;
        }
        field(70074; "PPZ for Building"; Boolean)
        {
            Caption = 'PPZ for Building', Comment = 'PPZ za zgradu';
            DataClassification = CustomerContent;
        }
        field(70075; "G Size"; Text[250])
        {
            Caption = 'G Size', Comment = 'Veličina G';
            DataClassification = CustomerContent;
        }
        field(70076; "Vertical"; Text[250])
        {
            Caption = 'Vertical', Comment = 'Vertikala';
            DataClassification = CustomerContent;
        }
        field(70077; "Responsible Contact"; Text[250])
        {
            Caption = 'Responsible Contact', Comment = 'Odgovorno lice';
            DataClassification = CustomerContent;
        }
        field(70078; "Welder"; Code[20])
        {
            Caption = 'Welder', Comment = 'Zavarivač';
            DataClassification = CustomerContent;
            TableRelation = Contact where("Type Relation" = const(Welder));
        }
        field(70079; "Welder Name"; Text[100])
        {
            Caption = 'Welder Name', Comment = 'Ime zavarivača';
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field(Welder)));
            Editable = false;
        }
        field(70080; "Press Conn. Tool"; Text[250])
        {
            Caption = 'Press Conn. Tool', Comment = 'Alat za pres spoj';
            DataClassification = CustomerContent;
        }
        field(70081; "Execution Protocol No."; text[20])
        {
            Caption = 'Execution Protocol No.', Comment = 'Broj protokola izvođača';
            DataClassification = CustomerContent;
        }
        field(70082; "According to Legislation"; Text[250])
        {
            Caption = 'According to Legislation', Comment = 'U skladu s propisima';
            DataClassification = CustomerContent;
        }
        field(70083; "Welder Atest"; Boolean)
        {
            Caption = 'Welder Atest', Comment = 'Atest varioca';
            DataClassification = CustomerContent;
        }
        field(70085; "Request Sent to Sarajevogas"; Boolean)
        {
            Caption = 'Request Sent to Sarajevogas', Comment = 'Zahtjev upućen Sarajevogasu';
            DataClassification = CustomerContent;
        }
        field(70086; "Request Sent to VIK"; Boolean)
        {
            Caption = 'Request Sent to VIK', Comment = 'Zahtjev upućen VIK';
            DataClassification = CustomerContent;
        }
        field(70087; "Request Sent to Toplane"; Boolean)
        {
            Caption = 'Request Sent to Toplane', Comment = 'Zahtjev upućen Toplane';
            DataClassification = CustomerContent;
        }
        field(70088; "Request Sent to RAD"; Boolean)
        {
            Caption = 'Request Sent to RAD', Comment = 'Zahtjev upućen RAD';
            DataClassification = CustomerContent;
        }
        field(70089; Classification; Text[50])
        {
            Caption = 'Classification', Comment = 'Klasifikacija';
            DataClassification = CustomerContent;
        }
        field(70090; "Registry No."; Text[10])
        {
            Caption = 'Registry No.', Comment = 'R. br. u registratoru';
            DataClassification = CustomerContent;
        }
        field(70091; "Entry Person"; Text[250])
        {
            Caption = 'Entry Person', Comment = 'Referent unosa';
            DataClassification = CustomerContent;
        }
        field(70092; "Change Person"; Text[250])
        {
            Caption = 'Change Person', Comment = 'Referent izmjene';
            DataClassification = CustomerContent;
        }
        field(70093; Number; Integer)
        {
            Caption = 'Number';
            DataClassification = CustomerContent;
        }
        field(70094; GeoID; Integer)
        {
            Caption = 'GeoID', Locked = true;
            DataClassification = CustomerContent;
        }
        field(70095; "Registry Code"; Text[10])
        {
            Caption = 'Registry Code', Comment = 'Registrator';
            DataClassification = CustomerContent;
        }
        field(70096; "Archive Date"; Date)
        {
            Caption = 'Archive Date', Comment = 'Datum arhive';
            DataClassification = CustomerContent;
        }
        field(70097; "Entry Date"; Date)
        {
            Caption = 'Entry Date', Comment = 'Datum unosa';
            DataClassification = CustomerContent;
        }
        field(70098; "Change Date"; Date)
        {
            Caption = 'Change Date', Comment = 'Datum izmjene';
            DataClassification = CustomerContent;
        }
        field(70099; "Bill type"; Code[20]) //ED
        {
            Caption = 'Bill Type';
            TableRelation = "Customer Templ.";
            trigger OnValidate()
            var
                CustomerTemp: Record "Customer Templ.";
            begin
                CustomerTemp.GET("bill type");
                If CustomerTemp."Bill Category" = CustomerTemp."Bill Category"::Resource
                then
                    validate("Customer Posting Group", 'USLUGE');

            end;
        }
        field(50089; "Bill Category"; enum "Bill Category ")
        {
            Caption = 'Bill Category';
        }
        field(70100; "Add Description"; Text[250]) //ED
        {
            Caption = 'Add Description';

        }


        field(70101; "Registration No."; Text[20]) //ED
        {
            Caption = 'Add Description';

        }
        field(70102; "Status_request"; enum "Information of processing") //ED
        {
            Caption = 'Status request';
            FieldClass = FlowField;
            CalcFormula = lookup("Status History 2"."Information of processing" where("Request No." = field("No."), Active = filter(true), "Source Table" = filter(5900), "Request Type" = field("Request Type")));


        }



        field(70103; "Contractor No"; Text[250])
        {
            Caption = 'Contractor';
        }
        field(70104; "Project Date"; Date)
        {
            Caption = 'Project Date';
        }
        field(70105; "Service Header UGI"; code[20])
        {
            Caption = 'Service Header UGI';
            TableRelation = "Service Header"."No." where("Customer No." = field("Customer No."), "Request Type" = filter("Project overview Request" | "Project and Energy Accordance"));
            trigger OnValidate()
            var
                myInt: Integer;
                SH: Record "Service Header";
            begin
                SH.Reset();
                SH.SetFilter("No.", '%1', rec."No.");
                if SH.FindFirst() then begin
                    "Service Date UGI" := sh."Document Date";
                    "Execution Company No." := sh."Execution Company No.";
                    "Execution Company Name" := sh."Execution Company Name";
                    "Execution Address" := sh."Execution Address";
                    "Execution Company Phone No." := sh."Execution Company Phone No.";
                    "Execution Protocol No." := sh."Execution Protocol No.";
                    "Planned W. Exec. Ending Date" := sh."Planned W. Exec. Ending Date";
                    "Planned W. Exec. Starting Date" := sh."Planned W. Exec. Starting Date";
                    "Contractor No" := sh."Contractor No";
                    "UGI type" := sh."UGI type";
                end;

            end;
        }

        field(70106; "Service Date UGI"; Date)
        {
            Caption = 'Service Date UGI';

        }
        field(70107; "UGI type"; enum UGI)
        {
            Caption = 'UGI Type';
        }
        field(70108; "Owner is Customer"; Boolean)
        {
            Caption = 'Owner is customer';
            trigger OnValidate()
            var
                myInt: Integer;
                ContactV: Record Contact;
                NoSe: Record "No. Series";
                RMSetup: Record "Marketing Setup";
                NoSeriesMgt: Codeunit NoSeriesExtented;
            begin
                if "Owner is Customer" = true then begin
                    ContactV.init;
                    NoSe.Reset();
                    NoSe.SetFilter("Type Relation", '%1', NoSe."Type Relation"::Owner);
                    if NoSe.FindFirst() then begin
                        NoSeriesMgt.InitSeries(NoSe.Code, xRec."No. Series", 0D, ContactV."No.", "No. Series");

                    end;

                    ContactV.validate(Name, "Bill-to Name");
                    ContactV.validate(Type, ContactV.Type::Person);
                    ContactV.Validate("Type Relation", ContactV."Type Relation"::Owner);
                    ContactV.Validate(Street, rec.Street);
                    ContactV.Validate("Street No.", rec."Street No.");

                    ContactV.insert;
                    rec.Validate("Owner No.", ContactV."No.");
                end;

            end;
        }

        field(70109; "Execution Protocol No. Text"; Text[250])
        {
            Caption = 'Execution Protocol No.', Comment = 'Broj protokola izvođača';
            DataClassification = CustomerContent;
        }

        field(70110; "No. for Execution"; Code[20])
        {
            Caption = 'No. for Execution';


        }
        field(70111; "Date for Execution"; Date)
        {
            Caption = 'No. for Execution';

        }

        field(70112; "First view No."; Code[20])
        {
            Caption = 'First view No.';

        }
        field(70113; "First view date"; Date)
        {
            Caption = 'First view date';

        }

        //ĐK 

        field(70115; "Prep. Process. Empl. Name."; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparation - Processing Employee Name';

        }
        field(70116; "Prep. Contr. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparation - Controlling Employee Name';

        }
        field(70117; "Prep. Verif. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparation - Verification Employee Name';

        }
        field(70118; "Real. Process. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Processing Employee Name';

        }
        field(70119; "Real. Contr. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Controlling Employee Name';

        }
        field(70120; "Real. Verif. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Verification Employee Name';

        }
        field(70121; "Firefight Accordance No."; Text[250])
        {
            Caption = 'Firefight Accordance No.', Comment = 'Protipožarna saglasnost broj';
            DataClassification = CustomerContent;
        }
        field(70122; "Measuring Area 1"; Decimal)
        {
            Caption = 'Measuring Area 1';
            DecimalPlaces = 1 : 3;
        }
        field(70123; "Measuring Area 2"; Decimal)
        {
            Caption = 'Measuring Area 2';
        }
        field(70124; "Document No."; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("A-B Attachments" where(Code = field("No."), Source = filter("Service Order"), Type = filter("Service Order")));


        }
        field(70125; "Catastral Municipality"; Code[20])
        {
            Caption = 'Catastral Municipality';
            TableRelation = Municipality.Code where(Type = filter(KO));
            trigger OnValidate()
            var
                myInt: Integer;
                Mun: Record Municipality;
            begin
                mun.Reset();
                Mun.SetFilter(Type, '%1', mun.Type::KO);
                mun.SetFilter(code, '%1', "Catastral Municipality");
                if mun.FindFirst() then
                    "Catastral Municipality Name" := mun.Name
                else
                    "Catastral Municipality Name" := '';

            end;
        }
        field(70126; "Catastral Municipality Name"; Text[250])
        {
            Caption = 'Catastral Municipality';
            Editable = false;
            //   FieldClass = FlowField;
            // CalcFormula = lookup(Municipality.Name where(Type = filter(KO), Code = field("Catastral Municipality")));
            // TableRelation = Municipality.Code where(Type = filter(KO));
        }
        field(70127; "Connection to"; Option)
        {
            Caption = 'Connection to';
            OptionMembers = " ","Distribution gas line","Service gas line";
            OptionCaption = ' ,Distribution gas line,Service gas line';
        }

        field(70128; "Archived"; Boolean)
        {
            Caption = 'Archived';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Archived = true then
                    "Archive Date" := today
                else
                    "Archive Date" := 0D;

            end;
        }

        field(70130; "GEO WorkPlaces"; Text[250])
        {
            Caption = 'GEO WorkPlaces';
            TableRelation = "GEO WorkPlace".Description;

            trigger OnValidate()
            var
                myInt: Integer;
                GEO: Record "GEO WorkPlace";
            begin
                geo.reset;
                geo.SetFilter(Description, '%1', "GEO WorkPlaces");
                if geo.FindFirst() then
                    "GEO WorkPlaces Code" := geo.code
                else
                    "GEO WorkPlaces Code" := '';
            end;
        }
        field(70132; "GEO WorkPlaces Code"; code[20])
        {
            Caption = 'GEO WorkPlaces';
            TableRelation = "GEO WorkPlace".Code;

            trigger OnValidate()
            var
                myInt: Integer;
                GEO: Record "GEO WorkPlace";
            begin
                geo.reset;
                geo.SetFilter(code, '%1', "GEO WorkPlaces Code");
                if geo.FindFirst() then
                    "GEO WorkPlaces" := geo.Description
                else
                    "GEO WorkPlaces" := '';
            end;
        }

        field(70133; "Marking Finished"; Boolean)
        {
            Caption = 'Finished', Comment = 'Završeno';
            DataClassification = CustomerContent;
        }
        field(70134; "Mark Method"; enum "Recording Method")
        {
            DataClassification = CustomerContent;
            Caption = 'Marking Method';
        }
        field(70135; "Mark DGM Total Length"; Decimal)
        {
            Caption = 'DGM Total Length', Comment = 'Ukupna dužina DGM';
            DataClassification = CustomerContent;
        }
        field(70136; "Mark PG Total Length"; Decimal)
        {
            Caption = 'PG Total Length', Comment = 'Ukupna dužina PG';
            DataClassification = CustomerContent;
        }


        field(70137; "Marking Fully Finished"; Boolean)
        {
            Caption = 'Fully Finished', Comment = 'Završeno u cijelosti';
            DataClassification = CustomerContent;
        }
        field(70138; "Marking Start Date"; DateTime)
        {
            Caption = 'Start Date', Comment = 'Vrijeme početka';
            DataClassification = CustomerContent;
        }
        field(70139; "Marking End Date"; DateTime)
        {
            Caption = 'End Date', Comment = 'Vrijeme završetka';
            DataClassification = CustomerContent;
        }
        field(70140; "Mark No. of Connections"; Integer)
        {
            Caption = 'No. of Connections', Comment = 'Broj priključaka';
            DataClassification = CustomerContent;
        }

        field(70141; "Class"; Option)
        {
            Caption = 'Class';
            OptionMembers = " ","T","T E-um","T E-ins","K";
            OptionCaption = ' ,T,T E-um,T E-ins,K';
        }

        //obilježavanje
        field(70142; "Marking Done"; Boolean)
        {
            Caption = 'Finished', Comment = 'Završeno';
            DataClassification = CustomerContent;
        }
        field(70143; "Marking Method 2"; enum "Recording Method")
        {
            DataClassification = CustomerContent;
            Caption = 'Marking Method';
        }
        field(70144; "Marking DGM Total Length"; Decimal)
        {
            Caption = 'DGM Total Length', Comment = 'Ukupna dužina DGM';
            DataClassification = CustomerContent;
        }
        field(70145; "Marking PG Total Length"; Decimal)
        {
            Caption = 'PG Total Length', Comment = 'Ukupna dužina PG';
            DataClassification = CustomerContent;
        }


        field(70146; "Marking Fully Done"; Boolean)
        {
            Caption = 'Fully Finished', Comment = 'Završeno u cijelosti';
            DataClassification = CustomerContent;
        }
        field(70147; "Marking Start Date - 2"; DateTime)
        {
            Caption = 'Start Date', Comment = 'Vrijeme početka';
            DataClassification = CustomerContent;
        }
        field(70148; "Marking End Date 2"; DateTime)
        {
            Caption = 'End Date', Comment = 'Vrijeme završetka';
            DataClassification = CustomerContent;
        }
        field(70149; "Marking No. of Connections"; Integer)
        {
            Caption = 'No. of Connections', Comment = 'Broj priključaka';
            DataClassification = CustomerContent;
        }
        field(70150; "Spray"; Integer)
        {
            Caption = 'Spray';
        }
        field(70151; "Harpoon"; Integer)
        {
            Caption = 'Harpoon';
        }
        field(70152; "Bolcna"; Integer)
        {
            Caption = 'Bolcna';
        }
        field(70153; "Palette"; Integer)
        {
            Caption = 'Palette';
        }

        //korištena oprema
        field(70154; "Trimble M3"; boolean)
        {
            caption = 'Trimble M3';
        }
        field(70155; "Sokkia SET2030"; boolean)
        {
            Caption = 'Sokkia SET2030';
        }
        field(70156; "Zeiss REC ELTA 15"; Boolean)
        {
            Caption = 'Zeiss REC ELTA 15';
        }
        field(70157; "GPS L1 - Promark 3"; Boolean)
        {
            Caption = 'GPS L1 - Promark 3';
        }
        field(70158; "GPS - Others"; Boolean)
        {
            Caption = 'GPS - others';
        }
        field(70159; "GPS TRIMBLE R8S"; Boolean)
        {
            Caption = 'GPS TRIMBLE R8S';
        }
        field(70160; "TRIMBLE C5"; Boolean)
        {
            Caption = 'Trimble C5';
        }
        field(70161; "Sokkia 5 m"; Boolean)
        {
            Caption = 'Sokkia 5 m';
        }
        field(70162; "Sokkia 3.8 m"; Boolean)
        {
            Caption = 'Sokkia 3.8 m';
        }
        field(70163; "Sokkia 2.7 m"; Boolean)
        {
            Caption = 'Sokkia 2.7 m';
        }
        field(70164; "Wild 2.15 m"; Boolean)
        {
            Caption = 'Wild 2.15 m';
        }
        field(70165; "Sokkia 1x"; Boolean)
        {
            Caption = 'Sokkia 1x';
        }
        field(70166; "Zeiss 3x"; Boolean)
        {
            Caption = 'Zeiss 3x';
        }
        field(70177; "Zeiss 1x"; Boolean)
        {
            Caption = 'Zeiss 1x';
        }
        field(70178; "Wild 1x"; Boolean)
        {
            Caption = 'Wild 1x';
        }
        field(70179; "50 m"; Boolean)
        {
            caption = '50 m';
        }
        field(70180; "30 m"; Boolean)
        {
            Caption = '30 m';
        }
        field(70181; "20 m"; Boolean)
        {
            Caption = '20 m';
        }
        field(70182; "Leica Disto"; Boolean)
        {
            Caption = 'Leica Disto';
        }
        field(70183; "Accessories for Centering"; Boolean)
        {
            Caption = 'Accessories for forced Centering';
        }

        field(70184; "Spray -R"; Integer)
        {
            Caption = 'Spray';
        }
        field(70185; "Harpoon -R"; Integer)
        {
            Caption = 'Harpoon';
        }
        field(70186; "Bolcna -R"; Integer)
        {
            Caption = 'Bolcna';
        }
        field(70187; "Palette -R"; Integer)
        {
            Caption = 'Palette';
        }

        field(70188; "Trimble M3 -R"; boolean)
        {
            caption = 'Trimble M3';
        }
        field(70189; "Sokkia SET2030 -R"; boolean)
        {
            Caption = 'Sokkia SET2030';
        }
        field(70190; "Zeiss REC ELTA 15 -R"; Boolean)
        {
            Caption = 'Zeiss REC ELTA 15';
        }
        field(70191; "GPS L1 - Promark 3 -R"; Boolean)
        {
            Caption = 'GPS L1 - Promark 3';
        }
        field(70192; "GPS - Others - R"; Boolean)
        {
            Caption = 'GPS - others';
        }
        field(70193; "GPS TRIMBLE R8S -R"; Boolean)
        {
            Caption = 'GPS TRIMBLE R8S';
        }
        field(70194; "TRIMBLE C5 -R"; Boolean)
        {
            Caption = 'Trimble C5';
        }
        field(70195; "Sokkia 5 m -R"; Boolean)
        {
            Caption = 'Sokkia 5 m';
        }
        field(70196; "Sokkia 3.8 m -R"; Boolean)
        {
            Caption = 'Sokkia 3.8 m';
        }
        field(70197; "Sokkia 2.7 m -R"; Boolean)
        {
            Caption = 'Sokkia 2.7 m';
        }
        field(70198; "Wild 2.15 m -R"; Boolean)
        {
            Caption = 'Wild 2.15 m';
        }
        field(70199; "Sokkia 1x-R"; Boolean)
        {
            Caption = 'Sokkia 1x';
        }
        field(70200; "Zeiss 3x -R"; Boolean)
        {
            Caption = 'Zeiss 3x';
        }
        field(70201; "Zeiss 1x-R"; Boolean)
        {
            Caption = 'Zeiss 1x';
        }
        field(70202; "Wild 1x-R"; Boolean)
        {
            Caption = 'Wild 1x';
        }
        field(70203; "50 m-R"; Boolean)
        {
            caption = '50 m';
        }
        field(70204; "30 m-R"; Boolean)
        {
            Caption = '30 m';
        }
        field(70205; "20 m-R"; Boolean)
        {
            Caption = '20 m';
        }
        field(70206; "Leica Disto-R"; Boolean)
        {
            Caption = 'Leica Disto';
        }
        field(70207; "Accessories for Centering-R"; Boolean)
        {
            Caption = 'Accessories for forced Centering';
        }
        field(70208; "Reason For Service Order"; Text[250])
        {
            Caption = 'Reason For Service Order';
            TableRelation = "Dismantling Reason".Description where(type = filter("Reason for Service Order"));
        }
        field(70209; "Remark For Service Order"; Text[250])
        {
            Caption = 'Remark For Service Order';

        }
        field(70210; "Supervisory Board"; text[250])
        {
            Caption = 'Supervisory Board';
        }
        field(70211; "Holder of works"; text[250])
        {
            Caption = 'Holder of works';
            TableRelation = Department.Description;

            TestTableRelation = false;
            ValidateTableRelation = false;

        }
        field(70212; "RN Source"; enum "RN Source")
        {
            Caption = 'RN Source';
        }
        field(70213; "Investor Code"; Code[20])
        {
            Caption = 'GEO WorkPlaces';
            TableRelation = Contact."No." where("Type Relation" = filter(Investor));

            trigger OnValidate()
            var
                myInt: Integer;
                GEO: Record "GEO WorkPlace";
                ContactR: Record Contact;
            begin

                ContactR.Reset();
                ContactR.setfilter("No.", '%1', "Investor Code");
                ContactR.setfilter("Type Relation", '%1', ContactR."Type Relation"::Investor);
                if ContactR.findfirst
                  then begin
                    "Investor Name" := ContactR."Name";
                end
                else begin
                    "Investor Name" := '';
                end;
            end;
        }

        field(70214; "Investor Name"; Text[250])
        {
            Caption = 'GEO WorkPlaces';
            //   TableRelation = Contact."No." where ("Type Relation"=filter(Investor));

            trigger OnValidate()
            var
                myInt: Integer;
                GEO: Record "GEO WorkPlace";
            begin

            end;
        }

        field(70215; "GEO Constructor Manager"; Code[20])
        {
            Caption = 'GEO WorkPlaces';
            TableRelation = Contact."No." where("Type Relation" = filter("GEO Construction Manager"));

            trigger OnValidate()
            var
                myInt: Integer;
                GEO: Record "GEO WorkPlace";
                ContactR: Record contact;
            begin


                ContactR.Reset();
                ContactR.setfilter("No.", '%1', "GEO Constructor Manager");
                ContactR.setfilter("Type Relation", '%1', ContactR."Type Relation"::"GEO Construction Manager");
                if ContactR.findfirst then begin
                    "GEO Constructor Manager Name" := ContactR."Name";
                end
                else begin
                    "GEO Constructor Manager Name" := '';
                end;
            end;
        }
        field(70216; "GEO Constructor Manager Name"; Code[250])
        {
            Caption = 'GEO WorkPlaces';
            //TableRelation = Contact."No." where("Type Relation" = filter("GEO Construction Manager"));

            /*    trigger OnValidate()
                var
                    myInt: Integer;
                    GEO: Record "GEO WorkPlace";
                begin
                    geo.reset;
                    geo.SetFilter(Description, '%1', "GEO WorkPlaces");
                    if geo.FindFirst() then
                        "GEO Constructor Manager Name" := geo."GEO Construction Manager Name"
                    else
                        "GEO Constructor Manager Name" := '';
                end;*/
        }
        field(70217; "Sector"; Code[20])
        {
            Caption = 'Sector Code';
            TableRelation = Sector.Code;
            trigger OnValidate()
            var
                myInt: Integer;
                Sect: Record Sector;
            begin
                Sect.Reset();
                Sect.SetFilter(Code, '%1', Sector);
                Sect.SetCurrentKey("Last Date Modified");
                sect.Ascending;
                if sect.FindLast() then
                    "Sector Text" := sect.Description
                else
                    "Sector Text" := '';
            end;
        }
        field(70218; "Sector Text"; Text[250])
        {
            Caption = 'Sector Name';
            //TableRelation=Sector.Code;
        }

        field(70220; "Measure Point Pressure1"; enum Pressure2)
        {
            Caption = 'Measure Point Pressure', Comment = 'Pritisak na mjestu mjerenja';
            DataClassification = CustomerContent;
        }
        field(70221; "Protocol No."; Text[250])
        {
            Caption = 'Protocol No.', Comment = 'Pritisak na mjestu mjerenja';
            DataClassification = CustomerContent;
        }
        field(70222; "Chimney Expert Date"; Date)
        {
            Caption = 'Chimney Expert Date', Comment = 'Stručni nalaz dimnjačara';
            DataClassification = CustomerContent;
        }
        field(70223; "A-B"; Boolean)
        {
            Caption = 'A-B';
            DataClassification = CustomerContent;
        }
        field(70224; "A-B Entry"; code[20])
        {
            Caption = 'A-B Entry';
            DataClassification = CustomerContent;
        }
        //korištena oprema za obilježavanje

        field(70225; "Trimble M3 -O"; boolean)
        {
            caption = 'Trimble M3';
        }
        field(70226; "Sokkia SET2030 -O"; boolean)
        {
            Caption = 'Sokkia SET2030';
        }
        field(70227; "Zeiss REC ELTA 15 -O"; Boolean)
        {
            Caption = 'Zeiss REC ELTA 15';
        }
        field(70228; "GPS L1 - Promark 3 -O"; Boolean)
        {
            Caption = 'GPS L1 - Promark 3';
        }
        field(70229; "GPS - Others - O"; Boolean)
        {
            Caption = 'GPS - others';
        }
        field(70230; "GPS TRIMBLE R8S -O"; Boolean)
        {
            Caption = 'GPS TRIMBLE R8S';
        }
        field(70231; "TRIMBLE C5 -O"; Boolean)
        {
            Caption = 'Trimble C5';
        }
        field(70232; "Sokkia 5 m -O"; Boolean)
        {
            Caption = 'Sokkia 5 m';
        }
        field(70233; "Sokkia 3.8 m -O"; Boolean)
        {
            Caption = 'Sokkia 3.8 m';
        }
        field(70234; "Sokkia 2.7 m -O"; Boolean)
        {
            Caption = 'Sokkia 2.7 m';
        }
        field(70235; "Wild 2.15 m -O"; Boolean)
        {
            Caption = 'Wild 2.15 m';
        }
        field(70236; "Sokkia 1x-O"; Boolean)
        {
            Caption = 'Sokkia 1x';
        }
        field(70237; "Zeiss 3x -O"; Boolean)
        {
            Caption = 'Zeiss 3x';
        }
        field(70238; "Zeiss 1x-O"; Boolean)
        {
            Caption = 'Zeiss 1x';
        }
        field(70239; "Wild 1x-O"; Boolean)
        {
            Caption = 'Wild 1x';
        }
        field(70240; "50 m-O"; Boolean)
        {
            caption = '50 m';
        }
        field(70241; "30 m-O"; Boolean)
        {
            Caption = '30 m';
        }
        field(70242; "20 m-O"; Boolean)
        {
            Caption = '20 m';
        }
        field(70243; "Leica Disto-O"; Boolean)
        {
            Caption = 'Leica Disto';
        }
        field(70244; "Accessories for Centering-O"; Boolean)
        {
            Caption = 'Accessories for forced Centering';
        }


        field(70245; "Spray -O"; Integer)
        {
            Caption = 'Spray';
        }
        field(70246; "Harpoon -O"; Integer)
        {
            Caption = 'Harpoon';
        }
        field(70247; "Bolcna -O"; Integer)
        {
            Caption = 'Bolcna';
        }
        field(70248; "Palette -O"; Integer)
        {
            Caption = 'Palette';
        }
        field(70249; "Employee Prepare Responsible"; Code[20])
        {
            Caption = 'Employee Prepare Responsible', Comment = 'Odgovorni zaposlenik';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(70250; "Employee Control Responsible"; Code[20])
        {
            Caption = 'Employee Control Responsible', Comment = 'Odgovorni zaposlenik';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(70251; "Evidential Number"; Code[20])
        {
            Caption = 'Evidential Number';


        }
        field(70252; "Date of ticket"; date)
        {
            Caption = 'Date of ticket';
        }
        field(70253; "Time of ticket"; time)
        {
            Caption = 'Time of ticket';
        }

        field(70254; "Date of sender"; date)
        {
            Caption = 'Date of sender';
        }
        field(70255; "Time of sender"; time)
        {
            Caption = 'Time of sender';
        }
        field(70256; "Control Done"; Boolean)
        {
            Caption = 'Control Done';

            trigger OnValidate()
            var
                myInt: Integer;
                UserS: record "User Setup";
            begin
                UserS.reset;
                UserS.setfilter("User ID", '%1', UserId);
                if UserS.FindFirst() then begin
                    if rec."Real. Contr. Empl. No." <> UserS."Employee No. for Wage" then
                        Error(Text007);

                end;

                validate("Control Date", today);

            end;
        }

        field(70257; "Verif Done"; Boolean)
        {
            Caption = 'Verif Done';

            trigger OnValidate()
            var
                myInt: Integer;
                UserS: record "User Setup";
            begin
                UserS.reset;
                UserS.setfilter("User ID", '%1', UserId);
                if UserS.FindFirst() then begin
                    if rec."Real. Verif. Empl. No." <> UserS."Employee No. for Wage" then
                        Error(Text007);

                end;

                validate("Verif Date", today);
            end;
        }
        field(70258; "Realisation Done"; Boolean)
        {
            Caption = 'Realisation Done';
            trigger OnValidate()
            var
                myInt: Integer;
                Sline: Record "Service Item Line";
                ErrorF: record "Service Item Line";
            begin


                TestField("Address");
                TestField("Address 2");

                ErrorF.reset;
                ErrorF.setfilter("Document No.", '%1', rec."No.");
                ErrorF.setfilter("Document Type", '%1', rec."Document Type");
                if not ErrorF.findfirst then begin
                    error('Ne možete kreirati radni nalog bez podataka o mjernom mjestu/lokaciji ili gasnoj stanici!');
                end;

                if "RN Source" = "RN Source"::" " then
                    error('Vrsta troška mora biti popunjena!');

                rec.validate("Done Date", today);

                /*   Sline.Reset();
                   Sline.SetFilter("Reason for dismantling New", '<>%1', '');

                   Sline.SetFilter(Applied, '%1', false);

                   if Sline.FindSet() then
                       repeat
                           sline.Validate(Applied, true);
                           sline.modify;
                       until Sline.Next() = 0;*/

            end;
        }

        //kraj


        field(70260; "Sent to ZIK GEO"; Date)
        {
            Caption = 'Sent to ZIK', Comment = 'Poslano u ZIK';
            DataClassification = CustomerContent;
        }
        field(70261; "Received from ZIK GEO"; Date)
        {
            Caption = 'Received from ZIK', Comment = 'Preuzeto iz ZIK';
            DataClassification = CustomerContent;
        }
        field(70267; "Filters by Fixed Asset"; code[20])
        {
            Caption = 'Filters by Fixed Asset';

        }
        field(70262; "Filters by Gauge"; Text[250])
        {
            Caption = 'Filters by Gauge';
            // TableRelation = "Installation History"."Inventory Number" where(type = filter(Gauge), active = filter(true));

            trigger OnValidate()
            var
                myInt: Integer;
                IH: Record "Installation History";
                ServiceItemLine: Record "Service Item Line";
                ServiceItemLineInit: Record "Service Item Line";
                CUF: Record Customer;
            begin

                if "Filters by Gauge" <> '' then begin
                    IH.Reset();
                    IH.SetFilter(InvterentoryFil, '%1', "Filters by Gauge");
                    ih.SetFilter(Type, '%1', ih.type::gauge);
                    ih.SetFilter(Active, '%1', true);
                    if ih.FindFirst() then begin
                        rec.Validate("Customer No.", ih."Customer No.");
                        rec."Filters by Measuring point" := ih."Measuring Point Code";
                        commit;
                        ServiceItemLine.Reset();
                        ServiceItemLine.SetFilter("Document No.", '%1', rec."No.");
                        ServiceItemLine.setfilter("Document Type", '%1', rec."Document Type");
                        ServiceItemLine.SetFilter(type, '%1', ServiceItemLine.type::MM);
                        if not ServiceItemLine.FindFirst() then begin
                            ServiceItemLineInit.init;
                            ServiceItemLineInit."Document No." := rec."No.";
                            ServiceItemLineInit."Document Type" := rec."Document Type";
                            ServiceItemLineInit.validate("Customer No.", ih."Customer No.");
                            ServiceItemLine."Type G_R" := ServiceItemLine."Type G_R"::Gauge;

                            ServiceItemLineInit.validate(type, ServiceItemLineInit.type::MM);
                            ServiceItemLineInit.Validate("Service Item No. - Relation", ih."Measuring Point Code");
                            CUF.reset;
                            CUF.SetFilter("No.", '%1', ServiceItemLineInit."Customer No.");
                            if CUF.FindFirst() then
                                ServiceItemLineInit."Customer Name" := CUF.Name;
                            ServiceItemLineInit.Insert();

                        end;
                    end;
                end;
            end;
        }
        field(70263; "Filters by Measuring point"; Code[20])
        {
            Caption = 'Filters by Measuring point';
            TableRelation = "Service Item"."No.";

            trigger OnValidate()
            var
                myInt: Integer;
                ServiceItemLine: record "Service Item Line";
                ServiceItemLineInit: record "Service Item Line";
                IH: Record "Service Item";
                CUF: Record Customer;
            begin
                if "Filters by Measuring point" <> '' then begin
                    IH.Reset();
                    IH.SetFilter("No.", '%1', "Filters by Measuring point");
                    if ih.FindFirst() then begin
                        rec.Validate("Customer No.", ih."Customer No.");
                        commit;
                        ServiceItemLine.Reset();
                        ServiceItemLine.setfilter("Document No.", '%1', rec."No.");
                        ServiceItemLine.setfilter("Document Type", '%1', rec."Document Type");
                        ServiceItemLine.SetFilter(type, '%1', ServiceItemLine.type::MM);
                        if not ServiceItemLine.FindFirst() then begin
                            ServiceItemLineInit.init;
                            ServiceItemLineInit."Document No." := rec."No.";
                            ServiceItemLineInit."Document Type" := rec."Document Type";
                            ServiceItemLineInit.validate("Customer No.", ih."Customer No.");
                            ServiceItemLineInit.validate(type, ServiceItemLineInit.type::MM);
                            ServiceItemLineInit.Validate("Service Item No. - Relation", ih."No.");
                            CUF.reset;
                            CUF.SetFilter("No.", '%1', ServiceItemLineInit."Customer No.");
                            if CUF.FindFirst() then
                                ServiceItemLineInit."Customer Name" := CUF.Name;
                            ServiceItemLineInit.Insert();
                        end;
                    end;
                end;

            end;
        }
        field(70264; "Calculation Code"; code[20])
        {
            Caption = 'Calculation Code';
        }
        field(70265; "Massive Code"; code[20])
        {
            Caption = 'Massive Code';
        }
        field(70266; "CZK Invoice Date"; Date)
        {
            Caption = 'CZK Date', Comment = 'Datum prijema u CZK';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Invoice Header"."Document Date" where("Order No." = field("CZK Request No.")));
            Editable = false;
        }

        field(70268; "Transfer Order"; Code[20])
        {
            Caption = 'Transfer Order';


        }

        field(70269; "Amount"; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Templates for CR';
            CalcFormula = sum("Service Line".Amount where("Document No." = field("No."), "Document Type" = field("Document Type")));

        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Service Line"."Amount Including VAT" WHERE("Document No." = FIELD("No."), "Document Type" = field("Document Type")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70270; "Done Date"; Date)
        {
            Caption = 'Done Date';
        }

        field(70271; "Control Date"; Date)
        {
            Caption = 'Control Date';

        }
        field(70272; "Verif Date"; Date)
        {
            Caption = 'Verif Date';

        }
        field(70273; "Location Name"; Text[250])
        {
            Caption = 'Location Name';
            FieldClass = FlowField;
            //naziv lokacije
            CalcFormula = lookup("Service Item Line".Address where("Document No." = field("No."), "Document Type" = field("Document Type")));

        }
        field(70274; "Service Item Line count"; Integer)
        {
            Caption = 'Service Item Line count';
            //brojac linija
            FieldClass = FlowField;
            CalcFormula = count("Service Item Line" where("Document No." = field("No."), "Document Type" = field("Document Type")));

        }

        field(70275; "Due Days Status"; Integer) //ED
        {
            Caption = 'Due Days Status';
            FieldClass = FlowField;
            CalcFormula = lookup("Status History 2"."Due days" where("Request No." = field("No."), Active = filter(true), "Source Table" = filter(5900), "Request Type" = field("Request Type")));


        }
        field(70276; "Need to reopen work order"; Boolean) //ED
        {
            Caption = 'Need to reopen work order';


        }

        field(70277; "Due Days Reopen"; Integer) //ED
        {
            Caption = 'Due Days Reopen';

        }
        field(70279; "Applied GEO WorkPlaces"; Boolean)
        {
            Caption = 'Applied Investor';
            trigger OnValidate()
            var

                myInt: Integer;
                ContactV: Record Contact;
                NoSe: Record "No. Series";
                NoSeriesMgt: Codeunit NoSeriesExtented;
                CU: Record Customer;
            begin
                if "Applied Investor" = true then begin

                    ContactV.init;
                    NoSe.Reset();
                    NoSe.SetFilter("Type Relation", '%1', NoSe."Type Relation"::"GEO Construction Manager");
                    if NoSe.FindFirst() then begin
                        NoSeriesMgt.InitSeries(NoSe.Code, xRec."No. Series", 0D, ContactV."No.", "No. Series");

                    end;

                    ContactV.validate(Name, name);
                    ContactV.validate(Type, ContactV.Type::Person);
                    ContactV.Validate("Type Relation", ContactV."Type Relation"::"GEO Construction Manager");
                    ContactV.Validate(Street, rec.Street);
                    ContactV.Validate("Street No.", rec."Street No.");
                    ContactV.validate("Mobile Phone No.", cu."Mobile Phone No.");
                    ContactV.validate("E-Mail", cu."E-Mail");

                    CU.Reset();
                    CU.SetFilter("No.", '%1', rec."Customer No.");
                    if cu.FindFirst() then
                        ContactV.Validate("Phone No.", cu."Customer Phone No.");

                    ContactV.insert;
                    Commit();
                    validate("GEO Constructor Manager", contactv."No.");

                end;

            end;
        }
        field(70280; "GPS Tersus"; boolean)
        {
            caption = 'GPS Tersus';
        }
        field(70286; "GPS Tersus (S)"; boolean)
        {
            caption = 'GPS Tersus (Recording)';
        }


        field(70287; "GPS Tersus (T)"; boolean)
        {
            caption = 'GPS Tersus (T)';
        }
        //Novi
        field(70302; "Topcon 2.15m"; boolean)
        {
            caption = 'Topcon 2.15m';
        }
        field(70303; "Topcon 2.15m (S)"; boolean)
        {
            caption = 'Topcon 2.15m (Recording)';
        }


        field(70304; "Topcon 2.15m (T)"; boolean)
        {
            caption = 'Topcon 2.15m (T)';
        }
        //kraj
        //3 nova topcona

        field(70299; "Topcon 1x"; boolean)
        {
            caption = 'Topcon 1x';
        }
        field(70300; "Topcon 1x (S)"; boolean)
        {
            caption = 'Topcon 1x (Recording)';
        }


        field(70301; "Topcon 1x (T)"; boolean)
        {
            caption = 'Topcon 1x (T)';
        }

        field(70296; "Topcon OS 201"; boolean)
        {
            caption = 'Topcon OS 201';
        }
        field(70297; "Topcon OS 201 (S)"; boolean)
        {
            caption = 'Topcon OS 201 (Recording)';
        }


        field(70298; "Topcon OS 201 (T)"; boolean)
        {
            caption = 'Topcon OS 201 (T)';
        }

        field(70288; "Folder yes"; Boolean)
        {
            Caption = 'Folder yes';
        }
        field(70289; "Contact Geo"; text[40])
        {
            Caption = 'Contact Geo';
            TableRelation = Contact."No." where("Type Relation" = filter(6 | 7 | 8 | 9 | 10 | 11 | 13 | 16 | 17 | 18));
            TestTableRelation = false;
            trigger OnValidate()
            var
                myInt: Integer;
                ContacF: record Contact;
            begin

                ContacF.reset;
                ContacF.SetFilter("No.", '%1', "Contact Geo");
                if contacf.FindFirst() then
                    "Contact Geo" := contacf.Name
                else
                    "Contact Geo" := '';

            end;
        }

        field(70294; "Construction Manager"; text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Construction Manager';
            TableRelation = Employee."No.";

            trigger OnValidate()
            var
                myInt: Integer;
                Emp: Record Employee;
            begin
                Emp.Reset();
                Emp.SetFilter("No.", '%1', "Construction Manager");
                if Emp.FindFirst() then
                    "Construction Manager Name" := Emp."Search Name"
                else
                    "Construction Manager" := '';

            end;

        }
        field(70295; "Construction Manager Name"; text[20])

        {
            DataClassification = CustomerContent;
            Caption = 'Construction Manager Name';
            TableRelation = Employee."Search Name";

            trigger OnValidate()
            var
                myInt: Integer;
                Emp: Record Employee;
            begin
                Emp.Reset();
                Emp.SetFilter("Search Name", '%1', "Construction Manager Name");
                if Emp.FindFirst() then
                    "Construction Manager" := Emp."No."
                else
                    "Construction Manager" := '';

            end;
        }


        field(70281; "Prep Control Done"; Boolean)
        {
            Caption = 'Prep Done';

            trigger OnValidate()
            var
                myInt: Integer;
                UserS: record "User Setup";
            begin
                UserS.reset;
                UserS.setfilter("User ID", '%1', UserId);
                if UserS.FindFirst() then begin
                    if rec."Prep. Contr. Empl. No." <> UserS."Employee No. for Wage" then
                        Error(Text007);

                end;

                validate("Prep Control Date", today);

            end;
        }

        field(70282; "Prep Verif Done"; Boolean)
        {
            Caption = 'Prep Verif Done';

            trigger OnValidate()
            var
                myInt: Integer;
                UserS: record "User Setup";
            begin
                UserS.reset;
                UserS.setfilter("User ID", '%1', UserId);
                if UserS.FindFirst() then begin
                    if rec."Prep. Verif. Empl. No." <> UserS."Employee No. for Wage" then
                        Error(Text007);

                end;

                validate("Prep Verif Date", today);
            end;
        }
        field(70283; "Prep Realisation Done"; Boolean)
        {
            Caption = 'Prep Realisation Done';
            trigger OnValidate()
            var
                myInt: Integer;
                Sline: Record "Service Item Line";
            begin
                rec.validate("Prep Done Date", today);


            end;
        }


        field(70284; "Prep Done Date"; Date)
        {
            Caption = 'Prep Done Date';
        }

        field(70285; "Prep Control Date"; Date)
        {
            Caption = 'Prep Control Date';

        }
        field(7028; "Prep Verif Date"; Date)
        {
            Caption = 'Prep Verif Date';

        }

        //kraj
        field(70278; "Applied Investor"; Boolean)
        {
            Caption = 'Applied Investor';
            trigger OnValidate()
            var

                myInt: Integer;
                ContactV: Record Contact;
                NoSe: Record "No. Series";
                NoSeriesMgt: Codeunit NoSeriesExtented;
                CU: Record Customer;
            begin
                if "Applied Investor" = true then begin

                    ContactV.init;
                    NoSe.Reset();
                    NoSe.SetFilter("Type Relation", '%1', NoSe."Type Relation"::Investor);
                    if NoSe.FindFirst() then begin
                        NoSeriesMgt.InitSeries(NoSe.Code, xRec."No. Series", 0D, ContactV."No.", "No. Series");

                    end;

                    ContactV.validate(Name, name);
                    ContactV.validate(Type, ContactV.Type::Person);
                    ContactV.Validate("Type Relation", ContactV."Type Relation"::Investor);
                    ContactV.Validate(Street, rec.Street);
                    ContactV.Validate("Street No.", rec."Street No.");
                    ContactV.validate("Mobile Phone No.", cu."Mobile Phone No.");
                    ContactV.validate("E-Mail", cu."E-Mail");

                    CU.Reset();
                    CU.SetFilter("No.", '%1', rec."Customer No.");
                    if cu.FindFirst() then
                        ContactV.Validate("Phone No.", cu."Customer Phone No.");

                    ContactV.insert;
                    Commit();
                    validate("Investor Code", contactv."No.");



                end;
            end;

        }
        field(70290; Initials; Text[30])
        {
            Caption = 'Initials';
        }
        field(70293; NC; Text[250])
        {
            Caption = 'NC';
        }
        field(70291; "Number of Floors"; Text[250])
        {
            Caption = 'Number of Floors';
        }
        field(70292; "Consumption Category"; Text[250])
        {
            Caption = 'Consumption Category';
        }
        FIELD(70923; "Gas Installation Data"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Gas Installation Data" WHERE("Customer No." = field("Customer No.")));
        }

        FIELD(70933; "Gas Installation Data today"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Gas Installation Data" WHERE("Customer No." = field("Customer No."),
            Date = field("Today date")));
        }

        FIELD(70934; "Today date"; Date)
        {
            FieldClass = FlowFilter;


        }

        FIELD(70935; "GID Finish Date"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Gas Installation Data" WHERE("Customer No." = field("Customer No."),
            Date = field("Finishing Date")));
        }




        field(70924; "Service Line RN Team"; code[20])
        {
            FieldClass = FlowField;
            Caption = 'Service Line RN Team';
            CalcFormula = lookup("Service Line RN"."Resource No." where("Document No." = field("No."), "Request Resource Type1" = filter("Team Leader")));
        }
        field(70925; "Service Line RN Team Name"; Text[250])
        {
            FieldClass = FlowField;
            Caption = 'Service Line RN Team Name';
            CalcFormula = lookup("Service Line RN"."Resource Name" where("Document No." = field("No."), "Request Resource Type1" = filter("Team Leader")));
        }
        field(70926; "Source Table Inf Number"; Text[50])
        {
            // U ovo polje se sejva Source Table za polje Information Number, kako bi razlikovalo izmedju običnog service headera i proknjižene serv fakture
            Editable = false;
        }
        field(70927; "Mandatory approval"; boolean)
        {
            Caption = 'Mandatory approval for fire and explosion protection';
        }
        field(70928; "Work Order Registry No. letter"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order Registry No. letter', Comment = 'Broj u registratoru slovima';
        }
        field(70929; "Type of Investition"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Type of Investition';
            TableRelation = InvestitionTable.Code;

            trigger OnValidate()
            var
                TypeOfInvestitionRec: Record InvestitionTable;
            begin
                /*  if TypeOfInvestitionRec.Get("Type of Investition") then
                      "Type of Invest. Description" := TypeOfInvestitionRec.Description
                  else
                      "Type of Invest. Description" := '';*/

                if TypeOfInvestitionRec.Get("Type of Investition") then
                    "Type of Investition" := TypeOfInvestitionRec.Description
                else
                    "Type of Investition" := '';

            end;
        }
        field(70930; "Sent Mail"; Boolean)
        {
            Caption = 'Sent Mail';
        }
        field(70931; "Bill-to Registration No."; Text[20])
        {
            Caption = 'Bill-to registration no.';
        }

        field(70932; "Bill-to VAT Registration No."; Text[20])
        {
            Caption = 'Bill-to VAT Registration No.';
        }
        field(70936; "Service Line RN External"; code[20])
        {
            FieldClass = FlowField;
            Caption = 'Service Line RN External';
            CalcFormula = lookup("Service Line RN"."Resource No." where("Document No." = field("No."), "Resource Connection Type" = filter(External)));
        }
        field(70937; "Service Line RN External Name"; Text[250])
        {
            FieldClass = FlowField;
            Caption = 'Service Line RN External Name';
            CalcFormula = lookup("Service Line RN"."Resource Name" where("Document No." = field("No."), "Resource Connection Type" = filter(External)));
        }


        /* field(70930; "Type of Invest. Description"; Text[100])
         {
             DataClassification = ToBeClassified;
             Caption = 'Type of Investition Description';
         }*/
    }
    keys
    {
        key(CZKRequestKey; "CZK Request No.")
        {

        }
        key(ResponsibleDepartment; "Responsible Department")
        {

        }
        key(RequestDepartment; "Request Department")
        {

        }
        key(SH; "Request Type")
        {

        }

    }

    trigger OnBeforeInsert()
    var
        ServiceMgtSetup: Record "Service Mgt. Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RequestNoSeries: Code[20];
        RequestDocNoSeries: Code[20];
        DS: Record "Dismantling Reason";
    begin
        if "Request Type" <> Enum::"Request Type"::"Others" then begin
            ServiceMgtSetup.Get();
            ServiceMgtSetup.TestField("Requests No. Series");
            "Request ID" := '';
            if rec."Reason For Service Order" <> '' then begin
                DS.Reset();
                DS.SetFilter(Description, '%1', rec."Reason For Service Order");
                DS.SetFilter(Type, '%1', ds.Type::"Reason for Service Order");
                if ds.FindFirst() then begin
                    if ds."RN No. Series" <> '' then
                        NoSeriesMgt.InitSeries(ds."RN No. Series", '', 0D, "Request ID", RequestNoSeries)
                    else
                        NoSeriesMgt.InitSeries(ServiceMgtSetup."Requests No. Series", '', 0D, "Request ID", RequestNoSeries);
                end
                else begin
                    NoSeriesMgt.InitSeries(ServiceMgtSetup."Requests No. Series", '', 0D, "Request ID", RequestNoSeries);
                end;
            end
            else begin
                NoSeriesMgt.InitSeries(ServiceMgtSetup."Requests No. Series", '', 0D, "Request ID", RequestNoSeries);
            end;

            if ("No." = '') and (("Request Type" <> "Request Type"::"Others") and ("Request Type".AsInteger() <> 0)) then begin
                RequestDocNoSeries := "No. Series";
                if RequestDocNoSeries = '' then
                    RequestDocNoSeries := GetNoSeries("Request Type");
                NoSeriesMgt.InitSeries(RequestDocNoSeries, '', 0D, "No.", RequestDocNoSeries);
                Classification := RequestDocNoSeries;
            end;
        end;
        UpdateLastModified();
        if "Evidential Number" = '' then
            "Evidential Number" := "No.";
    end;

    trigger OnBeforeModify()
    begin
        UpdateLastModified();
    end;


    trigger OnBeforeDelete()
    var
        myInt: Integer;
        ServiceHIn: Record "Service Invoice Header";
        Docno: Text;
        NoSeriesMgt: Codeunit NoSeriesExtented;

    begin

        ServiceHIn.Reset();
        ServiceHIn.SetFilter("No.", '%1', "Posting No.");
        if ServiceHIn.FindFirst() then begin

            Docno := NoSeriesMgt.GetNextNo(Rec."Posting No. Series", Rec."Document Date", true);
            rec."Posting No." := Docno;
            rec.Modify();
        end;

    end;



    trigger OnInsert()
    var

        CustTemp: record "Customer Templ.";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        RelationShip: Record "No. Series Relationship";
        US: Record "User Setup";

    begin
        if "Bill type" <> '' then begin
            CustTemp.Reset();
            CustTemp.SetFilter(Code, '%1', "Bill type");
            if CustTemp.FindFirst() then begin
                If CustTemp."Bill Category" = CustTemp."Bill Category"::Resource
                                then
                    validate("Customer Posting Group", 'USLUGE');

            end;

            CustTemp.Reset();
            CustTemp.SetFilter(Code, '%1', "Bill type");
            if CustTemp.FindFirst() then begin

                //ovdje pronađem proknjiženi format ovog računa

                //  ServiceHeader."Posting No." := ServiceHeader."No.";
                //Đemina dodaj ovdje
                //e sad bi trebala prema tome kojem centru kupca pripadam
                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                if US.FindFirst() then begin

                    RelationShip.Reset();
                    RelationShip.SetFilter("Series Code", '%1', STRSUBSTNO('*%1*', Us.CZK));
                    RelationShip.SetFilter(code, '%1', CustTemp."Posting No. Series Bill");
                    if RelationShip.FindFirst() then begin
                        "Posting No. Series" := RelationShip."Series Code";
                    end
                    else begin
                        "Posting No. Series" := CustTemp."Posting No. Series Bill";

                    end;

                    RelationShip.Reset();
                    RelationShip.SetFilter("Series Code", '%1', STRSUBSTNO('*%1*', Us.CZK));
                    RelationShip.SetFilter(code, '%1', CustTemp."No. Series Bill");
                    if RelationShip.FindFirst() then begin
                        "No. Series" := RelationShip."Series Code";
                    end
                    else begin
                        "No. Series" := CustTemp."No. Series Bill";

                    end;

                end;

                NoSeriesMgt.InitSeries("Posting No. Series", '', "Posting Date", "Posting No.", "Posting No. Series");
                NoSeriesMgt.InitSeries("No. Series", '', "Posting Date", "No.", "No. Series");

                if ("Request Type" = "Request Type"::"Location Accordance Issuing Information")
                or ("Request Type" = "Request Type"::"Route Accordance Issuing Information") then begin

                    if strpos("No.", '-') <> 0 then begin

                        Classification := CopyStr("No.", strpos("No.", '-'), StrLen("No."));

                    end;


                end;


            end;
        end;

    end;



    trigger OnModify()
    var
        CustTemp: record "Customer Templ.";
    begin

        CustTemp.Reset();
        if
        CustTemp.GET("Bill type") then begin
            If CustTemp."Bill Category" = CustTemp."Bill Category"::Resource
                            then
                VALIDATE("Customer Posting Group", 'USLUGE');
        end;
    END;

    trigger OnAfterDelete()
    var
        Sketch: Record Sketch;
        Elaboration: Record Elaboration;
    begin
        Sketch.SetRange("Document Type", "Document Type");
        Sketch.SetRange("Document No.", "No.");
        Sketch.DeleteAll();

        Elaboration.SetRange("Document Type", "Document Type");
        Elaboration.SetRange("Document No.", "No.");
        Elaboration.DeleteAll();
    end;

    local procedure FillTempServiceHeaderTable() //amir
    var
        SrvcHeader: Record "Service Header";
        ServiceInvHeader: Record "Service Invoice Header";
        MaxID: Integer;
        RequestTypeEnum: ENUM "Request Type";
    begin
        MaxID := 10000;
        TempServiceHeader.Reset();
        if TempServiceHeader.FindSet() then
            repeat
                TempServiceHeader.Delete();
            until TempServiceHeader.Next() = 0;

        //Pokupi sve dokumente iz Service Header tabele, tj. neproknjižene Zahtjeve gdje je isti kupac a Vrsta zahtjeva je Informacija o mogućnosti priključenja na DGM
        SrvcHeader.Reset();
        SrvcHeader.SetRange("Customer No.", Rec."Customer No.");
        SrvcHeader.SetRange("Request Type", RequestTypeEnum::"Information on Connection");
        if SrvcHeader.FindSet() then
            repeat
                TempServiceHeader.Init();
                TempServiceHeader."ID" := MaxID;
                TempServiceHeader."No." := SrvcHeader."No.";
                TempServiceHeader."Customer No." := SrvcHeader."Customer No.";
                TempServiceHeader."Request Type" := SrvcHeader."Request Type";
                TempServiceHeader."Source Table" := Format(DATABASE::"Service Header");
                TempServiceHeader."Document Date" := SrvcHeader."Document Date";
                TempServiceHeader.Insert();
                Commit();
                MaxID += 1;
            until SrvcHeader.Next() = 0;

        //Pokupi sve dokumente iz Service Invice Header tabele, tj. proknjižene Zahtjeve gdje je isti kupac a Vrsta zahtjeva je Informacija o mogućnosti priključenja na DGM
        ServiceInvHeader.Reset();
        ServiceInvHeader.SetRange("Customer No.", Rec."Customer No.");
        ServiceInvHeader.SetRange("Request Type", RequestTypeEnum::"Information on Connection");
        if ServiceInvHeader.FindSet() then
            repeat
                TempServiceHeader.Init();
                TempServiceHeader."ID" := MaxID;
                TempServiceHeader."No." := ServiceInvHeader."No.";
                TempServiceHeader."Customer No." := ServiceInvHeader."Customer No.";
                TempServiceHeader."Request Type" := ServiceInvHeader."Request Type";
                TempServiceHeader."Source Table" := Format(DATABASE::"Service Invoice Header");
                TempServiceHeader."Document Date" := ServiceInvHeader."Document Date";
                TempServiceHeader.Insert();
                Commit();
                MaxID += 1;
            until ServiceInvHeader.Next() = 0;
    end;

    local procedure OnValidateDesignerNo()
    var
        Contact: Record Contact;
        Employee: Record Employee;
    begin
        if "Designer No." = '' then begin
            "Designer Email" := '';
            "Designer Phone No." := '';
            "Designer Name" := '';
            exit;
        end;

        case "Designer Connection Type" of
            Enum::"Resource Connection Type"::External:
                begin
                    Contact.Get("Designer No.");
                    "Designer Email" := Contact."E-Mail";
                    "Designer Phone No." := Contact."Phone No.";
                    "Designer Name" := Contact.Name;
                end;
            Enum::"Resource Connection Type"::Internal:
                begin
                    Employee.Get("Designer No.");
                    "Designer Email" := Employee."E-Mail";
                    "Designer Phone No." := Employee."Phone No.";
                    "Designer Name" := Employee.FullName();
                end;
        end;
    end;

    local procedure OnAfterValidateCustomerNo()
    var
        Customer: Record Customer;
    begin
        if "Customer No." = '' then begin
            "Customer Category" := Enum::Category::" ";

            Address := '';
            "Municipality Code" := '';
            "MZ" := '';
            "Street" := '';
            "Street No." := '';
            "Stroke No." := 0;
            "Customer String" := 0;
            "Zone Stroke No." := 0;

            "Address 2" := '';
            "Municipality Code 2" := '';
            "MZ 2" := '';
            "Street 2" := '';
            "Street No. 2" := '';
            "City 2" := '';
            "Post Code 2" := '';
            "Stroke No. 2" := 0;
            "Customer String 2" := 0;
            "Zone Stroke No. 2" := 0;
            "Floor 2" := '';
            "Apartment No. 2" := '';

            exit;
        end;
        Customer.Get("Customer No.");
        //"Customer Category" := Customer."Customer Category";
        Validate("Customer Category", Customer."Customer Category");
        Validate("Consumption Category", Format(Customer."Customer Category"));
        Address := Customer."Address";
        "Municipality Code" := Customer."Municipality Code Customer";
        "MZ" := Customer."MZ Customer";
        "Street" := Customer."Street Customer";
        "Street No." := Customer."Street No.";
        "Stroke No." := Customer."Customer Stroke";
        "Customer String" := Customer."Customer String";
        "Zone Stroke No." := Customer."Zone stroke";
        "VAT Registration No." := Customer."VAT Registration No.";
        "Registration No." := Customer."Registration No.";

        "Address 2" := Customer."Address 2";
        "Municipality Code 2" := Customer."Municipality Code Customer 2";
        "MZ 2" := Customer."MZ Customer 2";
        "Street 2" := Customer."Street Customer 2";
        "Street No. 2" := Customer."Street No. 2";
        "City 2" := Customer."City 2";
        "Post Code 2" := Customer."Post Code 2";
        "Stroke No. 2" := Customer."Customer Stroke 2";
        "Customer String 2" := Customer."Customer String 2";
        "Zone Stroke No. 2" := Customer."Zone stroke 2";
        "Floor 2" := Customer."Floor Customer 2";
        "Apartment No. 2" := Customer."Apartment No. Customer 2";
        "Phone No." := Customer."Customer Phone No.";
        "E-Mail" := Customer."E-Mail";
        if "VAT Date" = 0D then
            validate("VAT Date", today);

    end;

    local procedure OnValidateOwnerNo()
    var
        Contact: Record Contact;
    begin
        if "Owner No." = '' then begin
            "Owner Name" := '';
            "Owner Address" := '';
            "Owner Municipality Code" := '';
            "Owner MZ" := '';
            "Owner Street" := '';
            "Owner Street No." := '';
            "EU Activity" := '';
            exit;
        end;
        Contact.Get("Owner No.");
        "Owner Address" := Contact.Address;
        "Owner Name" := Contact.Name;
        "Owner Municipality Code" := Contact."Municipality Code";
        "Owner MZ" := Contact."MZ";
        "Owner Street" := Contact."Street";
        "Owner Street No." := Contact."Street No.";
        "EU Activity" := Contact."EU Activity";
    end;

    trigger OnAfterInsert()
    var
        myInt: Integer;
        Comp: Record "Company Information";
    begin
        if "Request Type" <> "Request Type"::"Others" then begin
            comp.get;
            rec."According to Legislation" := Comp."Standard for the gas";
        end;
    end;

    procedure ProcessRequest()
    var
        ProcessingDocumentType: Enum "Request Type";
        ProcessDescription: Text[250];
        ProcessRemark: Text[250];
    begin
        ProcessingDocumentType := GetProcessingDocumentType("Request Type");
        if ProcessingDocumentType = Enum::"Request Type"::"Others" then
            exit;

        ProcessRequest(ProcessingDocumentType, ProcessRemark, ProcessDescription);
    end;

    local procedure ProcessRequest(CreateRequestType: Enum "Request Type"; CreateNewRemark: Text[250];
                                                          CreateNewReason: Text[250])
    var
        ServiceHeader: Record "Service Header";
        ServiceItemLine: Record "Service Item Line";


    begin
        //  TestField("Document Type", Enum::"Service Document Type"::Order);


        ServiceItemLine.SetRange("Document Type", "Document Type");
        ServiceItemLine.SetRange("Document No.", "No.");
        ServiceItemLine.FindFirst();
        //   ServiceItemline.TestField("Service Item No.");

        ServiceHeader.SetRange("Document Type", Enum::"Service Document Type"::Order);
        ServiceHeader.SetRange("Request Type", CreateRequestType);
        ServiceHeader.SetRange("CZK Request No.", "No.");
        if not ServiceHeader.FindFirst() then
            CreateServiceHeaderFromServiceHeader(ServiceHeader, CreateRequestType, CreateNewReason, CreateNewRemark, false, IsCopyWorkOrder);

        Commit();
        Page.RunModal(Page::"Request Card", ServiceHeader);
    end;

    procedure OpenRequestDocumentCard(DocumentNo: Code[20])
    var
        ServiceHeader: Record "Service Header";
    begin
        if DocumentNo = '' then
            exit;
        ServiceHeader.Get(Enum::"Service Document Type"::Order, DocumentNo);
        ServiceHeader.SetRange("Document Type", Enum::"Service Document Type"::Order);
        ServiceHeader.SetRange("Request Type", ServiceHeader."Request Type");
        ServiceHeader.SetRange("CZK Request No.", "No.");
        Page.RunModal(Page::"Request Card", ServiceHeader);
    end;

    procedure OpenCardPage()
    var
        ServiceHeader: Record "Service Header";
    begin
        ServiceHeader.Reset;
        ServiceHeader.SetRange("Request Type", "Request Type");
        ServiceHeader.SetRange("Document Type", "Document Type");
        ServiceHeader.SetRange("No.", "No.");
        Page.Run(Page::"Request Card", ServiceHeader);
    end;

    procedure CreateAndOpenWorkOrder(Filters: Boolean) RezNo: code[20]
    var
        ServiceHeader: Record "Service Header";
        ServiceItemLine: Record "Service Item Line";
        NewWorkOrderDialog: Page NewWorkOrderDialog;
        NewWorkOrderType: enum "Request Type";
        NewReason: Text[250];
        NewRemark: Text[250];
        ECL: Record "Employee Contract Ledger";
        SHNew: Record "Service Header";
        StatusHNew: Record "Status History 2";
        SHUpdate: Record "Status History 2";
        SLineInser: Record "Service Line";
        SHLast: Record "Status History 2";
    begin

        //    TestField("Document Type", Enum::"Service Document Type"::Order);
        //   ServiceItemLine.CopyFilters();
        //   CurrPage.CommentsSubForm.PAGE.SETTABLEVIEW(OrderComment);

        ServiceItemLine.SetRange("Document Type", "Document Type");
        ServiceItemLine.SetRange("Document No.", "No.");

        // if ServiceItemLine.FindFirst() then
        //   ServiceItemline.TestField("Service Item No.");

        NewWorkOrderDialog.SetInitialWorkOrderType(Enum::"Request Type"::"General Work Order", '', '', false, true);
        NewWorkOrderDialog.LookupMode := true;
        if NewWorkOrderDialog.RunModal = Action::LookupOK then begin
            NewWorkOrderDialog.GetSelectedWorkOrderType(NewWorkOrderType, NewRemark, NewReason, IsCopyWorkOrder);
            UseriD_REc.get(UserId);
            NewReason := UseriD_REc.Reason;
            NewRemark := UseriD_REc.Remark;
            IsCopyWorkOrder := UseriD_REc.IsCopyWorkOrder;
        end

        else begin
            Error('');
        end;

        CreateServiceHeaderFromServiceHeader(ServiceHeader, NewWorkOrderType, NewRemark, NewReason, Filters, IsCopyWorkOrder);

        RezNo := ServiceHeader."No.";
        Commit();

        UseriD_REc.Get(UseriD);
        if (ServiceHeader."Request Type" = ServiceHeader."Request Type"::"General Geo. Work Order")
        or (ServiceHeader."Request Type" = ServiceHeader."Request Type"::"General Geo. Work Order Office")
        then
            UseriD_REc.GEO := true
        else
            UseriD_REc.GEO := false;

        if (ServiceHeader."Request Type" = ServiceHeader."Request Type"::"General Geo. Work Order")
                       or (ServiceHeader."Request Type" = ServiceHeader."Request Type"::"General Geo. Work Order Office")
                       then begin
            if "CZK Request No." <> '' then begin
                SHNew.Reset();
                SHNew.SetFilter("No.", '%1', "CZK Request No.");
                if SHNew.FindFirst() then begin
                    if SHNew."Request Type" = SHNew."Request Type"::"Information Issuing Request" then begin
                        SHUpdate.Reset();
                        SHUpdate.SetFilter("Request No.", '%1', SHNew."No.");
                        if not SHUpdate.FindFirst() then begin
                            StatusHNew.init;
                            StatusHNew.validate("Source Table", 5900);
                            StatusHNew.validate("Request No.", SHNew."No.");
                            StatusHNew.validate("Information of processing", 45);
                            StatusHNew.Validate(Active, true);

                            SHLast.Reset();
                            SHLast.SetFilter("Request No.", '%1', SHNew."No.");
                            SHLast.SetCurrentKey(Integer);
                            SHLast.Ascending;
                            if SHLast.FindLast() then
                                StatusHNew.Integer := SHLast.Integer + 1
                            else
                                StatusHNew.Integer := 1;


                            StatusHNew.Insert();
                        end;
                    end;
                end;
            end;
        end;

        UseriD_REc.Modify();
        Commit();

        if Filters = false then begin
            Page.RunModal(Page::"Request Card", ServiceHeader);
        end;
        Commit();
    end;




    procedure CreateAndOpenWorkOrderEmpty()
    var
        ServiceHeader: Record "Service Header";
        ServiceItemLine: Record "Service Item Line";
        NewWorkOrderDialog: Page NewWorkOrderDialog;
        NewWorkOrderType: enum "Request Type";
        NewReason: Text[250];
        NewRemark: Text[250];
        ECL: Record "Employee Contract Ledger";
        SHNew: Record "Service Header";
        StatusHNew: Record "Status History 2";
        SHUpdate: Record "Status History 2";
    begin

        //    TestField("Document Type", Enum::"Service Document Type"::Order);
        /* ServiceItemLine.SetRange("Document Type", "Document Type");
         ServiceItemLine.SetRange("Document No.", "No.");
         if ServiceItemLine.FindFirst() then
             ServiceItemline.TestField("Service Item No.");
 */
        NewWorkOrderDialog.SetInitialWorkOrderType(Enum::"Request Type"::"General Work Order", '', '', false, false);
        NewWorkOrderDialog.LookupMode := true;
        if NewWorkOrderDialog.RunModal = Action::LookupOK then begin
            NewWorkOrderDialog.GetSelectedWorkOrderType(NewWorkOrderType, NewRemark, NewReason, IsCopyWorkOrder);
            UseriD_REc.get(UserId);
            NewReason := UseriD_REc.Reason;
            NewRemark := UseriD_REc.Remark;
        end

        else begin
            Error('');
        end;

        CreateServiceHeaderFromServiceHeaderEmpty(ServiceHeader, NewWorkOrderType, NewRemark, NewReason);

        Commit();

        UseriD_REc.Get(UseriD);
        if (ServiceHeader."Request Type" = ServiceHeader."Request Type"::"General Geo. Work Order")
        or (ServiceHeader."Request Type" = ServiceHeader."Request Type"::"General Geo. Work Order Office")
        then
            UseriD_REc.GEO := true
        else
            UseriD_REc.GEO := false;






        UseriD_REc.Modify();
        Commit();

        Page.RunModal(Page::"Request Card", ServiceHeader);
        Commit();
    end;

    local procedure CreateServiceHeaderFromServiceHeader(var ServiceHeader: Record "Service Header"; RequestType: Enum "Request Type"; var Descri: Text[250]; var Remar: Text[250]; Fil: Boolean; IsCopyWorkOrder: Boolean)
    var
        ServiceItemLine: record "Service Item Line";
        NewServiceItemLine: record "Service Item Line";
        RequestID: Code[20];
        DocumentAttachment: Record "Document Attachment";
        DocumentAttachmentPrevious: Record "Document Attachment";
        DocumentAttachmentNew: Record "Document Attachment";
        InsertL: Boolean;
        ReqCardSuP: page "Request Card SubPage";
        Mandat: Record "Mandatory Attachment Setup";
        ECL: Record "Employee Contract Ledger";
        DepartmentCOdeShema: Record Department;
        OrgS: Record "ORG Shema";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        USSet: Record "User Setup";
        ServiceLine: Record "Service Line";
        ServiceLineRec: Record "Service Line";
        SourceRecref, TargetRecref : RecordRef;
        ServiceLineRN: Record "Service Line RN";
        ServiceLineRNRec: Record "Service Line RN";
        ServiceLineMaterialRN: Record "Service Line";
        ServiceLineMaterialRNRec: Record "Service Line";
        DocFIlter: Record "Service Header";
        ConnectedRN: text;
        DocFIlter2: Record "Service Header";
        SLineConnected: record "Service Line";
        ServiceLineMaterialRNRec2: Record "Service Line";
        TempLinkedRequests: Record "Template_Message" temporary;
        TemporeryItem: Record "Tax Group" temporary;
        EntryNo: integer;
        EntryFilters2: text;
    begin
        if IsCopyWorkOrder then begin
            ServiceHeader.Init();
            ServiceHeader."Document Type" := Enum::"Service Document Type"::Order;
            ServiceHeader."No." := '';
            ServiceHeader."VAT Date" := today;


            UseriD_REc.Get(UserId);
            ServiceHeader."No. Series" := GetNoSeries(RequestType);

            ServiceHeader.Validate("Responsible Department", Rec."Responsible Department");
            ServiceHeader.Validate("Request Department", Rec."Request Department");
            ServiceHeader.Validate("Real. Process. Empl. No.", Rec."Real. Process. Empl. No.");
            ServiceHeader."Holder of works" := Rec."Holder of works";
            ServiceHeader.Sector := Rec.Sector;
            ServiceHeader."Sector Text" := Rec."Sector Text";

            NoSeriesMgt.InitSeries(ServiceHeader."No. Series", xRec."No. Series", 0D, ServiceHeader."No.", "No. Series");
            ServiceHeader."Order Date" := today;
            ServiceHeader."Order Time" := Time;
            ServiceHeader.Insert(True);
            RequestID := ServiceHeader."Request ID";
            ServiceHeader.TransferFields(Rec, false);
            //EK
            if IsCopyWorkOrder then begin
                ServiceHeader."Starting Date" := 0D;
                ServiceHeader."Finishing Date" := 0D;
                ServiceHeader."Starting Time" := 0T;
                ServiceHeader."Finishing Time" := 0T;
            end;
            //
            ServiceHeader.Validate("Responsible Department", Rec."Responsible Department");
            ServiceHeader.Validate("Request Department", Rec."Request Department");
            ServiceHeader.Validate("Real. Process. Empl. No.", Rec."Real. Process. Empl. No.");
            ServiceHeader.Sector := Rec.Sector;
            ServiceHeader."Sector Text" := Rec."Sector Text";

            //DONE polja resetovati:
            ServiceHeader."Prep Realisation Done" := false;
            ServiceHeader."Prep Verif Done" := false;
            ServiceHeader."Prep Control Done" := false;
            ServiceHeader."Prep Done Date" := 0D;
            ServiceHeader."Prep Control Date" := 0D;
            ServiceHeader."Prep Verif Date" := 0D;
            ServiceHeader."Realisation Done" := false;
            ServiceHeader."Verif Done" := false;
            ServiceHeader."Control Done" := false;
            ServiceHeader."Done Date" := 0D;
            ServiceHeader."Control Date" := 0D;
            ServiceHeader."Verif Date" := 0D;
            ServiceHeader."Need to reopen work order" := false;
            ServiceHeader."Due Days Reopen" := 0;
            //DONE sekcija završena

            ServiceHeader."No. Series" := GetNoSeries(RequestType);
            ServiceHeader.Validate("Responsible Department", Rec."Responsible Department");
            ServiceHeader.Validate("Request Department", Rec."Request Department");
            ServiceHeader.Validate("Real. Process. Empl. No.", Rec."Real. Process. Empl. No.");
            ServiceHeader."Holder of works" := ServiceHeader."Responsible Department";

            ServiceHeader."Reason For Service Order" := Remar;
            ServiceHeader."Remark For Service Order" := Descri;
            ServiceHeader."Geo. Activity Type" := Rec."Geo. Activity Type";

            ServiceHeader."Request ID" := RequestID;

            ServiceHeader."Request Group" := Rec."Request Group";
            ServiceHeader."Activity Type" := Rec."Activity Type";
            /*    ServiceHeader."Starting Date" := Rec."Starting Date";
                ServiceHeader."Starting Time" := Rec."Starting Time";
                ServiceHeader."Finishing Date" := Rec."Finishing Date";
                ServiceHeader."Finishing Time" := Rec."Finishing Time";*/

            ServiceHeader."Time of ticket" := Rec."Time of ticket";
            ServiceHeader."Time of sender" := Rec."Time of sender";
            ServiceHeader."Date of ticket" := Rec."Date of ticket";
            ServiceHeader."Date of sender" := Rec."Date of sender";

            ServiceHeader."Order Date" := Rec."Order Date";
            ServiceHeader."Order Time" := Rec."Order Time";
            ServiceHeader."Real. Process. Empl. No." := Rec."Real. Process. Empl. No.";
            ServiceHeader."Real. Process. Empl. Name" := Rec."Real. Process. Empl. Name";
            ServiceHeader."Real. Contr. Empl. No." := Rec."Real. Contr. Empl. No.";
            ServiceHeader."Real. Verif. Empl. Name" := Rec."Real. Verif. Empl. Name";

            ServiceHeader."Real. Contr. Empl. Name" := Rec."Real. Contr. Empl. Name";
            ServiceHeader."Real. Verif. Empl. Name" := Rec."Real. Verif. Empl. Name";
            ServiceHeader."Prep. Process. Empl. No." := Rec."Prep. Process. Empl. No."; //amir twice
            ServiceHeader."Prep. Process. Empl. No." := Rec."Prep. Process. Empl. No.";
            ServiceHeader."Prep. Contr. Empl. No." := Rec."Prep. Contr. Empl. No.";
            ServiceHeader."Prep. Contr. Empl. Name" := Rec."Prep. Contr. Empl. Name";
            ServiceHeader."Prep. Verif. Empl. Name" := Rec."Prep. Verif. Empl. Name";
            ServiceHeader."Prep. Verif. Empl. No." := rec."Prep. Verif. Empl. No.";

            ServiceHeader."Request Type" := RequestType;
            ServiceHeader."CZK Request No." := Rec."No.";
            Serviceheader."Document Date" := Today();
            ServiceHeader."Prep Realisation Done" := false;
            ServiceHeader."Prep Verif Done" := false;
            ServiceHeader."Prep Control Done" := false;
            ServiceHeader."Prep Done Date" := 0D;
            ServiceHeader."Prep Control Date" := 0D;
            ServiceHeader."Prep Verif Date" := 0D;
            ServiceHeader."Realisation Done" := false;
            ServiceHeader."Verif Done" := false;
            ServiceHeader."Control Done" := false;
            ServiceHeader."Done Date" := 0D;
            ServiceHeader."Control Date" := 0D;
            ServiceHeader."Verif Date" := 0D;
            ServiceHeader."Need to reopen work order" := false;
            ServiceHeader."Due Days Reopen" := 0;
            ServiceHeader.Modify(true);
            ServiceItemLine.SetRange("Document Type", "Document Type");
            ServiceItemLine.SetRange("Document No.", "No.");

            //ovdje provjerit
            if (fil = false) and (ServiceItemLine."Already Transfer" = false) then begin

                if ServiceItemLine.FindSet() then // if InsertL = true then begin
                    repeat
                        //     NewServiceItemLine.TransferFields(ServiceItemLine, false);
                        //   NewServiceItemLine."Document Type" := "Document Type";
                        NewServiceItemLine.Init();
                        NewServiceItemLine.TransferFields(ServiceItemLine, false);
                        UseriD_REc.Reset();
                        UseriD_REc.SetFilter("User ID", '%1', UserId);
                        if UseriD_REc.FindFirst() then begin
                            if UseriD_REc.FindFirst() then begin
                                if UseriD_REc.HS = true then begin
                                    NewServiceItemLine."Date of consumption" := 0D;
                                end;
                            end;
                        end;
                        NewServiceItemLine."Document Type" := "Document Type";
                        NewServiceItemLine."Document No." := ServiceHeader."No.";
                        NewServiceItemLine."CZK ID" := ServiceItemLine."Document No.";
                        NewServiceItemLine."Line No." := ServiceItemLine."Line No.";
                        NewServiceItemLine.Applied := falsE;
                        NewServiceItemLine.Insert();

                        ServiceItemLine."Already Transfer" := true;
                        ServiceItemLine.Modify();

                    // end;
                    until ServiceItemLine.Next() = 0;
                //SLineInser
                //SLineInser = 
                if (Rec."Request Type" = rec."Request Type"::"Information Issuing Request")
                or (rec."Request Type" = rec."Request Type"::"Location Accordance Issuing Request")
                or (rec."Request Type" = rec."Request Type"::"Project overview Request")
                or (rec."Request Type" = rec."Request Type"::"Route Accordance Issuing Request")
                or (rec."Request Type" = rec."Request Type"::"Spatial plan Accordance Issuing Request")
                 or (rec."Request Type" = rec."Request Type"::"Work Execution Request")
                  or (rec."Request Type" = rec."Request Type"::Others)
                 then begin

                    if ServiceHeader."Request Type" = ServiceHeader."Request Type"::"General Work Order" then begin
                        ServiceLineRec.reset;
                        ServiceLineRec.setfilter("Document No.", '%1', rec."No.");
                        ServiceLineRec.setfilter("Document Type", '%1', rec."Document Type");
                        ServiceLineRec.SetFilter(Type, '%1', ServiceLineRec.type::Item);

                        if ServiceLineRec.FindSet() then
                            repeat
                                ServiceLine.init;
                                ServiceLine.TransferFields(ServiceLineRec);
                                ServiceLine."Document No." := ServiceHeader."No.";
                                ServiceLine."Document Type" := ServiceHeader."Document Type";
                                if ServiceLine.Quantity = 0 then begin
                                    ServiceLine.Quantity := ServiceLine."Planned Quantity";
                                    ServiceLine.insert;
                                end
                                else begin
                                    ServiceLine.CalcFields("Shiped Quantity", "Invoiced Quantity", "Shiped Quantity2");
                                    if (ServiceLine."Shiped Quantity" = 0) then begin
                                        ServiceLine.insert;
                                    end
                                    else begin

                                        if (ServiceLine."Shiped Quantity" <> ServiceLine."Invoiced Quantity")
                                        and (ServiceLine.Quantity <> ServiceLine."Shiped Quantity") then begin
                                            ServiceLine.validate(Quantity, abs(ServiceLine.Quantity - ServiceLine."Shiped Quantity"));
                                            ServiceLine.insert;
                                        end;
                                    end;
                                end;
                            until ServiceLineRec.next() = 0;
                    end;
                end;
            end;

            ServiceLineRNRec.Reset();
            ServiceLineRNRec.SetFilter("Document No.", '%1', Rec."No.");
            ServiceLineRNRec.SetFilter("Document Type", '%1', Rec."Document Type");
            if ServiceLineRNRec.FindSet() then
                repeat
                    ServiceLineRN.Init();
                    ServiceLineRN.TransferFields(ServiceLineRNRec);
                    ServiceLineRN."Document No." := ServiceHeader."No.";
                    ServiceLineRN."Document Type" := ServiceHeader."Document Type";
                    ServiceLineRN.Insert();
                until ServiceLineRNRec.Next() = 0;

            ServiceLineMaterialRNRec.Reset();
            ServiceLineMaterialRNRec.SetFilter("Document No.", '%1', Rec."No.");
            ServiceLineMaterialRNRec.SetFilter("Document Type", '%1', Rec."Document Type");
            if ServiceLineMaterialRNRec.FindSet() then
                repeat
                    //ovo je situacija kopir
                    ServiceLineMaterialRN.Init();
                    ServiceLineMaterialRN.TransferFields(ServiceLineMaterialRNRec);

                    ServiceLineMaterialRN."Document No." := ServiceHeader."No.";
                    ServiceLineMaterialRN."Document Type" := ServiceHeader."Document Type";
                    ServiceLineMaterialRN."Source Location Code" := 'REVERS';

                    if ServiceLineMaterialRN."RN Type" = ServiceLineMaterialRN."RN Type"::Item then begin
                        ServiceLineMaterialRN."Quantity Shipped" := 0;
                        ServiceLineMaterialRN."Transfer Order" := '';
                    end;
                    ServiceLineMaterialRNRec2.reset;
                    ServiceLineMaterialRNRec2.SetFilter("Line No.", '%1', ServiceLineMaterialRNRec."Line No.");
                    ServiceLineMaterialRNRec2.SetFilter("Document No.", '%1', ServiceLineMaterialRNRec."Document No.");
                    DocFIlter.Reset();
                    DocFIlter.SetFilter("No.", '%1', ServiceLineMaterialRNRec."Document No.");
                    DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                    if DocFIlter.FindFirst() then begin
                        if DocFIlter."CZK Request No." <> '' then
                            ServiceLineMaterialRNRec2.SETRANGE("CZK Request No. Filter", DocFIlter."CZK Request No.")
                        else
                            ServiceLineMaterialRNRec2.SETRANGE("CZK Request No. Filter", ServiceLineMaterialRNRec."Document No.");

                    end
                    else begin
                        ServiceLineMaterialRNRec2.SETRANGE("CZK Request No. Filter", ServiceLineMaterialRNRec."Document No.");

                    end;

                    if ServiceLineMaterialRNRec."Invoiced Quantity" > 0 then begin

                        DocFIlter.Reset();
                        DocFIlter.SetFilter("No.", '%1', ServiceLineMaterialRNRec."Document No.");
                        DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                        if DocFIlter.FindFirst() then begin
                            ServiceLineMaterialRNRec2.SETRANGE("Shipment No. Filter", ServiceLineMaterialRNRec."Document No.")

                        end
                        else begin
                            ServiceLineMaterialRNRec2.SETRANGE("Shipment No. Filter", '       ');

                        end;
                    end
                    else begin

                        ServiceLineMaterialRNRec2.SETRANGE("Shipment No. Filter", ServiceLineMaterialRNRec."Document No.");

                    end;

                    if DocFIlter."CZK Request No." <> '' then
                        ServiceLineMaterialRNRec2.setfilter("Shipment No. Filter", '%1', ServiceLineMaterialRNRec."Document No.");

                    ConnectedRN := '';


                    if ServiceLineMaterialRNRec."Document No." <> '' then begin
                        DocFIlter.Reset();
                        DocFIlter.SetFilter("CZK Request No.", '%1', ServiceLineMaterialRNRec."Document No.");
                        if DocFIlter.findset() then
                            repeat
                                if DocFIlter."No." <> ServiceLineMaterialRNRec."Document No." then
                                    ConnectedRN += DocFIlter."No." + '|';
                            until DocFIlter.Next() = 0;
                        DocFIlter.Reset();
                        DocFIlter.SetFilter("No.", '%1', ServiceLineMaterialRNRec."Document No.");
                        if DocFIlter.FindFirst() then begin
                            if DocFIlter."CZK Request No." <> ServiceLineMaterialRNRec."Document No." then begin
                                if DocFIlter."CZK Request No." <> '' then
                                    ConnectedRN := DocFIlter."CZK Request No." + '|';
                            end;
                        end;


                        if DocFIlter."CZK Request No." <> '' then begin
                            DocFIlter2.Reset();
                            DocFIlter2.SetFilter("CZK Request No.", '%1', DocFIlter."CZK Request No.");
                            if DocFIlter2.findset() then
                                repeat
                                    if DocFIlter2."No." <> ServiceLineMaterialRNRec."Document No." then begin
                                        if strpos(ConnectedRN, DocFIlter2."No.") = 0 then
                                            ConnectedRN += DocFIlter2."No." + '|';
                                    end;
                                until DocFIlter.Next() = 0;

                        end;



                        if strlen(ConnectedRN) > 2 then
                            ConnectedRN := CopyStr(ConnectedRN, 1, StrLen(ConnectedRN) - 1);

                        //ja bih ovdje sada dodala ovaj connectedRN i da vidim kako će to izgledati
                        EntryFilters2 := '';
                        TempLinkedRequests.deleteall;
                        TemporeryItem.DeleteAll();
                        EntryNo := 1;




                        GetLinkedRequests(Rec."No.", TempLinkedRequests, EntryNo);
                        TempLinkedRequests.Reset();
                        TempLinkedRequests.setcurrentkey("ID");
                        TempLinkedRequests.ascending;

                        if TempLinkedRequests.FindSet() then
                            repeat
                                if TempLinkedRequests."Message Code" <> Rec."No." then
                                    EntryFilters2 += TempLinkedRequests."Message Code" + '|';
                            until TempLinkedRequests.Next() = 0;


                        if strlen(EntryFilters2) > 2 then
                            EntryFilters2 := copystr(EntryFilters2, 1, strlen(EntryFilters2) - 1);


                        ConnectedRN := EntryFilters2;
                        //kraj djemina

                        if ConnectedRN <> '' then
                            ServiceLineMaterialRNRec2.SETFILTER("CZK Connected No. Filter", ConnectedRN)
                        else
                            ServiceLineMaterialRNRec2.setfilter("CZK Connected No. Filter", '%1', 'Ne postoji');
                    end;
                    if ServiceLineMaterialRNRec2.FindFirst() then begin

                        ServiceLineMaterialRNRec2.CalcFields("Shiped Quantity", "Invoiced Quantity", "Connected Quantity");

                        if (ServiceLineMaterialRNRec2.Quantity = 0) and (ServiceLineMaterialRNRec2."Planned Quantity" <> 0)
                        and (ServiceLineMaterialRNRec2."Planned Quantity" > (ServiceLineMaterialRNRec2."Shiped Quantity2" + ServiceLineMaterialRNRec2."Connected Quantity")) then begin

                            //ubaci ako planirana ima vrijednost, a količina nema 
                            if (ServiceLineMaterialRN."Planned Quantity" <> 0) and (ServiceLineMaterialRN.Quantity = 0) and (ServiceLineMaterialRNRec2."Connected Quantity" = 0) then
                                ServiceLineMaterialRN.Validate(Quantity, ServiceLineMaterialRN."Planned Quantity");
                            ServiceLineMaterialRN.insert;
                        end
                        else begin
                            ServiceLineMaterialRNRec2.CalcFields("Shiped Quantity", "Invoiced Quantity");
                            if (ServiceLineMaterialRNRec2."Shiped Quantity" = 0) and (ServiceLineMaterialRNRec2."Planned Quantity" <> 0)
                            and (ServiceLineMaterialRNRec2."Planned Quantity" > (ServiceLineMaterialRNRec2."Shiped Quantity2" + ServiceLineMaterialRNRec2."Connected Quantity")) then begin
                                if (ServiceLineMaterialRN."Planned Quantity" <> 0) and (ServiceLineMaterialRN.Quantity = 0)
                                and (ServiceLineMaterialRNRec2."Connected Quantity" = 0) then
                                    ServiceLineMaterialRN.Validate(Quantity, ServiceLineMaterialRN."Planned Quantity");
                                ServiceLineMaterialRN.insert;
                            end
                            else begin

                                if (ServiceLineMaterialRNRec2."Planned Quantity" > ServiceLineMaterialRNRec2."Shiped Quantity")
                                and (ServiceLineMaterialRNRec2."Planned Quantity" > (ServiceLineMaterialRNRec2."Shiped Quantity" + ServiceLineMaterialRNRec2."Connected Quantity"))
                                then begin

                                    ServiceLineMaterialRN.validate(Quantity, abs(ServiceLineMaterialRNRec2."Planned Quantity" - ServiceLineMaterialRNRec2."Shiped Quantity" - ServiceLineMaterialRNRec2."Connected Quantity"));
                                    //     ServiceLineMaterialRN."Planned Quantity" := ServiceLineMaterialRN.Quantity;

                                    if (ServiceLineMaterialRN."Planned Quantity" <> 0) and (ServiceLineMaterialRN.Quantity = 0)
                                    and (ServiceLineMaterialRNRec2."Connected Quantity" = 0) then
                                        ServiceLineMaterialRN.Validate(Quantity, ServiceLineMaterialRN."Planned Quantity");
                                    ServiceLineMaterialRN.insert;
                                end;
                            end;
                        end;
                    end;

                until ServiceLineMaterialRNRec.Next() = 0;


            if ServiceHeader."Request Type" = ServiceHeader."Request Type"::"Project and Energy Accordance" then begin
                Mandat.Reset();
                Mandat.SetFilter("Request Type", '%1', ServiceHeader."Request Type");
                if Mandat.FindSet() then
                    repeat
                        DocumentAttachment.Init();
                        DocumentAttachment."Table ID" := Database::"Service Item Line";
                        DocumentAttachment."No." := ServiceHeader."No.";
                        DocumentAttachment."Line No." := 1000;
                        DocumentAttachment.Mandatory := Mandat.Mandatory;
                        DocumentAttachment.ID := 0;
                        DocumentAttachment.Information := mandat.Information;
                        DocumentAttachment."Mandatory Attachment Type" := mandat."Mandatory Attachment Type";
                        DocumentAttachment."File Name" := 'Odaberite datoteku...';
                        DocumentAttachment.Insert();
                    until Mandat.Next() = 0;
            end;

            //amir kopiraj bilješke i linkove:
            SourceRecref.GetTable(Rec);
            TargetRecref.GetTable(ServiceHeader);
            TargetRecref.CopyLinks(SourceRecref);
            //anisa

            if Rec."Request Type" = Rec."Request Type"::"Work Execution Request" then begin
                DocumentAttachmentPrevious.Reset();
                DocumentAttachmentPrevious.SetFilter("No.", '%1', rec."No.");
                DocumentAttachmentPrevious.SetFilter("Table ID", '%1', 5901);
                if DocumentAttachmentPrevious.FindSet() then
                    repeat

                        DocumentAttachmentNew.Init();
                        DocumentAttachmentNew.TransferFields(DocumentAttachmentPrevious);
                        DocumentAttachmentNew."No." := ServiceHeader."No.";
                        DocumentAttachmentNew.Insert();
                    until DocumentAttachmentPrevious.Next() = 0;
            end;


        end else begin
            ServiceHeader.Init();
            ServiceHeader."Document Type" := Enum::"Service Document Type"::Order;
            ServiceHeader."No." := '';
            ServiceHeader."VAT Date" := today;


            UseriD_REc.Get(UserId);
            ServiceHeader."No. Series" := GetNoSeries(RequestType);

            ECL.Reset();
            ECL.SetFilter("Employee No.", '%1', UseriD_REc."Employee No. for Wage");
            ECL.setfilter(active, '%1', true);
            if ECL.findfirst then
                ServiceHeader.Validate("Responsible Department", ecl."Department Code");


            ECL.Reset();
            ECL.SetFilter("Employee No.", '%1', UseriD_REc."Employee No. for Wage");
            ECL.setfilter(active, '%1', true);
            if ECL.findfirst then
                ServiceHeader.Validate("Request Department", ecl."Department Code");



            USSet.Reset();
            USSet.SetFilter("User ID", '%1', UserId);
            if USSet.FindFirst() then begin
                if USSet.HS = false then
                    ServiceHeader.Validate("Real. Process. Empl. No.", USSet."Employee No. for Wage");


            end;


            if ServiceHeader."Holder of works" = '' then
                ServiceHeader."Holder of works" := ServiceHeader."Responsible Department";

            OrgS.Reset();
            OrgS.SetFilter("Date From", '<=%1', today);
            OrgS.SetCurrentKey("Date From");
            OrgS.Ascending;
            if orgs.FindLast() then begin
                DepartmentCOdeShema.reset;
                DepartmentCOdeShema.SetFilter("ORG Shema", '%1', OrgS.code);
                DepartmentCOdeShema.SetFilter(Code, '%1', "Responsible Department");
                if DepartmentCOdeShema.FindFirst() then begin
                    Sector := DepartmentCOdeShema.sector;
                    "Sector Text" := DepartmentCOdeShema."Sector  Description";
                end
                else begin
                    Sector := '';
                    "Sector Text" := '';
                end;


            end;
            NoSeriesMgt.InitSeries(ServiceHeader."No. Series", xRec."No. Series", 0D, ServiceHeader."No.", "No. Series");
            ServiceHeader."Order Date" := today;
            ServiceHeader."Order Time" := Time;
            ServiceHeader.Insert(True);
            RequestID := ServiceHeader."Request ID";
            ServiceHeader.TransferFields(Rec, false);

            //EK 
            if IsCopyWorkOrder then begin
                ServiceHeader."Starting Date" := 0D;
                ServiceHeader."Finishing Date" := 0D;
                ServiceHeader."Starting Time" := 0T;
                ServiceHeader."Finishing Time" := 0T;
            end;
            //

            ECL.Reset();
            ECL.SetFilter("Employee No.", '%1', UseriD_REc."Employee No. for Wage");
            ECL.setfilter(active, '%1', true);
            if ECL.findfirst then
                ServiceHeader.Validate("Responsible Department", ecl."Department Code");


            ECL.Reset();
            ECL.SetFilter("Employee No.", '%1', UseriD_REc."Employee No. for Wage");
            ECL.setfilter(active, '%1', true);
            if ECL.findfirst then
                ServiceHeader.Validate("Request Department", ecl."Department Code");



            USSet.Reset();
            USSet.SetFilter("User ID", '%1', UserId);
            if USSet.FindFirst() then begin
                if USSet.HS = false then
                    ServiceHeader.Validate("Real. Process. Empl. No.", USSet."Employee No. for Wage");


            end;

            if ServiceHeader."Holder of works" = '' then
                ServiceHeader."Holder of works" := ServiceHeader."Responsible Department";


            OrgS.Reset();
            OrgS.SetFilter("Date From", '<=%1', today);
            OrgS.SetCurrentKey("Date From");
            OrgS.Ascending;
            if orgs.FindLast() then begin
                DepartmentCOdeShema.reset;
                DepartmentCOdeShema.SetFilter("ORG Shema", '%1', OrgS.code);
                DepartmentCOdeShema.SetFilter(Code, '%1', "Responsible Department");
                if DepartmentCOdeShema.FindFirst() then begin
                    Sector := DepartmentCOdeShema.sector;
                    "Sector Text" := DepartmentCOdeShema."Sector  Description";
                end
                else begin
                    Sector := '';
                    "Sector Text" := '';
                end;
            end;

            ECL.Reset();
            ECL.SetFilter("Employee No.", '%1', UseriD_REc."Employee No. for Wage");
            ECL.setfilter(active, '%1', true);
            if ECL.findfirst then
                ServiceHeader.Validate("Request Department", ecl."Department Code");




            ServiceHeader."Prep Realisation Done" := false;
            ServiceHeader."Prep Verif Done" := false;
            ServiceHeader."Prep Control Done" := false;
            ServiceHeader."Prep Done Date" := 0D;
            ServiceHeader."Prep Control Date" := 0D;
            ServiceHeader."Prep Verif Date" := 0D;
            ServiceHeader."Realisation Done" := false;
            ServiceHeader."Verif Done" := false;
            ServiceHeader."Control Done" := false;
            ServiceHeader."Done Date" := 0D;
            ServiceHeader."Control Date" := 0D;
            ServiceHeader."Verif Date" := 0D;
            ServiceHeader."Need to reopen work order" := false;
            ServiceHeader."Due Days Reopen" := 0;

            ServiceHeader."No. Series" := GetNoSeries(RequestType);

            ECL.Reset();
            ECL.SetFilter("Employee No.", '%1', UseriD_REc."Employee No. for Wage");
            ECL.setfilter(active, '%1', true);
            if ECL.findfirst then
                ServiceHeader.Validate("Responsible Department", ecl."Department Code");



            ECL.Reset();
            ECL.SetFilter("Employee No.", '%1', UseriD_REc."Employee No. for Wage");
            ECL.setfilter(active, '%1', true);
            if ECL.findfirst then
                ServiceHeader.Validate("Request Department", ecl."Department Code");


            USSet.Reset();
            USSet.SetFilter("User ID", '%1', UserId);
            if USSet.FindFirst() then begin
                if USSet.HS = false then
                    ServiceHeader.Validate("Real. Process. Empl. No.", USSet."Employee No. for Wage");
            end;

            ServiceHeader."Holder of works" := ServiceHeader."Responsible Department";


            OrgS.Reset();
            OrgS.SetFilter("Date From", '<=%1', today);
            OrgS.SetCurrentKey("Date From");
            OrgS.Ascending;
            if orgs.FindLast() then begin
                DepartmentCOdeShema.reset;
                DepartmentCOdeShema.SetFilter("ORG Shema", '%1', OrgS.code);
                DepartmentCOdeShema.SetFilter(Code, '%1', "Responsible Department");
                if DepartmentCOdeShema.FindFirst() then begin
                    Sector := DepartmentCOdeShema.sector;
                    "Sector Text" := DepartmentCOdeShema."Sector  Description";
                end
                else begin
                    Sector := '';
                    "Sector Text" := '';
                end;
            end;



            ServiceHeader."Reason For Service Order" := Remar;
            ServiceHeader."Remark For Service Order" := Descri;
            ServiceHeader."Geo. Activity Type" := '';

            ServiceHeader."Request ID" := RequestID;

            ServiceHeader."Request Group" := '';
            ServiceHeader."Activity Type" := '';
            ServiceHeader."Starting Date" := 0D;
            ServiceHeader."Starting Time" := 0T;
            ServiceHeader."Finishing Date" := 0D;
            ServiceHeader."Finishing Time" := 0T;

            ServiceHeader."Time of ticket" := 0T;
            ServiceHeader."Time of sender" := 0T;
            ServiceHeader."Date of ticket" := 0D;
            ServiceHeader."Date of sender" := 0D;

            ServiceHeader."Order Date" := 0D;
            ServiceHeader."Order Time" := 0T;
            ServiceHeader."Real. Process. Empl. No." := '';
            ServiceHeader."Real. Process. Empl. Name" := '';
            ServiceHeader."Real. Contr. Empl. No." := '';
            ServiceHeader."Real. Verif. Empl. Name" := '';

            ServiceHeader."Real. Contr. Empl. Name" := '';
            ServiceHeader."Real. Verif. Empl. Name" := '';
            ServiceHeader."Prep. Process. Empl. No." := '';
            ServiceHeader."Prep. Process. Empl. No." := '';
            ServiceHeader."Prep. Contr. Empl. No." := '';
            ServiceHeader."Prep. Contr. Empl. Name" := '';
            ServiceHeader."Prep. Verif. Empl. Name" := '';
            ServiceHeader."Prep. Verif. Empl. No." := '';


            ServiceHeader."Request Type" := RequestType;
            ServiceHeader."CZK Request No." := "No.";
            Serviceheader."Document Date" := Today();
            ServiceHeader.Modify(true);
            ServiceItemLine.SetRange("Document Type", "Document Type");
            ServiceItemLine.SetRange("Document No.", "No.");

            //ovdje provjerit
            if (fil = false) and (ServiceItemLine."Already Transfer" = false) then begin

                if ServiceItemLine.FindSet() then // if InsertL = true then begin
                    repeat
                        //     NewServiceItemLine.TransferFields(ServiceItemLine, false);
                        //   NewServiceItemLine."Document Type" := "Document Type";
                        NewServiceItemLine.Init();
                        NewServiceItemLine.TransferFields(ServiceItemLine, false);
                        NewServiceItemLine."Document Type" := "Document Type";
                        NewServiceItemLine."Document No." := ServiceHeader."No.";
                        NewServiceItemLine."CZK ID" := ServiceItemLine."Document No.";
                        NewServiceItemLine."Line No." := ServiceItemLine."Line No.";

                        UseriD_REc.Reset();
                        UseriD_REc.SetFilter("User ID", '%1', UserId);
                        if UseriD_REc.FindFirst() then begin
                            if UseriD_REc.FindFirst() then begin
                                if UseriD_REc.HS = true then begin
                                    NewServiceItemLine."Date of consumption" := 0D;
                                end;
                            end;
                        end;

                        NewServiceItemLine.Applied := falsE;
                        NewServiceItemLine.Insert();

                        ServiceItemLine."Already Transfer" := true;
                        ServiceItemLine.Modify();

                    // end;
                    until ServiceItemLine.Next() = 0;
                //SLineInser
                //SLineInser = 
                if (Rec."Request Type" = rec."Request Type"::"Information Issuing Request")
                or (rec."Request Type" = rec."Request Type"::"Location Accordance Issuing Request")
                or (rec."Request Type" = rec."Request Type"::"Project overview Request")
                or (rec."Request Type" = rec."Request Type"::"Route Accordance Issuing Request")
                or (rec."Request Type" = rec."Request Type"::"Spatial plan Accordance Issuing Request")
                 or (rec."Request Type" = rec."Request Type"::"Work Execution Request")
                  or (rec."Request Type" = rec."Request Type"::Others)
                 then begin

                    if ServiceHeader."Request Type" = ServiceHeader."Request Type"::"General Work Order" then begin
                        ServiceLineRec.reset;
                        ServiceLineRec.setfilter("Document No.", '%1', rec."No.");
                        ServiceLineRec.setfilter("Document Type", '%1', rec."Document Type");
                        ServiceLineRec.SetFilter(Type, '%1', ServiceLineRec.type::Item);
                        if ServiceLineRec.FindSet() then
                            repeat
                                ServiceLine.init;
                                ServiceLine.TransferFields(ServiceLineRec);
                                ServiceLine."Document No." := ServiceHeader."No.";
                                ServiceLine."Document Type" := ServiceHeader."Document Type";

                                ServiceLine.insert;

                            until ServiceLineRec.next() = 0;
                    end;
                end;
            end;
            if ServiceHeader."Request Type" = ServiceHeader."Request Type"::"Project and Energy Accordance" then begin

                Mandat.Reset();
                Mandat.SetFilter("Request Type", '%1', ServiceHeader."Request Type");
                if Mandat.FindSet() then
                    repeat
                        DocumentAttachment.Init();
                        DocumentAttachment."Table ID" := Database::"Service Item Line";
                        DocumentAttachment."No." := ServiceHeader."No.";
                        DocumentAttachment."Line No." := 1000;
                        DocumentAttachment.Mandatory := Mandat.Mandatory;
                        DocumentAttachment.ID := 0;
                        DocumentAttachment.Information := mandat.Information;
                        DocumentAttachment."Mandatory Attachment Type" := mandat."Mandatory Attachment Type";
                        DocumentAttachment."File Name" := 'Odaberite datoteku...';
                        DocumentAttachment.Insert();
                    until Mandat.Next() = 0;
            end;
        end;
    end;


    //Empty

    local procedure CreateServiceHeaderFromServiceHeaderEmpty(var ServiceHeader: Record "Service Header"; RequestType: Enum "Request Type"; var Descri: Text[250]; var Remar: Text[250])
    var
        ServiceItemLine: record "Service Item Line";
        NewServiceItemLine: record "Service Item Line";
        RequestID: Code[20];
        DocumentAttachment: Record "Document Attachment";
        Mandat: Record "Mandatory Attachment Setup";
        ECL: Record "Employee Contract Ledger";
        DepartmentCOdeShema: Record Department;
        OrgS: Record "ORG Shema";
        USSet: Record "User Setup";
    begin
        ServiceHeader.Init();
        ServiceHeader."Document Type" := Enum::"Service Document Type"::Order;
        ServiceHeader."VAT Date" := today;
        ServiceHeader."No." := '';
        ServiceHeader.Excavation := ServiceHeader.Excavation::"No Excavation";
        ServiceHeader."Verif Done" := false;
        ServiceHeader."Control Done" := false;
        ServiceHeader."Realisation Done" := false;
        ServiceHeader."Verif Date" := 0D;
        ServiceHeader."Control Date" := 0D;
        ServiceHeader."Done Date" := 0D;

        ServiceHeader."Real. Process. Empl. No." := '';
        ServiceHeader."Real. Process. Empl. Name" := '';
        ServiceHeader."Real. Contr. Empl. No." := '';
        ServiceHeader."Real. Verif. Empl. Name" := '';
        ServiceHeader."Real. Contr. Empl. Name" := '';
        ServiceHeader."Real. Verif. Empl. Name" := '';
        ServiceHeader."Prep. Process. Empl. No." := '';
        ServiceHeader."Prep. Process. Empl. No." := '';
        ServiceHeader."Prep. Contr. Empl. No." := '';
        ServiceHeader."Prep. Contr. Empl. Name" := '';
        ServiceHeader."Prep. Verif. Empl. Name" := '';
        ServiceHeader."Prep. Verif. Empl. No." := '';

        ServiceHeader."Geo. Activity Type" := '';

        ServiceHeader."Request ID" := RequestID;

        ServiceHeader."Request Group" := '';
        ServiceHeader."Activity Type" := '';
        ServiceHeader."Starting Date" := 0D;
        ServiceHeader."Starting Time" := 0T;
        ServiceHeader."Finishing Date" := 0D;
        ServiceHeader."Finishing Time" := 0T;

        ServiceHeader."Time of ticket" := 0T;
        ServiceHeader."Time of sender" := 0T;
        ServiceHeader."Date of ticket" := 0D;
        ServiceHeader."Date of sender" := 0D;

        ServiceHeader."Order Date" := 0D;
        ServiceHeader."Order Time" := 0T;

        ServiceHeader."Real. Process. Empl. No." := '';
        ServiceHeader."Real. Process. Empl. Name" := '';
        ServiceHeader."Real. Contr. Empl. No." := '';
        ServiceHeader."Real. Verif. Empl. Name" := '';
        ServiceHeader."Real. Contr. Empl. Name" := '';
        ServiceHeader."Real. Verif. Empl. Name" := '';
        ServiceHeader."Prep. Process. Empl. No." := '';
        ServiceHeader."Prep. Process. Empl. No." := '';
        ServiceHeader."Prep. Contr. Empl. No." := '';
        ServiceHeader."Prep. Contr. Empl. Name" := '';
        ServiceHeader."Prep. Verif. Empl. Name" := '';
        ServiceHeader."Prep. Verif. Empl. No." := '';

        UseriD_REc.Get(UserId);
        ServiceHeader."No. Series" := GetNoSeries(RequestType);

        ECL.Reset();
        ECL.SetFilter("Employee No.", '%1', UseriD_REc."Employee No. for Wage");
        ECL.setfilter(active, '%1', true);
        if ECL.findfirst then
            ServiceHeader.Validate("Responsible Department", ecl."Department Code");




        ECL.Reset();
        ECL.SetFilter("Employee No.", '%1', UseriD_REc."Employee No. for Wage");
        ECL.setfilter(active, '%1', true);
        if ECL.findfirst then
            ServiceHeader.Validate("Request Department", ecl."Department Code");



        USSet.Reset();
        USSet.SetFilter("User ID", '%1', UserId);
        if USSet.FindFirst() then begin
            if USSet.HS = false then
                ServiceHeader.Validate("Real. Process. Empl. No.", USSet."Employee No. for Wage");
        end;




        ServiceHeader."Holder of works" := ServiceHeader."Responsible Department";


        OrgS.Reset();
        OrgS.SetFilter("Date From", '<=%1', today);
        OrgS.SetCurrentKey("Date From");
        OrgS.Ascending;
        if orgs.FindLast() then begin
            DepartmentCOdeShema.reset;
            DepartmentCOdeShema.SetFilter("ORG Shema", '%1', OrgS.code);
            DepartmentCOdeShema.SetFilter(Code, '%1', "Responsible Department");
            if DepartmentCOdeShema.FindFirst() then begin
                if ServiceHeader."Real. Process. Empl. No." = '' then
                    ServiceHeader.validate("Real. Process. Empl. No.", DepartmentCOdeShema."Signatory 1");
                if ServiceHeader."Real. Verif. Empl. No." = '' then
                    ServiceHeader.validate("Real. Verif. Empl. No.", DepartmentCOdeShema."Signatory 1 Position");
                if ServiceHeader."Real. Contr. Empl. No." = '' then
                    ServiceHeader.validate("Real. Contr. Empl. No.", DepartmentCOdeShema."Signatory 2");
                if ServiceHeader."Prep. Process. Empl. No." = '' then
                    ServiceHeader.validate("Prep. Process. Empl. No.", DepartmentCOdeShema."Prip Realisation");
                //  if ServiceHeader."Real. Verif. Empl. No." = '' then
                if ServiceHeader."Prep. Contr. Empl. No." = '' then
                    ServiceHeader.validate("Prep. Contr. Empl. No.", DepartmentCOdeShema."Prip Control");
                //  if ServiceHeader."Real. Contr. Empl. No." = '' then
                if ServiceHeader."Prep. Verif. Empl. No." = '' then
                    ServiceHeader.validate("Prep. Verif. Empl. No.", DepartmentCOdeShema."Prip Verif");


            end
            else begin

            end;
        end;




        OrgS.Reset();
        OrgS.SetFilter("Date From", '<=%1', today);
        OrgS.SetCurrentKey("Date From");
        OrgS.Ascending;
        if orgs.FindLast() then begin
            DepartmentCOdeShema.reset;
            DepartmentCOdeShema.SetFilter("ORG Shema", '%1', OrgS.code);
            DepartmentCOdeShema.SetFilter(Code, '%1', "Responsible Department");
            if DepartmentCOdeShema.FindFirst() then begin
                Sector := DepartmentCOdeShema.sector;
                "Sector Text" := DepartmentCOdeShema."Sector  Description";
            end
            else begin
                Sector := '';
                "Sector Text" := '';
            end;
        end;


        ServiceHeader."Order Date" := today;
        ServiceHeader."Order Time" := Time;

        ServiceHeader."Prep Realisation Done" := false;
        ServiceHeader."Prep Verif Done" := false;
        ServiceHeader."Prep Control Done" := false;
        ServiceHeader."Prep Done Date" := 0D;
        ServiceHeader."Prep Control Date" := 0D;
        ServiceHeader."Prep Verif Date" := 0D;
        ServiceHeader."Realisation Done" := false;
        ServiceHeader."Verif Done" := false;
        ServiceHeader."Control Done" := false;
        ServiceHeader."Done Date" := 0D;
        ServiceHeader."Control Date" := 0D;
        ServiceHeader."Verif Date" := 0D;
        ServiceHeader."Need to reopen work order" := false;
        ServiceHeader."Due Days Reopen" := 0;
        ServiceHeader.Insert(True);
        //  RequestID := ServiceHeader."Request ID";
        //  ServiceHeader.TransferFields(Rec, false);
        ServiceHeader."Reason For Service Order" := Remar;
        ServiceHeader."Remark For Service Order" := Descri;
        //ServiceHeader."Request ID" := RequestID;
        ServiceHeader."Request Type" := RequestType;
        // ServiceHeader."CZK Request No." := "No.";
        Serviceheader."Document Date" := Today();
        ServiceHeader.Modify(true);
        /*  ServiceItemLine.SetRange("Document Type", "Document Type");
          ServiceItemLine.SetRange("Document No.", "No.");
          if ServiceItemLine.FindSet() then
              repeat
                  NewServiceItemLine.Init();
                  NewServiceItemLine.TransferFields(ServiceItemLine, false);
                  NewServiceItemLine."Document Type" := "Document Type";
                  NewServiceItemLine."Document No." := ServiceHeader."No.";
                  NewServiceItemLine."Line No." := ServiceItemLine."Line No.";
                  NewServiceItemLine.Insert();
              until ServiceItemLine.Next() = 0;*/

        if ServiceHeader."Request Type" = ServiceHeader."Request Type"::"Project and Energy Accordance" then begin

            Mandat.Reset();
            Mandat.SetFilter(Information, '%1', true);
            Mandat.SetFilter("Request Type", '%1', ServiceHeader."Request Type");
            if mandat.FindSet() then
                repeat
                    DocumentAttachment.Init();
                    DocumentAttachment."Table ID" := Database::"Service Item Line";
                    DocumentAttachment."No." := ServiceHeader."No.";
                    DocumentAttachment."Line No." := 1000;
                    DocumentAttachment.Mandatory := Mandat.Mandatory;
                    DocumentAttachment.ID := 0;
                    DocumentAttachment.Information := mandat.Information;
                    DocumentAttachment."Mandatory Attachment Type" := mandat."Mandatory Attachment Type";
                    DocumentAttachment."File Name" := 'Odaberite datoteku...';
                    DocumentAttachment.Insert();
                until Mandat.Next() = 0;
        end;
    end;

    procedure CreateWorkOrder(var ServiceHeader: Record "Service Header"; var Descri: Text[250]; var Remar: Text[250])
    var
        ServiceItemLine: record "Service Item Line";
        NewServiceItemLine: record "Service Item Line";
        RequestID: Code[20];
        ServiceLineRec: Record "Service Line";
        ServiceLine: Record "Service Line";
    begin
        ServiceHeader.Init();
        ServiceHeader."Document Type" := Enum::"Service Document Type"::Order;
        ServiceHeader."VAT Date" := today;

        ServiceHeader."No." := '';
        ServiceHeader."Order Date" := today;
        ServiceHeader."Order Time" := Time;
        ServiceHeader.Insert(True);

        RequestID := ServiceHeader."Request ID";
        ServiceHeader."Reason For Service Order" := Descri;
        ServiceHeader."Remark For Service Order" := Remar;

        ServiceHeader.TransferFields(Rec, false);
        ServiceHeader."Order Date" := today;
        ServiceHeader."Order Time" := Time;
        ServiceHeader."Request ID" := RequestID;
        ServiceHeader."Request Type" := Enum::"Request Type"::"Information on Connection";
        ServiceHeader."CZK Request No." := "No.";
        Serviceheader."Document Date" := Today();
        ServiceHeader."Prep Realisation Done" := false;
        ServiceHeader."Prep Verif Done" := false;
        ServiceHeader."Prep Control Done" := false;
        ServiceHeader."Prep Done Date" := 0D;
        ServiceHeader."Prep Control Date" := 0D;
        ServiceHeader."Prep Verif Date" := 0D;
        ServiceHeader."Realisation Done" := false;
        ServiceHeader."Verif Done" := false;
        ServiceHeader."Control Done" := false;
        ServiceHeader."Done Date" := 0D;
        ServiceHeader."Control Date" := 0D;
        ServiceHeader."Verif Date" := 0D;
        ServiceHeader."Need to reopen work order" := false;
        ServiceHeader."Due Days Reopen" := 0;
        ServiceHeader.Modify(true);
        ServiceItemLine.SetRange("Document Type", "Document Type");
        ServiceItemLine.SetRange("Document No.", "No.");
        if ServiceItemLine.FindSet() then
            repeat
                if ServiceItemLine."Already Transfer" = false then begin
                    NewServiceItemLine.Init();
                    NewServiceItemLine.TransferFields(ServiceItemLine, false);

                    UseriD_REc.Reset();
                    UseriD_REc.SetFilter("User ID", '%1', UserId);
                    if UseriD_REc.FindFirst() then begin
                        if UseriD_REc.FindFirst() then begin
                            if UseriD_REc.HS = true then begin
                                NewServiceItemLine."Date of consumption" := 0D;
                            end;
                        end;
                    end;

                    NewServiceItemLine."Document Type" := "Document Type";
                    NewServiceItemLine."Document No." := ServiceHeader."No.";
                    NewServiceItemLine."CZK ID" := ServiceItemLine."Document No.";
                    NewServiceItemLine."Line No." := ServiceItemLine."Line No.";
                    NewServiceItemLine.Applied := falsE;
                    NewServiceItemLine.Insert();

                    ServiceItemLine."Already Transfer" := true;
                    ServiceItemLine.Modify();
                end;
            until ServiceItemLine.Next() = 0;

        if (Rec."Request Type" = rec."Request Type"::"Information Issuing Request")
       or (rec."Request Type" = rec."Request Type"::"Location Accordance Issuing Request")
       or (rec."Request Type" = rec."Request Type"::"Project overview Request")
       or (rec."Request Type" = rec."Request Type"::"Route Accordance Issuing Request")
       or (rec."Request Type" = rec."Request Type"::"Spatial plan Accordance Issuing Request")
        or (rec."Request Type" = rec."Request Type"::"Work Execution Request")
        then begin
            if ServiceHeader."Request Type" = ServiceHeader."Request Type"::"General Work Order" then begin
                ServiceLineRec.reset;
                ServiceLineRec.setfilter("Document No.", '%1', rec."No.");
                ServiceLineRec.setfilter("Document Type", '%1', rec."Document Type");
                ServiceLineRec.SetFilter(Type, '%1', ServiceLineRec.type::Item);
                if ServiceLineRec.FindSet() then
                    repeat
                        ServiceLine.init;
                        ServiceLine.TransferFields(ServiceLineRec);
                        ServiceLine."Document No." := ServiceHeader."No.";
                        ServiceLine."Document Type" := ServiceHeader."Document Type";

                        ServiceLine.insert;

                    until ServiceLineRec.next() = 0;
            end;
        end;
    end;

    local procedure OnValidateExecutionCompanyNo()
    var
        Contact: Record Contact;
    begin
        if "Execution Company No." = '' then begin
            "Execution Company Name" := '';
            "Execution Address" := '';
            "Execution Company No." := '';
            "Contractor No" := '';
            "Responsible Contact" := '';


            exit;
        end;

        Contact.Get("Execution Company No.");
        "Execution Company Name" := Contact.Name;
        "Execution Address" := Contact.Address;
        "Execution Company Phone No." := Contact."Phone No.";
        "Contractor No" := Contact."Contractor No";
        "Responsible Contact" := contact."Responsible Contact";
    end;

    local procedure OnValidateStreet()
    var
        Stroke: Record Stroke;
    begin
        Stroke.ValidateStreetNo("Street No.", "Street", "Municipality Code", "MZ", "Stroke No.", "Customer String", "Zone Stroke No.");
        Validate("Municipality Code");
        Validate("MZ");
        CalcFields("Street Name", "Municipality Name", "MZ Name");
        "Address" := StrSubstNo('%1 %2', "Street Name", "Street No.");
    end;


    local procedure OnValidateStreet_Cust()
    var
        Stroke: Record Stroke;
        CustomerUpdate: Record customer;
        ServiceHeaderUpdate: Record "Service Header";
    begin
        CustomerUpdate.Reset();
        CustomerUpdate.SetFilter("No.", '%1', rec."Customer No.");
        if CustomerUpdate.FindFirst() then begin
            //      Stroke.ValidateStreetNo("Street No.", "Street", "Municipality Code", "MZ", "Stroke No.", "Customer String", "Zone Stroke No.");
            CustomerUpdate.validate("Street Customer", Street);
            //  CustomerUpdate.validate("Municipality Code Customer");
            CustomerUpdate.Validate("Street No.", "Street No.");
            CustomerUpdate.modify;

            ServiceHeaderUpdate.Reset();
            ServiceHeaderUpdate.SetFilter("Customer No.", '%1', rec."Customer No.");
            ServiceHeaderUpdate.SetFilter("Verif Done", '%1', false);
            if ServiceHeaderUpdate.FindSet() then
                repeat
                    ServiceHeaderUpdate.Street := CustomerUpdate."Street Customer";
                    ServiceHeaderUpdate.Address := CustomerUpdate.Address;
                    ServiceHeaderUpdate."Street No." := CustomerUpdate."Street No.";
                    ServiceHeaderUpdate."Municipality Code" := CustomerUpdate."Municipality Code Customer";
                    ServiceHeaderUpdate."Post Code" := CustomerUpdate."Post Code";
                    ServiceHeaderUpdate.City := CustomerUpdate.city;
                    ServiceHeaderUpdate.MZ := CustomerUpdate."MZ Customer";
                    ServiceHeaderUpdate."Stroke No." := CustomerUpdate."Customer Stroke";
                    ServiceHeaderUpdate."Customer String" := CustomerUpdate."Customer String";
                    ServiceHeaderUpdate."Zone Stroke No." := CustomerUpdate."Zone stroke";
                    ServiceHeaderUpdate.Modify();

                until ServiceHeaderUpdate.Next() = 0;


        end;

    end;

    local procedure OnValidateStreet_Cust2()
    var
        Stroke: Record Stroke;
        CustomerUpdate: Record customer;
        ServiceHeaderUpdate: Record "Service Header";
    begin
        CustomerUpdate.Reset();
        CustomerUpdate.SetFilter("No.", '%1', rec."Customer No.");
        if CustomerUpdate.FindFirst() then begin
            //Stroke.ValidateStreetNo("Street No.", "Street", "Municipality Code", "MZ", "Stroke No.", "Customer String", "Zone Stroke No.");
            CustomerUpdate.validate("Street Customer 2", "Street 2");
            //  CustomerUpdate.validate("Municipality Code Customer");
            CustomerUpdate.Validate("Street No. 2", "Street No. 2");
            CustomerUpdate.modify;

            ServiceHeaderUpdate.Reset();
            ServiceHeaderUpdate.SetFilter("Customer No.", '%1', rec."Customer No.");
            ServiceHeaderUpdate.SetFilter("Verif Done", '%1', false);
            if ServiceHeaderUpdate.FindSet() then
                repeat
                    ServiceHeaderUpdate."Street 2" := CustomerUpdate."Street Customer 2";
                    ServiceHeaderUpdate."Address 2" := CustomerUpdate."Address 2";
                    ServiceHeaderUpdate."Street No. 2" := CustomerUpdate."Street No. 2";
                    ServiceHeaderUpdate."Municipality Code 2" := CustomerUpdate."Municipality Code Customer 2";
                    ServiceHeaderUpdate."Post Code 2" := CustomerUpdate."Post Code 2";
                    ServiceHeaderUpdate."City 2" := CustomerUpdate."City 2";
                    ServiceHeaderUpdate."MZ 2" := CustomerUpdate."MZ Customer 2";
                    ServiceHeaderUpdate."Stroke No. 2" := CustomerUpdate."Customer Stroke 2";
                    ServiceHeaderUpdate."Customer String 2" := CustomerUpdate."Customer String 2";
                    ServiceHeaderUpdate."Zone Stroke No. 2" := CustomerUpdate."Zone stroke 2";
                    ServiceHeaderUpdate.Modify();

                until ServiceHeaderUpdate.Next() = 0;

        end;

    end;


    local procedure OnValidateStreet2()
    var
        Stroke: Record Stroke;
    begin
        Stroke.ValidateStreetNo("Street No. 2", "Street 2", "Municipality Code 2", "MZ 2", "Stroke No. 2", "Customer String 2", "Zone Stroke No. 2");
        Validate("Municipality Code 2");
        Validate("MZ 2");
        CalcFields("Street Name 2", "Municipality Name 2", "MZ Name 2");
        "Address 2" := StrSubstNo('%1 %2', "Street Name 2", "Street No. 2");
    end;

    local procedure OnValidateOwnerStreet()
    var
        Stroke: Record Stroke;
    begin
        Stroke.ValidateStreetNo("Owner Street No.", "Owner Street", "Owner Municipality Code", "Owner MZ");
        Validate("Owner Municipality Code");
        Validate("Owner MZ");
        CalcFields("Owner Street Name", "Owner Municipality Name", "Owner MZ Name");
        "Owner Address" := StrSubstNo('%1 %2', "Owner Street Name", "Owner Street No.");
    end;

    local procedure OnValidateMunicipality()
    var
        Municipality: Record Municipality;
    begin
        Municipality.ValidateMunicipality("Municipality Code", City, "Post Code");
    end;

    local procedure OnValidateMunicipality2()
    var
        Municipality: Record Municipality;
    begin
        Municipality.ValidateMunicipality("Municipality Code 2", "City 2", "Post Code 2");
    end;

    procedure GetDefaultResponsibleDepartment(var DeparmentCode: Code[20]; var CZKUser: Boolean; Manag: Boolean; Emp_bezt: Code[20])
    var
        UserSetup: Record "User Setup";
        Employee: Record Employee;
        US: Record "User Personalization";
        EmployeeContractLedger: Record "Employee Contract Ledger";
    begin
        Employee.SetAutoCalcFields("Department Code");
        Employee.SetLoadFields("Department Code");


        if not UserSetup.Get(UserId) then
            exit;
        if not Employee.Get(UserSetup."Employee No. for Wage") then
            exit;

        DeparmentCode := Employee."Department Code";
        CZKUser := UserSetup."CZK User";
        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if us."Profile ID" = 'CZK' then
                CZKUser := true
            else
                CZKUser := false;

        end;

        Manag := false;



        EmployeeContractLedger.Reset();
        EmployeeContractLedger.SetFilter("Employee No.", '%1', Employee."No.");
        EmployeeContractLedger.SetFilter(Active, '%1', true);
        if EmployeeContractLedger.FindFirst() then begin
            if (EmployeeContractLedger."Management Level" <> EmployeeContractLedger."Management Level"::E) then
                Manag := true
            else
                Manag := false;
        end;
        Emp_bezt := Employee."No.";



    end;

    procedure FindEmployee(var No: code[20]) EmployeeName: Text[250]
    var
        Empl: Record employee;
    begin
        empl.Reset();
        empl.SetFilter("No.", '%1', No);
        if empl.FindFirst() then begin
            EmployeeName := Empl."First Name" + ' ' + Empl."Last Name";
        end
        else begin
            EmployeeName := '';
        end;
    end;

    procedure FindEmployeeInitials(var No: Code[20]) EmployeeInitials: Text[5]
    var
        E: Record Employee;
    begin
        E.Reset();
        E.SetRange("No.", No);
        if E.FindFirst() then begin
            EmployeeInitials := E.Initials;
        end else begin
            EmployeeInitials := '';
        end;
    end;

    procedure GetDefaultResponsibleDepartment(var DepartmentCode: Code[20]; var Manag: boolean; Emp_2: Code[20])
    var
        CZKUser: Boolean;
    begin
        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
    end;

    procedure SetDepartmentFilter()
    var
        DepartmentCode: Code[20];
        CZKUser: Boolean;
        Manag: Boolean;
        Emp_2: Code[20];
        EmployeeContractLedger: Record "Employee Contract Ledger";
        Userid_rec: Record "User Setup";

    begin

        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);

        Manag := false;


        Userid_rec.Get(UserId);
        EmployeeContractLedger.Reset();
        EmployeeContractLedger.SetFilter("Employee No.", '%1', Userid_rec."Employee No. for Wage");
        EmployeeContractLedger.SetFilter(Active, '%1', true);
        if EmployeeContractLedger.FindFirst() then begin
            if (EmployeeContractLedger."Management Level" <> EmployeeContractLedger."Management Level"::E) then
                Manag := true
            else
                Manag := false;
        end;
        Emp_2 := Userid_rec."Employee No. for Wage";


        if Userid_rec."CZK User" = true then begin

            SetFilter("Request Department", DepartmentCode);
        end

        else begin
            if Manag = false then begin
                //   if Userid_rec."Control R" = true then begin
                //     SetFilter("Employee Control Responsible", Emp_2);
                // end
                // else begin
                //   if Userid_rec."Verif R" = true then
                //        SetFilter("Employee Prepare Responsible", Emp_2)
                //   else
                //     SetFilter("Employee Responsible", Emp_2);
                //   end;

            end

            else begin
                SetFilter("Responsible Department", DepartmentCode);
            end;
        end;

    end;

    local procedure GetNoSeries(RequestType: Enum "Request Type"): Code[20]
    var
        ServiceMgtSetup: Record "Service Mgt. Setup";
    begin
        ServiceMgtSetup.Get;
        exit(ServiceMgtSetup.GetRequestNoSeries(RequestType));
    end;

    procedure GetProcessingDocument(): Code[20]
    var
        ServiceHeader: Record "Service Header";
        ProcessingDocumentType: Enum "Request Type";
    begin
        ProcessingDocumentType := GetProcessingDocumentType("Request Type");
        if ProcessingDocumentType = Enum::"Request Type"::"Others" then
            exit;

        ServiceHeader.SetLoadFields("No.");
        ServiceHeader.SetRange("Request Type", ProcessingDocumentType);
        ServiceHeader.SetRange("CZK Request No.", "No.");
        if ServiceHeader.FindFirst then
            exit(ServiceHeader."No.");

        exit('');
    end;

    local procedure GetProcessingDocumentType(RequestDocumentType: Enum "Request Type"): Enum "Request Type";
    begin
        case RequestDocumentType of
            enum::"Request Type"::"Information Issuing Request":
                exit(Enum::"Request Type"::"Information on Connection");
            enum::"Request Type"::"Project overview Request":
                exit(Enum::"Request Type"::"Project and Energy Accordance");
            enum::"Request Type"::"Location Accordance Issuing Request":
                exit(Enum::"Request Type"::"Location Accordance Issuing Information");
            enum::"Request Type"::"Route Accordance Issuing Request":
                exit(Enum::"Request Type"::"Route Accordance Issuing Information");
            enum::"Request Type"::"Spatial plan Accordance Issuing Request":
                exit(Enum::"Request Type"::"Spatial plan Accordance Issuing Information");
            enum::"Request Type"::"Work Execution Request":
                exit(Enum::"Request Type"::"UGI Overview and First Release");
            else
                exit(Enum::"Request Type"::"Others");
        end;
    end;

    local procedure UpdateLastModified()
    begin
        "Last DateTime Modified" := CurrentDateTime;
        "Last Modified by User" := CopyStr(UserId, 1, 50);
    end;



    procedure GetLinkedRequests(StartNo: Code[20]; var TempResultRec: Record Template_Message temporary; EntryNo: Integer)
    var
        CZKExsist: Record "Service Header";
    begin
        // Dodaj početni No.
        TempResultRec.Reset();
        TempResultRec.SetFilter("Message Code", '%1', StartNo);
        if not TempResultRec.findfirst then begin
            TempResultRec.Init();
            TempResultRec."Message Code" := StartNo;
            TempResultRec."ID" := EntryNo;
            EntryNo += 1;
            TempResultRec.Insert();
        end;

        // Pokreni rekurziju
        GetChildRequests(StartNo, TempResultRec, Count);

        CZKExsist.Reset();
        CZKExsist.SetFilter("No.", '%1', StartNo);
        if CZKExsist.findfirst then begin

            if CZKExsist."CZK Request No." <> '' then begin
                TempResultRec.Reset();
                TempResultRec.SetFilter("Message Code", '%1', CZKExsist."CZK Request No.");
                if not TempResultRec.findfirst then begin
                    TempResultRec.Init();
                    TempResultRec."Message Code" := CZKExsist."CZK Request No.";
                    TempResultRec."ID" := EntryNo;
                    EntryNo += 1;
                    TempResultRec.Insert();
                end;

                // Pokreni rekurziju
                GetChildRequests(CZKExsist."CZK Request No.", TempResultRec, Count);
            end;
        end;
    end;


    local procedure GetChildRequests(ParentNo: Code[20]; var TempResultRec: Record Template_Message temporary; EntryNo: integer)
    var
        MyTable: Record "Service Header";
    begin
        MyTable.Reset();
        MyTable.SetRange("CZK Request No.", ParentNo);
        if MyTable.FindSet() then
            repeat
                TempResultRec.reset;
                TempResultRec.setfilter("Message Code", '%1', MyTable."No.");
                if not TempResultRec.findfirst then begin
                    TempResultRec.Init();
                    TempResultRec."Message Code" := MyTable."No.";
                    TempResultRec."ID" := EntryNo;
                    EntryNo += 1;
                    TempResultRec.Insert();
                    // Rekurzivno idi dalje
                    GetChildRequests(MyTable."No.", TempResultRec, EntryNo);
                end;
            until MyTable.Next() = 0;
        MyTable.Reset();
        MyTable.SetRange("No.", ParentNo);
        if MyTable.FindSet() then
            repeat
                TempResultRec.reset;
                if MyTable."CZK Request No." <> '' then begin
                    TempResultRec.setfilter("Message Code", '%1', MyTable."CZK Request No.");
                    if not TempResultRec.findfirst then begin
                        TempResultRec.Init();
                        TempResultRec."Message Code" := MyTable."CZK Request No.";
                        TempResultRec."ID" := EntryNo;
                        EntryNo += 1;
                        TempResultRec.Insert();
                        // Rekurzivno idi dalje
                        GetChildRequests(MyTable."CZK Request No.", TempResultRec, EntryNo);
                    end;
                end;
            until MyTable.Next() = 0;

    end;



    procedure ShowProcessRequests()
    var
        ServiceHeader: Record "Service Header";
        ProcessingDocumentType: Enum "Request Type";
    begin
        ProcessingDocumentType := GetProcessingDocumentType("Request Type");
        if ProcessingDocumentType = Enum::"Request Type"::"Others" then
            exit;

        ServiceHeader.FilterGroup(4);
        ServiceHeader.SetRange("Request Type", ProcessingDocumentType);
        ServiceHeader.FilterGroup(0);
        ServiceHeader.SetRange("CZK Request No.", "No.");

        Page.Run(Page::Requests, ServiceHeader);
    end;

    var
        UseriD_REc: Record "User Setup";
        Text007: Label 'You dont have permission to do actions!';
        TempServiceHeader: Record "Temp Service Header";

        ServiceLineDiameterCannotContainsLetters: Label 'this field can not contain letters or (.)';
        IsCopyWorkOrder: Boolean;
        BackupFinishingTime: Time;
        BackupFinishingDate: Date;
}

