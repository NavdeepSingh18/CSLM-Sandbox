page 50098 "Internal Student Hdr-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                                 Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  14-05-19   OnAfterGetRecord()                      Code added for Hide Semester/year and Validation .
    // 02.   CSPL-00174  14-05-19   OnNewRecord()                           Code added for Validation .
    // 03.   CSPL-00174  14-05-19   No. - OnAssistEdit()                    Code added for no.Series Generation   .
    // 04.   CSPL-00174  14-05-19   Course Code - OnValidate()              Code added for Hide Semester/Year and Current page Update .
    // 05.   CSPL-00174  14-05-19   Type Of Course - OnValidate()           Code added for Hide Semester/Year .
    // 06.   CSPL-00174  14-05-19   LOCAL SetControlAppearance()            Code added for Get Value of User ID and Open approval Entry Record .
    // 07.   CSPL-00174  14-05-19   LOCAL CheckLineExists()                 Code added for Validation .
    // 08.   CSPL-00174  14-05-19   Get Student - OnAction()                Code added for Validation and Get Internal Students .
    // 09.   CSPL-00174  14-05-19   Upload Internal Student - OnAction()    Code added for Upload Internal Students .
    // 10.   CSPL-00174  14-05-19   Publish Marks - OnAction()              Code added for Publish Student Internal Marks.
    // 11.   CSPL-00174  14-05-19   Internal Grade - OnAction()             Code added for Update Internal Grade.
    // 12.   CSPL-00174  14-05-19   SendApprovalRequest - OnAction()        Code added for Function Call.
    // 13.   CSPL-00174  14-05-19   Release - OnAction()                    Code added for Modify Field.
    // 14.   CSPL-00174  14-05-19   Reopen - OnAction()                     Code added for Modify Field.

    Caption = 'Internal Examination';
    DeleteAllowed = true;
    PageType = Document;
    RefreshOnActivate = true;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Internal Exam Header-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                // Editable = ReleaseDocument;
                Editable = NoChangeAllowed;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    // trigger OnAssistEdit()
                    // begin
                    //     //Code added for No.Series Generation ::CSPL-00174::140519: Start
                    //     IF Assistedit(xRec) THEN
                    //         CurrPage.Update();
                    //     //Code added for No.Series Generation ::CSPL-00174::140519: End
                    // end;
                }
                // field("Exam Schedule Code"; Rec."Exam Schedule Code")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }

                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        //Code added for Hide Semester/Year and Current page Update::CSPL-00174::140519: Start
                        // EventsOfExaminationCS.CSHideSemesterYear(HideSemseter, HideYear, Rec."Type Of Course");
                        CurrPage.Update();
                        //Code added for Hide Semester/Year and Current page Update::CSPL-00174::140519: End
                    end;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                // field("Student Group"; Rec."Student Group")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Type Of Course"; Rec."Type Of Course")
                // {
                //     ApplicationArea = All;
                //     Editable = false;

                //     trigger OnValidate()
                //     begin
                //         //Code added for Hide Semester/Year::CSPL-00174::140519: Start
                //         EventsOfExaminationCS.CSHideSemesterYear(HideSemseter, HideYear, "Type Of Course");
                //         //Code added for Hide Semester/Year::CSPL-00174::140519: End
                //     end;
                // }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                    //Editable = HideSemseter;
                }
                field("Exam Date"; Rec."Exam Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Exam Slot"; Rec."Exam Slot")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    Editable = false;
                    // Editable = HideYear;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // field(Section; Rec.Section)
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("Subject Class"; Rec."Subject Class")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Subject Type"; Rec."Subject Type")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Subject Description"; Rec."Subject Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("Exam Classification"; Rec."Exam Classification")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Maximum Mark"; Rec."Maximum Mark")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Maximum Weightage"; Rec."Maximum Weightage")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Portal ID"; Rec."Portal ID")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     Visible = false;
                // }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("Staff Code"; Rec."Staff Code")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Staff Name"; Rec."Staff Name")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Exam Type"; Rec."Exam Type")
                // {
                //     ApplicationArea = All;
                //     Visible = false;

                // }
                // field("Exam Group"; Rec."Exam Group")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Exam Method Code"; Rec."Exam Method Code")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Exam Date"; Rec."Exam Date")
                // {
                //     ApplicationArea = All;
                //     Visible = false;

                // }
                // field(Updated; Rec.Updated)
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
            }
            part("Lines"; "Internal Student SubPage-CS")
            {
                ApplicationArea = All;
                // Editable = ReleaseDocument;
                Editable = NoChangeAllowed;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Functions';
                action("Publish Marks")
                {
                    Image = Process;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        PublishMarks(Rec, 1);
                    end;
                }
                action("Student Subject Exams")
                {
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    // RunObject = Page "Student Subject Exam List";
                    // RunPageLink = "Published Document No." = field("No.");
                }
            }
            group(Report)
            {
                action("Print Student Internal Marks")
                {
                    Image = Report;
                    trigger OnAction()
                    var

                        ICMMarks: Report "ICM Scores";
                    begin
                        Clear(ICMMarks);
                        ICMMarks.Reportvariable('', Rec."No.");
                        ICMMarks.Run();

                    end;
                }
            }

            group(Release_Document)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Modify Field::CSPL-00174::140519: Start
                        //IF Status = Status::Open THEN//CODE ADDED 30-04-20
                        // ERROR(Text_10002Lbl);

                        IF Rec.Status = Rec.Status::Published THEN
                            ERROR(Text_10003Lbl);

                        IF Rec.Status = Rec.Status::Open THEN begin
                            IF CONFIRM(Text_10006Lbl, FALSE, Rec."No.") THEN BEGIN
                                CheckLineExists();
                                Rec.Status := Rec.Status::Released;
                                Rec.Updated := TRUE;
                                Rec.Modify();

                                InternalExamLineCS2.Reset();
                                InternalExamLineCS2.SETRANGE("Document No.", Rec."No.");
                                InternalExamLineCS2.SetRange(Status, InternalExamLineCS2.Status::Open);
                                IF InternalExamLineCS2.FINDSET() THEN BEGIN
                                    InternalExamLineCS2.MODIFYALL(Updated, TRUE);
                                    InternalExamLineCS2.MODIFYALL(Status, InternalExamLineCS2.Status::Released);
                                END;
                            End ELSE
                                EXIT;
                        end;
                        CurrPage.UPDATE(FALSE);
                        // Code added for Modify Field::CSPL-00174::140519: End
                    end;
                }
                action(ResetPublish)
                {
                    Caption = 'ResetPublish';
                    Image = ReOpen;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ExtExamLn: Record "Internal Exam Line-CS";
                        StudSubExam: Record "Student Subject Exam";
                    begin
                        Rec.Status := Rec.Status::Released;
                        Rec.Modify();

                        ExtExamLn.Reset();
                        ExtExamLn.SETRANGE("Document No.", Rec."No.");
                        IF ExtExamLn.FINDSET() THEN BEGIN
                            ExtExamLn.MODIFYALL(Status, ExtExamLn.Status::Released);
                            ExtExamLn.MODIFYALL(Updated, TRUE);
                        END;

                        ExtExamLn.Reset();
                        ExtExamLn.SetRange("Document No.", Rec."No.");
                        ExtExamLn.FindSet();
                        repeat
                            StudSubExam.Reset();
                            StudSubExam.SetRange("Student No.", ExtExamLn."Student No.");
                            StudSubExam.SetRange(Course, ExtExamLn.Course);
                            StudSubExam.SetRange(Semester, ExtExamLn.Semester);
                            StudSubExam.SetRange("Academic Year", ExtExamLn."Academic Year");
                            StudSubExam.SetRange("Subject Code", ExtExamLn."Subject Code");
                            StudSubExam.SetRange("Sitting Date", ExtExamLn."Exam Date");
                            StudSubExam.SetRange("Published Document No.", ExtExamLn."Document No.");
                            if StudSubExam.FindFirst() then
                                StudSubExam.Delete();

                        until ExtExamLn.Next() = 0;
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        // Code added for Modify Field::CSPL-00174::140519: Start
                        IF Rec.Status = Rec.Status::Released THEN begin
                            IF CONFIRM(Text_10005Lbl, FALSE, Rec."No.") THEN BEGIN
                                Rec.Status := Rec.Status::Open;
                                Rec.Updated := TRUE;
                                Rec.Modify();

                                InternalExamLineCS2.Reset();
                                InternalExamLineCS2.SETRANGE("Document No.", Rec."No.");
                                InternalExamLineCS2.SetRange(Status, InternalExamLineCS2.Status::Released);
                                IF InternalExamLineCS2.FINDSET() THEN BEGIN
                                    InternalExamLineCS2.MODIFYALL(Updated, TRUE);
                                    InternalExamLineCS2.MODIFYALL(Status, InternalExamLineCS2.Status::Open);
                                END;
                            End;
                            CurrPage.UPDATE(FALSE);
                        END ELSE
                            EXIT;
                        // Code added for Modify Field::CSPL-00174::140519: End
                    end;
                }

            }
        }
    }

    // trigger OnAfterGetRecord()
    // begin
    //     //Code added for Hide Semester/year and Validation  ::CSPL-00174::140519: Start
    //     EventsOfExaminationCS.CSHideSemesterYear(HideSemseter, HideYear, "Type Of Course");
    //     EventsOfExaminationCS.CSRestrictDocumentAfterRelease(Status, ReleaseDocument);
    //     SetControlAppearance();
    //     //Code added for Hide Semester/year and Validation ::CSPL-00174::140519: End
    // end;
    trigger OnOpenPage()
    begin
        //Code added for Page Editable or Non-Editable::CSPL-00174::010719: Start

        NoChangeAllowed := TRUE;
        if Rec.Status = Rec.Status::Published then
            NoChangeAllowed := false;
        //Code added for Editable or Non-Editable::CSPL-00174::010719: End
    end;

    trigger OnAfterGetCurrRecord()
    begin
        //Code added for Page Editable or Non-Editable::CSPL-00174::010719: Start

        NoChangeAllowed := TRUE;
        if Rec.Status = Rec.Status::Published then
            NoChangeAllowed := false;
        //Code added for Editable or Non-Editable::CSPL-00174::010719: End
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Code added for Validation ::CSPL-00174::140519: Start
        // EventsOfExaminationCS.CSRestrictDocumentAfterRelease(Rec.Status, ReleaseDocument);
        //Code added for Validation  ::CSPL-00174::140519: End
    end;

    var

        InternalMarksUploadCS: Record "Internal Marks Upload-CS";
        InternalExamHeaderCS: Record "Internal Exam Header-CS";
        InternalExamLineCS: Record "Internal Exam Line-CS";
        InternalExamLineCS2: Record "Internal Exam Line-CS";
        ActionMarkCS: Codeunit "Action Mark -CS";
        // EventsOfExaminationCS: Codeunit "Events Of Examination-CS";
        HideYear: Boolean;
        HideSemseter: Boolean;
        NoChangeAllowed: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ReleaseDocument: Boolean;

        Text_10001Lbl: Label 'Student Internal Exam Line does not exists.';
        //  Text_10002Lbl: Label 'This document can only be released when the approval process is complete.';

        Text_10003Lbl: Label 'The approval process must be cancelled or completed to reopen this document.';

        Text_10005Lbl: Label 'Do You Want To Open the Document No. %1 ?';
        Text_10006Lbl: Label 'Do You Want To Release the Document No. %1 ?';
        Text_10007Lbl: Label 'Do You Want To Publish the Document No. %1 ?';


    local procedure SetControlAppearance()
    var
    // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        //Code added for Get Value of User ID and Open approval Entry Record::CSPL-00174::140519: Start
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID());
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID());
        //Code added for Get Value of User ID and Open approval Entry Record::CSPL-00174::140519: End
    end;

    local procedure CheckLineExists()
    begin
        //Code added for Validation::CSPL-00174::140519: Start
        InternalExamLineCS2.Reset();
        InternalExamLineCS2.SETRANGE("Document No.", Rec."No.");
        IF InternalExamLineCS2.FINDSET() THEN begin
            REPEAT
                if InternalExamLineCS2."Exam Slot" <> '' then
                    InternalExamLineCS2.TESTFIELD(InternalExamLineCS2."Attendance Type")
                else
                    InternalExamLineCS2.TESTFIELD(InternalExamLineCS2."Attendance Type", InternalExamLineCS2."Attendance Type"::" ");
            UNTIL InternalExamLineCS2.NEXT() = 0;
        end Else
            ERROR(Text_10001Lbl);
        // Code added for Validation::CSPL-00174::140519: End
    end;

    procedure PublishMarks(IntExamHdr: Record "Internal Exam Header-CS"; InsertUpdate: Integer): Boolean
    var
        IntExamLn: Record "Internal Exam Line-CS";
        StudSubExam: Record "Student Subject Exam";
        StudSubExam2: Record "Student Subject Exam";
        CourseSem: Record "Course Sem. Master-CS";
        LineNo: Integer;
        PublishedInt: Integer;
    begin
        PublishedInt := 0;
        If InsertUpdate = 1 then begin
            if not Confirm('Do you want to publish the marks of Document No. %1 \Make sure all the students have been assigned marks in the lines', false, IntExamHdr."No.") then
                Exit(false);
            if IntExamHdr.Status = IntExamHdr.Status::Published then
                Error('Document No. %1 is already Published', IntExamHdr."No.");
            if IntExamHdr.Status = IntExamHdr.Status::Open then
                Error('Status must be Released for Document No. %1', IntExamHdr."No.");
        end;
        IntExamLn.Reset();
        IntExamLn.SetRange("Document No.", IntExamHdr."No.");
        IntExamLn.SetRange("Select To Perform", true);
        IntExamLn.FindSet();
        repeat
            IntExamLn.TestField("Student No.");
            IntExamLn.TestField("Enrollment No.");
            IntExamLn.TestField("Subject Code");
            // IntExamLn.TestField("Obtained Internal Marks");
            IntExamLn.TestField("Maximum Internal  Marks");
            // IntExamLn.TestField("Obtained Weightage");
            IntExamLn.TestField("Maximum Weightage");
            IntExamLn.TestField(Semester);
            IntExamLn.TestField("Academic Year");
            IntExamLn.TestField(Course);
            IntExamLn.TestField("Exam Date");
            //key(Key1; Rec."Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
            If InsertUpdate = 1 then begin
                StudSubExam.Reset();
                StudSubExam.SetRange("Student No.", IntExamLn."Student No.");
                StudSubExam.SetRange(Course, IntExamLn.Course);
                StudSubExam.SetRange(Semester, IntExamLn.Semester);
                StudSubExam.SetRange("Academic Year", IntExamLn."Academic Year");
                StudSubExam.SetRange(Term, IntExamLn.Term);
                StudSubExam.SetRange("Subject Code", IntExamLn."Subject Code");
                StudSubExam.SetRange("Sitting Date", IntExamLn."Exam Date");
                if StudSubExam.FindFirst() then
                    Error('Results already exist for Student No. %1, Course Course Code %2, Semester %3,Academic Year %4, Term %5 and Subject Code %6',
                    IntExamLn."Student No.", IntExamLn.Course, IntExamLn.Semester, IntExamLn."Academic Year", IntExamLn.Term, IntExamLn."Subject Code");

                StudSubExam.Reset();
                StudSubExam.SetCurrentKey("Line No.");
                StudSubExam.Ascending(true);
                StudSubExam.SetRange("Student No.", IntExamLn."Student No.");
                StudSubExam.SetRange(Course, IntExamLn.Course);
                StudSubExam.SetRange(Semester, IntExamLn.Semester);
                StudSubExam.SetRange("Academic Year", IntExamLn."Academic Year");
                StudSubExam.SetRange(Term, IntExamLn.Term);
                StudSubExam.SetRange("Subject Code", IntExamLn."Subject Code");
                if StudSubExam.FindLast() then;
                LineNo := StudSubExam."Line No." + 1;

                // Message('%1....%2', IntExamLn."Document No.", IntExamLn."Line No.");
                Clear(StudSubExam2);
                StudSubExam2.Reset();
                StudSubExam2.Init();
                StudSubExam2.Validate("Student No.", IntExamLn."Student No.");
                StudSubExam2.Validate(Course, IntExamLn.Course);
                StudSubExam2.Validate(Semester, IntExamLn.Semester);
                StudSubExam2.Validate("Academic Year", IntExamLn."Academic Year");
                StudSubExam2.Validate("Subject Code", IntExamLn."Subject Code");
                StudSubExam2.Validate(Term, IntExamLn.Term);
                StudSubExam2.validate(Year, IntExamLn.Year);
                StudSubExam2."Line No." := LineNo;
                StudSubExam2.Validate("Sitting Date", IntExamLn."Exam Date");
                StudSubExam2.Validate("Enrollment No", IntExamLn."Enrollment No.");
                StudSubExam2.Validate("Internal Mark", IntExamLn."Obtained Internal Marks");
                StudSubExam2.Validate(Total, IntExamLn."Obtained Internal Marks");
                StudSubExam2.validate("Percentage Obtained", IntExamLn."Percentage Obtained");
                StudSubExam2."Maximum Mark" := IntExamLn."Maximum Internal  Marks";
                StudSubExam2.Published := true;
                CourseSem.Reset();
                CourseSem.SetRange("Course Code", IntExamLn.Course);
                CourseSem.SetRange("Semester Code", IntExamLn.Semester);
                CourseSem.SetRange("Academic Year", IntExamLn."Academic Year");
                CourseSem.SetRange(Term, IntExamLn.Term);
                CourseSem.FindFirst();
                CourseSem.TestField("Start Date");
                CourseSem.TestField("End Date");
                StudSubExam2.Validate("Start Date", CourseSem."Start Date");
                StudSubExam2.Validate("End Date", CourseSem."End Date");
                StudSubExam2.Credit := IntExamLn."Maximum Weightage";
                StudSubExam2."Credit Earned" := IntExamLn."Obtained Weightage";
                StudSubExam2."Total Internal" := IntExamLn."Maximum Internal  Marks";
                StudSubExam2."User ID" := UserId;
                StudSubExam2."Published Document No." := IntExamLn."Document No.";
                // StudSubExam2.Internal Exam Doc No.:= IntExamLn."Document No.";
                StudSubExam2.Insert(True);
                PublishedInt += 1;
                IntExamLn.Status := IntExamLn.Status::Published;
                IntExamLn."Select To Perform" := false;
                IntExamLn."Published Document No." := IntExamLn."Document No.";
                IntExamLn.Modify();
                IntExamLn.CreateLedgerEntry(IntExamLn);
            End
            else
                if InsertUpdate = 2 then begin
                    StudSubExam.Reset();
                    StudSubExam.SetRange("Student No.", IntExamLn."Student No.");
                    StudSubExam.SetRange(Course, IntExamLn.Course);
                    StudSubExam.SetRange(Semester, IntExamLn.Semester);
                    StudSubExam.SetRange("Academic Year", IntExamLn."Academic Year");
                    StudSubExam.SetRange("Subject Code", IntExamLn."Subject Code");
                    StudSubExam.SetRange("Sitting Date", IntExamLn."Exam Date");
                    if StudSubExam.FindFirst() then begin
                        StudSubExam.Validate("Internal Mark", IntExamLn."Obtained Internal Marks");
                        StudSubExam.Validate(Total, IntExamLn."Obtained Internal Marks");
                        StudSubExam.validate("Percentage Obtained", IntExamLn."Percentage Obtained");
                        StudSubExam."Maximum Mark" := IntExamLn."Maximum Internal  Marks";
                        StudSubExam.Credit := IntExamLn."Maximum Weightage";
                        StudSubExam."Credit Earned" := IntExamLn."Obtained Weightage";
                        StudSubExam."Total Internal" := IntExamLn."Maximum Internal  Marks";

                        StudSubExam."User ID" := UserId();
                        StudSubExam."Published Document No." := IntExamLn."Document No.";
                        StudSubExam.Published := true;
                        StudSubExam.Modify(true);
                        IntExamLn.Status := IntExamLn.Status::Published;
                        IntExamLn."Select To Perform" := false;
                        IntExamLn."Published Document No." := IntExamLn."Document No.";
                        IntExamLn.Modify();
                        IntExamLn.CreateLedgerEntry(IntExamLn);
                    end
                    else
                        if (InsertUpdate < 1) or (InsertUpdate > 2) then
                            Error('Technical Error, please contact administrator');
                end;
        until IntExamLn.Next() = 0;
        If InsertUpdate = 1 then
            if PublishedInt > 0 then begin
                IntExamLn.Reset();
                IntExamLn.SetRange("Document No.", Rec."No.");
                IntExamLn.SetFilter(Status, '%1|%2', IntExamLn.Status::Open, IntExamLn.Status::Released);
                if not IntExamLn.FindFirst() then begin
                    IntExamHdr.Validate(Status, IntExamHdr.Status::Published);
                    IntExamHdr.Modify(True);
                    IntExamLn.CreateLedgerEntry(IntExamLn);
                end;

                Message('Marks have been published for Document No. %1', IntExamHdr."No.");
            end;

    end;
}

