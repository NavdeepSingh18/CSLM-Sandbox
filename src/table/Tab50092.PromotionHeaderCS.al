table 50092 "Promotion Header-CS"
{
    // version V.001-CS

    // Sr.No.      Emp. ID       Date          Trigger                                 Remarks
    // 1           CSPL-00092    20-04-2019    OnInsert                                No. Series and Assign value in User Id and Academic Year Field.
    // 2           CSPL-00092    20-04-2019    OnModify                              Assign value in Modified By and Modifyedon Field
    // 3           CSPL-00092    20-04-2019    OnDelete                                Code for Delete Data form Table
    // 4           CSPL-00092    20-04-2019    Course - OnValidate                   Validate Data and Assign Value in Fields
    // 5           CSPL-00092    20-04-2019    Semester - OnValidate                 Validate Data and Assign Value in order Field
    // 6           CSPL-00092    20-04-2019    Section - OnValidate                  Code for Validate Data
    // 7           CSPL-00092    20-04-2019    Academic Year - OnValidate              Code for Validate Data
    // 8           CSPL-00092    20-04-2019    Graduation - OnValidate               Code for Validate Data
    // 9           CSPL-00092    20-04-2019    Department Code - OnValidate          Code for Validate Data
    // 10          CSPL-00092    20-04-2019    No. - OnValidate                      Code for No. Series and Validate Data
    // 11          CSPL-00092    24-04-2019    Global Dimension 1 Code - OnValidate  Code for Validate Data
    // 12          CSPL-00092    24-04-2019    Global Dimension 2 Code - OnValidate  Code for Validate Data
    // 13          CSPL-00092    24-04-2019    Type Of Course - OnValidate           Code for Validate Data
    // 14          CSPL-00092    24-04-2019    Final Years Course - OnValidate       Code for Validate Data
    // 15          CSPL-00092    24-04-2019    Year - OnValidate                     Validate Data and Assign Value in Order Field
    // 16          CSPL-00092    24-04-2019    Session - OnValidate                  Code for Validate Data
    // 17          CSPL-00092    24-04-2019    Order - OnValidate                    Code for Validate Data
    // 18          CSPL-00092    20-04-2019    Assistedit                              Function for Select No series from Assitedit Button
    // 19          CSPL-00092    20-04-2019    StatusPromotion                       Function for Validate data

    Caption = 'Promotion Header';

    fields
    {
        field(1; Course; Code[20])
        {
            Caption = 'Course';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Validate Data and Assign Value in Fields::CSPL-00092::20-04-2019: Start
                StatusPromotion();
                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, Course);
                IF CourseMasterCS.FindFirst() THEN BEGIN
                    "Course Name" := CourseMasterCS.Description;
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := CourseMasterCS."Global Dimension 2 Code";
                    Graduation := CourseMasterCS.Graduation;
                    "Type Of Course" := CourseMasterCS."Type Of Course";
                END;
                //Code added for Validate Data and Assign Value in Fields::CSPL-00092::20-04-2019: End
            end;
        }
        field(2; Semester; Code[10])
        {
            Caption = 'Semester';
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Validate Data and Assign Value in order Field::CSPL-00092::20-04-2019: Start
                StatusPromotion();
                SemesterMasterCS.Reset();
                SemesterMasterCS.SETRANGE(SemesterMasterCS.Code, Semester);
                IF SemesterMasterCS.FindFirst() THEN
                    Order := SemesterMasterCS.Order;
                //Code added for Validate Data and Assign Value in order Field::CSPL-00092::20-04-2019: End
            end;
        }
        field(3; Section; Code[10])
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
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            Editable = true;
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::20-04-2019: Start
                StatusPromotion();
                //Code added for Validate Data::CSPL-00092::20-04-2019: End
            end;
        }
        field(5; Graduation; Code[20])
        {
            Caption = 'Graduation';
            Editable = false;
            TableRelation = "Graduation Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::20-04-2019: Start
                StatusPromotion();
                //Code added for Validate Data::CSPL-00092::20-04-2019: End
            end;
        }
        field(6; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::20-04-2019: Start
                StatusPromotion();
                //Code added for Validate Data::CSPL-00092::20-04-2019: End
            end;
        }
        field(7; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for No Series and Validate Data::CSPL-00092::20-04-2019: Start
                StatusPromotion();
                IF "No." <> xRec."No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesManagement.TestManual(AcademicsSetupCS."Student Promotion No.");
                    "No.Series" := '';
                END;
                //Code added for No Series and Validate Data::CSPL-00092::20-04-2019: End
            end;
        }
        field(8; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(9; "Term"; Option)
        {
            Caption = 'Term';
            OptionMembers = FALL,SPRING,SUMMER;
            OptionCaption = 'FALL,SPRING,SUMMER';
        }
        field(10; "Next Academic Year"; Code[20])
        {
            Caption = 'Next Academic Year';
            // Editable = false;
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(11; "Next Term"; Option)
        {
            Caption = 'Next Term';
            OptionMembers = FALL,SPRING,SUMMER;
            OptionCaption = 'FALL,SPRING,SUMMER';
            // Editable = false;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 24-04-2019';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::24-04-2019: Start
                StatusPromotion();
                //Code added for Validate Data::CSPL-00092::24-04-2019: End
            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24-04-2019';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::24-04-2019: Start
                StatusPromotion();
                //Code added for Validate Data::CSPL-00092::24-04-2019: End
            end;
        }
        field(50013; "Type Of Course"; Option)
        {
            Description = 'CS Field Added 24-04-2019';
            Editable = false;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            Caption = 'Type of Course';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::24-04-2019: Start
                StatusPromotion();
                //Code added for Validate Data::CSPL-00092::24-04-2019: End
            end;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Description = 'CS Field Added 24-04-2019';
            Caption = 'Fianl Years Course';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::24-04-2019: Start
                StatusPromotion();
                //Code added for Validate Data::CSPL-00092::24-04-2019: End
            end;
        }
        field(50015; Year; Code[20])
        {
            Description = 'CS Field Added 24-04-2019';
            TableRelation = "Year Master-CS";
            Caption = 'Year';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data and Assign Value in Order Field::CSPL-00092::24-04-2019: Start
                StatusPromotion();
                YearMasterCS.Reset();
                YearMasterCS.SETRANGE(YearMasterCS.Code, Year);
                IF YearMasterCS.FindFirst() THEN
                    Order := YearMasterCS.Order;
                //Code added for Validate Data and Assign Value in Order Field::CSPL-00092::24-04-2019: End
            end;
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
            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::24-04-2019: Start
                StatusPromotion();
                //Code added for Validate Data::CSPL-00092::24-04-2019: End
            end;
        }
        field(50018; Promoted; Boolean)
        {
            Description = 'CS Field Added 24-04-2019';
            Caption = 'Promoted';
            DataClassification = CustomerContent;
        }
        field(50019; "Course Name"; Text[100])
        {
            Description = 'CS Field Added 24-04-2019';
            Editable = false;
            Caption = 'Course Name';
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 24-04-2019';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 24-04-2019';
            DataClassification = CustomerContent;
        }
        field(33048922; "Created By"; Code[30])
        {
            Description = 'CS Field Added 24-04-2019';
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(33048923; "Created On"; Date)
        {
            Description = 'CS Field Added 24-04-2019';
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(33048924; "Modified By"; Code[30])
        {
            Description = 'CS Field Added 24-04-2019';
            Caption = 'Modified By';
            DataClassification = CustomerContent;
        }
        field(33048925; "Modified On"; Date)
        {
            Description = 'CS Field Added 24-04-2019';
            Caption = 'Modified';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; Course, Semester, Section, "Academic Year", Graduation, "Department Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //Code added for Delete Data form Table::CSPL-00092::20-04-2019: Start
        PromotionLineCS.Reset();
        PromotionLineCS.SETRANGE("Document No.", "No.");
        PromotionLineCS.DELETEALL();
        //Code added for Delete Data form Table::CSPL-00092::20-04-2019: End
    end;

    trigger OnInsert()
    begin
        //Code added for No. Series and Assign value in User Id and Academic Year Field::CSPL-00092::20-04-2019: Start
        AcademicsSetupCS.GET();
        IF "No.Series" = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD("Student Promotion No.");
            NoSeriesManagement.InitSeries(AcademicsSetupCS."Student Promotion No.", xRec."No.Series", 0D, "No.", "No.Series");
        END;
        "User ID" := FORMAT(UserId());
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        //Code added for No. Series and Assign value in User Id and Academic Year Field::CSPL-00092::20-04-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign value in Modified By and Modifyedon Field::CSPL-00092::20-04-2019: Start
        "Modified By" := FORMAT(UserId());
        "Modified On" := TODAY();
        //Code added for Assign value in Modified By and Modifyedon Field::CSPL-00092::20-04-2019: End
    end;

    var

        AcademicsSetupCS: Record "Academics Setup-CS";

        PromotionHeaderCS: Record "Promotion Header-CS";
        SemesterMasterCS: Record "Semester Master-CS";
        YearMasterCS: Record "Year Master-CS";
        CourseMasterCS: Record "Course Master-CS";
        PromotionLineCS: Record "Promotion Line-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        Text001Lbl: Label 'Student Promotion Has Been Already Committed';


    procedure Assistedit(OldStudentPromotinHeader: Record "Promotion Header-CS"): Boolean
    begin
        //Code added for Select No series from Assitedit Button::CSPL-00092::20-04-2019: Start
        WITH PromotionHeaderCS DO BEGIN
            PromotionHeaderCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("Student Promotion No.");
            IF NoSeriesManagement.SelectSeries(AcademicsSetupCS."Student Promotion No.", OldStudentPromotinHeader."No.Series",
            "No.Series") THEN BEGIN
                NoSeriesManagement.SetSeries("No.");
                Rec := PromotionHeaderCS;
                EXIT(TRUE);
            END;
        END;
        //Code added for Select No series from Assitedit Button::CSPL-00092::20-04-2019: End
    end;

    procedure StatusPromotion()
    begin
        //Code added for Validate Data::CSPL-00092::20-04-2019: Start
        IF Promoted = TRUE THEN
            ERROR(Text001Lbl);
        //Code added for Validate Data::CSPL-00092::20-04-2019: End
    end;
}

