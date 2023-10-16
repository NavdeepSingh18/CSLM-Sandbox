page 50026 "Attachment Stud Wise-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/01/2019       Open Attachment-OnAction()                 Use for Open Attachment
    // 02    CSPL-00059   07/01/2019       ImportAttachment-OnAction()                Use for Import Attachment
    // 03    CSPL-00059   07/01/2019       ExportAttachment-OnAction()                Use for Export Attachment
    // 04    CSPL-00059   07/01/2019       RemoveAttachment-OnAction()                Use for Remove Attachment
    Caption = 'Documents Received';
    AutoSplitKey = true;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Attachment Wise Student-CS";
    // DeleteAllowed = false;
    SourceTableView = Sorting("Updated On", "Created On") Order(descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Student No';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Line No.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ToolTip = 'Student Name';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ToolTip = 'Enrollment No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Document Type';
                    ApplicationArea = All;
                }
                field("Document Description"; Rec."Document Description")
                {
                    ToolTip = 'Document Description';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("File Name"; Rec."File Name")
                {
                    ToolTip = 'File Name';
                    ApplicationArea = All;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ToolTip = 'File Extension';
                    ApplicationArea = All;
                }
                field("Attachment No."; Rec."Attachment No.")
                {
                    ToolTip = 'Attachment No.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Approved; Rec.Approved)
                {
                    ToolTip = 'Approved';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;

                }
                field("Approved By"; Rec."Approved By")
                {
                    ToolTip = 'Approved By';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Reject Reason"; Rec."Reject Reason")
                {
                    ToolTip = 'Specifies the value of the Reject Reason field.';
                    ApplicationArea = All;
                }
                field("Reject Reason Description"; Rec."Reject Reason Description")
                {
                    ToolTip = 'Specifies the value of the Reject Reason Description field.';
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created On"; Rec."Created On")
                {
                    ToolTip = 'Specifies the value of the Created On field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Updated By"; Rec."Updated By")
                {
                    ToolTip = 'Specifies the value of the Updated By field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Updated On"; Rec."Updated On")
                {
                    ToolTip = 'Specifies the value of the Updated On field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Visible = false;//CSPL-00307
                action("Open Attachment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Open Attachment';
                    Caption = 'Open Attachment';
                    Promoted = true;
                    PromotedOnly = true;

                    PromotedCategory = Process;
                    Visible = false;
                    trigger OnAction()
                    begin
                        //Code added for Open Attachment::CSPL-00059::07012019: Start
                        // OpenAttachment();
                        //Code added for Open Attachment::CSPL-00059::07012019: End
                    end;
                }
                action("Import Document")
                {
                    ApplicationArea = All;
                    Caption = 'Import Document';
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Visible = false;
                    trigger OnAction()
                    begin
                        //Code added for Import Attachment::CSPL-00059::07012019: Start
                        // ImportAttachment();
                        //Code added for Open Attachment::CSPL-00059::07012019: End
                    end;
                }
                action("Export Attachment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Export Attachment';
                    Caption = 'Export Attachment';
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Visible = false;
                    trigger OnAction()
                    begin
                        //Code added for Export Attachment::CSPL-00059::07012019: Start
                        // ExportAttachment();
                        //Code added for Export Attachment::CSPL-00059::07012019: End
                    end;
                }
                action("Remove Attachment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Remove Attachment';
                    Caption = 'Remove Attachment';
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Visible = false;
                    trigger OnAction()
                    begin
                        //Code added for Remove Attachment::CSPL-00059::07012019: Start
                        // RemoveAttachment(TRUE);
                        //Code added for Remove Attachment::CSPL-00059::07012019: End
                    end;
                }
            }
            action(Approve)
            {
                ApplicationArea = All;
                Image = Approval;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = VisibleBoolean;
                trigger OnAction()
                var
                    RecAttWiseStudent: Record "Attachment Wise Student-CS";
                begin
                    RecAttWiseStudent.Reset();
                    IF Not Confirm('Are you sure do you want to Approve ?') then
                        exit;
                    CurrPage.SetSelectionFilter(RecAttWiseStudent);
                    RecAttWiseStudent.SetFilter(Status, '<>%1', RecAttWiseStudent.Status::Approved);
                    IF RecAttWiseStudent.FindSet() then begin
                        repeat
                            RecAttWiseStudent.TestField(Status, RecAttWiseStudent.Status::Pending);
                            RecAttWiseStudent.Status := RecAttWiseStudent.Status::Approved;
                            RecAttWiseStudent.Approved := true;
                            RecAttWiseStudent."Approved By" := UserId;
                            RecAttWiseStudent.Modify();
                        // Rec.SendEMail(RecAttWiseStudent);
                        until RecAttWiseStudent.Next() = 0;
                        Message('Approved');
                    end;
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Image = Reject;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = VisibleBoolean;
                trigger OnAction()
                var
                    RecAttWiseStudent: Record "Attachment Wise Student-CS";
                begin
                    RecAttWiseStudent.Reset();
                    IF Not Confirm('Are you sure do you want to Reject ?') then
                        exit;
                    CurrPage.SetSelectionFilter(RecAttWiseStudent);
                    RecAttWiseStudent.SetFilter(Status, '<>%1', RecAttWiseStudent.Status::Approved);
                    IF RecAttWiseStudent.FindSet() then begin
                        repeat
                            RecAttWiseStudent.TestField(Status, RecAttWiseStudent.Status::Pending);
                            RecAttWiseStudent.TestField("Reject Reason");
                            RecAttWiseStudent.Status := RecAttWiseStudent.Status::Rejected;
                            RecAttWiseStudent.Modify();
                        // Rec.SendEMail(RecAttWiseStudent);
                        until RecAttWiseStudent.Next() = 0;
                        Message('Rejected');
                    end;
                end;
            }
            action("Download Document")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = TRUE;
                Image = ExportAttachment;

                Trigger OnAction()
                Var
                    StudentDocumentAttachment_lRec: Record "Student Document Attachment";
                // StudentDocumentAttachment_lPag: Page "Site Visit Doc Attachment";
                Begin
                    // Clear(StudentDocumentAttachment_lPag);
                    // StudentDocumentAttachment_lRec.Reset();
                    // StudentDocumentAttachment_lRec.SetRange("Transaction No.", Rec."Transaction No.");
                    // StudentDocumentAttachment_lPag.SetTableView(StudentDocumentAttachment_lRec);
                    // StudentDocumentAttachment_lPag.InitPrameter(true);
                    // StudentDocumentAttachment_lPag.Run();
                End;
            }
        }
    }

    var
        VisibleBoolean: Boolean;

    trigger OnAfterGetRecord()
    var
    // myInt: Integer;
    begin
        IF (Rec.Status = Rec.Status::Pending) then
            VisibleBoolean := true
        else
            VisibleBoolean := false;
    end;

    trigger OnOpenPage()
    var
    // myInt: Integer;
    begin
        IF (Rec.Status = Rec.Status::Pending) then
            VisibleBoolean := true
        else
            VisibleBoolean := false;
    end;

}

