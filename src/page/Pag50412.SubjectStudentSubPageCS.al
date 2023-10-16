page 50412 "Subject Student-SP CS"
{
    Caption = 'Subject Student Subpage';
    DelayedInsert = true;
    Editable = true;
    PageType = ListPart;
    SourceTable = "Main Student Subject-CS";

    layout
    {
        area(content)
        {
            repeater(List)
            {
                Editable = EditList;
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
                field(UFM; Rec.UFM)
                {
                    ApplicationArea = All;
                }
                field(Revaluation2; Rec.Revaluation2)
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
                field(Revaluation1; Rec.Revaluation1)
                {
                    ApplicationArea = All;
                }
                field("Re-Registration"; Rec."Re-Registration")
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
                field("Internal Mark"; Rec."Internal Mark")
                {
                    ApplicationArea = All;
                }
                field("External Mark"; Rec."External Mark")
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
                field("Result With Held"; Rec.Inactive)
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
                field("Revaluation Refund"; Rec."Attendance Detail")
                {
                    Caption = 'Revaluation Refund';
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
                field(Publish; Rec.Publish)
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
                field("Total Class Held"; Rec."Total Class Held")
                {
                    ApplicationArea = All;
                }
                field("Total Attendance Taken"; Rec."Total Attendance Taken")
                {
                    ApplicationArea = All;
                }
                field("Present Count"; Rec."Present Count")
                {
                    ApplicationArea = All;
                }
                field("Absent Count"; Rec."Absent Count")
                {
                    ApplicationArea = All;
                }
                field("Subject Drop"; Rec."Subject Drop")
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
                field("Special Exam"; Rec."Special Exam")
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
                field(Specilization; Rec.Specilization)
                {
                    ApplicationArea = All;
                }
                field("Current Session"; Rec."Current Session")
                {
                    ApplicationArea = All;
                }
                field("Previous Session"; Rec."Previous Session")
                {
                    ApplicationArea = All;
                }
                field("Actual Session"; Rec."Actual Session")
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
            group(Process)
            {
                action("Subject Section Allocation")
                {
                    Image = Account;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedOnly = true;
                    RunObject = Page "List Room Allocation-CS";
                    RunPageLink = "Global Dimension 2 Code" = FIELD(Course),
                                  Course = FIELD("Academic Year"),
                                  "Subject" = FIELD("Subject Code");
                }
                // action("Exam Data Blank & UnTick")
                // {
                //     ApplicationArea = All;
                //     Image = Calculate;
                //     Promoted = true;
                //     PromotedOnly = true;
                //     PromotedIsBig = true;
                //     RunObject = Page "Un Check Student Results-CS";
                // }
                action("Grade Repeater Report")
                {
                    ApplicationArea = All;
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    RunObject = page "Results Student-CS";
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Code added to academic year wise page filter & editable or non-editable field::CSPL-00174::010119: Start
        AttendPercentageHeadCS.Reset();
        IF AttendPercentageHeadCS.FINDFIRST() THEN
            AddYear := AttendPercentageHeadCS."Academic Year";
        Rec.SETFILTER("Academic Year", AddYear);

        IF UserSetup.GET(UserId()) THEN
            IF UserSetup."Student Subject Permission" THEN
                EditList := TRUE
            ELSE
                EditList := FALSE;
        //Code added to academic year wise page filter & editable or non-editable field::CSPL-00174::010119: End
    end;

    var
        UserSetup: Record "User Setup";
        AttendPercentageHeadCS: Record "Attend Percentage Head-CS";
        EditList: Boolean;

        AddYear: Code[20];
}

