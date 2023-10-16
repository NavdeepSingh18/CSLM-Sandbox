page 50576 "Student Buffer List"
{

    PageType = API;
    SourceTable = "Student Buffer";
    Caption = 'Student Buffer List';
    EntityName = 'sT';
    EntitySetName = 'sT';
    DelayedInsert = true;
    UsageCategory = Administration;
    ApplicationArea = All;
    APIPublisher = 'sT01';
    APIGroup = 'sT';
    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field(digitID; Rec."18 Digit ID")
                {
                    ApplicationArea = All;
                }
                field("studentNo"; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("enrolmentNo"; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                field("emaiL"; Rec."E-mail")
                {
                    ApplicationArea = All;
                }
                field(statUs; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(parentstudentNo; Rec."Parent Student No.")
                {
                    ApplicationArea = all;
                }
                field("firstName"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("middleName"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("lastName"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("accountPersonType"; Rec."Account Person Type")
                {
                    ApplicationArea = All;
                }
                field("academicYear"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("admittedYear"; Rec."Admitted Year")
                {
                    ApplicationArea = All;
                }
                field(teRm; Rec.Term)
                {
                    ApplicationArea = all;
                }
                field("courseCode"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field(semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("alternateEmailAddress"; Rec."Alternate Email Address")
                {
                    ApplicationArea = All;
                }
                field(address1; Rec.Address1)
                {
                    ApplicationArea = All;
                }
                field(address2; Rec.Address2)
                {
                    ApplicationArea = All;
                }
                field(address3; Rec.Address3)
                {
                    ApplicationArea = All;
                }
                field(citY; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(postCode; Rec.Postcode)
                {
                    ApplicationArea = All;
                }
                field(staTe; Rec.State)
                {
                    ApplicationArea = All;
                }
                field("countryCode"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }
                field("countrycodePhone"; Rec."Country Code (Phone)")
                {
                    ApplicationArea = All;
                }
                field("phoneNo"; Rec."Phone No")
                {
                    ApplicationArea = All;
                }
                field(gendeR; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(nationalitY; Rec.Nationality)
                {
                    ApplicationArea = All;
                }

                field(citizenship; Rec.Citizenship)
                {
                    ApplicationArea = All;
                }
                field(ethnicitY; Rec.Ethnicity)
                {
                    ApplicationArea = All;
                }
                field(skyPe; Rec.Skype)
                {
                    ApplicationArea = All;
                }
                field("dateofBirth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field("dateOfJoining"; Rec."Date Of Joining")
                {
                    ApplicationArea = All;
                }


                field("fAFSAReceived"; Rec."FAFSA Received")
                {
                    ApplicationArea = All;
                }


                field("instituteCode"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("graduateGPA"; Rec."Graduate GPA")
                {
                    ApplicationArea = All;
                }
                field("highSchoolGPA"; Rec."High School GPA")
                {
                    ApplicationArea = All;
                }

                field("fatherName"; Rec."Father Name")
                {
                    ApplicationArea = All;
                }
                field("motherName"; Rec."Mother Name")
                {
                    ApplicationArea = All;
                }

                field("otherGPA"; Rec."Other GPA")
                {
                    ApplicationArea = All;
                }
                field("otherLeadSource"; Rec."Other Lead Source")
                {
                    ApplicationArea = All;
                }
                field("passportNo"; Rec."Passport No.")
                {
                    ApplicationArea = All;
                }
                field("nameonPassport"; Rec."Name on Passport")
                {
                    ApplicationArea = All;
                }

                field("passportIssuedBy"; Rec."Passport Issued By")
                {
                    ApplicationArea = All;
                }
                field("passportIssuedDate"; Rec."Passport Issued Date")
                {
                    ApplicationArea = All;
                }
                field("passportExpiryDate"; Rec."Passport Expiry Date")
                {
                    ApplicationArea = All;
                }

                field("permanentUsResident"; Rec."Permanent U.S. Resident")
                {
                    ApplicationArea = All;
                }
                field("personLeadSource"; Rec."Person Lead Source")
                {
                    ApplicationArea = All;
                }

                field("preReqGPA"; Rec."Pre-Req GPA")
                {
                    ApplicationArea = All;
                }
                field("primaryLeadSource"; Rec."Primary Lead Source")
                {
                    ApplicationArea = All;
                }
                field("residencyCity"; Rec."Residency City")
                {
                    ApplicationArea = All;
                }
                field("residencyHospital1"; Rec."Residency Hospital 1")
                {
                    ApplicationArea = All;
                }
                field("residencyHospital2"; Rec."Residency Hospital 2")
                {
                    ApplicationArea = All;
                }
                field("residencySpecialty1"; Rec."Residency Specialty 1")
                {
                    ApplicationArea = All;
                }
                field("residencySpecialty2"; Rec."Residency Specialty 2")
                {
                    ApplicationArea = All;
                }
                field("residencyState"; Rec."Residency State")
                {
                    ApplicationArea = All;
                }
                field("residencyStatus"; Rec."Residency Status")
                {
                    ApplicationArea = All;
                }
                field("residencyYear"; Rec."Residency Year")
                {
                    ApplicationArea = All;
                }

                field("scholarshipCode"; Rec."Scholarship Code 1")
                {
                    ApplicationArea = All;
                }
                field("grantCode1"; Rec."Grant Code 1")
                {
                    ApplicationArea = All;
                }
                field("grantCode2"; Rec."Grant Code 2")
                {
                    ApplicationArea = All;
                }
                field("grantCode3"; Rec."Grant Code 3")
                {
                    ApplicationArea = All;
                }
                field("schoolLevel"; Rec."School Level")
                {
                    ApplicationArea = All;
                }
                field("socialsecurItyNo"; Rec."Social Security No.")
                {
                    ApplicationArea = All;
                }

                field("transferGPA"; Rec."Transfer GPA")
                {
                    ApplicationArea = All;
                }
                field("transportRequired"; Rec."Transport Required")
                {
                    ApplicationArea = All;
                }

                field(yeAr; Rec.Year)
                {
                    ApplicationArea = All;
                }


                field("applicationID"; Rec."Application ID")
                {
                    ApplicationArea = All;
                }
                field("applicationType"; Rec."Application Type")
                {
                    ApplicationArea = All;
                }
                field("applicationSubtype"; Rec."Application Sub-type")
                {
                    ApplicationArea = All;
                }
                field("depositPaidDate"; Rec."Deposit Paid Date")
                {
                    ApplicationArea = All;
                }
                field("depositWaived"; Rec."Deposit Waived")
                {
                    ApplicationArea = All;
                }
                field(houSing; Rec.Housing)
                {
                    ApplicationArea = All;
                }
                field(housingwaiverapplicationNo; Rec."Housing/Waiver Application No.")
                {
                    ApplicationArea = All;
                }
                field("housingDepositDate"; Rec."Housing Deposit Date")
                {
                    ApplicationArea = All;
                }
                field(housingDepositwaived; Rec."Housing Deposit Waived")
                {
                    ApplicationArea = All;
                }
                field("seatDepositPaid"; Rec."Seat Deposit Paid")
                {
                    ApplicationArea = All;
                }
                field("studentAcceptedDate"; Rec."Student Accepted Date")
                {
                    ApplicationArea = All;
                }
                field("subStage"; Rec."Sub-Stage")
                {
                    ApplicationArea = All;
                }
                field(presentaddresS1; Rec."Present Address 1")
                {
                    ApplicationArea = All;
                }
                field(presentaddresS2; Rec."Present Address 2")
                {
                    ApplicationArea = All;
                }
                field(presentaddressS3; Rec."Present Address 3")
                {
                    ApplicationArea = All;
                }
                field(presentcitY; Rec."Present City")
                {
                    ApplicationArea = All;
                }
                field(presentpostcodE; Rec."Present Post Code")
                {
                    ApplicationArea = All;
                }
                field(presentstatE; Rec."Present State")
                {
                    ApplicationArea = All;
                }
                field(presentcountrY; Rec."Present Country")
                {
                    ApplicationArea = All;
                }
                field(leaseagreementnO; Rec."Lease Agreement No.")
                {
                    ApplicationArea = All;
                }
                field(leaseagreementgrouP; Rec."Lease Agreement Group")
                {
                    ApplicationArea = All;
                }

                field(tRansportCellNo; Rec."Transport Cell No.")
                {
                    ApplicationArea = All;
                }
                field(fLightArrDate; Rec."Flight Arrival Date")
                {
                    ApplicationArea = All;
                }
                field(fLightArrTime; Rec."Flight Arrival Time")
                {
                    ApplicationArea = All;
                }
                field(fLightNumber; Rec."Flight Number")
                {
                    ApplicationArea = All;
                }
                field(aIrlineCarrier; Rec."Airline/Carrier")
                {
                    ApplicationArea = All;
                }
                field(dEpartureDatefromAntigua; Rec."Departure Date from Antigua")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        RecStudentMaster: Record "Student Master-CS";
        StudMasterPrntStud: Record "Student Master-CS";

        RecStudentBuffer: Record "Student Buffer";
        RecEducationSetup: Record "Education Setup-CS";

        StudentStatus: Record "Student Status";
        //SD-SN-15-Dec-2020 +
        RecHousingApplication: Record "Housing Application";
        RecOptOut: Record "Opt Out";
        //NoSeriesMgt: codeunit NoSeriesManagement;
        HousingMailCod: Codeunit "Hosusing Mail";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenWebJnl: Codeunit "Gen. Web  Journal -CS";
        ApplicationType: Option "Bsic Opt Out","Housing Wavier","Make-Up","Restart","Appeal","Semester Registration";
        WaiverStatus: Option Open,"Pending for Approval",Approved,Rejected,Submit;
        // GenWebJnl: Codeunit "Gen. Web  Journal -CS";
        ReturnValue: Text[50];
        ExtraChar: Code[1];
        ToBeInserted: Integer;
    //SD-SN-15-Dec-2020 -


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        ToBeInserted := 0;
        If Rec."Global Dimension 1 Code" = '' then
            Error('Institute cannot be blank');
        if Rec."18 Digit ID" = '' then
            Error('18 Digit ID can not be blank');
        if Rec."Application ID" = '' then
            Error('"Application ID" cannot be blank');
        if Rec.Semester = '' then
            Error('Semester cannot be blank');
        if Rec."Course Code" = '' then
            Error('Course/Program cannot be blank');
        RecEducationSetup.Reset();
        RecEducationSetup.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        RecEducationSetup.FindFirst();


        if Rec."Parent Student No." <> '' then
            if not RecStudentMaster.Get(Rec."Parent Student No.") then
                Error('Parent Student No. %1 does not exist.', Rec."Parent Student No.");

        Rec."Entry Date" := Today();

        If Rec."Parent Student No." <> '' then begin
            RecStudentMaster.Reset();
            RecStudentMaster.SetRange("Parent Student No.", Rec."Parent Student No.");
            RecStudentMaster.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
            RecStudentMaster.SetRange("Course Code", Rec."Course Code");
            IF RecStudentMaster.FindFirst() then
                Error('Student : %1 is already present in the system.', RecStudentMaster."Original Student No.");
        end;

        IF Rec."Student No." <> '' then begin

            // StudentEthinicityInsert();
            RecStudentMaster.Get(Rec."Student No.");

            // if Housing = Housing::"AUA Housing" then begin
            //     RecHousingApplication.Reset();
            //     RecHousingApplication.SetRange("Student No.", "Student No.");
            //     RecHousingApplication.SetRange("Academic Year", "Academic Year");
            //     RecHousingApplication.SetRange(Semester, Semester);
            //     RecHousingApplication.SetRange(Term, Term);
            //     RecHousingApplication.SetFilter(Status, '%1|%2', RecHousingApplication.Status::Approved, RecHousingApplication.Status::Rejected);
            //     IF RecHousingApplication.FindFirst() then
            //         Error('Modification is not allowed as OLR E-Mail has been sent. Student can modify using OLR now onwards');
            // end
            // else
            // if Housing = Housing::"Independent Housing" then begin
            //     // RecOptOut.Reset();
            //     // RecOptOut.SetRange("Student No.", "Student No.");
            //     // RecOptOut.SetRange("Academic Year", "Academic Year");
            //     // RecOptOut.SetRange(Semester, Semester);
            //     // RecOptOut.SetRange(Term, Term);
            //     // RecOptOut.Setrange("Application Type", RecOptOut."Application Type"::"Housing Wavier");
            //     // RecOptOut.setfilter(Status, '%1|%2', RecOptOut.Status::Approved, RecOptOut.Status::Rejected);
            //     // IF RecOptOut.FindFirst() then
            //     //     Error('Modification is not allowed as OLR E-Mail has been sent. Student can modify using OLR now onwards');
            // end;

            if RecStudentMaster."18 Digit ID" <> Rec."18 Digit ID" then
                Error('"18 Digit ID" does not match with the "Student No."');

            // commonfieldModify();//arv
            RecStudentMaster.Modify(True);//arv
            //HousingWaiverInsertModify();//arv//GMCSCOM
            RecStudentMaster.Modify(True);//arv

            // Error('5    %1', "Housing/Waiver Application No.");
        end else
            IF Rec."Student No." = '' then begin

                RecEducationSetup.TESTFIELD("Student No.");

                If Rec."E-mail" <> '' then
                    Error('E-Mail address must be blank');
                if Rec."Enrolment No." <> '' then
                    Error('Enrolment No. must be blank');
                if Rec.Status <> 0 then
                    Error('Status must be blank');
                if Rec."Parent Student No." = '' then begin
                    RecStudentMaster.reset();
                    RecStudentMaster.SetRange("18 Digit ID", Rec."18 Digit ID");
                    RecStudentMaster.SetFilter("Parent Student No.", '<>%1', '');
                    if RecStudentMaster.FindFirst() then
                        Error('"18 Digit ID" %1 is already assigned to Student No. %2', Rec."18 Digit ID", RecStudentMaster."No.");

                    //if RecStudentMaster."Enrollment No." <> '' then
                    // Error('18 digit %1..', "Student No.");

                    RecStudentMaster.reset();
                    RecStudentMaster.SetRange("18 Digit ID", Rec."18 Digit ID");
                    RecStudentMaster.SetFilter("Parent Student No.", '%1', '');
                    if RecStudentMaster.FindFirst() then begin

                        ToBeInserted := 2;
                        //commonfieldModify();//GMCSCOM
                        RecStudentMaster.Modify(True);//arv
                                                      // HousingWaiverInsertModify();
                                                      // Error('End');
                        Rec."Student No." := RecStudentMaster."No.";
                        Rec."Enrolment No." := RecStudentMaster."Enrollment No.";
                        Rec."E-mail" := RecStudentMaster."E-Mail Address";
                        // Error('18 digit %1..%2', "Student No.", "Enrolment No.");
                        //GetStudentStatusOption();//GMCSCOM
                        Rec.Status := StudentStatus.Status;
                        RecStudentMaster.Modify(True);
                    end
                    else
                        ToBeInserted := 1;

                    // if RecStudentMaster."Enrollment No." <> '' then
                    //     Error(RecStudentMaster."Enrollment No.");

                    // Error('18 Digit %1', "18 Digit ID");
                    // RecStudentMaster.Reset();
                    // RecStudentMaster.SetRange("18 Digit ID", "18 Digit ID");
                    // // RecStudentMaster.SetFilter("Parent Student No.", '%1', '');
                    // if RecStudentMaster.FindFirst() then begin
                    //     if RecStudentMaster."Enrollment No." <> '' then
                    //         Error('18 Digit %1', "18 Digit ID");
                    //     ToBeInserted := 2;
                    //     commonfieldModify();
                    //     HousingWaiverInsertModify();

                    //     "Student No." := RecStudentMaster."No.";
                    //     "Enrolment No." := RecStudentMaster."Enrollment No.";
                    //     "E-mail" := RecStudentMaster."E-Mail Address";

                    //     GetStudentStatusOption();
                    //     Status := StudentStatus.Status;
                    //     RecStudentMaster.Modify(True);
                    // end;


                    if ToBeInserted = 1 then begin
                        // Code transferred to Job Queue - Start
                        // CommonFieldInsert();
                        // HousingWaiverInsertModify();
                        // RecStudentMaster.Modify(True);
                        // Code transferred to Job Queue - End
                    end;
                end
                else begin
                    RecStudentMaster.reset();
                    RecStudentMaster.SetRange("18 Digit ID", Rec."18 Digit ID");
                    RecStudentMaster.SetRange("Parent Student No.", Rec."Parent Student No.");
                    if RecStudentMaster.FindFirst() then begin
                        ToBeInserted := 2;
                        //commonfieldModify();//GMCSCOM
                        //HousingWaiverInsertModify();//GMCSCOM

                        Rec."Student No." := RecStudentMaster."No.";
                        Rec."Enrolment No." := RecStudentMaster."Enrollment No.";
                        Rec."E-mail" := RecStudentMaster."E-Mail Address";
                        //GetStudentStatusOption();//GMCSCOM
                        Rec.Status := StudentStatus.Status;
                        RecStudentMaster.Modify(True);
                    end
                    else
                        ToBeInserted := 1;

                    if ToBeInserted = 1 then begin
                        // Code transferred to Job Queue - Start
                        // CommonFieldInsert();
                        // HousingWaiverInsertModify();
                        // RecStudentMaster.Modify(True);
                        // Code transferred to Job Queue - End
                    end;
                end;

            end;
        if Rec."Student No." <> '' then begin
            RecStudentBuffer.Reset();
            RecStudentBuffer.SetRange("Student No.", Rec."Student No.");
            if RecStudentBuffer.FindLast() then
                Rec."Line No." := RecStudentBuffer."Line No." + 10000
            Else
                Rec."Line No." := 10000;
            Rec."Student Created" := true;
        end
        else
            Rec."Line No." := 10000;


    end;

    // local procedure CommonFieldInsert()
    // begin
    //     RecStudentMaster.Reset();
    //     RecStudentMaster.Init();
    //     commonfieldModify();
    //     RecStudentMaster.Validate("18 Digit ID", "18 Digit ID");
    //     ExtraChar := '';
    //     if "Parent Student No." <> '' then begin
    //         RecStudentMaster.Validate("Enrollment Order", CreateStudentNo("Parent Student No.", ExtraChar));
    //         RecStudentMaster.Validate("No.", ("Parent Student No." + ExtraChar));
    //         RecStudentMaster.validate("Original Student No.", "Parent Student No.");
    //     end
    //     else begin
    //         RecStudentMaster.Validate("No.", NoSeriesMgt.GetNextNo(RecEducationSetup."Student No.", 0D, TRUE));
    //         RecStudentMaster.validate("Original Student No.", RecStudentMaster."No.");
    //         RecStudentMaster.Validate("Enrollment Order", 1);
    //     end;
    //     RecStudentMaster."New Student" := True;
    //     IF RecStudentMaster.Insert() then begin
    //         RecStudentMaster.Validate("Parent Student No.", "Parent Student No.");
    //         RecStudentMaster."Creation Date" := Today();
    //         RecStudentMaster."Created By" := Userid();
    //         RecStudentMaster."User ID" := FORMAT(UserId());
    //         RecStudentMaster."Updated On" := TODAY();
    //         RecStudentMaster."Updated By" := FORMAT(UserId());
    //         RecStudentMaster."Mobile Insert" := TRUE;
    //         RecStudentMaster."Entry From Salesforce" := true;
    //         RecStudentMaster.Validate("Course Code", "Course Code");


    //         "Entry From Salesforce" := true;
    //         "Student No." := RecStudentMaster."No.";
    //         "Enrolment No." := RecStudentMaster."Enrollment No.";
    //         "E-mail" := RecStudentMaster."E-Mail Address";
    //         GetStudentStatusOption();
    //         Status := StudentStatus.Status;
    //     end;
    // End;
    /*
        local procedure commonfieldModify()
        Var
            Month: Integer;
            YearInt: Integer;
            Day: Integer;
        begin

            RecStudentMaster.Validate("First Name", Rec."First Name");
            RecStudentMaster.Validate("Middle Name", Rec."Middle Name");
            RecStudentMaster.Validate("Last Name", Rec."Last Name");
            RecStudentMaster.Validate("Alternate Email Address", Rec."Alternate Email Address");
            RecStudentMaster.Validate("Account Person Type", Rec."Account Person Type");
            recStudentMaster.Validate("School Level", Rec."School Level");
            RecStudentMaster.Validate("Country Code (Phone)", Rec."Country Code (Phone)");

            RecStudentMaster.Validate(Citizenship, Rec.Citizenship);
            RecStudentMaster.Validate(Ethnicity, Rec.Ethnicity);
            RecStudentMaster.Validate(Gender, Rec.Gender);
            RecStudentMaster.Validate("Graduate GPA", Rec."Graduate GPA");
            RecStudentMaster.Validate("High School GPA", Rec."High School GPA");
            RecStudentMaster.Validate("Phone Number", Rec."Phone No");
            RecStudentMaster.Validate("Name on Passport", Rec."Name on Passport");
            RecStudentMaster.Validate("Other GPA", Rec."Other GPA");
            Clear(Day);
            Clear(Month);
            Clear(YearInt);
            If Rec."Passport Expiry Date" <> 0D then begin
                Day := Date2DMY("Passport Expiry Date", 1);
                Month := Date2DMY("Passport Expiry Date", 2);
                YearInt := Date2DMY("Passport Expiry Date", 3);
                RecStudentMaster.Validate("Pass Port Expiry Date", DMY2Date(Day, month, YearInt));
            end;
            RecStudentMaster.Validate("Pass Port Issued By", Rec."Passport Issued By");
            Clear(Day);
            Clear(Month);
            Clear(YearInt);
            If Rec."Passport Expiry Date" <> 0D then begin
                Day := Date2DMY("Passport Expiry Date", 1);
                Month := Date2DMY("Passport Expiry Date", 2);
                YearInt := Date2DMY("Passport Expiry Date", 3);
                RecStudentMaster.Validate("Pass Port Expiry Date", DMY2Date(Day, month, YearInt));
            end;
            RecStudentMaster.Validate("Pass Port No.", Rec."Passport No.");
            RecStudentMaster.Validate("Permanent U.S. Resident", Rec."Permanent U.S. Resident");

            Clear(Day);
            Clear(Month);
            Clear(YearInt);
            IF Rec."Date of Birth" <> 0D then begin
                Day := Date2DMY("Date of Birth", 1);
                Month := Date2DMY("Date of Birth", 2);
                YearInt := Date2DMY("Date of Birth", 3);
                RecStudentMaster.Validate("Date of Birth", DMY2Date(Day, Month, YearInt));
            end;

            RecStudentMaster.Validate("Person Lead Source", "Person Lead Source");
            RecStudentMaster.Validate(Addressee, Rec.Address1);
            RecStudentMaster.Validate(Address1, Rec.Address2);
            RecStudentMaster.Validate(Address2, Rec.Address3);
            // if (Postcode <> '') or (City <> '') then
            //     GenWebJnl.CreatePostCode(Postcode, Rec.City, Rec.State, Rec."Country Code");
            RecStudentMaster.Validate("Post Code", Rec.Postcode);
            RecStudentMaster.Validate(City, Rec.City);
            RecStudentMaster.Validate("Country Code", Rec."Country Code");
            RecStudentMaster.Validate(State, Rec.State);

            RecStudentMaster.Validate("Pre-Req GPA", Rec."Pre-Req GPA");
            RecStudentMaster.Validate("Primary Lead Source", Rec."Primary Lead Source");
            RecStudentMaster.Validate(Skype, Rec.Skype);
            RecStudentMaster.Validate("Transfer GPA", Rec."Transfer GPA");
            RecStudentMaster.Validate("FAFSA Received", Rec."FAFSA Received");
            RecStudentMaster.Validate("Residency Hospital 1", Rec."Residency Hospital 1");
            RecStudentMaster.Validate("Residency Hospital 2", Rec."Residency Hospital 2");
            RecStudentMaster.Validate("Residency Status", Rec."Residency Status");
            RecStudentMaster.Validate("Residency City", Rec."Residency City");
            RecStudentMaster.Validate("Residency Specialty 1", Rec."Residency Specialty 1");
            RecStudentMaster.Validate("Residency Specialty 2", Rec."Residency Specialty 2");
            RecStudentMaster.Validate("Residency State", Rec."Residency State");
            RecStudentMaster.Validate("Residency Year", Rec."Residency Year");
            RecStudentMaster.Validate(Nationality, Rec.Nationality);
            RecStudentMaster.Validate("Academic Year", Rec."Academic Year");
            RecStudentMaster.Validate("Admitted Year", Rec."Admitted Year");
            RecStudentMaster.Validate(Term, Rec.Term);
            RecStudentMaster.Validate(Semester, Rec.Semester);

            Clear(Day);
            Clear(Month);
            Clear(YearInt);
            IF Rec."Date Of Joining" <> 0D then begin
                Day := Date2DMY("Date of Joining", 1);
                Month := Date2DMY("Date of Joining", 2);
                YearInt := Date2DMY("Date of Joining", 3);
                RecStudentMaster.Validate("Date of Joining", DMY2Date(Day, Month, YearInt));
            end;
            RecStudentMaster.Validate("Other Lead Source", Rec."Other Lead Source");
            Rec.TestField("Global Dimension 1 Code");
            RecStudentMaster.Validate("Global Dimension 1 Code", Rec.RecEducationSetup."Global Dimension 1 Code");
            RecStudentMaster.Validate("Fathers Name", Rec."Father Name");
            RecStudentMaster.Validate("Mothers Name", Rec."Mother Name");
            RecStudentMaster.Validate(Year, Rec.Year);
            RecStudentMaster."Transport Allot" := "Transport Required";

            Clear(Day);
            Clear(Month);
            Clear(YearInt);
            IF Rec."Flight Arrival Date" <> 0D then begin
                Day := Date2DMY("Flight Arrival Date", 1);
                Month := Date2DMY("Flight Arrival Date", 2);
                YearInt := Date2DMY("Flight Arrival Date", 3);
                RecStudentMaster."Flight Arrival Date" := DMY2Date(Day, Month, YearInt);
            end;
            RecStudentMaster."Flight Arrival Time" := Rec."Flight Arrival Time";
            RecStudentMaster."Flight Number" := Rec."Flight Number";
            RecStudentMaster."Airline/Carrier" := Rec."Airline/Carrier";
            Clear(Day);
            Clear(Month);
            Clear(YearInt);
            IF "Departure Date from Antigua" <> 0D then begin
                Day := Date2DMY("Departure Date from Antigua", 1);
                Month := Date2DMY("Departure Date from Antigua", 2);
                YearInt := Date2DMY("Departure Date from Antigua", 3);
                RecStudentMaster."Departure Date from Antigua" := DMY2Date(Day, Month, YearInt);
            end;
            if RecStudentMaster."Scholarship Source" <> "Scholarship Code 1" then
                RecStudentMaster.Validate("Scholarship Source", "Scholarship Code 1");
            if RecStudentMaster."Grant Code 1" <> "Grant Code 1" then
                RecStudentMaster.Validate("Grant Code 1", "Grant Code 1");
            if RecStudentMaster."Grant Code 2" <> "Grant Code 2" then
                RecStudentMaster.Validate("Grant Code 2", "Grant Code 2");
            if RecStudentMaster."Grant Code 3" <> "Grant Code 3" then
                RecStudentMaster.Validate("Grant Code 3", "Grant Code 3");
            RecStudentMaster.Validate("Social Security No.", "Social Security No.");
            RecStudentMaster.Validate("Global Dimension 2 Code", "Global Dimension 2 Code");

            RecStudentMaster.validate("Application No.", "Application ID");
            RecStudentMaster.Validate("Application Type", "Application Type");
            RecStudentMaster.validate("Application Sub-type", "Application Sub-type");

            Clear(Day);
            Clear(Month);
            Clear(YearInt);
            IF "Deposit Paid Date" <> 0D then begin
                Day := Date2DMY("Deposit Paid Date", 1);
                Month := Date2DMY("Deposit Paid Date", 2);
                YearInt := Date2DMY("Deposit Paid Date", 3);
                RecStudentMaster.validate("Deposit Paid Date", DMY2Date(Day, Month, YearInt));
            end;
            RecStudentMaster.validate("Deposit Waived", "Deposit Waived");
            RecStudentMaster.validate("Housing Deposit Date", "Housing Deposit Date");

            RecStudentMaster.Validate("Housing Deposit Waived", "Housing Deposit Waived");
            Clear(Day);
            Clear(Month);
            Clear(YearInt);
            IF "Student Accepted Date" <> 0D then begin
                Day := Date2DMY("Student Accepted Date", 1);
                Month := Date2DMY("Student Accepted Date", 2);
                YearInt := Date2DMY("Student Accepted Date", 3);
                RecStudentMaster.validate("Student Accepted Date", DMY2Date(Day, Month, YearInt));
            end;
            RecStudentMaster.validate("Sub-Stage", "Sub-Stage");
            RecStudentMaster.validate(Housing, Housing);

            RecStudentMaster.validate("Seat Deposit Paid", "Seat Deposit Paid");

        end;

        procedure HousingWaiverInsertModify()
        var
            OptOut2: record "Opt Out";
        begin
            if Housing = Housing::"Independent Housing" then begin
                if "Housing/Waiver Application No." = '' then begin

                    RecHousingApplication.Reset();
                    RecHousingApplication.SetRange("Student No.", "Student No.");
                    RecHousingApplication.SetRange("Academic Year", "Academic Year");
                    RecHousingApplication.SetRange(Semester, Semester);
                    RecHousingApplication.SetRange(Term, Term);
                    RecHousingApplication.Setfilter(Status, '%1|%2', RecHousingApplication.Status::"Pending for Approval", RecHousingApplication.Status::Approved);
                    IF RecHousingApplication.FindFirst() then
                        Error('Housing Waiver application cannot be created as Housing Application No. %1 already exists for this Student', RecHousingApplication."Application No.");

                    RecOptOut.Reset();
                    RecOptOut.SetRange("Student No.", "Student No.");
                    RecOptOut.SetRange("Academic Year", "Academic Year");
                    RecOptOut.SetRange(Semester, Semester);
                    RecOptOut.SetRange(Term, Term);
                    RecOptOut.Setrange("Application Type", RecOptOut."Application Type"::"Housing Wavier");
                    RecOptOut.setfilter(Status, '<>%1', RecOptOut.Status::Rejected);
                    IF RecOptOut.FindFirst() then
                        if ToBeInserted <> 2 then
                            Error('Housing Waiver Application No. %1 already exists for this Student', RecOptOut."Application No.")
                        else
                            "Housing/Waiver Application No." := RecOptOut."Application No.";


                    RecStudentMaster.Address3 := "Present Address 1";

                    RecStudentMaster.Address4 := "Present Address 2";
                    RecStudentMaster."Address To" := "Present Address 3";
                    // if ("Present Post Code" <> '') or ("Present City" <> '') then
                    //     GenWebJnl.CreatePostCode("Present Post Code", "Present City", "Present State", "Present Country");
                    RecStudentMaster."Cor Post Code" := "Present Post Code";
                    RecStudentMaster."Cor City" := "Present City";
                    RecStudentMaster."Cor Country Code" := "Present Country";
                    RecStudentMaster."Cor State" := "Present State";

                    RecStudentMaster."Lease Agreement/Contract No." := "Lease Agreement No.";
                    RecStudentMaster."Lease Agreement Group" := "Lease Agreement Group";
                    RecStudentMaster."Transport Allot" := "Transport Required";
                    RecStudentMaster."Transport Cell" := "Transport Cell No.";
                    //Error('3   %1', ToBeInserted);
                    //if ToBeInserted <> 2 then begin
                    ReturnValue := HousingMailCod.WebAPIHousingWavierInsert(RecStudentMaster."No.", ApplicationType::"Housing Wavier",
                    "Present Address 1", "Present Address 2", "Present Address 3", "Lease Agreement No.", "Lease Agreement Group",
                    RecStudentMaster."Transport Allot", RecStudentMaster."Transport Cell", "Present Post Code",
                    "Present City", "Present Country", "Present State", WaiverStatus::"Pending for Approval", true, Rec."Academic Year", Rec.Semester, Rec.Term);

                    if CopyStr(ReturnValue, 1, 7) = 'Success' then begin
                        OptOut2.Reset();
                        OptOut2.SetRange("Application No.", CopyStr(ReturnValue, 9, 20));
                        OptOut2.SetRange("Application Type", OptOut2."Application Type"::"Housing Wavier");
                        OptOut2.SetRange("Academic Year", "Academic Year");
                        OptOut2.SetRange(Semester, Semester);
                        OptOut2.SetRange(Term, Term);
                        OptOut2.setfilter(Status, '<>%1', RecOptOut.Status::Rejected);
                        //OptOut2.SetRange(Status, OptOut2.Status::Approved);
                        if OptOut2.FindFirst() then begin
                            "Housing/Waiver Application No." := CopyStr(ReturnValue, 9, 20);
                        end;
                    end
                    else
                        Error('Could not Insert the Housing Waiver Application');
                    RecStudentMaster.validate("Housing/Waiver Application No.", "Housing/Waiver Application No.");
                    // end;

                end
                else begin

                    RecOptOut.Reset();
                    RecOptOut.SetRange("Application No.", "Housing/Waiver Application No.");
                    RecOptOut.SetRange("Student No.", "Student No.");
                    RecOptOut.SetRange("Academic Year", "Academic Year");
                    RecOptOut.SetRange(Semester, Semester);
                    RecOptOut.SetRange(Term, Term);
                    RecOptOut.Setrange("Application Type", RecOptOut."Application Type"::"Housing Wavier");
                    RecOptOut.setfilter(Status, '%1', RecOptOut.Status::"Pending for Approval");
                    IF RecOptOut.FindFirst() then begin
                        RecStudentMaster.Address3 := "Present Address 1";
                        RecStudentMaster.Address4 := "Present Address 2";
                        RecStudentMaster."Address To" := "Present Address 3";
                        RecStudentMaster."Cor Post Code" := "Present Post Code";
                        RecStudentMaster."Cor City" := "Present City";
                        RecStudentMaster."Cor State" := "Present State";
                        RecStudentMaster."Cor Country Code" := "Present Country";
                        RecStudentMaster."Lease Agreement/Contract No." := "Lease Agreement No.";
                        RecStudentMaster."Lease Agreement Group" := "Lease Agreement Group";

                        RecStudentMaster."Transport Cell" := "Transport Cell No.";

                        RecOptOut."Present Address1" := "Present Address 1";
                        RecOptOut."Present Address2" := "Present Address 2";
                        RecOptOut."Present Address3" := "Present Address 3";
                        RecOptOut.city := "Present City";
                        RecOptOut.Country := "Present Country";
                        RecOptOut.County := "Present State";
                        RecOptOut."Post Code" := "Present Post Code";
                        RecOptOut."Lease Agreement Group" := "Lease Agreement Group";
                        RecOptOut."Lease Agreement/Contract No." := "Lease Agreement No.";

                        RecOptOut."Transport Cell" := "Transport Cell No.";
                        Recoptout.modify(true);

                    end;
                end;
            end
            else
                if Housing = Housing::"AUA Housing" then begin
                    if "Housing/Waiver Application No." = '' then begin
                        RecOptOut.Reset();
                        RecOptOut.SetRange("Student No.", RecStudentMaster."No.");
                        RecOptOut.SetRange("Academic Year", RecStudentMaster."Academic Year");
                        RecOptOut.SetRange(Semester, RecStudentMaster.Semester);
                        RecOptOut.SetRange(Term, RecStudentMaster.Term);
                        RecOptOut.Setrange("Application Type", RecOptOut."Application Type"::"Housing Wavier");
                        RecOptOut.setfilter(Status, '<>%1', RecOptOut.Status::Rejected);
                        IF RecOptOut.FindFirst() then
                            Error('Housing Application cannot be created as Housing Waiver Application No. %1 already exists for this Student', RecOptOut."Application No.");

                        RecHousingApplication.Reset();
                        RecHousingApplication.SetRange("Student No.", RecStudentMaster."No.");
                        RecHousingApplication.SetRange("Academic Year", RecStudentMaster."Academic Year");
                        RecHousingApplication.SetRange(Semester, RecStudentMaster.Semester);
                        RecHousingApplication.SetRange(Term, RecStudentMaster.Term);
                        RecHousingApplication.Setfilter(Status, '%1|%2', RecHousingApplication.Status::"Pending for Approval", RecHousingApplication.Status::Approved);
                        IF RecHousingApplication.FindFirst() then
                            if ToBeInserted <> 2 then
                                Error('Housing Application No. %1 already exists for this Student', RecHousingApplication."Application No.")
                            else
                                "Housing/Waiver Application No." := RecHousingApplication."Application No.";

                        if ToBeInserted <> 2 then begin
                            ReturnValue := HousingMailCod.SalesforceHousingApplicationInsert(RecStudentMaster."No.", false, '', '', '', '', '', '', '', '', '', '', '', '', true, "Housing Deposit Date", "Flight Arrival Date", "Flight Arrival Time"
                            , "Flight Number", "Airline/Carrier", "Departure Date from Antigua", Rec."Academic Year", Rec.Semester, Rec.Term, false, false, False, False, false, false, '', '');

                            if CopyStr(ReturnValue, 1, 7) = 'Success' then
                                "Housing/Waiver Application No." := CopyStr(ReturnValue, 9, 20)
                            else
                                Error('Could not Insert the Housing Application');
                            RecStudentMaster.validate("Housing/Waiver Application No.", "Housing/Waiver Application No.");
                        end;
                    end
                    else
                        HousingApplicationUpdate();

                end;

        end;

        procedure GetStudentStatusOption()
        begin
            StudentStatus.Reset();
            if StudentStatus.Get(RecStudentMaster.Status, RecStudentMaster."Global Dimension 1 Code") then;
        end;

        procedure CreateStudentNo(OriginalStudentNo: Code[20]; Rec.var pExtraChar: code[1]): Integer
        var
            TotalStud: Integer;
        begin
            pExtraChar := '';
            StudMasterPrntStud.Reset();
            StudMasterPrntStud.SetRange("Original Student No.", OriginalStudentNo);
            TotalStud := StudMasterPrntStud.count();
            if TotalStud > 0 then begin
                pExtraChar := StudMasterPrntStud.ExtraCharCalc(TotalStud + 1);
                Exit(TotalStud + 1);
            end
            else
                Error('"Parent Student No." %1 does not exist', OriginalStudentNo);
        end;

        Procedure StudentEthinicityInsert()
        Var
            StudentEthinicity_lRec: Record "Student Ethnicity";
        begin
            If Ethnicity <> '' then begin
                StudentEthinicity_lRec.Reset();
                StudentEthinicity_lRec.SetRange("Ethnicity Code", Rec.Ethnicity);
                StudentEthinicity_lRec.Setrange("Student No.", Rec."Student No.");
                If not StudentEthinicity_lRec.FindFirst() then begin
                    StudentEthinicity_lRec.Init();
                    StudentEthinicity_lRec.Validate("Ethnicity Code", Rec.Ethnicity);
                    StudentEthinicity_lRec.Validate("Student No.", Rec."Student No.");
                    StudentEthinicity_lRec.Insert(True);
                end;
            end;
        end;

        procedure HousingApplicationUpdate()
        var
            RecHousingApplication: Record "Housing Application";
        begin
            RecHousingApplication.Reset();
            RecHousingApplication.SetRange("Student No.", "Student No.");
            RecHousingApplication.SetRange("Academic Year", "Academic Year");
            RecHousingApplication.SetRange(Semester, Semester);
            RecHousingApplication.SetRange(Term, Term);
            RecHousingApplication.SetRange(Status, RecHousingApplication.Status::"Pending for Approval");
            IF RecHousingApplication.FindFirst() then begin
                RecHousingApplication."Flight Arrival Date" := "Flight Arrival Date";
                RecHousingApplication."Flight Arrival Time" := "Flight Arrival Time";
                RecHousingApplication."Flight Number" := "Flight Number";
                RecHousingApplication."Airline/Carrier" := "Airline/Carrier";
                RecHousingApplication."Departure Date from Antigua" := "Departure Date from Antigua";
                RecHousingApplication.Modify();
            end;

        end;

        // For Job Queue - Start

        // For Job Queue - End
        */

}