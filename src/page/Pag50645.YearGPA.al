page 50645 "Year GPA"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Temp Record";
    SourceTableTemporary = true;
    Caption = 'Year GPA';
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Semester; Rec.Field3)
                {
                    Caption = 'Semester';
                    ApplicationArea = All;
                }
                field("Credits Earned"; Rec.Field21)
                {
                    Caption = 'Credits Earned';
                    ApplicationArea = All;
                }
                field(GPA; Rec.Field22)
                {
                    Caption = 'GPA';
                    ApplicationArea = All;
                }
                field(Grading; Rec.Field5)
                {
                    Caption = 'Grading';
                    ApplicationArea = All;
                }
            }
        }

    }

    procedure VariablePassing(StudentNo: Code[20]; CourseCode: Code[20]; GD1: Code[20]);
    begin
        CourseCode1 := CourseCode;
        GlobalDim1 := GD1;
        StudentNo1 := StudentNo;
    end;

    trigger OnOpenPage()
    begin
        FeeInsert(StudentNo1, CourseCode1, GlobalDim1);
        Rec.SetCurrentKey(Field31);
    end;

    procedure FeeInsert(StudentNo: Code[20]; CourseCode: Code[20]; GD1: Code[20])
    var
        CourseYearMaster: Record "Course Year Master-CS";
        TempRecord1: Record "Temp Record" temporary;
        StudentMaster: Record "Student Master-CS";
    begin

        CourseYearMaster.Reset();
        CourseYearMaster.SetCurrentKey(CourseYearMaster."Sequence No");
        CourseYearMaster.SetRange("Course Code", CourseCode);
        CourseYearMaster.SetRange("Global Dimension 1 Code", GD1);
        IF CourseYearMaster.findSet() THEN begin
            StudentMaster.Get(StudentNo);
            REPEAT
                TempRecord1.Init();
                TempRecord1."Entry No" := CourseYearMaster."Sequence No";
                TempRecord1.Field2 := CourseYearMaster."Course Code";
                TempRecord1.Field3 := CourseYearMaster."Year Code";
                TempRecord1.Field4 := CourseYearMaster."Academic Year";
                TempRecord1.Field31 := CourseYearMaster."Sequence No";
                TempRecord1.Field5 := '';

                IF CourseYearMaster."Sequence No" = 1 then begin
                    TempRecord1.Field21 := StudentMaster."Year 1 Credit Earned";
                    TempRecord1.Field22 := StudentMaster."Year 1 GPA";
                end;
                IF CourseYearMaster."Sequence No" = 2 then begin
                    TempRecord1.Field21 := StudentMaster."Year 2 Credit Earned";
                    TempRecord1.Field22 := StudentMaster."Year 2 GPA";
                End;
                IF CourseYearMaster."Sequence No" = 3 then begin
                    TempRecord1.Field21 := StudentMaster."Year 3 Credit Earned";
                    TempRecord1.Field22 := StudentMaster."Year 3 GPA";
                end;
                IF CourseYearMaster."Sequence No" = 4 then begin
                    TempRecord1.Field21 := StudentMaster."Semester IV Credit Earned";
                    TempRecord1.Field22 := StudentMaster."Semester IV GPA";
                end;
                IF CourseYearMaster."Sequence No" = 5 then begin
                    TempRecord1.Field21 := StudentMaster."Semester V Credit Earned";
                    TempRecord1.Field22 := StudentMaster."Semester v GPA";
                end;
                IF CourseYearMaster."Sequence No" = 6 then begin
                    TempRecord1.Field21 := StudentMaster."Semester VI Credit Earned";
                    TempRecord1.Field22 := StudentMaster."Semester VI GPA";
                end;
                IF CourseYearMaster."Sequence No" = 7 then begin
                    TempRecord1.Field21 := StudentMaster."Semester VII Credit Earned";
                    TempRecord1.Field22 := StudentMaster."Semester VII GPA";
                end;
                IF CourseYearMaster."Sequence No" = 8 then begin
                    TempRecord1.Field21 := StudentMaster."Semester VIII Credit Earned";
                    TempRecord1.Field22 := StudentMaster."Semester VIII GPA";
                end;
                IF CourseYearMaster."Sequence No" = 9 then begin
                    TempRecord1.Field21 := StudentMaster."Semester IX Credit Earned";
                    TempRecord1.Field22 := StudentMaster."Semester IX GPA";
                end;
                TempRecord1.Insert();

                Rec.Init();
                Rec."Entry No" := TempRecord1."Entry No";
                Rec.Field2 := TempRecord1.Field2;
                Rec.Field3 := TempRecord1.Field3;
                Rec.Field4 := TempRecord1.Field4;
                Rec.Field31 := TempRecord1.Field31;
                Rec.Field21 := TempRecord1.Field21;
                Rec.Field22 := TempRecord1.Field22;
                Rec.Field5 := TempRecord1.Field5;
                Rec.Insert();

            Until CourseYearMaster.Next() = 0;

            // Net Semester CGPA
            TempRecord1.Init();
            TempRecord1."Entry No" := 20;
            TempRecord1.Field2 := CourseYearMaster."Course Code";
            TempRecord1.Field3 := 'Net Year CGPA';
            TempRecord1.Field4 := CourseYearMaster."Academic Year";
            TempRecord1.Field31 := 20;
            TempRecord1.Field5 := '';
            TempRecord1.Field21 := 0;
            TempRecord1.Field22 := StudentMaster."Net Semester CGPA";
            TempRecord1.Insert();

            Rec.Init();
            Rec."Entry No" := TempRecord1."Entry No";
            Rec.Field2 := TempRecord1.Field2;
            Rec.Field3 := TempRecord1.Field3;
            Rec.Field4 := TempRecord1.Field4;
            Rec.Field31 := TempRecord1.Field31;
            Rec.Field21 := TempRecord1.Field21;
            Rec.Field22 := TempRecord1.Field22;
            Rec.Field5 := TempRecord1.Field5;
            Rec.Insert();

        end;

    end;

    var
        StudentNo1: Code[20];
        CourseCode1: Code[20];
        GlobalDim1: COde[20];

}