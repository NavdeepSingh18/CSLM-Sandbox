table 50069 "Course Formula Details-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00092    10-01-2019    OnInsert                      User Id Assign in User Id Field.
    // 2         CSPL-00092    10-01-2019    ShowEligibleDetail Function   Show Elegible Corse Detail
    // 3         CSPL-00092    10-01-2019    ShowRankingDetail Function    Show Course rank detail

    Caption = 'Course Formula History -COL';

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;
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
        field(4; "Not Eligible Formula"; Code[250])
        {
            Caption = 'Not Eligible Formula';
            DataClassification = CustomerContent;
        }
        field(5; "Stage1 Formula"; Code[250])
        {
            Caption = 'Stage1 Formula';
            DataClassification = CustomerContent;
        }
        field(6; "Stage2 Formula"; Code[250])
        {
            Caption = 'Stage2 Formula';
            DataClassification = CustomerContent;
        }
        field(7; "Interview Scheduled Date"; Date)
        {
            Caption = 'Interview Scheduled Date';
            DataClassification = CustomerContent;
        }
        field(8; "No of Elgible Formula"; Integer)
        {
            Caption = 'No of Elgible Formula';
            DataClassification = CustomerContent;
        }
        field(14; "No of Ranking Formula"; Integer)
        {
            Caption = 'No of Ranking Formula';
            DataClassification = CustomerContent;
        }
        field(15; "Stage1 Completed"; Boolean)
        {
            Caption = 'Stage1 Completed';
            DataClassification = CustomerContent;
        }
        field(16; "Stage2 Completed"; Boolean)
        {
            Caption = 'Stage2 Completed';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 28-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 28-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 28-01-2019';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 28-01-2019';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Course Code", "Line No.")
        {
        }
        key(Key2; "Course Code", "List No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::10-01-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for User Id Assign in User Id Field::CSPL-00092::10-01-2019: End
    end;

    procedure ShowEligibleDetail()
    var
        CourseEligibleSummaryCS: Record "Course Eligible Summary-CS";
        UserGroupDetailCS: Page "User Group Detail-CS";
    begin
        //Code added for show Elegible Corse Detail::CSPL-00092::10-01-2019: Start
        TESTFIELD("Course Code");
        TESTFIELD("Line No.");
        TESTFIELD("List No.");
        CourseEligibleSummaryCS.SETRANGE("Course Code", "Course Code");
        CourseEligibleSummaryCS.SETRANGE("Course Line No.", "Line No.");
        CourseEligibleSummaryCS.SETRANGE("List No.", "List No.");
        UserGroupDetailCS.SETTABLEVIEW(CourseEligibleSummaryCS);
        UserGroupDetailCS.RUNMODAL();
        //Code added for show Elegible Corse Detail::CSPL-00092::10-01-2019: End
    end;

    procedure ShowRankingDetail()
    var
        CourseRankingSummaryCS: Record "Course Ranking Summary-CS";
        AdmissionActvsCS: Page "Admission Actvs-CS";
    begin
        //Code added for Show Course rank detail::CSPL-00092::10-01-2019: Start
        TESTFIELD("Course Code");
        TESTFIELD("Line No.");
        TESTFIELD("List No.");
        CourseRankingSummaryCS.SETRANGE("Course Code", "Course Code");
        CourseRankingSummaryCS.SETRANGE("Course Line No.", "Line No.");
        CourseRankingSummaryCS.SETRANGE("List No.", "List No.");
        AdmissionActvsCS.SETTABLEVIEW(CourseRankingSummaryCS);
        AdmissionActvsCS.RUNMODAL();
        //Code added for Show Course rank detail::CSPL-00092::10-01-2019: End
    end;
}