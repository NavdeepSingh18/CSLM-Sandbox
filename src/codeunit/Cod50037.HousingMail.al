codeunit 50037 "Hosusing Mail"
{

    trigger OnRun()
    begin
    end;

    procedure HousingMailToStudent()
    var

        HostelApplication: Record "Housing Application";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        EducationSetup: Record "Education Setup-CS";
        EndDate: Date;
        StartDate: Date;
        DateCheck: Date;

    begin
        EducationSetup.Reset();
        IF EducationSetup.FindSet() then
            repeat
                EducationSetup.TestField(EducationSetup."Housing Mail Terms");
                IF EducationSetup."Even/Odd Semester" = EducationSetup."Even/Odd Semester"::SPRING then begin
                    EducationMultiEventCalCS.RESET();
                    EducationMultiEventCalCS.SETRANGE("Event Code", 'SPRING');
                    EducationMultiEventCalCS.SetRange("Academic Year", EducationSetup."Academic Year");
                    IF EducationMultiEventCalCS.FindSet() THEN begin
                        if WorkDate() IN [EducationMultiEventCalCS."Start Date" .. EducationMultiEventCalCS."End Date"] then begin
                            StartDate := EducationMultiEventCalCS."Start Date";
                            EndDate := EducationMultiEventCalCS."Revised End Date";

                            HostelApplication.Reset();
                            HostelApplication.SetRange("Start Date", StartDate);
                            HostelApplication.SetRange("End Date", EndDate);
                            HostelApplication.SetRange(Status, HostelApplication.Status::Approved);
                            HostelApplication.SetRange("Global Dimension 1 Code", EducationMultiEventCalCS."Global Dimension 1 Code");
                            HostelApplication.SetRange(Posted, True);
                            IF HostelApplication.FindFirst() then
                                repeat
                                    DateCheck := CalcDate(EducationSetup."Housing Mail Terms", EndDate);
                                // IF DateCheck = WorkDate() then
                                //     MailDocumentforClosed(HostelApplication."Student No.", EndDate);
                                Until HostelApplication.Next() = 0;
                        End;
                    End;
                end ELse begin
                    EducationMultiEventCalCS.RESET();
                    EducationMultiEventCalCS.SETRANGE("Event Code", 'FALL');
                    EducationMultiEventCalCS.SetRange("Academic Year", EducationSetup."Academic Year");
                    IF EducationMultiEventCalCS.FindSet() THEN begin
                        if WorkDate() IN [EducationMultiEventCalCS."Start Date" .. EducationMultiEventCalCS."End Date"] then begin
                            StartDate := EducationMultiEventCalCS."Start Date";
                            EndDate := EducationMultiEventCalCS."Revised End Date";

                            HostelApplication.Reset();
                            HostelApplication.SetRange("Start Date", StartDate);
                            HostelApplication.SetRange("End Date", EndDate);
                            HostelApplication.SetRange(Status, HostelApplication.Status::Approved);
                            HostelApplication.SetRange("Global Dimension 1 Code", EducationMultiEventCalCS."Global Dimension 1 Code");
                            HostelApplication.SetRange(Posted, True);
                            IF HostelApplication.FindFirst() then
                                repeat
                                    DateCheck := CalcDate(EducationSetup."Housing Mail Terms", EndDate);
                                // IF DateCheck = WorkDate() then
                                //     MailDocumentforClosed(HostelApplication."Student No.", EndDate);
                                Until HostelApplication.Next() = 0;
                        End;
                    end;
                end;
            Until EducationSetup.Next() = 0;
    END;

    // procedure MailDocumentforClosed(StudentNo: Code[20]; EndDate: date)
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     BodyText: text[2048];
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'Housing Vacate/Renew';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Name as on Certificate");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('You Can vacate the hostel, if you want to continue then apply for the Renewal from the SLcM Portal');
    //     SmtpMail.AppendtoBody('before this date' + ' ' + Format(EndDate));
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Thanking You');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This Is System Generated Mail.Please Do Not Reply On This E-mail ID');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     //SMTPmail.send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing', 'MEA', SenderAddress, Studentmaster."Student Name",
    //     Studentmaster."No.", Subject, BodyText, 'Housing Vacate/Renew', 'Housing Vacate/Renew', '', '',
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    procedure HousingAutomaticVacate()
    var

        HostelApplication: Record "Housing Application";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        EducationSetup: Record "Education Setup-CS";
        //HousingChangeRequest: Record "Housing Change Request";
        EndDate: Date;
        StartDate: Date;

    begin
        EducationSetup.Reset();
        IF EducationSetup.FindSet() then
            repeat
                //EducationSetup.TestField(EducationSetup."Housing Mail Terms");
                IF EducationSetup."Even/Odd Semester" = EducationSetup."Even/Odd Semester"::"SPRING" then begin
                    EducationMultiEventCalCS.RESET();
                    EducationMultiEventCalCS.SETRANGE("Event Code", 'SPRING');
                    EducationMultiEventCalCS.SetRange("Academic Year", EducationSetup."Academic Year");
                    IF EducationMultiEventCalCS.FindSet() THEN begin
                        if WorkDate() IN [EducationMultiEventCalCS."Start Date" .. EducationMultiEventCalCS."End Date"] then begin
                            StartDate := EducationMultiEventCalCS."Start Date";
                            EndDate := EducationMultiEventCalCS."Revised End Date";

                            HostelApplication.Reset();
                            HostelApplication.SetRange("Start Date", StartDate);
                            HostelApplication.SetRange("End Date", EndDate);
                            HostelApplication.SetRange(Status, HostelApplication.Status::Approved);
                            //HostelApplication.SetRange("Global Dimension 1 Code", EducationMultiEventCalCS."Global Dimension 1 Code");
                            HostelApplication.SetRange(Posted, True);
                            IF HostelApplication.FindFirst() then
                                repeat
                                    //HousingChangeRequest.Reset();
                                    //HousingChangeRequest.SetRange("Student No.", HostelApplication."Student No.");
                                    //HousingChangeRequest.SetRange(HousingChangeRequest.Type, HousingChangeRequest.Type::"Re-Registration");
                                    //HousingChangeRequest.SetRange("Original Application No.", HostelApplication."Application No.");
                                    //if HousingChangeRequest.IsEmpty() then begin
                                    PostHousingVacate(HostelApplication."Student No.", HostelApplication."Application No.");
                                    PostApplication(HostelApplication."Application No.", HostelApplication."Housing ID",
                                        HostelApplication."Room No.", HostelApplication."With Spouse");
                                //end;
                                Until HostelApplication.Next() = 0;
                        End;
                    End;
                end ELse begin
                    EducationMultiEventCalCS.RESET();
                    EducationMultiEventCalCS.SETRANGE("Event Code", 'FALL');
                    EducationMultiEventCalCS.SetRange("Academic Year", EducationSetup."Academic Year");
                    IF EducationMultiEventCalCS.FindSet() THEN begin
                        if WorkDate() IN [EducationMultiEventCalCS."Start Date" .. EducationMultiEventCalCS."End Date"] then begin
                            StartDate := EducationMultiEventCalCS."Start Date";
                            EndDate := EducationMultiEventCalCS."Revised End Date";

                            HostelApplication.Reset();
                            HostelApplication.SetRange("Start Date", StartDate);
                            HostelApplication.SetRange("End Date", EndDate);
                            HostelApplication.SetRange(Status, HostelApplication.Status::Approved);
                            //HostelApplication.SetRange("Global Dimension 1 Code", EducationMultiEventCalCS."Global Dimension 1 Code");
                            HostelApplication.SetRange(Posted, True);
                            IF HostelApplication.FindFirst() then
                                repeat
                                    // HousingChangeRequest.Reset();
                                    // HousingChangeRequest.SetRange("Student No.", HostelApplication."Student No.");
                                    // HousingChangeRequest.SetRange(HousingChangeRequest.Type, HousingChangeRequest.Type::"Re-Registration");
                                    // HousingChangeRequest.SetRange("Original Application No.", HostelApplication."Application No.");
                                    // if HousingChangeRequest.IsEmpty() then begin
                                    PostHousingVacate(HostelApplication."Student No.", HostelApplication."Application No.");
                                    PostApplication(HostelApplication."Application No.", HostelApplication."Housing ID",
                                    HostelApplication."Room No.", HostelApplication."With Spouse");
                                // end;
                                Until HostelApplication.Next() = 0;
                        End;
                    end;
                end;
            Until EducationSetup.Next() = 0;
    END;

    procedure PostApplication(ApplicationNo: Code[20]; HousingId: Code[20]; RoomNo: Code[20]; WithSpouse: Boolean)
    var
        HostelLedgerRec: Record "Housing Ledger";
        HostelLedgerRec1: Record "Housing Ledger";
        HostelApplicationRec1: Record "Housing Application";
        RoomWiseBedRec: Record "Room Wise Bed";
        LastNo: Integer;
    begin
        IF WithSpouse then begin
            RoomWiseBedRec.Reset();
            RoomWiseBedRec.setrange("Housing ID", HousingId);
            RoomWiseBedRec.SetRange("Room No.", RoomNo);
            RoomWiseBedRec.Setfilter(Available, '%1', true);
            if RoomWiseBedRec.FindSet() then begin
                repeat
                    HostelLedgerRec.Reset();
                    if HostelLedgerRec.FINDLAST() then
                        LastNo := HostelLedgerRec."Entry No." + 1
                    else
                        LastNo := 1;

                    HostelLedgerRec.Init();
                    HostelLedgerRec."Entry No." := LastNo;
                    HostelLedgerRec."Application No." := ApplicationNo;
                    HostelLedgerRec."Original Application No." := ApplicationNo;
                    HostelLedgerRec.Status := HostelLedgerRec.Status::UnAssigned;
                    HostelLedgerRec1.Reset();
                    HostelLedgerRec1.SetRange("Application No.", ApplicationNo);
                    IF HostelLedgerRec1.FindSet() then;
                    HostelLedgerRec."Housing ID" := HostelLedgerRec1."Housing ID";
                    HostelLedgerRec."Room Category Code" := HostelLedgerRec1."Room Category Code";
                    HostelLedgerRec."Housing Group" := HostelLedgerRec1."Housing Group";
                    HostelLedgerRec.Type := HostelLedgerRec.Type::Vacate;
                    HostelLedgerRec."Room No." := HostelLedgerRec1."Room No.";
                    HostelLedgerRec."Bed No." := HostelLedgerRec1."Bed No.";
                    HostelLedgerRec."Student No." := HostelLedgerRec1."Student No.";
                    HostelLedgerRec."Academic Year" := HostelLedgerRec1."Academic Year";
                    HostelLedgerRec.Semester := HostelLedgerRec1.Semester;
                    HostelLedgerRec."Enrolment No." := HostelLedgerRec1."Enrolment No.";
                    HostelLedgerRec."Room Assignment" := -1;
                    HostelLedgerRec."Global Dimension 1 Code" := HostelLedgerRec1."Global Dimension 1 Code";
                    HostelLedgerRec."Global Dimension 2 Code" := HostelLedgerRec1."Global Dimension 2 Code";
                    HostelLedgerRec."Housing Vacated On" := WORKDATE();
                    HostelLedgerRec."Posting Date" := WORKDATE();
                    HostelLedgerRec."Contract No." := HostelLedgerRec1."Contract No.";
                    HostelLedgerRec.Insert(true);

                    RoomWiseBedRec.Available := true;
                    RoomWiseBedRec.Modify();
                until RoomWiseBedRec.next() = 0;

                HostelApplicationRec1.Reset();
                HostelApplicationRec1.SetRange("Application No.", ApplicationNo);
                IF HostelApplicationRec1.FindFirst() then begin
                    HostelApplicationRec1.Status := HostelApplicationRec1.Status::Vacated;
                    HostelApplicationRec1.Modify();
                End;
            end;
        end else begin
            HostelLedgerRec.Reset();
            if HostelLedgerRec.FINDLAST() then
                LastNo := HostelLedgerRec."Entry No." + 1
            else
                LastNo := 1;

            HostelLedgerRec.Init();
            HostelLedgerRec."Entry No." := LastNo;
            HostelLedgerRec."Application No." := ApplicationNo;
            HostelLedgerRec."Original Application No." := ApplicationNo;
            HostelLedgerRec.Status := HostelLedgerRec.Status::UnAssigned;
            HostelLedgerRec1.Reset();
            HostelLedgerRec1.SetRange("Application No.", ApplicationNo);
            IF HostelLedgerRec1.FindSet() then;
            HostelLedgerRec."Housing ID" := HostelLedgerRec1."Housing ID";
            HostelLedgerRec."Room Category Code" := HostelLedgerRec1."Room Category Code";
            HostelLedgerRec."Housing Group" := HostelLedgerRec1."Housing Group";
            HostelLedgerRec.Type := HostelLedgerRec.Type::Vacate;
            HostelLedgerRec."Room No." := HostelLedgerRec1."Room No.";
            HostelLedgerRec."Bed No." := HostelLedgerRec1."Bed No.";
            HostelLedgerRec."Student No." := HostelLedgerRec1."Student No.";
            HostelLedgerRec."Academic Year" := HostelLedgerRec1."Academic Year";
            HostelLedgerRec.Semester := HostelLedgerRec1.Semester;
            HostelLedgerRec."Enrolment No." := HostelLedgerRec1."Enrolment No.";
            HostelLedgerRec."Room Assignment" := -1;
            HostelLedgerRec."Global Dimension 1 Code" := HostelLedgerRec1."Global Dimension 1 Code";
            HostelLedgerRec."Global Dimension 2 Code" := HostelLedgerRec1."Global Dimension 2 Code";
            HostelLedgerRec."Housing Vacated On" := WORKDATE();
            HostelLedgerRec."Posting Date" := WORKDATE();
            HostelLedgerRec."Contract No." := HostelLedgerRec1."Contract No.";
            HostelLedgerRec.Insert(true);

            HostelApplicationRec1.Reset();
            HostelApplicationRec1.SetRange("Application No.", ApplicationNo);
            IF HostelApplicationRec1.FindFirst() then begin
                HostelApplicationRec1.Status := HostelApplicationRec1.Status::Vacated;
                HostelApplicationRec1.Modify();
            End;

            RoomWiseBedRec.Reset();
            RoomWiseBedRec.SetRange("Housing ID", HostelLedgerRec1."Housing ID");
            RoomWiseBedRec.SetRange("Room No.", HostelLedgerRec1."Room No.");
            RoomWiseBedRec.SetRange("Bed No.", HostelLedgerRec1."Bed No.");
            if RoomWiseBedRec.FINDFIRST() then begin
                RoomWiseBedRec.Available := true;
                RoomWiseBedRec.Modify();
            end;
        end;
    end;

    procedure PostApplicationNew(ApplicationNo: Code[20]; HousingId: Code[20]; RoomNo: Code[20]; WithSpouse: Boolean)
    var
        HostelLedgerRec: Record "Housing Ledger";
        HostelLedgerRec1: Record "Housing Ledger";
        HostelApplicationRec1: Record "Housing Application";
        RoomWiseBedRec: Record "Room Wise Bed";
        LastNo: Integer;
    begin
        IF WithSpouse then begin
            RoomWiseBedRec.Reset();
            RoomWiseBedRec.setrange("Housing ID", HousingId);
            RoomWiseBedRec.SetRange("Room No.", RoomNo);
            //RoomWiseBedRec.Setfilter(Available, '%1', true);
            if RoomWiseBedRec.FindSet() then begin
                repeat
                    HostelLedgerRec.Reset();
                    if HostelLedgerRec.FINDLAST() then
                        LastNo := HostelLedgerRec."Entry No." + 1
                    else
                        LastNo := 1;

                    HostelLedgerRec.Init();
                    HostelLedgerRec."Entry No." := LastNo;
                    HostelLedgerRec."Application No." := ApplicationNo;
                    HostelLedgerRec."Original Application No." := ApplicationNo;
                    HostelLedgerRec.Status := HostelLedgerRec.Status::UnAssigned;
                    HostelLedgerRec1.Reset();
                    HostelLedgerRec1.SetRange("Application No.", ApplicationNo);
                    IF HostelLedgerRec1.FindSet() then;
                    HostelLedgerRec."Housing ID" := HostelLedgerRec1."Housing ID";
                    HostelLedgerRec."Room Category Code" := HostelLedgerRec1."Room Category Code";
                    HostelLedgerRec."Housing Group" := HostelLedgerRec1."Housing Group";
                    HostelLedgerRec.Type := HostelLedgerRec.Type::Vacate;
                    HostelLedgerRec."Room No." := HostelLedgerRec1."Room No.";
                    HostelLedgerRec."Bed No." := HostelLedgerRec1."Bed No.";
                    HostelLedgerRec."Student No." := HostelLedgerRec1."Student No.";
                    HostelLedgerRec."Academic Year" := HostelLedgerRec1."Academic Year";
                    HostelLedgerRec.Semester := HostelLedgerRec1.Semester;
                    HostelLedgerRec."Enrolment No." := HostelLedgerRec1."Enrolment No.";
                    HostelLedgerRec."Room Assignment" := -1;
                    HostelLedgerRec."Global Dimension 1 Code" := HostelLedgerRec1."Global Dimension 1 Code";
                    HostelLedgerRec."Global Dimension 2 Code" := HostelLedgerRec1."Global Dimension 2 Code";
                    HostelLedgerRec."Housing Vacated On" := WORKDATE();
                    HostelLedgerRec."Posting Date" := WORKDATE();
                    HostelLedgerRec."Contract No." := HostelLedgerRec1."Contract No.";
                    HostelLedgerRec.Insert(true);

                    RoomWiseBedRec.Available := true;
                    RoomWiseBedRec.Modify();
                until RoomWiseBedRec.next() = 0;

                HostelApplicationRec1.Reset();
                HostelApplicationRec1.SetRange("Application No.", ApplicationNo);
                IF HostelApplicationRec1.FindFirst() then begin
                    HostelApplicationRec1.Status := HostelApplicationRec1.Status::Vacated;
                    HostelApplicationRec1.Modify();
                End;
            end;
        end else begin
            HostelLedgerRec.Reset();
            if HostelLedgerRec.FINDLAST() then
                LastNo := HostelLedgerRec."Entry No." + 1
            else
                LastNo := 1;

            HostelLedgerRec.Init();
            HostelLedgerRec."Entry No." := LastNo;
            HostelLedgerRec."Application No." := ApplicationNo;
            HostelLedgerRec."Original Application No." := ApplicationNo;
            HostelLedgerRec.Status := HostelLedgerRec.Status::UnAssigned;
            HostelLedgerRec1.Reset();
            HostelLedgerRec1.SetRange("Application No.", ApplicationNo);
            IF HostelLedgerRec1.FindSet() then;
            HostelLedgerRec."Housing ID" := HostelLedgerRec1."Housing ID";
            HostelLedgerRec."Room Category Code" := HostelLedgerRec1."Room Category Code";
            HostelLedgerRec."Housing Group" := HostelLedgerRec1."Housing Group";
            HostelLedgerRec.Type := HostelLedgerRec.Type::Vacate;
            HostelLedgerRec."Room No." := HostelLedgerRec1."Room No.";
            HostelLedgerRec."Bed No." := HostelLedgerRec1."Bed No.";
            HostelLedgerRec."Student No." := HostelLedgerRec1."Student No.";
            HostelLedgerRec."Academic Year" := HostelLedgerRec1."Academic Year";
            HostelLedgerRec.Semester := HostelLedgerRec1.Semester;
            HostelLedgerRec."Enrolment No." := HostelLedgerRec1."Enrolment No.";
            HostelLedgerRec."Room Assignment" := -1;
            HostelLedgerRec."Global Dimension 1 Code" := HostelLedgerRec1."Global Dimension 1 Code";
            HostelLedgerRec."Global Dimension 2 Code" := HostelLedgerRec1."Global Dimension 2 Code";
            HostelLedgerRec."Housing Vacated On" := WORKDATE();
            HostelLedgerRec."Posting Date" := WORKDATE();
            HostelLedgerRec."Contract No." := HostelLedgerRec1."Contract No.";
            HostelLedgerRec.Insert(true);

            HostelApplicationRec1.Reset();
            HostelApplicationRec1.SetRange("Application No.", ApplicationNo);
            IF HostelApplicationRec1.FindFirst() then begin
                HostelApplicationRec1.Status := HostelApplicationRec1.Status::Vacated;
                HostelApplicationRec1.Modify();
            End;

            RoomWiseBedRec.Reset();
            RoomWiseBedRec.SetRange("Housing ID", HostelLedgerRec1."Housing ID");
            RoomWiseBedRec.SetRange("Room No.", HostelLedgerRec1."Room No.");
            RoomWiseBedRec.SetRange("Bed No.", HostelLedgerRec1."Bed No.");
            if RoomWiseBedRec.FINDFIRST() then begin
                RoomWiseBedRec.Available := true;
                RoomWiseBedRec.Modify();
            end;
        end;
    end;

    procedure PostHousingVacate(StudentNo: Code[20]; OriginalAppNo: Code[20])
    var
        HousingChangeRec: Record "Housing Change Request";
        HostelApplicationRec: Record "Housing Application";
        RecStuRoomWiseInventory: Record "Student Room Wise Inventory";
        EducationSetupRec: Record "Education Setup-CS";
        StudentMasterRec: Record "Student Master-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        StudentMasterRec.Get(StudentNo);
        EducationSetupRec.Reset();
        EducationSetupRec.SetRange("Global Dimension 1 Code", StudentMasterRec."Global Dimension 1 Code");
        EducationSetupRec.FindFirst();
        HousingChangeRec.INIT();
        HousingChangeRec."Application No." := NoSeriesMgt.GetNextNo(EducationSetupRec."Housing Change/Vacate No.", 0D, TRUE);
        HousingChangeRec.Validate("Student No.", StudentNo);
        HousingChangeRec."Application Date" := WORKDATE();
        HousingChangeRec."Original Application No." := OriginalAppNo;
        HostelApplicationRec.Reset();
        HostelApplicationRec.SetRange("Application No.", OriginalAppNo);
        IF HostelApplicationRec.FindSet() then;
        HousingChangeRec."With Spouse" := HostelApplicationRec."With Spouse";
        HousingChangeRec."Room Category Code" := HostelApplicationRec."Room Category Code";
        HousingChangeRec.Type := HousingChangeRec.Type::Vacate;
        HousingChangeRec.Status := HousingChangeRec.Status::Approved;
        HousingChangeRec."Effective Date" := WORKDATE();
        HousingChangeRec.Posted := True;
        HousingChangeRec."Room Keys Returned" := True;
        HousingChangeRec."Mid Sem Break" := false;
        //22Dec2021
        HousingChangeRec."Academic Year" := HostelApplicationRec."Academic Year";
        HousingChangeRec.Semester := HostelApplicationRec.Semester;
        HousingChangeRec.Term := HostelApplicationRec.Term;
        //22Dec2021
        HousingChangeRec.INSERT(true);

        RecStuRoomWiseInventory.Reset();
        RecStuRoomWiseInventory.SetRange("Student No.", StudentNo);
        RecStuRoomWiseInventory.SetRange("Application No.", OriginalAppNo);
        RecStuRoomWiseInventory.SetRange("Quantity Verified Vacate", False);
        IF RecStuRoomWiseInventory.FindSet() then begin
            repeat
                RecStuRoomWiseInventory."Quantity Verified Vacate" := true;
                RecStuRoomWiseInventory.Modify()
            until RecStuRoomWiseInventory.Next() = 0;
        end;

    end;

    // procedure MailSendforImmigrationRelatedForm(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     BodyText: text[2048];
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'Immigration Related Information';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Name as on Certificate");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to inform you that you have to fill the Immigration Form and upload the all related document on SLcM Portal within 2 weeks');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Thanking You');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This Is System Generated Mail.Please Do Not Reply On This E-mail ID');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     //SMTPmail.send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Immigration', 'MEA', SenderAddress, Studentmaster."Student Name",
    //     Studentmaster."No.", Subject, BodyText, 'Immigration', 'Immigration', '', '',
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure MailSendforImmigrationDocumentSubmit(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     BodyText: text[2048];
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'Immigration Related Document Submitted Alert';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Name as on Certificate");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to inform you that you have not Upload Immigration document. Please Upload all related document on SLcM Portal within 1 weeks');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Thanking You');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This Is System Generated Mail.Please Do Not Reply On This E-mail ID');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     //SmtpMail.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Immigration', 'MEA', SenderAddress, Studentmaster."Student Name",
    //     Studentmaster."No.", Subject, BodyText, 'Immigration Document', 'Immigration Document', '', '',
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure MailSendforImmigrationHardCopySubmit(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     BodyText: text[2048];
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'Immigration Document Related Information';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Name as on Certificate");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to inform you that the hard copies of all Uploaded Immigration document on SLcM portal needs to be Submitted in Housing Servies Office');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Thanking You');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This Is System Generated Mail.Please Do Not Reply On This E-mail ID');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     //SmtpMail.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Immigration', 'MEA', SenderAddress, Studentmaster."Student Name",
    //     Studentmaster."No.", Subject, BodyText, 'Immigration Document', 'Immigration Document', '', '',
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    procedure HoldStatusLedgerEntryInsert(StudentNo: Code[20];
    HoldCode: Code[20]; HoldDescription: Text[100]; HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance";
    Status: Option Enable,Disable)
    var
        RecHoldStatusLedger: Record "Hold Status Ledger";
        RecStudentMaster: Record "Student Master-CS";
        LastNo: Integer;
    begin
        RecHoldStatusLedger.Reset();
        if RecHoldStatusLedger.FINDLAST() then
            LastNo := RecHoldStatusLedger."Entry No." + 1
        else
            LastNo := 1;
        IF RecStudentMaster.Get(StudentNo) then;
        RecHoldStatusLedger.Init();
        RecHoldStatusLedger."Entry No." := LastNo;
        RecHoldStatusLedger."Student No." := RecStudentMaster."No.";
        RecHoldStatusLedger."Student Name" := RecStudentMaster."Student Name";
        RecHoldStatusLedger."Academic Year" := RecStudentMaster."Academic Year";
        RecHoldStatusLedger."Admitted Year" := RecStudentMaster."Admitted Year";
        RecHoldStatusLedger.Semester := RecStudentMaster.Semester;
        RecHoldStatusLedger."Entry Date" := Today();
        RecHoldStatusLedger."Entry Time" := Time();
        RecHoldStatusLedger."Hold Code" := HoldCode;
        RecHoldStatusLedger."Hold Description" := HoldDescription;
        RecHoldStatusLedger."Hold Type" := HoldType;
        RecHoldStatusLedger.Status := Status;
        RecHoldStatusLedger."Global Dimension 1 Code" := RecStudentMaster."Global Dimension 1 Code";
        RecHoldStatusLedger."Global Dimension 2 Code" := RecStudentMaster."Global Dimension 2 Code";
        RecHoldStatusLedger."User ID" := FORMAT(UserId());
        RecHoldStatusLedger.Insert();

    end;

    // procedure EmailNotificationISIR(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     BodyText: text[2048];
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'ISIR Notification';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Name as on Certificate");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Need Email Notification for ISIR(FAFSA)');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Thanking You');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This Is System Generated Mail.Please Do Not Reply On This E-mail ID');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     //SmtpMail.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('ISIR', 'MEA', SenderAddress, Studentmaster."Student Name",
    //     Studentmaster."No.", Subject, BodyText, 'ISIR', 'ISIR', '', '',
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure StudentIntimationOnlineRegistration(StudentNo: Code[20]; AcademicYear: Code[20]; Semester: Code[20]; CourseCode: Code[20]; GDim1: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
    //     EducationSetup: Record "Education Setup-CS";
    //     RecCourseMaster: Record "Course Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     DueDate: Date;

    // begin
    //     EducationSetup.Reset();
    //     EducationSetup.SetRange("Global Dimension 1 Code", GDim1);
    //     EducationSetup.SetRange("Academic Year", AcademicYear);
    //     IF EducationSetup.FindFirst() then begin
    //         EducationSetup.Testfield("Registration Email");
    //         RecCourseMaster.Reset();
    //         RecCourseMaster.SetRange(Code, CourseCode);
    //         RecCourseMaster.SetRange("Academic Year", AcademicYear);
    //         RecCourseMaster.SetRange(Semester, Semester);
    //         IF RecCourseMaster.FindFirst() then begin
    //             EducationMultiEventCalCS.RESET();
    //             EducationMultiEventCalCS.SETRANGE("Event Code", RecCourseMaster."Event Code");
    //             EducationMultiEventCalCS.SetRange("Academic Year", RecCourseMaster."Academic Year");
    //             EducationMultiEventCalCS.SetRange(Semester, RecCourseMaster.Semester);
    //             IF EducationMultiEventCalCS.FindFirst() THEN begin
    //                 DueDate := CALCDATE(EducationSetup."Registration Email", EducationMultiEventCalCS."Start Date");
    //                 IF WorkDate() = DueDate then begin
    //                     SmtpMailRec.Get();
    //                     Studentmaster.GET(StudentNo);
    //                     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //                     Recipient := Studentmaster."E-Mail Address";
    //                     Recipients := Recipient.Split(';');
    //                     SenderName := 'MEA';
    //                     SenderAddress := SmtpMailRec."Email Address";
    //                     Subject := 'Online Registration';
    //                     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Name as on Certificate");
    //                     SmtpMail.AppendtoBody('<br><br>');
    //                     SmtpMail.AppendtoBody('Your online registration successful');
    //                     SmtpMail.AppendtoBody('<br>');
    //                     SmtpMail.AppendtoBody('Thanking You');
    //                     SmtpMail.AppendtoBody('<br><br>');
    //                     SmtpMail.AppendtoBody('<br>');
    //                     SmtpMail.AppendtoBody('This Is System Generated Mail.Please Do Not Reply On This E-mail ID');
    //                     SmtpMail.AppendtoBody('<br>');
    //                     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //                     //SMTPmail.send();

    //                 end;

    //             end;

    //         end;
    //     end;
    // end;

    procedure StudentHousingTypeUpdate(StudentNo: Code[20]; HousingID: Code[20]; RoomNo: Code[20]; BedNo: Code[20])
    var
        Studentmaster: Record "Student Master-CS";
        AcademicYearMasterRec: Record "Academic Year Master-CS";
        HousingApplicationRec: Record "Housing Application";
        HousingApplicationRec1: Record "Housing Application";
        HousingApplicationRec2: Record "Housing Application";
        CourseMaster: Record "Course Master-CS";
        PreviousSession: Option SPRING,FALL;
        SequenceNo: Integer;
        PreviousAcademicYear: Code[20];
    begin
        Studentmaster.Reset();
        If Studentmaster.Get(StudentNo) then begin
            HousingApplicationRec2.Reset();
            HousingApplicationRec2.SetRange("Student No.", StudentNo);
            HousingApplicationRec2.SetRange(Posted, true);
            if HousingApplicationRec2.FindLast() then begin
                IF Studentmaster.Term = Studentmaster.Term::SPRING then begin
                    PreviousSession := PreviousSession::FALL;
                    AcademicYearMasterRec.Reset();
                    AcademicYearMasterRec.SetRange(Code, Studentmaster."Academic Year");
                    IF AcademicYearMasterRec.FindFirst() then
                        SequenceNo := AcademicYearMasterRec.Sequence;
                    IF SequenceNo <> 0 Then begin
                        AcademicYearMasterRec.Reset();
                        AcademicYearMasterRec.SetRange(Sequence, (SequenceNo - 1));
                        IF AcademicYearMasterRec.FindFirst() then
                            PreviousAcademicYear := AcademicYearMasterRec.Code;

                        HousingApplicationRec.Reset();
                        HousingApplicationRec.SetRange("Student No.", StudentNo);
                        HousingApplicationRec.SetRange("Academic Year", PreviousAcademicYear);
                        HousingApplicationRec.SetRange(Term, HousingApplicationRec.Term::SPRING);
                        HousingApplicationRec.SetRange(Posted, true);
                        if HousingApplicationRec.FindLast() then begin
                            HousingApplicationRec1.Reset();
                            HousingApplicationRec1.SetRange("Application No.", HousingApplicationRec."Application No.");
                            HousingApplicationRec1.SetRange("Housing ID", HousingID);
                            HousingApplicationRec1.SetRange("Room No.", RoomNo);
                            HousingApplicationRec1.SetRange("Bed No.", BedNo);
                            if HousingApplicationRec1.FindLast() then begin
                                Studentmaster."Housing Type" := Studentmaster."Housing Type"::Remain;


                            end else begin
                                Studentmaster."Housing Type" := Studentmaster."Housing Type"::" ";


                            end;
                        end else begin
                            Studentmaster."Housing Type" := Studentmaster."Housing Type"::Return;

                        end;

                    end;
                end;
                IF Studentmaster.Term = Studentmaster.Term::FALL then begin
                    //PreviousSession := PreviousSession::SPRING;
                    HousingApplicationRec.Reset();
                    HousingApplicationRec.SetRange("Student No.", StudentNo);
                    HousingApplicationRec.SetRange("Academic Year", Studentmaster."Academic Year");
                    HousingApplicationRec.SetRange(Term, HousingApplicationRec.Term::SPRING);
                    HousingApplicationRec.SetRange(Posted, true);
                    if HousingApplicationRec.FindLast() then begin
                        HousingApplicationRec1.Reset();
                        HousingApplicationRec1.SetRange("Application No.", HousingApplicationRec."Application No.");
                        HousingApplicationRec1.SetRange("Housing ID", HousingID);
                        HousingApplicationRec1.SetRange("Room No.", RoomNo);
                        HousingApplicationRec1.SetRange("Bed No.", BedNo);
                        if HousingApplicationRec1.FindLast() then begin
                            Studentmaster."Housing Type" := Studentmaster."Housing Type"::Remain;

                        end else begin
                            Studentmaster."Housing Type" := Studentmaster."Housing Type"::" ";
                        end;
                    end else begin
                        Studentmaster."Housing Type" := Studentmaster."Housing Type"::Return;


                    end;
                end;

            end;
            Studentmaster.Housing := Studentmaster.Housing::"AUA Housing";
            Studentmaster."Temporary Apartment No." := '';
            Studentmaster."Temporary Housing Name" := '';
            Studentmaster."Temporary Room No." := '';
            CourseMaster.Reset();
            CourseMaster.SetRange(Code, Studentmaster."Course Code");
            IF CourseMaster.FindFirst() then
                IF (CourseMaster."New OLR Enabled") or (CourseMaster."Returning OLR Enabled") then begin
                    // Studentmaster."OLR Email Sent Date" := Today();//CSPL-00307 - Code Comment as per Sanjay Sir 16-01-2023
                    // Studentmaster."OLR Email Sent" := true;
                end;
            Studentmaster.Modify();
        end;
    end;

    // procedure MailSendforHousingWaiverSubmit(StudentNo: Code[20]; ApplicationNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     CompanyInformationRec: Record "Company Information";
    //     Studentmaster: Record "Student Master-CS";
    //     UserSetupRec: Record "User Setup";
    //     usersetupapprover: Record "Document Approver Users";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     CompanyInformationRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     usersetupapprover.Reset();
    //     usersetupapprover.SetFilter(usersetupapprover."Department Approver Type", '%1', usersetupapprover."Department Approver Type"::"Residential Services");
    //     usersetupapprover.FindFirst();
    //     UserSetupRec.get(usersetupapprover."User ID");
    //     UserSetupRec.TestField("E-Mail");

    //     Recipient := UserSetupRec."E-Mail";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := ApplicationNo + ' ' + 'Housing Waiver Application Submission';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear Residential Services Team,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to inform you that Housing Waiver Application #' + ' ' + ApplicationNo + ' ' + 'has been submitted by:');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Student Name :' + ' ' + Studentmaster."Student Name");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Enrolment No. :' + ' ' + Studentmaster."Enrollment No.");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Semester :' + ' ' + Studentmaster.Semester);
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Housing Waiver Application # :' + ' ' + ApplicationNo);
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please review the information in Business Central.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Thanking You,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody(Studentmaster."Student Name");
    //     //    SmtpMail.AppendtoBody('<br>');
    //     //    //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     If CompanyInformationRec."Send Email On/Off" then
    //         SMTPmail.send();
    // end;

    // procedure MailSendforHousingApplicationSubmit(StudentNo: Code[20]; ApplicationNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     UserSetupRec: Record "User Setup";
    //     CompanyInformationRec: Record "Company Information";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     usersetupapprover: Record "Document Approver Users";
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     SmtpMailRec.TestField("User ID");
    //     CompanyInformationRec.Get();
    //     Studentmaster.GET(StudentNo);

    //     //CSPL-00307-BUG 13-04-23 Mail was going to wrong Receipient
    //     // usersetupapprover.Reset();
    //     // usersetupapprover.SetFilter(usersetupapprover."Department Approver Type", '%1', usersetupapprover."Department Approver Type"::"Residential Services");
    //     // usersetupapprover.FindFirst();
    //     // UserSetupRec.get(usersetupapprover."User ID");
    //     // UserSetupRec.TestField("E-Mail");

    //     Recipient := 'NSC@auamed.org;studentservices@auamed.net';
    //     //CSPL-00307-BUG 13-04-23 Mail was going to wrong Receipient

    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := ApplicationNo + ' ' + 'Housing Application Submission';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear Residential Services Team,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to inform you that Housing Application #' + ' ' + ApplicationNo + ' ' + 'has been submitted by:');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Student Name :' + ' ' + Studentmaster."Student Name");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Enrolment No. :' + ' ' + Studentmaster."Enrollment No.");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Semester :' + ' ' + Studentmaster.Semester);
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Housing Application # :' + ' ' + ApplicationNo);
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please review the information in Business Central.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Thanking You,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody(Studentmaster."Student Name");
    //     //  SmtpMail.AppendtoBody('<br>');
    //     //   //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     if CompanyInformationRec."Send Email On/Off" then
    //         SMTPmail.send();
    // end;

    // procedure MailSendforHousingChangeSubmit(StudentNo: Code[20]; ApplicationNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     BodyText: text[2048];
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := ApplicationNo + ' ' + 'Housing Change Request Accepted';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name" + ' ' + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('We would like to inform you that your Housing Change Request #' + ' ' + ApplicationNo + ' ' + 'has been accepted. Please submit the room keys at the Residential Services office.');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('After the keys are submitted, Housing Inspection team will verify the Housing Inventory in the room and if any damages have been incurred during your stay. You shall be notified accordingly.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     //SmtpMail.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing', 'MEA', SenderAddress, Studentmaster."Student Name",
    //     Studentmaster."No.", Subject, BodyText, 'Housing Change Request', 'Housing Change Request Accepted', '', '',
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    procedure SalesforceHousingApplicationInsert(StudentNo: Code[20]; WithSpouse: Boolean; HostelPref1: Code[20]; HostelPref2: Code[20]; HostelPref3: Code[20]; RoomCategoryCode1: Code[20]; RoomCategoryCode2: Code[20];
    RoomCategoryCode3: Code[20]; HousingGroup1: code[20]; HousingGroup2: code[20]; HousingGroup3: code[20];
      PreferenceRemarks: Text[100]; RoomMateName: text[50]; RoomMateEmail: text[80]; EntryFromSalesforce: Boolean; HousingDepositDate: Date
      ; FlightDate: Date; FlightTime: Time; FlightNumber: text[20]; Airline: text[100]; DepartureDate: Date; AcadYear: Code[20]; Sem: Code[20]; PTerm: Option FALL,SPRIMG,SUMMER;
      MedicalCondition: Boolean; Disable: Boolean; TravelWithSpouse: Boolean; TravelWithSpouseChild: Boolean; TravelWithServicAnimal: Boolean; OtherBool: Boolean; OtherDesc: Text[250]; SpecialRoommatePref: Text[1024]) Return: Text[50]

    var
        HostelApplicationRec: Record "Housing Application";
        EducationSetupRec: Record "Education Setup-CS";
        StudentMasterRec: Record "Student Master-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ApplicationFound: Boolean;
    begin
        StudentMasterRec.Get(StudentNo);
        EducationSetupRec.Reset();
        EducationSetupRec.SetRange("Global Dimension 1 Code", StudentMasterRec."Global Dimension 1 Code");
        EducationSetupRec.FindFirst();
        EducationSetupRec.Testfield("Housing Application No.");
        ApplicationFound := false;
        HostelApplicationRec.RESET();
        HostelApplicationRec.SETRANGE("Student No.", StudentNo);
        HostelApplicationRec.SetRange(Semester, Sem);
        HostelApplicationRec.SetRange("Academic Year", AcadYear);
        HostelApplicationRec.SetRange(Term, PTerm);
        // HostelApplicationRec.Setrange(Posted, false);
        // HostelApplicationRec.SetRange(Status, HostelApplicationRec.Status::Vacated);
        IF HostelApplicationRec.FindLast() then
            IF HostelApplicationRec.Status = HostelApplicationRec.Status::Rejected then
                ApplicationFound := true;
        IF not HostelApplicationRec.FindFirst() then
            ApplicationFound := true;

        HostelApplicationRec.RESET();
        HostelApplicationRec.SETRANGE("Student No.", StudentNo);
        HostelApplicationRec.SetRange(Semester, Sem);
        HostelApplicationRec.SetRange("Academic Year", AcadYear);
        HostelApplicationRec.SetRange(Term, PTerm);
        // HostelApplicationRec.Setrange(Posted, false);
        // HostelApplicationRec.SetRange(Status, HostelApplicationRec.Status::Vacated);
        IF NOT HostelApplicationRec.FindFirst() THEN BEGIN
            iF ApplicationFound then begin
                HostelApplicationRec.Reset();
                HostelApplicationRec.INIT();
                HostelApplicationRec."Application No." := NoSeriesMgt.GetNextNo(EducationSetupRec."Housing Application No.", 0D, TRUE);
                HostelApplicationRec.Validate("Student No.", StudentNo);
                HostelApplicationRec."Application Date" := WORKDATE();
                HostelApplicationRec."Entry From Salesforce" := EntryFromSalesforce;
                if HousingDepositDate <> 0D then
                    HostelApplicationRec."Housing Deposit Date" := HousingDepositDate;
                HostelApplicationRec."With Spouse" := WithSpouse;
                HostelApplicationRec.Validate("Housing Pref. 1", HostelPref1);
                HostelApplicationRec.Validate("Housing Pref. 2", HostelPref2);
                HostelApplicationRec.Validate("Housing Pref. 3", HostelPref3);

                if HousingGroup1 <> '' then
                    HostelApplicationRec."Housing Group Pref.1" := HousingGroup1;
                if HousingGroup2 <> '' then
                    HostelApplicationRec."Housing Group Pref.2" := HousingGroup2;
                if HousingGroup3 <> '' then
                    HostelApplicationRec."Housing Group Pref.3" := HousingGroup3;
                HostelApplicationRec.Validate("Room Category Pref.1", RoomCategoryCode1);
                HostelApplicationRec.Validate("Room Category Pref.2", RoomCategoryCode2);
                HostelApplicationRec.Validate("Room Category Pref.3", RoomCategoryCode3);
                HostelApplicationRec."Preference Remarks" := PreferenceRemarks;
                HostelApplicationRec."Room Mate Name Pref" := RoomMateName;
                HostelApplicationRec."Room Mate Email Pref" := RoomMateEmail;
                HostelApplicationRec."Flight Arrival Date" := FlightDate;
                HostelApplicationRec."Flight Arrival Time" := FlightTime;
                HostelApplicationRec."Flight Number" := FlightNumber;
                HostelApplicationRec."Airline/Carrier" := Airline;
                HostelApplicationRec."Departure Date from Antigua" := DepartureDate;
                HostelApplicationRec.Status := HostelApplicationRec.Status::"Pending for Approval";
                HostelApplicationRec.Inserted := TRUE;
                HostelApplicationRec."Academic Year" := AcadYear;
                HostelApplicationRec.Semester := Sem;
                HostelApplicationRec.Term := PTerm;
                HostelApplicationRec."Medical Condition" := MedicalCondition;
                HostelApplicationRec.Disability := Disable;
                HostelApplicationRec."Traveling With Spouse" := TravelWithSpouse;
                HostelApplicationRec."Travel Spouse & Child" := TravelWithSpouseChild;
                HostelApplicationRec."Travel Ser. Animal" := TravelWithServicAnimal;
                HostelApplicationRec.Other := OtherBool;
                HostelApplicationRec."Other Description" := OtherDesc;
                HostelApplicationRec."Special Roommate Preference" := SpecialRoommatePref;
                If HostelApplicationRec.INSERT(true) then
                    EXIT('Success' + ' ' + HostelApplicationRec."Application No.")
                else
                    EXIT('Failed' + ' ' + HostelApplicationRec."Application No.");

            END ELSE
                exit('Duplicate');

        End;
    END;

    procedure SalesforceHousingApplicationInsertOther(StudentNo: Code[20]; WithSpouse: Boolean; HostelPref1: Code[20]; HostelPref2: Code[20]; HostelPref3: Code[20]; RoomCategoryCode1: Code[20]; RoomCategoryCode2: Code[20];
    RoomCategoryCode3: Code[20]; HousingGroup1: code[20]; HousingGroup2: code[20]; HousingGroup3: code[20];
      PreferenceRemarks: Text[100]; RoomMateName: text[50]; RoomMateEmail: text[80]; EntryFromSalesforce: Boolean; HousingDepositDate: Date
      ; FlightDate: Date; FlightTime: Time; FlightNumber: text[20]; Airline: text[100]; DepartureDate: Date) Return: Text[50]

    var
        HostelApplicationRec: Record "Housing Application";
        EducationSetupRec: Record "Education Setup-CS";
        StudentMasterRec: Record "Student Master-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        StudentMasterRec.Get(StudentNo);
        EducationSetupRec.Reset();
        EducationSetupRec.SetRange("Global Dimension 1 Code", StudentMasterRec."Global Dimension 1 Code");
        EducationSetupRec.FindFirst();
        EducationSetupRec.Testfield("Housing Application No.");
        HostelApplicationRec.RESET();
        HostelApplicationRec.SETRANGE("Student No.", StudentNo);
        HostelApplicationRec.Setrange(Posted, false);
        HostelApplicationRec.SetRange(Status, HostelApplicationRec.Status::Vacated);
        IF NOT HostelApplicationRec.FINDFIRST() THEN BEGIN
            HostelApplicationRec.INIT();
            HostelApplicationRec."Application No." := NoSeriesMgt.GetNextNo(EducationSetupRec."Housing Application No.", 0D, TRUE);
            HostelApplicationRec.Validate("Student No.", StudentNo);
            HostelApplicationRec."Application Date" := WORKDATE();
            HostelApplicationRec."Entry From Salesforce" := EntryFromSalesforce;
            if HousingDepositDate <> 0D then
                HostelApplicationRec."Housing Deposit Date" := HousingDepositDate;
            HostelApplicationRec."With Spouse" := WithSpouse;
            HostelApplicationRec.Validate("Housing Pref. 1", HostelPref1);
            HostelApplicationRec.Validate("Housing Pref. 2", HostelPref2);
            HostelApplicationRec.Validate("Housing Pref. 3", HostelPref3);

            if HousingGroup1 <> '' then
                HostelApplicationRec."Housing Group Pref.1" := HousingGroup1;
            if HousingGroup2 <> '' then
                HostelApplicationRec."Housing Group Pref.2" := HousingGroup2;
            if HousingGroup3 <> '' then
                HostelApplicationRec."Housing Group Pref.3" := HousingGroup3;
            HostelApplicationRec.Validate("Room Category Pref.1", RoomCategoryCode1);
            HostelApplicationRec.Validate("Room Category Pref.2", RoomCategoryCode2);
            HostelApplicationRec.Validate("Room Category Pref.3", RoomCategoryCode3);
            HostelApplicationRec."Preference Remarks" := PreferenceRemarks;
            HostelApplicationRec."Room Mate Name Pref" := RoomMateName;
            HostelApplicationRec."Room Mate Email Pref" := RoomMateEmail;
            HostelApplicationRec."Flight Arrival Date" := FlightDate;
            HostelApplicationRec."Flight Arrival Time" := FlightTime;
            HostelApplicationRec."Flight Number" := FlightNumber;
            HostelApplicationRec."Airline/Carrier" := Airline;
            HostelApplicationRec."Departure Date from Antigua" := DepartureDate;
            HostelApplicationRec.Status := HostelApplicationRec.Status::"Pending for Approval";
            HostelApplicationRec.Inserted := TRUE;
            // HostelApplicationRec."Academic Year" := AcadYear;
            // HostelApplicationRec.Semester := Sem;
            // HostelApplicationRec.Term := PTerm;
            If HostelApplicationRec.INSERT(true) then
                EXIT('Success' + ' ' + HostelApplicationRec."Application No.")
            else
                EXIT('Failed' + ' ' + HostelApplicationRec."Application No.");

        END ELSE
            exit('Duplicate');
    END;

    procedure WebAPIHousingWavierInsert(StudentNo: Code[20]; ApplicationType: Option "Bsic Opt Out","Housing Wavier","Make-Up","Restart","Appeal","Semester Registration";
    PresentAdd1: Text[50]; PresentAdd2: text[50]; PresentAdd3: Text[50]; LeaseAgrNo: code[20]; LeaseAgrGrp: Text[50];
    Transport: Boolean; TransportCell: Text[30]; PostCode: Code[20]; City: Text[30]; Country: Code[10]; SState: Text[30];
    Status: Option Open,"Pending for Approval",Approved,Rejected,Submit; EntryFromSalesforce: Boolean; AcadYear: Code[20]; Sem: Code[20]; PTerm: Option FALL,SPRIMG,SUMMER): Text[30]
    var
        OptOutRec: Record "Opt Out";
        EducationSetupCS: Record "Education Setup-CS";
        StudentHoldRec: Record "Student Hold";
        RecStudentWiseHold: Record "Student Wise Holds";
        StudentRec: Record "Student Master-CS";
        recStudentMaster: Record "Student Master-CS";
        RecCodeUnit50037: Codeunit "Hosusing Mail";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesForceCodeunit: Codeunit SLcMToSalesforce;
        DocNo: Code[20];
    begin
        StudentRec.Get(StudentNo);
        if ApplicationType <> ApplicationType::"Housing Wavier" then
            Error('Application Type must be Housing Waiver');
        if PresentAdd1 = '' then
            Error('Present Address 1 cannot be empty');
        /*    
        if PostCode = '' then
            Error('Post Code cannot be empty');
        if City = '' then
            Error('City cannot be empty');
        if SState = '' then
            Error('State cannot be empty');
        if Country = '' then
            Error('Country cannot be empty');
        */
        OptOutRec.Reset();
        OptOutRec.SetRange("Student No.", StudentRec."No.");
        OptOutRec.SetRange("Academic Year", AcadYear);
        OptOutRec.SetRange(Semester, Sem);
        OptOutRec.SetRange(Term, PTerm);
        OptOutRec.SetRange("Application Type", ApplicationType);
        IF OptOutRec.FindFirst() then
            exit('Duplicate');
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        If EducationSetupCS.FindFirst() Then
            EducationSetupCS.TestField(EducationSetupCS."Housing Opt Out No.");
        OptOutRec.Init();
        OptOutRec.Validate("Application No.", NoSeriesMgt.GetNextNo(EducationSetupCS."Housing Opt Out No.", 0D, TRUE));
        DocNo := '';
        DocNo := OptOutRec."Application No.";
        OptOutRec.Validate("Student No.", StudentNo);
        OptOutRec."Application Type" := ApplicationType;
        OptOutRec."Application Date" := WorkDate();
        OptOutRec."Entry From Salesforce" := EntryFromSalesforce;
        OptOutRec.Validate("Present Address1", PresentAdd1);
        OptOutRec.Validate("Present Address2", PresentAdd2);
        OptOutRec.Validate("Present Address3", PresentAdd3);
        OptOutRec.Validate("Lease Agreement/Contract No.", LeaseAgrNo);
        OptOutRec.Validate("Lease Agreement Group", LeaseAgrGrp);
        OptOutRec."Post Code" := PostCode;
        OptOutRec.City := City;
        OptOutRec.Validate(Country, Country);
        OptOutRec.Validate(County, SState);
        OptOutRec.Transportation := Transport;
        OptOutRec.Validate("Transport Cell", TransportCell);
        OptOutRec.Status := Status;
        OptOutRec.Status := OptOutRec.Status::Approved;
        OptOutRec."Approved/Rejected By" := Format(UserId());
        OptOutRec."Approved/Rejected On" := Today();
        OptOutRec."Academic Year" := AcadYear;
        OptOutRec.Semester := Sem;
        OptOutRec.Term := PTerm;

        recStudentMaster.Reset();
        recStudentMaster.SetRange("No.", OptOutRec."Student No.");
        recStudentMaster.SetRange("Academic Year", OptOutRec."Academic Year");
        recStudentMaster.SetRange(Semester, OptOutRec.Semester);
        IF recStudentMaster.FindFirst() then begin
            recStudentMaster.Address3 := OptOutRec."Present Address1";
            recStudentMaster.Address4 := OptOutRec."Present Address2";
            recStudentMaster."Cor Post Code" := OptOutRec."Post Code";
            recStudentMaster."Address To" := OptOutRec."Present Address3";
            recStudentMaster."Transport Facility" := OptOutRec.Transportation;
            recStudentMaster."Lease Agreement/Contract No." := OptOutRec."Lease Agreement/Contract No.";
            recStudentMaster."Lease Agreement Group" := OptOutRec."Lease Agreement Group";
            recStudentMaster."Cor City" := OptOutRec.City;
            recStudentMaster."Cor State" := OptOutRec.County;
            recStudentMaster."Cor Country Code" := OptOutRec.Country;
            recStudentMaster.Modify();
        end;
        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Global Dimension 1 Code", OptOutRec."Global Dimension 1 Code");
        StudentHoldRec.SetRange("Hold Type", StudentHoldRec."Hold Type"::Housing);
        StudentHoldRec.FindFirst();

        RecStudentWiseHold.Reset();
        RecStudentWiseHold.SetRange("Student No.", OptOutRec."Student No.");
        // RecStudentWiseHold.SetRange("Academic Year", OptOutRec."Academic Year");
        // RecStudentWiseHold.SetRange(Semester, OptOutRec.Semester);
        RecStudentWiseHold.SetRange("Hold Type", RecStudentWiseHold."Hold Type"::Housing);
        IF RecStudentWiseHold.FindFirst() then begin
            RecStudentWiseHold.Validate(Status, RecStudentWiseHold.Status::Disable);
            RecStudentWiseHold."Hold Description" := StudentHoldRec."Signoff Description";
            IF RecStudentWiseHold.Modify() then begin
                RecCodeUnit50037.HoldStatusLedgerEntryInsert(OptOutRec."Student No.", RecStudentWiseHold."Hold Code",
                RecStudentWiseHold."Hold Description", RecStudentWiseHold."Hold Type"::Housing, RecStudentWiseHold.Status);
            end;
        end;


        if OptOutRec.Insert(true) then begin
            exit('Success' + ' ' + OptOutRec."Application No.");
        end Else
            exit('Failed' + ' ' + OptOutRec."Application No.");


    end;

    procedure HousingAutomaticVacatebyStudentNo(StudentNo: Code[20])
    var

        HostelApplication: Record "Housing Application";

    begin
        HostelApplication.Reset();
        HostelApplication.SetRange("Student No.", StudentNo);
        HostelApplication.SetRange(Status, HostelApplication.Status::Approved);
        HostelApplication.SetRange(Posted, True);
        IF HostelApplication.FindFirst() then begin
            PostHousingVacate(HostelApplication."Student No.", HostelApplication."Application No.");
            PostApplicationNew(HostelApplication."Application No.", HostelApplication."Housing ID",
                HostelApplication."Room No.", HostelApplication."With Spouse");
        end;
    End;

    procedure ReturningStudentOnlineRegistrationEmail(StudentNo: Code[20])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
        JsonFilePath: File;
        JsonOutStream: OutStream;
    begin
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Mannual_OLR_Email_Sent?StudentNo=%1', StudentNo);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            Clear(RecCompanyInformation);

            // SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;

    procedure ManualOLREmail(StudentNo: Code[20])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
        JsonFilePath: File;
        JsonOutStream: OutStream;
    begin
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Email_Notification_Returning_Student?StudentNo_=%1', StudentNo);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            // SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;

    Procedure StudentMasterUpdateN(DocNo: Code[20]; StudentNo: Code[20]; Var StudentMaster_lRec: Record "Student Master-CS")
    Var
        OLRUpdateLine_lRec: Record "OLR Update Line";
        StudentRegistration_lRec: Record "Student Registration-CS";
        StudentRegistration_lRec1: Record "Student Registration-CS";
        UserSetup_lRec: Record "User Setup";
        EducationSetup_lRec: Record "Education Setup-CS";
        HousingApplication_lRec: Record "Housing Application";
        OptOut_lRec: Record "Opt Out";
        PaymentPlan_lRec: Record "Financial AID";
        Ferpa_lRec: Record "FERPA Details";
        HostelLedger_lREc: Record "Housing Ledger";
        MSPE_lRec: Record MSPE;
        StudentStatusMangCod: Codeunit "Student Status Mangement";
        WebServiceFn: Codeunit WebServicesFunctionsCSL;
    Begin
        // UserSetup_lRec.Reset();
        // UserSetup_lRec.SetRange("User ID", UserId());
        // IF UserSetup_lRec.FindFirst() then
        //     UserSetup_lRec.TestField("OLR Retuning Student Data Update");

        EducationSetup_lRec.Reset();
        IF EducationSetup_lRec.FindFirst() then begin
            OLRUpdateLine_lRec.Reset();
            If DocNo <> '' then
                OLRUpdateLine_lRec.SetFilter("Document No.", DocNo);
            IF StudentNo <> '' then
                OLRUpdateLine_lRec.Setfilter("Student No.", StudentNo);
            OLRUpdateLine_lRec.SetRange(Confirmed, True);
            //OLRUpdateLine_lRec.Setrange("Student Master Sync", False);
            OLRUpdateLine_lRec.SetRange("OLR Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
            OLRUpdateLine_lRec.SetRange("OLR Term", EducationSetup_lRec."Returning OLR Term");
            If OLRUpdateLine_lRec.Findset() then begin
                repeat
                    StudentRegistration_lRec.Reset();
                    StudentRegistration_lRec.SetRange("Student No", OLRUpdateLine_lRec."Student No.");
                    StudentRegistration_lRec.SetRange("Academic Year", OLRUpdateLine_lRec."OLR Academic Year");
                    StudentRegistration_lRec.SetRange(Term, OLRUpdateLine_lRec."OLR Term");
                    //StudentRegistration_lRec.SetRange(Semester, OLRUpdateLine_lRec."OLR Semester");
                    If StudentRegistration_lRec.FindFirst() then begin


                        // StudentMaster_lRec.Validate(Title, StudentRegistration_lRec.Title);
                        // StudentMaster_lRec.Validate("First Name", StudentRegistration_lRec."First Name");
                        // StudentMaster_lRec.Validate("Last Name", StudentRegistration_lRec."Last Name");
                        // StudentMaster_lRec.Validate("Middle Name", StudentRegistration_lRec."Middle Name");
                        // StudentMaster_lRec.Validate("Maiden Name", StudentRegistration_lRec."Maiden Name");
                        // StudentMaster_lRec.Validate("Social Security No.", StudentRegistration_lRec."Social Security No.");
                        // StudentMaster_lRec.Validate("Alternate Email Address", StudentRegistration_lRec."Alternate E-Mail Address");
                        // StudentMaster_lRec.Validate("Date of Birth", StudentRegistration_lRec."Date of Birth");
                        // StudentMaster_lRec.Validate(Gender, StudentRegistration_lRec.Gender);
                        // StudentMaster_lRec.Validate("Marital Status", StudentRegistration_lRec."Marital Status");
                        StudentMaster_lRec.Validate(Addressee, StudentRegistration_lRec."Street Address");
                        StudentMaster_lRec.Address1 := StudentRegistration_lRec."Address 2";
                        StudentMaster_lRec.Address2 := StudentRegistration_lRec."Address 3";
                        StudentMaster_lRec."Post Code" := StudentRegistration_lRec."Postal Code";
                        StudentMaster_lRec.City := StudentRegistration_lRec.City;
                        StudentMaster_lRec.State := StudentRegistration_lRec.State;
                        StudentMaster_lRec.Validate("Country Code", StudentRegistration_lRec."Country Code");
                        StudentMaster_lRec.Validate("Emergency Contact First Name", StudentRegistration_lRec."Emergency Contact First Name");
                        StudentMaster_lRec.Validate("Emergency Contact Last Name", StudentRegistration_lRec."Emergency Contact Last Name");
                        StudentMaster_lRec.Validate("Emergency Contact E-Mail", StudentRegistration_lRec."Emergency Contact E-Mail");
                        StudentMaster_lRec.Validate("Emergency Contact RelationShip", StudentRegistration_lRec."Emergency Contact RelationShip");
                        StudentMaster_lRec.Validate("Emergency Contact Phone No.", StudentRegistration_lRec."Emergency Contact Phone No.");
                        StudentMaster_lRec.Validate("Emergency Contact Phone No. 2", StudentRegistration_lRec."Emergency Contact Phone No. 2");
                        StudentMaster_lRec.Validate("Emergency Contact Address", StudentRegistration_lRec."Emergency Contact Address");
                        StudentMaster_lRec.Validate("Emergency Contact City", StudentRegistration_lRec."Emergency Contact City");
                        StudentMaster_lRec."Emergency Contact State" := StudentRegistration_lRec."Emergency Contact State";
                        StudentMaster_lRec.Validate("Emergency Contact Postal Code", StudentRegistration_lRec."Emergency Contact Postal Code");
                        StudentMaster_lRec.Validate("Emergency Contact Country Code", StudentRegistration_lRec."Emergency Contact Country Code");
                        StudentMaster_lRec.Validate("Local Emergency First Name", StudentRegistration_lRec."Local Emergency First Name");
                        StudentMaster_lRec.Validate("Local Emergency Last Name", StudentRegistration_lRec."Local Emergency Last Name");
                        StudentMaster_lRec.Validate("Local Emergency Street Address", StudentRegistration_lRec."Local Emergency Street Address");
                        StudentMaster_lRec.Validate("Local Emergency City", StudentRegistration_lRec."Local Emergency City");
                        StudentMaster_lRec."Local Emergency Phone No." := StudentRegistration_lRec."Local Emergency Phone No.";
                        StudentMaster_lRec.Validate(Remarks, StudentRegistration_lRec.Remarks);
                        StudentMaster_lRec.Validate(Nationality, StudentRegistration_lRec.Nationality);
                        StudentMaster_lRec.Validate(Citizenship, StudentRegistration_lRec.Citizenship);
                        StudentMaster_lRec.Validate(Ethnicity, StudentRegistration_lRec.Ethnicity);
                        StudentMaster_lRec.Validate("Name on Passport", StudentRegistration_lRec."Student Passport Full Name");
                        StudentMaster_lRec.Validate("Pass Port No.", StudentRegistration_lRec."Pass Port No. 1");
                        StudentMaster_lRec.Validate("Pass Port Issued By", StudentRegistration_lRec."Pass Port Issued By 1");
                        StudentMaster_lRec.Validate("Pass Port Issued Date", StudentRegistration_lRec."Pass Port Issued Date 1");
                        StudentMaster_lRec.Validate("Pass Port Expiry Date", StudentRegistration_lRec."Pass Port Expiry Date 1");
                        StudentMaster_lRec.Validate("Visa No.", StudentRegistration_lRec."Visa No.");
                        StudentMaster_lRec.Validate("Visa Issued Date", StudentRegistration_lRec."Visa Issued Date");
                        StudentMaster_lRec.Validate("Visa Expiry Date", StudentRegistration_lRec."Visa Expiry Date");
                        StudentMaster_lRec.Validate("Visa Extension Date", StudentRegistration_lRec."Visa Extension Date");
                        StudentMaster_lRec.Validate("Immigration Expiration Date", StudentRegistration_lRec."Immigration Expiration Date");
                        StudentMaster_lRec.Validate("Immigration Issuance Date", StudentRegistration_lRec."Immigration Issuance Date");
                        StudentMaster_lRec.Validate("Resident Address", StudentRegistration_lRec."Resident Address");
                        StudentMaster_lRec.Validate("Resident Country", StudentRegistration_lRec."Resident Country");
                        StudentMaster_lRec.Validate("Resident State", StudentRegistration_lRec."Resident State");
                        StudentMaster_lRec.Validate("Residency City", StudentRegistration_lRec."Resident City");
                        StudentMaster_lRec.Validate("Resident Zip Code", StudentRegistration_lRec."Resident Zip Code");
                        StudentMaster_lRec."Transport Allot" := StudentRegistration_lRec."Transport Allot";
                        StudentMaster_lRec.Validate("Transport Cell", StudentRegistration_lRec."Transport Cell");
                        StudentMaster_lRec.Validate("Media Release Sign-off", StudentRegistration_lRec."Media Release Sign-off");
                        StudentMaster_lRec.Validate("OLR Completed", StudentRegistration_lRec."OLR Completed");
                        StudentMaster_lRec.Validate("OLR Completed Date", StudentRegistration_lRec."OLR Completed Date");
                        StudentMaster_lRec.Validate("Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
                        StudentMaster_lRec.Validate(Term, EducationSetup_lRec."Returning OLR Term");
                        StudentMaster_lRec."FERPA Release" := StudentRegistration_lRec."FERPA Release";
                        StudentMaster_lRec."Ferpa Release Date" := StudentRegistration_lRec."Stage FERPA Date";
                        StudentMaster_lRec."MOU Agreement" := StudentRegistration_lRec."MOU Agreement";
                        StudentMaster_lRec."Lease Agreement" := StudentRegistration_lRec."Lease Agreement";
                        StudentMaster_lRec."Fathers Name" := StudentRegistration_lRec."Fathers Name";
                        StudentMaster_lRec."Father Contact Number" := StudentRegistration_lRec."Father Contact Number";
                        StudentMaster_lRec."Father Email ID" := StudentRegistration_lRec."Father Email ID";
                        StudentMaster_lRec."Mothers Name" := StudentRegistration_lRec."Mothers Name";
                        StudentMaster_lRec."Mother Contact Number" := StudentRegistration_lRec."Mother Contact Number";
                        StudentMaster_lRec."Mother Email ID" := StudentRegistration_lRec."Mother Email ID";
                        StudentMaster_lRec."Guardian Name" := StudentRegistration_lRec."Guardian Name";
                        StudentMaster_lRec."Guardian Contact Number" := StudentRegistration_lRec."Guardian Contact Number";
                        StudentMaster_lRec."Guardian Email ID" := StudentRegistration_lRec."Guardian Email ID";
                        // IF StudentMaster_lRec."OLR Completed" then
                        //     StudentMaster_lRec.Validate(Status, StudentStatusMangCod.NewDeferredStudentOnlineRegistration1(StudentMaster_lRec."No.", StudentMaster_lRec.Status, StudentMaster_lRec."Global Dimension 1 Code"));
                        //StudentMaster_lRec.Modify(true);
                        StudentMaster_lRec."Blackboard Synch Status" := StudentMaster_lRec."Blackboard Synch Status"::Pending;
                        IF StudentMaster_lRec."OLR Completed" then begin
                            OLRUpdateLine_lRec."Student Master Sync" := true;
                            OLRUpdateLine_lRec.Modify();
                        end;

                        StudentRegistration_lRec1.Reset();
                        StudentRegistration_lRec1.SetRange("Student No", StudentMaster_lRec."No.");
                        StudentRegistration_lRec1.SetRange("Academic Year", StudentMaster_lRec."Academic Year");
                        StudentRegistration_lRec1.SetRange(Term, StudentMaster_lRec.Term);
                        IF StudentRegistration_lRec1.FindFirst() then begin
                            StudentRegistration_lRec1.Rename(StudentMaster_lRec."No.", StudentMaster_lRec."Course Code", StudentMaster_lRec."Academic Year", StudentMaster_lRec.Semester, StudentMaster_lRec.Term);
                        end;

                        HousingApplication_lRec.Reset();
                        HousingApplication_lRec.SetRange("Student No.", StudentMaster_lRec."No.");
                        HousingApplication_lRec.SetRange("Academic Year", StudentMaster_lRec."Academic Year");
                        HousingApplication_lRec.SetRange(Term, StudentMaster_lRec.Term);
                        IF HousingApplication_lRec.FindFirst() then begin
                            HousingApplication_lRec.Semester := StudentMaster_lRec.Semester;
                            HousingApplication_lRec.Modify();
                        end;

                        HostelLedger_lREc.Reset();
                        HostelLedger_lREc.SetRange("Student No.", StudentMaster_lRec."No.");
                        HostelLedger_lREc.SetRange("Academic Year", StudentMaster_lRec."Academic Year");
                        HostelLedger_lREc.SetRange(Term, StudentMaster_lRec.Term);
                        IF HostelLedger_lREc.FindSet() then begin
                            repeat
                                HostelLedger_lREc.Semester := StudentMaster_lRec.Semester;
                                HostelLedger_lREc.Modify(true);
                            until HostelLedger_lREc.Next() = 0;
                        end;

                        OptOut_lRec.Reset();
                        OptOut_lRec.SetRange("Student No.", StudentMaster_lRec."No.");
                        OptOut_lRec.SetRange("Academic Year", StudentMaster_lRec."Academic Year");
                        OptOut_lRec.SetRange(Term, StudentMaster_lRec.Term);
                        IF OptOut_lRec.FindFirst() then begin
                            OptOut_lRec.Semester := StudentMaster_lRec.Semester;
                            OptOut_lRec.Modify();
                        end;
                        PaymentPlan_lRec.Reset();
                        PaymentPlan_lRec.SetRange("Student No.", StudentMaster_lRec."No.");
                        PaymentPlan_lRec.SetRange("Academic Year", StudentMaster_lRec."Academic Year");
                        PaymentPlan_lRec.SetRange(Term, StudentMaster_lRec.Term);
                        If PaymentPlan_lRec.FindFirst() then begin
                            PaymentPlan_lRec.Semester := StudentMaster_lRec.Semester;
                            PaymentPlan_lRec.Modify();
                        end;
                        Ferpa_lRec.Reset();
                        Ferpa_lRec.SetRange("Student No.", StudentMaster_lRec."No.");
                        Ferpa_lRec.SetRange("Academic Year", StudentMaster_lRec."Academic Year");
                        Ferpa_lRec.SetRange(Term, StudentMaster_lRec.Term);
                        IF Ferpa_lRec.FindFirst() then begin
                            Ferpa_lRec.Semester := StudentMaster_lRec.Semester;
                            Ferpa_lRec.Modify();

                        end;

                        MSPE_lRec.Reset();
                        MSPE_lRec.SetRange("Student No", StudentMaster_lRec."No.");
                        MSPE_lRec.SetFilter("Processing Status", '<>%1', MSPE_lRec."Processing Status"::Completed);
                        If MSPE_lRec.FindSet() then begin
                            repeat
                                MSPE_lRec.Semester := StudentMaster_lRec.Semester;
                                MSPE_lRec."Academic Year" := StudentMaster_lRec."Academic Year";
                                MSPE_lRec.Term := StudentMaster_lRec.Term;
                                MSPE_lRec.Modify();
                                WebServiceFn.MSPEFunction(MSPE_lRec, '', 0, 'OnAfterModifyEvent');
                            until MSPE_lRec.Next() = 0;
                        end;

                        OLRUpdateLine_lRec."OLR Semester" := StudentMaster_lRec.Semester;
                        OLRUpdateLine_lRec.Modify();
                        //13-07-2021
                        WebServiceFn.OLRReturningStudentEmailNotifyFn(OLRUpdateLine_lRec, False);
                        //13-07-2021

                        // end;
                    end;
                until OLRUpdateLine_lRec.Next() = 0;
            end;
        End;
    end;




    procedure HousingAutomaticVacateNew(HostelApplication: Record "Housing Application")
    var
        HousingChangeRequst: Record "Housing Change Request";
    begin
        PostHousingVacate(HostelApplication."Student No.", HostelApplication."Application No.");
        PostApplicationNew(HostelApplication."Application No.", HostelApplication."Housing ID",
            HostelApplication."Room No.", HostelApplication."With Spouse");
        // HousingChangeRequst.Reset();
        // HousingChangeRequst.SetRange("Original Application No.", HostelApplication."Application No.");
        // IF HousingChangeRequst.FindFirst() then
        //     HousingVacateButtonMail(HostelApplication, HousingChangeRequst);//CSPL-00307
    END;

    //CSPL-00307 Start
    // procedure HousingVacateButtonMail(HostelApplication: Record "Housing Application"; HousingChangeRequst: Record "Housing Change Request")
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     RecStudent: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     BodyText: Text;
    //     SenderName: Text;

    // begin
    //     SMTPMailSetup.GET;
    //     RecStudent.Get(HostelApplication."Student No.");
    //     RecStudent.TESTFIELD("E-Mail Address");
    //     Recipient := RecStudent."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailSetup."Email Address";
    //     //Recipient := 'mishma.kaushik@corporateserve.com';


    //     CLEAR(SMTPMail);
    //     SMTPMail.Create(SenderName, SenderAddress, Recipients, HousingChangeRequst."Application No." + ' Housing Vacated Confirmation!', '');
    //     Smtpmail.AppendtoBody('Dear ' + RecStudent."Student Name" + ',');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     SMTPMail.AppendtoBody('This is to inform you that your assigned AUA sponsored housing for Fall 2021 against Housing Application No. ' + HostelApplication."Application No." + ' has been vacated effective 20th December 2021!<br/><br/>');//Date is HardCoded as Per Mishma
    //     SMTPMail.AppendtoBody('We do hope your stay was a most enjoyable one and you enjoy your Holiday!<br/><br/>');
    //     SMTPMail.AppendtoBody('Students who have opted for AUA Housing during Online Registration will be informed when Assignment has been approved.<br/><br/>');
    //     SMTPMail.AppendtoBody('Please contact Residential Services for any clarifications');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     SMTPMail.AppendtoBody('Regards,<br/><br/>');
    //     SMTPMail.AppendtoBody('Residential Services Team');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     Smtpmail.Send();

    //     // MESSAGE('Mail sent');
    //     //FOR NOTIFICATION +
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Vacated', 'MEA', SenderAddress, RecStudent."Student Name",
    //     Format(RecStudent."No."), Subject, BodyText, 'Housing Vacated', 'Housing Vacated', HostelApplication."Application No.", Format(HostelApplication."Application Date"),
    //     Recipient, 1, RecStudent."Mobile Number", '', 1);
    //     //FOR NOTIFICATION -
    // end;


    // procedure SendEmailtoVacateAllStudents(HostelApplication: Record "Housing Application")
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     BodyText: Text;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     RecStudent: Record "Student Master-CS";
    // // HostelApplication: Record "Housing Application";
    // begin
    //     // HostelApplication.Reset();
    //     // HostelApplication.SetRange(Status, HostelApplication.Status::Approved);
    //     // IF HostelApplication.FindSet() then begin
    //     //     repeat
    //     SMTPMailSetup.GET;
    //     HostelApplication.TestField(Term, HostelApplication.Term::FALL);
    //     HostelApplication.TestField("Academic Year", '2021');
    //     HostelApplication.TestField(Status, HostelApplication.Status::Approved);
    //     RecStudent.Get(HostelApplication."Student No.");
    //     // IF (RecStudent.Term = RecStudent.Term::FALL) AND (RecStudent."Academic Year" = '2021') then begin
    //     RecStudent.TESTFIELD("E-Mail Address");
    //     Recipient := RecStudent."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderAddress := SmtpMailSetup."Email Address";
    //     //Recipient := 'mishma.kaushik@corporateserve.com;lucky.kumar@corporateserve.com';

    //     CLEAR(SMTPMail);
    //     SMTPMail.Create('MEA', SmtpMailSetup."Email Address", Recipients, 'Housing Vacate Alert!', '');
    //     Smtpmail.AppendtoBody('Dear ' + RecStudent."Student Name" + ',');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     SMTPMail.AppendtoBody('This is to inform you that your date to vacate AUA Sponsored housing is by Monday 20th December 2021.<br/><br/>');//Date is HardCoded as Per Mishma
    //     SMTPMail.AppendtoBody('Students who have opted for AUA Sponsored Housing during Online Registration will be informed when Housing Assignment has been approved.<br/><br/>');
    //     SMTPMail.AppendtoBody('Please contact Residential Services for more information.<br/><br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     // Smtpmail.AppendtoBody('<br/>');
    //     SMTPMail.AppendtoBody('Regards,<br/><br/>');
    //     SMTPMail.AppendtoBody('Residential Services Team');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     Smtpmail.Send();

    //     // MESSAGE('Mail sent');
    //     //FOR NOTIFICATION +
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Vacate Alert', 'MEA', SenderAddress, RecStudent."Student Name",
    //     Format(RecStudent."No."), Subject, BodyText, 'Housing Vacate Alert', 'Housing Vacate Alert', HostelApplication."Application No.", Format(HostelApplication."Application Date"),
    //     Recipient, 1, RecStudent."Mobile Number", '', 1);
    //     //FOR NOTIFICATION -
    //     // end;
    //     // until HostelApplication.Next() = 0;
    //     //end;
    // end;

    Procedure CheckHousingApplication(StudentNo: Code[20]; Sem: Code[20]; AcaYear: Code[20]; pTerm: Option FALL,SPRING,SUMMER)
    var
        HousingApplication_lRec: Record "Housing Application";
    Begin
        HousingApplication_lRec.Reset();
        HousingApplication_lRec.SetRange("Student No.", StudentNo);
        HousingApplication_lRec.SetRange("Academic Year", AcaYear);
        HousingApplication_lRec.SetRange(Term, pTerm);
        HousingApplication_lRec.SetRange(Semester, Sem);
        HousingApplication_lRec.SetFilter(Status, '%1', HousingApplication_lRec.Status::Approved);
        If HousingApplication_lRec.FindFirst() then
            Error('Housing Application : %1 already approved for Student : %2 whose Academic Year : %3 , Term : %4 and Status : %5', HousingApplication_lRec."Application No.", HousingApplication_lRec."Student No.", HousingApplication_lRec."Academic Year", HousingApplication_lRec.Term, HousingApplication_lRec.Status);

    End;

    procedure CheckHousingWaiver(StudentNo: Code[20]; Sem: Code[20]; AcaYear: Code[20]; pTerm: Option FALL,SPRING,SUMMER)
    var
        OptOut_lRec: Record "Opt Out";
    Begin
        OptOut_lRec.Reset();
        OptOut_lRec.SetRange("Student No.", StudentNo);
        OptOut_lRec.Setrange(Semester, Sem);
        OptOut_lRec.SetRange("Academic Year", AcaYear);
        OptOut_lRec.SetRange(Term, pTerm);
        OptOut_lRec.SetFilter(Status, '%1', OptOut_lRec.Status::Approved);
        IF OptOut_lRec.FindFirst() then
            Error('Housing Waiver : %1 already approved for Student : %2 whose Academic Year : %3 , Term : %4 and Status : %5', OptOut_lRec."Application No.", OptOut_lRec."Student No.", OptOut_lRec."Academic Year", OptOut_lRec.Term, OptOut_lRec.Status);

    End;
}


