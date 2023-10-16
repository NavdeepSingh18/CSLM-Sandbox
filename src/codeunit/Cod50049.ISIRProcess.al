codeunit 50049 "ISIR Process"
{
    trigger OnRun()
    begin
        //UploadISIRFile();
        UploadSalesForceFile();
        //UploadSalesForceFileNew();
        RemoveDuplicate();
        MatchResult();
    end;

    var
        ExcelBuffer: Record "Excel Buffer";
        ExcelBuf1: Record "Excel Buffer";
        ISIRRec: Record "ISIR File";
        ISIRRec1: Record "ISIR File";
        SalesForceRec: Record "SalesForce File";
        SalesForceRec1: Record "SalesForce File";
        SalesForceRec2: Record "SalesForce File";
        SalesForceRec3: Record "SalesForce File";
        StudentMasterRec: Record "Student Master-CS";
        AccountName: Text[100];
        Starting3D1: Text;
        Last4D1: Text;
        Middle56D1: Text;
        FinalValue: Text;
        BoolColor: Text;

        Path: Text[250];
        DataFileName: Text[250];
        XMLFileName: Text[250];
        TableName: Text[250];
        NewPath: Text[250];
        TotalColumns: Integer;
        TotalRows: Integer;
        X: Integer;

    procedure UploadISIRFile()
    Var
        ISIRRec: Record "ISIR File";
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
        EntryNo: integer;

    begin
        Path := 'F:\AUASharedFolder\ISIRFiles';
        NewPath := 'F:\AUASharedFolder\ISIRFiles\CompletedISIRFiles';
        DataFileName := 'isrf21op.dat';
        XMLFileName := 'ISIR_Import.xml';
        TableName := 'ISIR File';

        ISIRRec.Reset();
        if ISIRRec.FindSet() then
            ISIRRec.DeleteAll();

        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/ISIRFileImport?Path=%1&DataFileName=%2&XMLFileName=%3&TableName=%4', Path, DataFileName, XMLFileName, TableName);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            EntryNo := 0;
            ISIRRec.Reset();
            IF ISIRRec.FindLast() then
                EntryNo := ISIRRec."Entry No." + 1;

            ISIRRec.Reset();
            ISIRRec.SetRange("Entry No.", EntryNo);
            ISIRRec.Deleteall();

            SaveApiLogDetails('ISIR File', ResponseText, 'ISIRFileImport');

            // File.Copy(Path + '\' + DataFileName, NewPath + '\' + DataFileName);
            // File.Erase(Path + '\' + DataFileName);
        end;
    end;

    procedure SaveApiLogDetails(TableName: Text; APIResponse: Text; Remarks: Text)
    var
        PortalApiLog: Record "Portal APIs Error Log";
    begin
        IF Not (Strpos(APIResponse, 'ok</string>') > 0) then begin
            PortalApiLog.Init();
            PortalApiLog."Table Name" := TableName;
            PortalApiLog."API Responses" := APIResponse;
            PortalApiLog.Remarks := Remarks;
            PortalApiLog."Modified On" := CurrentDateTime();
            PortalApiLog."Modified By" := UserId();
            PortalApiLog.Insert();
        end;
    end;

    procedure UploadSalesForceFile()
    var
        // FileMgt: Codeunit "File Management";
        SheetName: Text;
        FileName: Text;
        NewFileName: Text;
    Begin
        Path := '\\10.2.109.7\AUASharedFolder\ISIRFiles';
        NewPath := '\\10.2.109.7\AUASharedFolder\ISIRFiles\CompletedISIRFiles';
        DataFileName := 'Accepted Students.xlsx';
        XMLFileName := 'ISIR_Import.xml';
        TableName := 'ISIR File';
        NewFileName := 'Accepted Students';

        ExcelBuffer.Reset();
        ExcelBuffer.DeleteAll();

        FileName := '';
        FileName := Path + '\' + DataFileName;

        // IF FILE.Exists(FileName) then begin
        //     SheetName := '';
        //     SheetName := ExcelBuffer.SelectSheetsName(FileName);

        //     ExcelBuffer.LOCKTABLE();
        //     ExcelBuffer.OpenBook(FileName, SheetName);
        //     ExcelBuffer.ReadSheet();
        //     GetLastRowandColumn();

        //     FOR X := 2 TO TotalRows DO
        //         InsertData(X);

        //     ExcelBuffer.DELETEALL();

        //     NewFileName := NewFileName + Format(CurrentDateTime);
        //     NewFileName := ReplaceString(NewFileName, '/', '-');
        //     NewFileName := ReplaceString2(NewFileName, ':', '-');
        //     NewFileName := NewFileName + '.xlsx';


        //     File.Copy(Path + '\' + DataFileName, NewPath + '\' + NewFileName);
        //     File.Erase(Path + '\' + DataFileName);
        // end;



    end;

    Procedure GetValueFn(_Value: Text): Text
    begin
        IF _Value = '' then
            exit('0');
        IF _Value = '-' then
            exit('0');
        IF not (_Value In ['', '-']) then
            exit(_Value);
    end;

    procedure GetLastRowandColumn()
    Begin

        ExcelBuffer.SETRANGE("Row No.", 1);
        TotalColumns := ExcelBuffer.COUNT;

        ExcelBuffer.RESET();
        IF ExcelBuffer.FINDLAST() THEN
            TotalRows := ExcelBuffer."Row No.";
    End;

    procedure InsertData(RowNo: Integer)
    var
        SalesForceRec: Record "SalesForce File";
    begin
        If (GetValueAtCell(RowNo, 38) <> '') And (GetValueAtCell(RowNo, 38) <> '0') then begin
            SalesForceRec.Reset();
            SalesForceRec.SetRange("18 Digit ID", GetValueAtCell(RowNo, 38));
            IF not SalesForceRec.FindFirst() then begin
                SalesForceRec.Init();
                SalesForceRec."Global Dimension 1 Code" := GetValueAtCell(RowNo, 1);
                SalesForceRec."Anticipated Term" := GetValueAtCell(RowNo, 2);
                SalesForceRec."Account Name" := GetValueAtCell(RowNo, 3);
                SalesForceRec."First Name" := GetValueAtCell(RowNo, 4);
                SalesForceRec."Last Name" := GetValueAtCell(RowNo, 5);
                //SalesForceRec."Date of Birth" := ConverttoDate(GetValueAtCell(RowNo, 6));
                SalesForceRec.Street := GetValueAtCell(RowNo, 7);
                SalesForceRec.State := GetValueAtCell(RowNo, 8);
                SalesForceRec.Postcode := GetValueAtCell(RowNo, 9);
                SalesForceRec."Country Code" := GetValueAtCell(RowNo, 10);
                SalesForceRec.City := GetValueAtCell(RowNo, 11);
                SalesForceRec."Semester Type" := GetValueAtCell(RowNo, 12);
                SalesForceRec."Application ID" := GetValueAtCell(RowNo, 13);
                SalesForceRec."Student No." := GetValueAtCell(RowNo, 14);
                SalesForceRec."Decision Date" := GetValueAtCell(RowNo, 15);
                SalesForceRec.Stage := GetValueAtCell(RowNo, 16);
                SalesForceRec."Special Program" := GetValueAtCell(RowNo, 17);
                SalesForceRec."Application Type" := GetValueAtCell(RowNo, 18);
                SalesForceRec."Application Sub-type" := GetValueAtCell(RowNo, 19);
                SalesForceRec."VP Appreciation Letter" := GetValueAtCell(RowNo, 20);
                Evaluate(SalesForceRec."Undergraduate GPA", GetValueAtCell(RowNo, 21));
                Evaluate(SalesForceRec."Pre-Req GPA", GetValueAtCell(RowNo, 22));
                Evaluate(SalesForceRec."Graduate GPA", GetValueAtCell(RowNo, 23));
                Evaluate(SalesForceRec."High School GPA", GetValueAtCell(RowNo, 24));
                SalesForceRec."Deposit Paid Date" := GetValueAtCell(RowNo, 25);
                SalesForceRec."Last ADA Call By" := GetValueAtCell(RowNo, 26);
                SalesForceRec."Last ADA Call Date" := GetValueAtCell(RowNo, 27);
                SalesForceRec."Enrollment No." := GetValueAtCell(RowNo, 28);
                SalesForceRec."Enrollment Status" := GetValueAtCell(RowNo, 29);
                SalesForceRec."Phone No" := GetValueAtCell(RowNo, 30);
                SalesForceRec."Email Address" := GetValueAtCell(RowNo, 31);
                SalesForceRec."Admission Co-ordinator" := GetValueAtCell(RowNo, 32);
                SalesForceRec."Special Program" := GetValueAtCell(RowNo, 33);
                SalesForceRec.City := GetValueAtCell(RowNo, 34);
                SalesForceRec."Sub-Stage" := GetValueAtCell(RowNo, 35);
                SalesForceRec."Housing Waiver" := GetValueAtCell(RowNo, 36);
                SalesForceRec.Housing := GetValueAtCell(RowNo, 37);
                SalesForceRec."18 Digit ID" := GetValueAtCell(RowNo, 38);
                SalesForceRec."18 Digit IDs" := GetValueAtCell(RowNo, 38);
                SalesForceRec.Insert();
            end;
        end;
    end;

    procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    Begin
        IF ExcelBuf1.GET(RowNo, ColNo) THEN
            EXIT(ExcelBuf1."Cell Value as Text");
        EXIT('0');
    end;

    Procedure ConverttoDate(_Value: Text): Date
    var
        DayInt: Integer;
        MonthInt: Integer;
        YearInt: Integer;
        DayTxt: Text;
        MonthTxt: Text;
        YearTxt: Text;
        DateSeparator: Text;
    begin
        DayTxt := CopyStr(_Value, 1, StrPos(_Value, '/') - 1);
        _Value := DelStr(_Value, 1, StrPos(_Value, '/'));
        MonthTxt := CopyStr(_Value, 1, StrPos(_Value, '/') - 1);
        _Value := DelStr(_Value, 1, StrPos(_Value, '/'));
        YearTxt := CopyStr(_Value, 1, 4);

        If StrLen(YearTxt) = 2 then
            YearTxt := '20' + YearTxt
        Else
            Yeartxt := YearTxt;

        Evaluate(DayInt, DayTxt);
        Evaluate(MonthInt, MonthTxt);
        Evaluate(YearInt, YearTxt);

        exit(DMY2Date(DayInt, MonthInt, YearInt));

    end;

    Procedure RemoveDuplicate()
    begin
        ISIRRec.RESET();
        IF ISIRRec.FINDSET() THEN
            REPEAT
                ISIRRec1.SETRANGE("Social Security No.", ISIRRec."Social Security No.");
                ISIRRec1.FINDSET();
                IF ISIRRec1.COUNT > 1 THEN
                    ISIRRec.DELETE();
            UNTIL ISIRRec.NEXT() = 0;
        ISIRRec.MODIFYALL("Duplicate Removed", TRUE);
    end;

    procedure MatchResult()
    var
        Count1: Integer;
    begin
        ISIRRec.Reset();
        ISIRRec.SetRange("Duplicate Removed", true);
        ISIRRec.SetRange("Result Matched", false);
        //ISIRRec.SetRange("Entry No.", 4601);
        IF ISIRRec.Findset() Then
            Repeat

                AccountName := ISIRRec.StudentFirstName + ' ' + ISIRRec.StudentLastName;
                SalesForceRec.Reset();
                SalesForceRec.SetFilter("Student Name", '@' + CONVERTSTR(AccountName, '@', '?'));
                SalesForceRec.SetFilter("Email Address", '@' + CONVERTSTR(ISIRRec.StudentPersonalEmail, '@', '?'));
                IF not SalesForceRec.FindFirst() Then begin
                    SalesForceRec1.Reset();
                    SalesForceRec1.SetFilter("Email Address", '@' + CONVERTSTR(ISIRRec.StudentPersonalEmail, '@', '?'));
                    IF not SalesForceRec1.FindFirst() Then begin
                        SalesForceRec2.Reset();
                        SalesForceRec2.SetRange("Date of Birth", ISIRRec.StudentDateOfBirth);
                        SalesForceRec2.SetFilter("Email Address", '@' + CONVERTSTR(ISIRRec.StudentPersonalEmail, '@', '?'));
                        IF not SalesForceRec2.FindFirst() Then begin
                            SalesForceRec3.Reset();
                            SalesForceRec3.SetRange("Phone No", ISIRRec.StudentPermPhoneNbr);
                            IF SalesForceRec3.FindFirst() Then begin
                                UpdateFAFSAIDbySalesforce(SalesForceRec3."18 Digit IDs", ISIRRec."Social Security No.", ISIRRec."FAFSA Type", ISIRRec);
                            end else begin
                                StudentMasterRec.Reset();
                                StudentMasterRec.SetFilter("Student Name", '@' + CONVERTSTR(AccountName, '@', '?'));
                                StudentMasterRec.SetFilter("E-Mail Address", '@' + CONVERTSTR(ISIRRec.StudentPersonalEmail, '@', '?'));
                                StudentMasterRec.SetFilter("Type of FA Roster", '<>%1', StudentMasterRec."Type of FA Roster"::SFP);
                                StudentMasterRec.SetFilter("Global Dimension 1 Code", '%1', '9000');
                                if StudentMasterRec.FindSet() then begin
                                    repeat
                                        if Count1 <> 1 then
                                            UpdateFAFSAIDbyStudent(StudentMasterRec."No.", ISIRRec, Count1);
                                    until StudentMasterRec.Next() = 0;
                                end else begin
                                    StudentMasterRec.Reset();
                                    StudentMasterRec.SetFilter("E-Mail Address", '@' + CONVERTSTR(ISIRRec.StudentPersonalEmail, '@', '?'));
                                    StudentMasterRec.SetFilter("Type of FA Roster", '<>%1', StudentMasterRec."Type of FA Roster"::SFP);
                                    StudentMasterRec.SetFilter("Global Dimension 1 Code", '%1', '9000');
                                    if StudentMasterRec.FindSet() then begin
                                        repeat
                                            if Count1 <> 1 then
                                                UpdateFAFSAIDbyStudent(StudentMasterRec."No.", ISIRRec, Count1);
                                        until StudentMasterRec.Next() = 0;
                                    end else begin
                                        StudentMasterRec.Reset();
                                        StudentMasterRec.SetRange("Date of Birth", ISIRRec.StudentDateOfBirth);
                                        StudentMasterRec.SetFilter("E-Mail Address", '@' + CONVERTSTR(ISIRRec.StudentPersonalEmail, '@', '?'));
                                        StudentMasterRec.SetFilter("Type of FA Roster", '<>%1', StudentMasterRec."Type of FA Roster"::SFP);
                                        StudentMasterRec.SetFilter("Global Dimension 1 Code", '%1', '9000');
                                        if StudentMasterRec.FindSet() then begin
                                            repeat
                                                if Count1 <> 1 then
                                                    UpdateFAFSAIDbyStudent(StudentMasterRec."No.", ISIRRec, Count1);
                                            until StudentMasterRec.Next() = 0;
                                        end else begin
                                            StudentMasterRec.Reset();
                                            StudentMasterRec.SetRange("Phone Number", ISIRRec.StudentPermPhoneNbr);
                                            StudentMasterRec.SetFilter("Type of FA Roster", '<>%1', StudentMasterRec."Type of FA Roster"::SFP);
                                            StudentMasterRec.SetFilter("Global Dimension 1 Code", '%1', '9000');
                                            if StudentMasterRec.FindSet() then begin
                                                repeat
                                                    if Count1 <> 1 then
                                                        UpdateFAFSAIDbyStudent(StudentMasterRec."No.", ISIRRec, Count1);
                                                until StudentMasterRec.Next() = 0;
                                            end;
                                        end;
                                    end;
                                end;
                            end;

                        End Else Begin
                            UpdateFAFSAIDbySalesforce(SalesForceRec2."18 Digit IDs", ISIRRec."Social Security No.", ISIRRec."FAFSA Type", ISIRRec);
                        end;
                    End Else Begin
                        UpdateFAFSAIDbySalesforce(SalesForceRec1."18 Digit IDs", ISIRRec."Social Security No.", ISIRRec."FAFSA Type", ISIRRec);
                    end;
                End Else Begin
                    UpdateFAFSAIDbySalesforce(SalesForceRec."18 Digit IDs", ISIRRec."Social Security No.", ISIRRec."FAFSA Type", ISIRRec);
                end;
            Until ISIRRec.Next() = 0;
    end;

    procedure UpdateFAFSAIDbySalesforce(DigitID18: Text[18]; SSNNo: Code[9]; FAFSAType: Text[36]; ISIRRec: Record "ISIR File")
    Var
        StudentStatusRec: Record "Student Status";
        SemesterRec: Record "Semester Master-CS";
        StudentMaster_lREc: Record "Student Master-CS";
        SalesForceFile: Record "SalesForce File";
        StudentBuffer: Record "Student Buffer";
        SLcMToSalesforceCod: Codeunit SLcMToSalesforce;
        ReturnValue: Integer;
        DayInt: Integer;
        MonthInt: Integer;
        YearInt: Integer;
    begin
        StudentMasterRec.Reset();
        StudentMasterRec.SetFilter("18 Digit ID", '@' + CONVERTSTR(DigitID18, '@', '?'));
        StudentMasterRec.Setrange("Student SFP Initiation", 0);
        if StudentMasterRec.FindFirst() then begin
            SemesterRec.Reset();
            SemesterRec.SetRange(Code, StudentMasterRec.Semester);
            IF SemesterRec.FindFirst() then
                if SemesterRec.Sequence >= 1 then
                    if StudentStatusRec.Get(StudentMasterRec.Status, StudentMasterRec."Global Dimension 1 Code") then
                        if not (StudentStatusRec.Status in [StudentStatusRec.Status::Graduated, StudentStatusRec.Status::"Pending Graduation",
                        StudentStatusRec.Status::ADWD, StudentStatusRec.Status::Withdrawn, StudentStatusRec.Status::Dismissed,
                        StudentStatusRec.Status::Deceased]) then
                            if StudentStatusRec.Status <> StudentStatusRec.Status::" " then begin
                                Starting3D1 := COPYSTR(SSNNo, 1, 3);
                                Middle56D1 := COPYSTR(SSNNo, 4, 2);
                                Last4D1 := COPYSTR(SSNNo, 6, 4);
                                FinalValue := Starting3D1 + '-' + Middle56D1 + '-' + Last4D1;
                                ReturnValue := 1;
                                ReturnValue := CheckSSNNo(FinalValue, StudentMasterRec."Original Student No.");
                                // StudentMaster_lREc.Reset();
                                // StudentMaster_lREc.SetRange("FSA ID", FinalValue);
                                // StudentMaster_lREc.SetRange("Social Security No.", FinalValue);
                                // If Not StudentMaster_lREc.FindFirst() then begin
                                IF ReturnValue = 0 then begin
                                    SSNErrorLog(StudentMasterRec, FinalValue);
                                    //SendEmailMEATeam(StudentMasterRec."Original Student No.", FinalValue);
                                end;
                                IF ReturnValue = 1 then begin
                                    // StudentBuffer.Reset();
                                    // StudentBuffer.SetRange("Student No.", StudentMasterRec."No.");
                                    // If StudentBuffer.FindFirst() then begin
                                    StudentMasterRec."FSA ID" := FinalValue;
                                    //CSPL-00307
                                    StudentMasterRec."Social Security No." := FinalValue;
                                    DayInt := 0;
                                    MonthInt := 0;
                                    YearInt := 0;
                                    IF ISIRRec.StudentDateOfBirth <> 0D then begin
                                        DayInt := Date2DMY(ISIRRec.StudentDateOfBirth, 1);
                                        MonthInt := Date2DMY(ISIRRec.StudentDateOfBirth, 2);
                                        YearInt := Date2DMY(ISIRRec.StudentDateOfBirth, 3);
                                        StudentMasterRec.Validate("Date of Birth", DMY2Date(DayInt, MonthInt, YearInt));
                                    end;
                                    //CSPL-00307
                                    StudentMasterRec."FAFSA Type" := ISIRRec."FAFSA Type";
                                    StudentMasterRec."FAFSA Received" := true;
                                    StudentMasterRec."FAFSA Applied" := true;
                                    StudentMasterRec."Student SFP Initiation" := 1;
                                    StudentMasterRec."SAFI Sync" := StudentMasterRec."SAFI Sync"::Pending;
                                    //EmailTrigger(StudentMasterRec);
                                    StudentMaster_lRec."ISIR E-mail Sent" := true;
                                    StudentMasterRec.Modify();

                                    ISIRRec."Student No." := StudentMasterRec."No.";
                                    ISIRRec."FAFSA ID" := FinalValue;
                                    ISIRRec."Result Matched" := true;
                                    ISIRRec."Updated In SLcM" := true;
                                    ISIRRec.Modify();
                                    // end;
                                    //end;

                                    SLcMToSalesforceCod.StudentMasterSFModify(StudentMasterRec);
                                end;
                            end;

        end;
    end;

    procedure UpdateFAFSAIDbyStudent(No: Code[20]; ISIRRec: Record "ISIR File"; var Count1: Integer)
    Var
        StudentStatusRec: Record "Student Status";
        SemesterRec: Record "Semester Master-CS";
        StudentMaster_lRec: Record "Student Master-CS";
        SalesForceFile: Record "SalesForce File";
        StudentBuffer: Record "Student Buffer";
        SLcMToSalesforceCod: Codeunit SLcMToSalesforce;
        ReturnValue: Integer;
        DayInt: Integer;
        MonthInt: Integer;
        YearInt: Integer;
    begin
        StudentMasterRec.Reset();
        StudentMasterRec.Setrange("No.", No);
        StudentMasterRec.Setrange("Student SFP Initiation", 0);
        if StudentMasterRec.FindFirst() then begin
            SemesterRec.Reset();
            SemesterRec.SetRange(Code, StudentMasterRec.Semester);
            IF SemesterRec.FindFirst() then
                if SemesterRec.Sequence >= 1 then
                    if StudentStatusRec.Get(StudentMasterRec.Status, StudentMasterRec."Global Dimension 1 Code") then
                        if not (StudentStatusRec.Status in [StudentStatusRec.Status::Graduated, StudentStatusRec.Status::"Pending Graduation",
                        StudentStatusRec.Status::ADWD, StudentStatusRec.Status::Withdrawn, StudentStatusRec.Status::Dismissed,
                        StudentStatusRec.Status::Deceased]) then
                            if StudentStatusRec.Status <> StudentStatusRec.Status::" " then begin
                                Starting3D1 := COPYSTR(ISIRRec."Social Security No.", 1, 3);
                                Middle56D1 := COPYSTR(ISIRRec."Social Security No.", 4, 2);
                                Last4D1 := COPYSTR(ISIRRec."Social Security No.", 6, 4);
                                FinalValue := Starting3D1 + '-' + Middle56D1 + '-' + Last4D1;
                                ReturnValue := 1;
                                ReturnValue := CheckSSNNo(FinalValue, StudentMasterRec."Original Student No.");
                                // StudentMaster_lRec.Reset();
                                // StudentMaster_lRec.SetRange("FSA ID", FinalValue);
                                // StudentMaster_lRec.SetRange("Social Security No.", FinalValue);
                                // IF not StudentMaster_lRec.FindFirst() then begin
                                IF ReturnValue = 0 then begin
                                    SSNErrorLog(StudentMasterRec, FinalValue);
                                    //SendEmailMEATeam(StudentMasterRec."Original Student No.", FinalValue);
                                end;
                                If ReturnValue = 1 then begin
                                    // StudentBuffer.Reset();
                                    // StudentBuffer.SetRange("Student No.", StudentMasterRec."No.");
                                    // IF StudentBuffer.FindFirst() then begin
                                    StudentMasterRec."FSA ID" := FinalValue;
                                    //CSPL-00307
                                    StudentMasterRec."Social Security No." := FinalValue;
                                    DayInt := 0;
                                    MonthInt := 0;
                                    YearInt := 0;
                                    IF ISIRRec.StudentDateOfBirth <> 0D then begin
                                        DayInt := Date2DMY(ISIRRec.StudentDateOfBirth, 1);
                                        MonthInt := Date2DMY(ISIRRec.StudentDateOfBirth, 2);
                                        YearInt := Date2DMY(ISIRRec.StudentDateOfBirth, 3);
                                        StudentMasterRec.Validate("Date of Birth", DMY2Date(DayInt, MonthInt, YearInt));
                                    end;
                                    //CSPL-00307
                                    StudentMasterRec."FAFSA Type" := ISIRRec."FAFSA Type";
                                    StudentMasterRec."FAFSA Received" := true;
                                    StudentMasterRec."FAFSA Applied" := true;
                                    StudentMasterRec."Student SFP Initiation" := 1;
                                    StudentMasterRec."SAFI Sync" := StudentMasterRec."SAFI Sync"::Pending;
                                    //EmailTrigger(StudentMasterRec);
                                    StudentMaster_lRec."ISIR E-mail Sent" := true;
                                    StudentMasterRec.Modify();

                                    ISIRRec."Student No." := StudentMasterRec."No.";
                                    ISIRRec."FAFSA ID" := FinalValue;
                                    ISIRRec."Result Matched" := true;
                                    ISIRRec."Updated In SLcM" := true;
                                    ISIRRec.Modify();
                                    Count1 := 1;
                                    // end;
                                    //end;
                                    SLcMToSalesforceCod.StudentMasterSFModify(StudentMasterRec);
                                end;
                            end;
        end;
    end;

    procedure ReplaceString(String: Text; FindWhat: TExt; ReplaceWith: Text): Text
    var
    Begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        Exit(String);
    End;

    procedure ReplaceString2(String: Text; FindWhat: TExt; ReplaceWith: Text): Text
    Var
    Begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        Exit(String);
    End;


    // Procedure EmailTrigger(StudentMaster_pRec: Record "Student Master-CS")
    // Var
    //     SMTPMailSetup: Record "Email Account";
    //     PortalUSer: Record "Portal User Login-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     BodyText: Text;

    // Begin
    //     SMTPMailSetup.Reset();
    //     SMTPMailSetup.Get();
    //     Recipient := StudentMaster_pRec."Alternate Email Address";
    //     Recipients := Recipient.Split(';');
    //     SenderAddress := SmtpMailSetup."Email Address";
    //     PortalUSer.Reset();
    //     PortalUSer.SetRange(U_ID, StudentMaster_pRec."No.");
    //     If PortalUSer.FindFirst() then;
    //     SMTPMail.Create('MEA', SenderAddress, Recipients, 'AUA LOGIN CREDENTIALS', '');
    //     SMTPMail.AppendtoBody('Dear ' + StudentMaster_pRec."Student Name");
    //     SMTPMail.AppendtoBody('<br><Br>');
    //     SMTPMail.AppendtoBody('Welcome to AUA!');
    //     SMTPMail.AppendtoBody('<br><Br>');
    //     SMTPMail.AppendtoBody('Below are your credentials to login to your auamed.net (https://webmail.auamed.net) email. You will also use this login for online registration and financial aid portal.');
    //     SMTPMail.AppendtoBody('<br><br>');
    //     SMTPMail.AppendtoBody('<b>*** Please be advised, you will soon be receiving a separate email with instructions needed to log into your Financial Aid Portal. ***</b>');
    //     SMTPMail.AppendtoBody('<br><br>');
    //     SMTPMail.AppendtoBody('Username: ' + StudentMaster_pRec."E-Mail Address");
    //     SMTPMail.AppendtoBody('<br>');
    //     SMTPMail.AppendtoBody('Password: ' + PortalUSer.Password);
    //     SMTPMail.AppendtoBody('<br><br>');
    //     SMTPMail.AppendtoBody('We wish you the very best at AUA!');
    //     SMTPMail.AppendtoBody('<br>');
    //     SMTPMail.AppendtoBody('If you need assistance with login, please contact the Campus Technology Service Desk servicedesk@auamed.net');
    //     SMTPMail.AppendtoBody('<br>');
    //     SMTPMail.AppendtoBody('Thank you!');
    //     SMTPMail.AppendtoBody('<br>');
    //     SMTPMail.AppendtoBody('American University of Antigua');
    //     BodyText := SMTPMail.GetBody();
    //     SMTPmail.send();
    //     Subject := 'AUA LOGIN CREDENTIALS';


    //     //FOR NOTIFICATION +
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('ISIR Process Email Alert', 'MEA', SenderAddress, StudentMaster_pRec."Student Name",
    //     Format(StudentMaster_pRec."No."), Subject, BodyText, 'ISIR Process Email Alert', 'ISIR Process Email Alert', '', '',
    //     Recipient, 1, StudentMaster_pRec."Mobile Number", '', 1);
    //     //FOR NOTIFICATION -
    // End;

    procedure CheckSSNNo(FinalValue: Code[18]; StudentID: Code[20]): Integer
    var
        StudentMaster: Record "Student Master-CS";
    Begin
        StudentMaster.Reset();
        StudentMaster.Setfilter("Original Student No.", '<>%1', StudentID);
        StudentMaster.SetRange("FSA ID", FinalValue);
        If StudentMaster.FindFirst() then
            exit(0);

        StudentMaster.Reset();
        StudentMaster.Setfilter("Original Student No.", '<>%1', StudentID);
        StudentMaster.SetRange("Social Security No.", FinalValue);
        If StudentMaster.FindFirst() then
            exit(0);

        IF FinalValue = '' then
            exit(0);

        FinalValue := DelChr(FinalValue, '=', '-');
        IF StrLen(FinalValue) <> 9 then
            exit(0)
        Else
            Exit(1);
    End;

    // Procedure SendEmailMEATeam(StudentID: Code[20]; FinalValue: Text[18]);
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     EducationSetup: Record "Education Setup-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     BodyText: Text;
    // Begin
    //     SMTPMailSetup.Reset();
    //     SMTPMailSetup.Get();

    //     EducationSetup.Reset();
    //     EducationSetup.SetRange("Global Dimension 1 Code", '9000');
    //     If EducationSetup.FindFirst() then begin
    //         Recipient := EducationSetup."ISIR Error(Email ID)";
    //         Recipients := Recipient.Split(';');
    //         SenderAddress := SmtpMailSetup."Email Address";
    //         SMTPMail.Create('MEA', SenderAddress, Recipients, 'AUA LOGIN CREDENTIALS', '');
    //         SMTPMail.AppendtoBody('Dear User,');
    //         SMTPMail.AppendtoBody('<br><Br>');
    //         SMTPMail.AppendtoBody('Please note ISIR matching process has not found below error:');
    //         SMTPMail.AppendtoBody('<br><Br>');
    //         SMTPMail.AppendtoBody('Student ID : ' + StudentID);
    //         // SMTPMail.AppendtoBody('<br>');
    //         // SMTPMail.AppendtoBody('Social Security No. : ' + FinalValue);
    //         SMTPMail.AppendtoBody('<br>');
    //         IF FinalValue = '' then
    //             SMTPMail.AppendtoBody('Error message : SSN No. is either duplicate or blank.')
    //         Else
    //             SMTPMail.AppendtoBody('Error message : SSN No. is either duplicate or its value must be equal to 9.');
    //         SMTPMail.AppendtoBody('<br><br>');
    //         // SMTPMail.AppendtoBody('We wish you the very best at AUA!');
    //         // SMTPMail.AppendtoBody('<br>');
    //         // SMTPMail.AppendtoBody('If you need assistance with login, please contact the Campus Technology Service Desk servicedesk@auamed.net');
    //         // SMTPMail.AppendtoBody('<br>');
    //         // SMTPMail.AppendtoBody('Thank you!');
    //         // SMTPMail.AppendtoBody('<br>');
    //         // SMTPMail.AppendtoBody('American University of Antigua');
    //         SMTPmail.send();
    //     end;

    // End;

    procedure SSNErrorLog(StudentMAster_pREc: Record "Student Master-CS"; FinalValue: Text[20])
    var
        EducationSetup: Record "Education Setup-CS";
        FamilyID: Record "Family ID-CS";
        NoseriesMgmt: Codeunit NoSeriesManagement;
    Begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        IF EducationSetup.FindFirst() then;

        FamilyID.Reset();
        FamilyID.Code := NoseriesMgmt.GetNextNo(EducationSetup."Dummy Student Subject", Today, true);
        FamilyID."Student ID" := StudentMAster_pREc."Original Student No.";
        FamilyID."SLcM No." := StudentMAster_pREc."No.";
        FamilyID."SSN No." := FinalValue;
        FamilyID."Student Name" := StudentMAster_pREc."Student Name";
        FamilyID.Insert();

    End;

    // procedure UploadSalesForceFileNew()
    // var
    //     FileMgt: Codeunit "File Management";
    //     SheetName: Text;
    //     FileName: Text;
    //     NewFileName: Text;
    // Begin
    //     Path := '\\10.2.109.7\AUASharedFolder\ISIRFiles';
    //     NewPath := '\\10.2.109.7\AUASharedFolder\ISIRFiles\CompletedISIRFiles';
    //     DataFileName := 'Accepted Student.xlsx';
    //     XMLFileName := 'ISIR_Import.xml';
    //     TableName := 'ISIR File';
    //     NewFileName := 'Accepted Student';

    //     ExcelBuffer.Reset();
    //     ExcelBuffer.DeleteAll();

    //     FileName := '';
    //     FileName := Path + '\' + DataFileName;

    //     IF FILE.Exists(FileName) then begin
    //         SheetName := '';
    //         SheetName := ExcelBuffer.SelectSheetsName(FileName);

    //         ExcelBuffer.LOCKTABLE();
    //         ExcelBuffer.OpenBook(FileName, SheetName);
    //         ExcelBuffer.ReadSheet();
    //         GetLastRowandColumn();

    //         FOR X := 2 TO TotalRows DO
    //             InsertData(X);

    //         ExcelBuffer.DELETEALL();

    //         NewFileName := NewFileName + Format(CurrentDateTime);
    //         NewFileName := ReplaceString(NewFileName, '/', '-');
    //         NewFileName := ReplaceString2(NewFileName, ':', '-');
    //         NewFileName := NewFileName + '.xlsx';


    //         File.Copy(Path + '\' + DataFileName, NewPath + '\' + NewFileName);
    //         File.Erase(Path + '\' + DataFileName);
    //     end;
    // end;
}
