report 50119 "Save LGS - Letter"
{
    Caption = 'Save LGS - Letter';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Roster Ledger Entry"; "Roster Ledger Entry")
        {
            RequestFilterFields = "Clerkship Type", "Rotation ID", "Course Code", "Elective Course Code", "Student ID";
            trigger OnPreDataItem()
            begin
                SetFilter("Start Date", '%1', FromDate);
                TotalCount := Count;
                WindowDialog.Open('Saving LGS Letter....\' + Text001Lbl + Text002Lbl);
                WindowDialog.UPDATE(1, TotalCount);
            end;

            trigger OnAfterGetRecord()
            var
                ClinicalNotification: Codeunit "Clinical Notification";
            begin
                LineCount += 1;
                WindowDialog.UPDATE(2, LineCount);
                //ClinicalNotification.SaveLGSLetter("Roster Ledger Entry", LPathOfFile);
            end;

            trigger OnPostDataItem()
            begin
                Message('File(s) Saved.');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(PathOfFile; LPathOfFile)
                    {
                        Caption = 'Path';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            LPathOfFile := LPathOfFile + '\';
                        end;
                    }
                    field(StartDateFrom; FromDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    var
        WindowDialog: Dialog;
        LPathOfFile: Text;
        Text001Lbl: Label 'Total Letter(s)      ############1################\';
        Text002Lbl: Label 'Current Letter      ############2################\';
        TotalCount: Integer;
        LineCount: Integer;
        FromDate: Date;
}
