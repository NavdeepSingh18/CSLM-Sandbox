table 50137 "Mark Application-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   19/06/2019       OnInsert()                             Auto assign User ID

    Caption = 'Mark Application-CS';

    fields
    {
        field(1; "Application No"; Code[20])
        {
            Caption = 'Application No';
            DataClassification = CustomerContent;
            TableRelation = "Application-CS";
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Mark Obtained"; Decimal)
        {
            BlankZero = true;
            Caption = 'Mark Obtained';
            DataClassification = CustomerContent;
        }
        field(4; Maximum; Decimal)
        {
            BlankZero = true;
            Caption = 'Maximum';
            DataClassification = CustomerContent;
        }
        field(5; Month; Option)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
            OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(6; "Year of passing"; Integer)
        {
            BlankZero = true;
            Caption = 'Year of passing';
            DataClassification = CustomerContent;
        }
        field(7; "Register Number"; Code[20])
        {
            Caption = 'Register Number';
            DataClassification = CustomerContent;
        }
        field(8; "Medium of Study"; Code[20])
        {
            Caption = 'Medium of Study';
            DataClassification = CustomerContent;
        }
        field(9; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            TableRelation = IF (Type = FILTER("Prequalification Subjects")) "Eligible Detail Course Wise-CS".Code WHERE("Course Code" = FIELD("Course Code"),
                                                                                                                     Prequalification = FIELD("Qualification Code"));
        }
        field(10; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(11; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(12; Category; Code[20])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
            TableRelation = "Category Master-CS";
        }
        field(13; Grade; Code[20])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
            SQLDataType = Integer;
            TableRelation = "Grade Master-CS";
        }
        field(14; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Evaluation,Prequalification Subjects';
            OptionMembers = "Evaluation","Prequalification Subjects";
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 19062019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 19062019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "School/ College Name"; Text[200])
        {
            Caption = 'School/ College Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 19062019';
        }
        field(50004; "Name of Board/Univ."; Text[200])
        {
            Caption = 'Name of Board/Univ.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 19062019';
        }
        field(50006; "Percentage of Mark"; Decimal)
        {
            Caption = 'Percentage of Mark';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 19062019';
        }
        field(50007; "Qualification Code"; Option)
        {
            Caption = 'Qualification Code ';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 19062019';
            OptionCaption = ' ,10th,12th,Diploma,Graduation,Post Graduation,Others';
            OptionMembers = " ","10th","12th",Diploma,Graduation,"Post Graduation",Others;
        }
        field(50008; "Order Number"; Integer)
        {
            Caption = 'Order Number';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 19062019';
        }
        field(50009; "Check Eligibility"; Boolean)
        {
            Caption = 'Check Eligibility';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 19062019';
        }
        field(50010; "Optional Subject"; Text[5])
        {
            Caption = 'Optional Subject';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 19062019';
        }
        field(50011; Stream; Code[20])
        {
            Caption = 'Stream';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 19062019';
            TableRelation = "Category Master-CS";
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;

            Description = 'CS Field Added 19062019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 19062019';
        }
    }

    keys
    {
        key(Key1; "Application No", Type, "Course Code", "Code", "Qualification Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Auto assign User ID::CSPL-00114::19062019: Start
        "User ID" := FORMAT(UserId());
        //Code added for Auto assign User ID::CSPL-00114::19062019: End
    end;

    var

}

