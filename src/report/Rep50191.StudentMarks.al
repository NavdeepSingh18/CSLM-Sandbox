report 50191 "Student Marks"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/StudentMarks.rdl';
    PreviewMode = PrintLayout;


    dataset
    {

        dataitem("Student Subject Exam"; "Student Subject Exam")
        {

            column(Filter_Caption1; AllFilters)
            { }
            column(CompInfo; CompInfo.Name)
            { }


            Column("Institute_Name"; Name)
            {

            }
            Column("Institute_Address"; Address)
            {

            }
            Column("Institute_Address2"; Address2)
            {

            }
            Column("Institute_City"; City)
            {

            }
            Column("Institute_PostCode"; PostCode)
            {

            }
            Column("Institute_Phone"; PhoneNo)
            {

            }
            Column("Institute_Email"; Emailid)
            {

            }
            Column("Institute_FaxNo"; FaxNo)
            {

            }
            column(Semester; Semester)
            {

            }

            column(Total; Total)
            {

            }
            column(Enrollment_No; "Enrollment No")
            {

            }
            column(Course; Course)
            {

            }
            column(Student_Name; "Student Name")
            {

            }
            column(Student_No_; "Student No.")
            {

            }
            column(Credit_Earned; "Credit Earned")
            {

            }
            column(Subject_Code; "Subject Code")
            {

            }
            column(SubjectLevel3; SubjectLevel3)
            {

            }
            column(SubjectDescr; SubjectDescr)
            {

            }
            column(Original_Student_No_; "Original Student No.")
            {

            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }
            column(Category_Course_Description; "Category-Course Description")
            {

            }

            trigger OnAfterGetRecord()
            begin
                Clear(SubjectDescr);
                //Clear(Subjectlevel2);
                Clear(SubjectLevel3);

                MainStudentSubject.Reset();
                MainStudentSubject.SetFilter("Enrollment No", "Student Subject Exam"."Enrollment No");
                MainStudentSubject.SetFilter(Course, "Student Subject Exam".Course);
                MainStudentSubject.SetFilter(Semester, "Student Subject Exam".Semester);
                MainStudentSubject.SetFilter("Subject Code", "Student Subject Exam"."Subject Code");
                if PublishedDocumentNo <> '' then
                    MainStudentSubject.SetFilter("Published Document No.", PublishedDocumentNo);
                if MainStudentSubject.FindFirst() then begin
                    SubjectLevel3 := MainStudentSubject."Subject Code";
                    SubjectDescr := MainStudentSubject.Description;
                end;



                AllFilters := '';
                InstituteCodeFilter := '';
                EnrollmentFilter := '';
                AcademicYearFilter := '';
                CourseCodeFilter := '';


                IF InstituteCode <> '' then
                    InstituteCodeFilter := 'Institute Code:' + "Global Dimension 1 Code";
                IF EnrollmentNo <> '' then
                    EnrollmentFilter := ', Enrollment No.:' + "Enrollment No";
                IF AcademicYear <> '' then
                    AcademicYearFilter := ', Academic Year:' + "Academic Year";
                if CourseCode <> '' then
                    CourseCodeFilter := ', Course Code:' + Course;


                AllFilters := InstituteCodeFilter + EnrollmentFilter + AcademicYearFilter + CourseCodeFilter;

            end;


            trigger OnPreDataItem()
            begin
                if InstituteCode <> '' then
                    SetRange("Global Dimension 1 Code", InstituteCode);
                IF EnrollmentNo <> '' THEN
                    SetFilter("Enrollment No", EnrollmentNo);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);
                if CourseCode <> '' then
                    SetFilter(Course, CourseCode);
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
                            MainStudentSubject.Reset();
                            MainStudentSubject.findset();
                            IF PAGE.RUNMODAL(50956, MainStudentSubject) = ACTION::LookupOK THEN
                                EnrollmentNo := MainStudentSubject."Enrollment No";
                        end;
                    }
                    field("Academic Year"; AcademicYear)
                    {
                        ApplicationArea = All;
                        Caption = 'Academic Year';
                        TableRelation = "Academic Year Master-CS";
                    }
                    field("Course Code"; CourseCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Course Code';
                        TableRelation = "Course Master-CS".Code;
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
        //if (EnrollmentNo = '') and (Semester1 = '') then
        //  Error('Enrollment No. or Semenst must have a value in it.');

        //IF InstituteCode = '' THEN
        //  ERROR('Institute Code must have a value in it');
        if InstituteCode <> '' then begin
            RecEduSetup.Reset();
            RecEduSetup.SetRange("Global Dimension 1 Code", InstituteCode);
            IF RecEduSetup.FindFirst() then begin
                RecEduSetup.CALCFIELDS("Logo Image");
                Name := RecEduSetup."Institute Name";
                Address := RecEduSetup."Institute Address";
                Address2 := RecEduSetup."Institute Address 2";
                City := RecEduSetup."Institute City";
                Emailid := RecEduSetup."Institute E-Mail";
                PhoneNo := RecEduSetup."Institute Phone No.";
                FaxNo := RecEduSetup."Institute Fax No.";
                PostCode := RecEduSetup."Institute Post Code";

            end;

        end else begin
            CompInfo.GET();
            Name := CompInfo.Name;
            Address := CompInfo.Address;
            Address2 := CompInfo."Address 2";
            City := CompInfo.City;
            Emailid := CompInfo."E-Mail";
            PhoneNo := CompInfo."Phone No.";
            FaxNo := CompInfo."Fax No.";
            PostCode := CompInfo."Post Code";
        end;
    end;


    var
        CompInfo: Record "Company Information";
        StudentMasterCS: Record "Student Master-CS";
        RecEduSetup: Record "Education Setup-CS";

        StudentNo: Code[2048];

        AllFilters: Text;

        StudentNoFilter: Code[2048];
        InstituteCode: Code[20];
        EnrollmentNo: Code[2048];

        PublishedDocumentNo: Code[20];
        AcademicYear: Code[20];
        InstituteCodeFilter: Code[20];
        AcademicYearFilter: Text;
        EnrollmentFilter: Code[2048];

        CourseCode: Code[20];

        CourseCodeFilter: Code[20];

        MainStudentSubject: Record "Student Subject Exam";
        SubjectLevel3: Code[20];
        Subjectlevel2: Code[20];

        SubjectDescr: Text[100];

        Name: Text[500];
        Address: Text[250];

        Address2: Text[250];
        City: Text[30];

        PostCode: Code[20];
        PhoneNo: Text[30];
        Emailid: Text[80];
        FaxNo: Text[30];


    procedure Reportvariable(Inst: code[20]; EnrollNo: Code[2048]; Course: Code[20]; AcaYear: Code[20]; PublishedDocNo: Code[20])
    begin
        EnrollmentNo := EnrollNo;
        PublishedDocumentNo := PublishedDocNo;
        InstituteCode := Inst;
        CourseCode := Course;
        AcademicYear := AcaYear;

    end;

}