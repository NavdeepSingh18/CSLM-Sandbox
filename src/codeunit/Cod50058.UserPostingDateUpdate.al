codeunit 50058 "Users Posting Date Update"
{
    trigger OnRun()
    begin
        updateusersetuppostingdate();

        UpdateSemesterDate();

        SynceSiteVisitDoc_to_StudentDocumentAttachment();
        // CLNDocumentExpireNotice();//CSPL-00307 -11-01-2023 
    end;

    var
        userapproversetup: Record "Document Approver Users";
        usersetup: record "User Setup";

    procedure updateusersetuppostingdate()
    Var
        Date_lRec: Record Date;
        VDate: Date;
    begin
        userapproversetup.Reset();
        if userapproversetup.FindSet() then
            repeat
                if userapproversetup."Department Approver Type" in [userapproversetup."Department Approver Type"::"Bursar Department",
                    userapproversetup."Department Approver Type"::"Financial Aid Department", userapproversetup."Department Approver Type"::BackOffice] then begin

                    usersetup.get(userapproversetup."User ID");
                    Date_lRec.Reset();
                    Date_lRec.SetRange("Period Type", Date_lRec."Period Type"::Date);
                    Date_lRec.SetRange("Period Start", Today());
                    IF Date_lRec.FindFirst() then begin
                        If Date_lRec."Period Name" = 'Monday' then
                            VDate := CalcDate('<-3D>', Today())
                        Else
                            VDate := CalcDate('<-1D>', Today());

                    end;
                    //usersetup."Allow Posting From" := calcdate('-1D', today);
                    usersetup."Allow Posting From" := VDate;
                    //usersetup."Allow Posting To" := today;
                    usersetup.modify();
                end;
            until userapproversetup.Next() = 0;
    end;

    procedure UpdateSemesterDate()
    var
        StudentMaster: Record "Student Master-CS";
        ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
    begin
        StudentMaster.Reset();
        StudentMaster.SetFilter("Original Student No.", '<>%1&<>%2', '68074', '2001148');
        if StudentMaster.FindSet() then
            repeat
            // ClinicalBaseAppSubscribe.SemesterProgression(StudentMaster, false);
            until StudentMaster.Next() = 0;
    end;

    procedure CLNDocumentExpireNotice()
    var
        StudentMaster: Record "Student Master-CS";
        ClincalNotification: Codeunit "Clinical Notification";
    begin
        //CSPL-00307
        StudentMaster.Reset();
        StudentMaster.SetRange("Global Dimension 1 Code", '9000');
        StudentMaster.Setfilter(Semester, 'BSIC|CLN5|CLN6|CLN7|CLN8');
        StudentMaster.SetFilter(Status, 'ATT|CLOA|PROB|REENTRY|SUS|TEMP|TWD|RADM');
        If StudentMaster.FindSet() then
            repeat
            // ClincalNotification.UpdatesToClinicalDocumentsRequired(StudentMaster."No.");
            // IF Date2DMY(WorkDate(), 1) in [15, 30] then
            //     ClincalNotification.DocumentUpdatesDue(StudentMaster."No.");
            until StudentMaster.Next() = 0;
    end;

    procedure SynceSiteVisitDoc_to_StudentDocumentAttachment()
    var
        SDA: Record "Student Document Attachment";
        FC: Record "Faculty Choice";
        EntryNo: Integer;
    begin
        FC.Reset();
        FC.SetRange("SDA Synced", false);
        FC.SetFilter("SDA Entry No", '0');
        if FC.FindSet(true) then
            repeat
                SDA.Reset();
                if SDA.FindLast() then
                    EntryNo := SDA."Entry No.";
                EntryNo := EntryNo + 1;
                clear(SDA);
                SDA.Init();
                SDA."Entry No." := EntryNo;
                SDA."Document Category" := FC."Document Category";
                SDA."Document Sub Category" := FC."Document Sub Category";
                SDA.Description := FC.Description;
                SDA."Document Description" := FC."Document Description";
                SDA.Validate("Student No.", FC."Student No.");
                SDA."Student Name" := FC."Student Name";
                //SDA."Subject Code" := Speciality;
                SDA."SLcM Document No" := FC."Faculty Code";
                SDA."Transaction No." := FC."Transaction No.";
                SDA."Note Entry No" := -100;
                SDA."File Name" := FC."File Name";
                SDA."Uploaded Source" := FC."Uploaded Source";
                SDA."Document Status" := FC."Document Status";
                SDA."Submission Date" := FC."Submission Date";
                SDA."Uploaded By" := FC."Uploaded By";
                SDA."Uploaded On" := FC."Uploaded On";
                SDA."Document Update Date" := FC."Document Update Date";
                if SDA.Insert(true) then begin
                    FC."SDA Synced" := true;
                    FC."SDA Entry No" := EntryNo;
                    FC.Modify();
                end;
            until FC.Next() = 0;
    end;

}