table 50352 "Student Room Wise Inventory"
{
    DataClassification = CustomerContent;
    Caption = 'Student Apartment Wise Inventory';
    DataCaptionFields = "Application No.", "Student Name";

    fields
    {
        field(1; "Housing ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing ID';
            Editable = False;

        }
        field(2; "Room No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment No.';
            Editable = False;

        }
        field(3; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            Editable = False;

        }
        field(4; "Enrolment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrolment No.';
            Editable = False;

        }
        field(5; "Ledger Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Ledger Entry No.';
            Editable = False;
        }
        field(6; "Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Application No.';
            Editable = False;

        }
        field(7; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
            Editable = False;

        }
        field(8; "Item Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Name';
            Editable = False;

        }
        field(9; "Quantity Allotted"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity Allotted';
            Editable = False;

        }
        field(10; "Quantity Verified Alloment"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity Verified Allotment';
            trigger OnValidate()
            begin
                if "Quantity Verified Vacate" then
                    Error('Quantity Verified Vacate is already checked.');

                modify();

                if "Quantity Verified Alloment" then begin
                    StudentRoomWiseInventoryRec.Reset();
                    StudentRoomWiseInventoryRec.SetRange("Application No.", "Application No.");
                    StudentRoomWiseInventoryRec.SetFilter(StudentRoomWiseInventoryRec."Quantity Verified Alloment", '%1', false);
                    if not StudentRoomWiseInventoryRec.FindFirst() then begin
                        HousingApplicationRec.Reset();
                        HousingApplicationRec.SetRange("Application No.", "Application No.");
                        if HousingApplicationRec.FindFirst() then begin
                            HousingApplicationRec."Inventory Verified" := true;
                            HousingApplicationRec.Modify();
                        end;
                    end;
                end else begin
                    HousingApplicationRec.Reset();
                    HousingApplicationRec.SetRange("Application No.", "Application No.");
                    HousingApplicationRec.SetRange("Student No.", "Student No.");
                    HousingApplicationRec.SetRange("Inventory Verified", true);
                    IF HousingApplicationRec.FindFirst() then
                        Error('Inventory is already verified');
                end;



                If "Quantity Verified Alloment" Then
                    "Verified Alloment Date" := WorkDate()
                Else
                    "Verified Alloment Date" := 0D;

            end;

        }
        field(11; "Quantity Verified Vacate"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity Verified Vacate';

            trigger OnValidate()
            begin
                TestField("Quantity Verified Alloment");
                If "Quantity Verified Vacate" Then
                    "Verified Vacate Date" := WorkDate()
                Else
                    "Verified Vacate Date" := 0D;
            End;
        }
        field(12; "Verified Alloment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Verified Allotment Date';
            Editable = false;

        }
        field(13; "Verified Vacate Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Verified Vacate Date';
            Editable = false;

        }
        field(14; Remarks; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';

        }
        field(15; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(16; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(17; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(18; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Created On';
            Editable = false;

        }
        Field(19; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            Editable = false;

        }
        Field(20; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
            Editable = False;

        }
        Field(21; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
            Editable = False;

        }
        Field(22; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
            Editable = False;

        }
        Field(23; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = False;

        }
        Field(24; "Inventory Category"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Apartment Wise","Room Wise";
            OptionCaption = ' ,Apartment Wise,Room Wise';


        }
    }

    keys
    {
        key(Key1; "Application No.", "Item No.")
        {
            Clustered = true;
        }
    }

    var
        HousingApplicationRec: Record "Housing Application";
        StudentRoomWiseInventoryRec: Record "Student Room Wise Inventory";
        FinancialAccountabilityRec: Record "Financial Accountability";
        UserSetupRec: Record "User Setup";
        EducationSetupRec: Record "Education Setup-CS";
        NoSeriesMgtCod: Codeunit NoSeriesManagement;

    procedure CreateFinancialAccountabilty(StudentNo: Code[20])
    var

    begin
        UserSetupRec.get(UserId());
        EducationSetupRec.Reset();
        EducationSetupRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        if EducationSetupRec.FindFirst() then begin
            FinancialAccountabilityRec.Reset();
            FinancialAccountabilityRec.Init();
            FinancialAccountabilityRec."Fine Application No." := NoSeriesMgtCod.GetNextNo(EducationSetupRec."Financial Accountability No.", 0D, TRUE);
            FinancialAccountabilityRec."Fine Date" := WORKDATE();
            FinancialAccountabilityRec.Validate("Student No.", StudentNo);
            FinancialAccountabilityRec.Status := FinancialAccountabilityRec.Status::Open;
            FinancialAccountabilityRec."Created By" := UserId();
            FinancialAccountabilityRec."Created On" := WorkDate();
            FinancialAccountabilityRec.Insert(true);
            PAGE.RUN(Page::"Financial Accountability List", FinancialAccountabilityRec);
        end;
    end;

    trigger OnInsert()
    begin
        "Created By" := FORMAT(UserId());
        "Created On" := WORKDATE();
        Inserted := true;
    end;

    trigger OnModify()
    begin
        "Modified By" := FORMAT(UserId());
        "Modified On" := WORKDATE();
        Updated := true;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}