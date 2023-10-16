table 50278 "Mark Appl Prequal-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   08/07/2019       OnInsert()                                 Get "Academic Year",Course Code & "User Id" Values From Related Table
    // 02    CSPL-00114   08/07/2019       Mark Obtained - OnValidate()               Code add form Validation & Grade Calculate
    // 03    CSPL-00114   08/07/2019       Maximum - OnValidate()                     Code add form Validation & Grade Calculate

    Caption = 'Mark Appl Prequal-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
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

            trigger OnValidate()
            begin
                //Code add form Validation & Grade Calculate::CSPL-00114::08072019: Start
                IF ("Mark Obtained" <> 0) AND (Maximum <> 0) THEN BEGIN
                    IF "Mark Obtained" > Maximum THEN
                        ERROR(Text000Lbl);
                    PercentageDecCS := ROUND(("Mark Obtained" / Maximum) * 100, 1, '=');
                    GradeMasterCS.Reset();
                    GradeMasterCS.SETFILTER("Min Percentage", '<=%1', PercentageDecCS);
                    GradeMasterCS.SETFILTER("Max Percentage", '>=%1', PercentageDecCS);
                    IF GradeMasterCS.FINDFIRST() THEN
                        Grade := GradeMasterCS.Code;
                END;
                //Code add form Validation & Grade Calculate::CSPL-00114::08072019: End
            end;
        }
        field(4; Maximum; Decimal)
        {
            BlankZero = true;
            Caption = 'Maximum';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code add form Validation & Grade Calculate::CSPL-00114::08072019: Start
                IF ("Mark Obtained" <> 0) AND (Maximum <> 0) THEN BEGIN
                    IF "Mark Obtained" > Maximum THEN
                        ERROR(Text000Lbl);
                    PercentageDecCS := ROUND(("Mark Obtained" / Maximum) * 100, 1, '=');
                    GradeMasterCS.Reset();
                    GradeMasterCS.SETFILTER("Min Percentage", '<=%1', PercentageDecCS);
                    GradeMasterCS.SETFILTER("Max Percentage", '>=%1', PercentageDecCS);
                    IF GradeMasterCS.FINDFIRST() THEN
                        Grade := GradeMasterCS.Code;
                END;
                //Code add form Validation & Grade Calculate::CSPL-00114::08072019: End
            end;
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
        field(9; "Prequalification Code"; Code[20])
        {
            Caption = 'Prequalification Code';
            DataClassification = CustomerContent;
            TableRelation = "Not Sync Document-CS";
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
            TableRelation = "Grade Master-CS";
        }
        field(14; "Prequalification Subject Code"; Code[10])
        {
            Caption = 'Prequalification Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Due Clearance-CS";
        }
        field(15; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08072019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08072019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "School/ College Name"; Text[50])
        {
            Caption = 'School/ College Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08072019';
        }
        field(50004; "Name of Board/Univ."; Text[50])
        {
            Caption = 'Name of Board/Univ.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08072019';
        }
        field(50005; "Prequalification Subjects"; Text[200])
        {
            Caption = 'Prequalification Subjects';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08072019';
        }
        field(50006; "Percentage of Mark"; Decimal)
        {
            Caption = 'Percentage of Mark';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08072019';
        }
        field(50007; Qualification; Option)
        {
            Caption = 'Qualification';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08072019';
            OptionCaption = ' ,10th,12th,Diploma,Graduation,Post Graduation,Others';
            OptionMembers = " ","10th","12th",Diploma,Graduation,"Post Graduation",Others;
        }
        field(50008; "Overall Percentage"; Decimal)
        {
            Caption = 'Overall Percentage';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08072019';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08072019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08072019';
        }
    }

    keys
    {
        key(Key1; "No.", Qualification, "Course Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Get "Academic Year",Course Code & "User Id" Values From Related Table::CSPL-00114::08072019: Start
        IF ApplicationCS.GET("No.") THEN
            "Course Code" := ApplicationCS."Course Code";
        "User ID" := FORMAT(UserId());
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        //Get "Academic Year",Course Code & "User Id" Values From Related Table::CSPL-00114::08072019: End
    end;

    var
        GradeMasterCS: Record "Grade Master-CS";
        ApplicationCS: Record "Application-CS";

        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        PercentageDecCS: Decimal;
        Text000Lbl: Label 'Please enter valid mark.';
}