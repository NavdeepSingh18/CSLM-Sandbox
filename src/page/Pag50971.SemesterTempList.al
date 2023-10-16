page 50971 "Semester Temp List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Temp Record";
    SourceTableTemporary = true;
    Caption = 'Semester Temp List';
    //Editable = false;
    //ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    //SourceTableView = sorting(Field31) ORDER(Ascending);

    layout
    {

        area(content)
        {

            repeater(Group)
            {

                field(Select; Rec.Select)
                {
                    Caption = 'Select';
                    ApplicationArea = All;
                }
                field("Semester Code"; Rec.Field2)
                {
                    Caption = 'Semester Code';
                    ApplicationArea = All;
                }
                field("Start Date"; Rec.Field73)
                {
                    Caption = 'Start Date';
                    ApplicationArea = All;
                }
                field("End Date"; Rec.Field74)
                {
                    Caption = 'End Date';
                    ApplicationArea = All;
                }
                field("Start Date Not Applicable"; Rec.Field75)
                {
                    Caption = 'Start Date Not Applicable';
                    ApplicationArea = All;
                }
                field(Sequence; Rec.Field31)
                {
                    Caption = 'Sequence';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec.Field3)
                {
                    Caption = 'Insititue Code';
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec.Field4)
                {
                    Caption = 'Academic Year';
                    ApplicationArea = All;
                }

            }
        }
    }
    procedure VariablePassing(Course: Code[20]; DimCode: Code[20]);
    begin
        CourseCode := Course;
        DimensionCode := DimCode;
    end;

    trigger OnOpenPage()
    begin
        SemesterInsert(DimensionCode);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        CourseSemesterInsert(CourseCode, Rec.Field73, Rec.Field74, Rec.Field4);
    end;

    Procedure SemesterInsert(DimCode: Code[20])
    var
        SemesterMasterRec: Record "Semester Master-CS";
        TempRecordRec: Record "Temp Record" temporary;
    begin
        EducationSetupRec.Reset();
        EducationSetupRec.SetRange("Global Dimension 1 Code", DimCOde);
        EducationSetupRec.FindFirst();

        CourseSemesterRec.Reset();
        CourseSemesterRec.SetRange("Course Code", CourseCode);
        CourseSemesterRec.SetRange("Global Dimension 1 Code", DimCode);
        CourseSemesterRec.SetRange(Term, EducationSetupRec."Even/Odd Semester");
        if CourseSemesterRec.FindSet() then
            repeat
                TempRecordRec.Reset();
                TempRecordRec.INIT();
                TempRecordRec."Entry No" := CourseSemesterRec."Sequence No";
                TempRecordRec.Field2 := CourseSemesterRec."Semester Code";
                TempRecordRec.Field75 := CourseSemesterRec."Start Date Not Applicable";
                TempRecordRec.Field31 := CourseSemesterRec."Sequence No";
                TempRecordRec.Field3 := CourseSemesterRec."Global Dimension 1 Code";
                TempRecordRec.Field4 := CourseSemesterRec."Academic Year";
                TempRecordRec.Field73 := CourseSemesterRec."Start Date";
                TempRecordRec.Field74 := CourseSemesterRec."End Date";
                TempRecordRec.Field75 := CourseSemesterRec."Start Date Not Applicable";
                TempRecordRec.Insert();

                Rec.Init();
                Rec."Entry No" := TempRecordRec."Entry No";
                Rec.Field2 := TempRecordRec.Field2;
                Rec.Field11 := TempRecordRec.Field11;
                Rec.Field31 := TempRecordRec.Field31;
                Rec.Field73 := TempRecordRec.Field73;
                Rec.Field74 := TempRecordRec.Field74;
                Rec.Field75 := TempRecordRec.Field75;
                Rec.Field3 := TempRecordRec.Field3;
                Rec.Field4 := TempRecordRec.Field4;
                Rec.Select := true;
                Rec.Insert();
            Until CourseSemesterRec.Next() = 0;

        SemesterMasterRec.Reset();
        SemesterMasterRec.SetRange("Global Dimension 1 Code", DimCode);
        if SemesterMasterRec.FindSet() then
            repeat
                CourseSemesterRec1.Reset();
                CourseSemesterRec1.SetRange("Course Code", CourseCode);
                CourseSemesterRec1.SetRange("Semester Code", SemesterMasterRec.Code);
                CourseSemesterRec1.SetRange("Global Dimension 1 Code", DimCode);
                CourseSemesterRec1.SetRange(Term, EducationSetupRec."Even/Odd Semester");
                CourseSemesterRec1.SetRange("Academic Year", EducationSetupRec."Academic Year");
                if not CourseSemesterRec1.FindFirst() then begin

                    TempRecordRec.Reset();
                    TempRecordRec.INIT();
                    TempRecordRec."Entry No" := SemesterMasterRec.Sequence;
                    TempRecordRec.Field2 := SemesterMasterRec.Code;
                    TempRecordRec.Field75 := SemesterMasterRec."Start Date Not Applicable";
                    TempRecordRec.Field31 := SemesterMasterRec.Sequence;
                    TempRecordRec.Field3 := SemesterMasterRec."Global Dimension 1 Code";
                    TempRecordRec.Field4 := EducationSetupRec."Academic Year";
                    TempRecordRec.Insert();

                    Rec.Init();
                    Rec."Entry No" := TempRecordRec."Entry No";
                    Rec.Field2 := TempRecordRec.Field2;
                    Rec.Field11 := TempRecordRec.Field11;
                    Rec.Field31 := TempRecordRec.Field31;
                    Rec.Field75 := TempRecordRec.Field75;
                    Rec.Field3 := TempRecordRec.Field3;
                    Rec.Field4 := TempRecordRec.Field4;
                    Rec.Insert();
                end;
            until SemesterMasterRec.Next() = 0;
    end;

    procedure CourseSemesterInsert(Course: Code[20];
        StartDate: Date;
        EndDate: Date;
        AcademicYear: Code[20])
    var
        CourseSemMasterRec: Record "Course Sem. Master-CS";
    begin
        CourseSemMasterRec.Reset();
        CourseSemMasterRec.SetRange("Course Code", Course);
        CourseSemMasterRec.Setrange("Academic Year", AcademicYear);
        if CourseSemMasterRec.findset() then
            CourseSemMasterRec.DeleteAll();

        Rec.Setrange(Select, True);
        if Rec.FindSet() then
            repeat
                CourseSemMasterRec.RESET();
                CourseSemMasterRec.Init();
                CourseSemMasterRec."Course Code" := Course;
                CourseSemMasterRec."Semester Code" := Rec.Field2;
                CourseSemMasterRec."Academic Year" := Rec.Field4;
                CourseSemMasterRec."Start Date" := Rec.Field73;
                CourseSemMasterRec."End Date" := Rec.Field74;
                CourseSemMasterRec."Sequence No" := Rec.Field31;
                CourseSemMasterRec."Global Dimension 1 Code" := Rec.Field3;
                CourseSemMasterRec.Term := EducationSetupRec."Even/Odd Semester";
                CourseSemMasterRec.Insert();
            Until Rec.Next() = 0;
    end;

    var
        EducationSetupRec: Record "Education Setup-CS";
        CourseSemesterRec: Record "Course Sem. Master-CS";
        CourseSemesterRec1: Record "Course Sem. Master-CS";
        CourseCode: Code[20];
        DimensionCode: Code[20];

}