page 50985 "External Exam Published List"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                                         Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  01-07-19   OnOpenPage()                                    Code added for Academic Year wise page filter.
    // 02.   CSPL-00174  01-07-19   Grade Generation - OnAction()                   Code added for Student Grade Generation.
    // 03.   CSPL-00174  01-07-19   Calculate GPA & CGPA - OnAction()               Code added for Calculate GPA & CGPA.
    // 04.   CSPL-00174  01-07-19   Release All - OnAction()                        Code added for Modify Record.
    // 05.   CSPL-00174  01-07-19   Regular Exam Grade Allocation - OnAction()      Code added for Exam Grade Allocation.
    // 06.   CSPL-00174  01-07-19   Publish Regular Exam Result  - OnAction()       Code added for Publish Student Exam Result.
    // 07.   CSPL-00174  01-07-19   Make-Up Exam Grade Allocation - OnAction()      Code added for Make-Up Exam Grade Allocation .
    // 08.   CSPL-00174  01-07-19   Publish MakeUp Exam Result  - OnAction()        Code added for Publish Make-Up Exam Result.
    // 09.   CSPL-00174  01-07-19   Revaluation1 Exam Grade Allocation - OnAction() Code added for Revaluation Exam Grade Allocation.
    // 10.   CSPL-00174  01-07-19   Revaluation2 Exam Grade Allocation - OnAction() Code added for Revaluation Exam Grade Allocation.
    // 11.   CSPL-00174  01-07-19   Publish Revaluation1 Exam Result- OnAction()    Code added for Publish Revaluation Exam Result.
    // 12.   CSPL-00174  01-07-19   Publish Revaluation2 Exam Result  - OnAction()  Code added for Publish Revaluation Exam Result.
    // 13.   CSPL-00174  01-07-19   Spacial Exam Grade Allocation - OnAction()      Code added for Special Exam Grade Allocation.
    // 14.   CSPL-00174  01-07-19   Publish Spacial Exam Result  - OnAction()       Code added for Publish Special Exam Result.

    Caption = 'External Exam Published List';
    CardPageID = "External Student Hdr-CS";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    SourceTable = "External Exam Header-CS";
    SourceTableView = where(Status = filter(Published));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
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

                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }


                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action("Student Subject Exams")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Student Subject Exam List";
                RunPageLink = "Published Document No." = field("No.");
            }

        }
    }
    trigger OnOpenPage()
    begin
        //Code added for Academic Year wise page filter::CSPL-00174::010719: Start
        // EducationSetupCS.Reset();
        // IF EducationSetupCS.FINDFIRST() THEN
        //     AddYear := EducationSetupCS."Academic Year";
        // SETFILTER("Academic Year", AddYear);
        //Code added for Academic Year wise page filter::CSPL-00174::010719: End
    end;

    var
        /* lADOConnection: Automation;
     lADOCommand: Automation;
     lADOParameter: Automation;Rec.*/
        GradeCutoffMasterCS: Record "Grade Cutoff Master-CS";
        EducationSetupCS: Record "Education Setup-CS";
        EducationSetupCS2: Record "Education Setup-CS";
        InformationOfStudentCS: Codeunit StudentsInfoCSCSLM;
        AddYear: Code[20];
        Text0001Lbl: Label 'Do You Want To Allote Regular Exam Garde ?';
        Text0002Lbl: Label 'Do You Want To Allote Make-Up Exam Garde ?';
        Text0003Lbl: Label 'Do You Want To Allote Revaluation 1  Exam Garde ?';
        Text0004Lbl: Label 'Do You Want To Allote Spacial Exam Garde ?';
        TEXT0005Lbl: Label 'Do You Want To Generate Grade ?';
        TEXT0006Lbl: Label 'Do You Want To Allote Revaluation 2 Exam Garde ?';
        Text_10001Lbl: Label 'Do You Want To Publish Regular Exam Garde ?';
        Text_10002Lbl: Label 'Do You Want To Publish Make-Up Exam Garde ?';
        Text_10003Lbl: Label 'Do You Want To Publish Revaluation1 Exam Garde ?';
        Text_10004Lbl: Label 'Do You Want To Publish Revaluation2 Exam Garde ?';
        Text_10006Lbl: Label 'Do You Want To Publish Spacial Exam Garde ?';
        Text_10005Lbl: Label 'Do You Want To Calculate GPA & CGPA ?';
}

