page 50750 "Temp Course Degree List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Temp Record";
    SourceTableTemporary = true;
    Caption = 'Course Degree List';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec.Field5)
                {
                    Caption = 'Student No.';
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Course Code"; Rec.Field2)
                {
                    Caption = 'Course Code';
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Degree Code"; Rec.Field3)
                {
                    Caption = 'Degree Code';
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Degree Name"; Rec.Field11)
                {
                    Caption = 'Degree Name';
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Institute Code"; Rec.Field4)
                {
                    Caption = 'Institute Code';
                    ApplicationArea = All;
                    Editable = False;
                }
                field(Select; Rec.Select)
                {
                    Caption = 'Select';
                    ApplicationArea = All;

                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Get")
            {
                Caption = '&Get';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SetupList;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    InsertCourseDegree(StudentNo1, CourseCode1, GlobalDim1);
                end;

            }
            action("Assign")
            {
                Caption = '&Assign';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SetupList;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    AssignStudentDegree();
                end;

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
        // InsertCourseDegree(StudentNo1, CourseCode1, GlobalDim1);
    end;

    procedure AssignStudentDegree()
    Var
        StudentDegree: Record "Student Degree";
    begin
        Rec.RESET();
        Rec.SetFilter(Field3, '<>%1', '');
        IF Rec.FindSet() then begin
            IF Confirm('Do you want to assign Student Degree ?', true) then begin
                repeat
                    IF Rec.Select = True then begin
                        StudentDegree.Init();
                        StudentDegree."Degree Code" := Rec.Field3;
                        StudentDegree."Degree Name" := Rec.Field11;
                        StudentDegree.Validate("Global Dimension 1 Code", Rec.Field4);
                        StudentDegree.Validate("Student No.", Rec.Field5);
                        StudentDegree.DateAwarded := WorkDate();
                        StudentDegree.DateCleared := WorkDate();
                        StudentDegree.Insert(true);
                    end;
                Until Rec.Next = 0;
                Message('Done Successfully');
            end;

        end;

    end;

    procedure InsertCourseDegree(StudentNo: Code[20]; CourseCode: Code[20]; GD1: Code[20])
    var
        EntryNo: Integer;
    begin
        RecCourseDegree.Reset();
        RecCourseDegree.SetRange("Course Code", CourseCode);
        RecCourseDegree.SetRange("Global Dimension 1 Code", GD1);
        IF RecCourseDegree.findSet() THEN begin
            IF Confirm('Do you want to get Course Degree ?', true) then begin
                StudentMaster.Get(StudentNo);
                REPEAT
                    TempRecord1.Init();
                    TempRecord1."Entry No" := EntryNo;
                    TempRecord1.Field2 := RecCourseDegree."Course Code";
                    TempRecord1.Field3 := RecCourseDegree."Degree Code";
                    TempRecord1.Field11 := RecCourseDegree."Degree Name";
                    TempRecord1.Field4 := RecCourseDegree."Global Dimension 1 Code";
                    TempRecord1.Field5 := StudentMaster."No.";
                    TempRecord1.Insert();

                    Rec.Init();
                    Rec."Entry No" := TempRecord1."Entry No";
                    Rec.Field2 := TempRecord1.Field2;
                    Rec.Field3 := TempRecord1.Field3;
                    Rec.Field4 := TempRecord1.Field4;
                    Rec.Field5 := TempRecord1.Field5;
                    Rec.Field11 := TempRecord1.Field11;
                    Rec.Select := True;
                    Rec.Insert();
                    EntryNo += 1;
                Until RecCourseDegree.Next() = 0;
            end;
        end else
            Message('Course Degree data not found');

    end;

    var

        RecCourseDegree: Record "Course Degree";
        TempRecord1: Record "Temp Record" temporary;
        StudentMaster: Record "Student Master-CS";
        StudentNo1: Code[20];
        CourseCode1: Code[20];
        GlobalDim1: COde[20];


}