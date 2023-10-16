table 50002 "Sessional Exam Group Line-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                     Remarks
    // 1         CSPL-00092    10-01-2019    OnModify                  Assign Value in Fields
    // 2         CSPL-00092    10-01-2019    Exam Method - OnLookup      Assign Value in Fields
    // 3         CSPL-00092    10-01-2019    Maximum Marks - OnValidate  Check Validation
    // 4         CSPL-00092    10-01-2019    Weightage - OnValidate    Check Validation

    Caption = 'Sessional Exam Group Line-CS';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(4; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(7; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(8; "Academic year"; Code[20])
        {
            Caption = 'Academic year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(9; "Exam Group"; Code[20])
        {
            Caption = 'Exam Group';
            DataClassification = CustomerContent;
            TableRelation = "Sessional Exam Group-CS".Group;
        }
        field(10; "Exam Method"; Code[20])
        {
            Caption = 'Exam Method';
            DataClassification = CustomerContent;
            trigger OnLookup()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::22-04-2019: Start
                SessionalExamGroupHeadCS.Reset();
                IF SessionalExamGroupHeadCS.GET("Document No.") THEN;
                SessionalExamGroupCS.Reset();
                SessionalExamGroupCS.SETRANGE(Group, SessionalExamGroupHeadCS."Exam Group");
                IF SessionalExamGroupCS.FINDSET() THEN
                    IF PAGE.RUNMODAL(50173, SessionalExamGroupCS) = ACTION::LookupOK THEN BEGIN
                        "Exam Method" := SessionalExamGroupCS."Exam Method Code";
                        "Exam Group" := SessionalExamGroupCS.Group;
                        "Method Description" := SessionalExamGroupCS.Description;
                    END;

                //Code added for Assign Value in Fields::CSPL-00092::22-04-2019: End
            end;
        }
        field(11; "Maximum Marks"; Decimal)
        {
            Caption = 'Maximum Marks';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Check Validation::CSPL-00092::22-04-2019: Start
                AcademicsSetupCS.GET();
                IF (AcademicsSetupCS."Attendance Code" <> '') AND ("Exam Method" = AcademicsSetupCS."Attendance Code") THEN BEGIN
                    AttendPercentageSetupCS.Reset();
                    AttendPercentageSetupCS.SETCURRENTKEY(Mark);
                    AttendPercentageSetupCS.ASCENDING(FALSE);
                    IF AttendPercentageSetupCS.FINDFIRST() THEN
                        IF AttendPercentageSetupCS.Mark < "Maximum Marks" THEN
                            ERROR(Text000Lbl);
                END;
                //Code added for Check Validation::CSPL-00092::22-04-2019: End
            end;
        }
        field(12; "Order"; Integer)
        {
            Caption = 'Order';
            DataClassification = CustomerContent;
        }
        field(13; Weightage; Decimal)
        {
            Caption = 'Weightage';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Check Validation::CSPL-00092::22-04-2019: Start
                IF "Maximum Marks" = 0 THEN
                    ERROR(Text007Lbl);
                //Code added for Check Validation::CSPL-00092::22-04-2019: End
            end;
        }
        field(15; "Method Description"; Text[50])
        {
            Caption = 'Method Description';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));


        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-04-2019';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-04-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Years course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-04-2019';
        }
        field(50015; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-04-2019';
            TableRelation = "Year Master-CS";
        }
        field(50016; "Created By"; Code[30])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-04-2019';
        }
        field(50017; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-04-2019';
        }
        field(50018; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-04-2019';
        }
        field(50019; "Modified On"; Date)
        {
            Caption = 'Modified On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-04-2019';
        }
        field(50020; "Marks Published"; Boolean)
        {
            Caption = 'Marks Published';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-04-2019';
        }
        field(50021; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-04-2019';
        }
        field(50022; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-04-2019';
            TableRelation = "Graduation Master-CS".Code;
        }
        field(50023; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-04-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-04-2019';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; Course, Semester, Section, "Academic year", "Subject Code", "Exam Method")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin

        //Code added for Assign Value in Fields::CSPL-00092::22-04-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        "Modified By" := FORMAT(UserId());
        "Modified On" := TODAY();
        //Code added for Assign Value in Fields::CSPL-00092::22-04-2019: End
    end;

    Trigger OnInsert()
    begin
        Inserted := true;
    end;

    var

        AcademicsSetupCS: Record "Academics Setup-CS";
        AttendPercentageSetupCS: Record "Attend Percentage Setup-CS";

        SessionalExamGroupCS: Record "Sessional Exam Group-CS";
        SessionalExamGroupHeadCS: Record "Sessional Exam Group Head-CS";
        Text000Lbl: Label 'Maximum mark is higher than mark in attendence percentage setup.';
        Text007Lbl: Label 'Enter Maximum Marks Value First !!';
}

