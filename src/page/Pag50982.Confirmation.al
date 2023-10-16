page 50982 Confirmation
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Lists;
    //SourceTable = USMLE;
    // SourceTableView = 
    layout
    {
        area(Content)
        {
            field("Step Number"; StepNumber)
            {
                OptionCaption = '1,CK,CS';
                ApplicationArea = All;

            }
            field("Attempt Number"; AttemptNumber)
            {
                OptionCaption = ' ,1,2,3,4,5,6,7';
                ApplicationArea = All;

            }
            field(ExtensionNumber; ExtensionNumber)
            {
                ApplicationArea = All;
                OptionCaption = '0,1,2,3,4,5';
            }
            field(Year; Year)
            {
                Editable = True;
                Caption = 'Start Year';
                ApplicationArea = All;
            }

            field(StartMonth; StartMonth)
            {
                OptionCaption = ' ,Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
                ApplicationArea = All;
                trigger OnValidate()
                var
                begin
                    StartMonthInt := 0;
                    IF StartMonth = StartMonth::Jan then
                        StartMonthInt := 1;
                    IF StartMonth = StartMonth::Feb then
                        StartMonthInt := 2;
                    IF StartMonth = StartMonth::Mar then
                        StartMonthInt := 3;
                    If StartMonth = StartMonth::Apr then
                        StartMonthInt := 4;
                    IF StartMonth = StartMonth::May then
                        StartMonthInt := 5;
                    If StartMonth = StartMonth::Jun then
                        StartMonthInt := 6;
                    If StartMonth = StartMonth::Jul then
                        StartMonthInt := 7;
                    IF StartMonth = StartMonth::Aug then
                        StartMonthInt := 8;
                    IF StartMonth = StartMonth::Sep then
                        StartMonthInt := 9;
                    If StartMonth = StartMonth::Oct then
                        StartMonthInt := 10;
                    If StartMonth = StartMonth::Nov then
                        StartMonthInt := 11;
                    IF StartMonth = StartMonth::Dec then
                        StartMonthInt := 12;
                end;
            }
            field(EndMonth; EndMonth)
            {
                OptionCaption = ' ,Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
                ApplicationArea = All;
                trigger OnValidate()
                var
                begin
                    EndMonthInt := 0;
                    IF EndMonth = EndMonth::Jan then
                        EndMonthInt := 1;
                    IF EndMonth = EndMonth::Feb then
                        EndMonthInt := 2;
                    IF EndMonth = EndMonth::Mar then
                        EndMonthInt := 3;
                    If EndMonth = EndMonth::Apr then
                        EndMonthInt := 4;
                    IF EndMonth = EndMonth::May then
                        EndMonthInt := 5;
                    If EndMonth = EndMonth::Jun then
                        EndMonthInt := 6;
                    If EndMonth = EndMonth::Jul then
                        EndMonthInt := 7;
                    IF EndMonth = EndMonth::Aug then
                        EndMonthInt := 8;
                    IF EndMonth = EndMonth::Sep then
                        EndMonthInt := 9;
                    If EndMonth = EndMonth::Oct then
                        EndMonthInt := 10;
                    If EndMonth = EndMonth::Nov then
                        EndMonthInt := 11;
                    IF EndMonth = EndMonth::Dec then
                        EndMonthInt := 12;

                    IF StartMonthInt <= EndMonthInt then
                        EndYear := Year
                    Else
                        EndYear := Year + 1;
                    WindowRange := Format(StartMonth) + ' ' + Format(Year) + ' Thru ' + Format(EndMonth) + ' ' + Format(EndYear);
                end;
            }

            Field(EndYear; EndYear)
            {
                Caption = 'End Year';
                ApplicationArea = All;
                Editable = false;
            }

            field(WindowRange; WindowRange)
            {
                Editable = false;
                Caption = 'Window Range';
                ApplicationArea = All;
            }

        }

    }
    var
        StepNumber: Option "1",CK,CS;
        AttemptNumber: Option " ","1","2","3","4","5","6","7";
        ExtensionNumber: Option "0","1","2","3","4","5";
        USMLEWindowStart: Date;
        USMLEWindowEnd: Date;
        StudentID: Code[20];
        EntryNo: Integer;
        WindowRange: Text;
        Year: Integer;
        StartMonth: Option " ",Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec;
        EndMonth: Option " ",Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec;
        EndYear: Integer;
        StartMonthInt: Integer;
        EndMonthInt: Integer;

    trigger OnOpenPage()
    var
    begin
        Year := Date2DMY(WorkDate(), 3);
        EndYEar := Date2DMY(WorkDate(), 3);
    end;

    trigger OnAfterGetRecord()
    var
    begin
        //WindowRange := Format(USMLEWindowStart, 0, '<Month Text> <Day>') + ' to ' + Format(USMLEWindowEnd, 0, '<Month Text> <Day>') + ' ' + Format(Year);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        USMLERec: Record USMLE;
        StudentRec: Record "Student Master-CS";
        USMLEList: Page "USMLE List";
        EDate: Date;
    begin
        if StartMonth = StartMonth::Jan then
            USMLEWindowStart := DMY2DATE(01, 01, Year);
        if StartMonth = StartMonth::Feb then
            USMLEWindowStart := DMY2DATE(01, 02, Year);
        if StartMonth = StartMonth::Mar then
            USMLEWindowStart := DMY2DATE(01, 03, Year);
        if StartMonth = StartMonth::Apr then
            USMLEWindowStart := DMY2DATE(01, 04, Year);
        if StartMonth = StartMonth::May then
            USMLEWindowStart := DMY2DATE(01, 05, Year);
        if StartMonth = StartMonth::Jun then
            USMLEWindowStart := DMY2DATE(01, 06, Year);
        if StartMonth = StartMonth::Jul then
            USMLEWindowStart := DMY2DATE(01, 07, Year);
        if StartMonth = StartMonth::Aug then
            USMLEWindowStart := DMY2DATE(01, 08, Year);
        if StartMonth = StartMonth::Sep then
            USMLEWindowStart := DMY2DATE(01, 09, Year);
        if StartMonth = StartMonth::Oct then
            USMLEWindowStart := DMY2DATE(01, 10, Year);
        if StartMonth = StartMonth::Nov then
            USMLEWindowStart := DMY2DATE(01, 11, Year);
        if StartMonth = StartMonth::Dec then
            USMLEWindowStart := DMY2DATE(01, 12, Year);


        if EndMonth = EndMonth::Jan then begin
            EDate := DMY2DATE(01, 01, EndYear);
            USMLEWindowEnd := CALCDATE('CM', EDate);
        end;
        if EndMonth = EndMonth::Feb then begin
            EDate := DMY2DATE(01, 02, EndYear);
            USMLEWindowEnd := CALCDATE('CM', EDate);
        End;
        if EndMonth = EndMonth::Mar then begin
            EDate := DMY2DATE(01, 03, EndYear);
            USMLEWindowEnd := CALCDATE('CM', EDate);
        end;
        if EndMonth = EndMonth::Apr then begin
            EDate := DMY2DATE(01, 04, EndYear);
            USMLEWindowEnd := CALCDATE('CM', EDate);
        end;
        if EndMonth = EndMonth::May then begin
            EDate := DMY2DATE(01, 05, EndYear);
            USMLEWindowEnd := CALCDATE('CM', EDate);
        End;
        if EndMonth = EndMonth::Jun then begin
            EDate := DMY2DATE(01, 06, EndYear);
            USMLEWindowEnd := CALCDATE('CM', EDate);
        End;
        if EndMonth = EndMonth::Jul then begin
            EDate := DMY2DATE(01, 07, EndYear);
            USMLEWindowEnd := CALCDATE('CM', EDate);
        end;
        if EndMonth = EndMonth::Aug then begin
            EDate := DMY2DATE(01, 08, EndYear);
            USMLEWindowEnd := CALCDATE('CM', EDate);
        end;
        if EndMonth = EndMonth::Sep then begin
            EDate := DMY2DATE(01, 09, EndYear);
            USMLEWindowEnd := CALCDATE('CM', EDate);
        end;
        if EndMonth = EndMonth::Oct then begin
            EDate := DMY2DATE(01, 10, EndYear);
            USMLEWindowEnd := CALCDATE('CM', EDate);
        end;
        if EndMonth = EndMonth::Nov then begin
            EDate := DMY2DATE(01, 11, EndYear);
            USMLEWindowEnd := CALCDATE('CM', EDate);
        end;
        if EndMonth = EndMonth::Dec then begin
            EDate := DMY2DATE(01, 12, EndYear);
            USMLEWindowEnd := CALCDATE('CM', EDate);
        End;
        // SDate := DMY2DATE(01,03,2021);
        // EDate := DMY2DATE(01, 05, 2021);


        //condition
        if CloseAction = Action::OK then begin
            if (USMLEWindowStart = 0D) then
                Error('Please fill the USMLE Window Start Date');
            if (USMLEWindowEnd = 0D) then
                Error('Please fill the USMLE Window End Date');
            if AttemptNumber = AttemptNumber::" " then
                Error('Please fill the Attempt Number');
            USMLERec.Reset();
            if USMLERec.FindLast() then
                EntryNo := USMLERec."Entry No.";

            EntryNo := EntryNo + 1;

            USMLERec.Init();
            USMLERec."Entry No." := EntryNo;
            USMLERec."Student ID" := StudentID;
            USMLERec."Step Att. Ext." := Format(StepNumber) + ' - ' + Format(AttemptNumber) + ' - ' + Format(ExtensionNumber);
            USMLERec.USMLEStepNumber := Format(StepNumber);
            USMLERec.USMLEAttempt := Format(AttemptNumber);
            USMLERec.USMLEExtention := Format(ExtensionNumber);
            USMLERec.USMLETestWindow := WindowRange;
            USMLERec.USMLEWindowStartDate := USMLEWindowStart;
            USMLERec.USMLEWindowEndDate := USMLEWindowEnd;
            USMLERec."Creation Date" := Today;
            StudentRec.Reset();
            StudentRec.SetRange("No.", StudentID); //"Original Student No."
            if StudentRec.FindFirst() then begin
                USMLERec.UsmleID := StudentRec.UsmleID;
                USMLERec."Transcript Recrd" := StudentRec.UsmleTranscriptRcvdDate;
                USMLERec."USMLE Ref Code" := StudentRec.UsmleRefCode;
                USMLERec."Certification Date" := StudentRec.UsmleCertDate;
                USMLERec."USMLE Ref Code" := StudentRec.UsmleRefCode;
                USMLERec."USMLE Consent Release Date" := StudentRec.StudentUSMLEConsentRelease;
                USMLERec.AAMICD := StudentRec.AamcID;
            end;
            USMLERec.Insert();

            USMLERec.Reset();
            USMLERec.SetRange("Student ID", StudentID);
            // USMLERec.SetRange(USMLEAttempt, Format(AttemptNumber));
            USMLERec.SetRange(USMLEStepNumber, Format(StepNumber));
            // USMLERec.SetRange(USMLEExtention, Format(ExtensionNumber));
            USMLERec.SetFilter("Entry No.", '<%1', EntryNo);
            USMLERec.SetRange(Block, false);
            if USMLERec.FindFirst() then
                repeat
                    USMLERec.Block := true;
                    USMLERec.Modify();
                until USMLERec.Next() = 0;

            StudentRec.Reset();
            StudentRec.SetRange("No.", StudentID);//"Original Student No."
            if StudentRec.FindFirst() then begin
                if StepNumber = StepNumber::"1" then
                    StudentRec."Step I Test Window" := format(StepNumber);
                if StepNumber = StepNumber::CS then
                    StudentRec."Step II (CK) Test Window" := Format(StepNumber);
                if StepNumber = StepNumber::CS then
                    StudentRec."Step II (CS) Test Window" := Format(StepNumber);
                StudentRec.Modify();
            end;
        end;
        USMLEList.Update(false);

    end;

    procedure SetVariable(LStudentID: Code[20])
    var
    begin
        StudentID := LStudentID;
    end;
}