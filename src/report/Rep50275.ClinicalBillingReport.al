report 50275 "Clinical Billing Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Temp Record"; "Temp Record")
        {
            RequestFilterFields = "Student ID";
            trigger OnPreDataItem()
            begin
                // TempREcord.Reset();
                // TempREcord.SetRange("Unique ID", UserId());
                // TempREcord.DeleteAll();
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn('Student #', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Last Name', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('First Name', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Semester', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Status', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Campus', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Post Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Bill Code', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Bill Description', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Description', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Amount', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FA Sem 5 Start', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FA Sem 6 Start', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FA Sem 7 Start', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FA Sem 8 Start', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FA Extra Start Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                //New Line Addtion
                TempExcelBuffer.AddColumn('Intent To Pay', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Received FAFSA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('In SFP', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FA SAP Status', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FA SAP Sub Status', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Failed SAP Reason', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FA SAP Status Action', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FA SAP Outcome', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Semester Start Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Semester End Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                "Temp Record".SetCurrentKey("Student ID");
                "Temp Record".SetRange("Posting Date", StartDate, EndDate);
                "Temp Record".SetRange("Unique ID", UserId());
            end;

            trigger OnAfterGetRecord()
            var
                StudentMasterCS: Record "Student Master-CS";
                StudentSubj: record "Main Student Subject-CS";
                CourseFilter: Text;
            begin
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn("Temp Record"."Student ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn("Temp Record"."Student Last Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Temp Record"."Student First Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn("Temp Record".Semester, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Temp Record".Field2, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Temp Record"."Institute Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Temp Record"."Posting Date", false, '', false, false, false, 'MM/dd/yyyy', TempExcelBuffer."Cell Type"::Date);
                TempExcelBuffer.AddColumn("Temp Record"."Bill Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Temp Record"."Bill Discription", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Temp Record"."Transaction Description", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Temp Record".Amount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn("Temp Record".Field73, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                TempExcelBuffer.AddColumn("Temp Record".Field74, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                TempExcelBuffer.AddColumn("Temp Record"."Course End Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                TempExcelBuffer.AddColumn("Temp Record"."Course Start Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                TempExcelBuffer.AddColumn("Temp Record"."Accrual Week End", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);

                StudentMasterCS.Reset();
                StudentMasterCS.SetCurrentKey("Enrollment Order");
                StudentMasterCS.SetFilter("Course Code", CourseFilter);
                StudentMasterCS.SetRange("Original Student No.", "Temp Record"."Student ID");
                IF StudentMasterCS.FindLast() then begin
                    TempExcelBuffer.AddColumn(StudentMasterCS."Intent to Pay", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(StudentMasterCS."FAFSA Received", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                    IF StudentMasterCS."Student SFP Initiation" = 0 Then
                        TempExcelBuffer.AddColumn(FALSE, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    ELSE
                        TempExcelBuffer.AddColumn(TRUE, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


                    TempExcelBuffer.AddColumn(StudentMasterCS."FA SAP Status", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(StudentMasterCS."FA SAP Sub Status", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                    TempExcelBuffer.AddColumn(StudentMasterCS."Failed SAP Reason", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                    TempExcelBuffer.AddColumn(StudentMasterCS."FA SAP Status Action", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                    TempExcelBuffer.AddColumn(StudentMasterCS."FA SAP Outcome", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);

                    If StudentMasterCS.Semester = 'CLN5' then begin
                        TempExcelBuffer.AddColumn(StudentMasterCS."5 FA Start Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn(StudentMasterCS."5 FA End Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                    end;
                    If StudentMasterCS.Semester = 'CLN6' then begin
                        TempExcelBuffer.AddColumn(StudentMasterCS."6 FA Start Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn(StudentMasterCS."6 FA End Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                    end;
                    If StudentMasterCS.Semester = 'CLN7' then begin
                        TempExcelBuffer.AddColumn(StudentMasterCS."7 FA Start Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn(StudentMasterCS."7 FA End Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                    end;
                    If StudentMasterCS.Semester = 'CLN8' then begin
                        TempExcelBuffer.AddColumn(StudentMasterCS."8 FA Start Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn(StudentMasterCS."8 FA End Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                    end;

                end;








            end;

            trigger OnPostDataItem()
            begin
                TempExcelBuffer.CreateNewBook(ExamList);
                TempExcelBuffer.WriteSheet(ExamList, CompanyName, UserId);
                TempExcelBuffer.CloseBook();
                TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, StartDate, EndDate));
                TempExcelBuffer.OpenExcel();

                TempREcord.Reset();
                TempREcord.SetRange("Unique ID", UserId());
                TempREcord.DeleteAll();
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';

                    }
                    Field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                }
            }
        }

    }

    trigger OnPreReport()
    Begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();

        TempREcord.Reset();
        TempREcord.DeleteAll();
        CourseFilter := '';
        CourseFilter := 'AUACOM | AUA-GHT|FIU - AUA CLINICAL|FIUGLOBAL|SEMCOM|SEMCOM2|STDPROG|TRICOM';

        FeeComponentFilter := '';
        FeeComponentFilter := 'WAIV-AUA|CLN5TUITION|CLN6TUITION|CLN7TUITION|CLN8TUITION|FIUSC|XTRAWEEKS|CLN5|CLN6|CLN7|CLN8|CLN9|CLN10|SCHLSP-AUA|4001104';

        StudentLegacyLedger.Reset();
        StudentLegacyLedger.SetRange(Date, StartDate, EndDate);
        IF StudentLegacyLedger.FindSet() then begin
            repeat
                If StudentLegacyLedger."Bill Code" In ['CLN5TUITION', 'CLN6TUITION', 'CLN7TUITION', 'CLN8TUITION', 'FIUSC', 'XTRAWEEKS', 'CLN5', 'CLN6', 'CLN7', 'CLN8', 'CLN9', 'CLN10', 'SCHLSP-AUA', '4001104', 'WAIV-AUA'] then begin
                    StudentMaster.Reset();
                    StudentMaster.SetCurrentKey("Enrollment Order");
                    StudentMaster.Ascending(false);
                    StudentMaster.SetRange("Original Student No.", StudentLegacyLedger."Student Number");
                    StudentMaster.SetFilter("Course Code", CourseFilter);
                    IF StudentMaster.FindFirst() then begin
                        If StudentLegacyLedger."Bill Code" In ['CLN5TUITION', 'CLN6TUITION', 'CLN7TUITION', 'CLN8TUITION', 'FIUSC', 'XTRAWEEKS', 'CLN5', 'CLN6', 'CLN7', 'CLN8', 'CLN9', 'CLN10', '4001104', 'WAIV-AUA'] then begin
                            EntryNo := 0;
                            TempREcord.Reset();
                            If TempREcord.FindLast() then
                                EntryNo := TempREcord."Entry No" + 1
                            Else
                                EntryNo := 1;

                            TempREcord.Init();
                            TempREcord."Entry No" := EntryNo;
                            TempREcord."Student ID" := StudentLegacyLedger."Student Number";
                            TempREcord."Student First Name" := StudentMaster."First Name";
                            TempREcord."Student Last Name" := StudentMaster."Last Name";
                            TempREcord.Semester := StudentMaster.Semester;
                            TempREcord.Field2 := StudentMaster.Status;
                            TempREcord."Institute Code" := StudentMaster."Global Dimension 1 Code";
                            TempREcord."Posting Date" := StudentLegacyLedger.Date;
                            TempREcord."Bill Code" := StudentLegacyLedger."Bill Code";
                            TempREcord."Bill Discription" := StudentLegacyLedger."Bill Code Desc";
                            TempREcord."Transaction Description" := StudentLegacyLedger.Description;
                            TempREcord.Amount := StudentLegacyLedger.Amount;
                            TempREcord.Field73 := StudentMaster."5 FA Start Date";
                            TempREcord.Field74 := StudentMaster."6 FA Start Date";
                            TempREcord."Course End Date" := StudentMaster."7 FA Start Date";
                            TempREcord."Course Start Date" := StudentMaster."8 FA Start Date";
                            TempREcord."Accrual Week End" := StudentMaster."Xtra Start Date";
                            TempREcord."Unique ID" := UserId();
                            TempREcord.Insert();
                        end;
                        If (StudentLegacyLedger."Bill Code" = 'SCHLSP-AUA') and (StudentMaster.Semester In ['CLN5', 'CLN6', 'CLN7', 'CLN8', 'CLN9', 'CLN10']) then begin
                            EntryNo := 0;
                            TempREcord.Reset();
                            If TempREcord.FindLast() then
                                EntryNo := TempREcord."Entry No" + 1
                            Else
                                EntryNo := 1;

                            TempREcord.Init();
                            TempREcord."Entry No" := EntryNo;
                            TempREcord."Student ID" := StudentLegacyLedger."Student Number";
                            TempREcord."Student First Name" := StudentMaster."First Name";
                            TempREcord."Student Last Name" := StudentMaster."Last Name";
                            TempREcord.Semester := StudentMaster.Semester;
                            TempREcord.Field2 := StudentMaster.Status;
                            TempREcord."Institute Code" := StudentMaster."Global Dimension 1 Code";
                            TempREcord."Posting Date" := StudentLegacyLedger.Date;
                            TempREcord."Bill Code" := StudentLegacyLedger."Bill Code";
                            TempREcord."Bill Discription" := StudentLegacyLedger."Bill Code Desc";
                            TempREcord."Transaction Description" := StudentLegacyLedger.Description;
                            TempREcord.Amount := StudentLegacyLedger.Amount;
                            TempREcord.Field73 := StudentMaster."5 FA Start Date";
                            TempREcord.Field74 := StudentMaster."6 FA Start Date";
                            TempREcord."Course End Date" := StudentMaster."7 FA Start Date";
                            TempREcord."Course Start Date" := StudentMaster."8 FA Start Date";
                            TempREcord."Accrual Week End" := StudentMaster."Xtra Start Date";
                            TempREcord."Unique ID" := UserId();
                            TempREcord.Insert();
                        end;
                    end;
                end;


            until StudentLegacyLedger.Next() = 0;
        end;

        GLEntry.Reset();
        GLEntry.SetFilter("Fee Code", FeeComponentFilter);
        GLEntry.SetRange("Posting Date", StartDate, EndDate);
        GLEntry.SetRange(Reversed, false);
        GLEntry.SetFilter("Student No.", '<>%1', '');
        IF GLEntry.FindSet() then begin
            repeat
                GLEntry.CalcFields("Student No.");
                CustomerRec.Reset();
                CustomerRec.SetRange("No.", GLEntry."Student No.");
                IF CustomerRec.FindFirst() then begin
                    CustomerPostingSetup.Reset();
                    CustomerPostingSetup.SetRange(Code, CustomerRec."Customer Posting Group");
                    CustomerPostingSetup.Setfilter("Receivables Account", '<>%1', GLEntry."G/L Account No.");
                    IF CustomerPostingSetup.FindFirst() then begin


                        StudentMaster.Reset();
                        StudentMaster.SetCurrentKey("Enrollment Order");
                        StudentMaster.Ascending(false);
                        StudentMaster.SetRange("Original Student No.", CustomerRec."No.");
                        StudentMaster.SetFilter("Course Code", CourseFilter);
                        IF StudentMaster.FindFirst() then begin
                            If (GLEntry."Fee Code" = 'SCHLSP-AUA') and (StudentMaster.Semester In ['CLN5', 'CLN6', 'CLN7', 'CLN8', 'CLN9', 'CLN10']) then begin

                                EntryNo := 0;
                                TempREcord.Reset();
                                If TempREcord.FindLast() then
                                    EntryNo := TempREcord."Entry No" + 1
                                Else
                                    EntryNo := 1;


                                TempREcord.Init();
                                TempREcord."Entry No" := EntryNo;
                                TempREcord."Student ID" := GLEntry."Student No.";
                                TempREcord."Student First Name" := StudentMaster."First Name";
                                TempREcord."Student Last Name" := StudentMaster."Last Name";
                                TempREcord.Semester := StudentMaster.Semester;
                                TempREcord.Field2 := StudentMaster.Status;
                                TempREcord."Institute Code" := StudentMaster."Global Dimension 1 Code";
                                TempREcord."Posting Date" := GLEntry."Posting Date";
                                TempREcord."Bill Code" := GLEntry."Fee Code";
                                TempREcord."Bill Discription" := GLEntry."Fee Description";
                                TempREcord."Transaction Description" := GLEntry.Description;
                                TempREcord.Amount := -1 * GLEntry.Amount;
                                TempREcord.Field73 := StudentMaster."5 FA Start Date";
                                TempREcord.Field74 := StudentMaster."6 FA Start Date";
                                TempREcord."Course End Date" := StudentMaster."7 FA Start Date";
                                TempREcord."Course Start Date" := StudentMaster."8 FA Start Date";
                                TempREcord."Accrual Week End" := StudentMaster."Xtra Start Date";
                                TempREcord."Unique ID" := UserId();
                                TempREcord.Insert();
                            end;
                            If GLEntry."Fee Code" In ['CLN5TUITION', 'CLN6TUITION', 'CLN7TUITION', 'CLN8TUITION', 'FIUSC', 'XTRAWEEKS', 'CLN5', 'CLN6', 'CLN7', 'CLN8', 'CLN9', 'CLN10', 'WAIV-AUA'] then begin
                                EntryNo := 0;
                                TempREcord.Reset();
                                If TempREcord.FindLast() then
                                    EntryNo := TempREcord."Entry No" + 1
                                Else
                                    EntryNo := 1;


                                TempREcord.Init();
                                TempREcord."Entry No" := EntryNo;
                                TempREcord."Student ID" := GLEntry."Student No.";
                                TempREcord."Student First Name" := StudentMaster."First Name";
                                TempREcord."Student Last Name" := StudentMaster."Last Name";
                                TempREcord.Semester := StudentMaster.Semester;
                                TempREcord.Field2 := StudentMaster.Status;
                                TempREcord."Bill Code" := GLEntry."Fee Code";
                                TempREcord."Bill Discription" := GLEntry."Fee Description";
                                TempREcord."Institute Code" := StudentMaster."Global Dimension 1 Code";
                                TempREcord."Posting Date" := GLEntry."Posting Date";
                                TempREcord."Transaction Description" := GLEntry.Description;
                                TempREcord.Amount := -1 * GLEntry.Amount;
                                TempREcord.Field73 := StudentMaster."5 FA Start Date";
                                TempREcord.Field74 := StudentMaster."6 FA Start Date";
                                TempREcord."Course End Date" := StudentMaster."7 FA Start Date";
                                TempREcord."Course Start Date" := StudentMaster."8 FA Start Date";
                                TempREcord."Accrual Week End" := StudentMaster."Xtra Start Date";
                                TempREcord."Unique ID" := UserId();
                                TempREcord.Insert();
                            end;
                        end;
                    end;
                End;
            until GLEntry.Next() = 0;
        end;
    End;

    var
        FeeComponentMaster: Record "Fee Component Master-CS";
        StudentLegacyLedger: Record "Student Legacy Ledger";
        CustomerRec: Record Customer;
        GLEntry: Record "G/L Entry";
        StudentMaster: Record "Student Master-CS";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        TempREcord: Record "Temp Record";
        CustomerPostingSetup: Record "Customer Posting Group";
        ExamList: Label 'Clinical Billing';
        ExcelFileName: Label 'Clinical Billing %1 - %2';
        EntryNo: Integer;

        StartDate: Date;
        EndDate: Date;
        FeeComponentFilter: Text;
        CourseFilter: Text;

}