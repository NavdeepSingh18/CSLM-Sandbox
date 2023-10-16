report 50193 "Step 1 Scores"
{
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    ApplicationArea = all;

    dataset
    {
        dataitem("Student Subject Exam"; "Student Subject Exam")
        {
            DataItemTableView = SORTING("Student No.") where("Score Type" = filter("STEP 1"));
            trigger OnPreDataItem()
            begin
                SetRange("Global Dimension 1 Code", InstituteCode);
                IF EnrollmentNo <> '' THEN
                    SetFilter("Enrollment No", EnrollmentNo);
                if StudentNo <> '' then
                    SetFilter("Student No.", StudentNo);
                if Semester1 <> '' then
                    SetFilter(Semester, Semester1);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);


                TempExcelBuffer.Reset();
                TempExcelBuffer.DeleteAll();

                TempExcelBuffer.AddColumn('Student Number', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Last Name', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('First Name', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Citizenship', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('School Status', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Semester', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Code', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Test Date', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Score', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Pass/Fail', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Attempt', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
                WindowDialog.Open('Fetching Students\' + Text001Lbl);
                CtrTot := "Student Subject Exam".Count();

            end;

            trigger OnAfterGetRecord()
            Var

                StudentSubjectExam: Record "Student Subject Exam";
            begin
                Code1 := '';
                SemesterFilter := '';
                StudentNoFilter := '';
                AllFilters := '';
                InstituteCodeFilter := '';
                EnrollmentFilter := '';
                AcademicYearFilter := '';


                Clear(StudentMaster);
                IF StudentMaster.Get("Student No.") Then;




                IF InstituteCode <> '' then
                    InstituteCodeFilter := 'Institute Code:' + "Global Dimension 1 Code";
                IF EnrollmentNo <> '' then
                    EnrollmentFilter := ', Enrollment No.:' + "Enrollment No";
                if StudentNo <> '' then
                    StudentNoFilter := 'Student No.:' + "Student No.";
                if Semester1 <> '' then
                    SemesterFilter := 'Semester:' + Semester;
                IF InstituteCode <> '' then
                    InstituteCodeFilter := 'Institute Code:' + "Global Dimension 1 Code";


                AllFilters := InstituteCodeFilter + EnrollmentFilter + StudentNoFilter + SemesterFilter + AcademicYearFilter;

                RecEduSetupAUA.Reset();
                RecEduSetupAUA.SetRange("Global Dimension 1 Code", '9000');
                IF RecEduSetupAUA.FindFirst() then
                    RecEduSetupAUA.CALCFIELDS("Logo Image");

                RecEduSetupAICASA.Reset();
                RecEduSetupAICASA.SetRange("Global Dimension 1 Code", '9100');
                IF RecEduSetupAICASA.FindFirst() then
                    RecEduSetupAICASA.CALCFIELDS("Logo Image");

                Code1 := 'STEP 1';
                Ctr += 1;
                WindowDialog.Update(1, "Student Subject Exam"."Student No." + ' - ' + format(Ctr));



                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn("Student Subject Exam"."Student No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(StudentMaster."Last Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(StudentMaster."First Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(StudentMaster.Citizenship, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(StudentMaster.Status, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(StudentMaster.Semester, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Code1, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Sitting Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                TempExcelBuffer.AddColumn("External Mark", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Result", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Exam Sequence", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);



            end;

            trigger OnPostDataItem()
            begin
                WindowDialog.Close();
                TempExcelBuffer.CreateNewBook(StudentList);
                TempExcelBuffer.WriteSheet(StudentList, CompanyName, UserId);
                TempExcelBuffer.CloseBook();
                TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
                TempExcelBuffer.OpenExcel();
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
                    field("No."; StudentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Student No.';
                        TableRelation = "Student Master-CS";
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

    trigger OnInitReport()
    begin
        CompInfo.GET();
    end;

    trigger OnPreReport()
    begin
        IF InstituteCode = '' THEN
            ERROR('Institute Code must have a value in it');

        RecEduSetup.Reset();
        RecEduSetup.SetRange("Global Dimension 1 Code", InstituteCode);
        IF RecEduSetup.FindFirst() then
            RecEduSetup.CALCFIELDS("Logo Image");
    end;

    var
        CompInfo: Record "Company Information";
        RecEduSetupAUA: Record "Education Setup-CS";
        RecEduSetupAICASA: Record "Education Setup-CS";
        StudentMasterCS: Record "Student Master-CS";
        RecEduSetup: Record "Education Setup-CS";
        StudentMaster: Record "Student Master-CS";
        Semester1: Code[100];
        StudentNo: Code[2048];
        Code1: Text[50];
        AllFilters: Text;
        SemesterFilter: Code[100];
        StudentNoFilter: Code[2048];
        InstituteCode: Code[20];
        // Attempt: Integer;
        EnrollmentNo: Code[2048];
        AcademicYear: Code[20];
        InstituteCodeFilter: Code[20];
        AcademicYearFilter: Text;
        EnrollmentFilter: Code[2048];
        // SourceCode: Code[20];
        // TestDate: date
        // ;
        Result: option " ",Pass,Fail,Certified;
        //StudentMaster: Record "Student Master-CS";
        TempExcelBuffer: Record "Excel Buffer" temporary;

        StudentList: Label 'Step 1 Scores';
        ExcelFileName: Label 'Step 1 Scores_%1_%2';
        Text001Lbl: Label 'Students No.     ############1################\';
        WindowDialog: Dialog;
        Ctr: Integer;
        CtrTot: Integer;


}