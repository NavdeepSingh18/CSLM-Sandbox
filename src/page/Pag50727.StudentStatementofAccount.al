page 50727 "Student Statement Request"
{
    ApplicationArea = All;
    Caption = 'Student Statement of Account';
    PageType = Document;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field("File Path"; FilePath)
            {
                ApplicationArea = All;
                Caption = 'File Path';
            }
            field("From Date"; FromDate)
            {
                ApplicationArea = All;
                Caption = 'From Date';
            }
            field("To Date"; ToDate)
            {
                ApplicationArea = All;
                Caption = 'To Date';
            }
            field("Institute Code"; InstituteCode)
            {
                ApplicationArea = All;
                Caption = 'Institude Code';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            }
            field("Housing Type"; "HousingType")
            {
                ApplicationArea = All;
                Caption = 'Housing Type';
                OptionCaption = ' ,With Housing,Only Housing';
            }
            field("Enrollment No"; EnrollmentNo)
            {
                ApplicationArea = All;
                Caption = 'Enrollment No.';
                trigger OnLookup(var Text: Text): Boolean
                begin
                    StudentMasterCS.Reset();
                    StudentMasterCS.findset();
                    IF PAGE.RUNMODAL(0, StudentMasterCS) = ACTION::LookupOK THEN
                        EnrollmentNo := StudentMasterCS."Enrollment No.";
                end;
            }
            field("Semester"; Semester1)
            {
                ApplicationArea = All;
                Caption = 'Semester';
                TableRelation = "Semester Master-CS";
            }
            field("Academic Year"; AcademicYear)
            {
                ApplicationArea = All;
                Caption = 'Academic Year';
                TableRelation = "Academic Year Master-CS";
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Go-To Student Statement of Account")
            {
                ApplicationArea = All;
                Caption = 'Go-To Student Statement of Account';
                Image = NextRecord;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    IF InstituteCode = '' THEN
                        ERROR('Institute Code must have a value.');
                    IF FromDate = 0D THEN
                        ERROR('FromDate must have a value.');
                    IF ToDate = 0D THEN
                        ERROR('ToDate must have a value.');

                    IF FilePath <> '' then begin
                        StudentMasterCS.Reset();
                        StudentMasterCS.SetCurrentKey("Enrollment No.");
                        StudentMasterCS.SetRange("Global Dimension 1 Code", InstituteCode);
                        IF EnrollmentNo <> '' THEN
                            StudentMasterCS.SetFilter("Enrollment No.", EnrollmentNo);
                        IF Semester1 <> '' THEN
                            StudentMasterCS.SetFilter(Semester, Semester1);
                        IF AcademicYear <> '' THEN
                            StudentMasterCS.SetFilter("Academic Year", AcademicYear);
                        IF StudentMasterCS.FindSet() then begin
                            CounterTotal := StudentMasterCS.COUNT();
                            Window.OPEN(Text001);
                            repeat
                                Counter := Counter + 1;
                                Window.UPDATE(1, StudentMasterCS."No.");
                                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                                Clear(StudentStatementofAccount);
                                StudentStatementofAccount.VariablePassing(FromDate, ToDate, StudentMasterCS."Global Dimension 1 Code", StudentMasterCS."Enrollment No.", '', '', HousingType);
                                //StudentStatementofAccount.SaveAsPdf('C:\StatementReport\' + StudentMasterCS."No." + '.pdf');//GMCSCOM
                                //FileManagement.DownloadToFile('C:\StatementReport\', FilePath);//GMCSCOM
                                CounterOK := CounterOK + 1;
                            until StudentMasterCS.Next() = 0;
                            Window.CLOSE();
                            MESSAGE(Text002, CounterOK, CounterTotal);
                            Message('Student Statement of Account pdf has been Generated.');
                        End;
                        CurrPage.Close();
                    end Else begin
                        StudentStatementofAccount.VariablePassing(FromDate, ToDate, InstituteCode, EnrollmentNo, Semester1, AcademicYear, HousingType);
                        StudentStatementofAccount.UseRequestPage(true);
                        StudentStatementofAccount.Run();
                        CurrPage.Close();
                    end;

                end;

            }
        }
    }
    var
        StudentMasterCS: Record "Student Master-CS";
        StudentStatementofAccount: Report "Student Statement of Account";
        FileManagement: Codeunit "File Management";
        FromDate: Date;
        ToDate: Date;
        InstituteCode: Code[20];
        EnrollmentNo: Code[2048];
        AcademicYear: Code[20];
        Semester1: Code[100];
        HousingType: Option " ","With Housing","Only Housing";
        FilePath: Text[1000];
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        CounterOK: Integer;
        Text001: Label 'Generated Pdf   #1########## @2@@@@@@@@@@@@@';
        Text002: Label '%1 out of a total of %2 have now been Generated.';

}

