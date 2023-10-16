table 50114 "Group Fee Details-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                            Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   18/08/2019       OnInsert()                         Code added for Fee Component Related Information.

    Caption = 'Group Fee Details-CS';
    DrillDownPageID = "Approval List Stu. (CBCS )-CS";
    LookupPageID = "Approval List Stu. (CBCS )-CS";

    fields
    {
        field(1; "S. No."; Integer)
        {
            Caption = 'S.No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Fee Group Code"; Code[10])
        {

            Caption = 'Fee Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Scho Continuation criteria-CS";

            trigger OnValidate()
            begin

                //Code added for Fee Component Related information::CSPL-00114::18082019: Start
                IF FeeComponentMasterCS.GET("Fee Group Code") THEN BEGIN
                    Description := FeeComponentMasterCS.Description;
                    "G/L Account No" := FeeComponentMasterCS."Global Dimension 1 Code";
                    "Global Dimension 1 Code" := FeeComponentMasterCS."Global Dimension 2 Code";
                    "G/L Account No" := FeeComponentMasterCS."G/L Account";
                END;
                //Code added for Fee Component Related information::CSPL-00114::18082019: End
            end;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            TableRelation = "Graduation Master-CS";
        }
        field(5; "Admitted Year"; Code[10])
        {
            Caption = 'Admitted Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(7; "No. Of  Sub/Lab"; Integer)
        {
            Caption = 'No. Of Sub/Lab';
            DataClassification = CustomerContent;
        }
        field(8; "G/L Account No"; Code[20])
        {
            Caption = 'G/L Account No.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }

    keys
    {
        key(Key1; "S. No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        FeeComponentMasterCS: Record "Fee Component Master-CS";
}

