page 50393 "Rotation Cancellation Appln"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Rotation Cancellation Appln";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Rotation No."; Rec."Rotation No.")
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
                field("Rotation Description"; Rec."Rotation Description")
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
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                }
                field("Cancel Reason Code"; Rec."Cancel Reason Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Cancel Reason Description"; Rec."Cancel Reason Description")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
            part("Supporting Documemnts"; "Student Attachment Line")
            {
                ApplicationArea = All;
                SubPageLink = "SLcM Document No" = field("Application No."), "Subject Code" = filter('ROTATIONCANCELAPPLN');
                Caption = 'Supporting Documemnt(s)';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Upload Supporting Documents")
            {
                ApplicationArea = All;
                ShortcutKey = 'Ctrl+Shift+D';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = TRUE;
                Image = Attachments;
                Caption = 'Upload Supporting Document(s)';

                trigger OnAction()
                var
                    StudentDocumentAttachment: Record "Student Document Attachment";
                    EntryNo: Integer;
                begin
                    LCategory := 'CLINICAL';
                    SubCategory := 'ROTATION CANCELLATION SUPPORTING DOCUMENT';

                    StudentDocumentAttachment.Reset();
                    if StudentDocumentAttachment.FindLast() then
                        EntryNo := StudentDocumentAttachment."Entry No.";
                    EntryNo := EntryNo + 1;

                    AttachmentDocument(EntryNo);
                end;
            }
            action("Approve")
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = Show;
                trigger OnAction()
                var
                    RSL: Record "Roster Scheduling Line";
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    CALE: Record "Clerkship Activity Log Entries";
                    RotationOfferApplication: Record "Rotation Offer Application";
                    UserSetup_1: Record "User Setup";
                // ClinicalNotification: Codeunit "Clinical Notification";
                begin
                    if not Confirm('Do you want to Cancel the Rotation of Student ID %1 (%2)?', true, Rec."Student No.", Rec."Student Name") then
                        exit;

                    RSL.Reset();
                    RSL.SetRange("Rotation ID", Rec."Rotation ID");
                    RSL.SetRange("Student No.", Rec."Student No.");
                    if RSL.FindFirst() then;

                    //CSPL-00307-RTP
                    IF WorkDate() > Rec."End Date" then
                        Error('You Can Not Cancelled this rotation as it is ended');
                    IF Rec."Start Date" <= WorkDate() then begin
                        UserSetup_1.Reset();
                        if UserSetup_1.Get(UserId) then
                            if UserSetup_1."Clinical Administrator" = false then
                                Error('Rotation is already started, it cannot be cancelled.')
                            else
                                if not Confirm('Rotation is already started.\Do you still want to cancel it?') then
                                    Error('Action stopped to respect the Started Rotation warning.');
                    end;

                    if Rec."Start Date" - WorkDate() <= 45 then
                        if not Confirm('Do you want to Cancel the Rotation, as it is within 45 Days') then
                            exit;

                    Rec.TestField("Cancel Reason Code");
                    Rec.TestField("Cancel Reason Description");

                    RosterLedgerEntry.Reset();
                    if RosterLedgerEntry.Get(RSL."Ledger Entry No.") then begin
                        if RosterLedgerEntry."Invoice No." <> '' then
                            Error('Cancellation of Rotation for the Student No. %1 (%2) is not allowed as Invoice has been raised for the Rotation.', Rec."Student No.", Rec."Student Name");

                        if RosterLedgerEntry."Check No." <> '' then
                            Error('Cancellation of Rotation for the Student No. %1 (%2) is not allowed as Check has been updated in the Rotation.', Rec."Student No.", Rec."Student Name");

                        if NOT (RosterLedgerEntry."Rotation Grade" IN ['', 'X', 'M']) then //CSPL-00307_M_GradeIssue
                            Error('Cancellation of Rotation for the Student No. %1 (%2) is not allowed as Grade has been marked for the Rotation.', Rec."Student No.", Rec."Student Name");

                        RosterLedgerEntry."Rotation Grade" := 'SC';

                        RosterLedgerEntry."Cancelled By" := UserId;
                        RosterLedgerEntry."Cancelled On" := Today;
                        RosterLedgerEntry.Modify();
                    end;

                    // IF RSL.Status = RSL.Status::"Published" then begin
                    //     // ClinicalNotification.RotationCancellation(RSL);

                    //     IF Rec."Start Date" <= WorkDate() then //CSPL-00307-RTP
                    //         ClinicalNotification.RotationCancellationNotice(RSL);
                    // end;

                    if RSL."Clerkship Type" = RSL."Clerkship Type"::Elective then begin
                        RotationOfferApplication.Reset();
                        if RSL."Elective Application No." <> '' then
                            RotationOfferApplication.SetRange("Application No.", RSL."Elective Application No.")
                        else begin
                            RotationOfferApplication.SetRange("Offer No.", RSL."Offer No.");
                            RotationOfferApplication.SetRange("Line No.", RSL."Offer Application Line No.");
                        end;
                        if RotationOfferApplication.FindFirst() then begin
                            RotationOfferApplication."Approval Status" := RotationOfferApplication."Approval Status"::"Rotation Cancelled";
                            RotationOfferApplication.Modify();
                        end;
                    end;

                    RSL.RemoveStudentSubject(RSL);
                    RSL.Validate(Status, RSL.Status::Cancelled);

                    RSL."Rotation Grade" := 'SC';

                    RSL."Cancel Reason Code" := Rec."Cancel Reason Code";
                    RSL."Cancel Reason Description" := Rec."Cancel Reason Description";
                    RSL."Cancelled By" := UserId;
                    RSL."Cancelled Date" := Today;
                    RSL."Cancelled Time" := Time;

                    if RSL."Clerkship Type" = RSL."Clerkship Type"::"FM1/IM1" then
                        CALE.InsertLogEntry(4, 10, Rec."Student No.", Rec."Student Name", Rec."Rotation ID", Rec."Cancel Reason Code", Rec."Cancel Reason Description", Rec."Course Code", Rec."Course Description");
                    if Rec."Clerkship Type" = Rec."Clerkship Type"::Core then
                        CALE.InsertLogEntry(5, 10, Rec."Student No.", Rec."Student Name", Rec."Rotation ID", Rec."Cancel Reason Code", Rec."Cancel Reason Description", Rec."Course Code", Rec."Course Description");
                    if Rec."Clerkship Type" = Rec."Clerkship Type"::Elective then
                        CALE.InsertLogEntry(8, 10, Rec."Student No.", Rec."Student Name", Rec."Rotation ID", Rec."Cancel Reason Code", Rec."Cancel Reason Description", Rec."Elective Course Code", Rec."Rotation Description");

                    RSL.Modify(true);

                    Rec.Validate(Status, Rec.Status::Approved);
                    Rec.Modify();

                    Message('Rotation Cancellation application approved.');
                    CurrPage.Close();
                end;
            }

            action("Reject")
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = Show;
                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                // ClinicalNotification: Codeunit "Clinical Notification";
                begin
                    if not Confirm('Do you want to reject the Rotation Cancellation Application of the Student No. %1 (%2)?', true, Rec."Student No.", Rec."Student Name") then
                        exit;

                    Rec.Validate(Status, Rec.Status::Rejected);
                    Rec.Modify();
                    CALE.InsertLogEntry(12, 10, Rec."Student No.", Rec."Student Name", Rec."Rotation ID", '', '', Rec."Course Code", Rec."Rotation Description");
                    // ClinicalNotification.SendRotationCancellationApplRejected(Rec);
                    Message('Rotation Cancellation application rejected.');
                    CurrPage.Close();
                end;
            }
        }
    }

    var
        Show: Boolean;
        LCategory: Code[100];
        SubCategory: Code[100];

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Show := true;
    end;

    trigger OnAfterGetRecord()
    begin
        Show := true;
        if Rec.Status IN [Rec.Status::Approved, Rec.Status::Rejected] then
            Show := false;
    end;

    procedure GetSemester()
    var
        UserSetup: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
        SemesterFilter: Text;
    begin
        UserSetup.Reset();
        IF not UserSetup.Get(UserId) then
            Error('User Setup not found for the User ID %1.', UserId);

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then;

        EducationSetup.TestField("FM1/IM1 Semester Filter");
        EducationSetup.TestField("Clerkship Semester Filter");
        EducationSetup.TestField("Elective Semester Filter");

        SemesterFilter := EducationSetup."FM1/IM1 Semester Filter" + '|' + EducationSetup."Clerkship Semester Filter" + '|' + EducationSetup."Elective Semester Filter";
        Rec.SetFilter("Clerkship Semester Filter", SemesterFilter);
    end;

    procedure AttachmentDocument(EntryNo: Integer)
    var
        StudentMaster: Record "Student Master-CS";
        SDA: Record "Student Document Attachment";
        TempBlob: Record "TempBlob Test";
        // FileMgmt: Codeunit "File Management";
        locOutFile: BigText;
        ResponseText: Text;
        FileName: Text;
        IStream: InStream;
        TransactionNo: Text[100];
        WindowDialog: Dialog;
    // MemoryStream: DotNet NewImageStream;
    // Bytes: DotNet Bytes;
    // Convert: DotNet ImageConvert;
    begin
        if not Confirm('Do you want to upload Document?') then
            exit;

        StudentMaster.Reset();
        if StudentMaster.Get(Rec."Student No.") then;

        // FileName := FileMgmt.UploadFile('Upload', 'C\LGSLetter');

        WindowDialog.Open('Uploading file...\Please wait...');
        if FileName = '' then
            exit;

        // TempBlob.Reset();
        // TempBlob.DeleteAll();

        // TempBlob.INIT();
        // TempBlob.Blob.IMPORT(FileName);
        // TempBlob.INSERT();
        // TempBlob.Blob.CREATEINSTREAM(IStream);
        // MemoryStream := MemoryStream.MemoryStream();
        // COPYSTREAM(MemoryStream, IStream);
        // Bytes := MemoryStream.GetBuffer();
        // locOutFile.ADDTEXT(Convert.ToBase64String(Bytes));
        // ResponseText := SDA.UploadSchoolDoc(StudentMaster."Original Student No.", SubCategory, FileName, Format(locOutFile));

        IF StrPos(ResponseText, '1</Success>') > 0 then begin
            TransactionNo := SDA.FindStringValue(ResponseText);

            SDA.Init();
            SDA."Entry No." := EntryNo;
            SDA."Document Category" := LCategory;
            SDA."Document Sub Category" := SubCategory;
            SDA."Document Description" := SubCategory;
            SDA.Validate("Student No.", Rec."Student No.");
            SDA."Student Name" := Rec."Student Name";
            SDA."Subject Code" := 'ROTATIONCANCELAPPLN';
            SDA."SLcM Document No" := Rec."Application No.";
            SDA."Transaction No." := TransactionNo;
            SDA."Note Entry No" := -110;
            SDA."File Name" := FileName;
            SDA."Uploaded Source" := SDA."Uploaded Source"::SLcMBC;
            SDA."Document Status" := SDA."Document Status"::"Pending for Verification";
            SDA."Submission Date" := Today;
            SDA."Uploaded By" := UserId;
            SDA."Uploaded On" := Today;
            SDA.Insert(true);
        end
        else
            Error('School Docs Error\%1', ResponseText);

        WindowDialog.Close();
        Message('Document has been Uploded.');
    end;
}