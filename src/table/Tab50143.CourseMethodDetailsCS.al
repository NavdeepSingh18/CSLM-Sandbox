table 50143 "Course Method Details-CS"
{
    // version V.001-CS

    // 
    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   16/06/2019       OnInsert()                                  Auto assign User ID
    // 02    CSPL-00114   16/06/2019       ShowEligibleFormula()                       Create Function for Page Run
    // 03    CSPL-00114   16/06/2019       ShowRankingFormula()                        Create Function for Page Run

    Caption = 'Course Method Details-CS';
    //DrillDownPageID = 33049382;
    //LookupPageID = 33049382;

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
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16062019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16062019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16062019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16062019';
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
        //Code added for Auto assign User ID::CSPL-00114::16062019: Start
        "User ID" := FORMAT(UserId());
        //Code added for Auto assign User ID::CSPL-00114::16062019: End
    end;

    procedure ShowEligibleFormula()
    var
        CourseEligibleDet: Record "Course Eligible Summary-CS";
        CourseEligibleDetails: Page "User Group Detail-CS";
    begin
        //Create Function for Page Run::CSPL-00114::16062019: Start
        TESTFIELD("Course Code");
        TESTFIELD("Line No.");
        TESTFIELD("List No.");
        CourseEligibleDet.SETRANGE("Course Code", "Course Code");
        CourseEligibleDet.SETRANGE("Course Line No.", "Line No.");
        CourseEligibleDet.SETRANGE("List No.", "List No.");
        CourseEligibleDetails.SETTABLEVIEW(CourseEligibleDet);
        CourseEligibleDetails.RUNMODAL();
        //Create Function for Page Run::CSPL-00114::16062019: End
    end;

    procedure ShowRankingFormula()
    var
        CourseRankingDet: Record "Course Ranking Summary-CS";
        CourseRankingDetails: Page "Admission Actvs-CS";
    begin
        //Create Function for Page Run::CSPL-00114::16062019: Start
        TESTFIELD("Course Code");
        TESTFIELD("Line No.");
        TESTFIELD("List No.");
        CourseRankingDet.SETRANGE("Course Code", "Course Code");
        CourseRankingDet.SETRANGE("Course Line No.", "Line No.");
        CourseRankingDet.SETRANGE("List No.", "List No.");
        CourseRankingDetails.SETTABLEVIEW(CourseRankingDet);
        CourseRankingDetails.RUNMODAL();
        //Create Function for Page Run::CSPL-00114::16062019: End
    end;
}

