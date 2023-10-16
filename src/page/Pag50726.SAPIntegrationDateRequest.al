page 50726 "SAP Integration Date Request"
{
    ApplicationArea = All;
    Caption = 'SAP Integration Date Request';
    PageType = Document;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group("Date Filter")
            {
                field("Start Date"; StartDate)
                {
                    Caption = 'Start Date';
                    ApplicationArea = All;
                    ToolTip = 'To Date must be filled';
                    trigger OnValidate()
                    begin
                        If EndDate <> 0D then begin
                            IF StartDate > EndDate then
                                Error('Start Date must be less then End Date');
                        end;
                    end;
                }

                field("End Date"; EndDate)
                {
                    Caption = 'End Date';
                    ApplicationArea = All;
                    ToolTip = 'To Date must be filled';
                    Editable = true;

                    trigger OnValidate()
                    Begin
                        if EndDate > WorkDate then
                            error('End Date must be less then Work Date');
                    End;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Go-To SAP Integration Data")
            {
                ApplicationArea = All;
                Caption = 'Go-To SAP Integration Data';
                Image = NextRecord;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    IF StartDate <> 0D Then begin
                        GLEntriesDateWise.DeleteAll();
                        GLEntry.Reset();
                        GLEntry.SetRange("Posting Date", StartDate, EndDate);
                        IF GLEntry.FindSet() then
                            repeat
                                CustomerPostingGroup.Reset();
                                CustomerPostingGroup.SetRange("Receivables Account", GLEntry."G/L Account No.");
                                IF Not CustomerPostingGroup.FindFirst() Then begin
                                    GLEntriesDateWise.Init();
                                    GLEntriesDateWise.TransferFields(GLEntry);
                                    GLEntriesDateWise.StartDate := StartDate;
                                    GLEntriesDateWise.EndDate := EndDate;
                                    GLEntriesDateWise.Insert();
                                end;
                            Until GLEntry.Next() = 0;
                        PageGLEntriesDateWise.Run();
                    end else
                        Error('Start Date must not be blank');

                end;

            }
        }
    }
    var
        GLEntry: Record "G/L Entry";
        GLEntriesDateWise: Record "G/L Entries Date Wise";
        CustomerPostingGroup: Record "Customer Posting Group";
        PageGLEntriesDateWise: Page "SAP Integration Data";
        StartDate: Date;
        EndDate: Date;


    trigger OnOpenPage()
    begin
        StartDate := WorkDate();
        EndDate := WorkDate();
    end;
}

