tableextension 50066 ServiceInvoiceHeaderExtends extends "Service Invoice Header"
{
    fields
    {
        //    VAT Base (retro.)
        field(50000; "VAT Date"; Date)
        {

            DataClassification = ToBeClassified;

        }





        //Fiscal DateTime

        field(50001; "Fiscal DateTime"; DateTime)
        {

            DataClassification = ToBeClassified;

        }

        field(50002; "Fiscal User"; COde[250])
        {

            DataClassification = ToBeClassified;

        }

        field(50003; "Fiscal No."; COde[20])
        {

            DataClassification = ToBeClassified;

        }

        field(50004; "Fiscal No. Printed"; Boolean)
        {

            DataClassification = ToBeClassified;

        }

        field(50005; "Fiscal Printer Code"; Code[20])
        {

            DataClassification = ToBeClassified;

        }

        field(70099; "Bill type"; Code[20]) //ED
        {
            Caption = 'Bill Type';
            TableRelation = "Customer Templ.";
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



        //proširla invoice - primjer


        field(60000; "Request Type"; Enum "Request Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Request Type';
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
            TableRelation = "Activity Type".Description;
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
                //   OnValidateDesignerNo();
            end;
        }
        field(60013; "Project"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Project';
            TableRelation = "Project".Description;
        }
        field(60014; Grouping; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Grouping';
            TableRelation = Grouping.Description;
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
        }
        field(60018; "Prep. Contr. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparation - Controlling Employee No.';
            TableRelation = Employee;
        }
        field(60019; "Prep. Verif. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparation - Verification Employee No.';
            TableRelation = Employee;
        }
        field(60020; "Real. Process. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Processing Employee No.';
            TableRelation = Employee;
        }
        field(60021; "Real. Contr. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Controlling Employee No.';
            TableRelation = Employee;
        }
        field(60022; "Real. Verif. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Verification Employee No.';
            TableRelation = Employee;
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
                //    OnValidateOwnerNo();
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
            TableRelation = Municipality.Code where(Type = filter(Regular));
            trigger OnValidate()
            begin
                //    OnValidateMunicipality();
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
                //  OnValidateStreet();
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
                //   OnValidateStreet();
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
                //    OnValidateOwnerStreet();
            end;
        }

        field(60046; "Owner Street Name"; Text[250])
        {
            Caption = 'Street Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Street.Description where(Code = field("Owner Street")));
            Editable = false;
        }
        field(70127; "Connection to"; Option)
        {
            Caption = 'Connection to';
            OptionMembers = " ","Distribution gas line","Service gas line";
            OptionCaption = ' ,Distribution gas line,Service gas line';
        }
        field(70268; "Transfer Order"; Code[20])
        {
            Caption = 'Transfer Order';


        }
        field(60047; "Owner Street No."; Code[20])
        {
            Caption = 'Street No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //   OnValidateOwnerStreet();
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
        field(70222; "Chimney Expert Date"; Date)
        {
            Caption = 'Chimney Expert Date', Comment = 'Stručni nalaz dimnjačara';
            DataClassification = CustomerContent;
        }
        field(60055; "Execution Company No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Execution Company No.', Comment = 'Br. izvođača';
            TableRelation = Contact where("Type Relation" = const(Contractor));
            trigger OnValidate()
            begin
                //  OnValidateExecutionCompanyNo();
            end;
        }
        field(60056; "Execution Company Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Execution Company Name', Comment = 'Naziv izvođača';
        }
        field(70104; "Project Date"; Date)
        {
            Caption = 'Project Date';
        }
        field(70105; "Service Header UGI"; code[20])
        {
            Caption = 'Service Header UGI';
            TableRelation = "Service Header"."No." where("Customer No." = field("Customer No."), "Request Type" = filter(4 | 5));
            trigger OnValidate()
            var
                myInt: Integer;
                SH: Record "Service Header";
            begin
                SH.Reset();
                SH.SetFilter("No.", '%1', rec."No.");
                if SH.FindFirst() then begin
                    "Service Date UGI" := sh."Document Date";
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
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Sent to ZIK" where("CZK Request No." = field("CZK Request No."), "Request Type" = filter("General Geo. Work Order Office"),
            "Sent to ZIK" = filter(<> '')));


        }
        field(60064; "Received from ZIK"; Date)
        {
            Caption = 'Received from ZIK', Comment = 'Preuzeto iz ZIK';
            // DataClassification = CustomerContent;
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Received from ZIK" where("CZK Request No." = field("CZK Request No."), "Request Type" = filter("General Geo. Work Order Office"),
            "Received from ZIK" = filter(<> '')));
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

        field(70115; "Prep. Process. Empl. Name."; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparation - Processing Employee Name';
            Editable = false;
        }
        field(70116; "Prep. Contr. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparation - Controlling Employee Name';
            Editable = false;
        }
        field(70117; "Prep. Verif. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparation - Verification Employee Name';
            Editable = false;
        }
        field(70118; "Real. Process. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Processing Employee Name';
            Editable = false;
        }
        field(70119; "Real. Contr. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Controlling Employee Name';
            Editable = false;
        }
        field(70120; "Real. Verif. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Verification Employee Name';
            Editable = false;
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
        field(70290; Initials; Text[30])
        {
            Caption = 'Initials';
        }
        field(70124; "Document No."; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("A-B Attachments" where(Code = field("No."), Source = filter("Service Order"), Type = filter("Service Order")));

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
        field(70109; "Execution Protocol No. Text"; Text[250])
        {
            Caption = 'Execution Protocol No.', Comment = 'Broj protokola izvođača';
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
            TableRelation = Municipality.Code where(type = filter(Regular));
            trigger OnValidate()
            begin
                //   OnValidateMunicipality2();
            end;
        }
        field(70029; "Municipality Name 2"; Text[250])
        {
            Caption = 'Municipality Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("Municipality Code 2"), type = filter(Regular)));

            Editable = false;
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
            //  FieldClass = FlowField;
            Editable = false;
            //CalcFormula = lookup(Municipality.Name where(Type = filter(KO), Code = field("Catastral Municipality")));
            // TableRelation = Municipality.Code where(Type = filter(KO));
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
                //   OnValidateStreet2();
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
                //     OnValidateStreet2();
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
            FieldClass = FlowField;
            CalcFormula = lookup(Department.Description where(Code = field("Responsible Department")));
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
        field(70220; "Measure Point Pressure1"; enum Pressure)
        {
            Caption = 'Measure Point Pressure', Comment = 'Pritisak na mjestu mjerenja';
            DataClassification = CustomerContent;
        }
        field(70221; "Protocol No."; Text[250])
        {
            Caption = 'Protocol No.', Comment = 'Pritisak na mjestu mjerenja';
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
        field(70281; "Prep Control Done"; Boolean)
        {
            Caption = 'Prep Done';

            trigger OnValidate()
            var
                myInt: Integer;
                UserS: record "User Setup";
                Text007: Label 'You dont have permission to do actions!';
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
                Text007: Label 'You dont have permission to do actions!';
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
        field(70286; "GPS Tersus (S)"; boolean)
        {
            caption = 'GPS Tersus (Recording)';
        }
        //Novi
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
        //kraj
        field(70289; "Contact Geo"; text[20])
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
        field(70288; "Folder yes"; Boolean)
        {
            Caption = 'Folder yes';
        }


        field(70287; "GPS Tersus (T)"; boolean)
        {
            caption = 'GPS Tersus (T)';
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
        field(70061; "Project Accordance Date"; Date)
        {
            Caption = 'Project Accordance Date', Comment = 'Datum saglasnosti na projekat';
            DataClassification = CustomerContent;
        }
        field(70062; "UGI Project Name"; Text[250])
        {
            Caption = 'UGI Project Name', Comment = 'Naziv projekta UGI';
            DataClassification = CustomerContent;
        }
        field(70063; "Service Line Diameter"; Text[250])
        {
            Caption = 'Service Line Diameter', Comment = 'Prečnik servisnog voda';
            DataClassification = CustomerContent;
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
        }
        field(70068; "UGI Project Creation Date"; Date)
        {
            Caption = 'UGI Project Creation Date', Comment = 'Datum izrade UGI projekta';
        }
        field(70069; "Information Number"; Text[250])
        {
            Caption = 'Information Number', Comment = 'Broj infromacije';
            DataClassification = CustomerContent;
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
        }
        field(70073; "Request Department Name"; Text[150])
        {
            Caption = 'Request Department Name', Comment = 'Naziv org. jedinice pošiljaoca';
            FieldClass = FlowField;
            CalcFormula = lookup(Department.Description where(Code = field("Request Department")));
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
        field(70102; "Status_request"; enum "Information of processing") //ED
        {
            Caption = 'Status request';
            FieldClass = FlowField;
            CalcFormula = lookup("Status History 2"."Information of processing" where("Request No." = field("Order No."), Active = filter(true), "Source Table" = filter(5900)));


        }

        field(70103; "Contractor No"; Text[250])
        {
            Caption = 'Contractor';
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

        //kraj invoice
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
            begin
                geo.reset;
                geo.SetFilter(Description, '%1', "GEO WorkPlaces");
                if geo.FindFirst() then
                    "Investor Code" := geo.Investor
                else
                    "Investor Code" := '';
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
                geo.reset;
                geo.SetFilter(Description, '%1', "GEO WorkPlaces");
                if geo.FindFirst() then
                    "Investor Name" := geo."Investor Name"
                else
                    "Investor Name" := '';
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
            begin
                geo.reset;
                geo.SetFilter(Description, '%1', "GEO WorkPlaces");
                if geo.FindFirst() then
                    "GEO Constructor Manager" := geo."GEO Construction Manager"
                else
                    "GEO Constructor Manager" := '';
            end;
        }
        field(70216; "GEO Constructor Manager Name"; Code[250])
        {
            Caption = 'GEO WorkPlaces';
            // TableRelation = Contact."No." where("Type Relation" = filter("GEO Construction Manager"));

            trigger OnValidate()
            var
                myInt: Integer;
                GEO: Record "GEO WorkPlace";
            begin
                /*   geo.reset;
                   geo.SetFilter(Description, '%1', "GEO WorkPlaces");
                   if geo.FindFirst() then
                       "GEO Constructor Manager Name" := geo."GEO Construction Manager Name"
                   else
                       "GEO Constructor Manager Name" := '';*/
            end;
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


        field(70225; "Trimble M3 -O"; boolean)
        {
            caption = 'Trimble M3';
        }
        field(70280; "GPS Tersus"; boolean)
        {
            caption = 'GPS Tersus';
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
        }

        field(70257; "Verif Done"; Boolean)
        {
            Caption = 'Verif Done';
        }
        field(70258; "Realisation Done"; Boolean)
        {
            Caption = 'Realisation Done';
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
        field(70262; "Filters by Gauge"; Text[250])
        {
            Caption = 'Filters by Gauge';
            //TableRelation = "Installation History"."Serial Number I" where(type = filter(Gauge), Active = filter(true));
        }

        field(70263; "Filters by Measuring point"; Code[20])
        {
            Caption = 'Filters by Measuring point';
            TableRelation = "Service Item"."No.";
        }
        field(70264; "Calculation Code"; code[20])
        {
            Caption = 'Calculation Code';
        }
        field(70267; "Filters by Fixed Asset"; code[20])
        {
            Caption = 'Filters by Fixed Asset';

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
            CalcFormula = lookup("Service Item Line".Address where("Document No." = field("No.")));

        }
        field(70274; "Service Item Line count"; Integer)
        {
            Caption = 'Service Item Line count';
            //brojac linija
            FieldClass = FlowField;
            CalcFormula = count("Service Item Line" where("Document No." = field("No.")));

        }
        field(70275; "Due Days Status"; Integer) //ED
        {
            Caption = 'Due Days Status ';
            FieldClass = FlowField;
            CalcFormula = lookup("Status History 2"."Due days" where("Request No." = field("Order No."), Active = filter(true), "Source Table" = filter(5900)));


        }

        field(70276; "Need to reopen work order"; Boolean) //ED
        {
            Caption = 'Need to reopen work order';


        }

        field(70277; "Due Days Reopen"; Integer) //ED
        {
            Caption = 'Due Days Reopen';

        }
        field(70928; "Work Order Registry No. letter"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order Registry No. letter', Comment = 'Broj u registratoru slovima';
        }
        field(70930; "Sent Mail"; Boolean)
        {
            Caption = 'Sent Mail';
        }
        field(70931; "Bill-to Registration No."; Text[20]) //EK
        {
            Caption = 'Bill-to Registration No.';

        }

        field(70932; "Bill-to VAT Registration No."; Text[20]) //EK
        {
            Caption = 'Bill-to VAT Registration No.';

        }










    }

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

    local procedure ProcessRequest(CreateRequestType: Enum "Request Type"; CreateNewRemark: Text[250]; CreateNewReason: Text[250])
    var
        ServiceHeader: Record "Service Invoice Header";
        ServiceItemLine: Record "Service Invoice Line";


    begin
        //  TestField("Document Type", Enum::"Service Document Type"::Order);


        //  ServiceItemLine.SetRange("Document Type", "Document Type");
        ServiceItemLine.SetRange("Document No.", "No.");
        ServiceItemLine.FindFirst();
        ServiceItemline.TestField("Service Item No.");

        // ServiceHeader.SetRange("Document Type", Enum::"Service Document Type"::Order);
        ServiceHeader.SetRange("Request Type", CreateRequestType);
        ServiceHeader.SetRange("CZK Request No.", "No.");
        if not ServiceHeader.FindFirst() then
            CreateServiceHeaderFromServiceHeader(ServiceHeader, CreateRequestType, CreateNewReason, CreateNewRemark);

        Commit();
        Page.RunModal(Page::"Request Card", ServiceHeader);
    end;


    local procedure GetNoSeries(RequestType: Enum "Request Type"): Code[20]
    var
        ServiceMgtSetup: Record "Service Mgt. Setup";
    begin
        ServiceMgtSetup.Get;
        exit(ServiceMgtSetup.GetRequestNoSeries(RequestType));
    end;

    procedure CreateServiceHeaderFromServiceHeader(var ServiceHeader: Record "Service Invoice Header"; RequestType: Enum "Request Type"; var Descri: Text[250]; var Remar: Text[250]) RN: code[20]
    var
        ServiceItemLine: record "Service Invoice Line";
        NewServiceItemLine: record "Service Line";
        GaugeSerial: Record Gauge;
        RequestID: Code[20];
        DocumentAttachment: Record "Document Attachment";
        Mandat: Record "Mandatory Attachment Setup";
        ServiceHeader2: Record "Service Header";
        ServiceLine2: Record "Service Line";
        ServiceItemLineNew: Record "Service Item Line";
        IH: Record "Installation History";
        NoSeriesMgt: Codeunit NoSeriesExtented;
    begin
        ServiceHeader2.Init();
        //  ServiceHeader."Document Type" := Enum::"Service Document Type"::Order;
        ServiceHeader2.TransferFields(ServiceHeader);
        ServiceHeader2."No." := '';
        ServiceHeader2."No. Series" := GetNoSeries(RequestType);
        NoSeriesMgt.InitSeries(ServiceHeader2."No. Series", xRec."No. Series", 0D, ServiceHeader2."No.", ServiceHeader2."No. Series");
        ServiceHeader2."Document Type" := ServiceHeader2."Document Type"::Order;





        // ServiceHeader."No. Series" := GetNoSeries(RequestType);
        ServiceHeader2.Insert(True);
        RequestID := ServiceHeader."Request ID";
        ServiceHeader2.TransferFields(Rec, false);
        ServiceHeader2."Reason For Service Order" := Remar;
        //  ServiceHeader2."Document Type" := ServiceHeader2."Document Type"::Order;
        ServiceHeader2."Remark For Service Order" := Descri;
        ServiceHeader2."Request ID" := RequestID;
        ServiceHeader2."Request Type" := RequestType;
        ServiceHeader2."CZK Request No." := "Order No.";
        ServiceHeader2."Document Date" := Today();
        //  ServiceHeader."No. Series" := GetNoSeries(RequestType);
        ServiceHeader2.Modify(true);
        RN := ServiceHeader2."No.";
        // ServiceItemLine.SetRange("Document Type", "Document Type");
        ServiceItemLine.SetRange("Document No.", "No.");
        if ServiceItemLine.FindSet() then
            repeat
                ServiceItemLineNew.Reset();
                ServiceItemLineNew.SetFilter("Service Item No.", '%1', ServiceItemLine."Service Item No.");
                ServiceItemLineNew.SetFilter("Line No.", '%1', ServiceItemLine."Service Item Line No.");
                ServiceItemLineNew.SetFilter("Document No.", '%1', ServiceHeader2."No.");
                if not ServiceItemLineNew.FindFirst() then begin
                    ServiceItemLineNew.Init();
                    ServiceItemLineNew."Line No." := ServiceItemLine."Service Item Line No.";
                    ServiceItemLineNew."Document No." := ServiceHeader2."No.";
                    ServiceItemLineNew.Applied := false;
                    ServiceItemLineNew."Document Type" := ServiceHeader2."Document Type"::Order;
                    // ServiceItemLineNew.Validate("Service Item No. - Relation", ServiceItemLine."Service Item No.");
                    ServiceItemLineNew."Service Item No. - Relation" := ServiceItemLine."Service Item No.";
                    ServiceItemLineNew."Service Item No." := ServiceItemLine."Service Item No.";

                    IH.Reset();
                    IH.SetFilter("Measuring Point Code", '%1', ServiceItemLineNew."Service Item No. - Relation");
                    iH.SetFilter(Active, '%1', true);
                    Ih.SetFilter(Type, '%1', IH.Type::Gauge);
                    IH.SetFilter("Installation Date", '<=%1', ServiceHeader2."Document Date");
                    //    IH.SetFilter("Dismantling date", '%1|>=%2', 0D, ServiceHeader2."Document Date");
                    ih.SetCurrentKey("Installation Date");
                    ih.Ascending;
                    if ih.FindLast() then begin

                        ServiceItemLineNew.Gauge := ih.Code;
                        GaugeSerial.Reset();
                        GaugeSerial.SetFilter("Code", '%1', ServiceItemLineNew.Gauge);
                        if GaugeSerial.FindFirst() then begin
                            ServiceItemLineNew.RMS := GaugeSerial."Inventar number";
                            ServiceItemLineNew."Meter Manufacturer" := GaugeSerial."Meter Manufacturer";
                            ServiceItemLineNew."Meter Manufacturer Desc" := GaugeSerial."Meter Manufacturer Desc";
                            ServiceItemLineNew."Gauge Size" := GaugeSerial."Gauge Size";
                            ServiceItemLineNew."Year of Production" := GaugeSerial."Year of Production";
                            ServiceItemLineNew."DD calibration" := GaugeSerial."DD calibration";
                        end
                        else begin
                            ServiceItemLineNew.RMS := '';
                            ServiceItemLineNew."Meter Manufacturer" := '';
                            ServiceItemLineNew."Meter Manufacturer Desc" := '';
                            ServiceItemLineNew."Gauge Size" := '';
                            ServiceItemLineNew."Year of Production" := 0;
                            ServiceItemLineNew."DD calibration" := 0;
                        end;
                    end;
                    ServiceItemLineNew.Insert();
                end;
                NewServiceItemLine.Init();
                NewServiceItemLine.TransferFields(ServiceItemLine, false);
                //   NewServiceItemLine."Document Type" := "Document Type";
                NewServiceItemLine."Document No." := ServiceHeader2."No.";
                NewServiceItemLine."Line No." := ServiceItemLine."Line No.";
                NewServiceItemLine."Service Item Line No." := ServiceItemLine."Service Item Line No.";
                NewServiceItemLine."Document Type" := ServiceHeader2."Document Type";

                NewServiceItemLine.Insert();

            until ServiceItemLine.Next() = 0;

        if ServiceHeader."Request Type" = ServiceHeader."Request Type"::"Project and Energy Accordance" then begin

            Mandat.Reset();
            Mandat.SetFilter(Information, '%1', true);
            Mandat.SetFilter("Request Type", '%1', ServiceHeader."Request Type");
            if mandat.FindSet() then
                repeat
                    DocumentAttachment.Init();
                    DocumentAttachment."Table ID" := Database::"Service Item Line";
                    DocumentAttachment."No." := ServiceHeader2."No.";
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

    procedure CreateAndOpenWorkOrder()
    var
        ServiceHeader: Record "Service Invoice Header";
        ServiceItemLine: Record "Service Invoice Line";
        NewWorkOrderDialog: Page NewWorkOrderDialog;
        NewWorkOrderType: enum "Request Type";
        UseriD_REc: Record "User Setup";
        NewReason: Text[250];
        NewRemark: Text[250];
        RN_2: code[20];
        ServiceHeader2: Record "Service Header";
        IsCopyWorkOrder: Boolean;
    begin

        //    TestField("Document Type", Enum::"Service Document Type"::Order);
        //    ServiceItemLine.SetRange("Document Type", "Document Type");
        ServiceItemLine.SetRange("Document No.", "No.");
        ServiceItemLine.FindFirst();
        ServiceItemline.TestField("Service Item No.");

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
        ;

        RN_2 := CreateServiceHeaderFromServiceHeader(ServiceHeader, NewWorkOrderType, NewRemark, NewReason);

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
        if ServiceHeader2.Get(ServiceHeader2."Document Type", RN_2) then
            Page.RunModal(Page::"Request Card", ServiceHeader2);
        Commit();
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

    procedure GetProcessingDocument(): Code[20]
    var
        ServiceHeader: Record "Service Invoice Header";
        ProcessingDocumentType: Enum "Request Type";
    begin
        ProcessingDocumentType := GetProcessingDocumentType("Request Type");
        if ProcessingDocumentType = Enum::"Request Type"::"Others" then
            exit;

        ServiceHeader.SetLoadFields("No.");
        ServiceHeader.SetRange("Request Type", ProcessingDocumentType);
        ServiceHeader.SetRange("CZK Request No.", "Order No.");
        if ServiceHeader.FindFirst then
            exit(ServiceHeader."No.");

        exit('');
    end;

}