report 50189 "Fall 2020 Registration"
{
    Caption = 'Fall 2020 Registration';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    ApplicationArea = All;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = sorting("No.");
            trigger OnPreDataItem()
            begin
                SetRange("Global Dimension 1 Code", InstituteCode);
                IF EnrollmentNo <> '' THEN
                    SetFilter("Enrollment No.", EnrollmentNo);
                IF Semester1 <> '' THEN
                    SetFilter(Semester, Semester1);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);
                IF StudentNo <> '' then
                    SetFilter("No.", StudentNo);

                ExcelBuffer.DELETEALL();

                //ExcelBuffer.DELETEALL(FALSE);
                // ExcelBuffer.ClearNewRow;
                // ExcelBuffer.NewRow;
                MakeExcelDataHeaderSpring2020();
                //ExcelBuffer.CreateBook('', 'Spring 2020');

            end;

            trigger OnAfterGetRecord()
            begin
                MakeExcelDataBodySpring2020("Student Master-CS");
                // ExcelBuffer.WriteSheet('', '', '');
            end;

            trigger OnPostDataItem()
            begin

            end;

        }
        dataitem(Student_MasterCS1; "Student Master-CS")
        {
            DataItemTableView = sorting("No.");
            trigger OnPreDataItem()
            begin

                SetRange("Global Dimension 1 Code", InstituteCode);
                IF EnrollmentNo <> '' THEN
                    SetFilter("Enrollment No.", EnrollmentNo);
                IF Semester1 <> '' THEN
                    SetFilter(Semester, Semester1);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);
                IF StudentNo <> '' then
                    SetFilter("No.", StudentNo);

                ExcelBuffer.DELETEALL();
                // ExcelBuffer.AddSheet('', 'Current Status');
                // ExcelBuffer.ClearNewRow;
                // ExcelBuffer.NewRow;
                MakeExcelDataHeaderCurrentStatus();
            end;

            trigger OnAfterGetRecord()
            begin
                MakeExcelDataBodyCurrentStatus(Student_MasterCS1);
                // ExcelBuffer.WriteSheet('', '', '');
            end;

            trigger OnPostDataItem()
            begin
            end;
        }
        dataitem(Student_MasterCS2; "Student Master-CS")
        {
            DataItemTableView = sorting("No.");
            trigger OnPreDataItem()
            begin

                SetRange("Global Dimension 1 Code", InstituteCode);
                IF EnrollmentNo <> '' THEN
                    SetFilter("Enrollment No.", EnrollmentNo);
                IF Semester1 <> '' THEN
                    SetFilter(Semester, Semester1);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);
                IF StudentNo <> '' then
                    SetFilter("No.", StudentNo);

                ExcelBuffer.DELETEALL();
                // ExcelBuffer.AddSheet('', 'Returning AUA');
                // ExcelBuffer.ClearNewRow;
                // ExcelBuffer.NewRow;
                MakeExcelDataHeaderReturningAUA();
            end;

            trigger OnAfterGetRecord()
            begin
                MakeExcelDataBodyReturningAUA(Student_MasterCS2);
                // ExcelBuffer.WriteSheet('', '', '');
            end;

            trigger OnPostDataItem()
            begin
            end;
        }
        dataitem(Student_MasterCS3; "Student Master-CS")
        {
            DataItemTableView = sorting("No.") where("Global Dimension 1 Code" = filter(9000));
            trigger OnPreDataItem()
            begin

                SetRange("Global Dimension 1 Code", InstituteCode);
                IF EnrollmentNo <> '' THEN
                    SetFilter("Enrollment No.", EnrollmentNo);
                IF Semester1 <> '' THEN
                    SetFilter(Semester, Semester1);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);
                IF StudentNo <> '' then
                    SetFilter("No.", StudentNo);

                ExcelBuffer.DELETEALL();
                // ExcelBuffer.AddSheet('', 'AUA New');
                // ExcelBuffer.ClearNewRow;
                // ExcelBuffer.NewRow;
                MakeExcelDataHeaderAUANew();
            end;

            trigger OnAfterGetRecord()
            begin
                MakeExcelDataBodyAUANew(Student_MasterCS3);
                // ExcelBuffer.WriteSheet('', '', '');
            end;

            trigger OnPostDataItem()
            begin
            end;
        }

        dataitem(Student_MasterCS4; "Student Master-CS")
        {
            DataItemTableView = sorting("No.") where("Global Dimension 1 Code" = filter(9100));
            trigger OnPreDataItem()
            begin

                SetRange("Global Dimension 1 Code", InstituteCode);
                IF EnrollmentNo <> '' THEN
                    SetFilter("Enrollment No.", EnrollmentNo);
                IF Semester1 <> '' THEN
                    SetFilter(Semester, Semester1);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);
                IF StudentNo <> '' then
                    SetFilter("No.", StudentNo);

                ExcelBuffer.DELETEALL();
                // ExcelBuffer.AddSheet('', 'AICASA New');
                // ExcelBuffer.ClearNewRow;
                // ExcelBuffer.NewRow;
                MakeExcelDataHeaderAICASANew();
            end;

            trigger OnAfterGetRecord()
            begin
                MakeExcelDataBodyAICASANew(Student_MasterCS4);
                // ExcelBuffer.WriteSheet('', '', '');
            end;

            trigger OnPostDataItem()
            begin
            end;
        }

        dataitem(Student_MasterCS5; "Student Master-CS")
        {
            DataItemTableView = sorting("No.");
            trigger OnPreDataItem()
            begin

                SetRange("Global Dimension 1 Code", InstituteCode);
                IF EnrollmentNo <> '' THEN
                    SetFilter("Enrollment No.", EnrollmentNo);
                IF Semester1 <> '' THEN
                    SetFilter(Semester, Semester1);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);
                IF StudentNo <> '' then
                    SetFilter("No.", StudentNo);

                ExcelBuffer.DELETEALL();
                // ExcelBuffer.AddSheet('', 'New Student Emails');
                // ExcelBuffer.ClearNewRow;
                // ExcelBuffer.NewRow;
                MakeExcelDataHeaderNewStudentEmails();
            end;

            trigger OnAfterGetRecord()
            begin
                MakeExcelDataBodyNewStudentEmails(Student_MasterCS5);
                // ExcelBuffer.WriteSheet('', '', '');
            end;

            trigger OnPostDataItem()
            begin
            end;
        }
        dataitem(Student_MasterCSWaived; "Student Master-CS")
        {
            DataItemTableView = sorting("No.");
            trigger OnPreDataItem()
            begin

                SetRange("Global Dimension 1 Code", InstituteCode);
                IF EnrollmentNo <> '' THEN
                    SetFilter("Enrollment No.", EnrollmentNo);
                IF Semester1 <> '' THEN
                    SetFilter(Semester, Semester1);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);
                IF StudentNo <> '' then
                    SetFilter("No.", StudentNo);

                ExcelBuffer.DELETEALL();
                // ExcelBuffer.AddSheet('', 'Waived');
                // ExcelBuffer.ClearNewRow;
                // ExcelBuffer.NewRow;
                MakeExcelDataHeaderWaived();
            end;

            trigger OnAfterGetRecord()
            begin
                MakeExcelDataBodyWaived(Student_MasterCSWaived);
                // ExcelBuffer.WriteSheet('', '', '');
            end;

            trigger OnPostDataItem()
            begin
            end;
        }

        dataitem(Student_MasterCSBursar; "Student Master-CS")
        {
            DataItemTableView = sorting("No.");
            trigger OnPreDataItem()
            begin

                SetRange("Global Dimension 1 Code", InstituteCode);
                IF EnrollmentNo <> '' THEN
                    SetFilter("Enrollment No.", EnrollmentNo);
                IF Semester1 <> '' THEN
                    SetFilter(Semester, Semester1);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);
                IF StudentNo <> '' then
                    SetFilter("No.", StudentNo);

                ExcelBuffer.DELETEALL();
                // ExcelBuffer.AddSheet('', 'Bursar');
                // ExcelBuffer.ClearNewRow;
                // ExcelBuffer.NewRow;
                MakeExcelDataHeaderBursar();
            end;

            trigger OnAfterGetRecord()
            begin
                MakeExcelDataBodyBursar(Student_MasterCSBursar);
                // ExcelBuffer.WriteSheet('', '', '');
            end;

            trigger OnPostDataItem()
            begin
            end;
        }
        dataitem(Student_MasterCSOGCI; "Student Master-CS")
        {
            DataItemTableView = sorting("No.");
            trigger OnPreDataItem()
            begin

                SetRange("Global Dimension 1 Code", InstituteCode);
                IF EnrollmentNo <> '' THEN
                    SetFilter("Enrollment No.", EnrollmentNo);
                IF Semester1 <> '' THEN
                    SetFilter(Semester, Semester1);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);
                IF StudentNo <> '' then
                    SetFilter("No.", StudentNo);

                ExcelBuffer.DELETEALL();
                // ExcelBuffer.AddSheet('', 'OGCI');
                // ExcelBuffer.ClearNewRow;
                // ExcelBuffer.NewRow;
                MakeExcelDataHeaderOGCI();
            end;

            trigger OnAfterGetRecord()
            begin
                MakeExcelDataBodyOGCI(Student_MasterCSOGCI);
                // ExcelBuffer.WriteSheet('', '', '');
            end;

            trigger OnPostDataItem()
            begin
            end;
        }
        dataitem(Student_MasterPDFDate; "Student Master-CS")
        {
            DataItemTableView = sorting("No.");
            trigger OnPreDataItem()
            begin

                SetRange("Global Dimension 1 Code", InstituteCode);
                IF EnrollmentNo <> '' THEN
                    SetFilter("Enrollment No.", EnrollmentNo);
                IF Semester1 <> '' THEN
                    SetFilter(Semester, Semester1);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);
                IF StudentNo <> '' then
                    SetFilter("No.", StudentNo);

                ExcelBuffer.DELETEALL();
                // ExcelBuffer.AddSheet('', 'PDF Date');
                // ExcelBuffer.ClearNewRow;
                // ExcelBuffer.NewRow;
                MakeExcelDataHeaderPDFDate();
            end;

            trigger OnAfterGetRecord()
            begin
                MakeExcelDataBodyPDFDate(Student_MasterPDFDate);
                // ExcelBuffer.WriteSheet('', '', '');
            end;

            trigger OnPostDataItem()
            begin
            end;
        }

        dataitem(Student_MasterOptOutBSIC; "Student Master-CS")
        {
            DataItemTableView = sorting("No.");
            trigger OnPreDataItem()
            begin

                SetRange("Global Dimension 1 Code", InstituteCode);
                IF EnrollmentNo <> '' THEN
                    SetFilter("Enrollment No.", EnrollmentNo);
                IF Semester1 <> '' THEN
                    SetFilter(Semester, Semester1);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);
                IF StudentNo <> '' then
                    SetFilter("No.", StudentNo);

                ExcelBuffer.DELETEALL();
                // ExcelBuffer.AddSheet('', 'Opt Out BSIC');
                // ExcelBuffer.ClearNewRow;
                // ExcelBuffer.NewRow;
                MakeExcelDataHeaderOptOutBSIC();
            end;

            trigger OnAfterGetRecord()
            begin
                MakeExcelDataBodyOptOutBSIC(Student_MasterOptOutBSIC);
                // ExcelBuffer.WriteSheet('', '', '');
            end;

            trigger OnPostDataItem()
            begin
            end;
        }
        dataitem(Student_MasterHousing; "Student Master-CS")
        {
            DataItemTableView = sorting("No.");
            trigger OnPreDataItem()
            begin

                SetRange("Global Dimension 1 Code", InstituteCode);
                IF EnrollmentNo <> '' THEN
                    SetFilter("Enrollment No.", EnrollmentNo);
                IF Semester1 <> '' THEN
                    SetFilter(Semester, Semester1);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);
                IF StudentNo <> '' then
                    SetFilter("No.", StudentNo);

                ExcelBuffer.DELETEALL();
                // ExcelBuffer.AddSheet('', 'Housing');
                // ExcelBuffer.ClearNewRow;
                // ExcelBuffer.NewRow;
                MakeExcelDataHeaderHousing();
            end;

            trigger OnAfterGetRecord()
            begin
                MakeExcelDataBodyHousing(Student_MasterHousing);
                // ExcelBuffer.WriteSheet('', '', '');
            end;

            trigger OnPostDataItem()
            begin
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

                    field("Institute Code"; InstituteCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Institude Code';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    }
                    field("No."; StudentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Student No.';
                        TableRelation = "Student Master-CS";
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
        }

    }

    trigger OnPreReport()
    begin
        IF InstituteCode = '' then
            Error('Institute Code must have a value');
    end;

    trigger OnPostReport()
    Begin
        // ExcelBuffer.CloseBook;
        // ExcelBuffer.OpenExcel;

    End;

    var
        ExcelBuffer: Record "Excel Buffer Test";
        StudentMasterCS: Record "Student Master-CS";

        ExportToExcel: Boolean;
        InstituteCode: Code[20];
        EnrollmentNo: Code[2048];
        AcademicYear: Code[20];
        Semester1: Code[100];
        StudentNo: Code[2048];

    procedure MakeExcelDataHeaderSpring2020()
    begin
        // ExcelBuffer.AddColumn('Student Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Last Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('First Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Campus', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('School Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Semester', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Program', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Term', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Current Semester', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Current Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('OLR Completed', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('On Isalnd', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExcelDataBodySpring2020(RecStudentMaster: Record "Student Master-CS")
    var
        RecStudentRegistration: Record "Student Registration-CS";
    begin
        RecStudentRegistration.Reset();
        RecStudentRegistration.SetRange("Student No", RecStudentMaster."No.");
        RecStudentRegistration.SetRange(Semester, RecStudentMaster.Semester);
        RecStudentRegistration.SetRange("Academic Year", RecStudentMaster."Academic Year");
        IF RecStudentRegistration.FindFirst() then;
        // ExcelBuffer.NewRow();
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster."No."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster."Last Name"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster."First Name"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster."Global Dimension 1 Code"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster.Status), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster.Semester), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster."Course Name"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster.Term), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster.Semester), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster.Status), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentRegistration."OLR Completed Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        // ExcelBuffer.AddColumn(RecStudentMaster."On Ground Check-In On", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);

    end;

    procedure MakeExcelDataHeaderCurrentStatus()
    begin

        // ExcelBuffer.AddColumn('Student Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Last Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('First Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Current Semester', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('School Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('AD Program Description', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Campus', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Email', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExcelDataBodyCurrentStatus(RecStudentMaster: Record "Student Master-CS")
    begin
        // ExcelBuffer.NewRow();
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster."No."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster."Last Name"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster."First Name"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster.Semester), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster.Status), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster."Course Name"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster."Global Dimension 1 Code"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster."E-Mail Address"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;


    procedure MakeExcelDataHeaderReturningAUA()
    begin
        // ExcelBuffer.AddColumn('Student Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Email', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Last Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('First Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Old Semester', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Old School Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Old Program', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Opted Out', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Semester', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('School Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Program', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('OLR Completed', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('On Isalnd', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('PDF Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Current Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExcelDataBodyReturningAUA(RecStudentMaster: Record "Student Master-CS")
    Var
        RecStudentRegistration: Record "Student Registration-CS";
    begin
        RecStudentRegistration.Reset();
        RecStudentRegistration.SetRange("Student No", RecStudentMaster."No.");
        RecStudentRegistration.SetRange(Semester, RecStudentMaster.Semester);
        RecStudentRegistration.SetRange("Academic Year", RecStudentMaster."Academic Year");
        IF RecStudentRegistration.FindFirst() then;
        // ExcelBuffer.NewRow();
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster."No."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster."E-Mail Address"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster."Last Name"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster."First Name"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster.Semester), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster.Status), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Course Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster.Semester), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster.Status), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Course Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentRegistration."OLR Completed Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        // ExcelBuffer.AddColumn(RecStudentMaster."On Ground Check-In On", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster.Status, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure MakeExcelDataHeaderAUANew()
    begin
        // ExcelBuffer.AddColumn('Student Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Application Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Application Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Special Program', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Email', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Campus', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('School Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Program', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Housing', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Waived', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Email Sent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Program Start', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Stage (Combined)', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('OLR Completed', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('On Island', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('PDF Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Semester', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExcelDataBodyAUANew(RecStudentMaster: Record "Student Master-CS")
    Var
        RecHousingApp: Record "Housing Application";
        RecOptOutWaived: Record "Opt Out";
        RecStudentRegistration: Record "Student Registration-CS";
        NotAssigned: Text;
        NotWaived: Text;
        OLREmailSent: Text;
    begin
        NotAssigned := '';
        NotWaived := '';
        OLREmailSent := '';
        RecHousingApp.Reset();
        RecHousingApp.SetRange("Student No.", RecStudentMaster."No.");
        RecHousingApp.SetRange(Semester, RecStudentMaster.Semester);
        RecHousingApp.SetRange("Academic Year", RecStudentMaster."Academic Year");
        RecHousingApp.SetRange(Status, RecHousingApp.Status::Approved);
        IF RecHousingApp.FindFirst() then;

        IF RecHousingApp."Approved On" <> 0D then
            NotAssigned := FORMAT(RecHousingApp."Approved On")
        else
            NotAssigned := 'Not Assigned';

        RecOptOutWaived.Reset();
        RecOptOutWaived.SetRange("Student No.", RecStudentMaster."No.");
        RecOptOutWaived.SetRange(Semester, RecStudentMaster.Semester);
        RecOptOutWaived.SetRange("Academic Year", RecStudentMaster."Academic Year");
        RecOptOutWaived.SetRange("Application Type", RecOptOutWaived."Application Type"::"Housing Wavier");
        RecOptOutWaived.SetRange(Status, RecOptOutWaived.Status::Approved);
        IF RecOptOutWaived.FindFirst() then;

        IF RecOptOutWaived."Approved/Rejected On" <> 0D then
            NotWaived := FORMAT(RecOptOutWaived."Approved/Rejected On")
        else
            NotWaived := 'Not Waived';

        RecStudentRegistration.Reset();
        RecStudentRegistration.SetRange("Student No", RecStudentMaster."No.");
        RecStudentRegistration.SetRange(Semester, RecStudentMaster.Semester);
        RecStudentRegistration.SetRange("Academic Year", RecStudentMaster."Academic Year");
        IF RecStudentRegistration.FindFirst() then;
        IF RecStudentRegistration."OLR Completed Date" <> 0D then
            OLREmailSent := FORMAT(RecStudentRegistration."OLR Completed Date")
        else
            OLREmailSent := 'Not Sent';


        // ExcelBuffer.NewRow();
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster."No."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster."Student Name"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Account Person Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster."Course Name"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster."E-Mail Address"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Global Dimension 1 Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster.Status, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Course Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(NotAssigned, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        // ExcelBuffer.AddColumn(NotWaived, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(OLREmailSent, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Course Name" + ' ' + RecStudentMaster.Semester, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentRegistration."OLR Completed Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        // ExcelBuffer.AddColumn(RecStudentMaster."On Ground Check-In On", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster.Semester, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExcelDataHeaderAICASANew()
    begin
        // ExcelBuffer.AddColumn('Student Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Application Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Application Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Special Program', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Email', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Campus', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('School Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Program', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Housing', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Waived', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Email Sent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Program Start', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Stage (Combined)', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('OLR Completed', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('On Island', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('PDF Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Semester', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExcelDataBodyAICASANew(RecStudentMaster: Record "Student Master-CS")
    var
        RecHousingApp: Record "Housing Application";
        RecOptOutWaived: Record "Opt Out";
        RecStudentRegistration: Record "Student Registration-CS";
        NotAssigned: Text;
        NotWaived: Text;
        OLREmailSent: Text;
    begin
        NotAssigned := '';
        NotWaived := '';
        OLREmailSent := '';
        RecHousingApp.Reset();
        RecHousingApp.SetRange("Student No.", RecStudentMaster."No.");
        RecHousingApp.SetRange(Semester, RecStudentMaster.Semester);
        RecHousingApp.SetRange("Academic Year", RecStudentMaster."Academic Year");
        RecHousingApp.SetRange(Status, RecHousingApp.Status::Approved);
        IF RecHousingApp.FindFirst() then;

        IF RecHousingApp."Approved On" <> 0D then
            NotAssigned := FORMAT(RecHousingApp."Approved On")
        else
            NotAssigned := 'Not Assigned';

        RecOptOutWaived.Reset();
        RecOptOutWaived.SetRange("Student No.", RecStudentMaster."No.");
        RecOptOutWaived.SetRange(Semester, RecStudentMaster.Semester);
        RecOptOutWaived.SetRange("Academic Year", RecStudentMaster."Academic Year");
        RecOptOutWaived.SetRange("Application Type", RecOptOutWaived."Application Type"::"Housing Wavier");
        RecOptOutWaived.SetRange(Status, RecOptOutWaived.Status::Approved);
        IF RecOptOutWaived.FindFirst() then;

        IF RecOptOutWaived."Approved/Rejected On" <> 0D then
            NotWaived := FORMAT(RecOptOutWaived."Approved/Rejected On")
        else
            NotWaived := 'Not Waived';

        RecStudentRegistration.Reset();
        RecStudentRegistration.SetRange("Student No", RecStudentMaster."No.");
        RecStudentRegistration.SetRange(Semester, RecStudentMaster.Semester);
        RecStudentRegistration.SetRange("Academic Year", RecStudentMaster."Academic Year");
        IF RecStudentRegistration.FindFirst() then;
        IF RecStudentRegistration."OLR Completed Date" <> 0D then
            OLREmailSent := FORMAT(RecStudentRegistration."OLR Completed Date")
        else
            OLREmailSent := 'Not Sent';
        // ExcelBuffer.NewRow();
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster."No."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster."Student Name"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Account Person Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Format(RecStudentMaster."Course Name"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster."E-Mail Address"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Global Dimension 1 Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster.Status, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Course Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(NotAssigned, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(NotWaived, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(OLREmailSent, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Course Name" + ' ' + RecStudentMaster.Semester, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentRegistration."OLR Completed Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        // ExcelBuffer.AddColumn(RecStudentMaster."On Ground Check-In On", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster.Semester, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExcelDataHeaderNewStudentEmails()
    begin
        // ExcelBuffer.AddColumn('Student Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Application Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Application Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Stage', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Last Modified Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Account: Last Modified Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Official Auamed Email', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Official Email Created Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Housing Assigned Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('OLR Criteria Met Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('OLR Email Sent Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('On Ground Check-in Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('OLR Complete Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);


    end;

    procedure MakeExcelDataBodyNewStudentEmails(RecStudentMaster: Record "Student Master-CS")
    var
        RecHousingApp: Record "Housing Application";
        RecOptOutWaived: Record "Opt Out";
        RecStudentRegistration: Record "Student Registration-CS";
        NotAssigned: Text;
        NotWaived: Text;
        OLREmailSent: Text;
    begin
        NotAssigned := '';
        NotWaived := '';
        OLREmailSent := '';
        RecHousingApp.Reset();
        RecHousingApp.SetRange("Student No.", RecStudentMaster."No.");
        RecHousingApp.SetRange(Semester, RecStudentMaster.Semester);
        RecHousingApp.SetRange("Academic Year", RecStudentMaster."Academic Year");
        RecHousingApp.SetRange(Status, RecHousingApp.Status::Approved);
        IF RecHousingApp.FindFirst() then;

        IF RecHousingApp."Approved On" <> 0D then
            NotAssigned := FORMAT(RecHousingApp."Approved On")
        else
            NotAssigned := 'Not Assigned';

        RecOptOutWaived.Reset();
        RecOptOutWaived.SetRange("Student No.", RecStudentMaster."No.");
        RecOptOutWaived.SetRange(Semester, RecStudentMaster.Semester);
        RecOptOutWaived.SetRange("Academic Year", RecStudentMaster."Academic Year");
        RecOptOutWaived.SetRange("Application Type", RecOptOutWaived."Application Type"::"Housing Wavier");
        RecOptOutWaived.SetRange(Status, RecOptOutWaived.Status::Approved);
        IF RecOptOutWaived.FindFirst() then;

        IF RecOptOutWaived."Approved/Rejected On" <> 0D then
            NotWaived := FORMAT(RecOptOutWaived."Approved/Rejected On")
        else
            NotWaived := 'Not Waived';

        RecStudentRegistration.Reset();
        RecStudentRegistration.SetRange("Student No", RecStudentMaster."No.");
        RecStudentRegistration.SetRange(Semester, RecStudentMaster.Semester);
        RecStudentRegistration.SetRange("Academic Year", RecStudentMaster."Academic Year");
        IF RecStudentRegistration.FindFirst() then;
        IF RecStudentRegistration."OLR Completed Date" <> 0D then
            OLREmailSent := FORMAT(RecStudentRegistration."OLR Completed Date")
        else
            OLREmailSent := 'Not Sent';

        // ExcelBuffer.NewRow();
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster."No."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster."Student Name"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Account Person Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(Today(), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."E-Mail Address", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecHousingApp."Approved On", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentRegistration."OLR Completed Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        // ExcelBuffer.AddColumn(RecStudentMaster."On Ground Check-In On", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        // ExcelBuffer.AddColumn(RecStudentRegistration."OLR Completed Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);

    end;

    procedure MakeExcelDataHeaderWaived()
    begin
        // ExcelBuffer.AddColumn('Student Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Last Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('First Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('School Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Semester', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Added By', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Date On', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Removed By', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Date Off', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExcelDataBodyWaived(RecStudentMaster: Record "Student Master-CS")
    var
        RecOptOutWaived: Record "Opt Out";
        RecOptOutWaived1: Record "Opt Out";
    begin
        RecOptOutWaived.Reset();
        RecOptOutWaived.SetRange("Student No.", RecStudentMaster."No.");
        RecOptOutWaived.SetRange(Semester, RecStudentMaster.Semester);
        RecOptOutWaived.SetRange("Academic Year", RecStudentMaster."Academic Year");
        RecOptOutWaived.SetRange("Application Type", RecOptOutWaived."Application Type"::"Housing Wavier");
        RecOptOutWaived.SetRange(Status, RecOptOutWaived.Status::Approved);
        IF RecOptOutWaived.FindFirst() then;

        RecOptOutWaived1.Reset();
        RecOptOutWaived1.SetRange("Student No.", RecStudentMaster."No.");
        RecOptOutWaived1.SetRange(Semester, RecStudentMaster.Semester);
        RecOptOutWaived1.SetRange("Academic Year", RecStudentMaster."Academic Year");
        RecOptOutWaived1.SetRange("Application Type", RecOptOutWaived1."Application Type"::"Housing Wavier");
        RecOptOutWaived1.SetRange(Status, RecOptOutWaived1.Status::Rejected);
        IF RecOptOutWaived1.FindFirst() then;

        // ExcelBuffer.NewRow();
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster."No."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster."Last Name"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster."First Name"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster.Status), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(FORMAT(RecStudentMaster.Semester), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecOptOutWaived."Approved/Rejected By", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecOptOutWaived."Approved/Rejected On", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        // ExcelBuffer.AddColumn(RecOptOutWaived1."Approved/Rejected By", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecOptOutWaived1."Approved/Rejected On", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExcelDataHeaderBursar()
    begin
        // ExcelBuffer.AddColumn('Student Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Account Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Person Account: First Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Person Account: Last Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Person Account: Birthdate', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Person Account: Mailing Street', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Person Account: Mailing State/Province', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Person Account: Mailing Zip/Postal Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Person Account: Mailing Country', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Institution', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Semester Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Application Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Decision Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Stage', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Program Start', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Application Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Application Sub-type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('VP Appreciation Letter', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Undergraduate GPA', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Pre-Req GPA', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Graduate GPA', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('High School GPA', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Deposit Paid Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Last ADA Call By', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Last ADA Call Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Enrollment Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Phone', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Person Account: Email', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Admission Co-ordinator', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Special Program', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Country of Citizenship', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Sub-Stage', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Anticipated Term', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Housing Waiver', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Housing', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('18 Digit ID', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('On AUA List?', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('On AICASA List?', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExcelDataBodyBursar(RecStudentMaster: Record "Student Master-CS")
    var
        RecEducationSetup: Record "Education Setup-CS";
        RecOptOutWaived: Record "Opt Out";
        RecStudentMaster1: Record "Student Master-CS";
        RecStudentMaster2: Record "Student Master-CS";
        CourseMasterRec: Record "Course Master-CS";
        StudentNumberAUA: Code[20];
        StudentNumberAICASA: Code[20];
    begin
        StudentNumberAUA := '';
        StudentNumberAICASA := '';
        RecEducationSetup.Reset();
        RecEducationSetup.SetRange("Global Dimension 1 Code", RecStudentMaster."Global Dimension 1 Code");
        IF RecEducationSetup.FindFirst() then;

        CourseMasterRec.Get(RecStudentMaster."Course Code");

        RecStudentMaster1.Reset();
        RecStudentMaster1.SetRange("No.", RecStudentMaster."No.");
        RecStudentMaster1.SetRange("Global Dimension 1 Code", '9000');
        IF RecStudentMaster1.FindFirst() then
            StudentNumberAUA := RecStudentMaster1."No.";

        RecStudentMaster2.Reset();
        RecStudentMaster2.SetRange("No.", RecStudentMaster."No.");
        RecStudentMaster2.SetRange("Global Dimension 1 Code", '9100');
        IF RecStudentMaster2.FindFirst() then
            StudentNumberAICASA := RecStudentMaster2."No.";
        RecOptOutWaived.Reset();
        RecOptOutWaived.SetRange("Student No.", RecStudentMaster."No.");
        RecOptOutWaived.SetRange(Semester, RecStudentMaster.Semester);
        RecOptOutWaived.SetRange("Academic Year", RecStudentMaster."Academic Year");
        RecOptOutWaived.SetRange("Application Type", RecOptOutWaived."Application Type"::"Housing Wavier");
        IF RecOptOutWaived.FindFirst() then;
        // ExcelBuffer.NewRow();
        // ExcelBuffer.AddColumn(RecStudentMaster."No.", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Student Name", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."First Name", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Last Name", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Date of Birth", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster.Addressee, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster.State, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Post Code", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Country Code", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecEducationSetup."Institute Name", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Course Name" + ' ' + RecStudentMaster.Semester, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Pre-Req GPA", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Graduate GPA", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."High School GPA", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster.Status, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Phone Number", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."E-Mail Address", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(CourseMasterRec."Course Category", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster.Citizenship, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster.Term, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecOptOutWaived.Status, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Housing', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."18 Digit ID", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(StudentNumberAUA, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(StudentNumberAICASA, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExcelDataHeaderOGCI()
    begin
        // ExcelBuffer.AddColumn('Student Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('SyStudentId', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('LastName', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('FirstName', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Campus', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('School Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Sy Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Category', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Current Semester', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Program', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Term', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('OGCI On ID', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('User On', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('OLR Completed ', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('UserIDOff', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('OGCI Off', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Off By', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('OGCIC On ID', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Checked In By', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('In Person Check In', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExcelDataBodyOGCI(RecStudentMaster: Record "Student Master-CS")
    var
        RecStudentRegistration: Record "Student Registration-CS";
    begin
        RecStudentRegistration.Reset();
        RecStudentRegistration.SetRange("Student No", RecStudentMaster."No.");
        RecStudentRegistration.SetRange(Semester, RecStudentMaster.Semester);
        RecStudentRegistration.SetRange("Academic Year", RecStudentMaster."Academic Year");
        IF RecStudentRegistration.FindFirst() then;

        // ExcelBuffer.NewRow();
        // ExcelBuffer.AddColumn(RecStudentMaster."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Last Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."First Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Global Dimension 1 Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Status", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster.Category, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster.Semester, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Course Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster.Term, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentRegistration."OLR Completed Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExcelDataHeaderPDFDate()
    begin
        // ExcelBuffer.AddColumn('Student Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('SyStudentID', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Last Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('First Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('School Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Program', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Current Semester', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Campus', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Document Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Document #', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Module', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Date Requested', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Date Sent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Date Received', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Due Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Document Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('User', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Date Added', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Time Added', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Date Last Modified', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Original File Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Comments', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Add User', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Document Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Document #', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Module', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Date Requested', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Date Sent', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Date Received', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Due Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Document Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('User', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Date Added', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Time Added', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Date Last Modified', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Original File Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Comments', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Add User', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExcelDataBodyPDFDate(RecStudentMaster: Record "Student Master-CS")
    begin
        // ExcelBuffer.NewRow();
        // ExcelBuffer.AddColumn(RecStudentMaster."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // //ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Last Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."First Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster.Status, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Course Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster.Semester, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Global Dimension 1 Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Document Name', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Document #', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Module', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Date Requested', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Date Sent', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Date Received', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Due Date', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Document Status', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('User', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Date Added', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Time Added', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Date Last Modified', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('OriginalFileName', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Comments', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Add User', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Document Name', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Document #', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Module', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Date Requested', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Date Sent', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Date Received', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Due Date', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Document Status', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('User', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Date Added', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Time Added', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Date Last Modified', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('OriginalFileName', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Comments', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // // ExcelBuffer.AddColumn('Add User', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);


    end;

    procedure MakeExcelDataHeaderOptOutBSIC()
    begin
        // ExcelBuffer.AddColumn('Student Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // //ExcelBuffer.AddColumn('SyStudentID', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('LastName', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('FirstName', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Group', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Semester', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Date On', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Date Off', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Date Off', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExcelDataBodyOptOutBSIC(RecStudentMaster: Record "Student Master-CS")
    begin
        // ExcelBuffer.NewRow();
        // ExcelBuffer.AddColumn(RecStudentMaster."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // //ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Last Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."First Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster.Group, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster.Semester, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExcelDataHeaderHousing()
    begin
        // ExcelBuffer.AddColumn('Student Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Last Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('First Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Application Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Housing From', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Housing To', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Housing Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Lease Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Building', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Room Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Room Category', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Room Fee', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Lease Start Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Move Out Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('End Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Actual End Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Date Added', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Campus', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExcelDataBodyHousing(RecStudentMaster: Record "Student Master-CS")
    var
        RecHousingApplication: Record "Housing Application";
    begin
        RecHousingApplication.Reset();
        RecHousingApplication.SetRange("Student No.", RecStudentMaster."No.");
        RecHousingApplication.SetRange(Semester, RecStudentMaster.Semester);
        RecHousingApplication.SetRange("Academic Year", RecStudentMaster."Academic Year");
        RecHousingApplication.SetRange(Status, RecHousingApplication.Status::Approved);
        IF RecHousingApplication.FindFirst() then;
        // ExcelBuffer.NewRow();
        // ExcelBuffer.AddColumn(RecStudentMaster."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Last Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."First Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecHousingApplication."Start Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        // ExcelBuffer.AddColumn(RecHousingApplication."End Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecHousingApplication."Housing ID", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecHousingApplication."Room No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecHousingApplication."Room Category Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecHousingApplication."Housing Cost", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecHousingApplication."End Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(RecStudentMaster."Global Dimension 1 Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

    end;

}