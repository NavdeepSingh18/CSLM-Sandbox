table 50288 "Exam Time Table Head-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   12/04/2019       OnInsert()                                 Get the value of "No Series","Academic Year",Exam Type Field
    // 02    CSPL-00114   12/04/2019       OnModify()                                 Code added for Any Record Change then Updated Field update
    // 03    CSPL-00114   12/04/2019       No. - OnValidate()                         Get the value of "No Series"
    // 04    CSPL-00114   12/04/2019       Exam Slot - OnValidate()                   Code added for Start & End Time Field
    // 05    CSPL-00114   12/04/2019       Assistedit -Function                       Code added for Assist edit Field for No Series

    Caption = 'Exam Time Table Head-CS';
    // DrillDownPageID = "Schedule(Exam) List-CS";
    // LookupPageID = "Schedule(Exam) List-CS";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Get the value of "No Series"::CSPL-00114::12042019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesManagement.TestManual(AcademicsSetupCS."Exam Schedule No.");
                    "No. Series" := '';
                END;
                //Code added for Get the value of "No Series"::CSPL-00114::12042019: End
            end;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(3; "Exam Type"; Option)
        {
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
        }
        field(4; "Exam Method"; Code[20])
        {
            Caption = 'Exam Method';
            DataClassification = CustomerContent;
            TableRelation = "Exam Group Code-CS" WHERE("Exam Type" = FIELD("Exam Type"));
        }
        field(5; "Exam Slot"; Code[20])
        {
            Caption = 'Exam Slot';
            DataClassification = CustomerContent;
            TableRelation = "Examination Time Slot-CS";

            trigger OnValidate()
            var
                ExaminationTimeSlotCS: Record "Examination Time Slot-CS";
            begin
                //Code added for Start & End Time Field::CSPL-00114::12042019: Start
                IF ExaminationTimeSlotCS.GET("Exam Slot") THEN BEGIN
                    "Start Time" := ExaminationTimeSlotCS."From Time";
                    "End Time" := ExaminationTimeSlotCS."To Time";
                END;
                //Code added for Start & End Time Field::CSPL-00114::12042019: End
            end;
        }
        field(6; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
            trigger OnValidate()
            begin
                ErrorIfLineExists(Rec);
            end;
        }
        field(8; "Start Time"; Time)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
        }
        field(9; "End Time"; Time)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
        }
        field(10; "Exam Classification"; Code[20])
        {
            Caption = 'Exam Classification';
            DataClassification = CustomerContent;
            TableRelation = "Examination Type Master-CS".Code WHERE("Exam Type" = FIELD("Exam Type"));
            trigger OnValidate()
            begin
                ErrorIfLineExists(Rec);

                ExistingScheduleLineModification();
                ScheduleCheck(Rec);
            end;
        }
        field(21; "Subject Classification"; Code[20])
        {
            Caption = 'Subject Classification';
            DataClassification = CustomerContent;
            TableRelation = "Subject Classification-CS";
            trigger OnValidate()
            begin
                ErrorIfLineExists(Rec);
            end;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12042019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            begin
                ErrorIfLineExists(Rec);
            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12042019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Ext Exam Attendance No."; Code[20])
        {
            Caption = 'Ext Exam Attendance No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12042019';
        }
        field(50004; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12042019';
        }
        field(50005; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12042019';
        }
        field(50006; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12042019';
        }
        field(50007; "Updated By"; Code[50])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12042019';
        }
        field(50008; "Updated On"; Date)
        {
            Caption = 'Updated On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12042019';
        }
        field(50009; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            trigger OnValidate()
            begin
                ErrorIfLineExists(Rec);

                ExistingScheduleLineModification();
                ScheduleCheck(Rec);
            end;
        }
        field(50010; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50011; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            var
                CourseMasterCS: Record "Course master-CS";
            begin
                ErrorIfLineExists(Rec);

                "Semester Code" := '';
                if "Course Code" <> '' then begin
                    CourseMasterCS.get("Course Code");
                    "Course Name" := CourseMasterCS.Description;
                end
                else
                    "Course Name" := '';

            end;
        }
        field(50012; "Semester Code"; Code[10])
        {
            Caption = 'Semester Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Sem. Master-CS"."Semester Code" where("Course Code" = field("Course Code"), "Academic Year" = Field("Academic Year"));
            trigger OnValidate()
            begin
                ErrorIfLineExists(Rec);
            end;
        }
        field(50013; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            Editable = false;
        }
        Field(50014; "Exam Code"; Code[20])
        {
            Caption = 'Exam Selection';
            TableRelation = if ("Exam Type" = Filter(External)) "Reason Code" where(Type = filter("External Exam"))
            Else
            If ("Exam Type" = Filter(Internal)) "Reason Code" where(Type = filter("Internal Exam"));
        }


        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12042019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12042019';
        }
        field(33048922; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12042019';
            OptionMembers = Open,Released;
        }
        field(33048924; "Last Modify Date"; DateTime)
        {
            Caption = 'Last Modify Date"';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12042019';
        }

    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DrillDown; "No.")
        {
        }
    }

    trigger OnInsert()
    begin
        //Code added for Get the value of "No Series","Academic Year",Exam Type Field::CSPL-00114::12042019: Start
        AcademicsSetupCS.GET();
        IF "No." = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD("Exam Schedule No.");
            NoSeriesManagement.InitSeries(AcademicsSetupCS."Exam Schedule No.", xRec."No. Series", 0D, "No.", "No. Series");

            UserSetup.Get(UserId());
            EducationSetupCS.Reset();
            EducationSetupCS.SetFilter("Global Dimension 1 Code", '%1', '9000');
            if EducationSetupCS.FindFirst() then begin
                "Academic Year" := EducationSetupCS."Academic Year";
                "Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                Term := EducationSetupCS."Even/Odd Semester";
            end;
        END;
        "Created By" := FORMAT(UserId());
        "Created On" := Today();
        Inserted := true;
        //Code added for Get the value of "No Series","Academic Year",Exam Type Field::CSPL-00114::12042019: End
    end;

    trigger OnModify()
    begin
        //Code added for Any Record Change then Updated Field update::CSPL-00114::12042019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        "Updated By" := FORMAT(UserId());
        "Updated On" := TODAY();
        //Code added for Any Record Change then Updated Field update::CSPL-00114::12042019: End
    end;

    trigger OnDelete()
    begin
        ErrorIfLineExists(Rec);

        ExamTimeTableLine.Reset();
        ExamTimeTableLine.SetRange("Document No.", "No.");
        If ExamTimeTableLine.FindSet() then
            ExamTimeTableLine.DeleteAll();
    end;

    var
        AcademicsSetupCS: Record "Academics Setup-CS";
        ExamTimeTableHeadCS: Record "Exam Time Table Head-CS";
        EducationSetupCS: Record "Education Setup-CS";
        UserSetup: Record "User Setup";
        ExamTimeTableLine: Record "Exam Time Table Line-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";

    procedure AssistEdit(OldExamTimeTableHeadCS: Record "Exam Time Table Head-CS"): Boolean
    begin
        //Code added for Assist edit Field for No Series::CSPL-00114::12042019: Start
        WITH ExamTimeTableHeadCS DO BEGIN
            ExamTimeTableHeadCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("Exam Schedule No.");
            IF NoSeriesManagement.SelectSeries(AcademicsSetupCS."Exam Schedule No.",
           OldExamTimeTableHeadCS."No. Series", "No. Series")
            THEN BEGIN
                NoSeriesManagement.SetSeries("No.");
                Rec := ExamTimeTableHeadCS;
                EXIT(TRUE);
            END;
        END;
        //Code added for Assist edit Field for No Series::CSPL-00114::12042019: Start
    end;

    procedure ScheduleCheck(RecExamTimeTableHeadCS: Record "Exam Time Table Head-CS"): Boolean
    var
        OldExamTimeTableHeadCS: Record "Exam Time Table Head-CS";
    begin
        OldExamTimeTableHeadCS.Reset();
        OldExamTimeTableHeadCS.SetRange("Global Dimension 1 Code", RecExamTimeTableHeadCS."Global Dimension 1 Code");
        OldExamTimeTableHeadCS.SetRange("Academic Year", RecExamTimeTableHeadCS."Academic Year");
        OldExamTimeTableHeadCS.SetRange("Exam Classification", RecExamTimeTableHeadCS."Exam Classification");
        OldExamTimeTableHeadCS.SetRange("Term", RecExamTimeTableHeadCS."Term");
        OldExamTimeTableHeadCS.SetRange("Exam Type", RecExamTimeTableHeadCS."Exam Type");
        OldExamTimeTableHeadCS.SetRange("Course Code", RecExamTimeTableHeadCS."Course Code");
        OldExamTimeTableHeadCS.SetRange("Semester Code", RecExamTimeTableHeadCS."Semester Code");
        OldExamTimeTableHeadCS.SetRange("Exam Code", RecExamTimeTableHeadCS."Exam Method");
        IF OldExamTimeTableHeadCS.FindFirst() THEN BEGIN
            Error('Same Schedule Already Exist');
        END;
    end;

    procedure ExistingScheduleLineModification()
    var
        ExamTimeTableLineCS: Record "Exam Time Table Line-CS";
    begin
        ExamTimeTableLineCS.Reset();
        ExamTimeTableLineCS.SETRANGE("Document No.", "No.");
        If ExamTimeTableLineCS.FindSet() then begin
            ExamTimeTableLineCS.ModifyAll(ExamTimeTableLineCS."Exam Classification", "Exam Classification");
            ExamTimeTableLineCS.ModifyAll(ExamTimeTableLineCS.Term, Term);
        end;
    end;

    procedure ErrorIfLineExists(ExamSchdHdr: Record "Exam Time Table Head-CS")
    var
        ExamTimeTableLineCS: Record "Exam Time Table Line-CS";
    begin
        ExamTimeTableLineCS.Reset();
        ExamTimeTableLineCS.SETRANGE("Document No.", ExamSchdHdr."No.");
        ExamTimeTableLineCS.SetFilter("Exam No.", '<>%1', '');
        If ExamTimeTableLineCS.FindFirst() then
            Error('Modifications not allowed as Examination Schedule Line exists with Exam No. in Line No. %1', ExamTimeTableLineCS."Line No.");
    end;
}

