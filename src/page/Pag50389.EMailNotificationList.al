page 50389 "E-Mail Notification List"
{

    PageType = List;
    SourceTable = "Email Notification";
    SourceTableView = sorting(Id) order(descending);
    Caption = 'E-Mail Notification List';
    ApplicationArea = All;
    UsageCategory = Administration;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                }
                field("Notification Sent By"; Rec."Notification Sent By")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Receiver Email Id"; Rec."Receiver Email Id")
                {
                    ApplicationArea = All;
                }
                field(ReceiverId; Rec.ReceiverId)
                {
                    ApplicationArea = All;
                }
                field(ReceiverName; Rec.ReceiverName)
                {
                    ApplicationArea = All;
                }
                field(SenderId; Rec.SenderId)
                {
                    ApplicationArea = All;
                }
                field("Sender Name"; Rec."Sender Name")
                {
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
                Field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field(Text_; Rec.Text_)
                {
                    ApplicationArea = All;
                }
                field(EDate; Rec.EDate)
                {
                    ApplicationArea = All;
                }
                field("Email Sent Datetime"; Rec."Email Sent Datetime")
                {
                    ApplicationArea = All;
                }
                field("Email Sent"; Rec."Email Sent")
                {
                    ApplicationArea = All;
                }
                field("Mail Item Id"; Rec."Mail Item Id")
                {
                    ApplicationArea = All;
                    visible = false;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                }
                field("Process No"; Rec."Process No")
                {
                    ApplicationArea = All;
                    Caption = 'Application No.';
                }
                field("Send Email"; Rec."Send Email")
                {
                    ApplicationArea = All;
                    visible = false;
                }
                field("Send Sms"; Rec."Send Sms")
                {
                    ApplicationArea = All;
                }
                field("Sms Sent Datetime"; Rec."Sms Sent Datetime")
                {
                    ApplicationArea = All;
                }
                field("Sms Sent"; Rec."Sms Sent")
                {
                    ApplicationArea = All;
                }
                field("Sms Text"; Rec."Sms Text")
                {
                    ApplicationArea = All;
                }
                field(Event_; Rec.Event_)
                {
                    ApplicationArea = All;
                }
                field(Process; Rec.Process)
                {
                    ApplicationArea = All;
                }
                Field(PortalMail; Rec.PortalMail)
                {
                    ApplicationArea = All;
                }
                Field("File Attachment"; Rec."File Attachment")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                }

            }
        }
    }

    // actions
    // {
    //     area(processing)
    //     {
    //         action("Download Unofficial Transcript")
    //         {
    //             ApplicationArea = All;
    //             Promoted = true;
    //             PromotedOnly = true;
    //             PromotedIsBig = true;
    //             PromotedCategory = Process;
    //             Image = Download;

    //             trigger OnAction()
    //             var
    //                 IStream: InStream;
    //                 FielNAme: Text;
    //             Begin
    //                 Rec.CalcFields("File Attachment");
    //                 FielNAme := '';
    //                 FielNAme := Format(Rec."File Attachment");
    //                 Rec."File Attachment".CreateInStream(IStream);
    //                 DownloadFromStream(IStream, 'Export', '', '*.pdf*', FielNAme);

    //             End;
    //         }
    //     }
    // }


}
