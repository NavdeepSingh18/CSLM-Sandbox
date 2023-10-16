page 50137 SiteVisit
{
    PageType = Document;
    //ApplicationArea = All;
    UsageCategory = none;
    SourceTable = "Site Visit";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                    ApplicationArea = All;
                    Trigger OnAssistEdit()
                    Begin
                        IF Rec.AssistEdit(xRec) then
                            Currpage.update();
                    End;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the Visitor ID field.';
                    ApplicationArea = All;
                }
                field("Visitor Name"; Rec."Visitor Name")
                {
                    ToolTip = 'Specifies the value of the Visitor Name field.';
                    ApplicationArea = All;
                }
                field("Visit Date"; Rec."Visit Date")
                {
                    ToolTip = 'Specifies the value of the Visit Date field.';
                    ApplicationArea = All;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ToolTip = 'Specifies the value of the Hospital ID field.';
                    ApplicationArea = All;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ToolTip = 'Specifies the value of the Hospital Name field.';
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ToolTip = 'Specifies the value of the Department Name field.';
                    ApplicationArea = All;
                }
                field("Person Name"; Rec."Person Name")
                {
                    ToolTip = 'Specifies the value of the Person Name field.';
                    ApplicationArea = All;
                }
                field(Speciality; Rec.Speciality)
                {
                    ToolTip = 'Specifies the value of the Speciality field.';
                    ApplicationArea = All;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ToolTip = 'Specifies the value of the Course Description field.';
                    ApplicationArea = All;
                }
                field("Visit Reason"; Rec."Visit Reason")
                {
                    ToolTip = 'Specifies the value of the Visit Reason field.';
                    ApplicationArea = All;
                }
                field(Inference; Rec.Inference)
                {
                    ToolTip = 'Specifies the value of the Inference field.';
                    ApplicationArea = All;
                }
            }
            Group("Basic Info")
            {

                field("Number of Beds"; Rec."Number of Beds")
                {
                    ToolTip = 'Specifies the value of the Number of Beds field.';
                    ApplicationArea = All;
                }
                field("Street Address"; Rec."Street Address")
                {
                    ToolTip = 'Specifies the value of the Street Address field.';
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.';
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ToolTip = 'Specifies the value of the State field.';
                    ApplicationArea = All;
                }
                field(Country; Rec.Country)
                {
                    ToolTip = 'Specifies the value of the Country field.';
                    ApplicationArea = All;
                }
                field("Zip Code"; Rec."Zip Code")
                {
                    ToolTip = 'Specifies the value of the Zip Code field.';
                    ApplicationArea = All;
                }
                field("Approved ACGME Resiency Program(s)"; Rec."Appr. ACGME Residency Prog.")
                {
                    ToolTip = 'Specifies the value of the Approved ACGME Residency Program field.';
                    ApplicationArea = All;
                }
                field("Other Services"; Rec."Other Services")
                {
                    ToolTip = 'Specifies the value of the Other Services field.';
                    ApplicationArea = All;
                }
                field("DME First Name"; Rec."DME First Name")
                {
                    ToolTip = 'Specifies the value of the DME First Name field.';
                    ApplicationArea = All;
                }
                field("DME Last Name"; Rec."DME Last Name")
                {
                    ToolTip = 'Specifies the value of the DME Last Name field.';
                    ApplicationArea = All;
                }
                field("DME Email"; Rec."DME Email")
                {
                    ToolTip = 'Specifies the value of the DME Email field.';
                    ApplicationArea = All;
                }
                field("DME Phone with Area Code"; Rec."DME Phone with Area Code")
                {
                    ToolTip = 'Specifies the value of the DME Phone field.';
                    ApplicationArea = All;
                }
                field("Dept Chairperson First Name"; Rec."Dept Chairperson First Name")
                {
                    ToolTip = 'Specifies the value of the Dept Chairperson First Name field.';
                    ApplicationArea = All;
                }
                field("Dept Chairperson Last Name"; Rec."Dept Chairperson Last Name")
                {
                    ToolTip = 'Specifies the value of the Dept Chairperson Last Name field.';
                    ApplicationArea = All;
                }
                field("Dept Chairperson Email"; Rec."Dept Chairperson Email")
                {
                    ToolTip = 'Specifies the value of the Dept Chairperson Email field.';
                    ApplicationArea = All;
                }
                field("Dept Chairperson Phone with Area Code"; Rec."Dept Chairperson Phone")
                {
                    ToolTip = 'Specifies the value of the Dept Chairperson Phone field.';
                    ApplicationArea = All;
                }
                field("Program Director First Name"; Rec."Program Director First Name")
                {
                    ToolTip = 'Specifies the value of the Program Director First Name field.';
                    ApplicationArea = All;
                }
                field("Program Director Last Name"; Rec."Program Director Last Name")
                {
                    ToolTip = 'Specifies the value of the Program Director Last Name field.';
                    ApplicationArea = All;
                }
                field("Program Director Email"; Rec."Program Director Email")
                {
                    ToolTip = 'Specifies the value of the Program Director Email field.';
                    ApplicationArea = All;
                }
                field("Program Director Phone with Area Code"; Rec."Program Director Phone")
                {
                    ToolTip = 'Specifies the value of the Program Director Phone field.';
                    ApplicationArea = All;
                }
                field("Clerkship Director First Name"; Rec."Clerkship Director First Name")
                {
                    ToolTip = 'Specifies the value of the Clerkship Director First Name field.';
                    ApplicationArea = All;
                }
                field("Clerkship Director Last Name"; Rec."Clerkship Director Last Name")
                {
                    ToolTip = 'Specifies the value of the Clerkship Director Last Name field.';
                    ApplicationArea = All;
                }
                field("Clerkship Director Email"; Rec."Clerkship Director Email")
                {
                    ToolTip = 'Specifies the value of the Clerkship Director Email field.';
                    ApplicationArea = All;
                }
                field("Clerkship Director Phone with Area Code"; Rec."Clerkship Director Phone")
                {
                    ToolTip = 'Specifies the value of the Clerkship Director Phone field.';
                    ApplicationArea = All;
                }
                field("Student Preceptor Contact"; Rec."Student Preceptor Contact")
                {
                    ToolTip = 'Specifies the value of the Student Preceptor Contact field.';
                    ApplicationArea = All;
                }

                field("Student Coordinator Contact"; Rec."Student Coordinator Contact")
                {
                    ToolTip = 'Specifies the value of the Student Coordinator Contact field.';
                    ApplicationArea = All;
                }
            }
            Group(Faculty)

            {
                field("Number of Clinical Faculty"; Rec."Number of Clinical Faculty")
                {
                    ToolTip = 'Specifies the value of the Number of Clinical Faculty field.';
                    ApplicationArea = All;
                }
                field("Formal Lectures"; Rec."Formal Lectures")
                {
                    ToolTip = 'Specifies the value of the Formal Lectures field.';
                    ApplicationArea = All;
                }

                field("Informal Teaching"; Rec."Informal Teaching")
                {
                    ToolTip = 'Specifies the value of the Informal Teaching field.';
                    ApplicationArea = All;
                }
                field("Faculty Supervision"; Rec."Faculty Supervision")
                {
                    ToolTip = 'Specifies the value of the Faculty Supervision field.';
                    ApplicationArea = All;
                }
                field("Faculty Assessment of Students"; Rec."Faculty Assessment of Students")
                {
                    ToolTip = 'Specifies the value of the Faculty Assessment of Students field.';
                    ApplicationArea = All;
                }


                field("General Comments"; Rec."General Comments")
                {
                    ToolTip = 'Specifies the value of the General Comments field.';
                    ApplicationArea = All;
                }
            }
            Group(Students)
            {

                field("Number of AUA students Rotating"; Rec."AUA students Rotating")
                {
                    ToolTip = 'Specifies the value of the Number of AUA students Rotating field.';
                    ApplicationArea = All;
                }
                field("Number of students from other medical schools in that rotation"; Rec."Other Med. School Rotation")
                {
                    ToolTip = 'Specifies the value of the Number of students from other medical schools in that rotation field.';
                    ApplicationArea = All;
                }
                field("Participates Morning Report"; Rec."Participates Morning Report")
                {
                    ToolTip = 'Specifies the value of the Participates Morning Report field.';
                    ApplicationArea = All;
                }
                field("Participates Daily Rounds"; Rec."Participates Daily Rounds")
                {
                    ToolTip = 'Specifies the value of the Participates Daily Rounds field.';
                    ApplicationArea = All;
                }

                field("Performs History"; Rec."Performs History")
                {
                    ToolTip = 'Specifies the value of the Performs History field.';
                    ApplicationArea = All;
                }
                field("Performs Physical"; Rec."Performs Physical")
                {
                    ToolTip = 'Specifies the value of the Performs Physical field.';
                    ApplicationArea = All;
                }
                field("Ambulatory Training"; Rec."Ambulatory Training")
                {
                    ToolTip = 'Specifies the value of the Ambulatory Training field.';
                    ApplicationArea = All;
                }
                field("Performs Procedures"; Rec."Performs Procedures")
                {
                    ToolTip = 'Specifies the value of the Performs Procedures field.';
                    ApplicationArea = All;
                }
                field("Writes/Types Orders"; Rec."Writes/Types Orders")
                {
                    ToolTip = 'Specifies the value of the Writes/Types Orders field.';
                    ApplicationArea = All;
                }
                field("EMR Entry"; Rec."EMR Entry")
                {
                    ToolTip = 'Specifies the value of the EMR Entry field.';
                    ApplicationArea = All;
                }
                field("Night Calls/Rotation"; Rec."Night Calls/Rotation")
                {
                    ToolTip = 'Specifies the value of the Night Calls/Rotation field.';
                    ApplicationArea = All;
                }
                field("Case Presentations"; Rec."Case Presentations")
                {
                    ToolTip = 'Specifies the value of the Case Presentations field.';
                    ApplicationArea = All;
                }
                field(General_Comments; Rec.General_Comments)
                {
                    ToolTip = 'Specifies the value of the General_Comments field.';
                    ApplicationArea = All;
                }
            }
            Group(Facilities)
            {
                field("Student Facilities"; Rec."Student Facilities")
                {
                    ToolTip = 'Specifies the value of the Student Facilities field.';
                    ApplicationArea = All;
                }
                field("Education Facilities"; Rec."Education Facilities")
                {
                    ToolTip = 'Specifies the value of the Education Facilities field.';
                    ApplicationArea = All;
                }
            }
            group("Rotation Rating")
            {
                field(Rating; Rec.Rating)
                {
                    ToolTip = 'Specifies the value of the Rating field.';
                    ApplicationArea = All;
                }
                field(GeneralComments; Rec.GeneralComments)
                {
                    ToolTip = 'Specifies the value of the GeneralComments field.';
                    ApplicationArea = All;
                }
            }
            Group("Final Recommendation")
            {
                field(Approval; Rec.Approval)
                {
                    ToolTip = 'Specifies the value of the Approval field.';
                    ApplicationArea = All;
                }
                field("Approval Comments"; Rec."Approval Comments")
                {
                    ToolTip = 'Specifies the value of the Approval Comments field.';
                    ApplicationArea = All;
                }
            }


        }

    }
    actions
    {
        area(Processing)
        {
            action("Upload Attachment")
            {
                ApplicationArea = All;
                ShortcutKey = 'Ctrl+Shift+D';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = TRUE;
                Image = Attachments;

                trigger OnAction()
                var
                    StudentDocumentAttachment: Record "Faculty Choice";
                    EntryNo: Integer;
                begin
                    StudentDocumentAttachment.Reset();
                    StudentDocumentAttachment.SetRange("Faculty Code", Rec."Document No.");
                    if StudentDocumentAttachment.FindLast() then
                        EntryNo := StudentDocumentAttachment."Line No";
                    EntryNo := EntryNo + 1;

                    AttachmentDocument(EntryNo);
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
                    StudentDocumentAttachment_lRec: Record "Faculty Choice";
                    StudentDocumentAttachment_lPag: Page "Select Faculty-CS";
                Begin
                    Clear(StudentDocumentAttachment_lPag);
                    StudentDocumentAttachment_lRec.Reset();
                    StudentDocumentAttachment_lRec.SetRange("Faculty Code", Rec."Document No.");
                    StudentDocumentAttachment_lRec.SetRange("Site Visit Entry", true);
                    StudentDocumentAttachment_lPag.SetTableView(StudentDocumentAttachment_lRec);
                    StudentDocumentAttachment_lPag.Run();
                End;
            }
        }
    }

    procedure AttachmentDocument(EntryNo: Integer)
    var
        SDA: Record "Student Document Attachment";
        FacultyChoice: Record "Faculty Choice";
        TempBlob: Record "TempBlob Test";
        StudentMaster: Record "Student Master-CS";
        // FileMgmt: Codeunit "File Management";
        SalesOrder: Page "Sales Order";
        locOutFile: BigText;
        ResponseText: Text;
        FileName: Text;
        IStream: InStream;
        TransactionNo: Text[100];
        WindowDialog: Dialog;

    begin
        if not Confirm('Do you want to upload Document?') then
            exit;

        /*FileName := FileMgmt.UploadFile('Upload', 'C\LGSLetter');

        WindowDialog.Open('Uploading file...\Please wait...');
        if FileName = '' then
            exit;

        TempBlob.Reset();
        TempBlob.DeleteAll();

        TempBlob.INIT();
        TempBlob.Blob.IMPORT(FileName);
        TempBlob.INSERT();
        TempBlob.Blob.CREATEINSTREAM(IStream);
        MemoryStream := MemoryStream.MemoryStream();
        COPYSTREAM(MemoryStream, IStream);
        Bytes := MemoryStream.GetBuffer();
        locOutFile.ADDTEXT(Convert.ToBase64String(Bytes));
        ResponseText := SDA.UploadSchoolDoc('ZZZZZ', 'SITEVISIT', FileName, Format(locOutFile));
        // StudentMaster.Reset();
        // IF StudentMaster.Get('ZZZZZ') then;

        IF StrPos(ResponseText, '1</Success>') > 0 then begin
            TransactionNo := SDA.FindStringValue(ResponseText);

            FacultyChoice.Init();
            FacultyChoice."Document Category" := 'EED CLINICAL';
            FacultyChoice."Document Sub Category" := 'SITEVISIT';
            FacultyChoice.Description := 'Site Visit Document';
            FacultyChoice."Document Description" := 'Academics';
            FacultyChoice.Validate("Student No.", 'ZZZZZ');
            FacultyChoice."Student Name" := 'ZZZZZ';
            //SDA."Subject Code" := Speciality;
            FacultyChoice."Faculty Code" := "Document No.";
            FacultyChoice."Transaction No." := TransactionNo;
            FacultyChoice."Line No" := EntryNo;
            FacultyChoice."File Name" := FileName;
            FacultyChoice."Uploaded Source" := SDA."Uploaded Source"::SLcMBC;
            FacultyChoice."Document Status" := SDA."Document Status"::"Submitted";
            FacultyChoice."Submission Date" := Today;
            FacultyChoice."Uploaded By" := UserId;
            FacultyChoice."Uploaded On" := Today;
            FacultyChoice."Document Update Date" := Today();
            FacultyChoice."Site Visit Entry" := true;
            FacultyChoice.Insert();
        end
        else
            Error('School Docs Error\%1', ResponseText);

        WindowDialog.Close();
        Message('Document - %1 has been Uploded.', 'Site Visit Document');*/
    end;
    // actions
    // {
    //     area(Processing)
    //     {
    //         action("Upload Attachment")
    //         {
    //             ApplicationArea = All;
    //             ShortcutKey = 'Ctrl+Shift+D';
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             PromotedOnly = TRUE;
    //             Image = Attachments;
    //             Visible = False;
    //             trigger OnAction()
    //             var
    //                 StudentDocumentAttachment: Record "Student Document Attachment";
    //                 EntryNo: Integer;
    //             begin
    //                 StudentDocumentAttachment.Reset();
    //                 if StudentDocumentAttachment.FindLast() then
    //                     EntryNo := StudentDocumentAttachment."Entry No.";
    //                 EntryNo := EntryNo + 1;

    //                 AttachmentDocument(EntryNo);
    //             end;
    //         }

    //         action("Download Document")
    //         {
    //             ApplicationArea = All;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             PromotedOnly = TRUE;
    //             Image = ExportAttachment;
    //             Visible = False;
    //             Trigger OnAction()
    //             Var
    //                 StudentDocumentAttachment_lRec: Record "Student Document Attachment";
    //                 StudentDocumentAttachment_lPag: Page "Site Visit Doc Attachment";
    //             Begin
    //                 Clear(StudentDocumentAttachment_lPag);
    //                 StudentDocumentAttachment_lRec.Reset();
    //                 StudentDocumentAttachment_lRec.SetRange("SLcM Document No", "Document No.");
    //                 StudentDocumentAttachment_lPag.SetTableView(StudentDocumentAttachment_lRec);
    //                 StudentDocumentAttachment_lPag.Run();
    //             End;
    //         }
    //     }
    // }

    // procedure AttachmentDocument(EntryNo: Integer)
    // var
    //     SDA: Record "Student Document Attachment";
    //     TempBlob: Record "TempBlob Test";
    //     StudentMaster: Record "Student Master-CS";
    //     FileMgmt: Codeunit "File Management";
    //     SalesOrder: Page "Sales Order";
    //     locOutFile: BigText;
    //     ResponseText: Text;
    //     FileName: Text;
    //     IStream: InStream;
    //     TransactionNo: Text[100];
    //     WindowDialog: Dialog;
    //     MemoryStream: DotNet NewImageStream;
    //     Bytes: DotNet Bytes;
    //     Convert: DotNet ImageConvert;
    // begin
    //     if not Confirm('Do you want to upload Document?') then
    //         exit;

    //     FileName := FileMgmt.UploadFile('Upload', 'C\LGSLetter');

    //     WindowDialog.Open('Uploading file...\Please wait...');
    //     if FileName = '' then
    //         exit;

    //     TempBlob.Reset();
    //     TempBlob.DeleteAll();

    //     TempBlob.INIT();
    //     TempBlob.Blob.IMPORT(FileName);
    //     TempBlob.INSERT();
    //     TempBlob.Blob.CREATEINSTREAM(IStream);
    //     MemoryStream := MemoryStream.MemoryStream();
    //     COPYSTREAM(MemoryStream, IStream);
    //     Bytes := MemoryStream.GetBuffer();
    //     locOutFile.ADDTEXT(Convert.ToBase64String(Bytes));
    //     ResponseText := SDA.UploadSchoolDoc('ZZZZZ', 'SITEVISIT', FileName, Format(locOutFile));
    //     StudentMaster.Reset();
    //     IF StudentMaster.Get('ZZZZZ') then;

    //     IF StrPos(ResponseText, '1</Success>') > 0 then begin
    //         TransactionNo := SDA.FindStringValue(ResponseText);

    //         SDA.Init();
    //         SDA."Entry No." := EntryNo;
    //         SDA."Document Category" := 'EED CLINICAL';
    //         SDA."Document Sub Category" := 'SITEVISIT';
    //         SDA.Description := 'Site Visit Document';
    //         SDA."Document Description" := 'Academics';
    //         SDA.Validate("Student No.", 'ZZZZZ');
    //         SDA."Student Name" := 'ZZZZZ';
    //         //SDA."Subject Code" := Speciality;
    //         SDA."SLcM Document No" := "Document No.";
    //         SDA."Transaction No." := TransactionNo;
    //         SDA."Note Entry No" := -100;
    //         SDA."File Name" := FileName;
    //         SDA."Uploaded Source" := SDA."Uploaded Source"::SLcMBC;
    //         SDA."Document Status" := SDA."Document Status"::"Submitted";
    //         SDA."Submission Date" := Today;
    //         SDA."Uploaded By" := UserId;
    //         SDA."Uploaded On" := Today;
    //         SDA."Document Update Date" := Today();
    //         SDA.Insert(true);
    //     end
    //     else
    //         Error('School Docs Error\%1', ResponseText);

    //     WindowDialog.Close();
    //     Message('Document - %1 has been Uploded.', 'Site Visit Document');
    // end;
}