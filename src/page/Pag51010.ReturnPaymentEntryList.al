page 51010 "Return Payment Entry List"
{

    ApplicationArea = All;
    Caption = 'Reversal Entry List';
    PageType = List;
    SourceTable = "SLcM Reversal Entry";
    ;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field(Status; Status)
            {
                ApplicationArea = All;
                Editable = false;
            }
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    editable = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Specifies the value of the Student No. field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document No."; Rec."Payment Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Select"; Rec."Payment Document Select")
                {
                    ToolTip = 'Specifies the value of the Document Select field';
                    ApplicationArea = All;
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Remaning Amount"; Rec."Remaning Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Reverse Applicable"; Rec."Reverse Applicable")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Reverse")
            {
                Image = GetActionMessages;
                action("Reverse Entry")
                {
                    ApplicationArea = all;
                    Image = EntryStatistics;
                    trigger OnAction()
                    var
                        // ReversalEntry: Record "Reveral Entry SCLM";
                        // GLEntry: Record "G/L Entry";
                        // ReturnEntry: Record "Return Payment Entry";
                        ReturnPaymentEntry: Record "SLcM Reversal Entry";
                        ReturnPaymentEntry2: Record "SLcM Reversal Entry";
                        JobQueue: Record "Job Queue Entry";
                        TextLbl: Label 'Do you want to reverse %1 entries ?';
                        JobQueueMsgFail: Label 'Some of entries are not reversed. Please check job queue entries.';
                        JobQueueMsgSuccess: Label 'Reversed transaction successfully completed.';
                        EntryToReverse: Integer;
                        EntriesReversed: Integer;
                        DocumentNo: Code[20];
                        FullyReversed: Boolean;
                        MyDialog: Dialog;
                        myInteger: Record Integer;
                        myInteger1: Integer;
                    begin
                        ReturnPaymentEntry2.Reset();
                        ReturnPaymentEntry2.SetRange("Payment Document Select", true);
                        ReturnPaymentEntry2.SetRange(Reversed, true);
                        if ReturnPaymentEntry2.findset() then begin
                            repeat
                                ReturnPaymentEntry2."Payment Document Select" := false;
                                ReturnPaymentEntry2.modify();
                            until ReturnPaymentEntry2.Next() = 0;
                        end;

                        FullyReversed := true;
                        ReturnPaymentEntry.Reset();
                        ReturnPaymentEntry.SetRange("Payment Document Select", true);
                        if ReturnPaymentEntry.findset() then begin
                            RevCount := ReturnPaymentEntry.Count();
                        end;
                        if Confirm(TextLbl, false, RevCount) then begin
                            JobQueue.Reset();
                            JobQueue.Setrange("Object Type to Run", JobQueue."Object Type to Run"::Report);
                            JobQueue.Setrange("Object ID to Run", 50200);
                            if JobQueue.FindFirst() then
                                JobQueue.DeleteAll();

                            JobQueue.Init();
                            JobQueue.id := CreateGuid();
                            JobQueue."Object Type to Run" := JobQueue."Object Type to Run"::Report;
                            JobQueue."Object ID to Run" := 50200;
                            JobQueue."Report Output Type" := JobQueue."Report Output Type"::"None (Processing only)";
                            JobQueue.Insert(true);
                            JobQueue.Reset();

                            JobQueue.Setrange("Object Type to Run", JobQueue."Object Type to Run"::Report);
                            JobQueue.Setrange("Object ID to Run", 50200);
                            if JobQueue.FindFirst() then begin
                                JobQueue.validate(Status, JobQueue.Status::Ready);
                                JobQueue."Report Output Type" := JobQueue."Report Output Type"::"None (Processing only)";
                                JobQueue.validate("Earliest Start Date/Time", CREATEDATETIME(Today, TIme + 600));
                                JobQueue.Modify();
                            End;

                            // begin
                            //     repeat
                            //         myInteger1 := myInteger1 + 1;
                            //         JobQueue.Reset();
                            //         JobQueue.Setrange("Object Type to Run", JobQueue."Object Type to Run"::Report);
                            //         JobQueue.Setrange("Object ID to Run", 50200);
                            //         if Not JobQueue.FindFirst() then
                            //             myInteger1 := 120000000;
                            //     until myInteger1 = 120000000;
                            // End;

                            // ReturnPaymentEntry2.Reset();
                            // ReturnPaymentEntry2.SetRange("Payment Document Select", true);
                            // ReturnPaymentEntry2.SetRange(Reversed, false);
                            // if ReturnPaymentEntry2.findset() then
                            //     if ReturnPaymentEntry2.Count = 1 then begin
                            //         Message('Out of %1 Selected Entries, %2 Entries Reversed Successfully and 1 Entry of Doc. No. %3 is not Reversed', RevCount, RevCount - 1, ReturnPaymentEntry2."Payment Document No.");
                            //         FullyReversed := False;
                            //     end;

                            // ReturnPaymentEntry.Reset();
                            // ReturnPaymentEntry.SetRange("Payment Document Select", true);
                            // if ReturnPaymentEntry.findset() then;
                            // ReturnPaymentEntry2.Reset();
                            // ReturnPaymentEntry2.SetRange("Payment Document Select", true);
                            // ReturnPaymentEntry2.SetRange(Reversed, false);
                            // if ReturnPaymentEntry2.findset() then;
                            // if ReturnPaymentEntry2.Count = ReturnPaymentEntry.Count then begin
                            //     Message('Out of %1 Selected Entries, 0 Entries Reversed Successfully', ReturnPaymentEntry.Count);
                            //     FullyReversed := false;
                            // end;

                            // if FullyReversed then
                            Message('Please check reversed entry processed List Page for more details after some time.');
                            ReturnPaymentEntry.reset();
                            Rec.Reset();
                            CurrPage.Update(false);
                            Rec.Reset();
                            Rec.FilterGroup(2);
                            Rec.SetRange(Reversed, false);
                            Rec.filtergroup(0);
                        end else begin
                            ReturnPaymentEntry.reset();
                            CurrPage.Update(false);
                            Rec.Reset();
                            Rec.FilterGroup(2);
                            Rec.SetRange(Reversed, false);
                            Rec.filtergroup(0);
                        end;
                    end;
                }
                action(ImportData)
                {
                    caption = 'Import Data';
                    ApplicationArea = All;
                    Image = Import;
                    trigger OnAction()
                    begin
                        Xmlport.Run(50085, false, true);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.Setrange(Reversed, false);
        Rec.FilterGroup(0);
    end;

    trigger OnAfterGetRecord()
    var

    begin
        JobQueueGlobal.Setrange("Object Type to Run", JobQueueGlobal."Object Type to Run"::Report);
        JobQueueGlobal.Setrange("Object ID to Run", 50200);
        if JobQueueGlobal.FindFirst() then
            Status := JobQueueGlobal.Status;
    end;



    var
        RevCount: Integer;
        Status: Option Ready,"In Process",Error,"On Hold",Finished,"On Hold with Inactivity Timeout";
        JobQueueGlobal: Record "Job Queue Entry";
}
