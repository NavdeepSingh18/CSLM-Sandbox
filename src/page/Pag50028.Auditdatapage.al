page 50028 "Audit Report Data"
{

    PageType = List;
    SourceTable = "Temp Record";
    Caption = 'Audit Report Data';
    UsageCategory = None;
    SourceTableView = sorting("Student ID", "Department Code", "Posting Date") order(ascending);
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                }
                field("Student Last Name"; Rec."Student Last Name")
                {
                    ApplicationArea = All;
                }
                field("Student First Name"; Rec."Student First Name")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }

                field("Doc. Type"; Rec."Doc. Type")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = 'Date';
                    ApplicationArea = All;
                }

                field("Transaction Description"; Rec."Transaction Description")
                {
                    Caption = 'Discription';
                    ApplicationArea = All;
                }

                field("Bill Discription"; Rec."Bill Discription")
                {
                    Caption = 'Charge Type';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Running Balance"; Rec."Running Balance")
                {
                    Caption = 'Running Balance';
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        StudentLegacyLedger: Record "Student Legacy Ledger";
        glentry: Record "Cust. Ledger Entry";
        globaldimensionfilter1: Text;
        datefilter: Date;
        customerno: Code[20];
        billdesc: Text;
        runningtotal: Decimal;
        temprecord: Record "Temp Record";


    trigger OnInit()
    begin

    end;

    trigger OnOpenPage()
    begin
        customerno := '';
        billdesc := '';
        temprecord.Reset();
        temprecord.SetCurrentKey("Student ID", "Department Code", "Posting Date");
        temprecord.Ascending(true);
        temprecord.SetRange("Unique ID", 'AUDITREPORT' + UserId());
        if temprecord.FindFirst() then
            repeat
                if (customerno <> temprecord."Student ID") or (billdesc <> temprecord."Bill Discription") then begin
                    Clear(runningtotal);
                    if temprecord."Bill Discription" = 'Tution' then begin
                        Clear(runningtotal);
                        StudentLegacyLedger.reset();
                        StudentLegacyLedger.SetRange("Date", 0D, (datefilter) - 1);
                        StudentLegacyLedger.SetRange("Student Number", temprecord."student id");
                        if globaldimensionfilter1 <> '' then
                            StudentLegacyLedger.setfilter("Global Dimension 1 Code", globaldimensionfilter1);
                        StudentLegacyLedger.setfilter("Global Dimension 2 Code", '%1', '');
                        if StudentLegacyLedger.Findfirst() then BEGIN
                            StudentLegacyLedger.CalcSums(Amount);
                            RunningTotal := StudentLegacyLedger.Amount;
                        end;

                        glentry.reset();
                        glentry.setrange("posting Date", 0D, (datefilter) - 1);
                        glentry.SetRange("customer No.", temprecord."Student ID");
                        if globaldimensionfilter1 <> '' then
                            glentry.setfilter("Global Dimension 1 Code", globaldimensionfilter1);
                        glentry.setfilter("Global Dimension 2 Code", '%1', '');
                        glentry.SetRange(Reversed, false);
                        glentry.SetFilter("Document No.", '<>%1', 'OPNG*');
                        if glentry.Findfirst() then BEGIN
                            repeat
                                glentry.CalcFields(Amount);
                                RunningTotal += glentry.Amount;
                            until glentry.Next() = 0;
                        end;
                    end;

                    if temprecord."Bill Discription" = 'Housing' then begin
                        Clear(runningtotal);
                        StudentLegacyLedger.reset();
                        StudentLegacyLedger.SetRange("Date", 0D, (datefilter) - 1);
                        StudentLegacyLedger.SetRange("Student Number", temprecord."student id");
                        if globaldimensionfilter1 <> '' then
                            StudentLegacyLedger.setfilter("Global Dimension 1 Code", globaldimensionfilter1);
                        StudentLegacyLedger.setfilter("Global Dimension 2 Code", '<>%1', '');
                        if StudentLegacyLedger.Findfirst() then BEGIN
                            StudentLegacyLedger.CalcSums(Amount);
                            RunningTotal := StudentLegacyLedger.Amount;
                        end;

                        glentry.reset();
                        glentry.setrange("posting Date", 0D, (datefilter) - 1);
                        glentry.SetRange("customer No.", temprecord."Student ID");
                        if globaldimensionfilter1 <> '' then
                            glentry.setfilter("Global Dimension 1 Code", globaldimensionfilter1);
                        glentry.setfilter("Global Dimension 2 Code", '<>%1', '');
                        glentry.SetRange(Reversed, false);
                        glentry.SetFilter("Document No.", '<>%1', 'OPNG*');
                        if glentry.Findfirst() then BEGIN
                            repeat
                                glentry.CalcFields(Amount);
                                RunningTotal += glentry.Amount;
                            until glentry.Next() = 0;
                        end;
                    end;
                    runningtotal += temprecord.Amount;
                    temprecord."Running Balance" := RunningTotal;
                    temprecord.Modify();
                end else begin
                    RunningTotal += temprecord.Amount;
                    temprecord."Running Balance" := RunningTotal;
                    temprecord.Modify();
                end;

                customerno := temprecord."Student ID";
                billdesc := temprecord."Bill Discription";
            until temprecord.Next() = 0;
    end;

    trigger OnAfterGetRecord()
    begin

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if Confirm('Do you want to exit!', false) then begin
            rec.Reset();
            Rec.SetRange("Unique ID", 'AUDITREPORT' + UserId());
            if Rec.FindFirst() then
                Rec.DeleteAll();

        end else
            Error('');
        ;
    end;

    procedure setdatafilter(dimensionfilter: Text; daterange: date)
    begin
        globaldimensionfilter1 := dimensionfilter;
        datefilter := daterange;
    end;

}
