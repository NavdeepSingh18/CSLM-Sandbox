page 51047 GradeBookHeader
{
    PageType = Card;
    Caption = 'Grade Book';
    UsageCategory = None;
    SourceTable = "Grade Book Header";


    layout
    {
        area(Content)
        {
            group(GroupName)

            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                    Editable = False;
                    Visible = Rec."Global Dimension 1 Code" = '9100';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Academic year"; Rec."Academic year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. of Archives"; Rec."No. of Archives")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = Rec.Status = Rec.Status::Approved;
                }
                field("Approved On"; Rec."Approved On")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = Rec.Status = Rec.Status::Approved;
                }
                field("Rejected Reason"; Rec."Rejected Reason")
                {
                    ApplicationArea = all;
                    Visible = ReasonVisible;
                }
                field("Rejected Reason Description"; Rec."Rejected Reason Description")
                {
                    ApplicationArea = all;
                    Visible = ReasonVisible;
                    MultiLine = true;
                }
                field("Published By"; Rec."Published By")
                {
                    ApplicationArea = all;
                    Editable = false;
                    // Visible = Status = Status::Published;
                }
                field("Published On"; Rec."Published On")
                {
                    ApplicationArea = all;
                    Editable = false;
                    // Visible = Status = Status::Published;
                }
                field("Published Time"; Rec."Published Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                    // Visible = Status = Status::Published;
                }
            }
            part("Lines"; GradeBookSubform)
            {
                ApplicationArea = All;
                SubPageLink = "Grade Book No." = FIELD("Document No.");
                SubPageView = Where(Level = Filter('2'), "Global Dimension 1 Code" = filter('9000'));
                //Editable = false;
                Visible = Rec."Global Dimension 1 Code" = '9000';
            }

            part("Line"; GradeBookSubform)
            {
                ApplicationArea = All;
                SubPageLink = "Grade Book No." = FIELD("Document No.");
                SubPageView = Where(Level = Filter('1'), "Global Dimension 1 Code" = filter('9100'));
                //Editable = false;
                Visible = Rec."Global Dimension 1 Code" = '9100';
            }
        }
        area(factboxes)
        {
            part("Student Picture"; "Student Picture")
            {
                ApplicationArea = All;
                Provider = lines;
                SubPageLink = "No." = FIELD("Student No."), "Global Dimension 1 Code" = field("Global Dimension 1 Code");
                Visible = Rec."Global Dimension 1 Code" = '9000';
            }
            part("Student Pictures"; "Student Picture")
            {
                ApplicationArea = All;
                Provider = line;
                SubPageLink = "No." = FIELD("Student No."), "Global Dimension 1 Code" = field("Global Dimension 1 Code");
                //Visible = "Global Dimension 1 Code" = '9100';
            }
            part(StudentSubjectGradeBookFactbox; StudentSubjectGradeBookFactbox)
            {
                ApplicationArea = All;
                Provider = lines;
                SubPageLink = "Grade Book No." = FIELD("Grade Book No."), "Student No." = field("Student No."), "Global Dimension 1 Code" = Field("Global Dimension 1 Code");
                Visible = Rec."Global Dimension 1 Code" = '9000';

            }

            part(StudentSubjectGradeBookFactboxs; StudentSubjectGradeBookFactbox)
            {
                ApplicationArea = All;
                Provider = Line;
                SubPageLink = "Grade Book No." = FIELD("Grade Book No."), "Student No." = field("Student No."), "Global Dimension 1 Code" = Field("Global Dimension 1 Code");
                Visible = Rec."Global Dimension 1 Code" = '9100';

            }
            part(StudSubjGrdBookSummaryFactbox; StudSubjGrdBookSummaryFactbox)
            {
                ApplicationArea = All;
                Caption = 'Grade Book Summary';
                SubPageLink = "Grade Book No." = FIELD("Document No.");
            }
        }
    }


    actions
    {
        area(Processing)
        {
            group("Grading")
            {

                action("Reset Grade Book")
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        GradeBookHdr: Record "Grade Book Header";
                        StudSub: Record "Main Student Subject-CS";
                        StudSubGB: Record "Student Subject GradeBook";
                    begin
                        GradeBookHdr.Reset();
                        GradeBookHdr.Get(Rec."Document No.");
                        GradeBookHdr.Validate(Status, GradeBookHdr.Status::Open);
                        GradeBookHdr.Modify(true);
                        StudSub.Reset();
                        StudSub.SetRange("Grade Book No.", Rec."Document No.");
                        if StudSub.FindSet() then
                            repeat
                                StudSub."Percentage Obtained" := 0;
                                StudSub."Credit Earned" := 0;

                                StudSub.Grade := '';
                                // StudSub."Grade Book No." := StudSubGB."Grade Book No.";
                                StudSub."% Range" := '';
                                StudSub.Recommendation := '';
                                StudSub."Grade Confirmed" := false;
                                StudSub.Communications := '';
                                StudSub.Modify(True);
                            until StudSub.Next() = 0;
                        StudSubGB.Reset();
                        StudSubGB.SetRange("Grade Book No.", Rec."Document No.");
                        if StudSubGB.FindSet() then
                            repeat
                                StudSubGB.Delete(true);
                            until StudSubGB.Next() = 0;
                    end;
                }
                action(GradeInput)
                {
                    ApplicationArea = All;
                    Caption = 'Grade Input';
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Visible = Rec."Global Dimension 1 Code" = '9000';
                    RunObject = Page "Grade Input Grade Book List";
                    RunPageLink = "Grade Book No." = field("Document No.");
                }

                action(GradeList)
                {
                    ApplicationArea = All;
                    Caption = 'Grade List';
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Visible = Rec."Global Dimension 1 Code" = '9000';
                    RunObject = Page "Grade List GradeBook";
                    RunPageLink = "Grade Book No." = field("Document No.");
                }
                action(Recommendations)
                {
                    ApplicationArea = All;
                    Caption = 'Recommendations';
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Visible = Rec."Global Dimension 1 Code" = '9000';
                    RunObject = Page "Recommendation GradeBook List";
                    RunPageLink = "Grade Book No." = field("Document No.");
                }
            }

            action("Calculate Final Grade")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                Var
                    GradeBook_lRec: Record "Grade Book";
                    StudentNoFilter: Text;
                begin
                    FinalGradingForStudSub(Rec);
                    GradeBook_lRec.Reset();
                    GradeBook_lRec.SetCurrentKey("Student No.");
                    GradeBook_lRec.SetRange("Grade Book No.", Rec."Document No.");
                    IF GradeBook_lRec.FindSet() then begin
                        repeat
                            If StudentNoFilter <> GradeBook_lRec."Student No." then begin
                                StudentNoFilter := GradeBook_lRec."Student No.";
                                CalculateGPAForGradeBook(GradeBook_lRec, GradeBook_lRec."Student No.");
                            end;
                        until GradeBook_lRec.Next() = 0;
                    end;
                end;
            }
            action(StatusLedger)
            {
                ApplicationArea = All;
                Caption = 'Status Ledger';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = Rec."Global Dimension 1 Code" = '9000';
                RunObject = Page GradeBookHeaderLedgerList;
                RunPageLink = "Document No." = field("Document No.");
            }
            action(StudentSubjectGradeBook)
            {
                ApplicationArea = All;
                Caption = 'Student Subject - Grade Book';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = Page StudentSubjectGradeBookList;
                RunPageLink = "Grade Book No." = field("Document No.");
            }


            action("Archive Document")
            {
                ApplicationArea = All;
                Caption = 'Archive Document';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if Confirm('Do you want to Archive Document No. %1', false, Rec."Document No.") then
                        Rec.DocumentArchive(Rec);
                end;
            }

            action("Send For Approval")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = ActionSendForApp;
                trigger OnAction()
                var
                    DocAppUser: Record "Document Approver Users";
                    UserSetup: Record "User Setup";
                    GradeBook_lRec: REcord "Grade Book";
                    StudentNoFilter: Text;
                begin
                    DocAppUser.Reset();
                    DocAppUser.SetRange("Department Approver Type", DocAppUser."Department Approver Type"::"Promotions Committee");
                    DocAppUser.FindFirst();
                    DocAppUser.TestField("User ID");
                    UserSetup.Reset();
                    UserSetup.get(DocAppUser."User ID");
                    UserSetup.TestField("E-Mail");

                    if Confirm('Do you want to send Document No. %1 for approvals', false, Rec."Document No.") then begin
                        if Rec.Status in [Rec.Status::Approved, Rec.Status::"Pending For Approval"] then
                            Error('Document must be Open/Rejected in order to Send for Approval');
                        Rec."Rejected Reason" := '';
                        Rec."Rejected Reason Description" := '';
                        Rec.Status := Rec.Status::"Pending For Approval";
                        Rec.Validate(Status);

                        Rec."To Be Approved By" := DocAppUser."User ID";
                        Rec."Send for Approval By" := UserId();
                        Rec."Send for Approval On" := Today();
                        Rec."Send for Approval Time" := Time();
                        Rec.CreateDocumentLedger(Rec);
                        Rec.Modify();
                        SendGradeBookEmail(Rec, 1);
                        FinalGradingForStudSub(Rec);
                        GradeBook_lRec.Reset();
                        GradeBook_lRec.SetCurrentKey("Student No.");
                        GradeBook_lRec.SetRange("Grade Book No.", Rec."Document No.");
                        IF GradeBook_lRec.FindSet() then begin
                            repeat
                                If StudentNoFilter <> GradeBook_lRec."Student No." then begin
                                    StudentNoFilter := GradeBook_lRec."Student No.";
                                    CalculateGPAForGradeBook(GradeBook_lRec, GradeBook_lRec."Student No.");
                                end;
                            until GradeBook_lRec.Next() = 0;
                        end;
                    end;
                    CurrPage.Close();
                end;
            }
            action("Approve Document")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = Rec.Status = Rec.Status::"Pending For Approval";
                trigger OnAction()
                begin
                    if Confirm('Do you want to Approve Document No. %1', false, Rec."Document No.") then begin
                        if Rec.Status <> Rec.Status::"Pending For Approval" then
                            Error('Document must be "Pending For Approval" in order to Approve it');

                        Rec.Status := Rec.Status::Approved;
                        Rec.Validate(Status);
                        Rec."Approved By" := UserId();
                        Rec."Approved On" := Today();
                        Rec.CreateDocumentLedger(Rec);
                        Rec.Modify();
                        SendGradeBookEmail(Rec, 2);
                    end;
                    CurrPage.Close();
                end;
            }

            action("Reject Document")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = Rec.Status = Rec.Status::"Pending For Approval";
                trigger OnAction()
                begin
                    if Confirm('Do you want to Reject Document No. %1', false, Rec."Document No.") then begin
                        if Rec.Status <> Rec.Status::"Pending For Approval" then
                            Error('Document must be "Pending For Approval" in order to Reject it');
                        Rec.TestField("Rejected Reason Description");
                        Rec.Status := Rec.Status::Rejected;
                        Rec.Validate(Status);
                        Rec.CreateDocumentLedger(Rec);
                        Rec.Modify();
                        SendGradeBookEmail(Rec, 3);
                    end;
                    CurrPage.Close();
                end;
            }
            action(Recalculate)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = Rec."Global Dimension 1 Code" = '9000';
                trigger OnAction()
                Var
                    GradeBook_lRec: Record "Grade Book";
                    StudentNoFilter: Text;

                begin
                    if Confirm('Do you want to recalculate Grade Book No. %1', false, Rec."Document No.") then begin
                        RecalculateGradeBook(Rec);
                        FinalGradingForStudSub(Rec);
                        GradeBook_lRec.Reset();
                        GradeBook_lRec.SetCurrentKey("Student No.");
                        GradeBook_lRec.SetRange("Grade Book No.", Rec."Document No.");
                        IF GradeBook_lRec.FindSet() then begin
                            repeat
                                If StudentNoFilter <> GradeBook_lRec."Student No." then begin
                                    StudentNoFilter := GradeBook_lRec."Student No.";
                                    CalculateGPAForGradeBook(GradeBook_lRec, GradeBook_lRec."Student No.");
                                end;
                            until GradeBook_lRec.Next() = 0;
                        end;
                    end;
                end;
            }
            action("Publish Final Grades")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = PublishShow;
                trigger OnAction()
                var
                    Sem: Record "Semester Master-CS";
                    CrsSemLn: Record "Course Sem. Master-CS";
                    CourseMAster: Record "Course Master-CS";
                    GradeBookHdrIP: Record "Grade Book Header";
                    StudSub: Record "Main Student Subject-CS";
                    StudSubEven: Record "Main Student Subject-CS";
                    StudSubOdd: Record "Main Student Subject-CS";
                    StudSubGB: Record "Student Subject GradeBook";
                    DocAppUser: Record "Document Approver Users";
                    StudentMaster: Record "Student Master-CS";
                    GradeBook_lRec: Record "Grade Book";
                    GradeToBePublished: Code[20];
                    SemSeq: Integer;
                    AYInt: Integer;
                    OldAY: Code[20];
                    OldTerm: Option FALL,SPRING,SUMMER," ";
                    StudentNoFilter: Code[20];
                    PrevStudent: Text;
                    CourseFilter: Text;
                begin
                    if Confirm('Do you want to Publish Document No. %1', false, Rec."Document No.") then begin
                        IF Rec."Global Dimension 1 Code" = '9000' then
                            if Rec.Status <> Rec.Status::Approved then
                                Error('Grade Book No. %1 must be Approved', Rec."Document No.");
                        DocAppUser.Reset();
                        DocAppUser.SetRange("User ID", USERID());
                        DocAppUser.SetRange("Department Approver Type", DocAppUser."Department Approver Type"::"Registrar Department");
                        if not DocAppUser.FindFirst() then
                            Error('Only Registrar Department people are allowed to Publish');

                        CourseFilter := '';
                        If Rec."Global Dimension 1 Code" = '9000' then begin
                            CourseMAster.Reset();
                            CourseMAster.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                            CourseMAster.SetRange("Consider for Grading", true);
                            If CourseMAster.FindSet() then begin
                                repeat
                                    If CourseFilter = '' then
                                        CourseFilter := CourseMAster.Code
                                    Else
                                        CourseFilter += '|' + CourseMAster.Code;
                                until CourseMAster.Next() = 0;
                            end;
                        end Else
                            If Rec."Global Dimension 1 Code" = '9100' then
                                CourseFilter := Rec.Course;

                        Sem.Reset();
                        Sem.SetRange(Code, Rec.Semester);
                        Sem.FindFirst();
                        if Rec."Global Dimension 1 Code" = '9000' then begin
                            if Sem."Temporary Grade" <> '' then
                                PublishFinalGrades(Rec, True, GradeToBePublished)
                            else begin
                                PublishFinalGrades(Rec, false, GradeToBePublished);
                                CrsSemLn.Reset();
                                //CrsSemLn.SetRange("Course Code", Course);
                                CrsSemLn.SetFilter("Course Code", CourseFilter);
                                CrsSemLn.SetRange("Semester Code", Rec.Semester);
                                CrsSemLn.SetRange("Academic Year", Rec."Academic year");
                                CrsSemLn.SetRange(Term, Rec.Term);
                                CrsSemLn.FindFirst();
                                // SemSeq := CrsSemLn."Sequence No" - 1;
                                // if SemSeq < 0 then
                                //     Error('Semester Sequence cannot be less than 0');
                                // if Term = Term::SPRING then begin
                                //     Evaluate(AYInt, "Academic year");
                                //     OldAY := Format(AYInt - 1);
                                //     OldTerm := OldTerm::FALL;
                                // end
                                // else
                                //     if Term = Term::FALL then begin
                                //         OldAY := "Academic year";
                                //         OldTerm := OldTerm::SPRING;
                                //     end;


                                // CrsSemLn.Reset();
                                // //CrsSemLn.SetRange("Course Code", Course);
                                // CrsSemLn.SetFilter("Course Code", CourseFilter);
                                // CrsSemLn.SetRange("Academic Year", OldAY);
                                // CrsSemLn.SetRange(Term, OldTerm);
                                // CrsSemLn.SetRange("Sequence No", SemSeq);
                                // CrsSemLn.FindFirst();

                                GradeBookHdrIP.Reset();
                                GradeBookHdrIP.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                                GradeBookHdrIP.SetRange(Course, Rec.Course);
                                GradeBookHdrIP.SetRange(Semester, CrsSemLn."Semester Code");
                                GradeBookHdrIP.SetRange("Academic year", CrsSemLn."Academic Year");
                                GradeBookHdrIP.SetRange(Term, CrsSemLn.Term);
                                GradeBookHdrIP.SetRange(Status, GradeBookHdrIP.Status::Published);
                                If GradeBookHdrIP.FindFirst() then begin
                                    IF Rec.Semester <> 'BSIC' then // as per Ajay in BSIC IP grade should not update on previous semester 24-02-22 Lucky
                                        PublishFinalGrades(GradeBookHdrIP, false, GradeToBePublished);
                                    Rec.CreateDocumentLedger(Rec);
                                end;
                                If Not GradeBookHdrIP.FindFirst() then begin
                                    PublishFinalGradesNonGradeBook(Rec, false, GradeToBePublished, Rec."Global Dimension 1 Code", CourseFilter, CrsSemLn."Semester Code", CrsSemLn."Academic Year", CrsSemLn.Term);
                                    Rec.CreateDocumentLedger(Rec);
                                end;

                                //R Grade Update - Start
                                StudSub.Reset();
                                StudSub.SetRange("Grade Book No.", Rec."Document No.");
                                StudSub.SetRange(Failed, false);
                                StudSub.FindSet();
                                repeat
                                    StudSubEven.Reset();
                                    //key(Key1; "Student No.", Course, Semester, "Academic Year", 
                                    //"Subject Code", Section, "Start Date")
                                    StudSubEven.SetRange("Student No.", StudSub."Student No.");
                                    StudSubEven.SetRange(Semester, StudSub.Semester);
                                    StudSubEven.SetRange("Subject Code", StudSub."Subject Code");
                                    StudSubEven.SetFilter("Start Date", '<>%1', StudSub."Start Date");
                                    if StudSubEven.FindFirst() then begin
                                        StudSubEven.Validate(Grade, 'R');
                                        StudSubEven."Grade Confirmed" := true;
                                        StudSubEven.Modify(true);

                                        StudentMaster.Reset();
                                        If StudentMaster.Get(StudSubEven."Student No.") then begin
                                            IF StudentMaster."Student SFP Initiation" <> 0 then begin
                                                StudentMaster."SAFI Sync" := StudentMaster."SAFI Sync"::Pending;            //10-11-2021
                                                StudentMaster.Modify(true);
                                            end;
                                        end;

                                        CrsSemLn.Reset();
                                        //CrsSemLn.SetRange("Course Code", Course);
                                        CrsSemLn.SetFilter("Course Code", CourseFilter);
                                        CrsSemLn.SetRange("Semester Code", Rec.Semester);
                                        CrsSemLn.SetRange("Academic Year", StudSubEven."Academic year");
                                        CrsSemLn.SetRange(Term, StudSubEven.Term);
                                        CrsSemLn.FindFirst();
                                        // SemSeq := CrsSemLn."Sequence No" - 1;
                                        // if SemSeq < 0 then
                                        //     Error('Semester Sequence cannot be less than 0');
                                        // if StudSubEven.Term = StudSubEven.Term::SPRING then begin
                                        //     Evaluate(AYInt, StudSubEven."Academic year");
                                        //     OldAY := Format(AYInt - 1);
                                        //     OldTerm := OldTerm::FALL;
                                        // end
                                        // else
                                        //     if Term = Term::FALL then begin
                                        //         OldAY := StudSubEven."Academic year";
                                        //         OldTerm := OldTerm::SPRING;
                                        //     end;

                                        // CrsSemLn.Reset();
                                        // //CrsSemLn.SetRange("Course Code", Course);
                                        // CrsSemLn.SetFilter("Course Code", CourseFilter);
                                        // CrsSemLn.SetRange("Sequence No", SemSeq);
                                        // CrsSemLn.SetRange("Academic Year", OldAY);
                                        // CrsSemLn.SetRange(Term, OldTerm);
                                        // CrsSemLn.FindFirst();

                                        StudSubOdd.Reset();
                                        //key(Key1; "Student No.", Course, Semester, "Academic Year", 
                                        //"Subject Code", Section, "Start Date")
                                        StudSubOdd.SetRange("Student No.", StudSub."Student No.");

                                        StudSubOdd.SetRange(Semester, CrsSemLn."Semester Code");
                                        // StudSubOdd.SetRange("Subject Code", StudSub."Subject Code");
                                        StudSubOdd.SetFilter("Start Date", '<>%1', StudSub."Start Date");
                                        StudSubOdd.FindLast();
                                        //StudSubOdd.Validate(Grade, 'R');     19Apr2022
                                        StudSubOdd.Validate(Grade, GradeToBePublished);
                                        StudSubOdd."Grade Confirmed" := true;
                                        StudSubOdd.Modify(true);

                                        StudentMaster.Reset();
                                        If StudentMaster.Get(StudSubOdd."Student No.") then begin
                                            If StudentMaster."Student SFP Initiation" <> 0 then begin
                                                StudentMaster."SAFI Sync" := StudentMaster."SAFI Sync"::Pending;        //10-11-2021
                                                StudentMaster.Modify(true);
                                            end;
                                        end;

                                    end;
                                until StudSub.Next() = 0;

                                //R Grade Update - End
                            end;
                        end
                        else
                            if Rec."Global Dimension 1 Code" = '9100' then begin
                                PublishFinalGrades(Rec, false, GradeToBePublished);
                                Rec.CreateDocumentLedger(Rec);
                            end;
                        //CSPL-00307 Starts
                        StudSubGB.Reset();
                        StudSubGB.SetCurrentKey("Student No.");
                        StudSubGB.SetRange("Grade Book No.", Rec."Document No.");
                        StudSubGB.SetAscending("Student No.", true);
                        IF StudSubGB.FindSet() then
                            repeat
                                StudentMaster.Reset();
                                If StudentMaster.Get(StudSubGB."Student No.") then begin
                                    IF PrevStudent <> StudSubGB."Student No." then begin
                                        PrevStudent := StudSubGB."Student No.";
                                        StudentMaster.CalculateSAP(StudentMaster, Rec."Document No.");
                                        //StudSubGB.TestField(Communications);
                                        SemesterPromotionsMail(StudSubGB);
                                    end;
                                end;
                            until StudSubGB.Next() = 0;
                        //CSPL-00307 Ends
                        GradeBook_lRec.Reset();
                        GradeBook_lRec.SetCurrentKey("Student No.");
                        GradeBook_lRec.SetRange("Grade Book No.", Rec."Document No.");
                        IF GradeBook_lRec.FindSet() then begin
                            repeat
                                If StudentNoFilter <> GradeBook_lRec."Student No." then begin
                                    StudentNoFilter := GradeBook_lRec."Student No.";
                                    CalculateGPA(GradeBook_lRec, GradeBook_lRec."Student No.");
                                end;
                            until GradeBook_lRec.Next() = 0;
                        end;
                    end;
                end;
            }

            Action("Refresh Grade Book")
            {
                ApplicationArea = All;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = Rec."Global Dimension 1 Code" = '9000';
                Trigger OnAction()
                Begin

                    CreateNewGradeBook(Rec."Document No.");
                    Message('Updated.');
                End;
            }
            group(Reports)
            {
                action("Grade Book")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GrdBook: report "Grade Book";
                        GrdBookBSIC: report "Grade Book BSIC";
                    begin
                        Clear(GrdBook);
                        Clear(GrdBookBSIC);
                        IF Rec.Semester <> 'BSIC' then begin
                            GrdBook.AddParam(Rec."Global Dimension 1 Code", Rec.Course, Rec.Semester, Rec."Academic year", Rec.Term);
                            GrdBook.Run();
                        end Else begin
                            GrdBookBSIC.AddParam(Rec."Global Dimension 1 Code", Rec.Course, Rec.Semester, Rec."Academic year", Rec.Term);
                            GrdBookBSIC.Run();
                        end;
                    end;
                }
                // action("Grade Book Opt")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Grade Book';
                //     Visible = False;
                //     trigger OnAction()
                //     var
                //         GrdBook: report "Grade Book Opt";

                //     begin
                //         Clear(GrdBook);
                //         //IF Rec.Semester <> 'BSIC' then begin
                //         GrdBook.AddParam("Global Dimension 1 Code", Course, Semester, "Academic year", Term, "Document No.");
                //         GrdBook.Run();
                //         // end Else begin
                //         //     GrdBookBSIC.AddParam("Global Dimension 1 Code", Course, Semester, "Academic year", Term);
                //         //     GrdBookBSIC.Run();
                //         // end;
                //     end;
                // }


            }
        }

    }

    procedure FinalGradingForStudSub(pGradeBookHdr: Record "Grade Book Header")
    var
        Stud: Record "Student Master-CS";
        GradeBook: Record "Grade Book";
        GradeBookChk: Record "Grade Book";
        GradeBookUn: Record "Grade Book" temporary;
        StudentSubject: Record "Main Student Subject-CS";
        StudentSubjectGB: Record "Student Subject GradeBook";
        StudentSubjectOdd: Record "Main Student Subject-CS";
        RecRecommendationsGB: Record "Recommendations GradeBook";
        StudentSubjectExam: Record "Student Subject Exam";
        CrsSemLn: Record "Course Sem. Master-CS";
        CrsSubjectLn: Record "Course Wise Subject Line-CS";
        SubMaster: Record "Subject Master-CS";
        Sem: Record "Semester Master-CS";
        Sem2: Record "Semester Master-CS";
        GradeMaster_lRec: Record "Grade Master-CS";
        GradeMaster: Record "Grade Master Grade Book";
        CrsMstr: Record "Course Master-CS";
        GradeInput_lRec: Record "Marks Weightage Grade Book";
        GradeCalculation_lPag: Page "Grade Calculation";
        SemSeq: Integer;
        AYInt: Integer;
        OldAY: Code[20];
        OldTerm: Option FALL,SPRING,SUMMER;
        StudSubGBEntryNo: Integer;
        EntryFound: Integer;
        // TotEarnedPoints: Decimal;
        LineCout: Decimal;
        TotPercTmp: Decimal;
        TotPerc: Decimal;
        Lvl1Subj: Code[20];
        NumericGrade: Decimal;
        CourseFilter: Text;
        MarksWeightage: Decimal;
    begin
        CourseFilter := '';
        IF pGradeBookHdr."Global Dimension 1 Code" = '9000' then begin
            CrsMstr.Reset();
            CrsMstr.SetRange("Global Dimension 1 Code", pGradeBookHdr."Global Dimension 1 Code");
            CrsMstr.SetRange("Consider for Grading", true);
            IF CrsMstr.FindSet() then begin
                repeat
                    IF CourseFilter = '' then
                        CourseFilter := CrsMstr.Code
                    Else
                        CourseFilter += '|' + CrsMstr.Code;
                until CrsMstr.Next() = 0;
            end;
        end Else
            If pGradeBookHdr."Global Dimension 1 Code" = '9100' then
                CourseFilter := pGradeBookHdr.Course;

        GradeMaster_lRec.Reset();
        If pGradeBookHdr."Global Dimension 1 Code" = '9100' then begin
            GradeBook.Reset();
            GradeBook.Setrange("Grade Book No.", pGradeBookHdr."Document No.");
            If GradeBook.FindSet() then begin
                Repeat
                    GradeCalculation_lPag.CopyGradeList(GradeMaster_lRec, GradeBook);
                until GradeBook.Next() = 0;
            end;
        end;
        GradeMaster.Reset();
        GradeMaster.SetRange("Global Dimension 1 Code", pGradeBookHdr."Global Dimension 1 Code");
        GradeMaster.SetRange("Grade Book No.", pGradeBookHdr."Document No.");
        GradeMaster.SetRange("Blocked for Grading", false);
        GradeMaster.FindSet();
        repeat
            GradeMaster."Total Students" := 0;
            GradeMaster.Modify();
        until GradeMaster.Next() = 0;

        GradeBookUn.Reset();
        GradeBookUn.DeleteAll();
        Clear(GradeBookUn);

        StudentSubjectGB.Reset();
        StudentSubjectGB.SetRange("Grade Book No.", pGradeBookHdr."Document No.");
        if StudentSubjectGB.FindSet() then
            StudentSubjectGB.DeleteAll();

        GradeBook.Reset();
        GradeBook.SetRange("Grade Book No.", pGradeBookHdr."Document No.");
        IF GradeBook."Global Dimension 1 Code" = '9000' then
            GradeBook.SetRange(Level, 2);
        IF GradeBook."Global Dimension 1 Code" = '9100' then
            GradeBook.SetRange(Level, 1);
        GradeBook.FindSet();
        repeat

            EntryFound := 0;
            GradeBookUn.Reset();
            GradeBookUn.SetRange("Student No.", GradeBook."Student No.");
            //Subject Filter here
            if GradeBookUn.FindFirst() then
                EntryFound := 1;

            if EntryFound = 0 then begin
                GradeBookUn.Reset();
                GradeBookUn.Init();
                GradeBookUn."Grade Book No." := GradeBook."Grade Book No.";
                GradeBookUn."Student No." := GradeBook."Student No.";
                GradeBookUn."Exam Code" := GradeBook."Exam Code";
                GradeBookUn.Insert();
            end;
        until GradeBook.Next() = 0;

        GradeBookUn.Reset();
        GradeBookUn.SetRange("Grade Book No.", pGradeBookHdr."Document No.");         //13 Marc 2023
        //Subject Filter here
        GradeBookUn.FindSet();
        repeat
            TotPerc := 0;
            NumericGrade := 0;
            MarksWeightage := 0;
            GradeBook.Reset();
            GradeBook.SetRange("Grade Book No.", pGradeBookHdr."Document No.");
            //Subject Filter here
            GradeBook.SetRange("Student No.", GradeBookUn."Student No.");
            IF GradeBook."Global Dimension 1 Code" = '9000' then
                GradeBook.SetRange(Level, 2);
            IF GradeBook."Global Dimension 1 Code" = '9100' then
                GradeBook.SetRange(Level, 1);
            LineCout := GradeBook.Count();
            If GradeBook.FindSet() then
                repeat
                    //check here for best
                    TotPercTmp := 0;

                    TotPercTmp := GradeBook."Percentage Obtained";//Best

                    TotPerc += TotPercTmp;//Best
                    GradeInput_lRec.Reset();
                    NumericGrade += GradeBook."Available Points" * GradeBook."Percentage Obtained" / 100;
                    IF GradeBook.Level = 2 then
                        MarksWeightage += GradeBook."Available Points";

                    StudentSubject.Reset();
                    StudentSubject.SetCurrentKey(StudentSubject."Student No.");
                    StudentSubject.SetRange("Student No.", GradeBookUn."Student No.");
                    StudentSubject.SetRange("Global Dimension 1 Code", pGradeBookHdr."Global Dimension 1 Code");
                    StudentSubject.SetRange("Academic Year", pGradeBookHdr."Academic Year");
                    StudentSubject.SetRange(Term, pGradeBookHdr.Term);
                    StudentSubject.SetRange(Semester, pGradeBookHdr.Semester);

                    SubMaster.Reset();
                    SubMaster.SetRange(Code, GradeBook."Exam Code");
                    SubMaster.SetRange("BSIC/MED4 not Applicable", false);
                    IF SubMaster.FindFirst() then;
                    Lvl1Subj := SubMaster."Subject Group";
                    IF Lvl1Subj <> '' then begin
                        SubMaster.Reset();
                        SubMaster.SetRange(Code, Lvl1Subj);
                        SubMaster.FindFirst();
                    end;
                    StudentSubject.SetRange("Subject Code", SubMaster.Code);

                    StudentSubject.SetRange(Course, GradeBook.Course);

                until GradeBook.Next() = 0;
            //MarksWeightage := MarksWeightage / 2;
            MarksWeightage := 100 - MarksWeightage;
            StudentSubject.FindFirst();
            OldAY := '';
            OldTerm := 0;
            Sem.Reset();
            Sem.SetRange(Code, StudentSubject.Semester);
            Sem.FindFirst();
            // if ((Sem.Sequence MOD 2) > 0) OR ("Global Dimension 1 Code" = '9100') then begin
            StudentSubject."Numeric Grade" := NumericGrade;// Stuti
            If LineCout <> 0 then           //13Mar2023
                StudentSubject."Percentage Obtained" := Round((TotPerc / LineCout), 0.01, '=')
            else
                StudentSubject."Percentage Obtained" := 0;
            // end;
            // else
            //     if (Sem.Sequence MOD 2) = 0 then begin
            //         CrsSemLn.Reset();
            //         //CrsSemLn.SetRange("Course Code", pGradeBookHdr.Course);
            //         CrsSemLn.SetFilter("Course Code", CourseFilter);
            //         CrsSemLn.SetRange("Semester Code", pGradeBookHdr.Semester);
            //         CrsSemLn.SetRange("Academic Year", pGradeBookHdr."Academic year");
            //         CrsSemLn.SetRange(Term, pGradeBookHdr.Term);
            //         CrsSemLn.FindFirst();
            //         SemSeq := CrsSemLn."Sequence No" - 1;
            //         if SemSeq < 0 then
            //             Error('Semester Sequence cannot be less than 0');
            //         if pGradeBookHdr.Term = pGradeBookHdr.Term::SPRING then begin
            //             Evaluate(AYInt, pGradeBookHdr."Academic year");
            //             OldAY := Format(AYInt - 1);
            //             OldTerm := OldTerm::FALL;
            //         end
            //         else
            //             if Term = Term::FALL then begin
            //                 OldAY := "Academic year";
            //                 OldTerm := OldTerm::SPRING;
            //             end;

            //         CrsSemLn.Reset();
            //         //CrsSemLn.SetRange("Course Code", pGradeBookHdr.Course);
            //         CrsSemLn.SetFilter("Course Code", CourseFilter);
            //         CrsSemLn.SetRange("Sequence No", SemSeq);
            //         CrsSemLn.SetRange("Academic Year", OldAY);
            //         CrsSemLn.SetRange(Term, OldTerm);
            //         CrsSemLn.FindFirst();
            //         Sem2.Reset();
            //         Sem2.SetRange(Code, CrsSemLn."Semester Code");
            //         Sem2.FindFirst();


            //         //key(Key1; "Student No.", Course, Semester, 
            //         //"Academic Year", "Subject Code", Section, "Start Date")
            //         StudentSubjectOdd.Reset();
            //         StudentSubjectOdd.SetRange("Student No.", StudentSubject."Student No.");
            //         StudentSubjectOdd.SetRange(Course, StudentSubject.Course);
            //         StudentSubjectOdd.SetRange(Semester, CrsSemLn."Semester Code");
            //         // StudentSubjectGBOdd.SetRange("Academic Year", OldAY);// Blocked because of ELOA Gap
            //         // StudentSubjectGBOdd.SetRange("Subject Code", StudentSubject."Subject Code");
            //         // StudentSubjectOdd.SetRange(Term, OldTerm);// Blocked because of ELOA Gap
            //         StudentSubjectOdd.SetFilter(Grade, '<>%1', 'PNC');
            //         StudentSubjectOdd.FindLast();
            //         IF "Global Dimension 1 Code" = '9000' then//Lucky
            //             StudentSubjectOdd.TestField("Numeric Grade");

            //         StudentSubject."Numeric Grade" := NumericGrade + Round((StudentSubjectOdd."Numeric Grade" * MarksWeightage) / 100);// Stuti

            //         StudentSubject."Percentage Obtained" := Round(StudentSubject."Numeric Grade" * 100 / (Sem."Total Weightage" + Sem."Internal Total Weightage" + Sem2."Total Weightage" + Sem2."Internal Total Weightage"), 0.01);
            //     end;


            GradeMaster.Reset();
            GradeMaster.SetRange("Global Dimension 1 Code", pGradeBookHdr."Global Dimension 1 Code");
            GradeMaster.SetFilter("Min Percentage", '<=%1', StudentSubject."Percentage Obtained");
            GradeMaster.SetFilter("Max Percentage", '>=%1', StudentSubject."Percentage Obtained");
            GradeMaster.SetRange("Grade Book No.", pGradeBookHdr."Document No.");
            GradeMaster.SetRange("Blocked for Grading", false);
            GradeMaster.FindFirst();
            GradeMaster."Total Students" += 1;
            GradeMaster.Modify();

            StudentSubject.Grade := GradeMaster.Code;
            StudentSubject."Grade Book No." := pGradeBookHdr."Document No.";
            // StudentSubject.Modify(True);

            StudentSubjectGB.Reset();
            if StudentSubjectGB.FindLast() then;
            StudSubGBEntryNo := StudentSubjectGB."Entry No." + 1;

            StudentSubjectGB.Reset();
            StudentSubjectGB.Init();
            StudentSubjectGB.TransferFields(StudentSubject);
            StudentSubjectGB."Entry No." := StudSubGBEntryNo;
            StudentSubjectGB.Status := pGradeBookHdr.Status;

            if Sem."Temporary Grade" = '' then
                StudentSubjectGB."Grade To Be Published" := StudentSubject.Grade
            else
                StudentSubjectGB."Grade To Be Published" := Sem."Temporary Grade";
            IF Stud.Get(StudentSubjectGB."Student No.") then;
            RecRecommendationsGB.Reset();
            RecRecommendationsGB.SetRange("Global Dimension 1 Code", StudentSubjectGB."Global Dimension 1 Code");
            RecRecommendationsGB.SetRange(Semester, StudentSubjectGB.Semester);
            RecRecommendationsGB.SetFilter("Min Percentage", '<=%1', StudentSubjectGB."Percentage Obtained");
            RecRecommendationsGB.SetRange("Grade Book No.", StudentSubjectGB."Grade Book No.");
            RecRecommendationsGB.SetFilter("Max Percentage", '>=%1', StudentSubjectGB."Percentage Obtained");
            RecRecommendationsGB.SetRange("Academic SAP", Stud."Remaining Academic SAP");//Lucky
            If Stud."Remaining Academic SAP" <> 5 then
                RecRecommendationsGB.SetRange(Repeating, (Stud."Semester Decision" = Stud."Semester Decision"::"Repeat ") OR (Stud."Semester Decision" = Stud."Semester Decision"::Restart));//Lucky
            IF StudentSubjectGB.Semester = 'BSIC' then begin
                StudentSubjectExam.Reset();
                StudentSubjectExam.SetCurrentKey("Exam Sequence");
                StudentSubjectExam.SetRange("Student No.", StudentSubjectGB."Student No.");
                StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CBSE);
                StudentSubjectExam.SetAscending("Exam Sequence", false);
                IF StudentSubjectExam.FindFirst() then begin
                    RecRecommendationsGB.SetFilter("CBSE Min", '<=%1', StudentSubjectExam.Total);
                    RecRecommendationsGB.SetFilter("CBSE Max", '>=%1', StudentSubjectExam.Total);
                end;
            end;
            IF RecRecommendationsGB.FindFirst() then begin
                StudentSubjectGB."% Range" := RecRecommendationsGB."Range Percentage";
                StudentSubjectGB.Recommendation := RecRecommendationsGB.Recommendation;
                StudentSubjectGB.Communications := RecRecommendationsGB.Communications;//Lucky
            end;


            StudentSubjectGB.Failed := GradeMaster.Failed;
            CalcAcadSuggest(pGradeBookHdr, StudentSubjectGB."Student No.", StudentSubjectGB."Percentage Obtained", StudentSubjectGB.failed, StudentSubjectGB."Academic Suggestion", StudentSubjectGB.Course);
            // IF RecRecommendationsGB.Communications = '' then //CSPL-00307 
            //     CalcComm(StudentSubjectGB, StudentSubjectGB.Communications);
            StudentSubjectGB.Insert(True);
        // IF StudentSubjectGB."Global Dimension 1 Code" = '9000' then
        //     StudentSubjectGB.TestField(Communications);       //14March2022
        // SemesterPromotionsMail(StudentSubjectGB);//CSPL-00307
        until GradeBookUn.Next() = 0;
    end;

    procedure RecalculateGradeBook(pGradeBookHdr: Record "Grade Book Header")
    var
        GradeInput: Record "Marks Weightage Grade Book";
        GradeBook: Record "Grade Book";
        RecRecommendations: Record "Recommendations";
        GradeMaster: Record "Grade Master Grade Book";
        ExaminationMgmt: Codeunit "Examination Management";
    begin
        if pGradeBookHdr.Status = pGradeBookHdr.Status::Approved then
            Error('Grade Book cannot be recalculated as it is already approved');
        pGradeBookHdr.DocumentArchive(pGradeBookHdr);
        GradeBook.Reset();
        GradeBook.SetRange("Grade Book No.", pGradeBookHdr."Document No.");
        GradeBook.FindSet();
        repeat
            GradeInput.Reset();
            GradeInput.SetRange("Global Dimension 1 Code", GradeBook."Global Dimension 1 Code");
            GradeInput.SetRange("Exam Code", GradeBook."Exam Code");
            GradeInput.SetRange("Academic Year", GradeBook."Academic year");
            GradeInput.SetRange("Course Code", GradeBook.Course);
            GradeInput.SetRange(Semester, GradeBook.Semester);
            GradeInput.SetRange("Grade Book No.", pGradeBookHdr."Document No.");
            GradeInput.Setrange(Term, pGradeBookHdr.Term);
            GradeInput.FindFirst();

            GradeBook."Earned Points" := Round(((GradeBook."Percentage Obtained" / 100) * GradeInput.Points), 0.01, '=');
            GradeBook."Available Points" := GradeInput.Points;
            GradeBook."Earned Points Percentage" := Round((GradeBook."Earned Points" / GradeInput.Points) * 100, 0.01, '=');

            // RecRecommendations.Reset();
            // RecRecommendations.SetRange("Global Dimension 1 Code", GradeBook."Global Dimension 1 Code");
            // RecRecommendations.SetRange(Semester, GradeBook.Semester);
            // RecRecommendations.SetFilter("Min. Percentage", '<=%1', GradeBook."Earned Points Percentage");
            // RecRecommendations.SetFilter("Max Percentage", '>=%1', GradeBook."Earned Points Percentage");
            // IF RecRecommendations.FindFirst() then begin
            //     GradeBook."% Range" := RecRecommendations."Range Percentage";
            //     GradeBook.Recommendation := RecRecommendations.Recommendation;
            // end;

            GradeMaster.Reset();
            GradeMaster.SetRange("Global Dimension 1 Code", GradeBook."Global Dimension 1 Code");
            GradeMaster.SetFilter("Min Percentage", '<=%1', GradeBook."Earned Points Percentage");
            GradeMaster.SetFilter("Max Percentage", '>=%1', GradeBook."Earned Points Percentage");
            GradeMaster.SetRange("Grade Book No.", pGradeBookHdr."Document No.");
            GradeMaster.SetRange("Blocked for Grading", false);
            GradeMaster.FindFirst();
            GradeBook."Grade Result" := GradeMaster.Code;
            GradeBook.Grade := GradeMaster.Code;

            GradeBook.Modify();
            ExaminationMgmt.RunningTotalCalcData(GradeBook.Semester, GradeBook."Academic Year", GradeBook.Term, GradeBook."Global Dimension 1 Code");
        until GradeBook.Next() = 0;
    end;

    procedure SendGradeBookEmail(GradeBookHdr: Record "Grade Book Header"; PendAppRej: Integer)
    var

        SmtpMailRec: Record "Email Account";
        UserSetup: Record "User Setup";
        UserTab: Record User;
        SmtpMail: Codeunit "Email Message";
        WebServicesFunctionsCSCod: Codeunit "WebServicesFunctionsCSL";
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[250];
        Recipients: List of [Text];
        Recipient: Text[100];
        Body1: Text[2048];
        Body2: Text[2048];
        RcvrName: Text[150];
        RcvrId: Text[50];

    begin
        if (PendAppRej < 1) or (PendAppRej > 3) then
            Error('Wrong variable initalized');
        if PendAppRej = 1 then begin
            UserSetup.Reset();
            UserSetup.get(GradeBookHdr."To Be Approved By");
            UserSetup.TestField("E-Mail");
            Recipient := UserSetup."E-Mail";
            Subject := 'Grade Book pending for Aprroval';
            Body1 := 'This is to inform you that the Gradebook No. ' + GradeBookHdr."Document No." +
             ' for Semester ' + GradeBookHdr.Semester + ' & Term ' +
             Format(GradeBookHdr.Term) + ' has been received for approval.';
            Body2 := 'Kindly Approve/Reject the same.';
            UserTab.Reset();
            UserTab.SetRange("User Name", UserSetup."User ID");
            UserTab.FindFirst();
            RcvrName := UserTab."Full Name";
            RcvrId := UserSetup."User ID";
        end
        else
            if PendAppRej = 2 then begin
                UserSetup.Reset();
                UserSetup.get(GradeBookHdr."Send for Approval By");
                UserSetup.TestField("E-Mail");
                Recipient := UserSetup."E-Mail";
                Subject := 'Grade Book Approved';
                Body1 := 'This is to inform you that the Gradebook No. ' + GradeBookHdr."Document No." +
             ' for Semester ' + GradeBookHdr.Semester + ' & Term ' +
             Format(GradeBookHdr.Term) + ' Term has been Approved by Promotion Committee.';
                Body2 := '';
                UserTab.Reset();
                UserTab.SetRange("User Name", UserSetup."User ID");
                UserTab.FindFirst();
                RcvrName := UserTab."Full Name";
                RcvrId := UserSetup."User ID";
            end
            else
                if PendAppRej = 3 then begin
                    UserSetup.Reset();
                    UserSetup.get(GradeBookHdr."Send for Approval By");
                    UserSetup.TestField("E-Mail");
                    Recipient := UserSetup."E-Mail";
                    Subject := 'Grade Book Rejected';
                    Body1 := 'This is to inform you that the Gradebook No. ' + GradeBookHdr."Document No." +
             ' for Semester ' + GradeBookHdr.Semester + ' & Term ' +
             Format(GradeBookHdr.Term) + ' Term has been Rejected by Promotion Committee.';
                    Body2 := '';
                    UserTab.Reset();
                    UserTab.SetRange("User Name", UserSetup."User ID");
                    UserTab.FindFirst();
                    RcvrName := UserTab."Full Name";
                    RcvrId := UserSetup."User ID";
                end;


        SmtpMailRec.Get();
        Recipients := Recipient.Split(';');
        SenderName := 'MEA';
        SenderAddress := SmtpMailRec."Email Address";
        //SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');////GMCSCOM

        SmtpMail.AppendtoBody('Dear' + ' ' + RcvrName + ' ' + ',');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(Body1);
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(Body2);
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Regards,');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody(SenderName);
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
        //        SmtpMail.AppendtoBody('[THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD]');
        // Mail_lCU.Send();////GMCSCOM

        WebServicesFunctionsCSCod.ApiPortalinsertupdatesendNotification('GradeBookEmail', 'MEA', SenderAddress, RcvrName
        , RcvrId, Subject, Body1, 'GradeBook', '', '', format(Today(), 0, 9), Recipient, 1, '', '', 0);

    end;

    procedure PublishFinalGrades(pGradeBookHdr: Record "Grade Book Header"; IPGrade: Boolean; var pGradeToBePublished: Code[20])
    var
        Stud: Record "Student Master-CS";
        StudSubGB: Record "Student Subject GradeBook";
        StudSub: Record "Main Student Subject-CS";
        StudSubPNC: Record "Main Student Subject-CS";
        Crs: Record "Course Master-CS";
        CrsSubLn: Record "Course Wise Subject Line-CS";
        CrsSemLn: Record "Course Sem. Master-CS";
        RecGradBook: Record "Grade Book";
        NewSem: Code[20];
        PubInt: Integer;
        SemSeq: Integer;
        PrevStudent: Text;
    begin
        PubInt := 0;
        StudSubGB.Reset();
        StudSubGB.SetCurrentKey("Student No.");		//Doubt
        StudSubGB.SetRange("Grade Book No.", pGradeBookHdr."Document No.");
        StudSubGB.SetAscending("Student No.", true);
        if StudSubGB.FindSet() then begin
            repeat
                // key(Key1; "Student No.", Course, Semester, "Academic Year", "Subject Code", 
                //Section, "Start Date")
                IF Rec."Global Dimension 1 Code" = '9000' then begin
                    StudSub.Reset();
                    StudSub.SetRange("Student No.", StudSubGB."Student No.");
                    StudSub.SetRange(Course, StudSubGB.Course);
                    StudSub.SetRange(Semester, StudSubGB.Semester);
                    StudSub.SetRange("Academic Year", StudSubGB."Academic Year");
                    StudSub.SetRange("Subject Code", StudSubGB."Subject Code");
                    StudSub.SetRange(Section, StudSubGB.Section);
                    StudSub.SetRange("Global Dimension 1 Code", StudSubGB."Global Dimension 1 Code");
                    StudSub.SetRange(Term, StudSubGB.Term);
                    StudSub.FindLast();

                    StudSub."Percentage Obtained" := StudSubGB."Percentage Obtained";
                    if StudSubGB.Failed then
                        StudSub."Credit Earned" := 0
                    else
                        StudSub."Credit Earned" := StudSub.Credit;
                    StudSub."Numeric Grade" := StudSubGB."Numeric Grade";
                    // StudSub."Credit Earned" := StudSubGB."Credit Earned";
                    // StudSub."Numeric Grade" := StudSubGB."Credit Earned";

                    if IPGrade then begin
                        StudSub.Validate(Grade, StudSubGB."Grade To Be Published");
                        // StudSub.Validate(Grade, pGradeToBePublished);
                        // StudSubGB."Grade To Be Published" := StudSub.Grade;
                        pGradeToBePublished := '';
                    end
                    else begin
                        IF pGradeBookHdr.Status <> pGradeBookHdr.Status::Published then
                            pGradeToBePublished := '';
                        if pGradeToBePublished <> '' then begin
                            StudSub.validate(Grade, pGradeToBePublished);
                            StudSubGB.Validate("Grade To Be Published", pGradeToBePublished);
                        end
                        else begin
                            StudSub.validate(Grade, StudSubGB.Grade);
                            pGradeToBePublished := StudSub.Grade;
                        end;
                    end;
                    StudSub."Grade Book No." := StudSubGB."Grade Book No.";
                    StudSub."% Range" := StudSubGB."% Range";
                    StudSub.Recommendation := StudSubGB.Recommendation;
                    StudSub."Grade Confirmed" := true;
                    StudSub.Modify(True);
                end else
                    IF Rec."Global Dimension 1 Code" = '9100' then begin
                        RecGradBook.Reset();
                        RecGradBook.SetRange("Grade Book No.", Rec."Document No.");
                        RecGradBook.SetRange("Student No.", StudSubGB."Student No.");
                        // RecGradBook.SetRange("Exam Code",StudSubGB."Subject Code");
                        if RecGradBook.FindFirst() then begin
                            repeat
                                StudSub.Reset();
                                StudSub.SetRange("Student No.", StudSubGB."Student No.");
                                StudSub.SetRange(Course, StudSubGB.Course);
                                StudSub.SetRange(Semester, StudSubGB.Semester);
                                StudSub.SetRange("Academic Year", StudSubGB."Academic Year");
                                StudSub.SetRange("Subject Code", RecGradBook."Exam Code");
                                StudSub.SetRange(Section, StudSubGB.Section);
                                StudSub.SetRange("Global Dimension 1 Code", StudSubGB."Global Dimension 1 Code");
                                StudSub.SetRange(Term, StudSubGB.Term);
                                StudSub.FindLast();
                                StudSub."Percentage Obtained" := RecGradBook."Percentage Obtained";
                                if StudSubGB.Failed then
                                    StudSub."Credit Earned" := 0
                                else
                                    StudSub."Credit Earned" := StudSub.Credit;
                                StudSub."Numeric Grade" := StudSubGB."Numeric Grade";
                                if IPGrade then begin
                                    StudSub.Validate(Grade, RecGradBook.Grade);
                                    pGradeToBePublished := '';
                                end
                                else begin
                                    IF pGradeBookHdr.Status <> pGradeBookHdr.Status::Published then
                                        pGradeToBePublished := '';
                                    if pGradeToBePublished <> '' then begin
                                        StudSub.validate(Grade, pGradeToBePublished);
                                        StudSubGB.Validate("Grade To Be Published", pGradeToBePublished);
                                    end
                                    else begin
                                        StudSub.validate(Grade, RecGradBook.Grade);
                                        pGradeToBePublished := StudSub.Grade;
                                    end;
                                end;
                                StudSub."Grade Book No." := StudSubGB."Grade Book No.";
                                StudSub."% Range" := RecGradBook."% Range";
                                StudSub.Recommendation := RecGradBook.Recommendation;
                                StudSub."Grade Confirmed" := true;
                                StudSub.Modify(True);
                            until RecGradBook.Next() = 0;
                        end;
                    end;

                StudSubGB.Status := StudSubGB.Status::Published;
                CalcAcadSuggest(pGradeBookHdr, StudSubGB."Student No.", StudSubGB."Percentage Obtained", StudSubGB.failed, StudSubGB."Academic Suggestion", StudSubGB.Course);
                //aaa
                IF pGradeBookHdr.Status <> pGradeBookHdr.Status::Published then begin//Lucky
                    Stud.Reset();
                    Stud.Get(StudSubGB."Student No.");
                    if StudSubGB."Academic Suggestion" = StudSubGB."Academic Suggestion"::Dismiss then begin
                        Stud.Validate(Status, 'DIS');
                        If Stud."Student SFP Initiation" <> 0 then
                            Stud."SAFI Sync" := Stud."SAFI Sync"::Pending;              //10-11-2021
                        Stud.Modify(true);
                    end
                    else
                        if StudSubGB."Academic Suggestion" = StudSubGB."Academic Suggestion"::Progress then begin
                            CrsSemLn.Reset();
                            CrsSemLn.SetRange("Course Code", StudSubGB.Course);
                            CrsSemLn.SetRange("Semester Code", StudSubGB.Semester);
                            CrsSemLn.SetRange("Academic Year", StudSubGB."Academic year");
                            CrsSemLn.SetRange(Term, StudSubGB.Term);
                            CrsSemLn.FindFirst();
                            SemSeq := CrsSemLn."Sequence No";

                            CrsSemLn.Reset();
                            CrsSemLn.SetRange("Course Code", StudSubGB.Course);
                            CrsSemLn.SetRange("Sequence No", (SemSeq + 1));
                            CrsSemLn.SetRange("Academic Year", StudSubGB."Academic year");
                            CrsSemLn.SetRange(Term, StudSubGB.Term);
                            if CrsSemLn.FindFirst() AND (StudSubGB.Semester <> 'BSIC') then
                                NewSem := CrsSemLn."Semester Code"
                            else
                                NewSem := StudSubGB.Semester;

                            StudSubGB."Old Semester" := StudSubGB.Semester;
                            StudSubGB."New Semester" := NewSem;

                            Stud.Validate(Semester, NewSem);
                            // Code for OLR Tables
                            Stud.SemesterDecisionInsert(Stud, Stud."Semester Decision");
                            If Stud."Student SFP Initiation" <> 0 then
                                Stud."SAFI Sync" := Stud."SAFI Sync"::Pending;                  //10-11-2021
                            Stud.Modify(true);

                            ////////////////
                            //Prev Grade
                            ////////////////
                        end;
                end;
                StudSubGB.Modify(True);
                PubInt += 1;

                Crs.Reset();
                Crs.Get(StudSubGB.Course);
                if Crs."Additional Subject Grade" <> '' then begin
                    CrsSubLn.Reset();
                    CrsSubLn.SetRange("Course Code", Crs.code);
                    CrsSubLn.SetRange(Semester, StudSubGB.Semester);
                    CrsSubLn.SetRange("Academic Year", StudSubGB."Academic Year");
                    // CrsSubLn.SetRange(Term, StudSubGB.Term);
                    CrsSubLn.SetRange("Subject Code", StudSubGB."Subject Code");
                    CrsSubLn.FindFirst();
                    if CrsSubLn."Additional Subject" <> '' then begin
                        StudSubPNC.Reset();
                        // key(Key1; "Student No.", Course, Semester, "Academic Year",
                        // "Subject Code", Section, "Start Date")
                        StudSubPNC.SetRange("Student No.", StudSubGB."Student No.");
                        StudSubPNC.SetRange(Course, StudSubGB.Course);
                        StudSubPNC.SetRange(Semester, StudSubGB.Semester);
                        StudSubPNC.SetRange("Academic Year", StudSubGB."Academic Year");
                        StudSubPNC.SetRange("Subject Code", CrsSubLn."Additional Subject");
                        StudSubPNC.SetRange(Section, StudSubGB.Section);
                        StudSubPNC.SetRange("Start Date", StudSubGB."Start Date");
                        StudSubPNC.FindFirst();
                        StudSubPNC.Validate(Grade, Crs."Additional Subject Grade");
                        StudSubPNC."Grade Confirmed" := true;
                        StudSubPNC.Modify(true);
                        Stud.Reset();
                        If Stud.Get(StudSubPNC."Student No.") then begin
                            If Stud."Student SFP Initiation" <> 0 then begin
                                Stud."SAFI Sync" := Stud."SAFI Sync"::Pending;                      //10-11-2021
                                Stud.Modify();
                            end;
                        end;

                    end;
                end;
            //CSPL-00307 Starts
            // IF PrevStudent <> StudSubGB."Student No." then begin
            //     PrevStudent := StudSubGB."Student No.";
            //     Stud.CalculateSAP(Stud);
            //     StudSubGB.TestField(Communications);
            //     SemesterPromotionsMail(StudSubGB);
            // end;
            //CSPL-00307 ENds
            until StudSubGB.Next() = 0;
            if PubInt > 0 then begin
                pGradeBookHdr.validate(Status, pGradeBookHdr.Status::Published);
                pGradeBookHdr."Published By" := UserId();
                pGradeBookHdr."Published On" := Today();
                pGradeBookHdr."Published Time" := Time();

                pGradeBookHdr.Modify(True);
                Message('Grade Book %1 has been published', pGradeBookHdr."Document No.");
            end;

        end;
    end;

    procedure CalcAcadSuggest(pGradeBookHdr: Record "Grade Book Header";
    StudNo: Code[20]; ScorePer: Decimal; Failed: Boolean; var AcaSugg: Option " ",Progress,Dismiss; pCourse: Code[20])
    var
        CrsSem: Record "Course Sem. Master-CS";
        Stud: Record "Student Master-CS";
    begin
        CrsSem.Reset();
        CrsSem.SetRange("Course Code", pCourse);
        CrsSem.SetRange("Semester Code", pGradeBookHdr.Semester);
        CrsSem.SetRange("Academic Year", pGradeBookHdr."Academic year");
        CrsSem.SetRange("Global Dimension 1 Code", pGradeBookHdr."Global Dimension 1 Code");
        CrsSem.SetRange(Term, pGradeBookHdr.Term);
        CrsSem.FindFirst();
        CrsSem.TestField("Dismissal Percentage");
        Stud.Reset();
        Stud.Get(StudNo);
        if ScorePer < CrsSem."Dismissal Percentage" then
            AcaSugg := AcaSugg::Dismiss
        else begin
            if Failed then begin
                if (CrsSem."Sequence No" = 2) or (CrsSem."Sequence No" = 4) then begin
                    //if Stud."Remaining Academic SAP" >= 6 then
                    AcaSugg := AcaSugg::Dismiss;
                    // else
                    //     AcaSugg := AcaSugg::Progress;
                end
                else
                    if (CrsSem."Sequence No" = 1) or (CrsSem."Sequence No" = 3) then
                        AcaSugg := AcaSugg::Progress
                    else
                        if CrsSem."Sequence No" = 5 then begin
                            //if Stud."Remaining Academic SAP" >= 7 then
                            AcaSugg := AcaSugg::Dismiss;
                            // else
                            //     AcaSugg := AcaSugg::" ";
                        end;


            end
            else
                AcaSugg := AcaSugg::Progress;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        ReasonVisible := false;
        if Rec.Status in [Rec.Status::"Pending For Approval", Rec.Status::Rejected] then
            ReasonVisible := true;

        PublishShow := false;
        IF Rec."Global Dimension 1 Code" = '9000' then
            IF Rec.Status = Rec.Status::Approved then
                PublishShow := true;

        IF Rec."Global Dimension 1 Code" = '9100' then
            PublishShow := true;
    end;

    trigger OnOpenPage()
    begin
        ReasonVisible := false;
        if Rec.Status in [Rec.Status::"Pending For Approval", Rec.Status::Rejected] then
            ReasonVisible := true;

        ActionSendForApp := false;
        if Rec.Status in [Rec.Status::Open, Rec.Status::Rejected] then
            IF Rec."Global Dimension 1 Code" = '9000' then
                ActionSendForApp := true;
        if GradeBookNo <> '' then
            Rec.SetRange(Rec."Document No.", GradeBookNo);

        PublishShow := false;
        IF Rec."Global Dimension 1 Code" = '9000' then
            IF Rec.Status = Rec.Status::Approved then
                PublishShow := true;

        IF Rec."Global Dimension 1 Code" = '9100' then
            PublishShow := true;

    end;

    procedure GetGradeBookNo(pGradeBookNo: Code[20])
    begin
        GradeBookNo := pGradeBookNo;
    end;

    procedure CalcComm(pStudentSubjectGB: Record "Student Subject GradeBook"; var Comm: Text[2048])
    var
        Stud: Record "Student Master-CS";
    begin
        Stud.Reset();
        Stud.Get(pStudentSubjectGB."Student No.");
        if not pStudentSubjectGB.Failed then
            Comm := 'Congratulations!  You will progress to the second half of Year ' + 'in Spring 2020.  You are encouraged to maintain your current level of academic performance and seek ways of performing even better.';
    end;


    var
        GradeBookNo: Code[20];
        ReasonVisible: Boolean;
        ActionSendForApp: Boolean;
        PublishShow: Boolean;

    procedure CalculateGPA(GradeBook: Record "Grade Book"; StudentNo: Code[20])
    var
        Stud: Record "Student Master-CS";
        StudentMaster: Record "Student Master-CS";
        CourseMasterRec1: Record "Course Master-CS";
        CourseMasterRec: Record "Course Master-CS";
        StudSub: Record "Main Student Subject-CS";
        Grade: Record "Grade Master-CS";
        StudentSubjectGradeBook: Record "Student Subject GradeBook";
        MultipleEnrollmentBool: Boolean;
        CourseFilter: Text;
        SemesterTxt: Text;
        TotQualityPoint: Decimal;
        GradePointsArr: Decimal;
        CreditAttemptArr: DEcimal;
        GPA: Decimal;
        int: Integer;
        TotCreditAttempt: Decimal;
    Begin
        Stud.Reset();
        IF Stud.Get(StudentNo) then;
        MultipleEnrollmentBool := false;
        CourseMasterRec1.Reset();
        CourseMasterRec1.SetRange(Code, Stud."Course Code");
        IF CourseMasterRec1.FindFirst() then
            IF CourseMasterRec1."Transcript Data Filter" then
                MultipleEnrollmentBool := true;

        If MultipleEnrollmentBool then begin
            CourseFilter := '';
            CourseMasterRec.Reset();
            CourseMasterRec.SetRange("Transcript Data Filter", true);
            IF CourseMasterRec.FindSet() then begin
                repeat

                    IF CourseFilter = '' then
                        CourseFilter := CourseMasterRec.Code
                    Else
                        CourseFilter += '|' + CourseMasterRec.Code;
                until CourseMasterRec.Next() = 0;
            end;
        end;
        if (Stud."Course Code" <> '') and (Stud.Status <> '') then begin
            StudentMaster.Reset();
            If not MultipleEnrollmentBool then begin
                StudentMaster.SetRange("Enrollment No.", Stud."Enrollment No.");
                StudentMaster.SetRange("Course Code", Stud."Course Code");
            end;
            If MultipleEnrollmentBool then begin
                StudentMaster.SetRange("Original Student No.", Stud."Original Student No.");
                StudentMaster.SetFilter("Course Code", CourseFilter);
            end;
            StudentMaster.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
            If StudentMaster.FindSet() then begin
                repeat
                    Clear(GradePointsArr);
                    Clear(CreditAttemptArr);
                    Clear(GPA);
                    SemesterTxt := '';
                    TotQualityPoint := 0;
                    TotCreditAttempt := 0;

                    StudSub.Reset();
                    StudSub.SetCurrentKey(Semester);
                    If MultipleEnrollmentBool then begin
                        StudSub.SetRange("Original Student No.", StudentMaster."Original Student No.");
                        StudSub.SetFilter(Course, CourseFilter);
                    end;
                    If not MultipleEnrollmentBool then begin
                        StudSub.SetRange(Course, StudentMaster."Course Code");
                        StudSub.SetRange("Student No.", StudentMaster."No.");
                    end;
                    StudSub.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    Studsub.Setfilter(Semester, '<>%1', '');
                    StudSub.SetFilter("Level Description", '<>%1&<>%2', StudSub."Level Description"::"Level 2 Clinical Rotation", StudSub."Level Description"::"Level 2 Elective Rotation");
                    StudSub.SetRange(TC, false);
                    StudSub.SetRange(Semester, GradeBook.Semester);
                    if StudSub.FindSet() then
                        repeat
                            Int := Studsub.Sequence;
                            SemesterTxt := Studsub.Semester;
                            IF SemesterTxt = StudSub.Semester then begin
                                Grade.Reset();
                                Grade.SetRange(Code, StudSub.Grade);
                                Grade.SetRange("Global Dimension 1 Code", StudSub."Global Dimension 1 Code");
                                if Grade.FindFirst() then begin
                                    If Grade."Consider for GPA" then begin
                                        CreditAttemptArr += StudSub."Credits Attempt"; //for non Clinicals
                                        TotCreditAttempt += StudSub."Credits Attempt";
                                    end;
                                    GradePointsArr += Grade."Grade Points" * StudSub."Credits Attempt";
                                    TotQualityPoint += Grade."Grade Points" * StudSub."Credits Attempt";
                                end;

                                // if ((Grade."Grade Points" * StudSub."Credit Earned") = 0) or (StudSub."Credit Earned" = 0) then
                                //     Error('Earned Credits %4..%5...Sequence %6.... not matching Student %1..Semester %2..Grade %3', StudSub."Student No.", StudSub.Semester, StudSub.Grade, StudSub."Credit Earned", Grade.Description,
                                //         StudSub.Sequence);



                            end;
                        until StudSub.Next() = 0;
                    StudentSubjectGradeBook.Reset();
                    StudentSubjectGradeBook.SetRange("Grade Book No.", GradeBook."Grade Book No.");
                    StudentSubjectGradeBook.SetRange("Student No.", GradeBook."Student No.");
                    If StudentSubjectGradeBook.FindFirst() then begin
                        IF CreditAttemptArr <> 0 then begin
                            StudentSubjectGradeBook.GPA := Round(GradePointsArr / CreditAttemptArr);
                            StudentSubjectGradeBook.Modify();
                        end;
                    end
                Until StudentMaster.Next() = 0;
            end;

        End;
    end;

    procedure CalculateGPAForGradeBook(GradeBook: Record "Grade Book"; StudentNo: Code[20])
    var
        Stud: Record "Student Master-CS";
        StudentMaster: Record "Student Master-CS";
        CourseMasterRec1: Record "Course Master-CS";
        CourseMasterRec: Record "Course Master-CS";
        StudSub: Record "Main Student Subject-CS";
        Grade: Record "Grade Master-CS";
        StudentSubjectGradeBook: Record "Student Subject GradeBook";
        MultipleEnrollmentBool: Boolean;
        CourseFilter: Text;
        SemesterTxt: Text;
        TotQualityPoint: Decimal;
        GradePointsArr: Decimal;
        CreditAttemptArr: DEcimal;
        GPA: Decimal;
        int: Integer;
        TotCreditAttempt: Decimal;
    Begin
        Stud.Reset();
        IF Stud.Get(StudentNo) then;
        MultipleEnrollmentBool := false;
        CourseMasterRec1.Reset();
        CourseMasterRec1.SetRange(Code, Stud."Course Code");
        IF CourseMasterRec1.FindFirst() then
            IF CourseMasterRec1."Transcript Data Filter" then
                MultipleEnrollmentBool := true;

        If MultipleEnrollmentBool then begin
            CourseFilter := '';
            CourseMasterRec.Reset();
            CourseMasterRec.SetRange("Transcript Data Filter", true);
            IF CourseMasterRec.FindSet() then begin
                repeat

                    IF CourseFilter = '' then
                        CourseFilter := CourseMasterRec.Code
                    Else
                        CourseFilter += '|' + CourseMasterRec.Code;
                until CourseMasterRec.Next() = 0;
            end;
        end;
        if (Stud."Course Code" <> '') and (Stud.Status <> '') then begin
            StudentMaster.Reset();
            If not MultipleEnrollmentBool then begin
                StudentMaster.SetRange("Enrollment No.", Stud."Enrollment No.");
                StudentMaster.SetRange("Course Code", Stud."Course Code");
            end;
            If MultipleEnrollmentBool then begin
                StudentMaster.SetRange("Original Student No.", Stud."Original Student No.");
                StudentMaster.SetFilter("Course Code", CourseFilter);
            end;
            StudentMaster.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
            If StudentMaster.FindSet() then begin
                repeat
                    Clear(GradePointsArr);
                    Clear(CreditAttemptArr);
                    Clear(GPA);
                    SemesterTxt := '';
                    TotQualityPoint := 0;
                    TotCreditAttempt := 0;

                    StudSub.Reset();
                    StudSub.SetCurrentKey(Semester);
                    If MultipleEnrollmentBool then begin
                        StudSub.SetRange("Original Student No.", StudentMaster."Original Student No.");
                        StudSub.SetFilter(Course, CourseFilter);
                    end;
                    If not MultipleEnrollmentBool then begin
                        StudSub.SetRange(Course, StudentMaster."Course Code");
                        StudSub.SetRange("Student No.", StudentMaster."No.");
                    end;
                    //StudSub.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    Studsub.Setfilter(Semester, '<>%1', '');
                    StudSub.SetFilter("Level Description", '<>%1&<>%2', StudSub."Level Description"::"Level 2 Clinical Rotation", StudSub."Level Description"::"Level 2 Elective Rotation");
                    StudSub.SetRange(TC, false);
                    StudSub.SetRange(Semester, GradeBook.Semester);
                    if StudSub.FindSet() then
                        repeat
                            Int := Studsub.Sequence;
                            SemesterTxt := Studsub.Semester;
                            IF SemesterTxt = StudSub.Semester then begin
                                StudentSubjectGradeBook.Reset();
                                StudentSubjectGradeBook.SetRange("Student No.", StudSub."Student No.");
                                StudentSubjectGradeBook.SetRange(Semester, StudSub.Semester);
                                StudentSubjectGradeBook.SetRange(Course, StudSub.Course);
                                StudentSubjectGradeBook.SetRange("Subject Code", StudSub."Subject Code");
                                IF StudentSubjectGradeBook.FindFirst() then begin
                                    Grade.Reset();
                                    Grade.SetRange(Code, StudentSubjectGradeBook."Grade To Be Published");
                                    Grade.SetRange("Global Dimension 1 Code", StudSub."Global Dimension 1 Code");
                                    if Grade.FindFirst() then begin
                                        If Grade."Consider for GPA" then begin
                                            CreditAttemptArr += StudSub.Credit; //for non Clinicals
                                            TotCreditAttempt += StudSub.Credit;
                                        end;
                                        GradePointsArr += Grade."Grade Points" * StudSub.Credit;
                                        TotQualityPoint += Grade."Grade Points" * StudSub.Credit;
                                    end;
                                end;
                            end;
                        until StudSub.Next() = 0;
                    StudentSubjectGradeBook.Reset();
                    StudentSubjectGradeBook.SetRange("Grade Book No.", GradeBook."Grade Book No.");
                    StudentSubjectGradeBook.SetRange("Student No.", StudentNo);
                    If StudentSubjectGradeBook.FindFirst() then begin
                        IF CreditAttemptArr <> 0 then begin
                            StudentSubjectGradeBook.GPA := Round(GradePointsArr / CreditAttemptArr);
                            StudentSubjectGradeBook.Modify();
                        end;
                    end
                Until StudentMaster.Next() = 0;
            end;

        End;
    end;

    procedure SemesterPromotionsMail(StudentSubjectGradeBook: Record "Student Subject GradeBook")
    var
        SMTPMailSetup: Record "Email Account";
        Studentmaster: Record "Student Master-CS";
        StudentSubjectExam: record "Student Subject Exam";
        Recomendations: Record Recommendations;
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        SMTPMail: codeunit "Email Message";
        Recipients: List of [Text];
        Recipient: Text;
        SenderAddress: Text[250];
        Subject: Text[100];
        BodyText: Text;
        Grade: Code[10];
        Percent: Decimal;

        CBSEScrore: Decimal;
    begin
        IF StudentSubjectGradeBook."Global Dimension 1 Code" = '9000' then begin
            SMTPMailSetup.GET;
            Grade := StudentSubjectGradeBook."Grade To Be Published";
            Percent := StudentSubjectGradeBook."Percentage Obtained";
            Clear(CBSEScrore);
            IF StudentSubjectGradeBook.Semester = 'BSIC' then begin
                StudentSubjectExam.Reset();
                StudentSubjectExam.SetCurrentKey("Exam Sequence");
                StudentSubjectExam.SetRange("Student No.", StudentSubjectGradeBook."Student No.");
                StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CBSE);
                StudentSubjectExam.SetAscending("Exam Sequence", false);
                IF StudentSubjectExam.FindFirst() then begin
                    CBSEScrore := StudentSubjectExam.Total;
                end;
            end;
            Studentmaster.Reset();
            if Studentmaster.GET(StudentSubjectGradeBook."Student No.") then;
            // Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
            //Recipient := 'nfernandez@auamed.org';
            Recipient := 'ajay.khare@corporateserve.com';
            Recipients := Recipient.Split(';');
            SenderAddress := SmtpMailSetup."Email Address";
            Subject := 'Semester Progression for Student ID -' + Studentmaster."Original Student No.";
            CLEAR(SMTPMail);
            //SMTPMail.Create('MEA', SmtpMailSetup."Email Address", Recipients, Subject, '');//GMCSCOM
            // SMTPMail.AppendtoBody('<font face = "Book Antiqua">');
            Smtpmail.AppendtoBody('Dear ' + Studentmaster."Student Name" + ',');
            Smtpmail.AppendtoBody('<br/>');
            Smtpmail.AppendtoBody('<br/>');
            IF StudentSubjectGradeBook.Semester IN ['MED1', 'MED3'] Then begin
                SMTPMail.AppendtoBody(StudentSubjectGradeBook.Semester + ' Grade : ' + Grade + '<br/>');
                SMTPMail.AppendtoBody(StudentSubjectGradeBook.Semester + ' Percent : ' + Format(Percent) + '%');
            end else
                IF StudentSubjectGradeBook.Semester = 'MED2' Then begin
                    SMTPMail.AppendtoBody('Year 1 Grade : ' + Grade + '<br/>');
                    SMTPMail.AppendtoBody('Year 1 Percent :' + Format(Percent) + '%');
                end else
                    IF StudentSubjectGradeBook.Semester = 'MED4' Then begin
                        SMTPMail.AppendtoBody('Year 2 Grade : ' + Grade + ' <br/>');
                        SMTPMail.AppendtoBody('Year 2 Percent : ' + Format(Percent) + '%');
                    end else
                        IF StudentSubjectGradeBook.Semester = 'BSIC' Then begin
                            SMTPMail.AppendtoBody('CBSE score : ' + Format(CBSEScrore) + '<br/>');
                            SMTPMail.AppendtoBody('BSIC grade :  ' + Grade + ' <br/>');
                            SMTPMail.AppendtoBody('BSIC  percent : ' + Format(Percent) + '%');
                        end;
            Smtpmail.AppendtoBody('<br/>');
            Smtpmail.AppendtoBody('<br/>');
            SMTPMail.AppendtoBody(StudentSubjectGradeBook.Communications);
            Smtpmail.AppendtoBody('<br><br>You have the right to appeal a grade or a dismissal to the Appeals Committee using this <a href="https://auamed-my.sharepoint.com/:w:/g/personal/examcenter_auamed_net/EU9fvr9ozfpNhoxZV_iAxyYBMaJ_wvJc2MQBnNnQJKZ3lw?e=dn4v1K">form</a>.  Completed appeals must be emailed to appeals@auamed.net within seven calendar days of the date of this email.<br/><br/>');
            SMTPMail.AppendtoBody('<table border="1">');
            SMTPMail.AppendtoBody('<tr>');
            SMTPMail.AppendtoBody('<th>Subject</th>');
            SMTPMail.AppendtoBody('<th>Percentage Obtained</th>');
            SMTPMail.AppendtoBody('<th>Grade</th>');
            SMTPMail.AppendtoBody('</tr>');
            StudentSubjectExam.Reset();
            StudentSubjectExam.SetRange("Student No.", StudentSubjectGradeBook."Student No.");
            StudentSubjectExam.SetRange("Grade Book No.", StudentSubjectGradeBook."Grade Book No.");
            IF StudentSubjectExam.FindSet() then begin
                repeat
                    SMTPMail.AppendtoBody('<tr>');
                    SMTPMail.AppendtoBody('<td>' + StudentSubjectExam.Description + '</td>');
                    SMTPMail.AppendtoBody('<td>' + Format(StudentSubjectExam."Percentage Obtained") + '</td>');
                    SMTPMail.AppendtoBody('<td>' + StudentSubjectExam.Grade + '</td>');
                    SMTPMail.AppendtoBody('</tr>');
                until StudentSubjectExam.Next() = 0;
                SMTPMail.AppendtoBody('</table>');
                Smtpmail.AppendtoBody('<br/>');
                Smtpmail.AppendtoBody('<br/>');
            end;
            Smtpmail.AppendtoBody('<b><u>Grade Legend</u></b><br/>');
            SMTPMail.AppendtoBody('Honors (H) <br/>');
            SMTPMail.AppendtoBody('High Pass (HP) <br/>');
            SMTPMail.AppendtoBody('Pass (P) <br/>');
            SMTPMail.AppendtoBody('Fail (F) <br/>');
            SMTPMail.AppendtoBody('In Progress (IP) <br/>');
            Smtpmail.AppendtoBody('<br/><br/>');
            Smtpmail.AppendtoBody('Neville Fernandez M.D. <br>');
            Smtpmail.AppendtoBody('Professor, Office of Academic Outcomes <br>');
            Smtpmail.AppendtoBody('Director Exam Center/Campus Chief Proctor ');
            // SMTPMail.AppendtoBody('</font>');
            BodyText := SmtpMail.GetBody();
            //Mail_lCU.Send();////GMCSCOM
            // MESSAGE('Mail sent');
            //FOR NOTIFICATION +
            WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Semester Promotions Email Alert', 'MEA', SenderAddress, Studentmaster."Student Name",
            Format(Studentmaster."No."), Subject, BodyText, 'Semester Promotions Email Alert', 'Semester Promotions Email Alert', Format(Rec."Document No."), Format(WorkDate(), 0, 9),
            Recipient, 1, Studentmaster."Mobile Number", '', 1);
            //FOR NOTIFICATION -
            InsertNote(Studentmaster."No.", StudentSubjectGradeBook.Communications);
        end else
            IF StudentSubjectGradeBook."Global Dimension 1 Code" = '9100' then begin
                SMTPMailSetup.GET;
                Grade := StudentSubjectGradeBook.Grade;
                Percent := StudentSubjectGradeBook."Percentage Obtained";

                Studentmaster.Reset();
                if Studentmaster.GET(StudentSubjectGradeBook."Student No.") then;
                Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
                Recipient := Studentmaster."E-Mail Address";
                // Recipient := 'stuti.khandelwal@corporateserve.com;ajay.khare@corporateserve.com;lucky.kumar@corporateserve.com';
                Recipients := Recipient.Split(';');
                SenderAddress := SmtpMailSetup."Email Address";
                Subject := 'Semester Progression for Student ID -' + Studentmaster."Original Student No.";
                CLEAR(SMTPMail);
                // SMTPMail.Create('MEA', SmtpMailSetup."Email Address", Recipients, Subject, '');//GMCSCOM
                Smtpmail.AppendtoBody('Dear ' + Studentmaster."Student Name" + ',');
                Smtpmail.AppendtoBody('<br/>');
                Smtpmail.AppendtoBody('<br/>');
                SMTPMail.AppendtoBody(StudentSubjectGradeBook.Communications);
                Smtpmail.AppendtoBody('<br/><br/>');
                SMTPMail.AppendtoBody('<table border="1">');
                SMTPMail.AppendtoBody('<tr>');
                SMTPMail.AppendtoBody('<th>Subject</th>');
                SMTPMail.AppendtoBody('<th>Percentage Obtained</th>');
                SMTPMail.AppendtoBody('<th>Grade</th>');
                SMTPMail.AppendtoBody('</tr>');
                StudentSubjectExam.Reset();
                StudentSubjectExam.SetRange("Student No.", StudentSubjectGradeBook."Student No.");
                StudentSubjectExam.SetRange("Grade Book No.", StudentSubjectGradeBook."Grade Book No.");
                IF StudentSubjectExam.FindSet() then begin
                    repeat
                        SMTPMail.AppendtoBody('<tr>');
                        SMTPMail.AppendtoBody('<td>' + StudentSubjectExam.Description + '</td>');
                        SMTPMail.AppendtoBody('<td>' + Format(StudentSubjectExam."Percentage Obtained") + '</td>');
                        SMTPMail.AppendtoBody('<td>' + StudentSubjectExam.Grade + '</td>');
                        SMTPMail.AppendtoBody('</tr>');
                    until StudentSubjectExam.Next() = 0;
                    SMTPMail.AppendtoBody('</table>');
                    Smtpmail.AppendtoBody('<br/>');
                    Smtpmail.AppendtoBody('<br/>');
                end;
                Smtpmail.AppendtoBody('Regards <br>');
                Smtpmail.AppendtoBody('Registrar Department');
                BodyText := SmtpMail.GetBody();
                // Mail_lCU.Send();//GMCSCOM
                // MESSAGE('Mail sent');
                //FOR NOTIFICATION +
                WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Semester Promotions Email Alert', 'MEA', SenderAddress, Studentmaster."Student Name",
                Format(Studentmaster."No."), Subject, BodyText, 'Semester Promotions Email Alert', 'Semester Promotions Email Alert', Format(Rec."Document No."), Format(WorkDate(), 0, 9),
                Recipient, 1, Studentmaster."Mobile Number", '', 1);
                //FOR NOTIFICATION -
                InsertNote(Studentmaster."No.", StudentSubjectGradeBook.Communications);
            end;
    end;

    procedure PublishFinalGradesNonGradeBook(pGradeBookHdr: Record "Grade Book Header"; IPGrade: Boolean; pGradeToBePublished: Code[20]; pGD: Code[20]; pCourseCode: Text; pSem: Code[20]; pAY: Code[20]; pTerm: Option "FALL","SPRING","SUMMER")
    var
        Stud: Record "Student Master-CS";
        StudSubGB: Record "Student Subject GradeBook";
        StudSub: Record "Main Student Subject-CS";
        StudSubPNC: Record "Main Student Subject-CS";
        Crs: Record "Course Master-CS";
        CrsSubLn: Record "Course Wise Subject Line-CS";
        CrsSemLn: Record "Course Sem. Master-CS";
        RecGradBook: Record "Grade Book";
        NewSem: Code[20];
        PubInt: Integer;
        SemSeq: Integer;
        PrevStudent: Text;
    begin
        PubInt := 0;
        StudSubGB.Reset();
        StudSubGB.SetCurrentKey("Student No.");		//Doubt
        StudSubGB.SetRange("Grade Book No.", pGradeBookHdr."Document No.");
        StudSubGB.SetAscending("Student No.", true);
        if StudSubGB.FindSet() then begin
            repeat
                // key(Key1; "Student No.", Course, Semester, "Academic Year", "Subject Code", 
                //Section, "Start Date")
                IF Rec."Global Dimension 1 Code" = '9000' then begin
                    StudSub.Reset();
                    StudSub.SetRange("Student No.", StudSubGB."Student No.");
                    StudSub.SetFilter(Course, pCourseCode);
                    StudSub.SetRange(Semester, pSem);
                    StudSub.SetRange("Academic Year", pAY);
                    //StudSub.SetRange("Subject Code", StudSubGB."Subject Code");
                    StudSub.SetRange(Section, StudSubGB.Section);
                    StudSub.SetRange("Global Dimension 1 Code", StudSubGB."Global Dimension 1 Code");
                    StudSub.SetRange(Term, pTerm);
                    StudSub.FindLast();

                    StudSub."Percentage Obtained" := StudSubGB."Percentage Obtained";
                    if StudSubGB.Failed then
                        StudSub."Credit Earned" := 0
                    else
                        StudSub."Credit Earned" := StudSub.Credit;
                    StudSub."Numeric Grade" := StudSubGB."Numeric Grade";
                    // StudSub."Credit Earned" := StudSubGB."Credit Earned";
                    // StudSub."Numeric Grade" := StudSubGB."Credit Earned";

                    if IPGrade then begin
                        StudSub.Validate(Grade, StudSubGB."Grade To Be Published");
                        // StudSub.Validate(Grade, pGradeToBePublished);
                        // StudSubGB."Grade To Be Published" := StudSub.Grade;
                        pGradeToBePublished := '';
                    end
                    else begin
                        IF pGradeBookHdr.Status <> pGradeBookHdr.Status::Published then
                            pGradeToBePublished := '';
                        if pGradeToBePublished <> '' then begin
                            StudSub.validate(Grade, pGradeToBePublished);
                            StudSubGB.Validate("Grade To Be Published", pGradeToBePublished);
                        end
                        else begin
                            StudSub.validate(Grade, StudSubGB.Grade);
                            pGradeToBePublished := StudSub.Grade;
                        end;
                    end;
                    StudSub."Grade Book No." := StudSubGB."Grade Book No.";
                    StudSub."% Range" := StudSubGB."% Range";
                    StudSub.Recommendation := StudSubGB.Recommendation;
                    StudSub."Grade Confirmed" := true;
                    StudSub.Modify(True);
                end else
                    IF Rec."Global Dimension 1 Code" = '9100' then begin
                        RecGradBook.Reset();
                        RecGradBook.SetRange("Grade Book No.", Rec."Document No.");
                        RecGradBook.SetRange("Student No.", StudSubGB."Student No.");
                        // RecGradBook.SetRange("Exam Code",StudSubGB."Subject Code");
                        if RecGradBook.FindFirst() then begin
                            repeat
                                StudSub.Reset();
                                StudSub.SetRange("Student No.", StudSubGB."Student No.");
                                StudSub.SetRange(Course, StudSubGB.Course);
                                StudSub.SetRange(Semester, StudSubGB.Semester);
                                StudSub.SetRange("Academic Year", StudSubGB."Academic Year");
                                StudSub.SetRange("Subject Code", RecGradBook."Exam Code");
                                StudSub.SetRange(Section, StudSubGB.Section);
                                StudSub.SetRange("Global Dimension 1 Code", StudSubGB."Global Dimension 1 Code");
                                StudSub.SetRange(Term, StudSubGB.Term);
                                StudSub.FindLast();
                                StudSub."Percentage Obtained" := RecGradBook."Percentage Obtained";
                                if StudSubGB.Failed then
                                    StudSub."Credit Earned" := 0
                                else
                                    StudSub."Credit Earned" := StudSub.Credit;
                                StudSub."Numeric Grade" := StudSubGB."Numeric Grade";
                                if IPGrade then begin
                                    StudSub.Validate(Grade, RecGradBook.Grade);
                                    pGradeToBePublished := '';
                                end
                                else begin
                                    IF pGradeBookHdr.Status <> pGradeBookHdr.Status::Published then
                                        pGradeToBePublished := '';
                                    if pGradeToBePublished <> '' then begin
                                        StudSub.validate(Grade, pGradeToBePublished);
                                        StudSubGB.Validate("Grade To Be Published", pGradeToBePublished);
                                    end
                                    else begin
                                        StudSub.validate(Grade, RecGradBook.Grade);
                                        pGradeToBePublished := StudSub.Grade;
                                    end;
                                end;
                                StudSub."Grade Book No." := StudSubGB."Grade Book No.";
                                StudSub."% Range" := RecGradBook."% Range";
                                StudSub.Recommendation := RecGradBook.Recommendation;
                                StudSub."Grade Confirmed" := true;
                                StudSub.Modify(True);
                            until RecGradBook.Next() = 0;
                        end;
                    end;

                StudSubGB.Status := StudSubGB.Status::Published;
                CalcAcadSuggest(pGradeBookHdr, StudSubGB."Student No.", StudSubGB."Percentage Obtained", StudSubGB.failed, StudSubGB."Academic Suggestion", StudSub.Course);
                //aaa
                IF pGradeBookHdr.Status <> pGradeBookHdr.Status::Published then begin//Lucky
                    Stud.Reset();
                    Stud.Get(StudSubGB."Student No.");
                    if StudSubGB."Academic Suggestion" = StudSubGB."Academic Suggestion"::Dismiss then begin
                        Stud.Validate(Status, 'DIS');
                        If Stud."Student SFP Initiation" <> 0 then
                            Stud."SAFI Sync" := Stud."SAFI Sync"::Pending;              //10-11-2021
                        Stud.Modify(true);
                    end
                    else
                        if StudSubGB."Academic Suggestion" = StudSubGB."Academic Suggestion"::Progress then begin
                            CrsSemLn.Reset();
                            CrsSemLn.SetRange("Course Code", StudSubGB.Course);
                            CrsSemLn.SetRange("Semester Code", StudSubGB.Semester);
                            CrsSemLn.SetRange("Academic Year", StudSubGB."Academic year");
                            CrsSemLn.SetRange(Term, StudSubGB.Term);
                            CrsSemLn.FindFirst();
                            SemSeq := CrsSemLn."Sequence No";

                            CrsSemLn.Reset();
                            CrsSemLn.SetRange("Course Code", StudSubGB.Course);
                            CrsSemLn.SetRange("Sequence No", (SemSeq + 1));
                            CrsSemLn.SetRange("Academic Year", StudSubGB."Academic year");
                            CrsSemLn.SetRange(Term, StudSubGB.Term);
                            if CrsSemLn.FindFirst() AND (StudSubGB.Semester <> 'BSIC') then
                                NewSem := CrsSemLn."Semester Code"
                            else
                                NewSem := StudSubGB.Semester;

                            StudSubGB."Old Semester" := StudSubGB.Semester;
                            StudSubGB."New Semester" := NewSem;

                            Stud.Validate(Semester, NewSem);
                            // Code for OLR Tables
                            Stud.SemesterDecisionInsert(Stud, Stud."Semester Decision");
                            If Stud."Student SFP Initiation" <> 0 then
                                Stud."SAFI Sync" := Stud."SAFI Sync"::Pending;                  //10-11-2021
                            Stud.Modify(true);

                            ////////////////
                            //Prev Grade
                            ////////////////
                        end;
                end;
                StudSubGB.Modify(True);
                PubInt += 1;

                Crs.Reset();
                Crs.Get(StudSubGB.Course);
                if Crs."Additional Subject Grade" <> '' then begin
                    CrsSubLn.Reset();
                    CrsSubLn.SetRange("Course Code", Crs.code);
                    CrsSubLn.SetRange(Semester, StudSubGB.Semester);
                    CrsSubLn.SetRange("Academic Year", StudSubGB."Academic Year");
                    // CrsSubLn.SetRange(Term, StudSubGB.Term);
                    CrsSubLn.SetRange("Subject Code", StudSubGB."Subject Code");
                    CrsSubLn.FindFirst();
                    if CrsSubLn."Additional Subject" <> '' then begin
                        StudSubPNC.Reset();
                        // key(Key1; "Student No.", Course, Semester, "Academic Year",
                        // "Subject Code", Section, "Start Date")
                        StudSubPNC.SetRange("Student No.", StudSubGB."Student No.");
                        StudSubPNC.SetRange(Course, StudSubGB.Course);
                        StudSubPNC.SetRange(Semester, StudSubGB.Semester);
                        StudSubPNC.SetRange("Academic Year", StudSubGB."Academic Year");
                        StudSubPNC.SetRange("Subject Code", CrsSubLn."Additional Subject");
                        StudSubPNC.SetRange(Section, StudSubGB.Section);
                        StudSubPNC.SetRange("Start Date", StudSubGB."Start Date");
                        StudSubPNC.FindFirst();
                        StudSubPNC.Validate(Grade, Crs."Additional Subject Grade");
                        StudSubPNC."Grade Confirmed" := true;
                        StudSubPNC.Modify(true);
                        Stud.Reset();
                        If Stud.Get(StudSubPNC."Student No.") then begin
                            If Stud."Student SFP Initiation" <> 0 then begin
                                Stud."SAFI Sync" := Stud."SAFI Sync"::Pending;                      //10-11-2021
                                Stud.Modify();
                            end;
                        end;

                    end;
                end;
            //CSPL-00307 Starts
            // IF PrevStudent <> StudSubGB."Student No." then begin
            //     PrevStudent := StudSubGB."Student No.";
            //     Stud.CalculateSAP(Stud);
            //     StudSubGB.TestField(Communications);
            //     SemesterPromotionsMail(StudSubGB);
            // end;
            //CSPL-00307 ENds
            until StudSubGB.Next() = 0;
            // if PubInt > 0 then begin
            //     // pGradeBookHdr.validate(Status, pGradeBookHdr.Status::Published);
            //     // pGradeBookHdr."Published By" := UserId();
            //     // pGradeBookHdr."Published On" := Today();
            //     // pGradeBookHdr."Published Time" := Time();

            //     // pGradeBookHdr.Modify(True);
            //     Message('Grade Book %1 has been published', pGradeBookHdr."Document No.");
            // end;

        end;
    end;

    procedure CreateNewGradeBook(var pGradeBookNo: Code[20])
    var
        IntExamHdr: Record "Internal Exam Header-CS";
        ExtExamHdr: Record "External Exam Header-CS";
        ExtExamLine: Record "External Exam Line-CS";
        ExtExamLine2: Record "External Exam Line-CS";
        IntExamLine: Record "Internal Exam Line-CS";
        IntExamLine2: Record "Internal Exam Line-CS";
        CourseSubjectLine: Record "Course Wise Subject Line-CS";
        Sem: Record "Semester Master-CS";
        GradeBookHdr: Record "Grade Book Header";
        GradeCalculation_lPag: Page "Grade Calculation";
        HdrCreated: Integer;

    begin
        HdrCreated := 1;
        if Rec."Global Dimension 1 Code" = '9000' then begin
            CourseSubjectLine.Reset();
            //CourseSubjectLine.SetRange("Course Code", CourseCode);
            CourseSubjectLine.SetRange(Semester, Rec.Semester);
            CourseSubjectLine.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
            CourseSubjectLine.SETRANGE(Examination, true);
            CourseSubjectLine.SETFilter("Level Description", '%1', CourseSubjectLine."Level Description"::"External Examination");
            CourseSubjectLine.FindSet();
            repeat
                ExtExamHdr.Reset();
                ExtExamHdr.SetRange("Global Dimension 1 Code", CourseSubjectLine."Global Dimension 1 Code");
                ExtExamHdr.SetRange("Course Code", CourseSubjectLine."Course Code");
                ExtExamHdr.SetRange(Semester, CourseSubjectLine.Semester);
                ExtExamHdr.SetRange("Academic Year", Rec."Academic year");
                ExtExamHdr.SetRange(Term, Rec.Term);
                ExtExamHdr.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                if ExtExamHdr.FindFirst() then begin
                    ExtExamLine.Reset();
                    ExtExamLine.SetRange("Document No.", ExtExamHdr."No.");
                    ExtExamLine.FindSet();
                    // if HdrCreated = 0 then
                    //     InsertGradeBookHeader(ExtExamHdr."Global Dimension 1 Code", ExtExamHdr."Course Code", ExtExamHdr.Semester, ExtExamHdr."Academic Year", ExtExamHdr.Term, GradeBookHeader);
                    HdrCreated := 1;
                    pGradeBookNo := Rec."Document No.";
                    repeat
                        ExtExamLine2.Reset();
                        ExtExamLine2.SetCurrentKey("Percentage Obtained");
                        ExtExamLine2.Ascending(false);
                        ExtExamLine2.SetRange("Global Dimension 1 Code", CourseSubjectLine."Global Dimension 1 Code");
                        ExtExamLine2.SetRange(Course, CourseSubjectLine."Course Code");
                        ExtExamLine2.SetRange(Semester, CourseSubjectLine.Semester);
                        ExtExamLine2.SetRange("Academic Year", Rec."Academic year");
                        ExtExamLine2.SetRange(Term, Rec.Term);
                        ExtExamLine2.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                        ExtExamLine2.SetRange("Student No.", ExtExamLine."Student No.");
                        ExtExamLine2.FindFirst();
                        GradeCalculation_lPag.InsertGradeBookLineExt(ExtExamLine2, Rec);
                    until ExtExamLine.Next() = 0;
                end;
            until CourseSubjectLine.Next() = 0;

            Sem.Reset();
            Sem.SetRange(Code, Rec.Semester);
            Sem.FindFirst();
            // For CBSE Start
            if (Sem.Sequence = 4) or (Sem.Sequence = 5) then begin
                ExtExamLine.Reset();
                ExtExamLine.SetCurrentKey("Percentage Obtained");
                ExtExamLine.Ascending(false);
                ExtExamLine.SetRange("Global Dimension 1 Code", GradeBookHdr."Global Dimension 1 Code");
                ExtExamLine.SetRange(Course, Rec.Course);
                ExtExamLine.SetRange(Semester, Rec.Semester);
                ExtExamLine.SetRange("Academic Year", Rec."Academic year");
                ExtExamLine.SetRange(Term, Rec.Term);
                // ExtExamLine.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                // ExtExamLine.SetRange("Student No.", ExtExamLine."Student No.");
                ExtExamLine.SetRange(Status, ExtExamLine.Status::Published);
                ExtExamLine.SetFilter("CBSE Version", '<>%1', '');
                ExtExamLine.FindSet();
                repeat
                    ExtExamLine2.Reset();
                    ExtExamLine2.SetCurrentKey("Percentage Obtained");
                    ExtExamLine2.Ascending(false);
                    ExtExamLine2.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    // ExtExamLine2.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                    ExtExamLine2.SetRange("Student No.", ExtExamLine."Student No.");
                    ExtExamLine2.SetRange(Status, ExtExamLine.Status::Published);
                    ExtExamLine2.SetFilter("CBSE Version", '<>%1', '');
                    ExtExamLine2.FindFirst();
                    GradeCalculation_lPag.InsertGradeBookLineExt(ExtExamLine2, Rec);
                until ExtExamLine.Next() = 0;


            end;
            // For CBSE End
        end;

        //Internal Exam Grade Book
        CourseSubjectLine.Reset();
        //CourseSubjectLine.SetRange("Course Code", CourseCode);
        CourseSubjectLine.SetRange(Semester, Rec.Semester);
        CourseSubjectLine.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        CourseSubjectLine.SETRANGE(Examination, true);
        IF Rec."Global Dimension 1 Code" = '9000' then
            CourseSubjectLine.SETFilter("Level Description", '%1|%2', CourseSubjectLine."Level Description"::"Internal Examination",
                    CourseSubjectLine."Level Description"::"Internal Exam Component");
        IF Rec."Global Dimension 1 Code" = '9100' then
            CourseSubjectLine.SetRange("Level Description", CourseSubjectLine."Level Description"::"Main Subject");
        If CourseSubjectLine.FindSet() then
            repeat
                IntExamHdr.Reset();
                IntExamHdr.SetRange("Global Dimension 1 Code", CourseSubjectLine."Global Dimension 1 Code");
                IntExamHdr.SetRange("Course Code", CourseSubjectLine."Course Code");
                IntExamHdr.SetRange(Semester, CourseSubjectLine.Semester);
                IntExamHdr.SetRange("Academic Year", Rec."Academic year");
                IntExamHdr.SetRange(Term, Rec.Term);
                IntExamHdr.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                //arv
                // IntExamHdr.SetRange("Exam Classification", ExamClassification);
                if IntExamHdr.FindFirst() then begin
                    IntExamLine.Reset();
                    IntExamLine.SetRange("Document No.", IntExamHdr."No.");
                    IntExamLine.FindSet();
                    // if HdrCreated = 0 then
                    //     InsertGradeBookHeader(IntExamHdr."Global Dimension 1 Code", IntExamHdr."Course Code", IntExamHdr.Semester, IntExamHdr."Academic Year", IntExamHdr.Term, GradeBookHeader);
                    HdrCreated += 1;
                    pGradeBookNo := Rec."Document No.";
                    repeat
                        //arv
                        IntExamLine2.Reset();
                        IntExamLine2.SetCurrentKey("Percentage Obtained");
                        IntExamLine2.Ascending(false);
                        IntExamLine2.SetRange("Global Dimension 1 Code", CourseSubjectLine."Global Dimension 1 Code");
                        IntExamLine2.SetRange(Course, CourseSubjectLine."Course Code");
                        IntExamLine2.SetRange(Semester, CourseSubjectLine.Semester);
                        IntExamLine2.SetRange("Academic Year", Rec."Academic year");
                        IntExamLine2.SetRange(Term, Rec.Term);
                        IntExamLine2.SetRange("Subject Code", CourseSubjectLine."Subject Code");
                        IntExamLine2.SetRange("Student No.", IntExamLine."Student No.");
                        IntExamLine2.FindFirst();
                        GradeCalculation_lPag.InsertGradeBookLineInt(IntExamLine2, Rec);
                    until IntExamLine.Next() = 0;
                end;
            until CourseSubjectLine.Next() = 0;
    end;

    Procedure InsertNote(StudentNo: Code[20]; CommText: Text)
    var
        InterLogEntryCommentLine: Record "Interaction Log Entry";
        UserSetup: Record "User Setup";
        StudentMaster: Record "Student Master-CS";
        usersetupapprover: record "Document Approver Users";
        EntryNo: Integer;
    Begin
        InterLogEntryCommentLine.Reset();
        if InterLogEntryCommentLine.FindLast() then
            EntryNo := InterLogEntryCommentLine."Entry No."
        else
            EntryNo := 0;

        UserSetup.Reset();
        if UserSetup.Get(UserId) then;

        usersetupapprover.Reset();
        usersetupapprover.SetRange("User ID", userid());
        if usersetupapprover.FindFirst() then;

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then begin

            InterLogEntryCommentLine.Init();
            InterLogEntryCommentLine."Entry No." := EntryNo + 1;
            InterLogEntryCommentLine."Source No." := StudentNo;
            InterLogEntryCommentLine.Validate("Interaction Template Code", 'CSPREXAM');
            InterLogEntryCommentLine.Validate("Interaction Group Code", 'CSPREXAM');
            InterLogEntryCommentLine.Validate("Student No.", StudentNo);
            InterLogEntryCommentLine."Original Student No." := StudentMaster."Original Student No.";
            InterLogEntryCommentLine.Validate("Global Dimension 2 Code", UserSetup."Global Dimension 2 Code");
            InterLogEntryCommentLine.Department := InterLogEntryCommentLine.Department::"Registrar Department";
            InterLogEntryCommentLine."Created By" := UserId();
            InterLogEntryCommentLine."Created On" := Today();
            InterLogEntryCommentLine.Notes := CommText;
            InterLogEntryCommentLine.Insert(true);
        end;
    End;

}