page 50101 "External Student Hdr-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                                 Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  01-07-19   OnOpenPage()                            Code added for Page Editable or Non-Editable.
    // 02.   CSPL-00174  01-07-19   OnAfterGetRecord()                      Code added for Hide Semester/Year and Document Validation.
    // 03.   CSPL-00174  01-07-19   OnNewRecord()                           Code added for Document Validation.
    // 04.   CSPL-00174  01-07-19   No. - OnAssistEdit()                    Code added for No.Series Generation.
    // 05.   CSPL-00174  01-07-19   Course Code - OnValidate()              Code added for Hide Semester/Year and current page update.
    // 06.   CSPL-00174  01-07-19   Function-LOCAL UpdateGeneratedResult()  Code added for generate Students Result.
    // 07.   CSPL-00174  01-07-19   Function-LOCAL UndoGeneratedResult()    Code added for generated Undo Students Result.
    // 08.   CSPL-00174  01-07-19   Function-LOCAL SetControlAppearance()   Code added for Get value Curr_User and Approval Entries.
    // 09.   CSPL-00174  01-07-19   Function-LOCAL CheckLineExists()        Code added for Validation.
    // 10.   CSPL-00174  01-07-19   Get Student  - OnAction()               Code added for Get Students.
    // 11.   CSPL-00174  01-07-19   Get Internal Marks - OnAction()         Code added for Get Students Internal Marks.
    // 11.   CSPL-00174  01-07-19   Generate Result - OnAction()            Code added for Generate Students Result.
    // 12.   CSPL-00174  01-07-19   Generate Grade - OnAction()             Code added for Generate Students Grade.
    // 13.   CSPL-00174  01-07-19   Publish Marks - OnAction()              Code added for Publish Students Marks.
    // 14.   CSPL-00174  01-07-19   SendApprovalRequest - OnAction()        Code added Send Approval Request.
    // 15.   CSPL-00174  01-07-19   CancelApprovalRequest - OnAction()      Code added for Cancel  Approval Request.
    // 16.   CSPL-00174  01-07-19   Release - OnAction()                    Code added for confiramtion message with Modify Record.
    // 17.   CSPL-00174  01-07-19   Ropen - OnAction()                      Code added for confiramtion message with Modify Record.

    Caption = 'External Examination';

    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "External Exam Header-CS";
    UsageCategory = Administration;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = NoChangeAllowed;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    // trigger OnAssistEdit()
                    // begin
                    //     //Code added for No.Series Generation ::CSPL-00174::010719: Start
                    //     IF Assistedit(xRec) THEN
                    //         CurrPage.Update();
                    //     //Code added for No.Series Generation ::CSPL-00174::010719: End
                    // end;
                }

                field("Term"; Rec."Term")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    //Editable = ShowSemester; Rec.
                    Editable = false;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    //Editable = ShowYear;
                    Editable = false;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Student Group"; Rec."Student Group")
                {
                    ApplicationArea = all;
                    Editable = false;
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

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Lines; "External Student Line-CS")
            {
                ApplicationArea = All;
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
                Caption = 'F&unction';
                action("Publish Marks")
                {
                    Image = Process;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    Visible = Rec.Status <> Rec.Status::Published;
                    trigger OnAction()
                    begin
                        PublishMarks(Rec, 1);
                    end;

                }
                Action("Upload MakeUp Student List")
                {
                    Image = Process;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    Visible = Rec."Exam Classification" = 'MAKEUP';
                    trigger OnAction()
                    var
                        ImportMakeUpStudent: XmlPort ImportMakeUpStudent;
                    Begin
                        Clear(ImportMakeUpStudent);
                        ImportMakeUpStudent.GetHdrDoc(Rec."No.");
                        ImportMakeUpStudent.Run();
                        CurrPage.Update();
                    End;
                }
                // action("Publish")
                // {
                //     Image = PutawayLines;
                //     Promoted = true;
                //     PromotedOnly = true;
                //     ApplicationArea = All;
                //     PromotedCategory = Process;

                //     trigger OnAction()
                //     begin
                //         //Code added for Publish Students Marks::CSPL-00174::010719: Start
                //         IF Status = Status::Published THEN
                //             ERROR('Document No. %1 Already Published !!', "No.");
                //         IF NOT CONFIRM('Do You Want To Publish The Document ?', FALSE) THEN
                //             EXIT
                //         ELSE BEGIN
                //             IF Status = Status::Released THEN begin
                //                 Status := Status::Published;
                //                 ExternalExamLineCS2.Reset();
                //                 ExternalExamLineCS2.SETRANGE("Document No.", "No.");
                //                 IF ExternalExamLineCS2.FINDSET() THEN
                //                     ExternalExamLineCS2.MODIFYALL(Status, ExternalExamLineCS2.Status::Published);
                //             end ELSE
                //                 ERROR('Document No. %1 Should Be Released !!', "No.");
                //             //Code added for Publish Students Marks::CSPL-00174::010719: End
                //         end;
                //     End;
                // }
                // action("Grade Calculation")
                // {
                //     ApplicationArea = All;
                //     Promoted = true;
                //     trigger OnAction()
                //     Var
                //         GradeCal: Page "Grade Calculation";

                //     begin
                //         GradeCal.Run();

                //     end;
                // }

            }
            group(Report)
            {
                action("Print Student External Marks")
                {
                    Image = Report;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    trigger OnAction()
                    var

                        ExtMarks: Report "Student Marks";
                    begin
                        Clear(ExtMarks);
                        //(Inst: code[20]; Rec.EnrollNo: Code[2048]; Rec.Course: Code[20]; Rec.AcaYear: Code[20]; Rec.PublishedDocNo: Code[20])
                        ExtMarks.Reportvariable('', '', '', '', Rec."No.");
                        ExtMarks.Run();
                    end;
                }
            }
            group("Release Document")
            {
                Caption = 'Release';
                Image = ReleaseDoc;

                action(Release)
                {
                    Caption = 'Release';
                    ApplicationArea = All;
                    Image = ReleaseDoc;
                    Promoted = true;
                    Visible = Rec.Status <> Rec.Status::Published;
                    PromotedOnly = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //Code added for Confirmation Message with Modify Record::CSPL-00174::010719: Start
                        IF NOT CONFIRM('Do You Want To Release The Document No. %1?', FALSE, Rec."No.") THEN
                            EXIT
                        ELSE BEGIN
                            IF Rec.Status = Rec.Status::Open THEN begin
                                Rec.Status := Rec.Status::Released;
                                Rec.Modify();

                                ExternalExamLineCS.Reset();
                                ExternalExamLineCS.SETRANGE("Document No.", Rec."No.");
                                ExternalExamLineCS.SetRange(Status, ExternalExamLineCS.Status::Open);
                                IF ExternalExamLineCS.FINDSET() THEN BEGIN
                                    ExternalExamLineCS.MODIFYALL(Status, ExternalExamLineCS.Status::Released);
                                    ExternalExamLineCS.MODIFYALL(Updated, TRUE);
                                END;
                                CurrPage.UPDATE(TRUE);
                            END ELSE
                                ERROR('Document No. %1 Should Be Open !!', Rec."No.");
                            //Code added for Confirmation Message with Modify Record::CSPL-00174::010719: End
                        end;
                    End;
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
                        ExtExamLn: Record "External Exam Line-CS";
                        StudSubExam: Record "Student Subject Exam";
                    begin
                        Rec.Status := Rec.Status::Released;
                        Rec.Modify();

                        ExternalExamLineCS.Reset();
                        ExternalExamLineCS.SETRANGE("Document No.", Rec."No.");
                        IF ExternalExamLineCS.FINDSET() THEN BEGIN
                            ExternalExamLineCS.MODIFYALL(Status, ExternalExamLineCS.Status::Released);
                            ExternalExamLineCS.MODIFYALL(Updated, TRUE);
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
                action(ReOpen)
                {
                    Caption = 'ReOpen';
                    Image = ReOpen;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedOnly = true;
                    Visible = Rec.Status <> Rec.Status::Published;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //Code added for Confirmation Message with Modify Record::CSPL-00174::010719: Start
                        IF Rec.Status = Rec.Status::Published THEN
                            ERROR(Text_10004Lbl);

                        IF NOT CONFIRM('Do You Want To ReOpen The Document ?', FALSE) THEN
                            EXIT
                        ELSE BEGIN
                            Rec.Status := Rec.Status::Open;
                            Rec.MODIFY();
                            ExternalExamLineCS.RESET();
                            ExternalExamLineCS.SETRANGE("Document No.", Rec."No.");
                            ExternalExamLineCS.SetRange(Status, ExternalExamLineCS.Status::Released);
                            IF ExternalExamLineCS.FINDSET() THEN BEGIN
                                ExternalExamLineCS.MODIFYALL(Status, ExternalExamLineCS.Status::Open);
                                ExternalExamLineCS.MODIFYALL(Updated, TRUE);
                            END;
                            CurrPage.UPDATE(TRUE);
                        END;

                        //Code added for Confirmation Message with Modify Record::CSPL-00174::010719: End
                    end;
                }
                action("Student Exam Line(s)")
                {
                    Caption = 'Student Exam Line(s)';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedOnly = true;
                    Visible = Rec.Status = Rec.Status::Published;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        StudExam: Record "Student Subject Exam";
                        StudExamLst: Page "Student Subject Exam List";
                    begin
                        StudExam.Reset();
                        StudExam.SetFilter("Published Document No.", Rec."No.");
                        if StudExam.FindSet() then begin
                            Clear(StudExamLst);
                            StudExamLst.SetTableView(StudExam);
                            StudExamLst.Run();
                        end;

                    end;
                }
            }
        }
    }

    // trigger OnAfterGetRecord()
    // begin
    //     //Code added for Hide Semester/Year and Document Validation ::CSPL-00174::010719: Start
    //     // EventsOfExaminationCS.CSHideSemesterYear(ShowSemester, ShowYear, "Type Of Course");
    //     // EventsOfExaminationCS.CSRestrictDocumentAfterRelease(Status, NoChangeAllowed);
    //     //Code added for Hide Semester/Year and Document Validation ::CSPL-00174::010719: End
    // end;

    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     //Code added for Document Validation ::CSPL-00174::010719: Start
    //     EventsOfExaminationCS.CSRestrictDocumentAfterRelease(Status, NoChangeAllowed);
    //     //Code added for Document Validation ::CSPL-00174::010719: End
    // end;

    trigger OnOpenPage()
    begin
        //Code added for Page Editable or Non-Editable::CSPL-00174::010719: Start

        NoChangeAllowed := TRUE;
        if Rec.Status = Rec.Status::Published then
            NoChangeAllowed := false;

        ShowMakeUpUpload := false;
        IF Rec."Exam Classification" = 'MAKEUP' then
            ShowMakeUpUpload := true;
        //Code added for Editable or Non-Editable::CSPL-00174::010719: End
    end;

    trigger OnAfterGetCurrRecord()
    begin
        //Code added for Page Editable or Non-Editable::CSPL-00174::010719: Start

        NoChangeAllowed := TRUE;
        if Rec.Status = Rec.Status::Published then
            NoChangeAllowed := false;

        ShowMakeUpUpload := false;
        IF Rec."Exam Classification" = 'MAKEUP' then
            ShowMakeUpUpload := true;
        //Code added for Editable or Non-Editable::CSPL-00174::010719: End
    end;

    var
        ExternalExamLineCS: Record "External Exam Line-CS";
        ClassAttendanceHeaderCS: Record "Class Attendance Header-CS";
        InternalExamHeaderCS: Record "Internal Exam Header-CS";
        AttendPercentageHeadCS: Record "Attend Percentage Head-CS";
        AttendPercentageLineCS: Record "Attend Percentage Line-CS";
        SessionalExamGroupHeadCS: Record "Sessional Exam Group Head-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        ExternalExamLineCS2: Record "External Exam Line-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        // EventsOfExaminationCS: Codeunit "Events Of Examination-CS";
        ActionMarkCS: Codeunit "Action Mark -CS";
        AttendanceActionCS: Codeunit "Attendance Action-CS";
        Text10001Lbl: Label 'The current sheet is released.Kindly ReOpen to do any changes.';
        Text10002Lbl: Label 'The data generated sucessfully...';
        ShowSemester: Boolean;
        ShowYear: Boolean;

        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        Text_10001Lbl: Label 'Student Internal Exam Line does not exists.';

        NoChangeAllowed: Boolean;
        Text_10004Lbl: Label 'You Can''t  ReOpen The Document .If Document Is Published !!';
        ShowMakeUpUpload: Boolean;

    /* lADOConnection: Automation;
    lADOCommand: Automation;
    lADOParameter: Automation;*/



    local procedure UpdateGeneratedResult()
    begin
        //Code added for generated Students Result ::CSPL-00174::010719: Start
        ExternalExamLineCS2.Reset();
        ExternalExamLineCS2.SETRANGE("Document No.", Rec."No.");
        IF ExternalExamLineCS2.FINDSET() THEN
            REPEAT
                IF Rec."Subject Type" = 'CORE' THEN BEGIN
                    MainStudentSubjectCS.Reset();
                    IF MainStudentSubjectCS.GET(ExternalExamLineCS2."Student No.", ExternalExamLineCS2.Course, ExternalExamLineCS2.Semester,
                        ExternalExamLineCS2."Academic year", ExternalExamLineCS2."Subject Code",
                        ExternalExamLineCS2.Section)
                    THEN BEGIN
                        MainStudentSubjectCS."Internal Mark" := ExternalExamLineCS2."Internal Mark";
                        MainStudentSubjectCS."External Mark" := ExternalExamLineCS2."External Mark";
                        MainStudentSubjectCS.Total := ExternalExamLineCS2.Total;
                        MainStudentSubjectCS.Result := ExternalExamLineCS2.Result;
                        MainStudentSubjectCS."Attendance Type" := ExternalExamLineCS2."Attendance Type";
                        IF ExternalExamLineCS2."Rev. Grade" = '' THEN
                            MainStudentSubjectCS.Grade := ExternalExamLineCS2."Std. Grade"
                        ELSE
                            MainStudentSubjectCS.Grade := ExternalExamLineCS2."Rev. Grade";
                        MainStudentSubjectCS."Maximum Mark" := ExternalExamLineCS2."Total Maximum";
                        MainStudentSubjectCS."Percentage Obtained" := ExternalExamLineCS2."Percentage Obtained";
                        MainStudentSubjectCS.Absent := ExternalExamLineCS2.Absent;
                        MainStudentSubjectCS.Detained := ExternalExamLineCS2.Detained;
                        MainStudentSubjectCS.Dropped := ExternalExamLineCS2.Dropped;
                        MainStudentSubjectCS.UFM := ExternalExamLineCS2.UFM;
                        MainStudentSubjectCS."Main Exam Result Updated" := TRUE;
                        MainStudentSubjectCS.Points := ExternalExamLineCS2.Points;
                        MainStudentSubjectCS.Modify();
                    END;
                END ELSE BEGIN
                    OptionalStudentSubjectCS.Reset();
                    IF OptionalStudentSubjectCS.GET(ExternalExamLineCS2."Student No.", ExternalExamLineCS2.Course, ExternalExamLineCS2.Semester,
                        ExternalExamLineCS2."Academic year", ExternalExamLineCS2."Subject Code", ExternalExamLineCS2.Section) THEN BEGIN
                        IF ExternalExamLineCS2."Rev. Grade" = '' THEN
                            OptionalStudentSubjectCS.Grade := ExternalExamLineCS2."Std. Grade"
                        ELSE
                            OptionalStudentSubjectCS.Grade := ExternalExamLineCS2."Rev. Grade";
                        OptionalStudentSubjectCS."Internal Obtained" := ExternalExamLineCS2."Internal Mark";
                        OptionalStudentSubjectCS."External Obtained" := ExternalExamLineCS2."External Mark";
                        OptionalStudentSubjectCS."Grace Marks" := ExternalExamLineCS2."Grace Marks";
                        OptionalStudentSubjectCS.Modify();
                    END;
                END;
            UNTIL ExternalExamLineCS2.NEXT() = 0;

        // updating the Result in all previous tables
        ClassAttendanceHeaderCS.Reset();
        ClassAttendanceHeaderCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
        ClassAttendanceHeaderCS.SETRANGE("Course Code", Rec."Course Code");
        ClassAttendanceHeaderCS.SETRANGE(Semester, Rec.Semester);
        ClassAttendanceHeaderCS.SETRANGE(Section, Rec.Section);
        ClassAttendanceHeaderCS.SETRANGE("Academic Year", Rec."Academic Year");
        ClassAttendanceHeaderCS.SETRANGE("Subject Type", Rec."Subject Type");
        ClassAttendanceHeaderCS.SETRANGE("Subject Code", Rec."Subject Code");
        ClassAttendanceHeaderCS.SETRANGE("Result Generated", FALSE);
        ClassAttendanceHeaderCS.MODIFYALL("Result Generated", TRUE);

        InternalExamHeaderCS.Reset();
        InternalExamHeaderCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
        InternalExamHeaderCS.SETRANGE("Course Code", Rec."Course Code");
        InternalExamHeaderCS.SETRANGE(Semester, Rec.Semester);
        InternalExamHeaderCS.SETRANGE(Section, Rec.Section);
        InternalExamHeaderCS.SETRANGE("Academic Year", Rec."Academic Year");
        InternalExamHeaderCS.SETRANGE("Subject Type", Rec."Subject Type");
        InternalExamHeaderCS.SETRANGE("Subject Code", Rec."Subject Code");
        InternalExamHeaderCS.SETRANGE("Result Generated", FALSE);
        InternalExamHeaderCS.MODIFYALL("Result Generated", TRUE);

        AttendPercentageHeadCS.Reset();
        AttendPercentageHeadCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
        AttendPercentageHeadCS.SETRANGE("Course Code", Rec."Course Code");
        AttendPercentageHeadCS.SETRANGE(Semester, Rec.Semester);
        AttendPercentageHeadCS.SETRANGE(Section, Rec.Section);
        AttendPercentageHeadCS.SETRANGE("Academic Year", Rec."Academic Year");
        AttendPercentageHeadCS.SETRANGE("Subject Type", Rec."Subject Type");
        AttendPercentageHeadCS.SETRANGE("Subject Code", Rec."Subject Code");
        AttendPercentageHeadCS.SETRANGE("Result Generated", FALSE);
        AttendPercentageHeadCS.MODIFYALL("Result Generated", TRUE);

        AttendPercentageLineCS.Reset();
        AttendPercentageLineCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
        AttendPercentageLineCS.SETRANGE("Course Code", Rec."Course Code");
        AttendPercentageLineCS.SETRANGE(Semester, Rec.Semester);
        AttendPercentageLineCS.SETRANGE(Section, Rec.Section);
        AttendPercentageLineCS.SETRANGE("Academic Year", Rec."Academic Year");
        AttendPercentageLineCS.SETRANGE("Subject Type", Rec."Subject Type");
        AttendPercentageLineCS.SETRANGE("Subject Code", Rec."Subject Code");
        AttendPercentageLineCS.SETRANGE("Result Generated", FALSE);
        AttendPercentageLineCS.MODIFYALL("Result Generated", TRUE);

        SessionalExamGroupHeadCS.Reset();
        SessionalExamGroupHeadCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
        SessionalExamGroupHeadCS.SETRANGE("Course Code", Rec."Course Code");
        SessionalExamGroupHeadCS.SETRANGE(Semester, Rec.Semester);
        SessionalExamGroupHeadCS.SETRANGE(Section, Rec.Section);
        SessionalExamGroupHeadCS.SETRANGE("Academic Year", Rec."Academic Year");
        SessionalExamGroupHeadCS.SETRANGE("Subject Type", Rec."Subject Type");
        SessionalExamGroupHeadCS.SETRANGE("Subject Code", Rec."Subject Code");
        SessionalExamGroupHeadCS.SETRANGE("Result Generated", FALSE);
        SessionalExamGroupHeadCS.MODIFYALL("Result Generated", TRUE);
        //Code added for generated Students Result ::CSPL-00174::010719: End
    end;

    local procedure UndoGeneratedResult()
    begin
        //Code added for generated Undo Students Result ::CSPL-00174::010719: Start
        ExternalExamLineCS2.Reset();
        ExternalExamLineCS2.SETRANGE("Document No.", Rec."No.");
        IF ExternalExamLineCS2.FINDSET() THEN
            REPEAT
                IF Rec."Subject Type" = 'CORE' THEN BEGIN
                    MainStudentSubjectCS.Reset();
                    IF MainStudentSubjectCS.GET(ExternalExamLineCS2."Student No.", ExternalExamLineCS2.Course, ExternalExamLineCS2.Semester,
                        ExternalExamLineCS2."Academic year", ExternalExamLineCS2."Subject Code",
                        ExternalExamLineCS2.Section)
                    THEN BEGIN
                        MainStudentSubjectCS."Internal Mark" := 0;
                        MainStudentSubjectCS."External Mark" := 0;
                        MainStudentSubjectCS.Total := 0;
                        MainStudentSubjectCS.Result := MainStudentSubjectCS.Result::" ";
                        MainStudentSubjectCS."Attendance Type" := ExternalExamLineCS2."Attendance Type"::" ";
                        MainStudentSubjectCS.Grade := '';
                        MainStudentSubjectCS."Maximum Mark" := 0;
                        MainStudentSubjectCS."Percentage Obtained" := 0;
                        MainStudentSubjectCS.Absent := FALSE;
                        MainStudentSubjectCS.Detained := FALSE;
                        MainStudentSubjectCS.Dropped := FALSE;
                        MainStudentSubjectCS.UFM := FALSE;
                        MainStudentSubjectCS."Main Exam Result Updated" := FALSE;
                        MainStudentSubjectCS.Points := 0;
                        MainStudentSubjectCS.Modify();
                    END;
                END ELSE BEGIN
                    OptionalStudentSubjectCS.Reset();
                    IF OptionalStudentSubjectCS.GET(ExternalExamLineCS2."Student No.", ExternalExamLineCS2.Course, ExternalExamLineCS2.Semester,
                        ExternalExamLineCS2."Academic year", ExternalExamLineCS2."Subject Code", ExternalExamLineCS2.Section) THEN BEGIN
                        OptionalStudentSubjectCS.Grade := '';
                        OptionalStudentSubjectCS."Internal Obtained" := 0;
                        ;
                        OptionalStudentSubjectCS."External Obtained" := 0;
                        ;
                        OptionalStudentSubjectCS."Grace Marks" := 0;
                        ;
                        OptionalStudentSubjectCS.Modify();
                    END;
                END;
            UNTIL ExternalExamLineCS2.NEXT() = 0;

        ClassAttendanceHeaderCS.Reset();
        ClassAttendanceHeaderCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
        ClassAttendanceHeaderCS.SETRANGE("Course Code", Rec."Course Code");
        ClassAttendanceHeaderCS.SETRANGE(Semester, Rec.Semester);
        ClassAttendanceHeaderCS.SETRANGE(Section, Rec.Section);
        ClassAttendanceHeaderCS.SETRANGE("Academic Year", Rec."Academic Year");
        ClassAttendanceHeaderCS.SETRANGE("Subject Type", Rec."Subject Type");
        ClassAttendanceHeaderCS.SETRANGE("Subject Code", Rec."Subject Code");
        ClassAttendanceHeaderCS.SETRANGE("Result Generated", TRUE);
        ClassAttendanceHeaderCS.MODIFYALL("Result Generated", FALSE);

        InternalExamHeaderCS.Reset();
        InternalExamHeaderCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
        InternalExamHeaderCS.SETRANGE("Course Code", Rec."Course Code");
        InternalExamHeaderCS.SETRANGE(Semester, Rec.Semester);
        InternalExamHeaderCS.SETRANGE(Section, Rec.Section);
        InternalExamHeaderCS.SETRANGE("Academic Year", Rec."Academic Year");
        InternalExamHeaderCS.SETRANGE("Subject Type", Rec."Subject Type");
        InternalExamHeaderCS.SETRANGE("Subject Code", Rec."Subject Code");
        InternalExamHeaderCS.SETRANGE("Result Generated", TRUE);
        InternalExamHeaderCS.MODIFYALL("Result Generated", FALSE);

        AttendPercentageHeadCS.Reset();
        AttendPercentageHeadCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
        AttendPercentageHeadCS.SETRANGE("Course Code", Rec."Course Code");
        AttendPercentageHeadCS.SETRANGE(Semester, Rec.Semester);
        AttendPercentageHeadCS.SETRANGE(Section, Rec.Section);
        AttendPercentageHeadCS.SETRANGE("Academic Year", Rec."Academic Year");
        AttendPercentageHeadCS.SETRANGE("Subject Type", Rec."Subject Type");
        AttendPercentageHeadCS.SETRANGE("Subject Code", Rec."Subject Code");
        AttendPercentageHeadCS.SETRANGE("Result Generated", TRUE);
        AttendPercentageHeadCS.MODIFYALL("Result Generated", FALSE);

        AttendPercentageLineCS.Reset();
        AttendPercentageLineCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
        AttendPercentageLineCS.SETRANGE("Course Code", Rec."Course Code");
        AttendPercentageLineCS.SETRANGE(Semester, Rec.Semester);
        AttendPercentageLineCS.SETRANGE(Section, Rec.Section);
        AttendPercentageLineCS.SETRANGE("Academic Year", Rec."Academic Year");
        AttendPercentageLineCS.SETRANGE("Subject Type", Rec."Subject Type");
        AttendPercentageLineCS.SETRANGE("Subject Code", Rec."Subject Code");
        AttendPercentageLineCS.SETRANGE("Result Generated", TRUE);
        AttendPercentageLineCS.MODIFYALL("Result Generated", FALSE);

        SessionalExamGroupHeadCS.Reset();
        SessionalExamGroupHeadCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
        SessionalExamGroupHeadCS.SETRANGE("Course Code", Rec."Course Code");
        SessionalExamGroupHeadCS.SETRANGE(Semester, Rec.Semester);
        SessionalExamGroupHeadCS.SETRANGE(Section, Rec.Section);
        SessionalExamGroupHeadCS.SETRANGE("Academic Year", Rec."Academic Year");
        SessionalExamGroupHeadCS.SETRANGE("Subject Type", Rec."Subject Type");
        SessionalExamGroupHeadCS.SETRANGE("Subject Code", Rec."Subject Code");
        SessionalExamGroupHeadCS.SETRANGE("Result Generated", TRUE);
        SessionalExamGroupHeadCS.MODIFYALL("Result Generated", FALSE);

        Rec."Result Generated" := FALSE;
        Rec.Modify();
        //Code added for generated Undo Students Result::CSPL-00174::010719: End
    end;

    [IntegrationEvent(false, false)]
    local procedure GenerateGrade(StudentExternalHeaderCOL: Record "External Exam Header-CS")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnReleaseReOpen(StudentExternalHeaderCOL: Record "External Exam Header-CS")
    begin
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        //Code added for Get value of Curr_User and Approval Entries::CSPL-00174::010719: Start
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID());
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID());
        //Code added for Get value of Curr_User and Approval Entries ::CSPL-00174::010719: End
    end;

    local procedure CheckLineExists()
    begin
        //Code added for Validation ::CSPL-00174::010719: Start
        ExternalExamLineCS2.Reset();
        ExternalExamLineCS2.SETRANGE("Document No.", Rec."No.");
        IF NOT ExternalExamLineCS2.FINDFIRST() THEN
            ERROR(Text_10001Lbl);
        IF ExternalExamLineCS2.FINDSET() THEN
            REPEAT
                ExternalExamLineCS2.TESTFIELD("Attendance Type");
            UNTIL ExternalExamLineCS2.NEXT() = 0;
        //Code added for Validation::CSPL-00174::010719: End
    end;

    procedure PublishMarks(ExtExamHdr: Record "External Exam Header-CS"; InsertUpdate: Integer): Boolean
    var
        ExtExamLn: Record "External Exam Line-CS";
        StudSubExam: Record "Student Subject Exam";
        SubjMaster: Record "Subject Master-CS";
        StudSubExam2: Record "Student Subject Exam";
        CourseSem: Record "Course Sem. Master-CS";
        LineNo: Integer;
        PublishedExt: Integer;
    begin
        PublishedExt := 0;
        If InsertUpdate = 1 then begin
            if not Confirm('Do you want to publish the marks of Document No. %1 \Make sure all the students have been assigned marks in the lines', false, ExtExamHdr."No.") then
                Exit(false);
            if ExtExamHdr.Status = ExtExamHdr.Status::Published then
                Error('Document No. %1 is already Published', ExtExamHdr."No.");
            if ExtExamHdr.Status = ExtExamHdr.Status::Open then
                Error('Status must be Released for Document No. %1', ExtExamHdr."No.");
        End;

        ExtExamLn.Reset();
        ExtExamLn.SetRange("Document No.", ExtExamHdr."No.");
        ExtExamLn.SetRange("Select To Perform", True);
        ExtExamLn.FindSet();
        repeat
            ExtExamLn.TestField("Student No.");
            ExtExamLn.TestField("Enrollment No.");
            ExtExamLn.TestField("Subject Code");
            // ExtExamLn.TestField("External Mark");
            ExtExamLn.TestField("Total Maximum");
            // ExtExamLn.TestField("Obtained Weightage");
            ExtExamLn.TestField("Maximum Weightage");
            ExtExamLn.TestField(Semester);
            ExtExamLn.TestField("Academic Year");
            ExtExamLn.TestField(Course);
            ExtExamLn.TestField("Exam Date");

            SubjMaster.Reset();
            SubjMaster.SetRange(code, Rec."Subject Code");
            SubjMaster.FindFirst();
            if SubjMaster."Exam Record Not Required" then begin
                PublishedExt := 1;
                ExtExamLn.Status := ExtExamLn.Status::Published;
                ExtExamLn."Select To Perform" := false;
                if SubjMaster."Exam Schedule" then
                    ExtExamLn."Published Document No." := ExtExamLn."Document No.";
                ExtExamLn.Modify();
                ExtExamLn.CreateLedgerEntry(ExtExamLn);
            end
            else begin

                //"Student No.", Course, Semester, "Academic Year", "Subject Code", Section, "Line No."
                If InsertUpdate = 1 then begin
                    StudSubExam.Reset();
                    StudSubExam.SetRange("Student No.", ExtExamLn."Student No.");
                    StudSubExam.SetRange(Course, ExtExamLn.Course);
                    StudSubExam.SetRange(Semester, ExtExamLn.Semester);
                    StudSubExam.SetRange("Academic Year", ExtExamLn."Academic Year");
                    StudSubExam.SetRange(Term, ExtExamLn.Term);
                    StudSubExam.SetRange("Subject Code", ExtExamLn."Subject Code");
                    StudSubExam.SetRange("Sitting Date", ExtExamLn."Exam Date");
                    if StudSubExam.FindFirst() then
                        Error('Results already exist for Student No. %1, Course Course Code %2, Semester %3,Academic Year %4, Term %5 and Subject Code %6',
                        ExtExamLn."Student No.", ExtExamLn.Course, ExtExamLn.Semester, ExtExamLn."Academic Year", ExtExamLn.Term, ExtExamLn."Subject Code");


                    StudSubExam.Reset();
                    StudSubExam.SetCurrentKey("Line No.");
                    StudSubExam.Ascending(true);
                    StudSubExam.SetRange("Student No.", ExtExamLn."Student No.");
                    StudSubExam.SetRange(Course, ExtExamLn.Course);
                    StudSubExam.SetRange(Semester, ExtExamLn.Semester);
                    StudSubExam.SetRange("Academic Year", ExtExamLn."Academic Year");
                    StudSubExam.SetRange(Term, ExtExamLn.Term);
                    StudSubExam.SetRange("Subject Code", ExtExamLn."Subject Code");
                    if StudSubExam.FindLast() then;
                    LineNo := StudSubExam."Line No." + 1;


                    Clear(StudSubExam2);
                    StudSubExam2.Reset();
                    StudSubExam2.Init();
                    StudSubExam2.Validate("Student No.", ExtExamLn."Student No.");
                    StudSubExam2.Validate(Course, ExtExamLn.Course);
                    StudSubExam2.Validate(Semester, ExtExamLn.Semester);
                    StudSubExam2.Validate("Academic Year", ExtExamLn."Academic Year");
                    StudSubExam2.Validate("Subject Code", ExtExamLn."Subject Code");
                    StudSubExam2.Validate(Term, ExtExamLn.Term);
                    StudSubExam2.validate(Year, ExtExamLn.Year);
                    StudSubExam2."Line No." := LineNo;
                    StudSubExam2.Validate("Sitting Date", ExtExamLn."Exam Date");
                    StudSubExam2.Validate("Enrollment No", ExtExamLn."Enrollment No.");
                    StudSubExam2.Validate("External Mark", ExtExamLn."External Mark");
                    StudSubExam2.Validate(Total, ExtExamLn."External Mark");
                    StudSubExam2.validate("Percentage Obtained", ExtExamLn."Percentage Obtained");
                    StudSubExam2."Maximum Mark" := ExtExamLn."Total Maximum";
                    StudSubExam2.Published := true;
                    CourseSem.Reset();
                    CourseSem.SetRange("Course Code", ExtExamLn.Course);
                    CourseSem.SetRange("Semester Code", ExtExamLn.Semester);
                    CourseSem.SetRange("Academic Year", ExtExamLn."Academic Year");
                    CourseSem.SetRange(Term, ExtExamLn.Term);
                    CourseSem.FindFirst();
                    CourseSem.TestField("Start Date");
                    CourseSem.TestField("End Date");
                    StudSubExam2.Validate("Start Date", CourseSem."Start Date");
                    StudSubExam2.Validate("End Date", CourseSem."End Date");
                    StudSubExam2.Credit := ExtExamLn."Maximum Weightage";
                    StudSubExam2."Credit Earned" := ExtExamLn."Obtained Weightage";
                    StudSubExam2."External Mark" := ExtExamLn."External Mark";
                    StudSubExam2."Maximum Mark" := ExtExamLn."Total Maximum";
                    StudSubExam2."User ID" := UserId();
                    StudSubExam2."Published Document No." := ExtExamLn."Document No.";
                    // StudSubExam2.External Exam Doc No.:= ExtExamLn."Document No.";

                    StudSubExam2.Insert(True);
                    PublishedExt += 1;
                    ExtExamLn.Status := ExtExamLn.Status::Published;
                    ExtExamLn."Select To Perform" := false;
                    ExtExamLn."Published Document No." := ExtExamLn."Document No.";
                    ExtExamLn.Modify();
                    ExtExamLn.CreateLedgerEntry(ExtExamLn);
                End
                else
                    if InsertUpdate = 2 then begin
                        StudSubExam.Reset();
                        StudSubExam.SetRange("Student No.", ExtExamLn."Student No.");
                        StudSubExam.SetRange(Course, ExtExamLn.Course);
                        StudSubExam.SetRange(Semester, ExtExamLn.Semester);
                        StudSubExam.SetRange("Academic Year", ExtExamLn."Academic Year");
                        StudSubExam.SetRange("Subject Code", ExtExamLn."Subject Code");
                        StudSubExam.SetRange("Sitting Date", ExtExamLn."Exam Date");
                        if StudSubExam.FindFirst() then begin
                            StudSubExam.Credit := ExtExamLn."Maximum Weightage";
                            StudSubExam."Credit Earned" := ExtExamLn."Obtained Weightage";
                            StudSubExam."External Mark" := ExtExamLn."External Mark";
                            StudSubExam."Maximum Mark" := ExtExamLn."Total Maximum";
                            StudSubExam."User ID" := UserId();
                            StudSubExam."Published Document No." := ExtExamLn."Document No.";
                            StudSubExam.Published := true;
                            StudSubExam.Modify(true);
                            ExtExamLn.Status := ExtExamLn.Status::Published;
                            ExtExamLn."Select To Perform" := false;
                            ExtExamLn."Published Document No." := ExtExamLn."Document No.";
                            ExtExamLn.Modify();
                            ExtExamLn.CreateLedgerEntry(ExtExamLn);
                        end;
                    end
                    else
                        if (InsertUpdate < 1) or (InsertUpdate > 2) then
                            Error('Technical Error, please contact administrator');
            end;

        until ExtExamLn.Next() = 0;

        If InsertUpdate = 1 then
            if PublishedExt > 0 then begin

                ExtExamLn.Reset();
                ExtExamLn.SetRange("Document No.", Rec."No.");
                ExtExamLn.SetFilter(Status, '%1|%2', ExtExamLn.Status::Open, ExtExamLn.Status::Released);
                if not ExtExamLn.FindFirst() then begin
                    ExtExamHdr.Validate(Status, ExtExamHdr.Status::Published);
                    ExtExamHdr.Modify(True);
                end;
                // ExtExamLn.ModifyAll(Status, Status::Published);

                Message('Marks have been published for Document No. %1', ExtExamHdr."No.");
            end;
    end;

    // procedure PublishMarksIntoStudExam(ExtExamLn: Record "External Exam Line-CS"): Boolean
    // var
    //     StudSubExam: Record "Student Subject Exam";
    //     StudSubExam2: Record "Student Subject Exam";
    //     CourseSem: Record "Course Sem. Master-CS";
    //     LineNo: Integer;
    //     PublishedExt: Integer;
    // begin
    //     PublishedExt := 0;

    //     // ExtExamLn.Reset();
    //     // ExtExamLn.SetRange("Document No.", ExtExamHdr."No.");
    //     // ExtExamLn.FindSet();
    //     // repeat
    //     ExtExamLn.TestField("Student No.");
    //     ExtExamLn.TestField("Enrollment No.");
    //     ExtExamLn.TestField("Subject Code");
    //     // ExtExamLn.TestField("External Mark");
    //     ExtExamLn.TestField("Total Maximum");
    //     // ExtExamLn.TestField("Obtained Weightage");
    //     // ExtExamLn.TestField("Maximum Weightage");
    //     ExtExamLn.TestField(Semester);
    //     ExtExamLn.TestField("Academic Year");
    //     ExtExamLn.TestField(Course);
    //     ExtExamLn.TestField("Exam Date");
    //     //key(Key1; Rec."Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
    //     // StudSubExam.Reset();
    //     // StudSubExam.SetRange("Student No.", ExtExamLn."Student No.");
    //     // StudSubExam.SetRange(Course, ExtExamLn.Course);
    //     // StudSubExam.SetRange(Semester, ExtExamLn.Semester);
    //     // StudSubExam.SetRange("Academic Year", ExtExamLn."Academic Year");
    //     // StudSubExam.SetRange("Subject Code", ExtExamLn."Subject Code");
    //     // StudSubExam.SetRange("Sitting Date", ExtExamLn."Exam Date");

    //     // if StudSubExam.FindFirst() then
    //     //     Error('Results already exist for Student No. %1, Course Course Code %2, Semester %3,Academic Year %4 and Subject Code %5',
    //     //     ExtExamLn."Student No.", ExtExamLn.Course, ExtExamLn.Semester, ExtExamLn."Academic Year", ExtExamLn."Subject Code");

    //     StudSubExam.Reset();
    //     StudSubExam.SetCurrentKey("Line No.");
    //     StudSubExam.Ascending(true);
    //     StudSubExam.SetRange("Student No.", ExtExamLn."Student No.");
    //     StudSubExam.SetRange(Course, ExtExamLn.Course);
    //     StudSubExam.SetRange(Semester, ExtExamLn.Semester);
    //     StudSubExam.SetRange("Academic Year", ExtExamLn."Academic Year");
    //     StudSubExam.SetRange(Term, ExtExamLn.Term);
    //     StudSubExam.SetRange("Subject Code", ExtExamLn."Subject Code");
    //     if StudSubExam.FindLast() then;
    //     LineNo := StudSubExam."Line No." + 1;


    //     Clear(StudSubExam2);
    //     StudSubExam2.Reset();
    //     StudSubExam2.Init();
    //     StudSubExam2.Validate("Student No.", ExtExamLn."Student No.");
    //     StudSubExam2.Validate(Course, ExtExamLn.Course);
    //     StudSubExam2.Validate(Semester, ExtExamLn.Semester);
    //     StudSubExam2.Validate("Academic Year", ExtExamLn."Academic Year");
    //     StudSubExam2.Validate("Subject Code", ExtExamLn."Subject Code");
    //     StudSubExam2.Validate(Term, ExtExamLn.Term);
    //     StudSubExam2.validate(Year, ExtExamLn.Year);
    //     StudSubExam2."Line No." := LineNo;
    //     StudSubExam2.Validate("Sitting Date", ExtExamLn."Exam Date");
    //     StudSubExam2.Validate("Enrollment No", ExtExamLn."Enrollment No.");
    //     StudSubExam2.Validate("External Mark", ExtExamLn."External Mark");
    //     StudSubExam2.Validate(Total, ExtExamLn."External Mark");
    //     StudSubExam2.validate("Percentage Obtained", ExtExamLn."Percentage Obtained");
    //     StudSubExam2."Maximum Mark" := ExtExamLn."Total Maximum";
    //     CourseSem.Reset();
    //     CourseSem.SetRange("Course Code", ExtExamLn.Course);
    //     CourseSem.SetRange("Semester Code", ExtExamLn.Semester);
    //     CourseSem.SetRange("Academic Year", ExtExamLn."Academic Year");
    //     CourseSem.SetRange(Term, ExtExamLn.Term);
    //     CourseSem.FindFirst();
    //     CourseSem.TestField("Start Date");
    //     CourseSem.TestField("End Date");
    //     StudSubExam2.Validate("Start Date", CourseSem."Start Date");
    //     StudSubExam2.Validate("End Date", CourseSem."End Date");
    //     StudSubExam2.Credit := ExtExamLn."Maximum Weightage";
    //     StudSubExam2."Credit Earned" := ExtExamLn."Obtained Weightage";
    //     StudSubExam2."External Mark" := ExtExamLn."External Mark";
    //     StudSubExam2."Maximum Mark" := ExtExamLn."Total Maximum";
    //     StudSubExam2."User ID" := UserId;
    //     StudSubExam2."Published Document No." := ExtExamLn."Document No.";
    //     // StudSubExam2.External Exam Doc No.:= ExtExamLn."Document No.";
    //     StudSubExam2.Insert(True);
    //     PublishedExt += 1;


    //     // until ExtExamLn.Next() = 0;
    //     // if PublishedExt > 0 then begin
    //     //     ExtExamHdr.Validate(Status, ExtExamHdr.Status::Published);
    //     //     ExtExamHdr.Modify(True);
    //     //     Message('Marks have been published for Document No. %1', ExtExamHdr."No.");
    //     // end;
    // end;
}