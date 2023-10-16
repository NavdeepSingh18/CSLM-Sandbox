table 50157 "Fee Course Head-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                             Remarks
    // 1         CSPL-00092    09-05-2019    OnInsert                            No. Series and Assign Value in Fields.
    // 2         CSPL-00092    09-05-2019    OnModify                          Assign Value in Updated Field
    // 3         CSPL-00092    09-05-2019    No. - OnValidate                  No. Series
    // 4         CSPL-00092    09-05-2019    Course Code - OnValidate          Assign Value in fields
    // 5         CSPL-00092    09-05-2019    Semester - OnValidate              Validate Data
    // 6         CSPL-00092    09-05-2019    Due Date - OnValidate              Find Last Due Date
    // 7         CSPL-00092    09-05-2019    Fixed Amount - OnValidate          Validate Data
    // 8         CSPL-00092    09-05-2019    G/L Account for fine - OnValidate  Find Account For Fine
    // 9         CSPL-00092    09-05-2019    Year - OnValidate                  Validate data
    // 10        CSPL-00092    09-05-2019    Year Part - OnValidate            Validate data
    // 11        CSPL-00092    09-05-2019    Assistedit                        Select No. Series


    LookupPageID = "Fee Course Hdr List-CS";
    DataCaptionFields = "No.", "Course Code", "Course Name";


    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.Get(UserId());
                //Code added for No. Series::CSPL-00092::09-05-2019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    "FeeSetupCS".Reset();
                    "FeeSetupCS".SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                    IF FeeSetupCS.FindFirst() then begin
                        NoSeriesManagement.TestManual(FeeSetupCS."Course Fee No");
                        "No.Series" := '';
                    end;
                END;
                //Code added for No. Series::CSPL-00092::09-05-2019: End
            end;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign Value in fields::CSPL-00092::09-05-2019: Start
                IF CourseMasterCS.GET("Course Code") THEN BEGIN
                    "Course Name" := CourseMasterCS.Description;
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := CourseMasterCS."Global Dimension 2 Code";
                    "Program" := CourseMasterCS.Graduation;
                END ELSE BEGIN
                    "Course Name" := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Program" := '';
                END;
                UpdateFeeCourseLineField(Rec, xRec);

                //Code added for Assign Value in fields::CSPL-00092::09-05-2019: End
            end;
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Course Sem. Master-CS"."Semester Code";

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::09-05-2019: Start
                IF "Type Of Course" = "Type Of Course"::Semester THEN BEGIN
                    FeeCourseHeadCS1.Reset();
                    FeeCourseHeadCS1.SETCURRENTKEY("Course Code", Semester, "Academic Year");
                    FeeCourseHeadCS1.SETRANGE("Course Code", "Course Code");
                    FeeCourseHeadCS1.SETRANGE(Semester, Semester);
                    FeeCourseHeadCS1.SETRANGE("Academic Year", "Academic Year");
                    IF FeeCourseHeadCS1.FINDFIRST() THEN
                        ERROR('Duplicate Entry');
                END;
                UpdateFeeCourseLineField(Rec, xRec);
                //Code added for Validate Data::CSPL-00092::09-05-2019: End
            end;
        }
        field(4; "Fee Classification Code"; Code[20])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
            TableRelation = "Fee Classification Master-CS";
        }
        field(5; "No Of Installment"; Integer)
        {
            Caption = 'No Of Installment';
            DataClassification = CustomerContent;
        }
        field(6; "Installment Charges"; Decimal)
        {
            Caption = 'Installment Charges';
            DataClassification = CustomerContent;
        }
        field(7; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(8; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
            trigger OnValidate()
            begin
                UpdateFeeCourseLineField(Rec, xRec);
            end;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            begin
                UpdateFeeCourseLineField(Rec, xRec);
            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';

            trigger OnValidate()
            begin
                //Code added for Find Last Due Date::CSPL-00092::09-05-2019: Start
                FeeCourseLineCS.Reset();
                FeeCourseLineCS.SETRANGE("Document No.", "No.");
                IF FeeCourseLineCS.FindFirst() THEN
                    REPEAT
                        FeeCourseLineCS."Last Date" := "Due Date";
                        FeeCourseLineCS.Modify();
                    UNTIL FeeCourseLineCS.NEXT() = 0;
                //Code added for Find Last Due Date::CSPL-00092::09-05-2019: End
            end;
        }
        field(50004; "Fixed Amount"; Decimal)
        {
            Caption = 'Fixed Amount';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::09-05-2019: Start
                FeeCourseLineCS.Reset();
                FeeCourseLineCS.SETRANGE("Document No.", "No.");
                IF FeeCourseLineCS.FINDSET() THEN
                    REPEAT
                        FeeCourseLineCS.TESTFIELD("Late Fee Amount %", 0);
                    UNTIL FeeCourseLineCS.NEXT() = 0;
                //Code added for Validate Data::CSPL-00092::09-05-2019: End
            end;
        }
        field(50005; "G/L Account for fine"; Code[20])
        {
            Caption = 'G/L Account for fine';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                //Code added for Find Account For Fine::CSPL-00092::09-05-2019: Start
                FeeCourseLineCS.Reset();
                FeeCourseLineCS.SETRANGE("Document No.", "No.");
                IF FeeCourseLineCS.FindFirst() THEN
                    REPEAT
                        FeeCourseLineCS."G/L Acount for fine" := "G/L Account for fine";
                        FeeCourseLineCS.Modify();
                    UNTIL FeeCourseLineCS.NEXT() = 0;
                //Code added for Find Account For Fine::CSPL-00092::09-05-2019: End
            end;
        }
        field(50006; "Fixed amount for Compound Fine"; Decimal)
        {
            Caption = 'Fixed amount for Compound Fine';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(50007; "Start Date for Compound Fine"; Date)
        {
            Caption = 'Start Date for Compound Fine';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Year Master-CS";

            trigger OnValidate()
            begin
                //Code added for Validate data::CSPL-00092::09-05-2019: Start
                IF "Type Of Course" = "Type Of Course"::Year THEN BEGIN
                    FeeCourseHeadCS1.Reset();
                    FeeCourseHeadCS1.SETCURRENTKEY("Course Code", Semester, "Academic Year");
                    FeeCourseHeadCS1.SETRANGE("Course Code", "Course Code");
                    FeeCourseHeadCS1.SETRANGE(Year, Year);
                    FeeCourseHeadCS1.SETRANGE("Academic Year", "Academic Year");
                    IF FeeCourseHeadCS1.FINDFIRST() THEN
                        ERROR('Duplicate Entry');
                END;
                UpdateFeeCourseLineField(Rec, xRec);
                //Code added for Validate data::CSPL-00092::09-05-2019: End
            end;
        }
        field(50015; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            trigger OnValidate()
            begin
                UpdateFeeCourseLineField(Rec, xRec);
            end;
        }
        field(50016; "Duration of Years"; DateFormula)
        {
            CalcFormula = Lookup("Category Master-CS"."Discount Code" WHERE(Code = FIELD("Course Code")));
            Caption = 'Duration of Years';
            Description = 'CS Field Added 11-05-2019';
            FieldClass = FlowField;
        }
        field(50017; "Admitted Year"; Code[20])
        {
            Caption = 'Admitted Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Academic Year Master-CS";
            trigger Onvalidate()
            begin
                UpdateFeeCourseLineField(Rec, xRec);
            end;
        }
        field(50018; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            CalcFormula = Sum("Fee Course Line-CS"."Amount" WHERE("Document No." = FIELD("No.")));
            Description = 'CS Field Added 11-05-2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50019; "Late Fine %"; Decimal)
        {
            Caption = 'Late Fine %';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(50020; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(50021; "End Date"; Date)
        {
            Description = 'CS Field Added 11-05-2019';
        }
        field(50022; Category; Code[20])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Category Master-CS".Code WHERE("Fee Classification" = FIELD("Fee Classification Code"));
        }
        field(50023; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(50024; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Graduation Master-CS";
            trigger Onvalidate()
            begin
                UpdateFeeCourseLineField(Rec, xRec);
            end;
        }
        field(50025; "Other Fees"; Boolean)
        {
            Caption = 'Other Fees';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            trigger OnValidate()
            begin
                UpdateFeeCourseLineField(Rec, xRec);
            end;
        }
        field(50026; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = Currency.Code;
        }

        field(50027; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(33048922; "Year Part"; Option)
        {
            Caption = 'Year Part';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            OptionCaption = ' ,1st,2nd';
            OptionMembers = " ","1st","2nd";

            trigger OnValidate()
            begin
                //Code added for Validate data::CSPL-00092::09-05-2019: Start
                FeeCourseHeadCS1.Reset();
                FeeCourseHeadCS1.SETCURRENTKEY("Course Code", Semester, "Academic Year", "Fee Classification Code");
                FeeCourseHeadCS1.SETRANGE("Course Code", "Course Code");
                FeeCourseHeadCS1.SETRANGE("Academic Year", "Academic Year");
                FeeCourseHeadCS1.SETRANGE(Year, Year);
                FeeCourseHeadCS1.SETRANGE("Fee Classification Code", "Fee Classification Code");
                FeeCourseHeadCS1.SETRANGE("Year Part", "Year Part");
                IF FeeCourseHeadCS1.FINDFIRST() THEN
                    ERROR(TEXT0000Lbl);

                //Code added for Validate data::CSPL-00092::09-05-2019: End
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Course Code", Semester, "Academic Year")
        {
        }
        key(Key3; "Course Code", Year, "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        UserSetup: Record "User Setup";
    begin
        //Code added for No. Series and Assign Value in Fields::CSPL-00092::09-05-2019: Start
        UserSetup.Get(UserId());
        "FeeSetupCS".Reset();
        "FeeSetupCS".SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        IF FeeSetupCS.FindFirst() then begin
            IF "No.Series" = '' THEN BEGIN
                FeeSetupCS.TESTFIELD("Course Fee No");
                NoSeriesManagement.InitSeries(FeeSetupCS."Course Fee No", xRec."No.Series", 0D, "No.", "No.Series");
            END;
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Academic Year" := VerticalEducationCS.CreateAdmission_Yr();
            "User ID" := FORMAT(UserId());
        End;

        Inserted := true;
        //Code added for No. Series and Assign Value in Fields::CSPL-00092::09-05-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in Updated Field::CSPL-00092::09-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign Value in Updated Field::CSPL-00092::09-05-2019: Start
    end;

    trigger OnDelete()
    var
        FeeCouseLine: Record "Fee Course Line-CS";
    begin
        FeeCouseLine.Reset();
        FeeCouseLine.SetRange("Document No.", "No.");
        If FeeCouseLine.FindSet() then
            FeeCouseLine.DeleteAll();

    end;

    var
        FeeSetupCS: Record "Fee Setup-CS";

        FeeCourseHeadCS: Record "Fee Course Head-CS";

        FeeCourseLineCS: Record "Fee Course Line-CS";

        FeeCourseHeadCS1: Record "Fee Course Head-CS";
        CourseMasterCS: Record "Course Master-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        TEXT0000Lbl: Label 'Fees Already Generated for Current Class ';



    procedure Assistedit(OldCoursefees: Record "Fee Course Head-CS"): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        //Code added for Select No. Series::CSPL-00092::09-05-2019: Start
        UserSetup.Get(UserId());
        WITH FeeCourseHeadCS DO BEGIN
            FeeCourseHeadCS := Rec;
            "FeeSetupCS".Reset();
            "FeeSetupCS".SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
            IF FeeSetupCS.FindFirst() then begin
                FeeSetupCS.TESTFIELD("Course Fee No");
                IF NoSeriesManagement.SelectSeries(FeeSetupCS."Course Fee No", OldCoursefees."No.Series", "No.Series") THEN BEGIN
                    NoSeriesManagement.SetSeries("No.");
                    Rec := FeeCourseHeadCS;
                    EXIT(TRUE);
                END;
            End;
        END;
        //Code added for Select No. Series::CSPL-00092::09-05-2019: End
    end;

    Procedure UpdateFeeCourseLineField(_Rec: Record "Fee Course Head-CS"; _xRec: Record "Fee Course Head-CS")
    var
        FeeCourseLine_lRec: Record "Fee Course Line-CS";
    begin
        FeeCourseLine_lRec.Reset();
        FeeCourseLine_lRec.SetRange("Document No.", _Rec."No.");
        IF _Rec."Course Code" <> _xRec."Course Code" then
            FeeCourseLine_lRec.ModifyAll("Course Code", _Rec."Course Code");
        IF _Rec."Course Name" <> _xRec."Course Name" then
            FeeCourseLine_lRec.ModifyAll("Course Name", _Rec."Course Name");
        IF _Rec.Program <> _xRec.Program then
            FeeCourseLine_lRec.ModifyAll(Program, _Rec.Program);
        IF _Rec."Other Fees" <> _xRec."Other Fees" then
            FeeCourseLine_lRec.ModifyAll("Other Fees", _Rec."Other Fees");
        IF _Rec.Year <> _xRec.Year then
            FeeCourseLine_lRec.ModifyAll(Year, _Rec.Year);
        IF _Rec."Academic Year" <> _xRec."Academic Year" then
            FeeCourseLine_lRec.ModifyAll("Academic Year", _Rec."Academic Year");
        IF _Rec."Admitted Year" <> _xRec."Admitted Year" then
            FeeCourseLine_lRec.ModifyAll("Admitted Year", _Rec."Admitted Year");
        IF _Rec."Global Dimension 1 Code" <> _xRec."Global Dimension 1 Code" then
            FeeCourseLine_lRec.ModifyAll("Global Dimension 1 Code", _Rec."Global Dimension 1 Code");
        IF _Rec.Semester <> _xRec.Semester then
            FeeCourseLine_lRec.ModifyAll(Semester, _Rec.Semester);
    end;

}

