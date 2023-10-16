page 50534 APISalesForceStudentInsert
{

    // PageType = API;
    PageType = List;
    SourceTable = SalesForceStudent;
    // EntityName = 'salesforceStudent';
    // EntitySetName = 'salesforceStudent';
    DelayedInsert = true;
    Caption = 'API Salesforce Student';
    UsageCategory = Lists;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(academicyeaR; Rec.AcademicYear)
                {
                    Caption = 'AcademicYear';
                    ApplicationArea = All;
                }
                field(admittedyeaR; Rec.AdmittedYear)
                {
                    Caption = 'AdmittedYear';
                    ApplicationArea = All;
                }
                field(applicationnO; Rec.ApplicationNo)
                {
                    Caption = 'ApplicationNo';
                    ApplicationArea = All;
                }
                field(categorY; Rec.Category)
                {
                    Caption = 'Category';
                    ApplicationArea = All;
                }
                field(citizenshiP; Rec.Citizenship)
                {
                    Caption = 'Citizenship';
                    ApplicationArea = All;
                }
                field(coursecodE; Rec.CourseCode)
                {
                    Caption = 'CourseCode';
                    ApplicationArea = All;
                }
                field(dateofjoininG; Rec.DateofJoining)
                {
                    Caption = 'DateofJoining';
                    ApplicationArea = All;
                }
                field(emaiL; Rec.Email)
                {
                    Caption = 'Email';
                    ApplicationArea = All;
                }
                field(fathernamE; Rec.FatherName)
                {
                    Caption = 'FatherName';
                    ApplicationArea = All;
                }
                field(feeclassificationcodE; Rec.FeeClassificationCode)
                {
                    Caption = 'FeeClassificationCode';
                    ApplicationArea = All;
                }
                field(firstnamE; Rec.FirstName)
                {
                    Caption = 'FirstName';
                    ApplicationArea = All;
                }
                field(gD1; Rec.GD1)
                {
                    Caption = 'GD';
                    ApplicationArea = All;
                }
                field(gD2; Rec.GD2)
                {
                    Caption = 'GD';
                    ApplicationArea = All;
                }
                field(gendeR; Rec.Gender)
                {
                    Caption = 'Gender';
                    ApplicationArea = All;
                }
                field(middlenamE; Rec.MiddleName)
                {
                    Caption = 'MiddleName';
                    ApplicationArea = All;

                }
                field(mobilenO; Rec.MobileNo)
                {
                    Caption = 'MobileNo';
                    ApplicationArea = All;
                }
                field(mothernamE; Rec.MotherName)
                {
                    Caption = 'MotherName';
                    ApplicationArea = All;
                }
                field(nationalitY; Rec.Nationality)
                {
                    Caption = 'Nationality';
                    ApplicationArea = All;
                }
                field(passportexpirydatE; Rec.PassPortExpiryDate)
                {
                    Caption = 'PassPortExpiryDate';
                    ApplicationArea = All;
                }
                field(passportnO; Rec.PassPortNo)
                {
                    Caption = 'PassPortNo';
                    ApplicationArea = All;
                }
                field(postcodE; Rec.PostCode)
                {
                    Caption = 'PostCode';
                    ApplicationArea = All;
                }
                field(roomcategorY; Rec.RoomCategory)
                {
                    Caption = 'ApartmentCategory';
                    ApplicationArea = All;
                }
                field(salesforcenO; Rec.SalesForceNo)
                {
                    Caption = 'SalesForceNo';
                    ApplicationArea = All;
                }
                field(semesteR; Rec.Semester)
                {
                    Caption = 'Semester';
                    ApplicationArea = All;
                }
                field(lastnamE; Rec.LastName)
                {
                    Caption = 'LastName';
                    ApplicationArea = All;
                }
                field(yeaR; Rec.Year)
                {
                    Caption = 'Year';
                    ApplicationArea = All;
                }
                field(entrystatuS; Rec.EntryStatus)
                {
                    Caption = 'EntryStatus';
                    ApplicationArea = All;
                }
                field(studentnO; Rec.StudentNo)
                {
                    Caption = 'EntryStatus';
                    ApplicationArea = All;
                }
                field(enrollmentnO; Rec.EnrollmentNo)
                {
                    Caption = 'EntryStatus';
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        StudentMaster: Record "Student Master-CS";
        AcademicSetup: Record "Academics Setup-CS";
        AdmissionSetup: Record "Admission Setup-CS";
        SalesForceStudent: Record SalesForceStudent;
        NoSeriesMgt: Codeunit NoSeriesManagement;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if not (Rec.EntryStatus IN [Rec.EntryStatus::Insert, Rec.EntryStatus::Update, Rec.EntryStatus::Delete]) then
            error('%1 must have a value.', Rec.FieldCaption(EntryStatus));

        case Rec.EntryStatus of
            Rec.EntryStatus::Insert:
                begin
                    SalesForceStudent.Reset();
                    SalesForceStudent.SetRange(SalesForceNo, Rec.SalesForceNo);
                    if SalesForceStudent.FindFirst() then
                        error('Duplicate %1', Rec.SalesForceNo)
                    else begin
                        Rec.LineNo := 10000;
                    end;
                    // CreateRequest();
                end;
            Rec.EntryStatus::Update:
                begin
                    SalesForceStudent.Reset();
                    SalesForceStudent.SetRange(SalesForceNo, Rec.SalesForceNo);
                    if SalesForceStudent.Findlast() then
                        Rec.LineNo := SalesForceStudent.LineNo + 10000
                    else
                        Error('Please Insert entry to update this entry.');
                    //UpdateRequest();
                end;
            Rec.EntryStatus::Delete:
                begin
                    Error('Delete request development under process.');
                end
            else
                Error('Invalid Request');
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Error('Patch Or Update Request not Allowed.');
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Error('Delete Request not Allowed.');
    end;

    // procedure CreateRequest(): text
    // begin
    //     AcademicSetup.Get();
    //     AcademicSetup.TestField("Student No.");
    //     AdmissionSetup.Get();
    //     AdmissionSetup.TestField("Enrolment No.");
    //     StudentMaster.RESET();
    //     StudentMaster.SETRANGE("SalesForce Reference No.", SalesForceNo);
    //     IF NOT StudentMaster.FINDFIRST() THEN BEGIN
    //         StudentMaster.INIT();
    //         StudentMaster.Validate("No.", NoSeriesMgt.GetNextNo(AcademicSetup."Student No.", 0D, TRUE));
    //         StudentMaster."Application No." := ApplicationNo;
    //         StudentMaster.validate("First Name", FirstName);
    //         StudentMaster.validate("Middle Name", MiddleName);
    //         StudentMaster.validate("Last Name", LastName);
    //         StudentMaster."Academic Year" := AcademicYear;
    //         StudentMaster.Validate("Date of Birth", DateOfBirth);
    //         StudentMaster."Course Code" := CourseCode;
    //         StudentMaster.Graduation := 'PG';
    //         StudentMaster."Mobile Number" := MobileNo;
    //         StudentMaster."E-Mail Address" := Email;
    //         StudentMaster."Fee Classification Code" := FeeClassificationCode;
    //         StudentMaster.Category := Category;
    //         StudentMaster.Gender := Gender;
    //         StudentMaster.Semester := Semester;
    //         StudentMaster."Date of Joining" := DateofJoining;
    //         StudentMaster."SalesForce Reference No." := SalesForceNo;
    //         StudentMaster."Room Category Code" := RoomCategory;
    //         StudentMaster."Admitted Year" := AdmittedYear;
    //         StudentMaster.Year := Year;
    //         StudentMaster."Global Dimension 1 Code" := GD1;
    //         StudentMaster."Global Dimension 2 Code" := GD2;
    //         StudentMaster."Fathers Name" := FatherName;
    //         StudentMaster."Mothers Name" := MotherName;
    //         StudentMaster.Citizenship := Citizenship;
    //         StudentMaster.Nationality := Nationality;
    //         StudentMaster.Validate("Post Code", PostCode);
    //         StudentMaster."Pass Port No." := PassPortNo;
    //         StudentMaster."Pass Port Expiry Date" := PassPortExpiryDate;
    //         StudentMaster."Salesforce Inserted" := true;
    //         StudentMaster.Validate("Enrollment No.", NoSeriesMgt.GetNextNo(AdmissionSetup."Enrolment No.", 0D, TRUE));

    //         if StudentMaster.INSERT(true) then begin
    //             StudentNo := StudentMaster."No.";
    //             EnrollmentNo := StudentMaster."Enrollment No.";
    //         end;
    //     end;
    // end;

    // procedure UpdateRequest(): text
    // begin
    //     StudentMaster.RESET();
    //     StudentMaster.SETRANGE("SalesForce Reference No.", SalesForceNo);
    //     if StudentMaster.FINDFIRST() then begin
    //         StudentMaster."Application No." := ApplicationNo;
    //         StudentMaster.validate("First Name", FirstName);
    //         StudentMaster.validate("Middle Name", MiddleName);
    //         StudentMaster.validate("Last Name", LastName);
    //         StudentMaster."Academic Year" := AcademicYear;
    //         StudentMaster.Validate("Date of Birth", DateOfBirth);
    //         StudentMaster."Course Code" := CourseCode;
    //         StudentMaster.Graduation := 'PG';
    //         StudentMaster."Mobile Number" := MobileNo;
    //         StudentMaster."E-Mail Address" := Email;
    //         StudentMaster."Fee Classification Code" := FeeClassificationCode;
    //         StudentMaster.Category := Category;
    //         StudentMaster.Gender := Gender;
    //         StudentMaster.Semester := Semester;
    //         StudentMaster."Date of Joining" := DateofJoining;
    //         StudentMaster."Room Category Code" := RoomCategory;
    //         StudentMaster."Admitted Year" := AdmittedYear;
    //         StudentMaster.Year := Year;
    //         StudentMaster."Global Dimension 1 Code" := GD1;
    //         StudentMaster."Global Dimension 2 Code" := GD2;
    //         StudentMaster."Fathers Name" := FatherName;
    //         StudentMaster."Mothers Name" := MotherName;
    //         StudentMaster.Citizenship := Citizenship;
    //         StudentMaster.Nationality := Nationality;
    //         StudentMaster.Validate("Post Code", PostCode);
    //         StudentMaster."Pass Port No." := PassPortNo;
    //         StudentMaster."Pass Port Expiry Date" := PassPortExpiryDate;

    //         if StudentMaster.Modify(true) then begin
    //             StudentNo := StudentMaster."No.";
    //             EnrollmentNo := StudentMaster."Enrollment No.";
    //         end;
    //     end;
    // end;
}
