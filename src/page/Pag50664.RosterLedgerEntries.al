page 50664 "Roster Ledger Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Roster Ledger Entry";
    SourceTableView = sorting("Entry No.") order(descending);
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Entries)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnDrillDown()
                    begin
                        OpenRotationCard();
                    end;
                }
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        OpenRotationCard();
                    end;
                }
                field("Rotation No."; Rec."Rotation No.")
                {
                    ApplicationArea = All;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Student E-Mail ID"; Rec."Student E-Mail ID")
                {
                    ApplicationArea = All;
                }
                field("Student Present Mobile No."; Rec."Student Present Mobile No.")
                {
                    ApplicationArea = All;
                }
                field("Clerkship Type"; Rec."Clerkship Type")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Total No. of Weeks"; Rec."Total No. of Weeks")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("New/Returning"; Rec."New/Returning")
                {
                    ApplicationArea = All;
                }
                field("Actual Rotation Cost"; Rec."Actual Rotation Cost")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Total Actual Rotation Cost"; Rec."Total Actual Rotation Cost")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Estimated Rotation Cost"; Rec."Estimated Rotation Cost")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Total Estd. Rotation Cost"; Rec."Total Estd. Rotation Cost")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Rotation Grade"; Rec."Rotation Grade")
                {
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Check No."; Rec."Check No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Check Date"; Rec."Check Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cancelled By"; Rec."Cancelled By")
                {
                    ApplicationArea = All;
                }
                field("Cancelled On"; Rec."Cancelled On")
                {
                    ApplicationArea = All;
                }
                field("School Docs Sync"; Rec."School Docs Sync")
                {
                    ApplicationArea = All;
                }
                field("School Docs TransactionID"; Rec."School Docs TransactionID")
                {
                    ApplicationArea = All;
                }
                field("LGS SchoolDocs Trn. No."; Rec."LGS SchoolDocs Trn. No.")
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
            action("Rotation Card")
            {
                ApplicationArea = All;
                Caption = 'Rotation Card';
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ShortcutKey = 'Ctrl+F5';

                trigger OnAction()
                begin
                    OpenRotationCard();
                end;
            }
            action("Print LGS Letter")
            {
                ApplicationArea = All;
                Caption = 'Print LGS Letter';
                ShortcutKey = 'Ctrl+P';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Print;
                trigger OnAction();
                var
                    RLEReport: Record "Roster Ledger Entry";
                begin
                    RLEReport.Reset();
                    RLEReport.SetRange("Entry No.", Rec."Entry No.");
                    RLEReport.SetRange("Rotation ID", Rec."Rotation ID");
                    RLEReport.SetRange("Clerkship Type", Rec."Clerkship Type");
                    RLEReport.SetRange("Hospital ID", Rec."Hospital ID");
                    RLEReport.SetRange("Start Date", Rec."Start Date");
                    Report.RunModal(Report::"LGS Letter", true, true, RLEReport);
                end;
            }
            action("Upload LGS Letter On SchoolDocs")
            {
                ApplicationArea = All;
                Caption = 'Upload LGS Letter On SchoolDocs';
                ShortcutKey = 'Ctrl+F6';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = EditAttachment;
                trigger OnAction();
                var
                    ClinicalNotification: Codeunit "Clinical Notification";
                begin
                    // ClinicalNotification.UploadLGSLetterOnSchoolDocs(Rec, true);
                end;
            }
            action("Download LGS Letter")
            {
                ApplicationArea = All;
                ShortcutKey = 'Ctrl+D';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = TRUE;
                Image = DocInBrowser;
                trigger OnAction();
                var
                    CompanyInfo: Record "Company Information";
                    StudentMaster: Record "Student Master-CS";
                    StudentNo: Code[20];
                    PostUrl: Text;
                begin
                    CompanyInfo.Reset();
                    if CompanyInfo.Get() then;

                    if Rec."LGS SchoolDocs Trn. No." <> '' then begin
                        CompanyInfo.TestField("SchoolDocs Download Url");
                        PostUrl := CompanyInfo."SchoolDocs Download Url";
                        PostUrl := PostUrl + Rec."LGS SchoolDocs Trn. No.";
                        Hyperlink(PostUrl);
                    end
                    else begin
                        StudentMaster.Reset();
                        if StudentMaster.Get(Rec."Student ID") then;

                        if StudentMaster."Creation Date" < 20210410D then begin
                            if StudentMaster."Original Student No." <> '' then
                                StudentNo := StudentMaster."Original Student No."
                            else
                                StudentNo := StudentMaster."No.";
                        end
                        else
                            StudentNo := StudentMaster."No.";

                        CompanyInfo.TestField("SchoolDocs Documents Open Url");
                        PostUrl := CompanyInfo."SchoolDocs Documents Open Url";
                        PostUrl := PostUrl + StudentNo;

                        Hyperlink(PostUrl);
                    end;
                end;
            }

            action("Grade Revision Require")
            {
                ApplicationArea = All;
                ShortcutKey = 'Ctrl+R';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = TRUE;
                Image = ReverseRegister;
                trigger OnAction();
                var
                    RSL: Record "Roster Scheduling Line";
                    MainStudentSubject: Record "Main Student Subject-CS";
                    StudentMaster: Record "Student Master-CS";
                    SubjectMaster: Record "Subject Master-CS";
                    DAS: Record "DocuSign Assessment Scores";
                begin
                    if not Confirm('Do you want to revise the grade for the Student No. %1 (%2) of the Course %3 (%4)?', true, Rec."Student ID", Rec."Student Name", Rec."Course Code", Rec."Rotation Description") then
                        exit;

                    DAS.Reset();
                    if DAS.Get(Rec."Student ID", Rec."Rotation No.", Rec."Rotation ID") then
                        if not Confirm('Clerkship Assessment for the Student No. %1 (%2) of the Course %3 (%4) has done through SLcM. if you want to revise the grade, in that case system will remove the Previous Assessment record. Do you still want to proceed?', true, Rec."Student ID", Rec."Student Name", Rec."Course Code", Rec."Rotation Description") then
                            exit
                        else
                            DAS.Delete();

                    StudentMaster.Reset();
                    if StudentMaster.Get(Rec."Student ID") then;

                    SubjectMaster.Reset();
                    if Rec."Clerkship Type" <> Rec."Clerkship Type"::Elective then
                        SubjectMaster.SetRange(Code, Rec."Course Code")
                    else
                        SubjectMaster.SetRange(Code, Rec."Elective Course Code");
                    if SubjectMaster.FindFirst() then;

                    Rec."Rotation Grade" := '';
                    Rec.Status := Rec.Status::Published;
                    Rec."Assessment Completed" := false;
                    Rec.Modify();

                    RSL.Reset();
                    RSL.SetRange("Rotation ID", Rec."Rotation ID");
                    RSL.SetRange("Student No.", Rec."Student ID");
                    RSL.SetRange("Ledger Entry No.", Rec."Entry No.");
                    if RSL.FindFirst() then begin
                        RSL."Rotation Grade" := '';
                        RSL.Status := RSL.Status::Published;
                        RSL.Modify();
                    end;

                    MainStudentSubject.Reset();
                    MainStudentSubject.SetRange("Student No.", Rec."Student ID");
                    MainStudentSubject.SetRange(Course, StudentMaster."Course Code");
                    MainStudentSubject.SetRange("Subject Code", Rec."Course Code");
                    MainStudentSubject.SetRange("Start Date", Rec."Start Date");
                    if MainStudentSubject.FindFirst() then begin
                        MainStudentSubject.Grade := Rec."Rotation Grade";
                        MainStudentSubject."Grade Confirmed" := false;
                        MainStudentSubject.Credit := SubjectMaster.Credit;
                        MainStudentSubject."Credits Attempt" := 0;
                        MainStudentSubject."Date Grade Posted" := 0D;
                        MainStudentSubject."Credit Earned" := 0;
                        MainStudentSubject.Result := MainStudentSubject.Result::" ";

                        MainStudentSubject.Modify();
                    end
                    else begin
                        MainStudentSubject.Reset();
                        MainStudentSubject.SetRange("Student No.", Rec."Student ID");
                        MainStudentSubject.SetRange(Course, StudentMaster."Course Code");
                        MainStudentSubject.SetRange("Subject Code", Rec."Course Code");
                        MainStudentSubject.SetFilter(Grade, '');
                        if MainStudentSubject.FindFirst() then begin
                            MainStudentSubject.Grade := Rec."Rotation Grade";
                            MainStudentSubject."Grade Confirmed" := false;
                            MainStudentSubject.Credit := SubjectMaster.Credit;
                            MainStudentSubject."Credits Attempt" := 0;
                            MainStudentSubject."Date Grade Posted" := 0D;
                            MainStudentSubject."Credit Earned" := 0;
                            MainStudentSubject.Result := MainStudentSubject.Result::" ";

                            MainStudentSubject.Modify();
                        end
                    end;

                    Message('Rotation opened for grade revision.');
                end;
            }
            action("Assign F Grade")
            { //CSPL-00307
                ApplicationArea = All;
                Image = Action;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    UserSetup: record "User Setup";
                    RecRosterLedger: Record "Roster Ledger Entry";
                    RecRosterSchedulingLines: Record "Roster Scheduling Line";
                    StudentSubject: Record "Main Student Subject-CS";
                begin
                    UserSetup.Reset();
                    UserSetup.Get(UserId);
                    IF Not UserSetup."Assign F Grade Allowed" then
                        Error('You do not have permission to Assign F Grade');
                    IF Not Confirm('Are you sure you want to assign F grade to selected Rotation ?') then
                        exit;
                    RecRosterLedger.Reset();
                    RecRosterLedger.Get(Rec."Entry No.");
                    RecRosterLedger.TestField(Status, RecRosterLedger.Status::Published);
                    IF (RecRosterLedger."End Date" > WorkDate()) then begin
                        RecRosterSchedulingLines.reset();
                        RecRosterSchedulingLines.Get(RecRosterLedger."Rotation ID", RecRosterLedger."Academic Year", RecRosterLedger."Student ID", RecRosterLedger."Rotation No.");
                        RecRosterSchedulingLines."Rotation Grade" := 'F';
                        RecRosterSchedulingLines.Modify();
                        StudentSubject.Reset();
                        StudentSubject.SetRange("Student No.", RecRosterLedger."Student ID");
                        StudentSubject.SetRange("Subject Code", RecRosterLedger."Course Code");
                        StudentSubject.SetRange("Start Date", RecRosterLedger."Start Date");
                        StudentSubject.SetRange("End Date", RecRosterLedger."End Date");
                        StudentSubject.SetRange("Rotation ID", RecRosterLedger."Rotation ID");
                        IF StudentSubject.FindFirst() then begin
                            StudentSubject.Validate(Grade, 'F');
                            StudentSubject.Modify(true);
                        end;
                        RecRosterLedger.Validate("Rotation Grade", 'F');
                        IF RecRosterLedger.Modify() then begin
                            Message('Done');
                            CurrPage.Update();
                        end
                    end else
                        Error('You can not assign F Grade as rotation ended');
                end;
            }
        }
    }

    procedure OpenRotationCard()
    var
        RSH: Record "Roster Scheduling Header";
    begin
        RSH.Reset();
        RSH.FilterGroup(2);
        RSH.SetRange("Rotation ID", Rec."Rotation ID");
        RSH.FilterGroup(0);

        if Rec."Clerkship Type" = Rec."Clerkship Type"::Core then
            Page.RunModal(Page::"Confirm Roster Scheduling Card", RSH);

        if Rec."Clerkship Type" = Rec."Clerkship Type"::"FM1/IM1" then
            Page.RunModal(Page::"FM1/IM1 Roster Card+", RSH);

        if Rec."Clerkship Type" = Rec."Clerkship Type"::Elective then
            Page.RunModal(Page::"Elective Rotation Card", RSH);
    end;
}