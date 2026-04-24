table 50141 Profession
{
    Caption = 'Profession';
    DrillDownPageID = Profession;
    LookupPageID = Profession;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';

            trigger OnValidate()
            begin
                EVALUATE(Order, Code);
            end;
        }
        field(3; Description; Text[120])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                //"Search Name" := Name;
            end;
        }
        field(4; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(5; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(6; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(7; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(8; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(9; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(12; "Alternate Work Center"; Code[20])
        {
            Caption = 'Alternate Work Center';
            TableRelation = Profession;
        }
        /*   field(14; "Work Center Group Code"; Code[10])
           {
               Caption = 'Work Center Group Code';
               TableRelation = "Employee Blood Donation";

               trigger OnValidate()
               var
                   ProdOrderRtngLine: Record "Prod. Order Routing Line";
                   ProdOrderCapNeedEntry: Record "Prod. Order Capacity Need";
               //       PlanningRtngLine: Record "Employee Skills";
               begin


               end;
           }*/
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(18; "Subcontractor No."; Code[20])
        {
            Caption = 'Subcontractor No.';
            TableRelation = Vendor;
        }
        field(19; "Direct Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost';
            MinValue = 0;

            trigger OnValidate()
            begin
                //VALIDATE("Indirect Cost %");
            end;
        }
        field(20; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                /*GetGLSetup;
                "Unit Cost" :=
                  ROUND(
                    "Direct Unit Cost" * (1 + "Indirect Cost %" / 100) + "Overhead Rate",
                    GLSetup."Unit-Amount Rounding Precision");
                */

            end;
        }
        field(21; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            DecimalPlaces = 2 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                /*GetGLSetup;
                "Direct Unit Cost" :=
                  ROUND(("Unit Cost" - "Overhead Rate") / (1 + "Indirect Cost %" / 100),
                    GLSetup."Unit-Amount Rounding Precision");
                */

            end;
        }
        field(22; "Queue Time"; Decimal)
        {
            Caption = 'Queue Time';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(23; "Queue Time Unit of Meas. Code"; Code[10])
        {
            Caption = 'Queue Time Unit of Meas. Code';
            //  TableRelation = "Cube codes";
        }
        field(26; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(27; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
        }
        field(30; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            //  TableRelation = "Cube codes";

            trigger OnValidate()
            begin
                /*IF "Unit of Measure Code" = xRec."Unit of Measure Code" THEN
                  EXIT;
                
                CALCFIELDS("Prod. Order Need (Qty.)");
                IF "Prod. Order Need (Qty.)" <> 0 THEN
                  ERROR(Text007,FIELDCAPTION("Unit of Measure Code"));
                
                IF xRec."Unit of Measure Code" <> '' THEN
                  IF CurrFieldNo <> 0 THEN
                    IF NOT CONFIRM(Text001,FALSE,FIELDCAPTION("Unit of Measure Code"))
                    THEN BEGIN
                      "Unit of Measure Code" := xRec."Unit of Measure Code";
                      EXIT;
                    END;
                
                Window.OPEN(
                  Text008 +
                  Text009);
                
                MODIFY;
                
                // Capacity Calendar
                EntryCounter := 0;
                CalendarEntry.SETCURRENTKEY("Work Center No.");
                CalendarEntry.SETRANGE("Work Center No.","No.");
                NoOfRecords := CalendarEntry.COUNT;
                IF CalendarEntry.FIND('-') THEN
                  REPEAT
                    EntryCounter := EntryCounter + 1;
                    Window.UPDATE(1,EntryCounter);
                    Window.UPDATE(2,ROUND(EntryCounter / NoOfRecords * 10000,1));
                    CalendarEntry.VALIDATE("Ending Time");
                    CalendarEntry.MODIFY;
                  UNTIL CalendarEntry.NEXT = 0;
                
                Window.CLOSE;
                */

            end;
        }
        field(31; Capacity; Decimal)
        {
            Caption = 'Capacity';
            DecimalPlaces = 0 : 5;
            InitValue = 1;
            MinValue = 0;
        }
        field(32; Efficiency; Decimal)
        {
            Caption = 'Efficiency';
            DecimalPlaces = 0 : 5;
            InitValue = 100;
            MinValue = 0;
        }
        field(33; "Maximum Efficiency"; Decimal)
        {
            Caption = 'Maximum Efficiency';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(34; "Minimum Efficiency"; Decimal)
        {
            Caption = 'Minimum Efficiency';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(35; "Calendar Rounding Precision"; Decimal)
        {
            Caption = 'Calendar Rounding Precision';
            DecimalPlaces = 0 : 5;
            InitValue = 0.0001;
            MinValue = 0.0001;
            NotBlank = true;
        }
        field(36; "Simulation Type"; Option)
        {
            Caption = 'Simulation Type';
            OptionCaption = 'Moves,Moves When Necessary,Critical';
            OptionMembers = Moves,"Moves When Necessary",Critical;
        }
        field(37; "Shop Calendar Code"; Code[10])
        {
            Caption = 'Shop Calendar Code';
            TableRelation = Sector;
        }
        field(38; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(39; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        /*   field(40; "Work Shift Filter"; Code[10])
           {
               Caption = 'Work Shift Filter';
               FieldClass = FlowFilter;
               TableRelation = "Employee Picture";
           }*/
        field(41; "Capacity (Total)"; Decimal)
        {
            CalcFormula = Sum(Title."Capacity (Total)");
            Caption = 'Capacity (Total)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(42; "Capacity (Effective)"; Decimal)
        {
            CalcFormula = Sum(Title."Capacity (Effective)");
            Caption = 'Capacity (Effective)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(44; "Prod. Order Need (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Prod. Order Capacity Need"."Allocated Time");
            Caption = 'Prod. Order Need (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(45; "Prod. Order Need Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Prod. Order Routing Line"."Expected Operation Cost Amt.");
            Caption = 'Prod. Order Need Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "Prod. Order Status Filter"; Option)
        {
            Caption = 'Prod. Order Status Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Simulated,Planned,Firm Planned,Released,Finished';
            OptionMembers = Simulated,Planned,"Firm Planned",Released,Finished;
        }
        field(50; "Unit Cost Calculation"; Option)
        {
            Caption = 'Unit Cost Calculation';
            OptionCaption = 'Time,Units';
            OptionMembers = Time,Units;
        }
        field(51; "Specific Unit Cost"; Boolean)
        {
            Caption = 'Specific Unit Cost';
        }
        field(52; "Consolidated Calendar"; Boolean)
        {
            Caption = 'Consolidated Calendar';
        }
        field(53; "Flushing Method"; Option)
        {
            Caption = 'Flushing Method';
            InitValue = Manual;
            OptionCaption = 'Manual,Forward,Backward';
            OptionMembers = Manual,Forward,Backward;
        }
        field(80; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(81; "Overhead Rate"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Overhead Rate';

            trigger OnValidate()
            begin
                //VALIDATE("Indirect Cost %");
            end;
        }
        field(82; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(83; County; Text[30])
        {
            Caption = 'County';
        }
        field(84; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(7300; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            //  TableRelation = Location.Code WHERE("Use As In-Transit" = CONST(false),
            //                                     "Bin Mandatory" = CONST(TRUE));

            trigger OnValidate()
            var
                Location: Record "Location";
                //  MachineCenter: Record "Travel Header";
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
                AutoUpdate: Boolean;
            begin
                /*IF "Location Code" <> xRec."Location Code" THEN BEGIN
                  IF "Location Code" <> '' THEN BEGIN
                    Location.GET("Location Code");
                    WhseIntegrationMgt.CheckLocationCode(Location,DATABASE::"Work Center","No.");
                  END;
                
                  IF "Open Shop Floor Bin Code" <> '' THEN BEGIN
                    IF ConfirmAutoRemovalOfBinCode(AutoUpdate) THEN
                      VALIDATE("Open Shop Floor Bin Code",'')
                    ELSE
                      TESTFIELD("Open Shop Floor Bin Code",'');
                  END;
                  IF "To-Production Bin Code" <> '' THEN BEGIN
                    IF ConfirmAutoRemovalOfBinCode(AutoUpdate) THEN
                      VALIDATE("To-Production Bin Code",'')
                    ELSE
                      TESTFIELD("To-Production Bin Code",'');
                  END;
                  IF "From-Production Bin Code" <> '' THEN BEGIN
                    IF ConfirmAutoRemovalOfBinCode(AutoUpdate) THEN
                      VALIDATE("From-Production Bin Code",'')
                    ELSE
                      TESTFIELD("From-Production Bin Code",'');
                  END;
                  MachineCenter.SETCURRENTKEY("Work Center No.");
                  MachineCenter.SETRANGE("Work Center No.","No.");
                  IF MachineCenter.FINDSET(TRUE) THEN
                    REPEAT
                      MachineCenter."Location Code" := "Location Code";
                      IF MachineCenter."Open Shop Floor Bin Code" <> '' THEN BEGIN
                        IF ConfirmAutoRemovalOfBinCode(AutoUpdate) THEN
                          MachineCenter.VALIDATE("Open Shop Floor Bin Code",'')
                        ELSE
                          MachineCenter.TESTFIELD("Open Shop Floor Bin Code",'');
                      END;
                      IF MachineCenter."To-Production Bin Code" <> '' THEN BEGIN
                        IF ConfirmAutoRemovalOfBinCode(AutoUpdate) THEN
                          MachineCenter.VALIDATE("To-Production Bin Code",'')
                        ELSE
                          MachineCenter.TESTFIELD("To-Production Bin Code",'');
                      END;
                      IF MachineCenter."From-Production Bin Code" <> '' THEN BEGIN
                        IF ConfirmAutoRemovalOfBinCode(AutoUpdate) THEN
                          MachineCenter.VALIDATE("From-Production Bin Code",'')
                        ELSE
                          MachineCenter.TESTFIELD("From-Production Bin Code",'');
                      END;
                      MachineCenter.MODIFY(TRUE);
                    UNTIL MachineCenter.NEXT = 0;
                END;
                */

            end;
        }
        field(7301; "Open Shop Floor Bin Code"; Code[20])
        {
            Caption = 'Open Shop Floor Bin Code';
            //  TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));

            trigger OnValidate()
            var
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
            begin
                /*WhseIntegrationMgt.CheckBinCode("Location Code",
                  "Open Shop Floor Bin Code",
                  FIELDCAPTION("Open Shop Floor Bin Code"),
                  DATABASE::"Work Center","No.");
                  */

            end;
        }
        field(7302; "To-Production Bin Code"; Code[20])
        {
            Caption = 'To-Production Bin Code';
            //  TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));

            trigger OnValidate()
            var
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
            begin
                /*WhseIntegrationMgt.CheckBinCode("Location Code",
                  "To-Production Bin Code",
                  FIELDCAPTION("To-Production Bin Code"),
                  DATABASE::"Work Center","No.");
                */

            end;
        }
        field(7303; "From-Production Bin Code"; Code[20])
        {
            Caption = 'From-Production Bin Code';
            //   TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));

            trigger OnValidate()
            var
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
            begin
                /*WhseIntegrationMgt.CheckBinCode("Location Code",
                  "From-Production Bin Code",
                  FIELDCAPTION("From-Production Bin Code"),
                  DATABASE::"Work Center","No.");
                */

            end;
        }
        field(50000; "Order"; Integer)
        {
            Caption = 'Order';
        }
    }

    keys
    {
        key(Key1; "Code", Description)
        {
        }
        key(Key2; "Order")
        {
        }
        key(Key3; Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Description, "Order")
        {
        }
    }

    trigger OnDelete()
    var
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        StdCostWksh: Record "Standard Cost Worksheet";
    begin
        /*CapLedgEntry.SETCURRENTKEY("Work Center No.");
        CapLedgEntry.SETRANGE("Work Center No.","No.");
        IF CapLedgEntry.FINDFIRST THEN
          ERROR(Text010,TABLECAPTION,"No.",CapLedgEntry.TABLECAPTION);
        
        StdCostWksh.RESET;
        StdCostWksh.SETRANGE(Type,StdCostWksh.Type::"Work Center");
        StdCostWksh.SETRANGE("No.","No.");
        IF NOT StdCostWksh.ISEMPTY THEN
          ERROR(Text010,TABLECAPTION,"No.",StdCostWksh.TABLECAPTION);
        
        CalendarEntry.SETCURRENTKEY("Capacity Type","No.");
        CalendarEntry.SETRANGE("Capacity Type",CalendarEntry."Capacity Type"::"Work Center");
        CalendarEntry.SETRANGE("No.","No.");
        CalendarEntry.DELETEALL;
        
        CalAbsentEntry.SETCURRENTKEY("Capacity Type","No.");
        CalAbsentEntry.SETRANGE("Capacity Type",CalendarEntry."Capacity Type"::"Work Center");
        CalAbsentEntry.SETRANGE("No.","No.");
        CalAbsentEntry.DELETEALL;
        
        MfgCommentLine.SETRANGE("Table Name",MfgCommentLine."Table Name"::"Work Center");
        MfgCommentLine.SETRANGE("No.","No.");
        MfgCommentLine.DELETEALL;
        
        ProdOrderRtngLine.SETCURRENTKEY("Work Center No.");
        ProdOrderRtngLine.SETRANGE("Work Center No.","No.");
        IF ProdOrderRtngLine.FINDFIRST THEN
          ERROR(Text000);
        
        DimMgt.DeleteDefaultDim(DATABASE::"Work Center","No.");
        
        VALIDATE("Location Code",''); // to clean up the default bins
        */

    end;

    trigger OnInsert()
    begin
        /*MfgSetup.GET;
        IF "No." = '' THEN BEGIN
          MfgSetup.TESTFIELD("Work Center Nos.");
          NoSeriesMgt.InitSeries(MfgSetup."Work Center Nos.",xRec."No. Series",0D,"No.","No. Series");
        END;
        DimMgt.UpdateDefaultDim(
          DATABASE::"Work Center","No.",
          "Global Dimension 1 Code","Global Dimension 2 Code");
        */

        IF Code = '' THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("Profession Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Profession Nos", xRec."No. Series", 0D, Code, "No. Series");
        END;
        EVALUATE(Order, Code);

    end;

    trigger OnModify()
    begin
        //"Last Date Modified" := TODAY;
    end;

    trigger OnRename()
    begin
        //"Last Date Modified" := TODAY;
    end;

    var
        Text000: Label 'The Work Center is being used on production orders.';
        Text001: Label 'Do you want to change %1?';
        Text002: Label 'Work Center Group Code is changed...\\';
        Text003: Label 'Calendar Entry    #1###### @2@@@@@@@@@@@@@\';
        Text004: Label 'Calendar Absent.  #3###### @4@@@@@@@@@@@@@\';
        Text006: Label 'Prod. Order Need  #7###### @8@@@@@@@@@@@@@';
        Text007: Label '%1 cannot be changed for scheduled work centers.';
        Text008: Label 'Capacity Unit of Time is corrected on\\';
        Text009: Label 'Calendar Entry    #1###### @2@@@@@@@@@@@@@';
        PostCode: Record "Post Code";
        MfgSetup: Record "Manufacturing Setup";
        WorkCenter: Record "Profession";
        CapLedgEntry: Record "Capacity Ledger Entry";
        CalendarEntry: Record "Title";
        //  CalAbsentEntry: Record "Travel Line";
        MfgCommentLine: Record "Vocation";
        RtngLine: Record "Routing Line";
        GLSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        DimMgt: Codeunit "DimensionManagement";
        Window: Dialog;
        EntryCounter: Integer;
        NoOfRecords: Integer;
        GLSetupRead: Boolean;
        Text010: Label 'You cannot delete %1 %2 because there is at least one %3 associated with it.', Comment = '%1 = Table caption; %2 = Field Value; %3 = Table Caption';
        Text011: Label 'If you change the %1, then all bin codes on the %2 and related %3 will be removed. Are you sure that you want to continue?';
        HumanResSetup: Record "Human Resources Setup";

    procedure AssistEdit(OldWorkCenter: Record "Profession"): Boolean
    begin
        /*WITH WorkCenter DO BEGIN
          WorkCenter := Rec;
          MfgSetup.GET;
          MfgSetup.TESTFIELD("Work Center Nos.");
          IF NoSeriesMgt.SelectSeries(MfgSetup."Work Center Nos.",OldWorkCenter."No. Series","No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries("No.");
            Rec := WorkCenter;
            EXIT(TRUE);
          END;
        END;
        */

    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        /*DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Work Center","No.",FieldNumber,ShortcutDimCode);
        MODIFY;
        */

    end;

    local procedure GetGLSetup()
    begin
        /*IF NOT GLSetupRead THEN
          GLSetup.GET;
        GLSetupRead := TRUE;
        */

    end;

    local procedure ConfirmAutoRemovalOfBinCode(var AutoUpdate: Boolean): Boolean
    var
    //     MachineCenter: Record "Travel Header";
    begin
        /*IF AutoUpdate THEN
          EXIT(TRUE);
        
        IF CONFIRM(Text011,FALSE,FIELDCAPTION("Location Code"),TABLECAPTION,MachineCenter.TABLECAPTION) THEN
          AutoUpdate := TRUE;
        
        EXIT(AutoUpdate);
        */

    end;

    procedure GetBinCode(UseFlushingMethod: Boolean; FlushingMethod: Option Manual,Forward,Backward,"Pick + Forward","Pick + Backward"): Code[20]
    begin
        /*IF NOT UseFlushingMethod THEN
          EXIT("From-Production Bin Code");
        
        CASE FlushingMethod OF
          FlushingMethod::Manual,
          FlushingMethod::"Pick + Forward",
          FlushingMethod::"Pick + Backward":
            EXIT("To-Production Bin Code");
          FlushingMethod::Forward,
          FlushingMethod::Backward:
            EXIT("Open Shop Floor Bin Code");
        END;
        */

    end;
}

