page 50015 "Detail MakeUp Exam-CS"
{
    // version V.001-CS

    // Sr.No Emp.ID       Date       Trigger                                                    Remarks
    // ------------------------------------------------------------------------------------------------------------
    // 01.   CSPL-00174   05-04-19   OnOpenPage()                                               Code added to academic year wise page filter.
    // 02.   CSPL-00174   05-04-19   After Revaluation Grade Change Not Allow Make-Up Exam()    Code added to update data.
    // 03.   CSPL-00174   05-04-19   Cancel - OnAction()                                        Code added to cancel update.

    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "MakeUp Examination-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = All;
                }
                field("Subject Class"; Rec."Subject Class")
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Name"; Rec."Subject Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field(Session; Rec.Session)
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
                field("Apply Date"; Rec."Apply Date")
                {
                    ApplicationArea = All;
                }
                field("Exam Classification"; Rec."Exam Classification")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created  Date"; Rec."Created  Date")
                {
                    ApplicationArea = All;
                }
                field("Created By Name"; Rec."Created By Name")
                {
                    ApplicationArea = All;
                }
                field("Updated By"; Rec."Updated By")
                {
                    ApplicationArea = All;
                }
                field("Updated By Name"; Rec."Updated By Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("After Revaluation Grade Change Not Allow Make-Up Exam")
            {
                Caption = 'After Revaluation Grade Change Not Allow Make-Up Exam';
                Promoted = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added for update data::CSPL-00174::050419: Start
                    EducationSetupCS.Reset();
                    IF EducationSetupCS.FINDFIRST() THEN BEGIN
                        MakeUpExaminationCS.Reset();
                        MakeUpExaminationCS.SETRANGE(MakeUpExaminationCS."Academic Year", EducationSetupCS."Academic Year");
                        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                            MakeUpExaminationCS.SETFILTER(MakeUpExaminationCS.Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII')
                        ELSE
                            MakeUpExaminationCS.SETFILTER(MakeUpExaminationCS.Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
                        IF MakeUpExaminationCS.FINDSET() THEN
                            REPEAT
                                IF MakeUpExaminationCS."Subject Type" = 'CORE' THEN BEGIN
                                    MainStudentSubjectCS.Reset();
                                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", MakeUpExaminationCS."Student No.");
                                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Academic Year", MakeUpExaminationCS."Academic Year");
                                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", MakeUpExaminationCS.Semester);
                                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Subject Code", MakeUpExaminationCS."Subject Code");
                                    MainStudentSubjectCS.SETFILTER(MainStudentSubjectCS.Grade, '%1|%2|%3|%4|%5|%6', 'A+', 'A', 'B', 'C', 'D', 'E');
                                    IF MainStudentSubjectCS.FINDFIRST() THEN BEGIN
                                        MainStudentSubjectCS."Make Up Examination" := FALSE;
                                        MainStudentSubjectCS.Updated := TRUE;
                                        MainStudentSubjectCS.Modify();
                                        MakeUpExaminationCS.Cancel := TRUE;
                                        MakeUpExaminationCS.Modify();
                                    END;
                                END ELSE BEGIN
                                    OptionalStudentSubjectCS.Reset();
                                    OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Student No.", MakeUpExaminationCS."Student No.");
                                    OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Academic Year", MakeUpExaminationCS."Academic Year");
                                    OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Actual Semester", MakeUpExaminationCS.Semester);
                                    OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Subject Code", MakeUpExaminationCS."Subject Code");
                                    OptionalStudentSubjectCS.SETFILTER(OptionalStudentSubjectCS.Grade, '%1|%2|%3|%4|%5|%6', 'A+', 'A', 'B', 'C', 'D', 'E');
                                    IF OptionalStudentSubjectCS.FINDFIRST() THEN BEGIN
                                        OptionalStudentSubjectCS."Make Up Examination" := FALSE;
                                        OptionalStudentSubjectCS.Updated := TRUE;
                                        OptionalStudentSubjectCS.Modify();
                                        MakeUpExaminationCS.Cancel := TRUE;
                                        MakeUpExaminationCS.Modify();
                                    END;
                                END;
                            UNTIL MakeUpExaminationCS.NEXT() = 0;
                    END;
                    //Code added for update data::CSPL-00174::050419:End

                    MESSAGE('DONE');
                end;
            }
            action(Cancel)
            {
                Visible = false;
                ApplicationArea = All;
                Image = Cancel;
                trigger OnAction()
                begin
                    //Code added for cancel update::CSPL-00174::050419: Start
                    MakeUpExaminationCS.Reset();
                    IF MakeUpExaminationCS.FINDSET() THEN
                        REPEAT
                            MakeUpExaminationCS.Cancel := FALSE;
                            MakeUpExaminationCS.Modify();
                        UNTIL MakeUpExaminationCS.NEXT() = 0;

                    MESSAGE('Done');
                    //Code added for cancel update::CSPL-00174::050419: End
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Code added to academic year wise page filter and editable or non-editable field::CSPL-00174::010519: Start

        UserSetup.GET(UserId());

        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        IF EducationSetupCS.FINDFIRST() THEN
            AddYear := EducationSetupCS."Academic Year";
        Rec.SETFILTER("Academic Year", AddYear);
        //Code added to academic year wise page filter and editable or non-editable field::CSPL-0017::010519: END
    end;

    var
        UserSetup: Record "User Setup";
        EducationSetupCS: Record "Education Setup-CS";
        MakeUpExaminationCS: Record "MakeUp Examination-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        AddYear: Code[20];

}