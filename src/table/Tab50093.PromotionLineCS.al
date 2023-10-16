table 50093 "Promotion Line-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                                   Remarks
    // 1         CSPL-00092    20-04-2019    OnModify                                  Code for Assign Value in Modified By and Modified on Field
    // 2         CSPL-00092    20-04-2019    Student No. - OnValidate                Code for Validate Data
    // 3         CSPL-00092    20-04-2019    Course Code - OnValidate                Code for Validate Data
    // 4         CSPL-00092    20-04-2019    Semester - OnValidate                 Code for Validate Data
    // 5         CSPL-00092    20-04-2019    In Active - OnValidate                  Code for Validate Data
    // 6         CSPL-00092    20-04-2019    Section - OnValidate                    Code for Validate Data
    // 7         CSPL-00092    20-04-2019    Academic Year - OnValidate              Code for Validate Data
    // 8         CSPL-00092    24-04-2019    Session - OnValidate                    Code for Validate Data
    // 9         CSPL-00092    20-04-2019    StatusPromotion                         Function for Validate Data

    Caption = 'Promotion Line-CS';

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            Editable = false;
            TableRelation = "Student Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::20-04-2019: Start
                StatusPromotion();
                //Code added for Validate Data::CSPL-00092::20-04-2019: End
            end;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            Editable = false;
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::20-04-2019: Start
                StatusPromotion();
                //Code added for Validate Data::CSPL-00092::20-04-2019: End
            end;
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            Editable = false;
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::20-04-2019: Start
                StatusPromotion();
                //Code added for Validate Data::CSPL-00092::20-04-2019: End
            end;
        }
        field(4; "Student Name"; Text[100])
        {
            Caption = 'Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "In Active"; Boolean)
        {
            Caption = 'In Active';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::20-04-2019: Start
                StatusPromotion();
                AttendanceActionCS.ModifyStudentStatus("Student No.", "In Active");
                //Code added for Validate Data::CSPL-00092::20-04-2019: End
            end;
        }
        field(6; Section; Code[10])
        {
            Caption = 'Section';
            TableRelation = "Section Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::20-04-2019: Start
                StatusPromotion();
                //Code added for Validate Data::CSPL-00092::20-04-2019: End
            end;
        }
        field(8; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            Editable = false;
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::20-04-2019: Start
                StatusPromotion();
                //Code added for Validate Data::CSPL-00092::20-04-2019: End
            end;
        }
        field(9; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(11; "Graduation Code"; Code[20])
        {
            Caption = 'Graduation Code';
            TableRelation = "Graduation Master-CS";
            DataClassification = CustomerContent;
        }
        field(12; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
            DataClassification = CustomerContent;
        }
        field(13; "Earnd Percentage"; Decimal)
        {
            Caption = 'Earnd Percentage';
            DataClassification = CustomerContent;
        }
        field(14; "Admitted Year"; Code[20])
        {
            Caption = 'Admitted Year';
            Editable = false;
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::20-04-2019: Start
                StatusPromotion();
                //Code added for Validate Data::CSPL-00092::20-04-2019: End
            end;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 24-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 24-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(50013; "Type Of Course"; Option)
        {
            Description = 'CS Field Added 24-04-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            Caption = 'Type of Course';
            DataClassification = CustomerContent;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Description = 'CS Field Added 24-04-2019';
            DataClassification = CustomerContent;
            Caption = 'Fianl Year Course';
        }
        field(50015; "Not Eligible"; Boolean)
        {
            Description = 'CS Field Added 24-04-2019';
            Editable = false;
            Caption = 'Not Eligible';
            DataClassification = CustomerContent;
        }
        field(50016; Session; Code[20])
        {
            Description = 'CS Field Added 24-04-2019';
            TableRelation = Session;
            Caption = 'Session';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::24-04-2019: Start
                StatusPromotion();
                //Code added for Validate Data::CSPL-00092::24-04-2019: End
            end;
        }
        field(50017; "Order"; Integer)
        {
            Description = 'CS Field Added 24-04-2019';
            Caption = 'Order';
            DataClassification = CustomerContent;
        }
        field(50018; Year; Code[20])
        {
            Description = 'CS Field Added 24-04-2019';
            TableRelation = "Year Master-CS";
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(50019; "Student Promoted"; Boolean)
        {
            Description = 'CS Field Added 24-04-2019';
            Editable = false;
            Caption = 'Student Promoted';
            DataClassification = CustomerContent;
        }
        field(50020; "Enrollment No."; Code[20])
        {
            Description = 'CS Field Added 24-04-2019';
            Editable = false;
            Caption = 'Enrollemnt No.';
            DataClassification = CustomerContent;
        }
        field(50021; Credit; Decimal)
        {
            Description = 'CS Field Added 24-04-2019';
            Caption = 'Credit';
            DataClassification = CustomerContent;
        }
        field(50022; "Promoted Year"; Code[20])
        {
            Description = 'CS Field Added 24-04-2019';
            TableRelation = "Year Master-CS";
            Caption = 'Promoted Year';
            DataClassification = CustomerContent;
        }
        field(50023; "Promoted Semester"; Code[20])
        {
            Description = 'CS Field Added 24-04-2019';
            TableRelation = "Semester Master-CS";
            Caption = 'Promoted Semester';
            DataClassification = CustomerContent;
        }
        field(50024; "Promoted  Academic Year"; Code[20])
        {
            Description = 'CS Field Added 24-04-2019';
            TableRelation = "Academic Year Master-CS";
            Caption = 'Promoted Academic Year';
            DataClassification = CustomerContent;
        }
        field(50025; Graduated; Boolean)
        {
            Description = 'CS Field Added 24-04-2019';
            Caption = 'Graduated';
            DataClassification = CustomerContent;
        }
        field(50026; "Created By"; Code[30])
        {
            Description = 'CS Field Added 24-04-2019';
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(50027; "Created On"; Date)
        {
            Description = 'CS Field Added 24-04-2019';
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(50028; "Modified By"; Code[30])
        {
            Description = 'CS Field Added 24-04-2019';
            Caption = 'Modified By';
            DataClassification = CustomerContent;
        }
        field(50029; "Modified On"; Date)
        {
            Description = 'CS Field Added 24-04-2019';
            Caption = 'Modified On';
            DataClassification = CustomerContent;
        }
        field(50030; "Fee Generated"; Boolean)
        {
            Description = 'CS Field Added 24-04-2019';
            Editable = false;
            Caption = 'Fee Generated';
            DataClassification = CustomerContent;
        }
        field(50031; Group; Code[20])
        {
            Description = 'CS Field Added 24-04-2019';
            Caption = 'Group';
            DataClassification = CustomerContent;
        }
        field(50032; "Promoted To Group"; Code[20])
        {
            Description = 'CS Field Added 24-04-2019';
            Caption = 'Promoted To Group';
            DataClassification = CustomerContent;
        }
        field(50033; "Lateral Student"; Boolean)
        {
            Description = 'CS Field Added 24-04-2019';
            Caption = 'Lateral Student';
            DataClassification = CustomerContent;
        }
        field(50034; "Type Of Repeat"; Option)
        {
            Caption = 'Type Of Repeat';
            OptionMembers = " ","Semester","Year";
            DataClassification = CustomerContent;
        }
        field(50035; "Repeat Application No"; Code[20])
        {
            Caption = 'Repeat Application No';
            DataClassification = CustomerContent;
            trigger OnLookup()
            var
                OptOut: Record "Opt Out";
                RepeatApplicationCard: Page "Repeat Application Card";
            begin
                OptOut.Reset();
                OptOut.SetRange("Student No.", "Student No.");
                OptOut.SetRange("Academic Year", "Academic Year");
                OptOut.SetRange(Semester, Semester);
                OptOut.SetRange("Application Type", "Type Of Repeat");
                OptOut.SetRange(Status, OptOut.Status::Submit);
                OptOut.SetRange("Application Used", true);
                If "Repeat Application No" <> '' then
                    OptOut.SetRange("Application No.", "Repeat Application No");
                IF OptOut.FindFirst() then begin
                    Clear(RepeatApplicationCard);
                    RepeatApplicationCard.SetTableView(OptOut);
                    RepeatApplicationCard.Editable := false;
                    RepeatApplicationCard.Run();
                end;
            end;
        }
        field(50036; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50037; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //Code added for Assign Value in Modified By and Modified on Field::CSPL-00092::20-04-2019: Start
        "Modified By" := FORMAT(UserId());
        "Modified On" := TODAY();
        IF xRec.Updated = Updated then
            Updated := true;
        //Code added for Assign Value in Modified By and Modified on Field::CSPL-00092::20-04-2019: End
    end;

    trigger OnInsert()
    begin
        Inserted := true;
    end;

    var
        AttendanceActionCS: Codeunit "Attendance Action-CS";
        Text001Lbl: Label 'Student Promotion Has Been Already Committed';

    procedure StatusPromotion()
    begin
        //Code added for Validate Data::CSPL-00092::20-04-2019: Start
        IF "Student Promoted" = TRUE THEN
            ERROR(Text001Lbl);
        //Code added for Validate Data::CSPL-00092::20-04-2019: End
    end;
}