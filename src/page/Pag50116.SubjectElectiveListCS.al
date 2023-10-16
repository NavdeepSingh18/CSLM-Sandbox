page 50116 "Subject(Elective) List -CS"
{
    // version V.001-CS

    // 
    // Sr.No  Emp.ID      Date      Trigger                                     Remarks
    // -------------------------------------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  08-02-19   OnQueryClosePage()                         Code added to function call.
    // 02.   CSPL-00174  08-02-19   Function-SetDocCS()                        Code added to get value of StudentNo,Semester,Course,SectionCode,AcademicYear.
    // 03.   CSPL-00174  08-02-19   Function-LOCAL ElectiveSubjectInsertCS()   Code added to insert data.

    Caption = 'Subject(Elective) List -CS';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Course Wise Subject Line-CS";
    SourceTableView = SORTING("Course Code")
                      WHERE("Subject Type" = filter('ELECTIVE' | 'AUDIT'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Specilization; Rec.Specilization)
                {
                    ApplicationArea = All;
                }
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("Combination Code"; Rec."Combination Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = All;
                }
                field("Elective Group Code"; Rec."Elective Group Code")
                {
                    ApplicationArea = All;
                }
                field(Credit; Rec.Credit)
                {
                    ApplicationArea = All;
                }
                field(Capacity; Rec.Capacity)
                {
                    ApplicationArea = All;
                }
                field("Weekly Hours"; Rec."Weekly Hours")
                {
                    ApplicationArea = All;
                }
                field("Subject Classification"; Rec."Subject Classification")
                {
                    ApplicationArea = All;
                }
                field("Preference Hours"; Rec."Preference Hours")
                {
                    ApplicationArea = All;
                }
                field("Max Hours Per Day"; Rec."Max Hours Per Day")
                {
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Internal Maximum"; Rec."Internal Maximum")
                {
                    ApplicationArea = All;
                }
                field("External Pass"; Rec."External Pass")
                {
                    ApplicationArea = All;
                }
                field("External Maximum"; Rec."External Maximum")
                {
                    ApplicationArea = All;
                }
                field("Total Pass"; Rec."Total Pass")
                {
                    ApplicationArea = All;
                }
                field("Total Maximum"; Rec."Total Maximum")
                {
                    ApplicationArea = All;
                }
                field("Exam Fee"; Rec."Exam Fee")
                {
                    ApplicationArea = All;
                }
                field("Minimum Passing Marks"; Rec."Minimum Passing Marks")
                {
                    ApplicationArea = All;
                }
                field("Student Group"; Rec."Student Group")
                {
                    ApplicationArea = All;
                }
                field("Student Batch"; Rec."Student Batch")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //Code added to function call::CSPL-00174::080219: Start
        IF CloseAction = ACTION::LookupOK THEN
             ElectiveSubjectInsertCS();
        //Code added to function call::CSPL-00174::080219: End
    end;

    var
        StudentNo1: Code[20];
        Semester1: Code[10];
        AcedmicYear1: Code[20];
        Course1: Code[20];
        SectionCode1: Code[10];

    procedure SetDocCS(StudentNo: Code[20]; Semester: Code[10]; AcedmicYear: Code[20]; Course: Code[20]; SectionCode: Code[10])
    begin
        //Code added to get value of StudentNo,Semester,Course,SectionCode,AcademicYear::CSPL-00174::080219: Start
        StudentNo1 := StudentNo;
        Semester1 := Semester;
        Course1 := Course;
        SectionCode1 := SectionCode;
        AcedmicYear1 := AcedmicYear;
        //Code added to get value of StudentNo,Semester,Course,SectionCode,AcademicYear::CSPL-00174::080219: End
    end;

    local procedure ElectiveSubjectInsertCS()
    var
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        StudentMasterCS: Record "Student Master-CS";
    begin
        //Code added to insert data::CSPL-00174::080219: Start
        CurrPage.SETSELECTIONFILTER(Rec);
        IF Rec.FINDSET() THEN
            REPEAT
                OptionalStudentSubjectCS.INIT();
                OptionalStudentSubjectCS."Student No." := StudentNo1;
                OptionalStudentSubjectCS.Course := Course1;
                OptionalStudentSubjectCS.Semester := Semester1;
                OptionalStudentSubjectCS.Section := SectionCode1;
                OptionalStudentSubjectCS."Academic Year" := AcedmicYear1;
                OptionalStudentSubjectCS."Subject Code" := Rec."Subject Code";
                OptionalStudentSubjectCS.Description := Rec.Description;
                OptionalStudentSubjectCS."Subject Type" := Rec."Subject Type";
                OptionalStudentSubjectCS."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                OptionalStudentSubjectCS."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                OptionalStudentSubjectCS."Type Of Course" := Rec."Type Of Course";
                OptionalStudentSubjectCS.Credit := Rec.Credit;
                OptionalStudentSubjectCS."Internal Maximum" := Rec."Internal Maximum";
                OptionalStudentSubjectCS."External Maximum" := Rec."External Maximum";
                IF StudentMasterCS.GET(OptionalStudentSubjectCS."Student No.") THEN
                    OptionalStudentSubjectCS."Student Name" := StudentMasterCS."Student Name";
                OptionalStudentSubjectCS.INSERT();
            UNTIL Rec.NEXT() = 0;
        //Code added to insert data::CSPL-00174::080219: End
    end;
}
