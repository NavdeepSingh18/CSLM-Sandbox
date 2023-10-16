page 50054 "List Assignment-CS"
{
    // version V.001-CS

    // Sr.No  Emp.Id      Date      Trigger                                          Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  10-05-19   OnOpenPage()                                    Code added for academic year wise page filter.
    // 02.   CSPL-00174  10-05-19   Release All - OnAction()                        Code added for Document Release.
    // 03.   CSPL-00174  10-05-19   Publish Students Assignment Marks - OnAction()  Code added for Student Marks publish.
    // 04.   CSPL-00174  10-05-19   Re-Open - OnAction()                            Code added for Document Re-Open..

    ApplicationArea = All;
    UsageCategory = Administration;
    CardPageID = "Header Assignment-CS";
    PageType = List;
    SourceTable = "Class Assignment Header-CS";
    DeleteAllowed = True;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Assignment No."; Rec."Assignment No.")
                {
                    ApplicationArea = All;
                }
                field("Faculty Code"; Rec."Faculty Code")
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
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("Program"; Rec."Program")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
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
                field("Subject Class"; Rec."Subject Class")
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
                field("Exam Date"; Rec."Exam Date")
                {
                    ApplicationArea = All;
                }
                field("Exam Group"; Rec."Exam Group")
                {
                    ApplicationArea = All;
                }
                field("Exam Method Code"; Rec."Exam Method Code")
                {
                    ApplicationArea = All;
                }
                field("Assignment Description"; Rec."Assignment Description")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Assignment Status"; Rec."Assignment Status")
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
            action("Create Student Assignment Line")
            {
                Image = GetLines;
                Promoted = true;
                PromotedOnly = true;
                RunObject = Page 50197;
                ApplicationArea = All;
            }
            action("Release All")
            {
                Image = ReleaseShipment;
                Promoted = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added for Document Release::CSPL-00174::100519: Start
                    IF CONFIRM(Text_10002Lbl, FALSE) THEN BEGIN
                        ClassAssignmentHeaderCS.RESET();
                        ClassAssignmentHeaderCS.SETRANGE(ClassAssignmentHeaderCS."Assignment Status", ClassAssignmentHeaderCS."Assignment Status"::Open);
                        IF ClassAssignmentHeaderCS.FINDSET() THEN
                            REPEAT
                                ClassAssignmentLineCS.RESET();
                                ClassAssignmentLineCS.SETRANGE(ClassAssignmentLineCS."Assignment No.", ClassAssignmentHeaderCS."Assignment No.");
                                IF ClassAssignmentLineCS.FINDSET() THEN
                                    REPEAT
                                        ClassAssignmentLineCS.Status := ClassAssignmentLineCS.Status::Released;
                                        ClassAssignmentLineCS.Updated := TRUE;
                                        ClassAssignmentLineCS.Modify();
                                    UNTIL ClassAssignmentLineCS.NEXT() = 0;
                                ClassAssignmentHeaderCS."Assignment Status" := ClassAssignmentHeaderCS."Assignment Status"::Released;
                                ClassAssignmentHeaderCS.Updated := TRUE;
                                ClassAssignmentHeaderCS.Modify();
                            UNTIL ClassAssignmentHeaderCS.NEXT() = 0;

                        MESSAGE('Released');
                    END;
                    //Code added for Document Release::CSPL-00174::100519: End
                end;
            }
            action("Publish Students Assignment Marks")
            {
                Image = Allocate;
                Promoted = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added for Student Marks publish::CSPL-00174::100519: Start
                    IF CONFIRM(Text_10003Lbl, FALSE) THEN BEGIN
                        ClassAssignmentHeaderCS.RESET();
                        ClassAssignmentHeaderCS.SETFILTER(ClassAssignmentHeaderCS."Exam Date", '<>%1', 0D);
                        ClassAssignmentHeaderCS.SETRANGE(ClassAssignmentHeaderCS."Assignment Status", ClassAssignmentHeaderCS."Assignment Status"::Released);
                        IF ClassAssignmentHeaderCS.FINDSET() THEN
                            REPEAT
                                ClassAssignmentLineCS.RESET();
                                ClassAssignmentLineCS.SETRANGE(ClassAssignmentLineCS."Assignment No.", ClassAssignmentHeaderCS."Assignment No.");
                                IF ClassAssignmentLineCS.FINDSET() THEN
                                    REPEAT
                                        ClassAssignmentLineCS.Status := ClassAssignmentLineCS.Status::Published;
                                        ClassAssignmentLineCS.Updated := TRUE;
                                        ClassAssignmentLineCS.Modify();
                                    UNTIL ClassAssignmentLineCS.NEXT() = 0;
                                ClassAssignmentHeaderCS."Assignment Status" := ClassAssignmentHeaderCS."Assignment Status"::Published;
                                ClassAssignmentHeaderCS.Updated := TRUE;
                                ClassAssignmentHeaderCS.Modify();
                            UNTIL ClassAssignmentHeaderCS.NEXT() = 0;

                        MESSAGE('Published');
                    END;
                    //Code added for Student Marks publish::CSPL-00174::100519: End
                end;
            }
            action("Re-Open")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added for Document Reopen ::CSPL-00174::100519: Start
                    IF CONFIRM(Text_10002Lbl, FALSE) THEN BEGIN
                        ClassAssignmentHeaderCS.RESET();
                        ClassAssignmentHeaderCS.SETRANGE(ClassAssignmentHeaderCS."Assignment Status", ClassAssignmentHeaderCS."Assignment Status"::Released);
                        IF ClassAssignmentHeaderCS.FINDSET() THEN
                            REPEAT
                                ClassAssignmentLineCS.RESET();
                                ClassAssignmentLineCS.SETRANGE(ClassAssignmentLineCS."Assignment No.", ClassAssignmentHeaderCS."Assignment No.");
                                IF ClassAssignmentLineCS.FINDSET() THEN
                                    REPEAT
                                        ClassAssignmentLineCS.Status := ClassAssignmentLineCS.Status::Open;
                                        ClassAssignmentLineCS.Updated := TRUE;
                                        ClassAssignmentLineCS.Modify();
                                    UNTIL ClassAssignmentLineCS.NEXT() = 0;
                                ClassAssignmentHeaderCS."Assignment Status" := ClassAssignmentHeaderCS."Assignment Status"::Open;
                                ClassAssignmentHeaderCS.Updated := TRUE;
                                ClassAssignmentHeaderCS.Modify();
                            UNTIL ClassAssignmentHeaderCS.NEXT() = 0;
                        MESSAGE('Re-Open');
                    END;
                    //Code added for Document Reopen ::CSPL-00174::100519: End;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Code added for academic year wise page filter::CSPL-00174::100519: Start
        EducationSetupCS.RESET();
        IF EducationSetupCS.FINDFIRST() THEN
            AddYear := EducationSetupCS."Academic Year";
        Rec.SETFILTER("Academic Year", AddYear);
        //Code added for academic year wise page filter::CSPL-00174::100519: End
    end;

    var
        ClassAssignmentHeaderCS: Record "Class Assignment Header-CS";


        ClassAssignmentLineCS: Record "Class Assignment Line-CS";
        EducationSetupCS: Record "Education Setup-CS";

        AddYear: Code[20];
        Text_10003Lbl: Label 'Do You Want To Published All Documents ?';
        Text_10002Lbl: Label 'Do You Want To Release All Documents ?';
}