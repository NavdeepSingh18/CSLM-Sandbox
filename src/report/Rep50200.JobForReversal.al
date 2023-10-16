report 50200 "Job For Reversal"
{
    Caption = 'Job For Reversal';
    ProcessingOnly = true;
    dataset
    {
        dataitem(integer; "integer")
        {
            DataItemTableView = where(Number = filter(1));
            column(Number; Number)
            {

            }
            trigger OnAfterGetRecord()
            var
                ReversalEntry: Record "Reveral Entry SCLM";
                GLEntry: Record "G/L Entry";
                ReturnEntry: Record "SLcM Reversal Entry";
            begin
                ReturnEntry.reset();
                ReturnEntry.SetRange("Payment Document Select", true);
                ReturnEntry.SetRange(Reversed, False);
                if ReturnEntry.FindSet() then begin
                    repeat
                        GLEntry.reset();
                        GLEntry.SetRange("Document No.", ReturnEntry."Payment Document No.");
                        GLEntry.FindFirst();
                        Clear(ReversalEntry);
                        if GLEntry.Reversed then
                            ReversalEntry.AlreadyReversedEntry(TableCaption, GLEntry."Entry No.");
                        if GLEntry."Journal Batch Name" = '' then
                            ReversalEntry.TestFieldError();
                        GLEntry.TestField(GLEntry."Transaction No.");
                        ReversalEntry.SetHideDialog(true);
                        //ReversalEntry.SetHideWarningDialogs();
                        ReversalEntry.ReverseTransaction(GLEntry."Transaction No.");
                        GLEntry.reset();
                        GLEntry.SetRange("Document No.", ReturnEntry."Payment Document No.");
                        GLEntry.FindFirst();
                        ReturnEntry.Reversed := GLEntry.Reversed;
                        ReturnEntry."Processed Date" := Today();
                        ReturnEntry."Processed Time" := Time;
                        ReturnEntry.Modify();
                    Until ReturnEntry.Next() = 0;
                end;
                ReturnEntry.Reset();
                ReturnEntry.SetRange("Payment Document Select", true);
                ReturnEntry.SetRange(Reversed, true);
                if ReturnEntry.findset() then begin
                    repeat
                        ReturnEntry."Payment Document Select" := false;
                        ReturnEntry.modify();
                    until ReturnEntry.Next() = 0;
                end;

                ReturnEntry.Reset();
                ReturnEntry.SetRange(Reversed, False);
                if ReturnEntry.findset() then begin
                    repeat
                        ReturnEntry.delete();
                    until ReturnEntry.Next() = 0;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
