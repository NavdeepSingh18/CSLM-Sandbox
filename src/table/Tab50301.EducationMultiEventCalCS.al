table 50301 "Education Multi Event Cal-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   18/05/2019       OnInsert()                                 Auto update Mobile Insert Value
    // 02    CSPL-00114   18/05/2019       OnModify()                                 Code added for Any updated record
    // 04    CSPL-00114   18/05/2019       Event Day Calculation - OnValidate()       Code added for end date & Revised date Value
    // 05    CSPL-00114   18/05/2019       Event Code - OnValidate()                  Code added for Event Description
    // 06    CSPL-00114   18/05/2019       Semester - OnValidate()                    Code added for Course Related Semester Validation
    // 07    CSPL-00114   18/05/2019       Year - OnValidate()                        Code added for Course Related year Validation
    // 08    CSPL-00114   18/05/2019       Start Date - OnValidate()                  Code added for End & Revised date Calculate
    // 09    CSPL-00114   18/05/2019       RestrictChanges() - Function               Create function Any modification Validation Check

    LookupPageID = "Multi Evt Entry Edu Cale-CS";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            TableRelation = "Education Calendar-CS".Code;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin

                "Start Date" := Date;
            end;
        }
        field(3; "Event Day Calculation"; Code[10])
        {
            Caption = 'Event Day Calculation';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for end date & Revised date Value::CSPL-00114::18052019: Start
                IF ("Start Date" = 0D) OR ("Event Day Calculation" = '') THEN
                    "End Date" := 0D
                ELSE
                    CalcEndD := CALCDATE(FORMAT("Event Day Calculation"), "Start Date");
                CalcEndD2 := CALCDATE('<-1D>', CalcEndD);
                "End Date" := CalcEndD2;
                "Revised End Date" := CalcEndD2;
                //Code added for end date & Revised date Value::CSPL-00114::18052019: End
            end;
        }
        field(4; "Event Code"; Code[20])
        {
            Caption = 'Event Code';
            DataClassification = CustomerContent;
            TableRelation = "Education Event-CS"."Event Code";

            trigger OnValidate()
            begin
                //Code added for Event Description::CSPL-00114::18052019: Start
                IF EducationEventCS.GET("Event Code") THEN BEGIN
                    "Event Description" := EducationEventCS.Description;
                    VALIDATE("Event Day Calculation", EducationEventCS."Event Day Calculation");
                END ELSE BEGIN
                    "Event Description" := '';
                    "Event Day Calculation" := '';
                END;
                RestrictChanges();
                //Code added for Event Description::CSPL-00114::18052019: End
            end;
        }
        field(5; "Event Description"; Text[80])
        {
            Caption = 'Event Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(90; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";

            trigger OnValidate()
            var

            begin

                //Code added for Course Related Semester Validation::CSPL-00114::18052019: Start
                CourseWiseSubjectLineCS.Reset();
                CourseWiseSubjectLineCS.SETRANGE("Course Code", Code);
                IF CourseWiseSubjectLineCS.FindFirst() THEN
                    IF NOT (CourseWiseSubjectLineCS."Type Of Course" = CourseWiseSubjectLineCS."Type Of Course"::Semester) THEN
                        ERROR(Text_10001Lbl);
                //Code added for Course Related Semester Validation::CSPL-00114::18052019: End
            end;
        }
        field(92; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Wise Subject Line-CS"."Subject Code" WHERE(Semester = FIELD(Semester));
        }
        field(93; Year; Code[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";

            trigger OnValidate()
            begin
                //Code added for Course Related year Validation::CSPL-00114::18052019: Start
                CourseWiseSubjectLineCS.Reset();
                CourseWiseSubjectLineCS.SETRANGE("Course Code", Code);
                IF CourseWiseSubjectLineCS.FindFirst() THEN
                    IF NOT (CourseWiseSubjectLineCS."Type Of Course" = CourseWiseSubjectLineCS."Type Of Course"::Year) THEN
                        ERROR(Text_10002Lbl);
                //Code added for Course Related year Validation::CSPL-00114::18052019: End
            end;
        }
        field(50000; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18052019';
            Editable = false;

            trigger OnValidate()
            begin
                //Code added for End & Revised date Calculate::CSPL-00114::18052019: Start
                IF ("Start Date" = 0D) OR ("Event Day Calculation" = '') THEN
                    "End Date" := 0D
                ELSE
                    IF "Start Date" <> xRec."Start Date" THEN BEGIN
                        CalcEndD := CALCDATE(FORMAT("Event Day Calculation"), "Start Date");
                        CalcEndD2 := CALCDATE('<-1D>', CalcEndD);
                        "End Date" := CalcEndD2;
                        "Revised End Date" := CalcEndD2;
                    END;
                //Code added for End & Revised date Calculate::CSPL-00114::18052019: End
            end;
        }
        field(50001; "Revised End Date"; Date)
        {
            Caption = 'Revised End Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18052019';

            trigger OnValidate()
            begin
                Revised := TRUE;
            end;
        }
        field(50002; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18052019';
            Editable = false;
        }
        field(50003; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18052019';
        }
        field(50004; Revised; Boolean)
        {
            Caption = 'Revised';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18052019';
            Editable = false;
        }
        field(50005; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18052019';
        }
        field(50006; "Revised Date"; Date)
        {
            Caption = 'Revised Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18052019';
        }
        field(50007; "Mobile Insert"; Boolean)
        {
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18052019';
        }
        field(50008; "Mobile Update"; Boolean)
        {
            Caption = 'Mobile Update';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18052019';
        }
        field(50009; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50010; "Even/Odd Semester"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING';
            OptionMembers = FALL,SPRING;
        }
        field(50011; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
    }

    keys
    {
        key(Key1; "Code", Date, "Event Code", "Academic Year", "Even/Odd Semester")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Auto update Mobile Insert Value::CSPL-00114::18052019: Start
        "Mobile Insert" := TRUE;
        Inserted := true;
        //Code added for Auto update Mobile Insert Value::CSPL-00114::18052019: End
    end;

    trigger OnModify()
    begin
        //Code added for Any updated record::CSPL-00114::18052019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        IF "Mobile Insert" = FALSE THEN
            IF xRec."Mobile Update" = "Mobile Update" THEN
                "Mobile Update" := TRUE;

        //Code added for Any updated record::CSPL-00114::18052019: End
    end;

    var
        EducationEventCS: Record "Education Event-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        CalcEndD: Date;
        CalcEndD2: Date;
        Text_10001Lbl: Label 'This Course is not related to semester.';
        Text_10002Lbl: Label 'This Course is not related to Year.';


    local procedure RestrictChanges()
    var
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        Text001Lbl: Label 'You Can''t Modify %1 , Delete And Regenrate Event !!';
    begin
        //Create function Any modification Validation Check::CSPL-00114::18052019: Start
        IF ("Event Code" <> '') AND (Rec."Event Code" <> xRec."Event Code") THEN
            IF EducationMultiEventCalCS.GET(Code, Date, xRec."Event Code", "Academic Year") THEN
                IF EducationMultiEventCalCS."Event Code" <> Rec."Event Code" THEN
                    ERROR(Text001Lbl, FIELDCAPTION("Event Code"));


        //Create function Any modification Validation Check::CSPL-00114::18052019: End
    end;
}

