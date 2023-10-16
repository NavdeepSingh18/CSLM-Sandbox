page 50068 "Transcript Card"
{
    PageType = Card;
    // ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = "Competition H-CS";
    layout
    {
        area(Content)
        {
            group(GroupName)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                    trigger OnAssistEdit()
                    begin
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                    end;
                }
                field("Competition Name"; Rec."Competition Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Competition Type"; Rec."Competition Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Print By field.';
                }
                field("Competition Date"; Rec."Competition Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Print Date field.';
                }
                field("Last Print Date"; Rec."Last Print Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Print Date field.';
                }
                Field("Print Type"; Rec."Print Type")
                {
                    ApplicationArea = All;
                }
            }
            part(Lines; "Transcript Lines")
            {
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = all;
                Editable = False;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(transcript)////GAURAV//14//02//23
            {
                ApplicationArea = All;
                Caption = 'Upload File';
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;


                // trigger OnAction()
                // Var
                //     transcript: XMLPort transcript;
                // begin
                //     transcript.GetValue(Rec."No.");
                //     transcript.run;


                //end;
            }
            action("Print Transcript")
            {
                ApplicationArea = All;
                Caption = 'Print Transcript';
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                Trigger OnAction()
                vAr
                    TranscriptLine: Record "Competition L-CS";
                    StudentTimeLine: Record "Student Time Line";
                Begin
                    If Rec."Print Type" = Rec."Print Type"::" " then
                        Error('Please select either Official or UnOfficial Transcript');

                    If not Confirm('Do you want to print Bulk Transcript?', false) then
                        exit;

                    TranscriptLine.Reset();
                    TranscriptLine.SetRange("Document No.", Rec."No.");
                    TranscriptLine.ModifyAll(Print, false);
                    TranscriptLine.ModifyAll(Reprint, true);
                    TranscriptLine.ModifyAll("File created", False);
                    Rec."Competition Type" := UserId();
                    Rec."Last Print Date" := Today();
                    StudentTimeLine.InsertRecordFun(Rec."No.", '', 'Bulk Transcript print has been requested', UserId(), Today());
                    Message('Print request has been Noted');
                    CurrPage.Close();
                End;
            }

            action("Re-Print Transcript")
            {
                ApplicationArea = All;
                Caption = 'Re-Print Transcript';
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                Trigger OnAction()
                vAr
                    TranscriptLine: Record "Competition L-CS";
                    StudentTimeLine: Record "Student Time Line";
                Begin
                    If Rec."Print Type" = Rec."Print Type"::" " then
                        Error('Please select either Official or UnOfficial Transcript');

                    If not Confirm('Do you want to re-print Bulk Transcript?', false) then
                        exit;

                    TranscriptLine.Reset();
                    TranscriptLine.SetRange("Document No.", Rec."No.");
                    TranscriptLine.ModifyAll(Reprint, false);
                    TranscriptLine.ModifyAll(Print, true);
                    TranscriptLine.ModifyAll("File created", False);
                    Rec."Competition Type" := UserId();
                    Rec."Last Print Date" := Today();
                    StudentTimeLine.InsertRecordFun(Rec."No.", '', 'Bulk Transcript re-print has been requested', UserId(), Today());
                    Message('Re-Print request has been Noted');
                    CurrPage.Close();
                End;
            }


        }
    }
}