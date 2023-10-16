codeunit 50025 "Admission Stage1-CS"
{
    // version V.001-CS

    // Sr.No.Emp. ID      Date      Trigger                      Remarks
    // 1      CSPL-00092  11-05-2019LimitAgeCheckCS              Check Age Limit
    // 2      CSPL-00092  11-05-2019ApplicationDateCheckCS      Check Application Date
    // 3      CSPL-00092  11-05-2019RegistrationDateCheckCS      Check Registration Date
    // 4      CSPL-00092  11-05-2019TotalQuotaPercentageCheckCS  Check TotalQuota Percentage
    // 5      CSPL-00092  11-05-2019ProgramFeeDetailsCopyCS      Copy Program Fee Details
    // 6      CSPL-00092  11-05-2019ApplicationCostCheckCS        Code added for Enquiry Modification
    // 7      CSPL-00092  11-05-2019ReceiptUpdateCS               Code added for Application related Modification
    // 8      CSPL-00092  11-05-2019StudentNoAllotCS              Code added for Student No Allocation


    trigger OnRun()
    begin
    end;

    var
        Text004Lbl: Label 'Sale of Application Closed';
        Text005Lbl: Label 'Registration Closed';

    procedure LimitAgeCheckCS(getCourse: Code[20]; getAge: Integer): Boolean
    var
        CourseMasterCS: Record "Course Master-CS";
    begin
        //Code added for Check Age Limit ::CSPL-00092::11-05-2019: Start
        IF CourseMasterCS.GET(getCourse) THEN BEGIN
            IF (CourseMasterCS."Miniimum Age Limit" <> 0) AND (CourseMasterCS."Maximum Age Limit" <> 0) THEN BEGIN
                IF (CourseMasterCS."Miniimum Age Limit" >= getAge) AND (CourseMasterCS."Maximum Age Limit" <= getAge) THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END ELSE
                EXIT(TRUE);
        END ELSE
            EXIT(FALSE);
        //Code added for Check Age Limit ::CSPL-00092::11-05-2019: End
    end;

    procedure ApplicationDateCheckCS(GetCourse: Code[20]): Boolean
    var
        CourseMasterCS: Record "Course Master-CS";
    begin
        //Code added for Check Application Date ::CSPL-00092::11-05-2019: Start
        IF CourseMasterCS.GET(GetCourse) THEN BEGIN
            IF (CourseMasterCS."Application Sale From" <> 0D) AND (CourseMasterCS."Application Sale Till" <> 0D) THEN BEGIN
                IF (CourseMasterCS."Application Sale From" <= TODAY()) AND (CourseMasterCS."Application Sale Till" >= TODAY()) THEN
                    EXIT(TRUE)
                ELSE BEGIN
                    MESSAGE(Text004Lbl);
                    EXIT(FALSE);
                END;
            END ELSE
                EXIT(TRUE);
        END ELSE
            EXIT(TRUE);
        //Code added for Check Application Date ::CSPL-00092::11-05-2019: End
    end;

    procedure RegistrationDateCheckCS(GetCourse: Code[20]): Boolean
    var
        CourseMasterCS: Record "Course Master-CS";
    begin
        //Code added for Check Registration Date ::CSPL-00092::11-05-2019: Start
        IF CourseMasterCS.GET(GetCourse) THEN BEGIN
            IF (CourseMasterCS."Application Receive From" <> 0D) AND (CourseMasterCS."Application Receive Till" <> 0D) THEN BEGIN
                IF (CourseMasterCS."Application Receive From" <= TODAY()) AND (CourseMasterCS."Application Receive Till" >= TODAY()) THEN
                    EXIT(TRUE)
                ELSE BEGIN
                    MESSAGE(Text005Lbl);
                    EXIT(FALSE);
                END;
            END ELSE
                EXIT(TRUE);
        END ELSE
            EXIT(TRUE);
        //Code added for Check Registration Date ::CSPL-00092::11-05-2019: End
    end;

    procedure TotalQuotaPercentageCheckCS(): Decimal
    var
        PercentageQuotaCS: Record "Percentage Quota-CS";
        DecPercentage: Decimal;

    begin
        //Code added for Check TotalQuota Percentage ::CSPL-00092::11-05-2019: Start
        DecPercentage := 0;
        PercentageQuotaCS.Reset();
        IF PercentageQuotaCS.FINDSET() THEN
            REPEAT
                DecPercentage += PercentageQuotaCS.Percentage;
            UNTIL PercentageQuotaCS.NEXT() = 0;
        EXIT(DecPercentage);
        //Code added for Check TotalQuota Percentage ::CSPL-00092::11-05-2019: End
    end;

    procedure ProgramFeeDetailsCopyCS(Num: Code[20]; CopyAdmittedYear: Code[20]; CopyAcademicYear: Code[20]; AllotedAdmittedYear: Code[20]; AllotedAcademicYear: Code[20])
    var
        FeeCourseHeadCS: Record "Fee Course Head-CS";
        FeeCourseLineCS: Record "Fee Course Line-CS";
        FeeCourseLineCS1: Record "Fee Course Line-CS";
        FeeCourseHeadCS2: Record "Fee Course Head-CS";
        FeeCourseLineCS3: Record "Fee Course Line-CS";
        FeeSetupCS: Record "Fee Setup-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        LineNo: Integer;
        NextNo: Code[20];

    begin
        //Code added for Copy Program Fee Details ::CSPL-00092::11-05-2019: Start
        FeeSetupCS.GET();

        FeeCourseHeadCS.Reset();
        FeeCourseHeadCS.SETRANGE("Admitted Year", CopyAdmittedYear);
        FeeCourseHeadCS.SETRANGE("Academic Year", CopyAcademicYear);
        FeeCourseHeadCS.SETRANGE("No.", Num);
        IF FeeCourseHeadCS.FINDSET() THEN
            REPEAT
                NextNo := NoSeriesManagement.GetNextNo(FeeSetupCS."Course Fee No", 0D, TRUE);
                FeeCourseHeadCS2.INIT();
                FeeCourseHeadCS2."No." := NextNo;
                FeeCourseHeadCS2."Course Code" := FeeCourseHeadCS."Course Code";
                FeeCourseHeadCS2.Semester := FeeCourseHeadCS.Semester;
                FeeCourseHeadCS2.Year := FeeCourseHeadCS.Year;
                FeeCourseHeadCS2."Fee Classification Code" := FeeCourseHeadCS."Fee Classification Code";
                FeeCourseHeadCS2.Category := FeeCourseHeadCS.Category;
                FeeCourseHeadCS2."Academic Year" := AllotedAcademicYear;
                FeeCourseHeadCS2."Admitted Year" := AllotedAdmittedYear;
                FeeCourseHeadCS2."Global Dimension 1 Code" := FeeCourseHeadCS."Global Dimension 1 Code";
                FeeCourseHeadCS2."Global Dimension 2 Code" := FeeCourseHeadCS."Global Dimension 2 Code";
                FeeCourseHeadCS2."G/L Account for fine" := FeeCourseHeadCS."G/L Account for fine";
                FeeCourseHeadCS2."Late Fine %" := FeeCourseHeadCS."Late Fine %";
                FeeCourseHeadCS2."Program" := FeeCourseHeadCS."Program";
                FeeCourseHeadCS2."Type Of Course" := FeeCourseHeadCS."Type Of Course";
                FeeCourseHeadCS2."Course Name" := FeeCourseHeadCS."Course Name";
                FeeCourseHeadCS2."Currency Code" := FeeCourseHeadCS."Currency Code";
                FeeCourseHeadCS2."No.Series" := FeeSetupCS."Course Fee No";
                FeeCourseHeadCS2."User ID" := FORMAT(UserId());
                FeeCourseHeadCS2.INSERT();

                FeeCourseLineCS.Reset();
                FeeCourseLineCS.SETRANGE("Document No.", FeeCourseHeadCS."No.");
                IF FeeCourseLineCS.FINDSET() THEN
                    REPEAT

                        FeeCourseLineCS1.Reset();
                        FeeCourseLineCS1.SETRANGE("Document No.", FeeCourseHeadCS2."No.");
                        IF NOT FeeCourseLineCS1.FINDLAST() THEN
                            LineNo := 10000
                        ELSE
                            LineNo := FeeCourseLineCS1."Line No." + 10000;

                        FeeCourseLineCS3.INIT();
                        FeeCourseLineCS3."Document No." := NextNo;
                        FeeCourseLineCS3."Line No." := LineNo;
                        FeeCourseLineCS3."Fee Code" := FeeCourseLineCS."Fee Code";
                        FeeCourseLineCS3.Amount := FeeCourseLineCS.Amount;
                        FeeCourseLineCS3.Description := FeeCourseLineCS.Description;
                        FeeCourseLineCS3."Fees Type" := FeeCourseLineCS."Fees Type";
                        FeeCourseLineCS3."Global Dimension 1 Code" := FeeCourseLineCS."Global Dimension 1 Code";
                        FeeCourseLineCS3."Global Dimension 2 Code" := FeeCourseLineCS."Global Dimension 2 Code";
                        FeeCourseLineCS3."Last Date" := FeeCourseLineCS."Last Date";
                        FeeCourseLineCS3."Late Fee Amount %" := FeeCourseLineCS."Late Fee Amount %";
                        FeeCourseLineCS3."G/L Acount for fine" := FeeCourseLineCS."G/L Acount for fine";
                        FeeCourseLineCS3."Course Code" := FeeCourseLineCS."Course Code";
                        FeeCourseLineCS3."Course Name" := FeeCourseLineCS."Course Name";
                        FeeCourseLineCS3.Semester := FeeCourseLineCS.Semester;
                        FeeCourseLineCS3.Year := FeeCourseLineCS.Year;
                        FeeCourseLineCS3."Currency Code" := FeeCourseLineCS."Currency Code";
                        FeeCourseLineCS3."Academic Year" := AllotedAcademicYear;
                        FeeCourseLineCS3."Admitted Year" := AllotedAdmittedYear;
                        FeeCourseLineCS3.INSERT();
                    UNTIL FeeCourseLineCS.NEXT() = 0;
            UNTIL FeeCourseHeadCS.NEXT() = 0;
        //Code added for Copy Program Fee Details ::CSPL-00092::11-05-2019: End
    end;

    procedure ApplicationCostCheckCS("ApplNo.": Code[20]; getProcess: Option Sales,Registration): Boolean
    var
    // AdmissionSetupCS: Record "Admission Setup-CS";
    //ApplicationCS: Record "Application-CS";
    //CollegeEnquiryCS: Record "College Enquiry-CS";
    begin
        //Code added for Enquiry Modification ::CSPL-00092::11-05-2019: Start
        /*
        IF "ApplNo." = '' THEN
          ERROR(Text007);
        //AdmissionSetupCS.GET();
        //IF AdmissionSetupCS."Application Cost" AND (getProcess = getProcess::Sales) THEN
        //  "Application Journal"("ApplNo.",getProcess)
        //ELSE
        //IF (NOT AdmissionSetupCS."Application Cost") AND (getProcess = getProcess::Sales) THEN BEGIN
        IF (AdmissionSetupCS."Application Cost") AND (getProcess = getProcess::Sales) THEN BEGIN
          ApplicationCS.GET("ApplNo.");
          ApplicationCS."Application Status" := ApplicationCS."Application Status"::Sold;
          ApplicationCS.Modify();
          IF CollegeEnquiryCS.GET(ApplicationCS."Enquiry No.") THEN BEGIN
            CollegeEnquiryCS."Converted to Application" := TRUE;
            CollegeEnquiryCS.Modify();
          END;
            MESSAGE(Text001Lbl);
        END;
        */
        //Code added for Enquiry Modification ::CSPL-00092::11-05-2019: End

    end;

    procedure ReceiptUpdateCS("ApplNo.": Code[20])
    var
    // ApplicationCS: Record "Application-CS";
    // AdmissionSetupCS: Record "Admission Setup-CS";
    // Process: Option Sales,Registration;
    begin
        //Code added for Application Related Modification ::CSPL-00092::11-05-2019: Start
        /*
        ApplicationCS.GET("ApplNo.");
        AdmissionSetupCS.GET();
        IF AdmissionSetupCS."Registration Cost" THEN BEGIN
          ApplicationCS."Date of Receive" := TODAY();
          ApplicationCS.Modify();
         // "Application Journal"("ApplNo.",Process::Registration);
        END ELSE BEGIN
        // "Application Journal"("ApplNo.",Process::Sales);
          ApplicationCS."Application Status" := ApplicationCS."Application Status"::Received;
          ApplicationCS."Date of Receive" := TODAY();
          ApplicationCS.Modify();
          IF NOT ApplicationCS."Application Fee" THEN
          MESSAGE(Text002Lbl);
        END;
        */
        //Code added for Application Related Modification ::CSPL-00092::11-05-2019: End

    end;

    procedure StudentNoAllotCS(ApplNo: Code[20])
    var

    /*
            Student: Record "Unit Master-CS";
            Customer: Record "Customer";
            Application1: Record "Sessional Exam Group Line-CS";
            Student1: Record "Unit Master-CS";
            FeeGeneration: Report "Fee Generation - College1 CS";
            InitialFeeSetup: Record "Time Period-CS";
            ShiptoAddress: Record "Ship-to Address";
            SalesNRecSetup: Record "Sales & Receivables Setup";
            FeeGenerationCus: Report "Fee Generation - College1 CS";
            NoSeriesMgmt: Codeunit NoSeriesManagement;
            RollNo: Code[20];
            "StudentNo.": Code[20];

            CombineCode: Text[90];
            IntCount: Integer;

            "CustomerNo.": Code[20];
            Text0001Lbl: Label 'Roll No. %1  Generated for this application';
            Text0002Lbl: Label 'Already Converted as Student';
            Text0003Lbl: Label 'Customer No. %1  Generated for this application';*/
    begin
        //Code added for Student No Allocation No ::CSPL-00092::11-05-2019: Start
        /*
        Application.GET(ApplNo);
        IF Application.Admitted THEN
        IF Application.Alloted THEN
          ERROR(Text0002Lbl);
        ///
        
        //MESSAGE('Application Admitted and forwarded to Fee Section!');
        
        IntCount := 0;
        InitialFeeSetup.Reset();
        
        IF InitialFeeSetup.FINDSET()THEN
          REPEAT
            IntCount += 1;
            CombineCode += InitialFeeSetup."Fee Type Code";
            IF IntCount <> InitialFeeSetup.COUNT() THEN
              CombineCode += '|';
          UNTIL InitialFeeSetup.NEXT() = 0;
        
        IF CombineCode = '' THEN
          ERROR(Text003Lbl);
        Customer1.Reset();
        Customer1.SETRANGE("Application No.",ApplNo);
        IF Customer1.FINDSET()THEN
          ERROR('Customer already created');
        AdmissionSetup.GET();
        AdmissionSetup.TESTFIELD("Student No.");
        AdmissionSetup.TESTFIELD("Gen. Bus. Posting Group");
        AdmissionSetup.TESTFIELD("Customer Posting Group");
        CLEAR("StudentNo.");
        CLEAR(NoSeriesMgmt);
        "StudentNo." := NoSeriesMgmt.GetNextNo(AdmissionSetup."Student No.",0D,TRUE);
        
        Customer.VALIDATE("No.","StudentNo.");
        Customer.INSERT(TRUE);
          Customer.VALIDATE("Application No.",Application."No.");
          Customer.VALIDATE(Name,Application."Applicant Name");
          Customer.VALIDATE(Address,Application.Address1);
          Customer.VALIDATE("Address 2",Application.Address2);
          Customer.VALIDATE(City,Application.City);
          IF Application."Country Code" <> 'IN' THEN
            Customer.VALIDATE("State Code",'RAJ')
          ELSE
            Customer.VALIDATE("State Code",Application.State);
          Customer.VALIDATE("Phone No.",Application."Phone Number");
          Customer.VALIDATE("Country/Region Code",Application."Country Code");
          Customer.VALIDATE("E-Mail",Application."E-Mail Address");
          //Customer."Student Father Name":=Application."Father's Name";
          Customer.VALIDATE("Student Mother Name",Application."Mother's Name");
          //Customer."Date of Birth":=Application."Date of Birth";
          Customer.VALIDATE("Application No.",Application."No.");
          //Customer.VALIDATE("Course Code",Application."Programme Code");
          Customer.VALIDATE("Type Of Course",Application."Type Of Course");
          Customer.VALIDATE(Semester,Application.Semester);
          Customer.VALIDATE(Year,Application.Year);
          Customer.VALIDATE("Global Dimension 1 Code",Application."Global Dimension 1 Code");
          //Customer."Course Name":= Application."Course Name";
          //Customer.VALIDATE("Admited Year",Application."Admitted Year");
          Customer.VALIDATE("Academic Year",Application."Academic Year");
          //Customer.Session := Application.Session;
          //Customer."Programe Type":=Application."Programe Type";
          //Customer."User Id":=USERID();//
          //Customer."Creation Date Time":=CURRENTDATETIME;
          //Customer."Bypass Entry":=Application."Bypass Entry";
          //Customer."Bypass Date" :=Application."Bypass Date";
          Customer.VALIDATE(Quota,Application.Quota);
          //Customer.VALIDATE(Session,Application.Session);
          //Customer."Pay Type":=Application."Pay Type";
          Customer.VALIDATE("Global Dimension 2 Code",Application."Global Dimension 2 Code");
          Customer.VALIDATE("Gen. Bus. Posting Group",AdmissionSetup."Gen. Bus. Posting Group");
          Customer.VALIDATE("Customer Posting Group",AdmissionSetup."Customer Posting Group");
          Customer."Tax Liable":=TRUE;//Ram
          Customer."GST Customer Type":=Customer."GST Customer Type"::Unregistered;
          Customer."Hostel Accomadation" := Application."Hostel Allow";
          Customer."Transport Accomadation" := Application."Transport Allow";
          Customer.Gender := Application.Gender;
        Customer.Modify();
        
        recCustomer.Reset();
        recCustomer.SETRANGE("Application No.",Application."No.");
        IF recCustomer.FindFirst() THEN
          recCustomer."Global Dimension 1 Code":=Application."Global Dimension 1 Code";
          recCustomer.VALIDATE("Global Dimension 1 Code");
        recCustomer.Modify();
        
        Application1.GET(ApplNo);
        IF Application1.Spot OR Application1."Is Recommended" THEN BEGIN
          Application1."Application Selection" := TRUE;
          Application1."Rank Selection" := TRUE;
          Application1.Alloted := TRUE;
          Application1."Alloted Date":=TODAY();
          Application1.Spot:= TRUE;
          Application1."Call Letter Sent" := TRUE;
          Application1."Interview Attended" := TRUE;
          Application1."Interview Selected" := TRUE;
        END;
        Application1.Alloted := TRUE;
         Application1."Alloted Date":=TODAY();
        Application1."Registration Status":= Application1."Registration Status" :: Received;
        //Application1.Admitted := TRUE;                 Convert customer to student then true
        //Application1."Student No." := "StudentNo.";
        Application1.Modify();
        //IF (Application."Pay Type"<> Application."Pay Type"::Unpaid) THEN BEGIN
        {
        Student1.Reset();
        Student1.SETFILTER("No.","StudentNo.");
        FeeGeneration.USEREQUESTPAGE(FALSE);
        FeeGeneration.SetFeeType(CombineCode);
        FeeGeneration.SETTABLEVIEW(Student1);
        FeeGeneration.RUN;
        MESSAGE(Text0001Lbl,"StudentNo.");
        }
        
        
        Customer.Reset();
        Customer.SETFILTER("No.","StudentNo.");
        IF Customer.FINDFIRST()THEN BEGIN
          FeeGenerationCus.USEREQUESTPAGE(FALSE);
          //FeeGenerationCus.SetFeeType(CombineCode);
          FeeGenerationCus.SETTABLEVIEW(Customer);
          FeeGenerationCus.RUN;
          MESSAGE(Text0003Lbl,"StudentNo.");
        END;
        */
        //Code added for Student No Allocation No ::CSPL-00092::11-05-2019: End

    end;
}

