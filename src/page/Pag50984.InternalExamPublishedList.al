page 50984 "Internal Exam Published List"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                                         Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  06-07-19   OnOpenPage()                                    Code added for Academic Year wise page filter.
    // 02.   CSPL-00174  06-07-19   Publish Students Internal Marks - OnAction()    Code added to  Publish Students Internal marks.

    Caption = 'Internal Exam Published List';
    CardPageID = "Internal Student Hdr-CS";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Internal Exam Header-CS";
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

                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }


                field("Academic Year"; Rec."Academic Year")
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
            // action("Create Student Internal Line")
            // {
            //     Image = GetLines;
            //     Promoted = true;
            //     PromotedOnly = true;
            //     RunObject = Page 50194;
            //     ApplicationArea = All;
            // }

            action("Student Subject Exams")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Student Subject Exam List";
                RunPageLink = "Published Document No." = field("No.");
            }
            // action("Publish Students Internal Marks")
            // {
            //     Image = Allocate;
            //     Promoted = true;
            //     PromotedOnly = true;
            //     Visible = false;
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     begin
            //         //Code added to  Publish Students Internal marks::CSPL-00174::060719: Start
            //         IF CONFIRM(Text_10003Lbl, FALSE) THEN BEGIN
            //             InternalExamHeaderCS.Reset();
            //             InternalExamHeaderCS.SETRANGE(Status, InternalExamHeaderCS.Status::Released);
            //             IF InternalExamHeaderCS.FINDSET() THEN
            //                 REPEAT
            //                     InternalExamLineCS.Reset();
            //                     InternalExamLineCS.SETRANGE("Document No.", InternalExamHeaderCS."No.");
            //                     IF InternalExamLineCS.FINDSET() THEN
            //                         REPEAT
            //                             InternalExamLineCS.Status := InternalExamLineCS.Status::Published;
            //                             InternalExamLineCS.Updated := TRUE;
            //                             InternalExamLineCS.MODIFY(TRUE);
            //                         UNTIL InternalExamLineCS.NEXT() = 0;
            //                     InternalExamHeaderCS.Status := InternalExamHeaderCS.Status::Published;
            //                     InternalExamHeaderCS.Updated := TRUE;
            //                     InternalExamHeaderCS.MODIFY(TRUE);
            //                 UNTIL InternalExamHeaderCS.NEXT() = 0;
            //             MESSAGE('Published');
            //         END;
            //         //Code added to  Publish Students Internal marks::CSPL-00174::060719: End
            //     end;
            // }
            // action("Release / Reopen All Documents ")
            // {
            //     Image = ReleaseShipment;
            //     Promoted = true;
            //     PromotedOnly = true;
            //     RunObject = Page 50188;
            //     ApplicationArea = All;
            // }
        }
    }

    trigger OnOpenPage()
    begin
        //Code added for Academic Year wise page filter::CSPL-00174::060719: Start
        // EducationSetupCS.Reset();
        // IF EducationSetupCS.FINDFIRST() THEN
        //     AddYear := EducationSetupCS."Academic Year";
        // SETFILTER("Academic Year", AddYear);
        //Code added for Academic Year wise page filter::CSPL-00174::060719: End
    end;

    var
        InternalExamHeaderCS: Record "Internal Exam Header-CS";
        InternalExamLineCS: Record "Internal Exam Line-CS";
        EducationSetupCS: Record "Education Setup-CS";
        AddYear: Code[20];
        Text_10003Lbl: Label 'Do You Want To Publish All Documents ?';

}