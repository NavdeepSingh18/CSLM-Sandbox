page 50038 "Header Assignment-CS"
{
    // version V.001-CS

    // Sr.No  Emp.Id      Date      Trigger                               Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  06-05-19   OnOpenPage()                         Code added for boolian field false.
    // 02.   CSPL-00174  06-05-19   OnAfterGetRecord()                   Code added for editable or non-editable.
    // 03.   CSPL-00174  06-05-19   OnNewRecord()                        Code added for document validation.
    // 04.   CSPL-00174  06-05-19   Assignment No. - OnAssistEdit()      Code added for generate No. Series .
    // 05.   CSPL-00174  06-05-19   Course Code - OnValidate()           Code added for editable or non-editable.
    // 06.   CSPL-00174  06-05-19   Type Of Course - OnValidate()        Code added for editable or non-editable.
    // 07.   CSPL-00174  06-05-19   Get Student - OnAction()             Code added for Get Student.
    // 08.   CSPL-00174  06-05-19   Assignment Submitted - OnAction()    Code added for assignment submitted.
    // 09.   CSPL-00174  06-05-19   Publish Marks - OnAction()           Code added for publish marks.
    // 10.   CSPL-00174  06-05-19   Release - OnAction()                 Code added for release document & update data.
    // 11.   CSPL-00174  06-05-19   Reopen - OnAction()                  Code added for reopen document & update data.
    // 12.   CSPL-00174  06-05-19   LOCAL AssignCalcualtion()            Code added for internal assignment calculation.
    // 13.   CSPL-00174  06-05-19   LOCAL UpdateInInternalAssignment()   Code added for update internal assignment.
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Header Assignment';
    DeleteAllowed = true;
    PageType = Card;
    SourceTable = "Class Assignment Header-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = ReleaseDocument;
                field("Assignment No."; Rec."Assignment No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        //Code added for generate No. Series ::CSPL-00174::060519: Start
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.Update();
                        //Code added for generate No. Series ::CSPL-00174::060519: End
                    end;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Code added for editable or non-editable::CSPL-00174::060519: Start
                        IF REc."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END ELSE BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                        //Code added for editable or non-editable::CSPL-00174::060519:End
                    end;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Code added for editable or non-editable::CSPL-00174::060519: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END ELSE BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                        //Code added for editable or non-editable::CSPL-00174::060519: End
                    end;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    Editable = EditableBTNYR;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = EditableBTNSEM;
                }
                field(Section; Rec.Section)
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
                field(n; Rec."Faculty Code")
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
                field("Subject Description"; Rec."Subject Description")
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
                field("Student Batch"; Rec."Student Batch")
                {
                    ApplicationArea = All;
                }
                field("Assignment Description"; Rec."Assignment Description")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Maximum Mark"; Rec."Maximum Mark")
                {
                    ApplicationArea = All;
                }
                field("Maximum Weightage"; Rec."Maximum Weightage")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Assignment Status"; Rec."Assignment Status")
                {
                    ApplicationArea = All;
                }
                field("Closed Date"; Rec."Closed Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Exam Date"; Rec."Exam Date")
                {
                    ApplicationArea = All;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                }
            }
            part("Assignment Line"; "Subform Assignment-CS")
            {
                SubPageLink = "Assignment No." = field("Assignment No.");
                Editable = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Student)
            {
                action("Get Student")
                {
                    Image = GetLines;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Get Student::CSPL-00174::060519: Start
                        Rec.Testfield(Semester);
                        Rec.Testfield("Academic Year");
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Semester THEN
                            Rec.Testfield(Semester)
                        ELSE
                            Rec.Testfield(Year);
                        Rec.Testfield("Global Dimension 1 Code");
                        Rec.Testfield(Section);
                        IF Rec."Assignment Status" = Rec."Assignment Status"::Open THEN
                            ActionMarkCS.GetStudentsCS(Rec)
                        ELSE
                            ERROR('Document Should Be Open !!');
                        //Code added for Get Student::CSPL-00174::060519: End
                    end;
                }
                action("Assignment Submitted")
                {
                    Image = StepInto;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Assignment Submitted::CSPL-00174::060519: Start
                        ClassAssignmentLineCS.Reset();
                        ClassAssignmentLineCS.SETRANGE(ClassAssignmentLineCS."Assignment No.", Rec."Assignment No.");
                        IF ClassAssignmentLineCS.FINDFIRST() THEN
                            IF Rec."Assignment Submitted" <> TRUE THEN
                                IF CONFIRM(Text002Lbl, TRUE) THEN BEGIN
                                    Rec."Assignment Submitted" := TRUE;
                                    Rec.assignmentsubmitted();
                                    Rec."Assignment Status" := Rec."Assignment Status"::Released;
                                END;
                        COMMIT();
                        UpdateInInternalAssignmentCS();
                        //Code added for Assignment Submitted::CSPL-00174::060519: End
                    end;
                }
                action("Publish Marks")
                {
                    Image = PutawayLines;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Publish Marks::CSPL-00174::060519: Start
                        Rec.Testfield("Faculty Code");
                        IF Rec."Assignment Status" = Rec."Assignment Status"::Published THEN
                            ERROR('Document No. %1 Already Published !! ', Rec."Assignment No.");
                        IF Rec."Assignment Status" = Rec."Assignment Status"::Released THEN BEGIN
                            ClassAssignmentLineCS2.Reset();
                            ClassAssignmentLineCS2.SETRANGE("Assignment No.", Rec."Assignment No.");
                            IF ClassAssignmentLineCS2.FINDSET() THEN
                                REPEAT
                                    ClassAssignmentLineCS2.Status := ClassAssignmentLineCS2.Status::Published;
                                    Rec.Updated := TRUE;
                                    ClassAssignmentLineCS2.MODIFY(TRUE);
                                UNTIL ClassAssignmentLineCS2.NEXT() = 0;
                            Rec."Assignment Status" := Rec."Assignment Status"::Published;
                            Rec.Updated := TRUE;
                            Rec.MODIFY(TRUE);
                            MESSAGE('Marks Published !!');
                        END ELSE
                            Rec.Testfield("Assignment Status", Rec."Assignment Status"::Released);
                        //Code added for Publish Marks::CSPL-00174::060519: End
                    end;
                }

                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                    //  ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        //Code added for Release Document & Update Data::CSPL-00174::060519: Start
                        IF CONFIRM(Text_10006Lbl, FALSE) THEN BEGIN
                            Rec."Assignment Status" := Rec."Assignment Status"::Released;
                            Rec.Updated := TRUE;
                            Rec.Modify();
                            ClassAssignmentLineCS2.Reset();
                            ClassAssignmentLineCS2.SETRANGE("Assignment No.", Rec."Assignment No.");
                            IF ClassAssignmentLineCS2.FINDSET() THEN BEGIN
                                ClassAssignmentLineCS2.MODIFYALL(Updated, TRUE);
                                ClassAssignmentLineCS2.MODIFYALL(Status, ClassAssignmentLineCS2.Status::Released);
                            END;

                            CurrPage.UPDATE(FALSE);
                        END ELSE
                            EXIT;
                        //Code added for Release Document & Update Data::CSPL-00174::060519: End
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                    //  ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        //Code added for Reopen Document & Update Data::CSPL-00174::060519: Start
                        IF CONFIRM(Text_10005Lbl, FALSE) THEN BEGIN
                            REc."Assignment Submitted" := FALSE;
                            Rec."Assignment Status" := Rec."Assignment Status"::Open;
                            Rec.Updated := TRUE;
                            Rec.Modify();

                            ClassAssignmentLineCS2.Reset();
                            ClassAssignmentLineCS2.SETRANGE("Assignment No.", Rec."Assignment No.");
                            IF ClassAssignmentLineCS2.FINDSET() THEN BEGIN
                                ClassAssignmentLineCS2.MODIFYALL(Updated, TRUE);
                                ClassAssignmentLineCS2.MODIFYALL(Status, ClassAssignmentLineCS2.Status::Open);
                            END;

                            CurrPage.UPDATE(FALSE);
                        END ELSE
                            EXIT;
                        //Code added for Reopen Document & Update Data::CSPL-00174::060519: End
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Code added for editable or non-editable::CSPL-00174::060519: Start
        IF REc."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
            EditableBTNSEM := FALSE;
            EditableBTNYR := TRUE;
        END ELSE BEGIN
            EditableBTNYR := FALSE;
            EditableBTNSEM := TRUE;
        END;
        // EventsOfExaminationCS.CSRestrictDocumentAfterRelease(REc."Assignment Status", ReleaseDocument);
        //Code added for editable or non-editable:CSPL-00174::060519: End
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Code added for document validation::CSPL-00174::060519: Start
        // EventsOfExaminationCS.CSRestrictDocumentAfterRelease(Rec."Assignment Status", ReleaseDocument);
        //Code added for document validation::CSPL-00174::060519: End
    end;

    trigger OnOpenPage()
    begin
        //Code added for boolian field false  ::CSPL-00174::060519: Start
        EditableBTNSEM := FALSE;
        EditableBTNYR := FALSE;
        IF Rec."Assignment Status" = Rec."Assignment Status"::Released THEN
            Bool := FALSE;
        //Code added for boolian field false ::CSPL-00174::060519: End
    end;

    var

        ClassAssignmentLineCS: Record "Class Assignment Line-CS";
        ClassAssignmentLineCS2: Record "Class Assignment Line-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        ClassAssignmentLineCS1: Record "Class Assignment Line-CS";
        InternalExamLineCS: Record "Internal Exam Line-CS";
        ClassAssignmentHeaderCS: Record "Class Assignment Header-CS";
        // EventsOfExaminationCS: Codeunit "Events Of Examination-CS";
        ActionMarkCS: Codeunit "Action Mark -CS";
        Maxmarks: Decimal;
        Bool: Boolean;
        EditableBTNSEM: Boolean;
        EditableBTNYR: Boolean;


        ReleaseDocument: Boolean;
        Text002Lbl: Label 'Do You Want To Submit Assignment ?';

        Text_10005Lbl: Label 'Do You Want To Open Document ?';
        Text_10006Lbl: Label 'Do You Want To Release Document ?';

    local procedure AssignCalcualtionCS()
    begin
        //Code added for internal assignment calculation::CSPL-00174::060519: Start
        Maxmarks := 0;
        ClassAssignmentHeaderCS.Reset();
        ClassAssignmentHeaderCS.SETRANGE("Assignment Status", ClassAssignmentHeaderCS."Assignment Status"::Released);
        ClassAssignmentHeaderCS.SETRANGE("Course Code", Rec."Course Code");
        ClassAssignmentHeaderCS.SETRANGE("Academic Year", Rec."Academic Year");
        ClassAssignmentHeaderCS.SETRANGE(Session, Rec.Session);
        ClassAssignmentHeaderCS.SETRANGE("Type Of Course", Rec."Type Of Course");
        ClassAssignmentHeaderCS.SETRANGE(Semester, Rec.Semester);
        ClassAssignmentHeaderCS.SETRANGE("Subject Type", Rec."Subject Type");
        ClassAssignmentHeaderCS.SETRANGE("Subject Code", Rec."Subject Code");
        IF ClassAssignmentHeaderCS.FINDSET() THEN
            REPEAT
                Maxmarks := Maxmarks + ClassAssignmentHeaderCS."Maximum Mark";
            UNTIL ClassAssignmentHeaderCS.NEXT() = 0;
        SubjectMasterCS.Reset();
        SubjectMasterCS.SETRANGE(Code, Rec."Subject Code");
        IF SubjectMasterCS.FINDFIRST() THEN
            IF Rec."Maximum Mark" > (SubjectMasterCS."Assign max marks" - Maxmarks) THEN
                ERROR('You Can not assign Max Marks more than %1  ', SubjectMasterCS."Assign max marks" - Maxmarks);
        //Code added for internal assignment calculation::CSPL-00174::060519: End
    end;

    local procedure UpdateInInternalAssignmentCS()
    begin
        //Code added for update internal assignment::CSPL-00174::060519: Start
        IF Rec."Assignment Status" = Rec."Assignment Status"::Released THEN BEGIN
            ClassAssignmentLineCS1.Reset();
            ClassAssignmentLineCS1.SETRANGE("Assignment No.", Rec."Assignment No.");
            IF ClassAssignmentLineCS1.FINDSET() THEN
                REPEAT
                    InternalExamLineCS.Reset();
                    InternalExamLineCS.SETRANGE(InternalExamLineCS."Student No.", ClassAssignmentLineCS1."Student No.");
                    InternalExamLineCS.SETRANGE("Type Of Course", ClassAssignmentLineCS1."Type Of Course");
                    InternalExamLineCS.SETRANGE(Section, ClassAssignmentLineCS1.Section);
                    InternalExamLineCS.SETRANGE(Semester, ClassAssignmentLineCS1.Semester);
                    InternalExamLineCS.SETRANGE("Academic Year", ClassAssignmentLineCS1."Academic Year");
                    IF InternalExamLineCS.FINDFIRST() THEN BEGIN
                        InternalExamLineCS."Assignment Marks" := InternalExamLineCS."Assignment Marks" + ClassAssignmentLineCS1."Marks Obtained";
                        InternalExamLineCS.MODIFY()
                    END;
                UNTIL ClassAssignmentLineCS1.NEXT() = 0;
        END;
        // Code added for update internal assignment::CSPL-00174::060519: End
    end;
}

