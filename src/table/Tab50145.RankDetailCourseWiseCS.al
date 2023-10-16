table 50145 "Rank Detail Course Wise-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                             Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   26/09/2019       OnInsert()                          Auto assign User ID

    Caption = 'Rank Detail Course Wise-CS';
    //DrillDownPageID = 33049383;
    //LookupPageID = 33049383;

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;

            TableRelation = "Course Master-CS";
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "List No."; Integer)
        {
            Caption = 'List No.';
            DataClassification = CustomerContent;
        }
        field(4; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            TableRelation = IF (Type = FILTER(Evaluation)) "Discipline Level-CS"
            ELSE
            IF (Type = FILTER(Category)) "Room Alloted Line-CS"
            ELSE
            IF (Type = FILTER('Prequalification Subjects')) "Class Assignment Header-CS";
        }
        field(5; Percentage; Decimal)
        {
            Caption = 'Percentage';
            DataClassification = CustomerContent;
        }
        field(6; "Order Number"; Integer)
        {
            Caption = 'Order Number';
            DataClassification = CustomerContent;
        }
        field(9; "Course Line No."; Integer)
        {
            Caption = 'Course Line No.';
            DataClassification = CustomerContent;
        }
        field(10; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Evaluation,Category,Prequalification Subjects';
            OptionMembers = " ",Evaluation,Category,"Prequalification Subjects";
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26092019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26092019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26092019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26092019';
        }
    }

    keys
    {
        key(Key1; "Course Code", "Course Line No.", "List No.", "Line No.")
        {
        }
        key(Key2; "Course Code", "Course Line No.", "List No.", "Order Number")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Auto assign User ID::CSPL-00114::26092019: Start
        "User ID" := FORMAT(UserId());
        //Code added for Auto assign User ID::CSPL-00114::26092019: End
    end;
}

