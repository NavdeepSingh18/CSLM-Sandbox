table 50423 "Student Wise Goal"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;

        }
        Field(2; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                StudentMaster_lREc: Record "Student Master-CS";
            begin
                IF "Student No." <> '' then begin
                    StudentMaster_lREc.Reset();
                    StudentMaster_lREc.SetRange("No.", "Student No.");
                    IF StudentMaster_lREc.FindFirst() then begin
                        "Student Name" := StudentMaster_lREc."Student Name";
                        "Enrollment No." := StudentMaster_lREc."Enrollment No.";
                        "Course Code" := StudentMaster_lREc."Course Code";
                        Semester := StudentMaster_lREc.Semester;
                        "Academic Year" := StudentMaster_lREc."Academic Year";
                        "Global Dimension 1 Code" := StudentMaster_lREc."Global Dimension 1 Code";
                        Term := StudentMaster_lREc.Term;
                    end;

                end Else Begin
                    "Student Name" := '';
                    "Enrollment No." := '';
                    "Course Code" := '';
                    Semester := '';
                    "Academic Year" := '';
                    "Global Dimension 1 Code" := '';
                End;

            end;
        }
        Field(3; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(4; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(5; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(6; Semester; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(7; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(8; Term; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        Field(9; "Goal Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(10; "Goal Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(11; "Time Table Doc No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(12; "Time Table Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        Field(13; "Final Time Table No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        Field(14; "Grouping No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Time Table Line Grouping';
        }
        Field(15; "Subject Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(16; "Subject Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

        }
        Field(18; "Attendance Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        Field(201; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        Field(202; "Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(203; "Updated By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        Field(204; "Updated On"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(205; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(206; Updated; Boolean)
        {
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        "Created On" := Today();
        "Created By" := UserId();
        Inserted := true;
    end;

    trigger OnModify()
    begin
        "Updated On" := Today();
        "Updated By" := UserId();
        Updated := true;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}