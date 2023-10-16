table 50120 "College Orientation-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   27/09/2019       Course - OnValidate()                      Code added for Course name & program


    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(2; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Course name & program::CSPL-00114::27092019: Start
                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(Code, Course);
                IF CourseMasterCS.FINDFIRST() THEN BEGIN
                    "Course Name" := CourseMasterCS.Description;
                    "Program" := CourseMasterCS.Graduation;
                END ELSE BEGIN
                    "Course Name" := '';
                    "Program" := '';
                END;
                //Code added for Course name & program::CSPL-00114::27092019: End
            end;
        }
        field(3; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            TableRelation = "Graduation Master-CS".Code;
        }
        field(4; "Orientation Date"; Date)
        {
            Caption = 'Orientation Date';
            DataClassification = CustomerContent;
        }
        field(5; "Orientation Time"; Time)
        {
            Caption = 'Orientation Time';
            DataClassification = CustomerContent;
        }
        field(6; "Fee Classification code"; Code[20])
        {
            Caption = 'Fee Classification Code';
            DataClassification = CustomerContent;
            TableRelation = "Fee Classification Master-CS".Code;
        }
        field(7; Lateral; Boolean)
        {
            Caption = 'Lateral';
            DataClassification = CustomerContent;
        }
        field(8; Venue; Text[100])
        {
            Caption = 'Venue';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27092019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27092019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27092019';
        }
    }

    keys
    {
        key(Key1; "Academic Year", Course, "Program")
        {
        }
    }

    fieldgroups
    {
    }

    var
        CourseMasterCS: Record "Course Master-CS";
}

