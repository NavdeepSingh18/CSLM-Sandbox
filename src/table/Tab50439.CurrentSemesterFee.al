table 50439 "Current Semester Fee"
{
    Caption = 'Current Semester Fee';
    fields
    {

        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(2; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(3; "Semester"; Code[20])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
        }
        field(6; Session; Text[100])
        {
            Caption = 'Session';
            DataClassification = CustomerContent;
        }
        field(7; "Fee Code"; Code[20])
        {
            Caption = 'Fee Code';
            DataClassification = CustomerContent;
        }
        field(8; "Fixed Amount"; Decimal)
        {
            Caption = 'Fixed Amount';
            DataClassification = CustomerContent;
        }
        field(9; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
        }
        field(10; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(11; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Student No.", "Fee Code")
        {
        }
    }
    procedure VariablePassing(StudentNo: Code[20]);
    begin
        FeeInsert(StudentNo, TotAmt);
    end;

    procedure FeeInsert(StudentNo: Code[20]; var TotalAmt: Decimal)
    var
        FeeCourseHead: Record "Fee Course Head-CS";
        FeeCourseLine: Record "Fee Course Line-CS";
        RecCurrentSemesterFee: Record "Current Semester Fee";
        CourseRec: Record "Course Master-CS";
        StudentMaster: Record "Student Master-CS";
        RecCurrSemFee: Record "Current Semester Fee";
        FeeGeneration: Report "Fee Generation New";
        Amt: Decimal;
        SemFee: Decimal;
        Grenville: Decimal;

    begin
        StudentMaster.Get(StudentNo);
        FeeCourseHead.Reset();
        FeeCourseHead.SETRANGE(FeeCourseHead."Course Code", StudentMaster."Course Code");
        FeeCourseHead.SETRANGE(FeeCourseHead."Academic Year", StudentMaster."Academic Year");
        FeeCourseHead.SETRANGE(FeeCourseHead."Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
        FeeCourseHead.SETRANGE(FeeCourseHead."Other Fees", false);
        CourseRec.Get(StudentMaster."Course Code");
        If CourseRec."Admitted Year Wise Fee" then
            FeeCourseHead.SETRANGE(FeeCourseHead."Admitted Year", StudentMaster."Admitted Year");
        If CourseRec."Semester Wise Fee" then
            FeeCourseHead.SETRANGE(FeeCourseHead.Semester, StudentMaster.Semester);
        IF FeeCourseHead.findfirst() THEN BEGIN
            FeeCourseLine.Reset();
            FeeCourseLine.SETRANGE("Document No.", FeeCourseHead."No.");
            IF FeeCourseLine.findfirst() THEN
                REPEAT
                    Amt := FeeGeneration.StudentTotalFee(StudentMaster."No.", FeeCourseLine."Fee Code", '', '', false, SemFee, Grenville);
                    RecCurrSemFee.RESET();
                    RecCurrentSemesterFee.SetRange("Student No.", StudentMaster."No.");
                    RecCurrentSemesterFee.SetRange(Semester, StudentMaster.Semester);
                    RecCurrentSemesterFee.SetRange("Academic Year", StudentMaster."Academic Year");
                    RecCurrentSemesterFee.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
                    RecCurrentSemesterFee.SetRange("Fee Code", FeeCourseLine."Fee Code");
                    IF RecCurrentSemesterFee.FindFirst() then
                        RecCurrentSemesterFee.Delete();
                    If Amt <> 0 Then begin

                        RecCurrentSemesterFee.Init();
                        RecCurrentSemesterFee."Line No" := FeeCourseLine."Line No.";
                        RecCurrentSemesterFee."Student No." := StudentMaster."No.";
                        RecCurrentSemesterFee."Student Name" := StudentMaster."Student Name";
                        RecCurrentSemesterFee."Global Dimension 1 Code" := StudentMaster."Global Dimension 1 Code";
                        RecCurrentSemesterFee."Fixed Amount" := Amt;
                        RecCurrentSemesterFee."Fee Code" := FeeCourseLine."Fee Code";
                        RecCurrentSemesterFee.Semester := StudentMaster.Semester;
                        RecCurrentSemesterFee."Academic Year" := StudentMaster."Academic Year";
                        RecCurrentSemesterFee.Term := StudentMaster.Term;
                        RecCurrentSemesterFee.Insert();
                        TotalAmt += Amt
                    end;
                Until FeeCourseLine.Next() = 0;
        end;
    end;

    var

        TotAmt: Decimal;


}