xmlport 50000 "Temporary Housing Update"
{
    // version V.001-CS

    FieldSeparator = ',';
    Format = VariableText;
    Caption = 'Temporary Housing Upload';
    Direction = Import;
    UseRequestPage = false;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Integer; Integer)
            {

                textelement(SLcMNo)
                {
                    MinOccurs = Zero;
                }
                // Textelement(EnrollmentNo)
                // {
                //     MinOccurs = Zero;
                // }
                textelement(HousingName)
                {
                    MinOccurs = Zero;
                }
                textelement(ApartmentNo)
                {
                    MinOccurs = Zero;
                }
                textelement(RoomNo)
                {
                    MinOccurs = Zero;
                }
                textelement(ApartmentCategory)
                {
                    MinOccurs = Zero;
                }

                trigger OnBeforeInsertRecord()
                var
                    StudentMaster_lRec: Record "Student Master-CS";
                    EducationSetup: Record "Education Setup-CS";
                    HousingApplication: Record "Housing Application";
                    WebServiceCU: Codeunit WebServicesFunctionsCSL;
                    CourseFilter: Text;
                Begin
                    If SkipFirstLine then begin
                        SkipFirstLine := False;
                    end ELSE begin
                        StudentMaster_lRec.Reset();
                        StudentMaster_lRec.SetRange("No.", SLcMNo);
                        IF StudentMaster_lRec.FindFirst() then begin

                            EducationSetup.Reset();
                            EducationSetup.SetRange("Pre Housing App. Allowed", true);
                            EducationSetup.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                            IF EducationSetup.FindFirst() then begin
                                HousingApplication.Reset();
                                HousingApplication.SetRange("Student No.", SLcMNo);
                                HousingApplication.SetRange("Academic Year", EducationSetup."Returning OLR Academic Year");
                                HousingApplication.SetRange(Term, EducationSetup."Returning OLR Term");
                                IF HousingApplication.FindFirst() then begin
                                    IF HousingApplication.Status = HousingApplication.Status::"Pending for Approval" then begin
                                        //CSPL-00307-Housing_AutoPreference
                                        CheckValidations();
                                        UpdatePreference(HousingApplication);
                                        //CSPL-00307-Housing_AutoPreference
                                        StudentMaster_lRec."Temporary Housing Name" := HousingName;
                                        StudentMaster_lRec."Temporary Apartment No." := ApartmentNo;
                                        StudentMaster_lRec."Temporary Room No." := RoomNo;
                                        StudentMaster_lRec."Temprary Housing Email Sent" := true;
                                        StudentMaster_lRec.Modify(true);
                                        HousingApplication."Temporary Housing Name" := StudentMaster_lRec."Temporary Housing Name";
                                        HousingApplication."Temporary Apartment No." := StudentMaster_lRec."Temporary Apartment No.";
                                        HousingApplication."Temporary Room No." := StudentMaster_lRec."Temporary Room No.";
                                        HousingApplication."Room Category Code" := ApartmentCategory;
                                        HousingApplication.Updated := true;
                                        HousingApplication.Status := HousingApplication.Status::Assigned;
                                        HousingApplication.Modify();
                                        //For Email Trigger API
                                        WebServiceCU.Save_Update_TentativeHousingAllotmentAlert(HousingApplication);
                                        Commit(); //this is placed beacuse we cant roll back emails that already send using above api
                                    end;
                                end Else
                                    Error('Housing Application does not exist whose Student No.: %1 , Academic Year: %2 , Term: %3', StudentMaster_lRec."No.", EducationSetup."Returning OLR Academic Year", Format(EducationSetup."Returning OLR Term"));
                            end;

                            //StudentHostelAssignMail(StudentMaster_lRec);
                        end;
                    end;
                    currXMLport.Skip();
                End;
            }
        }
    }
    // procedure StudentHostelAssignMail(Rec: Record "Student Master-CS")
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     RecHousing: record "Housing Master";
    //     RecRoomMaster: Record "Room Master";
    //     educationsetup: Record "Education Setup-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     HostelNo: Code[20];
    //     AddCCmail: List of [Text];
    //     addccmailtext: text;
    //     BodyText: Text;
    // begin
    //     HostelApplication.Reset();
    //     HostelApplication.SetRange("Student No.", Rec."No.");
    //     HostelApplication.SetRange(Status, HostelApplication.Status::"Pending for Approval");
    //     IF HostelApplication.FindFirst() then begin
    //         // HostelApplication.Get(st);
    //         SmtpMailRec.Get();
    //         Studentmaster.GET(HostelApplication."Student No.");
    //         Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //         // HostelApplication.CalcFields("Temporary Housing Name", "Temporary Apartment No.", "Temporary Room No.");

    //         Recipient := Studentmaster."E-Mail Address";
    //         if HostelApplication."Pref. 1 Selected" then
    //             HostelNo := HostelApplication."Housing Pref. 1";
    //         if HostelApplication."Pref. 2 Selected" then
    //             HostelNo := HostelApplication."Housing Pref. 2";
    //         if HostelApplication."Pref. 3 Selected" then
    //             HostelNo := HostelApplication."Housing Pref. 3";


    //         RecHousing.Get(HostelNo);
    //         RecRoomMaster.Get(HostelNo, HostelApplication."Room No.");
    //         Recipients := Recipient.Split(';');
    //         SenderAddress := SmtpMailRec."Email Address";

    //         Subject := HostelApplication."Housing ID" + ' ' + 'AUA Housing Assignment Approval Letter';
    //         SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //         SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ',');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('We are pleased to inform you that you have been allotted tentative Housing until the final confirmation');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Please find the details below:');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Housing Name: ' + HostelApplication."Temporary Housing Name");
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Apartment Number: ' + HostelApplication."Temporary Apartment No.");
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Room Number: ' + HostelApplication."Temporary Room No.");
    //         SmtpMail.AppendtoBody('<br><br>');

    //         SmtpMail.AppendtoBody('Please contact Residential Services regarding any further information.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Regards,');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Residential Services Team ');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //         BodyText := SmtpMail.GetBody();
    //         if addccmailtext <> '' then
    //             SmtpMail.AddCC(AddCCmail);
    //         Mail_lCU.Send();
    //     end;
    // end;


    //CSPL-00307-Housing_AutoPreference
    local procedure CheckValidations()
    var
        RecHousing: Record "Housing Master";
        RoomCategoryMaster: Record "Room Category Master";
    // RoomMaster: Record "Room Master";
    begin
        RecHousing.Get(HousingName);
        RoomCategoryMaster.Get(ApartmentCategory);
    end;

    local procedure UpdatePreference(var HousingApplication: Record "Housing Application")
    var
        // myInt: Integer;
        RoomMaster: Record "Room Master";
        RoomWiseBedRec: Record "Room Wise Bed";
    begin
        IF (HousingName = HousingApplication."Housing Pref. 1") AND (ApartmentCategory = HousingApplication."Room Category Pref.1") then
            HousingApplication.Validate("Pref. 1 Selected", true)
        else
            IF (HousingName = HousingApplication."Housing Pref. 2") AND (ApartmentCategory = HousingApplication."Room Category Pref.2") then
                HousingApplication.Validate("Pref. 2 Selected", true)
            else
                IF (HousingName = HousingApplication."Housing Pref. 3") AND (ApartmentCategory = HousingApplication."Room Category Pref.3") then
                    HousingApplication.Validate("Pref. 3 Selected", true)
                else begin
                    HousingApplication.Validate("Housing Pref. 3", HousingName);
                    HousingApplication.validate("Room Category Pref.3", ApartmentCategory);
                    HousingApplication.Validate("Pref. 3 Selected", true);
                end;

        RoomMaster.Reset();
        if HousingApplication."Pref. 1 Selected" then
            RoomMaster.SetRange("Housing ID", HousingApplication."Housing Pref. 1")
        else
            if HousingApplication."Pref. 2 Selected" then
                RoomMaster.SetRange("Housing ID", HousingApplication."Housing Pref. 2")
            else
                if HousingApplication."Pref. 3 Selected" then
                    RoomMaster.SetRange("Housing ID", HousingApplication."Housing Pref. 3");
        RoomMaster.SetRange("Room Category Code", HousingApplication."Room Category Code");
        RoomMaster.SetRange("Room No.", ApartmentNo);
        RoomMaster.FindFirst(); // to check apartment exist
        HousingApplication."Room No." := ApartmentNo;
        HousingApplication."Bed No." := RoomNo;
        RoomWiseBedRec.Reset();
        RoomWiseBedRec.SetRange("Bed No.", HousingApplication."Bed No.");
        RoomWiseBedRec.FindFirst(); // to check room exist
        HousingApplication."Bed Size" := RoomWiseBedRec."Bed Size"
    end;

    trigger OnPostXmlPort()
    var
    // myInt: Integer;
    begin
        Message('Uploaded Successfully');
    end;

    var
        HostelApplication: Record "Housing Application";
        Counter: Integer;
        Window: Dialog;
        CounterTotal: Integer;
        CounterOK: Integer;
        FirstLine: Boolean;
        Text0001Lbl: Label 'Uploading Students  #1########## @2@@@@@@@@@@@@@';

        SkipFirstLine: Boolean;

}