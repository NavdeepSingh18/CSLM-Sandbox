page 50163 "Col Academics Setup-CS"
{
    // version V.001-CS

    Caption = 'Academics Setup';
    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Academics Setup-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = EditList;

                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Attendance No."; Rec."Attendance No.")
                {
                    ApplicationArea = All;
                }
                field("Internal Marks No."; Rec."Internal Marks No.")
                {
                    ApplicationArea = All;
                }
                field("External Marks No."; Rec."External Marks No.")
                {
                    ApplicationArea = All;
                }
                field("Common Subject Type"; Rec."Common Subject Type")
                {
                    ApplicationArea = All;
                }
                field("Attendance Code"; Rec."Attendance Code")
                {
                    ApplicationArea = All;
                }
                field("Attendance Percent No."; Rec."Attendance Percent No.")
                {
                    ApplicationArea = All;
                }
                field("Attendance Fine Entry No."; Rec."Attendance Fine Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Hall Ticket Entry No."; Rec."Hall Ticket Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Revaluation No."; Rec."Revaluation No.")
                {
                    ApplicationArea = All;
                }
                field("Revaluation Mark"; Rec."Revaluation Mark")
                {
                    ApplicationArea = All;
                }
                field("Revaluation Fees"; Rec."Revaluation Fees")
                {
                    ApplicationArea = All;
                }
                field("Re-appear No."; Rec."Re-appear No.")
                {
                    ApplicationArea = All;
                }
                field("Award List No."; Rec."Award List No.")
                {
                    ApplicationArea = All;
                }
                field("CBCS Batch"; Rec."CBCS Batch")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("CBCS Subject Type"; Rec."CBCS Subject Type")
                {
                    ApplicationArea = All;
                }
                field("Student CBCS No."; Rec."Student CBCS No.")
                {
                    ApplicationArea = All;
                }
                field("Internal Exam Group No."; Rec."Internal Exam Group No.")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal No."; Rec."Withdrawal No.")
                {
                    ApplicationArea = All;
                }
                field("Course Syllabus Header No."; Rec."Course Syllabus Header No.")
                {
                    ApplicationArea = All;
                }
                field("Faculty Scheme Planning No."; Rec."Faculty Scheme Planning No.")
                {
                    ApplicationArea = All;
                }
                field("TC No."; Rec."TC No.")
                {
                    ApplicationArea = All;
                }
                field("Exam Slot No."; Rec."Exam Slot No.")
                {
                    ApplicationArea = All;
                }
                field("Exam Schedule No."; Rec."Exam Schedule No.")
                {
                    ApplicationArea = All;
                }
                field("Examiner No."; Rec."Examiner No.")
                {
                    ApplicationArea = All;
                }
                field("Image File Directory"; Rec."Image File Directory")
                {
                    ApplicationArea = All;
                }
                field("Student Leave Application No."; Rec."Student Leave Application No.")
                {
                    ApplicationArea = All;
                }
                field("Student Promotion No."; Rec."Student Promotion No.")
                {
                    ApplicationArea = All;
                }
                field("Alumni Entry No."; Rec."Alumni Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Alumni No."; Rec."Alumni No.")
                {
                    ApplicationArea = All;
                }
                field("Alumni Meeting No."; Rec."Alumni Meeting No.")
                {
                    ApplicationArea = All;
                }
                field("Placement Register No."; Rec."Placement Register No.")
                {
                    ApplicationArea = All;
                }
                field("Placement Company No."; Rec."Placement Company No.")
                {
                    ApplicationArea = All;
                }
                field("Placement History No."; Rec."Placement History No.")
                {
                    ApplicationArea = All;
                }
                field("Placement Schedule No."; Rec."Placement Schedule No.")
                {
                    ApplicationArea = All;
                }

                field("Intership No."; Rec."Intership No.")
                {
                    ApplicationArea = All;
                }
                field("Convert to Year Semester No."; Rec."Convert to Year Semester No.")
                {
                    ApplicationArea = All;
                }
                field("MSPE No."; Rec."MSPE No.")
                {
                    ApplicationArea = All;
                }
                field("Publish Score Document No."; Rec."Publish Score Document No.")
                {
                    ApplicationArea = All;
                }
                Field("Decision Document Nos."; Rec."Decision Document Nos.")
                {
                    ApplicationArea = All;
                }
            }
            Group("Department Contact Details")
            {
                Caption = 'Department Contact Details';
                Editable = EditList;
                group("Graduate Affairs")
                {
                    Caption = 'Graduate Affairs';
                    field("E-mail ID (Graduate Affairs)"; Rec."E-mail ID (Graduate Affairs)")
                    {
                        ApplicationArea = All;
                        Caption = 'E-mail ID';
                    }
                    field("Phone No. (Graduate Affairs)"; Rec."Phone No. (Graduate Affairs)")
                    {
                        ApplicationArea = All;
                        Caption = 'Phone No.';
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        IF UserSetup.GET(UserId()) THEN
            IF UserSetup."Academic Setup Allowed" THEN
                EditList := TRUE
            ELSE
                EditList := FALSE;

    end;

    var
        UserSetup: Record "User Setup";
        EditList: Boolean;
}

