page 50263 "Time Tbl Hdr-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                               Remarks
    // 1         CSPL-00092    11-05-2019    OnOpenPage                            Hide Columns.
    // 2         CSPL-00092    11-05-2019    OnNextRecord                          Hide Columns
    // 3         CSPL-00092    11-05-2019    OnAfterGetRecord                      Restrict Document  After Release
    // 4         CSPL-00092    11-05-2019    OnNewRecord                           Hide Columns, Assign Data in Fields and Restrict Document  After Release
    // 5         CSPL-00092    11-05-2019    No. - OnAssistEdit                    Select No Series
    // 6         CSPL-00092    11-05-2019    Open Elective - OnValidate            Hide Columns
    // 7         CSPL-00092    11-05-2019    Year - OnValidate                     Hide Columns
    // 8         CSPL-00092    11-05-2019    TestStudentBatch                      Check Student Batch
    // 9         CSPL-00092    11-05-2019    TestDuplicacyForFaculty               Find Duplicacy For Faculty
    // 10        CSPL-00092    11-05-2019    TestDuplicacyForRoom                  Find Duplicacy For Room
    // 11        CSPL-00092    11-05-2019    Generate - OnAction                   Generate Time Table
    // 12        CSPL-00092    11-05-2019    Time Table Update                     Update Time Table
    // 13        CSPL-00092    11-05-2019    Release For Update - OnAction         Check Validation and Change Status Release For Updation
    // 13        CSPL-00092    11-05-2019    Reopen For Update - OnAction          Change Status Open for Updation

    //ApplicationArea = All;
    UsageCategory = None;
    Caption = 'Time Table Detail';
    PageType = Document;
    SourceTable = "Class Time Table Header-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = ReleaseDocument;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        //Code added for Select No Series::CSPL-00092::11-05-2019: Start
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.Update();
                        //Code added for Select No Series::CSPL-00092::11-05-2019: End
                    end;
                }


                field(Course; Rec.Course)
                {
                    ApplicationArea = All;

                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                    Editable = Bool;
                    Visible = False;
                }
                field("Room No."; Rec."Room No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Institude Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Institude Code';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Program"; Rec."Program")
                {
                    ApplicationArea = All;
                    Editable = Bool;
                    Visible = False;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    //Enabled = Bool;

                    trigger OnValidate()
                    begin
                        //Code added for Hide Columns::CSPL-00092::11-05-2019: Start
                        // IF ("Program" = 'UG') AND (Year = '1ST') THEN
                        //     Bool := FALSE
                        // ELSE
                        //     Bool := TRUE;
                        //Code added for Hide Columns::CSPL-00092::11-05-2019: End
                    end;
                }
                field(Group; Rec.Group)
                {
                    ApplicationArea = All;
                    Editable = Bool;
                    Visible = false;
                }

                field("Level 1 Subject Code"; Rec."Level 1 Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Level 1 Subject Description"; Rec."Level 1 Subject Description")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Department Code';
                    Visible = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Template Code"; Rec."Template Code")
                {
                    ApplicationArea = All;
                    //Editable = Bool;
                    trigger OnValidate()
                    begin
                        TemplateCodeShow := False;
                        If Rec."Template Code" <> '' then
                            TemplateCodeShow := True;

                        TemplateCodeNotShow := false;
                        If Rec."Template Code" = '' then
                            TemplateCodeNotShow := true;
                        CurrPage.Update(true);
                    end;
                }
                field("Template Name"; Rec."Template Name")
                {
                    ApplicationArea = All;
                }
                field("Time Table Status"; Rec."Time Table Status")
                {
                    ApplicationArea = All;
                }

            }
            part("Time Tbl SubPage-CS"; "Time Tbl SubPage-CS")
            {
                Editable = ReleaseDocument;
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            // part("Time Table Buffer List"; "Time Table Buffer List")
            // {
            //     //Editable = ReleaseDocument;
            //     SubPageLink = "Time Table Document No." = Field("No.");
            //     ApplicationArea = All;

            // }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Option)
            {
                Caption = 'Option';
                action("Line Upload")
                {
                    ApplicationArea = All;
                    Caption = 'Time Table Line Upload';
                    Promoted = true;
                    Promotedonly = True;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Process;
                    Visible = TemplateCodeNotShow;
                    trigger OnAction()
                    var
                        UploadTimeTableLineXml: XMLPORT "Upload Time Table Line";
                    begin
                        Rec.TestField("No.");
                        Rec.TestField("Academic Year");
                        Rec.TestField("Global Dimension 1 Code");
                        Rec.TestField(Course);
                        Rec.TestField(Semester);
                        Clear(UploadTimeTableLineXml);
                        UploadTimeTableLineXml.GetTimeTableNo(Rec."No.", Rec.Section, Rec.Course);
                        UploadTimeTableLineXml.Run();
                    end;
                }
                Action("Export Line")
                {
                    ApplicationArea = All;
                    Caption = 'Export Time Table Line';
                    Promoted = true;
                    Promotedonly = True;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Process;
                    Visible = TemplateCodeShow;

                    trigger OnAction()
                    var
                        ClassTimetableLine: Record "Class Time Table Line-CS";
                        TimeTableLineReport: Report TimetableLine;
                    Begin
                        Clear(TimeTableLineReport);
                        ClassTimetableLine.Reset();
                        ClassTimetableLine.SetRange("Document No.", Rec."No.");
                        TimetablelineReport.SetTableView(ClassTimetableLine);
                        TimeTableLineReport.DocumentNoFilter(Rec."No.");
                        TimeTableLineReport.TimeTableLineFilter(true);
                        TimeTableLineReport.Run();

                    End;

                }
                action("Line Uploads")
                {
                    ApplicationArea = All;
                    Caption = 'Time Table Line Upload';
                    Promoted = true;
                    Promotedonly = True;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Process;
                    Visible = TemplateCodeShow;
                    // trigger OnAction()
                    // var
                    //     TimeTableTemplateHdr: Record "Time Table Template Head-CS";
                    //     UploadTimeTableLineXml: Report "Time Table Line Upload";
                    //     UploadLabTimeTableLine: Report "Time Table (LAB)";
                    // begin
                    //     Clear(UploadTimeTableLineXml);
                    //     Clear(UploadLabTimeTableLine);
                    //     //UploadTimeTableLineXml.GetTimeTableNo("No.", Section, Course);

                    //     TimeTableTemplateHdr.Reset();
                    //     TimeTableTemplateHdr.SetRange("No.", Rec."Template Code");
                    //     TimeTableTemplateHdr.SetRange("With Topic Code", true);
                    //     If TimeTableTemplateHdr.FindFirst() then
                    //         UploadTimeTableLineXml.Run()
                    //     Else
                    //         UploadLabTimeTableLine.Run();
                    // end;
                }

                /*    action(Edit)
                    {
                        Caption = 'Edit ';
                        Image = UpdateDescription;
                        ApplicationArea = All;
                        Promoted = true;
                        PromotedOnly = true;
                        trigger OnAction()
                        begin
                            //
                        end;

                    }*/

                action("Time Table Upload")
                {
                    ApplicationArea = All;
                    Caption = 'Final Time Table Upload';
                    Promoted = true;
                    Promotedonly = True;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Process;
                    //Visible = false;
                    trigger OnAction()
                    var
                        FinalTimeTableXml: XMLPORT "Final Time Table Upload";
                    begin
                        Rec.TestField("No.");
                        Rec.TestField(Course);
                        Rec.TestField(Semester);
                        Rec.TestField("Global Dimension 1 Code");
                        FinalTimeTableXml.GetTimeTableNo(Rec."No.", Rec.Section, Rec.Course, Rec."Academic Year", Rec.Semester, Rec."Global Dimension 1 Code", Rec.Term, Rec.Year);
                        FinalTimeTableXml.Run();
                    end;
                }


                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        TimeTableLine: Record "Class Time Table Line-CS";
                        Txt001Lbl: Label 'Do you want to Release Document No. %1 ?';
                        Txt002Lbl: Label 'Document No. %1 has been Released.';
                    begin
                        If Confirm(Txt001Lbl, false, Rec."No.") then begin
                            // TestDuplicacyForRoom();
                            // TestStudentBatch();
                            IF (Rec."Time Table Status" = Rec."Time Table Status"::Open) THEN BEGIN
                                TimeTableLine.Reset();
                                TimeTableLine.SetRange("Document No.", Rec."No.");
                                TimeTableLine.SetFilter("Subject Code", '<>%1', '');
                                if not TimeTableLine.FindFirst() then
                                    Error('Time Table Can not be blank.');

                                Rec."Time Table Status" := Rec."Time Table Status"::Released;
                                Rec.Modify();
                            END;
                            Message(Txt002Lbl, Rec."No.");
                        end else
                            exit;
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Txt001Lbl: Label 'Do you want to Re-Open Document No. %1 ?';
                        Txt002Lbl: Label 'Document No. %1 has been Re-Open.';
                    begin
                        If Confirm(Txt001Lbl, false, Rec."No.") then begin
                            IF Rec."Time Table Status" = Rec."Time Table Status"::Released THEN BEGIN
                                Rec."Time Table Status" := Rec."Time Table Status"::Open;
                                Rec.Modify();
                            END ELSE
                                IF Rec."Time Table Status" = Rec."Time Table Status"::Generated THEN
                                    ERROR('Generated Time Table Cannot Be Open !!');
                            Message(Txt002Lbl, Rec."No.");
                        end else
                            exit;

                    end;
                }


                action(Generate)        //Abhishek
                {
                    Image = Create;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    Var
                        Txt001Lbl: Label 'Do you want to Generate the Time Table for Document No. %1 ?';

                    begin
                        //Code added for Generate Time Table::CSPL-00092::11-05-2019: Start
                        If Confirm(Txt001Lbl, false, Rec."No.") then begin
                            FinalClassTimeTableCS.Reset();
                            FinalClassTimeTableCS.SETRANGE("Time Table  Document No.", Rec."No.");
                            IF FinalClassTimeTableCS.FINDFIRST() THEN
                                ERROR('This Document already Generated');

                            IF Rec."Time Table Status" <> Rec."Time Table Status"::Released THEN
                                ERROR('Time Table Is Not Released !!');

                            IF Not Rec."Using TTBuffer" then begin
                                Rec.CheckFinalTimeTable(Rec);
                                Rec.ReGenerateFinalTimeTable(Rec);
                            end Else
                                Rec.CreateFinalTimeTable(Rec);
                        end else
                            exit;
                        //Code added for generate Time Table::CSPL-00092::11-05-2019: End
                    end;
                }
                action("Release For Update")
                {
                    Image = Reuse;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    Var
                        Txt001Lbl: Label 'Do you want to Release the Generated Time Table ?';
                        Txt002Lbl: Label 'Generated Time Table has been Release for Updation.';
                    begin
                        //Code added for Check Validation and Change Status Release For Updation::CSPL-00092::11-05-2019: Start
                        // TestDuplicacyForRoom();
                        // TestStudentBatch();
                        IF CONFIRM(Txt001Lbl, FALSE) THEN BEGIN
                            IF Rec."Time Table Status" = Rec."Time Table Status"::"Open for Updation" THEN BEGIN
                                Rec."Time Table Status" := Rec."Time Table Status"::"Release For Updation";
                                Rec.Modify();
                            END;
                            Message(Txt002Lbl);
                        END ELSE
                            EXIT;
                        //Code added for Check Validation and Change Status Release For Updation::CSPL-00092::11-05-2019: End
                    end;
                }
                action("Reopen For Update")
                {
                    Image = ChangeLog;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Txt001Lbl: Label 'Do you want to Re-Open the Generated Time Table ?';
                        Txt002Lbl: Label 'Generated Time Table has been Re-Open for Updation.';
                    begin
                        //Code added for Change Status Open for Updation::CSPL-00092::11-05-2019: Start
                        IF CONFIRM(Txt001Lbl, FALSE) THEN BEGIN
                            IF (Rec."Time Table Status" = Rec."Time Table Status"::Generated) OR (Rec."Time Table Status" = Rec."Time Table Status"::"Release For Updation") THEN BEGIN
                                Rec."Time Table Status" := Rec."Time Table Status"::"Open for Updation";
                                Rec.Modify();
                            END;
                            Message(Txt002Lbl);
                        END ELSE
                            EXIT;
                        //Code added for Change Status Open for Updation::CSPL-00092::11-05-2019: End
                    end;
                }
                action("Regenerate Time Table")
                {
                    Image = UnlimitedCredit;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var

                    begin
                        //Code added for Update Time Table::CSPL-00092::11-05-2019: Start
                        IF UserSetup.GET(UserId()) THEN BEGIN
                            IF UserSetup."Student Subject Permission" THEN
                                IF CONFIRM(Text_10002Lbl, FALSE) THEN BEGIN
                                    IF Rec."Time Table Status" = Rec."Time Table Status"::"Release For Updation" THEN BEGIN
                                        If not Rec."Using TTBuffer" then begin
                                            Rec.CheckFinalTimeTable(Rec);
                                            Rec.ReGenerateFinalTimeTable(Rec);
                                        end Else
                                            Rec.CreateFinalTimeTable(Rec);
                                    END ELSE
                                        ERROR('Time Table is not Released For Updation !!');
                                END ELSE
                                    EXIT;
                        END ELSE
                            ERROR('You do not have Permission to update Time Table.');
                        //Code added for Update Time Table::CSPL-00092::11-05-2019: End
                    end;

                }


                action("Time Table Buffer List")
                {
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Time Table Buffer List";
                    ApplicationArea = All;
                    Visible = false;
                    RunPageLink = "Time Table Document No." = FIELD("No.");
                }
                action("Time Table Buffer Approve")
                {
                    Image = Approve;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    Var
                    begin
                        CopyTableData()
                    end;
                }



                action("Time Table")
                {
                    Caption = 'Generated Time Table List';
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Time Tbl Detail-CS";
                    ApplicationArea = All;
                    RunPageLink = "Time Table  Document No." = FIELD("No.");
                }
                action("Course Faculty List")
                {
                    Image = Line;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Faculty-Course Wise";
                    ApplicationArea = All;
                    Visible = false;
                }
                action("Time Table Report")
                {
                    Image = "Report";
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(ClassTimeTableHeaderCS);
                        "REPORT".RUN(50015, TRUE, TRUE, ClassTimeTableHeaderCS);
                    end;
                }
            }

        }
    }

    trigger OnAfterGetRecord()
    begin
        //Code added for Restrict Document  After Release::CSPL-00092::11-05-2019: Start
        // EventsOfExaminationCS.CSRestrictDocumentAfterRelease(Rec."Time Table Status", ReleaseDocument);
        //Code added for Restrict Document  After Release::CSPL-00092::11-05-2019: End
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //     //Code added for Hide Columns Assign Data in Fields and Restrict Document  After Release::CSPL-00092::11-05-2019: Start
        Bool := TRUE;

        //     // EducationSetupCS.GET();
        //     // "Academic Year" := EducationSetupCS."Academic Year";
        //     // "Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
        //     //Modify();
        // EventsOfExaminationCS.CSRestrictDocumentAfterRelease(Rec."Time Table Status", ReleaseDocument);
        TemplateCodeShow := False;
        If Rec."Template Code" <> '' then
            TemplateCodeShow := True;

        TemplateCodeNotShow := false;
        If Rec."Template Code" = '' then
            TemplateCodeNotShow := true;
        //     //Code added for Hide Column Assign Data in Fields and Restrict Document  After Release::CSPL-00092::11-05-2019: End
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        //Code added for Hide Columns::CSPL-00092::11-05-2019: Start
        Bool := TRUE;
        // EventsOfExaminationCS.CSRestrictDocumentAfterRelease(Rec."Time Table Status", ReleaseDocument);
        //Code added for Hide Columns::CSPL-00092::11-05-2019: End
    end;

    trigger OnOpenPage()
    begin
        //Code added for Hide Columns::CSPL-00092::11-05-2019: Start
        Bool := TRUE;
        TemplateCodeShow := False;
        If Rec."Template Code" <> '' then
            TemplateCodeShow := True;

        TemplateCodeNotShow := false;
        If Rec."Template Code" = '' then
            TemplateCodeNotShow := true;
        //Code added for Hide Columns::CSPL-00092::11-05-2019: End
    end;

    var

        /* lADOConnection: Automation;
        lADOCommand: Automation;
        lADOParameter: Automation; Rec.*/

        FinalClassTimeTableCS: Record "Final Class Time Table-CS";
        EducationSetupCS: Record "Education Setup-CS";
        ClassTimeTableHeaderCS: Record "Class Time Table Header-CS";

        UserSetup: Record "User Setup";
        // EventsOfExaminationCS: Codeunit "Events Of Examination-CS";
        ReleaseDocument: Boolean;
        Bool: Boolean;
        Text_10001Lbl: label '%1 already assigned for same day %2 and Time Slot %3 and Document No. %4  !!';
        Text_10002Lbl: Label 'Do you want to update Generated Time Table ?';
        TemplateCodeShow: Boolean;
        TemplateCodeNotShow: Boolean;


    procedure TestStudentBatch()
    var
        // Student: Record "Student Master-CS";
        TimeTableLine: Record "Class Time Table Line-CS";

    begin
        //Code added for Check Student Batch::CSPL-00092::11-05-2019: Start
        TimeTableLine.Reset();
        TimeTableLine.SETRANGE("Document No.", Rec."No.");
        TimeTableLine.SETRANGE(Interval, FALSE);
        TimeTableLine.SETRANGE("OverRide Validation", FALSE);
        IF TimeTableLine.FINDSET() THEN
            REPEAT
                TimeTableLine.TESTFIELD(TimeTableLine."Subject Code");
                IF NOT TimeTableLine.Elective THEN BEGIN
                    TimeTableLine.TESTFIELD(TimeTableLine."Room No");
                    TimeTableLine.TESTFIELD(TimeTableLine."Faculty 1 Code");

                    IF TimeTableLine."Faculty 1 Code" <> '' THEN BEGIN
                        TimeTableLine.TESTFIELD(TimeTableLine."Faculty 1 Start Date");
                        TimeTableLine.TESTFIELD(TimeTableLine."Faculty 1 End Date");
                    END;

                    IF TimeTableLine."Faculty 2 Code" <> '' THEN BEGIN
                        TimeTableLine.TESTFIELD(TimeTableLine."Faculty 2 Start Date");
                        TimeTableLine.TESTFIELD(TimeTableLine."Faculty 2 End Date");
                    END;

                    IF TimeTableLine."Faculty 3 Code" <> '' THEN BEGIN
                        TimeTableLine.TESTFIELD(TimeTableLine."Faculty 3 Start Date");
                        TimeTableLine.TESTFIELD(TimeTableLine."Faculty 3 End Date");
                    END;

                    IF TimeTableLine."Faculty 4 Code" <> '' THEN BEGIN
                        TimeTableLine.TESTFIELD(TimeTableLine."Faculty 4 Start Date");
                        TimeTableLine.TESTFIELD(TimeTableLine."Faculty 4 End Date");
                    END;
                END;
            UNTIL TimeTableLine.NEXT() = 0;
        //Code added for Check Student Batch::CSPL-00092::11-05-2019: End
    end;

    procedure TestDuplicacyForFaculty()
    var

        TimeTableLine: Record "Class Time Table Line-CS";
        TimeTableLine1: Record "Class Time Table Line-CS";

    begin
        //Code added for Find Duplicacy For Faculty::CSPL-00092::11-05-2019: Start
        TimeTableLine.Reset();
        TimeTableLine.SETRANGE("Document No.", Rec."No.");
        TimeTableLine.SETRANGE("OverRide Validation", FALSE);
        TimeTableLine.SETRANGE(Interval, FALSE);
        IF TimeTableLine.FINDSET() THEN
            REPEAT
                IF TimeTableLine."Faculty 1 Code" <> '' THEN BEGIN
                    TimeTableLine1.Reset();
                    TimeTableLine1.SETFILTER("Document No.", '<>%1', TimeTableLine."Document No.");
                    TimeTableLine1.SETFILTER("Faculty 1 Start Date", '>=%1', TimeTableLine."Faculty 1 Start Date");
                    TimeTableLine1.SETFILTER("Faculty 1 End Date", '<=%1', TimeTableLine."Faculty 1 End Date");
                    TimeTableLine1.SETRANGE(Day, TimeTableLine.Day);
                    TimeTableLine1.SETRANGE("Time Slot", TimeTableLine."Time Slot");
                    IF TimeTableLine1.FINDFIRST() THEN
                        IF (TimeTableLine1."Faculty 1 Code" = TimeTableLine1."Faculty 1 Code") OR (TimeTableLine1."Faculty 2 Code" = TimeTableLine1."Faculty 1 Code")
                        OR (TimeTableLine1."Faculty 3 Code" = TimeTableLine1."Faculty 1 Code") OR (TimeTableLine1."Faculty 4 Code" = TimeTableLine1."Faculty 1 Code") THEN
                            ERROR(Text_10001Lbl, TimeTableLine1."Faculty 1 Code", TimeTableLine1.Day, TimeTableLine1."Time Slot", TimeTableLine1."Document No.");//The number of parameters passed to a string must match the placeholders.
                                                                                                                                                                 // ERROR(Text_10001Lbl);
                END ELSE
                    IF TimeTableLine."Faculty 2 Code" <> '' THEN BEGIN
                        TimeTableLine1.Reset();
                        TimeTableLine1.SETFILTER("Document No.", '<>%1', TimeTableLine."Document No.");
                        TimeTableLine1.SETFILTER("Faculty 2 Start Date", '>=%1', TimeTableLine."Faculty 2 Start Date");
                        TimeTableLine1.SETFILTER("Faculty 2 End Date", '<=%1', TimeTableLine."Faculty 2 End Date");
                        TimeTableLine1.SETRANGE(Day, TimeTableLine.Day);
                        TimeTableLine1.SETRANGE("Time Slot", TimeTableLine."Time Slot");
                        IF TimeTableLine1.FINDFIRST() THEN
                            IF (TimeTableLine1."Faculty 1 Code" = TimeTableLine1."Faculty 2 Code") OR (TimeTableLine1."Faculty 2 Code" = TimeTableLine1."Faculty 2 Code")
                            OR (TimeTableLine1."Faculty 3 Code" = TimeTableLine1."Faculty 2 Code") OR (TimeTableLine1."Faculty 4 Code" = TimeTableLine1."Faculty 2 Code") THEN
                                ERROR(Text_10001Lbl, TimeTableLine1."Faculty 2 Code", TimeTableLine1.Day, TimeTableLine1."Time Slot", TimeTableLine1."Document No.");//The number of parameters passed to a string must match the placeholders.
                                                                                                                                                                     //Error(Text_10001Lbl);
                    END ELSE
                        IF TimeTableLine."Faculty 3 Code" <> '' THEN BEGIN
                            TimeTableLine1.Reset();
                            TimeTableLine1.SETFILTER("Document No.", '<>%1', TimeTableLine."Document No.");
                            TimeTableLine1.SETFILTER("Faculty 3 Start Date", '>=%1', TimeTableLine."Faculty 3 Start Date");
                            TimeTableLine1.SETFILTER("Faculty 3 End Date", '<=%1', TimeTableLine."Faculty 3 End Date");
                            TimeTableLine1.SETRANGE(Day, TimeTableLine.Day);
                            TimeTableLine1.SETRANGE("Time Slot", TimeTableLine."Time Slot");
                            IF TimeTableLine1.FINDFIRST() THEN
                                IF (TimeTableLine1."Faculty 1 Code" = TimeTableLine1."Faculty 3 Code") OR (TimeTableLine1."Faculty 2 Code" = TimeTableLine1."Faculty 3 Code")
                                OR (TimeTableLine1."Faculty 3 Code" = TimeTableLine1."Faculty 3 Code") OR (TimeTableLine1."Faculty 4 Code" = TimeTableLine1."Faculty 3 Code") THEN
                                    ERROR(Text_10001Lbl, TimeTableLine1."Faculty 3 Code", TimeTableLine1.Day, TimeTableLine1."Time Slot", TimeTableLine1."Document No.");//The number of parameters passed to a string must match the placeholders.
                                                                                                                                                                         // ERROR(Text_10001Lbl);
                        END ELSE
                            IF TimeTableLine."Faculty 4 Code" <> '' THEN BEGIN
                                TimeTableLine1.Reset();
                                TimeTableLine1.SETFILTER("Document No.", '<>%1', TimeTableLine."Document No.");
                                TimeTableLine1.SETFILTER("Faculty 4 Start Date", '>=%1', TimeTableLine."Faculty 4 Start Date");
                                TimeTableLine1.SETFILTER("Faculty 4 End Date", '<=%1', TimeTableLine."Faculty 4 End Date");
                                TimeTableLine1.SETRANGE(Day, TimeTableLine.Day);
                                TimeTableLine1.SETRANGE("Time Slot", TimeTableLine."Time Slot");
                                IF TimeTableLine1.FINDFIRST() THEN
                                    IF (TimeTableLine1."Faculty 1 Code" = TimeTableLine1."Faculty 4 Code") OR (TimeTableLine1."Faculty 2 Code" = TimeTableLine1."Faculty 4 Code")
                                    OR (TimeTableLine1."Faculty 3 Code" = TimeTableLine1."Faculty 4 Code") OR (TimeTableLine1."Faculty 4 Code" = TimeTableLine1."Faculty 4 Code") THEN
                                        ERROR(Text_10001Lbl, TimeTableLine1."Faculty 4 Code", TimeTableLine1.Day, TimeTableLine1."Time Slot", TimeTableLine1."Document No.");//CODE COMMENT for warning The number of parameters passed to a string must match the placeholders.
                                                                                                                                                                             // ERROR(Text_10001Lbl);
                            END;
            UNTIL TimeTableLine.NEXT() = 0;
        //Code added for Find Duplicacy For Faculty::CSPL-00092::11-05-2019: End
    end;

    procedure TestDuplicacyForRoom()
    var
        // TimeTable: Record "Final Class Time Table-CS";
        // TimeTable1: Record "Final Class Time Table-CS";
        TimeTableLine: Record "Class Time Table Line-CS";
        TimeTableLine1: Record "Class Time Table Line-CS";

    begin
        //Code added for Find Duplicacy For Room::CSPL-00092::11-05-2019: Start
        TimeTableLine.Reset();
        TimeTableLine.SETRANGE("Document No.", Rec."No.");
        TimeTableLine.SETRANGE("OverRide Validation", FALSE);
        TimeTableLine.SETRANGE(Interval, FALSE);
        IF TimeTableLine.FINDSET() THEN
            REPEAT
                IF TimeTableLine."Faculty 1 Code" <> '' THEN BEGIN
                    TimeTableLine1.Reset();
                    TimeTableLine1.SETFILTER("Document No.", '<>%1', TimeTableLine."Document No.");
                    TimeTableLine1.SETFILTER("Faculty 1 Start Date", '>=%1', TimeTableLine."Faculty 1 Start Date");
                    TimeTableLine1.SETFILTER("Faculty 1 End Date", '<=%1', TimeTableLine."Faculty 1 End Date");
                    TimeTableLine1.SETRANGE(Day, TimeTableLine.Day);
                    TimeTableLine1.SETRANGE("Time Slot", TimeTableLine."Time Slot");
                    TimeTableLine1.SETRANGE("Room No", TimeTableLine."Room No");
                    IF TimeTableLine1.FINDFIRST() THEN
                        ERROR(Text_10001Lbl, TimeTableLine1."Room No", TimeTableLine1.Day, TimeTableLine1."Time Slot", TimeTableLine1."Document No.");//CODE COMMENT for warning The number of parameters passed to a string must match the placeholders.
                                                                                                                                                      //ERROR(Text_10001Lbl);
                END;
            UNTIL TimeTableLine.NEXT() = 0;
        //Code added for Find Duplicacy For Room::CSPL-00092::11-05-2019: End
    end;

    procedure CopyTableData()
    Var
        TimeTableBufferRec: Record "Time Table Buffer";
        FinalClassTimeTableRec: Record "Final Class Time Table-CS";
    begin
        FinalClassTimeTableRec.RESET();
        FinalClassTimeTableRec.SetRange("Time Table  Document No.", TimeTableBufferRec."Time Table Document No.");
        FinalClassTimeTableRec.SetRange("Time Slot Code", TimeTableBufferRec."Time Slot Code");
        FinalClassTimeTableRec.SetRange("Room No", TimeTableBufferRec."Room No");
        FinalClassTimeTableRec.SetRange(Batch, TimeTableBufferRec.Batch);
        FinalClassTimeTableRec.SetRange("Subject Code", TimeTableBufferRec."Subject Code");
        FinalClassTimeTableRec.SetRange(Date, TimeTableBufferRec.Date);
        FinalClassTimeTableRec.SetRange("Faculty 1Code", TimeTableBufferRec."Faculty 1Code");
        IF Not FinalClassTimeTableRec.FINDFIRST() THEN begin
            TimeTableBufferRec.RESET();
            IF TimeTableBufferRec.FINDFIRST() THEN
                REPEAT
                    FinalClassTimeTableRec.INIT();
                    FinalClassTimeTableRec.TRANSFERFIELDS(TimeTableBufferRec);
                    FinalClassTimeTableRec.INSERT();
                UNTIL TimeTableBufferRec.NEXT() = 0;
        end;
    end;
}

