table 50045 "Education Calendar-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID         Date          Trigger                 Remarks
    // 1         CSPL-00092      03-05-2019    OnInsert                Assign value in Academic Year and Mobile Insert Field.
    // 2         CSPL-00092      03-05-2019    OnMOdify                Assign value in Updated and Mobile Update Field

    Caption = 'Education Calendar-CS';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(3; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
            trigger OnValidate()
            begin
                IF ("Academic Year" <> xRec."Academic Year") THEN BEGIN
                    EducationCalendarEntryRec.RESET();
                    EducationCalendarEntryRec.SETRANGE(Code, Code);
                    IF EducationCalendarEntryRec.FINDSET() THEN
                        REPEAT
                            // if EducationCalendarEntryRec."Multi Event Exist" then
                            //     Error('Multi Event is already exist %1', EducationCalendarEntryRec.Date);

                            EducationCalendarEntryRec.VALIDATE("Academic Year", "Academic Year");
                            EducationCalendarEntryRec.MODIFY(TRUE);

                            EducationMultiEventCal.reset();
                            EducationMultiEventCal.SetRange(code, Code);
                            EducationMultiEventCal.SetRange(Date, EducationCalendarEntryRec.date);
                            EducationMultiEventCal.SetRange("Academic Year", EducationCalendarEntryRec."Academic Year");
                            if EducationMultiEventCal.FindSet() then
                                repeat
                                    EducationMultiEventCal.Rename(EducationMultiEventCal.Code, EducationMultiEventCal.Date, EducationMultiEventCal."Event Code", EducationCalendarEntryRec."Academic Year", EducationMultiEventCal."Even/Odd Semester");
                                until EducationMultiEventCal.Next() = 0;
                        UNTIL EducationCalendarEntryRec.NEXT() = 0;
                END;
            end;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Course Master-CS";
        }
        field(50004; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50005; "Mobile Insert"; Boolean)
        {
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50006; "Mobile Update"; Boolean)
        {
            Caption = 'Mobile Update';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50007; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
    }

    keys
    {
        key(Key1; "Code", "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign value in Academic Year and Mobile Insert Field::CSPL-00092::03-05-2019: Start
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        "Mobile Insert" := TRUE;

        Inserted := true;
        //Code added for Assign value in Academic Year and Mobile Insert Field::CSPL-00092::03-05-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign value in Updated and Mobile Update Field::CSPL-00092::03-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        IF "Mobile Insert" = FALSE THEN
            IF xRec."Mobile Update" = "Mobile Update" THEN
                "Mobile Update" := TRUE;

        //Code added for Assign value in Updated and Mobile Update Field::CSPL-00092::03-05-2019: End
    end;

    var
        EducationCalendarEntryRec: Record "Education Calendar Entry-CS";
        EducationMultiEventCal: Record "Education Multi Event Cal-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
}

