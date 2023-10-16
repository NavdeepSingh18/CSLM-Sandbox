codeunit 50001 SFStudentCreationAuto
{
    trigger OnRun()
    begin
        SFStudentCreation();
    end;

    procedure SFStudentCreation()
    var
        StudBuffer: Record "Student Buffer";
    begin
        StudBuffer.Reset();
        StudBuffer.SetRange("Student Created", false);
        //StudBuffer.SetFilter("18 Digit ID", '=%1', '0062M00000nML1FQAW');
        if StudBuffer.FindSet() then
            repeat
                CommonFieldInsert(StudBuffer);
            // StudBuffer.Modify();
            until StudBuffer.Next() = 0;

    end;

    procedure CommonFieldInsert(var StudBuff: Record "Student Buffer")
    var
        RecStudentMaster: Record "Student Master-CS";
        PortalUserLoginCS: Record "Portal User Login-CS";
        GenWebJournal: Codeunit "Gen. Web  Journal -CS";
        WebServFunc: Codeunit WebServicesFunctionsCSL;
        ExtraChar: Code[1];
    begin
        RecEducationSetup.Reset();
        RecEducationSetup.FindFirst();
        RecStudentMaster.Reset();
        RecStudentMaster.Setrange("18 Digit ID", StudBuff."18 Digit ID");
        IF not RecStudentMaster.FindFirst() then begin
            RecStudentMaster.Init();
            commonfieldModify(RecStudentMaster, StudBuff);
            RecStudentMaster.Validate("18 Digit ID", StudBuff."18 Digit ID");
            ExtraChar := '';
            if StudBuff."Parent Student No." <> '' then begin
                RecStudentMaster.Validate("Enrollment Order", CreateStudentNo(StudBuff."Parent Student No.", ExtraChar));
                RecStudentMaster.Validate("No.", (StudBuff."Parent Student No." + ExtraChar));
                RecStudentMaster.validate("Original Student No.", StudBuff."Parent Student No.");
            end
            else begin
                RecStudentMaster.Validate("No.", NoSeriesMgt.GetNextNo(RecEducationSetup."Student No.", 0D, TRUE));
                RecStudentMaster.validate("Original Student No.", RecStudentMaster."No.");
                RecStudentMaster.Validate("Enrollment Order", 1);
            end;
            RecStudentMaster."New Student" := True;
            IF RecStudentMaster.Insert() then begin
                RecStudentMaster.Validate("Parent Student No.", StudBuff."Parent Student No.");
                RecStudentMaster."Creation Date" := Today();
                RecStudentMaster."Created By" := Userid();
                RecStudentMaster."User ID" := FORMAT(UserId());
                RecStudentMaster."Updated On" := TODAY();
                RecStudentMaster."Updated By" := FORMAT(UserId());
                RecStudentMaster."Mobile Insert" := TRUE;
                RecStudentMaster."Entry From Salesforce" := true;
                RecStudentMaster.Validate("Course Code", StudBuff."Course Code");

                IF RecStudentMaster."E-Mail Address" = '' then begin
                    //Student_EmailCreation
                    WebServFunc.StudentEmailCreation(RecStudentMaster, 0);
                    PortalUserLoginCS.Reset();
                    PortalUserLoginCS.SetRange(U_ID, RecStudentMaster."No.");
                    PortalUserLoginCS.FindFirst();
                    RecStudentMaster.TestField("E-Mail Address");
                    PortalUserLoginCS.TestField("Login ID");
                    RecStudentMaster.TestField(Password);
                    GenWebJournal.StudentMissingFieldToSF(RecStudentMaster."No.", PortalUserLoginCS."Login ID", RecStudentMaster."E-Mail Address", RecStudentMaster.Password);
                end;

                StudBuff."Entry From Salesforce" := true;
                StudBuff."Student No." := RecStudentMaster."No.";
                StudBuff."Enrolment No." := RecStudentMaster."Enrollment No.";
                StudBuff."E-mail" := RecStudentMaster."E-Mail Address";
                GetStudentStatusOption(RecStudentMaster);
                StudBuff.Status := StudentStatus.Status;
                StudBuff."Student Created" := true;

                StudBuff.Modify();
                RecStudentMaster.Modify(true);

                HousingWaiverInsertModify(StudBuff, RecStudentMaster);
            end;
        end ELSE begin
            RecStudentMaster.Validate("Parent Student No.", StudBuff."Parent Student No.");
            RecStudentMaster."Creation Date" := Today();
            RecStudentMaster."Created By" := Userid();
            RecStudentMaster."User ID" := FORMAT(UserId());
            RecStudentMaster."Updated On" := TODAY();
            RecStudentMaster."Updated By" := FORMAT(UserId());
            RecStudentMaster."Mobile Insert" := TRUE;
            RecStudentMaster."Entry From Salesforce" := true;
            IF RecStudentMaster."Course Code" = '' then
                RecStudentMaster.Validate("Course Code", StudBuff."Course Code");

            StudBuff."Entry From Salesforce" := true;
            StudBuff."Student No." := RecStudentMaster."No.";
            StudBuff."Enrolment No." := RecStudentMaster."Enrollment No.";
            StudBuff."E-mail" := RecStudentMaster."E-Mail Address";
            GetStudentStatusOption(RecStudentMaster);
            StudBuff.Status := StudentStatus.Status;
            StudBuff."Student Created" := true;
            StudBuff.Modify();
            RecStudentMaster.Modify(true);

            HousingWaiverInsertModify(StudBuff, RecStudentMaster);
        end;


        //StudBuff."Student No." := RecStudentMaster."No.";

    End;

    procedure CreateStudentNo(OriginalStudentNo: Code[20]; var pExtraChar: code[1]): Integer
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

    procedure GetStudentStatusOption(Stud: Record "Student Master-CS")
    begin
        StudentStatus.Reset();
        StudentStatus.Get(Stud.Status, Stud."Global Dimension 1 Code");
    end;

    local procedure commonfieldModify(var RecStudentMaster: Record "Student Master-CS"; var StudBuff: Record "Student Buffer")
    Var
        Month: Integer;
        Year: Integer;
        Day: Integer;
    begin
        RecStudentMaster.Validate("First Name", StudBuff."First Name");
        RecStudentMaster.Validate("Middle Name", StudBuff."Middle Name");
        RecStudentMaster.Validate("Last Name", StudBuff."Last Name");
        RecStudentMaster.Validate("Alternate Email Address", StudBuff."Alternate Email Address");
        RecStudentMaster.Validate("Account Person Type", StudBuff."Account Person Type");
        recStudentMaster.Validate("School Level", StudBuff."School Level");
        RecStudentMaster.Validate("Country Code (Phone)", StudBuff."Country Code (Phone)");

        RecStudentMaster.Validate(Citizenship, StudBuff.Citizenship);
        // RecStudentMaster.Validate(Ethnicity, StudBuff.Ethnicity);
        RecStudentMaster.Validate(Gender, StudBuff.Gender);
        RecStudentMaster.Validate("Graduate GPA", StudBuff."Graduate GPA");
        RecStudentMaster.Validate("High School GPA", StudBuff."High School GPA");
        RecStudentMaster.Validate("Phone Number", StudBuff."Phone No");
        RecStudentMaster.Validate("Name on Passport", StudBuff."Name on Passport");
        RecStudentMaster.Validate("Other GPA", StudBuff."Other GPA");
        Clear(Day);
        Clear(Month);
        Clear(Year);
        If StudBuff."Passport Expiry Date" <> 0D then begin
            Day := Date2DMY(StudBuff."Passport Expiry Date", 1);
            Month := Date2DMY(StudBuff."Passport Expiry Date", 2);
            Year := Date2DMY(StudBuff."Passport Expiry Date", 3);
            RecStudentMaster.Validate("Pass Port Expiry Date", DMY2Date(Day, month, Year));
        end;
        RecStudentMaster.Validate("Pass Port Issued By", StudBuff."Passport Issued By");
        Clear(Day);
        Clear(Month);
        Clear(Year);
        If StudBuff."Passport Issued Date" <> 0D then begin
            Day := Date2DMY(StudBuff."Passport Issued Date", 1);
            Month := Date2DMY(StudBuff."Passport Issued Date", 2);
            Year := Date2DMY(StudBuff."Passport Issued Date", 3);
            RecStudentMaster.Validate("Pass Port Issued Date", DMY2Date(Day, month, Year));
        end;
        RecStudentMaster.Validate("Pass Port No.", StudBuff."Passport No.");
        RecStudentMaster.Validate("Permanent U.S. Resident", StudBuff."Permanent U.S. Resident");
        Clear(Day);
        Clear(Month);
        Clear(Year);
        IF StudBuff."Date of Birth" <> 0D then begin
            Day := Date2DMY(StudBuff."Date of Birth", 1);
            Month := Date2DMY(StudBuff."Date of Birth", 2);
            Year := Date2DMY(StudBuff."Date of Birth", 3);
            RecStudentMaster.Validate("Date of Birth", DMY2Date(Day, Month, Year));
        end;

        RecStudentMaster.Validate("Person Lead Source", StudBuff."Person Lead Source");
        RecStudentMaster.Validate(Addressee, StudBuff.Address1);
        RecStudentMaster.Validate(Address1, StudBuff.Address2);
        RecStudentMaster.Validate(Address2, StudBuff.Address3);
        // if (StudBuff.Postcode <> '') or (StudBuff.City <> '') then
        //     GenWebJnl.CreatePostCode(StudBuff.Postcode, StudBuff.City, StudBuff.State, StudBuff."Country Code");
        RecStudentMaster."Post Code" := StudBuff.Postcode;
        RecStudentMaster.City := StudBuff.City;
        RecStudentMaster.Validate(State, StudBuff.State);
        RecStudentMaster.Validate("Country Code", StudBuff."Country Code");
        RecStudentMaster.Validate("Pre-Req GPA", StudBuff."Pre-Req GPA");
        RecStudentMaster.Validate("Primary Lead Source", StudBuff."Primary Lead Source");
        RecStudentMaster.Validate(Skype, StudBuff.Skype);
        RecStudentMaster.Validate("Transfer GPA", StudBuff."Transfer GPA");
        RecStudentMaster.Validate("FAFSA Received", StudBuff."FAFSA Received");
        RecStudentMaster.Validate("Residency Hospital 1", StudBuff."Residency Hospital 1");
        RecStudentMaster.Validate("Residency Hospital 2", StudBuff."Residency Hospital 2");
        RecStudentMaster.Validate("Residency Status", StudBuff."Residency Status");
        RecStudentMaster.Validate("Residency City", StudBuff."Residency City");
        RecStudentMaster.Validate("Residency Specialty 1", StudBuff."Residency Specialty 1");
        RecStudentMaster.Validate("Residency Specialty 2", StudBuff."Residency Specialty 2");
        RecStudentMaster.Validate("Residency State", StudBuff."Residency State");
        RecStudentMaster.Validate("Residency Year", StudBuff."Residency Year");
        RecStudentMaster.Validate(Nationality, StudBuff.Nationality);
        RecStudentMaster.Validate("Academic Year", StudBuff."Academic Year");
        RecStudentMaster.Validate("Admitted Year", StudBuff."Admitted Year");
        RecStudentMaster.Validate(Term, StudBuff.Term);
        RecStudentMaster.Validate(Semester, StudBuff.Semester);
        RecStudentMaster."Eligible Non Citizen" := StudBuff."Eligible Non Citizen";
        RecStudentMaster."US Citizen" := StudBuff."US Citizen";
        RecStudentMaster."Antigua Citizen" := StudBuff."Antigua Citizen";
        RecStudentMaster."Indian Citizen" := StudBuff."Indian Citizen";
        RecStudentMaster.Validate("Admission Advisor", StudBuff."Admission Advisor");
        Clear(Day);
        Clear(Month);
        Clear(Year);
        IF StudBuff."Date Of Joining" <> 0D then begin
            Day := Date2DMY(StudBuff."Date of Joining", 1);
            Month := Date2DMY(StudBuff."Date of Joining", 2);
            Year := Date2DMY(StudBuff."Date of Joining", 3);
            RecStudentMaster.Validate("Date of Joining", DMY2Date(Day, Month, Year));
        end;
        RecStudentMaster.Validate("Other Lead Source", StudBuff."Other Lead Source");
        StudBuff.TestField("Global Dimension 1 Code");
        RecStudentMaster.Validate("Global Dimension 1 Code", StudBuff."Global Dimension 1 Code");
        RecStudentMaster.Validate("Fathers Name", StudBuff."Father Name");
        RecStudentMaster.Validate("Mothers Name", StudBuff."Mother Name");
        RecStudentMaster.Validate(Year, StudBuff.Year);
        RecStudentMaster."Transport Allot" := StudBuff."Transport Required";
        Clear(Day);
        Clear(Month);
        Clear(Year);
        IF StudBuff."Flight Arrival Date" <> 0D then begin
            Day := Date2DMY(StudBuff."Flight Arrival Date", 1);
            Month := Date2DMY(StudBuff."Flight Arrival Date", 2);
            Year := Date2DMY(StudBuff."Flight Arrival Date", 3);
            RecStudentMaster."Flight Arrival Date" := DMY2Date(Day, Month, Year);
        end;
        RecStudentMaster."Flight Arrival Time" := StudBuff."Flight Arrival Time";
        RecStudentMaster."Flight Number" := StudBuff."Flight Number";
        RecStudentMaster."Airline/Carrier" := StudBuff."Airline/Carrier";
        Clear(Day);
        Clear(Month);
        Clear(Year);
        IF StudBuff."Departure Date from Antigua" <> 0D then begin
            Day := Date2DMY(StudBuff."Departure Date from Antigua", 1);
            Month := Date2DMY(StudBuff."Departure Date from Antigua", 2);
            Year := Date2DMY(StudBuff."Departure Date from Antigua", 3);
            RecStudentMaster."Departure Date from Antigua" := DMY2Date(Day, Month, Year);
        end;
        RecStudentMaster.Validate("Scholarship Source", StudBuff."Scholarship Code 1");
        RecStudentMaster.Validate("Grant Code 1", StudBuff."Grant Code 1");
        RecStudentMaster.Validate("Grant Code 2", StudBuff."Grant Code 2");
        RecStudentMaster.Validate("Grant Code 3", StudBuff."Grant Code 3");
        RecStudentMaster.Validate("Social Security No.", StudBuff."Social Security No.");
        RecStudentMaster.Validate("Global Dimension 2 Code", StudBuff."Global Dimension 2 Code");

        RecStudentMaster.validate("Application No.", StudBuff."Application ID");
        RecStudentMaster.Validate("Application Type", StudBuff."Application Type");
        RecStudentMaster.validate("Application Sub-type", StudBuff."Application Sub-type");
        Clear(Day);
        Clear(Month);
        Clear(Year);
        IF StudBuff."Deposit Paid Date" <> 0D then begin
            Day := Date2DMY(StudBuff."Deposit Paid Date", 1);
            Month := Date2DMY(StudBuff."Deposit Paid Date", 2);
            Year := Date2DMY(StudBuff."Deposit Paid Date", 3);
            RecStudentMaster.validate("Deposit Paid Date", DMY2Date(Day, Month, Year));
        end;
        RecStudentMaster.validate("Deposit Waived", StudBuff."Deposit Waived");
        Clear(Day);
        Clear(Month);
        Clear(Year);
        IF StudBuff."Housing Deposit Date" <> 0D then begin
            Day := Date2DMY(StudBuff."Housing Deposit Date", 1);
            Month := Date2DMY(StudBuff."Housing Deposit Date", 2);
            Year := Date2DMY(StudBuff."Housing Deposit Date", 3);
            RecStudentMaster.validate("Housing Deposit Date", DMY2Date(Day, Month, Year));
        end;

        RecStudentMaster.Validate("Housing Deposit Waived", StudBuff."Housing Deposit Waived");

        Clear(Day);
        Clear(Month);
        Clear(Year);
        IF StudBuff."Student Accepted Date" <> 0D then begin
            Day := Date2DMY(StudBuff."Student Accepted Date", 1);
            Month := Date2DMY(StudBuff."Student Accepted Date", 2);
            Year := Date2DMY(StudBuff."Student Accepted Date", 3);
            RecStudentMaster.validate("Student Accepted Date", DMY2Date(Day, Month, Year));
        end;
        RecStudentMaster.validate("Sub-Stage", StudBuff."Sub-Stage");
        RecStudentMaster.validate(Housing, StudBuff.Housing);
        RecStudentMaster.validate("Seat Deposit Paid", StudBuff."Seat Deposit Paid");
    end;

    procedure HousingWaiverInsertModify(var lvStudBuff: Record "Student Buffer"; var lvStud: Record "Student Master-CS")
    var
        RecHousingApplication: Record "Housing Application";
        RecOptOut: Record "Opt Out";
        HousingMailCod: Codeunit "Hosusing Mail";
        ReturnValue: Text[50];
        ApplicationType: Option "Bsic Opt Out","Housing Wavier","Make-Up","Restart","Appeal","Semester Registration";
        WaiverStatus: Option Open,"Pending for Approval",Approved,Rejected,Submit;
    begin
        if lvStudBuff.Housing = lvStudBuff.Housing::"Independent Housing" then begin
            if lvStudBuff."Housing/Waiver Application No." = '' then begin
                RecHousingApplication.Reset();
                RecHousingApplication.SetRange("Student No.", lvStudBuff."Student No.");
                RecHousingApplication.SetRange("Academic Year", lvStudBuff."Academic Year");
                RecHousingApplication.SetRange(Semester, lvStudBuff.Semester);
                RecHousingApplication.SetRange(Term, lvStudBuff.Term);
                RecHousingApplication.Setfilter(Status, '%1|%2', RecHousingApplication.Status::"Pending for Approval", RecHousingApplication.Status::Approved);
                IF RecHousingApplication.FindFirst() then
                    Error('Housing Waiver application cannot be created as Housing Application No. %1 already exists for this Student', RecHousingApplication."Application No.");

                RecOptOut.Reset();
                RecOptOut.SetRange("Student No.", lvStudBuff."Student No.");
                RecOptOut.SetRange("Academic Year", lvStudBuff."Academic Year");
                RecOptOut.SetRange(Semester, lvStudBuff.Semester);
                RecOptOut.SetRange(Term, lvStudBuff.Term);
                RecOptOut.Setrange("Application Type", RecOptOut."Application Type"::"Housing Wavier");
                RecOptOut.setfilter(Status, '<>%1', RecOptOut.Status::Rejected);
                IF RecOptOut.FindFirst() then
                    // if ToBeInserted <> 2 then
                    //     Error('Housing Waiver Application No. %1 already exists for this Student', RecOptOut."Application No.")
                    // else
                        lvStudBuff."Housing/Waiver Application No." := RecOptOut."Application No.";


                lvStud.Address3 := lvStudBuff."Present Address 1";

                lvStud.Address4 := lvStudBuff."Present Address 2";
                lvStud."Address To" := lvStudBuff."Present Address 3";
                if (lvStudBuff."Present Post Code" <> '') or (lvStudBuff."Present City" <> '') then
                    GenWebJnl.CreatePostCode(lvStudBuff."Present Post Code", lvStudBuff."Present City", lvStudBuff."Present State", lvStudBuff."Present Country");
                lvStud."Cor Post Code" := lvStudBuff."Present Post Code";
                lvStud."Cor City" := lvStudBuff."Present City";
                lvStud."Cor State" := lvStudBuff."Present State";
                lvStud."Cor Country Code" := lvStudBuff."Present Country";
                lvStud."Lease Agreement/Contract No." := lvStudBuff."Lease Agreement No.";
                lvStud."Lease Agreement Group" := lvStudBuff."Lease Agreement Group";
                lvStud."Transport Allot" := lvStudBuff."Transport Required";
                lvStud."Transport Cell" := lvStudBuff."Transport Cell No.";

                // if ToBeInserted <> 2 then begin
                ReturnValue := HousingMailCod.WebAPIHousingWavierInsert(lvStud."No.", ApplicationType::"Housing Wavier",
                lvStudBuff."Present Address 1", lvStudBuff."Present Address 2", lvStudBuff."Present Address 3", lvStudBuff."Lease Agreement No.", lvStudBuff."Lease Agreement Group",
                lvStud."Transport Allot", lvStud."Transport Cell", lvStudBuff."Present Post Code",
                lvStudBuff."Present City", lvStudBuff."Present Country", lvStudBuff."Present State", WaiverStatus::"Pending for Approval", true, lvStudBuff."Academic Year", lvStudBuff.Semester, lvStudBuff.Term);

                if CopyStr(ReturnValue, 1, 7) = 'Success' then
                    lvStudBuff."Housing/Waiver Application No." := CopyStr(ReturnValue, 9, 20)
                else
                    Error('Could not Insert the Housing Waiver Application');
                lvStud.validate("Housing/Waiver Application No.", lvStudBuff."Housing/Waiver Application No.");


            end
            else begin

                RecOptOut.Reset();
                RecOptOut.SetRange("Application No.", lvStudBuff."Housing/Waiver Application No.");
                RecOptOut.SetRange("Student No.", lvStudBuff."Student No.");
                RecOptOut.SetRange("Academic Year", lvStudBuff."Academic Year");
                RecOptOut.SetRange(Semester, lvStudBuff.Semester);
                RecOptOut.SetRange(Term, lvStudBuff.Term);
                RecOptOut.Setrange("Application Type", RecOptOut."Application Type"::"Housing Wavier");
                RecOptOut.setfilter(Status, '%1', RecOptOut.Status::"Pending for Approval");
                IF RecOptOut.FindFirst() then begin
                    lvStud.Address3 := lvStudBuff."Present Address 1";
                    lvStud.Address4 := lvStudBuff."Present Address 2";
                    lvStud."Address To" := lvStudBuff."Present Address 3";
                    lvStud."Cor Post Code" := lvStudBuff."Present Post Code";
                    lvStud."Cor City" := lvStudBuff."Present City";
                    lvStud."Cor State" := lvStudBuff."Present State";
                    lvStud."Cor Country Code" := lvStudBuff."Present Country";
                    lvStud."Lease Agreement/Contract No." := lvStudBuff."Lease Agreement No.";
                    lvStud."Lease Agreement Group" := lvStudBuff."Lease Agreement Group";

                    lvStud."Transport Cell" := lvStudBuff."Transport Cell No.";

                    RecOptOut."Present Address1" := lvStudBuff."Present Address 1";
                    RecOptOut."Present Address2" := lvStudBuff."Present Address 2";
                    RecOptOut."Present Address3" := lvStudBuff."Present Address 3";
                    RecOptOut.city := lvStudBuff."Present City";
                    RecOptOut.Country := lvStudBuff."Present Country";
                    RecOptOut.County := lvStudBuff."Present State";
                    RecOptOut."Post Code" := lvStudBuff."Present Post Code";
                    RecOptOut."Lease Agreement Group" := lvStudBuff."Lease Agreement Group";
                    RecOptOut."Lease Agreement/Contract No." := lvStudBuff."Lease Agreement No.";

                    RecOptOut."Transport Cell" := lvStudBuff."Transport Cell No.";
                    Recoptout.modify(true);

                end;
            end;
        end
        else
            if lvStudBuff.Housing = lvStudBuff.Housing::"AUA Housing" then begin
                if lvStudBuff."Housing/Waiver Application No." = '' then begin
                    RecOptOut.Reset();
                    RecOptOut.SetRange("Student No.", lvStud."No.");
                    RecOptOut.SetRange("Academic Year", lvStud."Academic Year");
                    RecOptOut.SetRange(Semester, lvStud.Semester);
                    RecOptOut.SetRange(Term, lvStud.Term);
                    RecOptOut.Setrange("Application Type", RecOptOut."Application Type"::"Housing Wavier");
                    RecOptOut.setfilter(Status, '<>%1', RecOptOut.Status::Rejected);
                    IF RecOptOut.FindFirst() then
                        Error('Housing Application cannot be created as Housing Waiver Application No. %1 already exists for this Student', RecOptOut."Application No.");

                    RecHousingApplication.Reset();
                    RecHousingApplication.SetRange("Student No.", lvStud."No.");
                    RecHousingApplication.SetRange("Academic Year", lvStudBuff."Academic Year");
                    RecHousingApplication.SetRange(Semester, lvStudBuff.Semester);
                    RecHousingApplication.SetRange(Term, lvStudBuff.Term);
                    RecHousingApplication.Setfilter(Status, '%1|%2', RecHousingApplication.Status::"Pending for Approval", RecHousingApplication.Status::Approved);
                    IF RecHousingApplication.FindFirst() then
                        // if ToBeInserted <> 2 then
                        //     Error('Housing Application No. %1 already exists for this Student', RecHousingApplication."Application No.")
                        // else
                            lvStudBuff."Housing/Waiver Application No." := RecHousingApplication."Application No."
                    ELSE begin

                        // if ToBeInserted <> 2 then begin
                        ReturnValue := HousingMailCod.SalesforceHousingApplicationInsert(lvStud."No.", false, '', '', '', '', '', '', '', '', '', '', '', '', true, lvStudBuff."Housing Deposit Date", lvStudBuff."Flight Arrival Date",
                        lvStudBuff."Flight Arrival Time", lvStudBuff."Flight Number", lvStudBuff."Airline/Carrier", lvStudBuff."Departure Date from Antigua", lvStudBuff."Academic Year", lvStudBuff.Semester, lvStudBuff.Term, False, False, False, False, False, False, '', '');

                        if CopyStr(ReturnValue, 1, 7) = 'Success' then
                            lvStudBuff."Housing/Waiver Application No." := CopyStr(ReturnValue, 9, 20)
                        else
                            Error('Could not Insert the Housing Application');
                    END;
                    lvStud.validate("Housing/Waiver Application No.", lvStudBuff."Housing/Waiver Application No.");
                    // end;
                end;
            end;
    end;

    // Procedure EmailTrigger(StudentMaster_pRec: Record "Student Master-CS")
    // Var
    //     SMTPMailSetup: Record "Email Account";
    //     PortalUSer: Record "Portal User Login-CS";
    //     //SMTPMail: codeunit Mail
    //     SMTPMail: Codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     BodyText: Text;
    //     InstituteName: Text;
    //     Bcc: Text;
    //     BccList: List of [Text];
    // Begin
    //     Clear(InstituteName);
    //     IF NOT (StudentMaster_pRec."Global Dimension 1 Code" IN ['9000', '9100']) Then
    //         exit;
    //     IF StudentMaster_pRec."Global Dimension 1 Code" = '9000' then
    //         InstituteName := 'AUA'
    //     else
    //         InstituteName := 'AICASA';
    //     SMTPMailSetup.Reset();
    //     SMTPMailSetup.Get();
    //     Recipient := StudentMaster_pRec."Alternate Email Address";
    //     Recipients := Recipient.Split(';');
    //     //Temp Code
    //     // Bcc := 'stuti.khandelwal@corporateserve.com';
    //     // BccList := Bcc.Split(';');
    //     //Temp Code
    //     SenderAddress := SmtpMailSetup."Email Address";
    //     Subject := 'Important ' + InstituteName + ' Email Credentials Enclosed';
    //     PortalUSer.Reset();
    //     PortalUSer.SetRange(U_ID, StudentMaster_pRec."No.");
    //     If PortalUSer.FindFirst() then;
    //     SMTPMail.Create(Recipients, Subject, '', true);
    //     // SMTPMail.AddBCC(BccList);//Temp Code
    //     SMTPMail.AppendtoBody('Dear ' + StudentMaster_pRec."Student Name");
    //     SMTPMail.AppendtoBody('<br><Br>');
    //     SMTPMail.AppendtoBody('Welcome to ' + InstituteName + '!');
    //     SMTPMail.AppendtoBody('<br><Br>');
    //     SMTPMail.AppendtoBody('Below are your credentials to login to your ' + InstituteName + ' Portal. You will also utilize these credentials for online registration when OLR is open.');
    //     SMTPMail.AppendtoBody('<br><br>');
    //     SMTPMail.AppendtoBody('<H1>' + InstituteName + ' Portal </H1><H3>This will give you access to : Email, One Drive, Echo 360, Student Portal, Blackboard, Financial Aid, Library, Service Desk, etc</H3>');
    //     SMTPMail.AppendtoBody('<H3>URL: https://myapplications.microsoft.com </H3>');
    //     SMTPMail.AppendtoBody('<H3>Username: ' + StudentMaster_pRec."E-Mail Address" + '</H3>');
    //     SMTPMail.AppendtoBody('<H3>Password: ' + PortalUSer.Password + '</H3>');
    //     SMTPMail.AppendtoBody('<br>');
    //     SMTPMail.AppendtoBody('We wish you the very best at ' + InstituteName + '!');
    //     SMTPMail.AppendtoBody('<br><br>');
    //     SMTPMail.AppendtoBody('If you need assistance with login, please contact the Campus Technology Service Desk servicedesk@auamed.net');
    //     SMTPMail.AppendtoBody('<br><br><br><br>');
    //     SMTPMail.AppendtoBody('Thank you!');
    //     SMTPMail.AppendtoBody('<br><br>');
    //     IF StudentMaster_pRec."Global Dimension 1 Code" = '9000' then
    //         SMTPMail.AppendtoBody('American University of Antigua')
    //     else
    //         SMTPMail.AppendtoBody('American International College of Arts and Science');
    //     BodyText := SMTPMail.GetBody();
    //     Mail_lCU.Send();



    //     //FOR NOTIFICATION +
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification(InstituteName + ' Email Credentials', 'MEA', SenderAddress, StudentMaster_pRec."Student Name",
    //     Format(StudentMaster_pRec."No."), Subject, BodyText, InstituteName + ' Email Credentials', InstituteName + ' Email Credentials', '', '',
    //     Recipient, 1, StudentMaster_pRec."Mobile Number", '', 1);
    //     //FOR NOTIFICATION -
    // End;

    var
        StudMasterPrntStud: Record "Student Master-CS";
        RecEducationSetup: Record "Education Setup-CS";
        StudentStatus: Record "Student Status";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenWebJnl: Codeunit "Gen. Web  Journal -CS";
}