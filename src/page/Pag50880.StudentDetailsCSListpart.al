page 50880 "Student Details-CS LP"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                                             Remarks
    // 1         CSPL-00092    29-05-2019    <Action1102155025> - OnAction                       Page Run
    // 2         CSPL-00092    29-05-2019    Student Data Upload - OnAction                      XMLPort Run
    // 3         CSPL-00092    29-05-2019    Update Student Details - OnAction                   XMLPort Run
    // 4         CSPL-00092    29-05-2019    Send Data to Portal - OnAction                      Call Sql Procedure to Send data to Portal Database
    // 5         CSPL-00092    29-05-2019    Not Completed Lower Semester(NCL) - OnAction        Find and update Disability False for Student Not Completed Lower Semester(NCL)

    Caption = 'Student Listpart';
    CardPageID = "Student Detail Card-CS";
    Editable = false;
    ModifyAllowed = false;
    PageType = ListPart;
    // PromotedActionCategories = 'New,Process,Navigate,Admissions,Registrar/Academics,Clinical,Housing/Immigration,Bursar/Finance,Financial Aid,EED Pre-Clinical,EED Clinical Science,Graduate Affairs,Feedback';
    SourceTable = "Student Master-CS";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending);
    UsageCategory = none;

    layout
    {
        area(content)
        {
            repeater(Group1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Admitted Year"; Rec."Admitted Year")
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("OLR Completed"; Rec."OLR Completed")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Parent Student No."; Rec."Parent Student No.")
                {
                    ApplicationArea = All;
                }
                field("Financial Aid Approved"; Rec."Financial Aid Approved")
                {
                    ApplicationArea = All;
                    Visible = Bool;
                }
                field("Payment Plan Applied"; Rec."Payment Plan Applied")
                {
                    ApplicationArea = All;
                }
                field("Payment Plan Instalment"; Rec."Payment Plan Instalment")
                {
                    ApplicationArea = All;
                }
                field("Self Payment Applied"; Rec."Self Payment Applied")
                {
                    ApplicationArea = All;
                }
                field("Customer Exists"; Rec."Customer Exists")
                {
                    ApplicationArea = All;
                }
                field("Housing Hold"; Rec."Housing Hold")
                {
                    ApplicationArea = All;
                }
                field("Bursar Hold"; Rec."Bursar Hold")
                {
                    ApplicationArea = All;
                }
                field("Financial Aid Hold"; Rec."Financial Aid Hold")
                {
                    ApplicationArea = All;
                    Visible = Bool;
                }
                field("Registrar Hold"; Rec."Registrar Hold")
                {
                    ApplicationArea = All;
                }
                field("Immigration Hold"; Rec."Immigration Hold")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        usersetupapprover: Record "Document Approver Users";
    begin
        Bool := true;

        UserSetup.Get(UserId());
        If UserSetup."Global Dimension 1 Code" = '9100' then
            Bool := false;
        Rec.FilterGroup(2);
        Rec.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        Rec.FilterGroup(0);

        FinancialAid_GBoo := false;
        CourseHoldVisible := false;

        if CourseMaster.Get(Rec."Course Code") then
            if CourseMaster."Financial AID Applicable" then begin
                FinancialAid_GBoo := true;
                CourseHoldVisible := true;
            end;

        RegistrarHoldVisible := false;
        BursarHoldVisible := false;
        FinancialAIDHoldVisible := false;
        ImmigrationHoldVisible := false;

        if usersetupapprover.get(userid(), usersetupapprover."Department Approver Type"::"Registrar Department") then
            RegistrarHoldVisible := true
        else
            if usersetupapprover.get(userid(), usersetupapprover."Department Approver Type"::"Bursar Department") then
                BursarHoldVisible := true
            else
                if usersetupapprover.get(userid(), usersetupapprover."Department Approver Type"::"Financial Aid Department") then
                    FinancialAIDHoldVisible := true
                else
                    if usersetupapprover.get(userid(), usersetupapprover."Department Approver Type"::"Student Services") then
                        ImmigrationHoldVisible := true;
        // if UserSetup.Get(UserId()) then begin
        //     if UserSetup."Department Approver" = UserSetup."Department Approver"::"Registrar Department" then
        //         RegistrarHoldVisible := true;
        //     if UserSetup."Department Approver" = UserSetup."Department Approver"::"Bursar Department" then
        //         BursarHoldVisible := true;
        //     if UserSetup."Department Approver" = UserSetup."Department Approver"::"Financial Aid Department" then
        //         FinancialAIDHoldVisible := true;
        //     if UserSetup."Department Approver" = UserSetup."Department Approver"::"Immigration Department" then
        //         ImmigrationHoldVisible := true;
        // end;
        if (FinancialAIDHoldVisible) and (CourseHoldVisible) then
            FinCourseHoldVisible := true
        else
            FinCourseHoldVisible := false;
    end;
    /*
        trigger OnAfterGetRecord();
        begin
            FinancialAid_GBoo := false;
            CourseHoldVisible := false;

            if CourseMaster.Get(Rec."Course Code") then
                if CourseMaster."Financial AID Applicable" then begin
                    FinancialAid_GBoo := true;
                    CourseHoldVisible := true;
                end;

            RegistrarHoldVisible := false;
            BursarHoldVisible := false;
            FinancialAIDHoldVisible := false;
            ImmigrationHoldVisible := false;
            if UserSetup.Get(UserId()) then begin
                if UserSetup."Department Approver" = UserSetup."Department Approver"::"Registrar Department" then
                    RegistrarHoldVisible := true;
                if UserSetup."Department Approver" = UserSetup."Department Approver"::"Bursar Department" then
                    BursarHoldVisible := true;
                if UserSetup."Department Approver" = UserSetup."Department Approver"::"Financial Aid Department" then
                    FinancialAIDHoldVisible := true;
                if UserSetup."Department Approver" = UserSetup."Department Approver"::"Immigration Department" then
                    ImmigrationHoldVisible := true;
            end;
            if (FinancialAIDHoldVisible) and (CourseHoldVisible) then
                FinCourseHoldVisible := true
            else
                FinCourseHoldVisible := false;
        end;

        trigger OnAfterGetCurrRecord()
        begin
            FinancialAid_GBoo := false;
            CourseHoldVisible := false;

            if CourseMaster.Get(Rec."Course Code") then
                if CourseMaster."Financial AID Applicable" then begin
                    FinancialAid_GBoo := true;
                    CourseHoldVisible := true;
                end;

            RegistrarHoldVisible := false;
            BursarHoldVisible := false;
            FinancialAIDHoldVisible := false;
            ImmigrationHoldVisible := false;
            if UserSetup.Get(UserId()) then begin
                if UserSetup."Department Approver" = UserSetup."Department Approver"::"Registrar Department" then
                    RegistrarHoldVisible := true;
                if UserSetup."Department Approver" = UserSetup."Department Approver"::"Bursar Department" then
                    BursarHoldVisible := true;
                if UserSetup."Department Approver" = UserSetup."Department Approver"::"Financial Aid Department" then
                    FinancialAIDHoldVisible := true;
                if UserSetup."Department Approver" = UserSetup."Department Approver"::"Immigration Department" then
                    ImmigrationHoldVisible := true;
            end;
            if (FinancialAIDHoldVisible) and (CourseHoldVisible) then
                FinCourseHoldVisible := true
            else
                FinCourseHoldVisible := false;
        end;
*/
    var
        RecHoldStatusLedger: Record "Hold Status Ledger";
        StudentMasterCS: Record "Student Master-CS";
        UserSetup: Record "User Setup";
        CourseMaster: Record "Course Master-CS";
        RecCodeUnit50037: Codeunit "Hosusing Mail";
        HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance";
        StudentCount: Integer;
        Bool: Boolean;
        RegistrarHoldVisible: Boolean;
        BursarHoldVisible: Boolean;
        FinancialAIDHoldVisible: Boolean;
        ImmigrationHoldVisible: Boolean;
        FinCourseHoldVisible: Boolean;
        CourseHoldVisible: Boolean;
        FinancialAid_GBoo: Boolean;
        Text005Lbl: Label 'Do you want to change student group for selected students?';
        Text006Lbl: Label 'Do you want to change student group for Student No. %1?';
        Text007Lbl: Label 'The selected Students, group has been changed.';
        Text008Lbl: Label 'Student No. %1 group has been changed.';
        Text009Lbl: Label 'Do you want to map the course for selected students?';
        Text010Lbl: Label 'Do you want to map the course for Student No. %1?';
        Text011Lbl: Label 'The selected Students, course has been Mapped.';
        Text012Lbl: Label 'Student No. %1 course has been Mapped.';
        Text0013Lbl: Label 'Do you want to enable the Registrar Hold for selected Students?';
        Text0014Lbl: Label 'Do you want to enable the Registrar Hold for Student No. %1';
        Text0015Lbl: Label 'Registrar Hold enabled for selected students.';
        Text0016Lbl: Label 'Registrar Hold enabled for Student No. %1';
        Text0017Lbl: Label 'Do you want to disable the Registrar Hold for selected Students?';
        Text0018Lbl: Label 'Do you want to disable the Registrar Hold for Student No. %1';
        Text0019Lbl: Label 'Registrar Hold disabled for selected students.';
        Text0020Lbl: Label 'Registrar Hold disabled for Student No. %1';

    procedure BursarSignoff(StudentRec: Record "Student Master-CS")
    Var
        HoldUserMappingRec: Record "Holds User Mapping";
        StudentWiseHoldRec: Record "Student Wise Holds";
        StudentHoldRec: Record "Student Hold";
        StudentMaster_lRec: Record "Student Master-CS";
        RSL: Record "Roster Scheduling Line";
        HoldCount: Integer;

    begin
        HoldUserMappingRec.Reset();
        HoldUserMappingRec.SetRange("User ID", UserId());
        if HoldUserMappingRec.FindFirst() then begin

            // if HousingHoldCheck(StudentRec."No.") = true then
            //     error('Housing Hold is still Enable.');
            // if CheckFeeGeneration(StudentRec."No.") = False then (Block for Michael Bucher dated 14April2021)
            //     error('Fee is not Generated or all components of fee is not Generated');

            StudentMaster_lRec.Reset();
            StudentMaster_lRec.SetRange("Original Student No.", StudentRec."Original Student No.");
            If StudentMaster_lRec.FindSet() then begin
                Repeat
                    StudentHoldRec.Reset();
                    StudentHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                    StudentHoldRec.SetRange("Hold Type", StudentHoldRec."Hold Type"::Bursar);
                    IF StudentHoldRec.FindFirst() then begin
                        StudentWiseHoldRec.Reset();
                        StudentWiseHoldRec.SetRange("Student No.", StudentMaster_lRec."No.");
                        StudentWiseHoldRec.SetRange(StudentWiseHoldRec."Hold Type", StudentWiseHoldRec."Hold Type"::Bursar);
                        if StudentWiseHoldRec.FINDFIRST() then begin
                            StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Disable);
                            StudentWiseHoldRec."Hold Description" := StudentHoldRec."Signoff Description";
                            StudentWiseHoldRec.Modify();
                            RecCodeUnit50037.HoldStatusLedgerEntryInsert(StudentMaster_lRec."No.", StudentWiseHoldRec."Hold Code",
                        StudentWiseHoldRec."Hold Description", StudentWiseHoldRec."Hold Type"::Bursar, StudentWiseHoldRec.Status);
                            RSL.AutoPublishedRotation_On_CLN_Hold_Removed(StudentMaster_lRec);//CSPL-00307-RTP // As per Ajay 15-03-23
                        end;
                    end;
                until StudentMaster_lRec.Next() = 0;
            end;
            CurrPage.Update();
        end else
            Error('You do not have the permission to disable the Bursar Signoff');
    end;
}