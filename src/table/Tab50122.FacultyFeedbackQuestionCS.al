table 50122 "Faculty Feedback Question-CS"
{
    // version V.001-CS

    Caption = 'Faculty Feedback Question-CS';
    DrillDownPageID = "Question (Faculty) Detail-CS";
    LookupPageID = "Question (Faculty) Detail-CS";

    fields
    {
        field(1; "Sr. No."; Integer)
        {
            Caption = 'Sr. No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; Question; Text[250])
        {
            Caption = 'Question';
            DataClassification = CustomerContent;
        }
        field(3; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(4; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(5; "Maximum Marks"; Decimal)
        {
            Caption = 'Maximum Marks';
            DataClassification = CustomerContent;
        }
        field(6; "Active/DeActive"; Boolean)
        {
            Caption = 'Active/Deactivate';
            DataClassification = CustomerContent;
        }
        field(7; "Type of Evaluation"; Option)
        {

            DataClassification = CustomerContent;
            OptionCaption = 'Constructive Evaluation, Faculty Evaluation, Course/Subject Evaluation';
            OptionMembers = "Constructive Evaluation","Faculty Evaluation","Course/Subject Evaluation";
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Sr. No.")
        {
        }
    }

    fieldgroups
    {
    }
}

