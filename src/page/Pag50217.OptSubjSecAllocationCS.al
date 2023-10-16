page 50217 "Opt. Subj Sec Allocation-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID       Date       Trigger                               Remarks
    // ----------------------------------------------------------------------------------------------------
    // 01.   CSPL-00174   05-07-19   Elective Subjects - OnAction()        Code added for run list page .
    // 02.   CSPL-00174   05-07-19   Open Elective Subjects - OnAction()   Code added for run page .

    Caption = 'Opt. Subj Sec Allocation';
    Editable = false;
    PageType = List;
    SourceTable = "Optional Student Subject-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Contents)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No"; Rec."Enrollment No")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("Roll No."; Rec."Roll No.")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Group; Rec.Group)
                {
                    ApplicationArea = All;
                }
                field(Batch; Rec.Batch)
                {
                    ApplicationArea = All;
                }
                field(Graduation; Rec.Graduation)
                {
                    ApplicationArea = All;
                }
                field("Actual Semester"; Rec."Actual Semester")
                {
                    ApplicationArea = All;
                }
                field("Actual Year"; Rec."Actual Year")
                {
                    ApplicationArea = All;
                }
                field("Actual Academic Year"; Rec."Actual Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Actual Subject Code"; Rec."Actual Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Actual Subject Description"; Rec."Actual Subject Description")
                {
                    ApplicationArea = All;
                }
                field("Internal Obtained"; Rec."Internal Obtained")
                {
                    ApplicationArea = All;
                }
                field("External Obtained"; Rec."External Obtained")
                {
                    ApplicationArea = All;
                }
                field(Total; Rec.Total)
                {
                    ApplicationArea = All;
                }
                field(Result; Rec.Result)
                {
                    ApplicationArea = All;
                }
                field("Attendance Type"; Rec."Attendance Type")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field(Completed; Rec.Completed)
                {
                    ApplicationArea = All;
                }
                field(Credit; Rec.Credit)
                {
                    ApplicationArea = All;
                }
                field("Attendance Percentage"; Rec."Attendance Percentage")
                {
                    ApplicationArea = All;
                }
                field("Attendance % as on Date"; Rec."Attendance % as on Date")
                {
                    ApplicationArea = All;
                }
                field("Maximum Mark"; Rec."Maximum Mark")
                {
                    ApplicationArea = All;
                }
                field("Percentage Obtained"; Rec."Percentage Obtained")
                {
                    ApplicationArea = All;
                }
                field(Detained; Rec.Detained)
                {
                    ApplicationArea = All;
                }
                field("Attendance Detail"; Rec."Attendance Detail")
                {
                    ApplicationArea = All;
                }
                field(Absent; Rec.Absent)
                {
                    ApplicationArea = All;
                }
                field("Main Exam Result Updated"; Rec."Main Exam Result Updated")
                {
                    ApplicationArea = All;
                }
                field("Grace Marks"; Rec."Grace Marks")
                {
                    ApplicationArea = All;
                }
                field("Re-Appear External Marks"; Rec."Re-Appear External Marks")
                {
                    ApplicationArea = All;
                }
                field("Re-Appear Total"; Rec."Re-Appear Total")
                {
                    ApplicationArea = All;
                }
                field("Re-Appear Result"; Rec."Re-Appear Result")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Credit Earned"; Rec."Credit Earned")
                {
                    ApplicationArea = All;
                }
                field("Credit Grade Points Earned"; Rec."Credit Grade Points Earned")
                {
                    ApplicationArea = All;
                }
                field("Subject Class"; Rec."Subject Class")
                {
                    ApplicationArea = All;
                }
                field("Re- Register"; Rec."Re- Register")
                {
                    ApplicationArea = All;
                }
                field(Publish; Rec.Publish)
                {
                    ApplicationArea = All;
                }
                field("Re-Registration"; Rec."Re-Registration")
                {
                    ApplicationArea = All;
                }
                field("Re-Apply"; Rec."Re-Apply")
                {
                    ApplicationArea = All;
                }
                field("Assignment Marks"; Rec."Assignment Marks")
                {
                    ApplicationArea = All;
                }
                field("Total Internal"; Rec."Total Internal")
                {
                    ApplicationArea = All;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                }
                field("Elective Group Code"; Rec."Elective Group Code")
                {
                    ApplicationArea = All;
                }
                field("Program/Open Elective Temp"; Rec."Program/Open Elective Temp")
                {
                    ApplicationArea = All;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = All;
                }
                field("Re-Registration Date"; Rec."Re-Registration Date")
                {
                    ApplicationArea = All;
                }
                field("Grade Change Type"; Rec."Grade Change Type")
                {
                    ApplicationArea = All;
                }
                field("Internal Marks Updated"; Rec."Internal Marks Updated")
                {
                    ApplicationArea = All;
                }
                field("External Marks Updated"; Rec."External Marks Updated")
                {
                    ApplicationArea = All;
                }
                field("Make Up Examination"; Rec."Make Up Examination")
                {
                    ApplicationArea = All;
                }
                field("Re-Registration Exam Only"; Rec."Re-Registration Exam Only")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Internal Maximum"; Rec."Internal Maximum")
                {
                    ApplicationArea = All;
                }
                field("External Maximum"; Rec."External Maximum")
                {
                    ApplicationArea = All;
                }
                field("Applicable Attendance per"; Rec."Applicable Attendance per")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Elective Subjects")
            {
                Image = List;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
                    SubjectElectiveListCS: Page "Subject(Elective) List -CS";

                begin
                    //Code added for run list page  ::CSPL-00174::050719: Start
                    CLEAR(SubjectElectiveListCS);
                    Rec.FILTERGROUP(2);
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", Rec.Course);
                    Rec.FILTERGROUP(0);
                    SubjectElectiveListCS.SETTABLEVIEW(CourseWiseSubjectLineCS);
                    SubjectElectiveListCS.LOOKUPMODE(TRUE);
                    SubjectElectiveListCS.SetDocCS(Rec."Student No.", Rec.Semester, Rec."Academic Year", Rec.Course, Rec.Section);
                    SubjectElectiveListCS.RUNMODAL();
                    //Code added for run list page  ::CSPL-00174::050719:End
                end;
            }
            action("Open Elective Subjects")
            {
                Image = List;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    SubjectOpenElecListCS: Page "Subject(Open Elec.) List-CS";
                begin
                    //Code added for run page ::CSPL-00174::050719: Start
                    CLEAR(SubjectOpenElecListCS);
                    SubjectOpenElecListCS.LOOKUPMODE(TRUE);
                    SubjectOpenElecListCS.SetDocCS(Rec."Student No.", Rec.Semester, Rec."Academic Year", Rec.Course, Rec.Section);
                    SubjectOpenElecListCS.RUNMODAL();
                    //Code added for run page  ::CSPL-00174::050719: End
                end;
            }
            action("Export/Import Student Opt Subject")
            {
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = XMLport 50006;
                ApplicationArea = All;
            }
        }
    }
}