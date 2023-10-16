page 50508 "Spl Accommodation Entry Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Spcl Accommodation Application";
    Caption = 'Special Accommodation Application Entry';
    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = EditAllow;
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    ShowMandatory = true;
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowMandatory = true;
                }
                field("Send_for_Approval"; Rec."Send for Approval")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Send for Approval';
                }
                field("Send for Approval On"; Rec."Send for Approval On")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
        }
        area(FactBoxes)
        {
            part("Accommodation Categories"; "Std Spcl Acc. Category FactBox")
            {
                ApplicationArea = All;
                Caption = 'Accommodation Categories';
                SubPageLink = "Application No." = field("Application No.");
            }
            // part("SPCL Accommodation Attachment"; "SPCL Accommodation Attachment")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Attachments';
            //     SubPageLink = "SLcM Document No" = field("Application No."), "Document Category" = filter('CLINICAL'), "Document Sub Category" = filter('SPECIAL ACCOMMODATION APPLICATION');
            // }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Accommodation Category")
            {
                ApplicationArea = All;
                Caption = 'Accommodation Category';
                ShortcutKey = 'Ctrl+M';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = AbsenceCategories;
                trigger OnAction();
                var
                    StdSplAccommodationCategory: Record "Std Spl Accommodation Category";
                    PageSTDSplAccommodationCategory: Page "STD Spl Accommodation Category";
                begin
                    StdSplAccommodationCategory.Reset();
                    StdSplAccommodationCategory.SetRange("Student ID", Rec."Student No.");
                    Clear(PageSTDSplAccommodationCategory);
                    PageSTDSplAccommodationCategory.SetVariables(Rec."Clinical Reference No.", Rec."Application No.");
                    PageSTDSplAccommodationCategory.SetTableView(StdSplAccommodationCategory);
                    if Rec."Send for Approval" then
                        PageSTDSplAccommodationCategory.Editable(false);
                    PageSTDSplAccommodationCategory.RunModal();
                end;
            }

            action("Upload Document")
            {
                ApplicationArea = All;
                Caption = 'Upload Document';
                ShortcutKey = 'Ctrl+U';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = AbsenceCategories;
                trigger OnAction();
                begin
                    // AttachmentDocument(Rec."Student No.");
                end;
            }

            action("Send for Approval")
            {
                ApplicationArea = All;
                Caption = 'Send for Approval';
                ShortcutKey = 'Ctrl+R';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = ApprovalSetup;
                Enabled = EditAllow;
                trigger OnAction();
                var
                    StdSplAccommodationCategory: Record "Std Spl Accommodation Category";
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    if Confirm('Do you want to send the Application No. %1 for Approval?', true, Rec."Application No.") then begin
                        StdSplAccommodationCategory.Reset();
                        StdSplAccommodationCategory.SetRange("Student ID", Rec."Student No.");
                        StdSplAccommodationCategory.SetRange("Application No.", Rec."Application No.");
                        if not StdSplAccommodationCategory.FindFirst() then
                            Error('You must specify Accommodation Category.');

                        StdSplAccommodationCategory.Reset();
                        StdSplAccommodationCategory.SetRange("Student ID", Rec."Student No.");
                        StdSplAccommodationCategory.SetRange("Application No.", Rec."Application No.");
                        if StdSplAccommodationCategory.FindSet() then
                            repeat
                                if StdSplAccommodationCategory.Reason = '' then
                                    Error('You must Specify Reason for the Accommodation Category %1.', StdSplAccommodationCategory."Category Description");
                            //if StdSplAccommodationCategory."File Path" = '' then
                            //    Error('You must upload Supporting Document for the Accommodation Category %1.', StdSplAccommodationCategory."Category Description");
                            Until StdSplAccommodationCategory.Next() = 0;

                        Rec."Send for Approval" := true;
                        Rec."Send for Approval By" := UserId;
                        Rec."Send for Approval On" := Today;
                        Rec."Approval Status" := Rec."Approval Status"::"Pending for Approval";
                        CALE.InsertLogEntry(4, 12, Rec."Student No.", Rec."Student Name", Rec."Application No.", '', '', '', '');
                        Rec.Modify();
                        Message('Application sent for approval.');
                    end;
                end;
            }
        }
    }

    var
        EditAllow: Boolean;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        if not UserSetup.Get(UserId) then
            Error('User Setup for User ID %1 not found.', UserId);

        Rec."Global Dimension 1 Code" := '9000';
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.Editable := true;
        if Rec."Send for Approval" then
            CurrPage.Editable := false;

        EditAllow := not Rec."Send for Approval";
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec."Approval Status" <> Rec."Approval Status"::" " then
            Error('Delete not Allowed as Approval Status of Application changed to %1.', Rec."Approval Status");
    end;

    /// <summary> 
    /// Description for SetVariables.
    /// </summary>
    /// <param name="LClinicalRefNo">Parameter of type Code[20].</param>
    procedure SetVariables(LClinicalRefNo: Code[20])
    begin
        ClinicalRefNo := LClinicalRefNo;
    end;

    // procedure AttachmentDocument(StudentNo: Code[20])
    // var
    //     StudentMaster: Record "Student Master-CS";
    //     NewAttachment: Record "Attachment";
    //     NewAttachmentRec: Record "Attachment";
    //     SDA: Record "Student Document Attachment";
    //     CU_Base64: Codeunit "Base64 Convert";
    //     PDFFile: Text;
    //     ResponseText: Text;
    //     Base64Contant: Text;
    //     FileName: Text;
    //     IStream: InStream;
    //     TempNo: Integer;
    //     EntryNo: Integer;
    //     TransactionNo: Text[100];
    // begin
    //     if not Confirm('Do you want to upload Document for Special Accommodation Application %1 of the Student No. %2 (%3)?', True, "Application No.", StudentNo, "Student Name") then
    //         exit;

    //     StudentMaster.Reset();
    //     if StudentMaster.Get(Rec."Student No.") then;

    //     TempNo := 0;
    //     // IF NewAttachment.ImportAttachmentFromClientFile('', FALSE, TRUE) THEN BEGIN
    //         FileName := StudentNo + 'SPECIAL ACCOMMODATION APPLICATION.' + NewAttachment."File Extension";
    //         TempNo := NewAttachment."No.";

    //         NewAttachment.CALCFIELDS(NewAttachment."Attachment File");
    //         NewAttachment."Attachment File".CREATEINSTREAM(IStream);
    //         IStream.ReadText(PDFFile);
    //         Base64Contant := CU_Base64.ToBase64(IStream);

    //         ResponseText := SDA.UploadSchoolDoc(StudentMaster."Original Student No.", 'SPECIAL ACCOMMODATION APPLICATION', FileName, Base64Contant);

    //         IF StrPos(ResponseText, '1</Success>') > 0 then begin
    //             TransactionNo := SDA.FindStringValue(ResponseText);
    //             SDA.Reset();
    //             if SDA.FindLast() then
    //                 EntryNo := SDA."Entry No.";

    //             EntryNo := EntryNo + 1;

    //             SDA.Init();
    //             SDA."Entry No." := EntryNo;
    //             SDA."Document Category" := 'CLINICAL';
    //             SDA."Document Sub Category" := 'SPECIAL ACCOMMODATION APPLICATION';
    //             SDA."Document Description" := 'SPECIAL ACCOMMODATION APPLICATION';
    //             SDA.Validate("Student No.", StudentNo);
    //             SDA."Student Name" := "Student Name";
    //             SDA."SLcM Document No" := "Application No.";
    //             SDA."Transaction No." := TransactionNo;
    //             SDA."File Name" := FileName;
    //             SDA."File Type" := NewAttachment."File Extension";
    //             SDA."Uploaded Source" := SDA."Uploaded Source"::SLcMBC;
    //             SDA."Document Status" := SDA."Document Status"::"Pending for Verification";
    //             SDA."Submission Date" := Today;
    //             SDA."Uploaded By" := UserId;
    //             SDA."Uploaded On" := Today;

    //             SDA.Insert(true);
    //         end
    //         else
    //             Error('School Docs Response\%1', ResponseText);

    //         NewAttachmentRec.Get(TempNo);
    //         NewAttachmentRec.Delete();
    //         Message('Document for Special Accommodation Application of Student No. %1 (%2) has been Uploded.', StudentNo, "Student Name");
    //     end;
    // end;

    var
        ClinicalRefNo: Code[20];

}