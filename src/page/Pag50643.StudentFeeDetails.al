page 50643 "Student Fee Details"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Temp Record";
    SourceTableTemporary = true;
    Caption = 'Semester Fee Calculation';
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            field("Total Amount"; TotAmt)
            {
                Caption = 'Total Amount';
                ApplicationArea = all;
                Style = Strong;
            }
            repeater(Group)
            {

                field("Student No."; Rec.Field2)
                {
                    Caption = 'Student No.';
                    ApplicationArea = All;
                }
                field("Student Name"; Rec.Field11)
                {
                    Caption = 'Student Name';
                    ApplicationArea = All;
                }
                field(Semester; Rec.Field5)
                {
                    Caption = 'Semester';
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec.Field13)
                {
                    Caption = 'Academic Year';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec.Field3)
                {
                    Caption = 'Global Dimension 1 Code';
                    ApplicationArea = All;
                }
                field(Session; Rec.Field12)
                {
                    Caption = 'Session';
                    ApplicationArea = All;
                }
                field("Fee Code"; Rec.Field4)
                {
                    Caption = 'Fee Code';
                    ApplicationArea = All;
                }
                field("Fixed Amount"; Rec.Field21)
                {
                    Caption = 'Amount';
                    ApplicationArea = All;
                }
            }
        }
    }
    procedure VariablePassing(StudentNo: Code[20]);
    begin
        StudentNo1 := StudentNo;
    end;

    trigger OnOpenPage()
    begin
        FeeInsert(StudentNo1, TotAmt);
    end;

    procedure FeeInsert(StudentNo: Code[20]; var TotalAmt: Decimal)
    var
        FeeCourseHead: Record "Fee Course Head-CS";
        FeeCourseLine: Record "Fee Course Line-CS";
        TempRecord1: Record "Temp Record" temporary;
        CourseRec: Record "Course Master-CS";
        StudentMaster: Record "Student Master-CS";
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
                    If Amt <> 0 Then begin
                        TempRecord1.Init();
                        TempRecord1."Entry No" := FeeCourseLine."Line No.";
                        TempRecord1.Field2 := StudentMaster."No.";
                        TempRecord1.Field31 := FeeCourseLine."Line No.";
                        TempRecord1.Field11 := StudentMaster."Student Name";
                        TempRecord1.Field3 := StudentMaster."Global Dimension 1 Code";
                        TempRecord1.Field21 := Amt;
                        TempRecord1.Field4 := FeeCourseLine."Fee Code";
                        TempRecord1.Field5 := StudentMaster.Semester;
                        TempRecord1.Field13 := StudentMaster."Academic Year";
                        TempRecord1.Field12 := Format(StudentMaster.Term);
                        TempRecord1.Insert();

                        Rec.Init();
                        Rec."Entry No" := TempRecord1."Entry No";
                        Rec.Field2 := TempRecord1.Field2;
                        Rec.Field31 := TempRecord1.Field31;
                        Rec.Field11 := TempRecord1.Field11;
                        Rec.Field3 := TempRecord1.Field3;
                        Rec.Field21 := TempRecord1.Field21;
                        Rec.Field4 := TempRecord1.Field4;
                        Rec.Field5 := TempRecord1.Field5;
                        Rec.Field13 := TempRecord1.Field13;
                        Rec.Field12 := TempRecord1.Field12;
                        Rec.Insert();
                        TotalAmt += Amt;
                    end;
                Until FeeCourseLine.Next() = 0;
        end;
    end;

    var
        StudentNo1: Code[20];
        TotAmt: Decimal;

}