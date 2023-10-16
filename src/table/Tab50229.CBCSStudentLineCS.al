table 50229 "CBCS Student Line-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                  Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   05/01/2019       OnInsert()               Getting values from header to line Table
    // 02    CSPL-00114   06/01/2019   Subject Code OnLookup()      Retrieving the cbcs subjects from subject

    Caption = 'CBCS Student Line-CS';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";

            trigger OnLookup()
            begin

                //Code added Retrieving the cbcs subjects from subject::CSPL-00114::06/01/2019: Start
                IF CBCSStudentHeadCS.GET("Document No.") THEN BEGIN
                    AcademicsSetupCS.FINDFIRST();
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETRANGE("Subject Type", AcademicsSetupCS."CBCS Subject Type");
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", CBCSStudentHeadCS."Course Code");
                    CourseWiseSubjectLineCS.SETRANGE(Semester, CBCSStudentHeadCS."Semester Code");
                    IF PAGE.RUNMODAL(0, CourseWiseSubjectLineCS) = ACTION::LookupOK THEN BEGIN
                        CBCSStudentLineCS.Reset();
                        CBCSStudentLineCS.SETRANGE("Student No.", CBCSStudentHeadCS."Student No.");
                        CBCSStudentLineCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                        IF CBCSStudentLineCS.FINDFIRST() THEN
                            ERROR(Text000Lbl);
                        "Subject Code" := CourseWiseSubjectLineCS."Subject Code";
                        "Subject Description" := CourseWiseSubjectLineCS.Description;
                        Credit := CourseWiseSubjectLineCS.Credit;
                        "CBCS Status" := "CBCS Status"::Applied;
                        Specilization := CourseWiseSubjectLineCS.Specilization;
                    END;
                END;
                //Code added Retrieving the cbcs subjects from subject::CSPL-00114::06/01/2019: End
            end;
        }
        field(4; "Subject Description"; Text[100])
        {
            Caption = 'Subject Description';
            DataClassification = CustomerContent;
        }
        field(5; Credit; Decimal)
        {
            Caption = 'Credit';
            DataClassification = CustomerContent;
        }
        field(6; "CBCS Status"; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Applied,Approved,Rejected';
            OptionMembers = " ",Applied,Approved,Rejected;
        }
        field(7; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
        }
        field(8; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(9; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            TableRelation = "Course Master-CS";
        }
        field(10; "Semester Code"; Code[10])
        {
            Caption = 'Semester Code';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(11; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(12; "CBCS Batch"; Code[20])
        {
            Caption = 'CBCS Batch';
        }
        field(13; "Section Code"; Code[10])
        {
            Caption = 'Section Code';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(14; Specilization; Code[20])
        {
            Caption = 'Specilization';
            DataClassification = CustomerContent;
            TableRelation = "Specialization-CS";
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            Description = 'CS Field Added';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Years Course';
            Description = 'CS Field Added';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; "Student No.", "Course Code", "Semester Code")
        {
            SumIndexFields = Credit;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added Getting values from header to line Table::CSPL-00114::05/01/2019: Start
        IF CBCSStudentHeadCS.GET("Document No.") THEN BEGIN
            "Student No." := CBCSStudentHeadCS."Student No.";
            "Student Name" := CBCSStudentHeadCS."Student Name";
            "Course Code" := CBCSStudentHeadCS."Course Code";
            "Semester Code" := CBCSStudentHeadCS."Semester Code";
            "Section Code" := CBCSStudentHeadCS."Section Code";
            "Academic Year" := VerticalEducationCS.CreateSessionYear();
            "CBCS Batch" := AcademicsStageCS.GetDataCBCSBatch();
        END;
        //Code added Getting values from header to line Table::CSPL-00114::05/01/2019: End
    end;

    var
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        CBCSStudentHeadCS: Record "CBCS Student Head-CS";
        CBCSStudentLineCS: Record "CBCS Student Line-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        AcademicsStageCS: Codeunit "Academics Stage-CS";

        Text000Lbl: Label 'subject already exists.';
}

