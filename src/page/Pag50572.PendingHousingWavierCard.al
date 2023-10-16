page 50572 "Pending Housing Wavier Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Opt Out";
    Caption = 'Housing Waiver Card';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Caption = 'Application No.';
                    Importance = Standard;
                    Editable = RejectEditable;

                    trigger OnAssistEdit()
                    begin
                        If Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Application Date';
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Application Type';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Caption = 'Student No.';
                    Editable = RejectEditable;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Student Name';
                }
                field("Present Address1"; Rec."Present Address1")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = RejectEditable;
                }
                field("Present Address2"; Rec."Present Address2")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = RejectEditable;
                }
                field("Present Address3"; Rec."Present Address3")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = RejectEditable;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Editable = RejectEditable;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Editable = RejectEditable;
                }

                field(State; Rec.County)
                {
                    ApplicationArea = All;
                    Editable = RejectEditable;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                    Editable = RejectEditable;
                }
                field("Lease Agreement/Contract No."; Rec."Lease Agreement/Contract No.")
                {
                    ApplicationArea = All;
                    Editable = RejectEditable;
                }
                field("Lease Agreement Group"; Rec."Lease Agreement Group")
                {
                    ApplicationArea = All;
                    Editable = RejectEditable;
                }
                field(Transportation; Rec.Transportation)
                {
                    ApplicationArea = All;
                    Editable = RejectEditable;
                    trigger OnValidate()
                    begin
                        IF Rec.Transportation THEN begin
                            EditableBTNVfield := true;
                        end else
                            EditableBTNVfield := false;
                    end;
                }
                field("Transport Cell"; Rec."Transport Cell")
                {
                    ApplicationArea = All;
                    Editable = EditableBTNVfield;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Enrollment No.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Academic Year';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Semester';
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    Caption = 'Term';
                    Editable = RejectEditable;
                }

                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    Caption = 'Reason';

                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                    Caption = 'Reason Description';
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                Visible = Boolean_gBool;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    StudentRec: Record "Student Master-CS";
                    StudentHoldRec: Record "Student Hold";
                    HousingApplication_lRec: Record "Housing Application";
                    usersetupapprover: Record "Document Approver Users";
                    StudentMaster_lRec: Record "Student Master-CS";
                    StudentMaster_lRec1: Record "Student Master-CS";
                    CourseMAster: Record "Course Master-CS";
                    SalesForceCodeunit: Codeunit SLcMToSalesforce;
                    HousingMail_lCU: Codeunit "Hosusing Mail";
                    Text50000Lbl: Label 'Do you want to approve Application No. %1 ?';
                    Text50001Lbl: Label 'Application No. %1 has been approved.';
                begin
                    usersetupapprover.Reset();
                    usersetupapprover.setrange("User ID", UserId());
                    usersetupapprover.SetFilter(usersetupapprover."Department Approver Type", '%1', usersetupapprover."Department Approver Type"::"Residential Services");
                    IF not usersetupapprover.FindFirst() then
                        Error('You do not have permission to Approve the Application');
                    // if UserSetup.Get(UserId()) then
                    //     if UserSetup."Department Approver" <> UserSetup."Department Approver"::"Residential Services" then
                    //         Error('You do not have permission to Approve the Application');

                    Rec.TestField("Present Address1");

                    // StudentRec.Reset();
                    // StudentRec.Get("Student No.");
                    // if StudentRec.HostelRoomBedAssigned("Student No.", 2) <> '' then
                    //     Error('Housing is already assigned to Student No. %1', "Student No.");
                    // Testfield("Post Code");
                    // TestField(City);
                    // TestField(County);
                    // TestField(Country);

                    HousingMail_lCU.CheckHousingApplication(Rec."Student No.", Rec.Semester, Rec."Academic Year", Rec.Term);

                    EducationSetup.Reset();
                    EducationSetup.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    EducationSetup.SetRange("Pre Housing App. Allowed", false);
                    if EducationSetup.FindFirst() then begin
                        if EducationSetup."Even/Odd Semester" <> Rec.Term then
                            Error('No action can be taken in the Application No.%1 as it is not from current Term or Academic Year.', Rec."Application No.");
                        if EducationSetup."Academic Year" <> Rec."Academic Year" then
                            Error('No action can be taken in the Application No.%1 as it is not from current Term or Academic Year.', Rec."Application No.");
                    end;
                    If Rec.Status = Rec.Status::"Pending for Approval" then begin
                        // TestField("Lease Agreement/Contract No.");
                        // TestField("Lease Agreement Group");
                        //TestField("Reason Description");
                        If Confirm(Text50000Lbl, true, Rec."Application No.") then begin
                            Rec.Status := Rec.Status::Approved;
                            Rec."Approved/Rejected By" := Format(UserId());
                            Rec."Approved/Rejected On" := Today();
                            Rec.Modify();

                            //HousingWaiverApprovalMail();
                            recStudentMaster.Reset();
                            recStudentMaster.SetRange("No.", Rec."Student No.");
                            // recStudentMaster.SetRange("Academic Year", "Academic Year");
                            // recStudentMaster.SetRange(Semester, Semester);
                            IF recStudentMaster.FindFirst() then begin
                                recStudentMaster.Address3 := Rec."Present Address1";
                                recStudentMaster.Address4 := Rec."Present Address2";
                                recStudentMaster."Address To" := Rec."Present Address3";
                                recStudentMaster."Transport Facility" := Rec.Transportation;
                                recStudentMaster."Lease Agreement/Contract No." := Rec."Lease Agreement/Contract No.";
                                recStudentMaster."Lease Agreement Group" := Rec."Lease Agreement Group";
                                recStudentMaster."Cor Post Code" := Rec."Post Code";
                                recStudentMaster."Cor City" := Rec.City;
                                recStudentMaster."Cor State" := Rec.County;
                                recStudentMaster."Cor Country Code" := Rec.Country;
                                CourseMAster.Reset();
                                CourseMAster.SetRange(Code, recStudentMaster."Course Code");
                                IF CourseMAster.FindFirst() then
                                    IF (CourseMAster."New OLR Enabled") or (CourseMAster."Returning OLR Enabled") then begin
                                        // recStudentMaster."OLR Email Sent" := true;//CSPL-00307 - Code Comment as per Sanjay Sir 16-01-2023
                                        // recStudentMaster."OLR Email Sent Date" := Today();
                                    end;
                                recStudentMaster.Modify();
                            end;

                            //CS-02-07-2021
                            StudentMaster_lRec.Reset();
                            StudentMaster_lRec.SetRange("No.", Rec."Student No.");
                            IF StudentMaster_lRec.FindFirst() then begin
                                StudentMaster_lRec1.Reset();
                                StudentMaster_lRec1.SetRange("Original Student No.", StudentMaster_lRec."Original Student No.");
                                IF StudentMaster_lRec1.FindSet() then begin
                                    repeat
                                        StudentHoldRec.Reset();
                                        StudentHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                                        StudentHoldRec.SetRange("Hold Type", StudentHoldRec."Hold Type"::Housing);
                                        IF StudentHoldRec.FindFirst() then begin
                                            RecStudentWiseHold.Reset();
                                            RecStudentWiseHold.SetRange("Student No.", StudentMaster_lRec1."No.");
                                            RecStudentWiseHold.SetRange("Hold Type", RecStudentWiseHold."Hold Type"::Housing);
                                            IF RecStudentWiseHold.FindFirst() then begin
                                                RecStudentWiseHold.Validate(Status, RecStudentWiseHold.Status::Disable);
                                                RecStudentWiseHold."Hold Description" := StudentHoldRec."Signoff Description";
                                                IF RecStudentWiseHold.Modify() then begin
                                                    RecCodeUnit50037.HoldStatusLedgerEntryInsert(StudentMaster_lRec1."No.", RecStudentWiseHold."Hold Code",
                                    RecStudentWiseHold."Hold Description", RecStudentWiseHold."Hold Type"::Housing, RecStudentWiseHold.Status);

                                                end;
                                            end;
                                        end;
                                    until StudentMaster_lRec1.Next() = 0;
                                end;
                            end;
                            // SalesForceCodeunit.HousingAllomentInformationSFInsert(Rec, HousingApplication_lRec, 1);// Only one API will be called - 08June2021
                            SalesForceCodeunit.HousingWaiverAndApplicationAPI(HousingApplication_lRec, Rec, 1);
                            CurrPage.Update();
                            Message(Text50001Lbl, Rec."Application No.");
                            CurrPage.Close();
                        end;
                    end;
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Reject;
                Visible = RejectButtonShow;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    usersetupapprover: Record "Document Approver Users";
                    HousingApplication_lRec: Record "Housing Application";
                    SalesForceCodeunit: Codeunit SLcMToSalesforce;
                    Text50000Lbl: Label 'Do you want to reject Application No. %1 ?';
                    Text50001Lbl: Label 'Application No. %1 has been rejected.';
                begin
                    usersetupapprover.Reset();
                    usersetupapprover.setrange("User ID", UserId());
                    usersetupapprover.SetFilter(usersetupapprover."Department Approver Type", '%1', usersetupapprover."Department Approver Type"::"Residential Services");
                    IF not usersetupapprover.FindFirst() then
                        Error('You do not have permission to Reject the Application');
                    // if UserSetup.Get(UserId()) then
                    //     if UserSetup."Department Approver" <> UserSetup."Department Approver"::"Residential Services" then
                    //         Error('You do not have permission to Reject the Application');
                    EducationSetup.Reset();
                    EducationSetup.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    EducationSetup.SetRange("Pre Housing App. Allowed", false);
                    if EducationSetup.FindFirst() then begin
                        if EducationSetup."Even/Odd Semester" <> Rec.Term then
                            Error('No action can be taken in the Application No.%1 as it is not from current Term or Academic Year.', Rec."Application No.");
                        if EducationSetup."Academic Year" <> Rec."Academic Year" then
                            Error('No action can be taken in the Application No.%1 as it is not from current Term or Academic Year.', Rec."Application No.");
                    end;
                    If (Rec.Status IN [Rec.Status::"Pending for Approval", Rec.Status::Approved]) then begin
                        Rec.TestField("Reason Description");
                        If Confirm(Text50000Lbl, true, Rec."Application No.") then begin
                            Rec.Status := Rec.Status::Rejected;
                            Rec."Approved/Rejected By" := Format(UserId());
                            Rec."Approved/Rejected On" := Today();
                            Rec.Modify();
                            // SalesForceCodeunit.HousingAllomentInformationSFInsert(Rec, HousingApplication_lRec, 1);// Only one API will be called - 08June2021
                            SalesForceCodeunit.HousingWaiverAndApplicationAPI(HousingApplication_lRec, Rec, 1);
                            //HousingWaiverRejectionMail();
                            CurrPage.Update();
                            Message(Text50001Lbl, Rec."Application No.");
                            CurrPage.Close();
                        end;
                    End;
                end;
            }

            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
        }
    }

    var
        recStudentMaster: Record "Student Master-CS";
        RecStudentWiseHold: Record "Student Wise Holds";
        RecCodeUnit50037: Codeunit "Hosusing Mail";
        EducationSetup: Record "Education Setup-CS";
        UserSetup: Record "User Setup";
        Boolean_gBool: Boolean;
        EditableBTNVfield: Boolean;
        RejectButtonShow: Boolean;

        RejectEditable: Boolean;




    trigger OnOpenPage()
    begin
        EditableBTNVfield := false;
        Boolean_gBool := false;
        if Rec.Status = Rec.Status::"Pending for Approval" then
            Boolean_gBool := true;

        RejectButtonShow := False;
        IF (Rec.Status In [Rec.Status::"Pending for Approval", Rec.Status::Approved]) then
            RejectButtonShow := true;

        RejectEditable := true;
        IF Rec.Status = Rec.Status::Approved then
            RejectEditable := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    Begin
        EditableBTNVfield := false;
        Rec."Application Type" := Rec."Application Type"::"Housing Wavier";
        Rec.Status := Rec.Status::"Pending for Approval";


    End;

    trigger OnAfterGetRecord()
    Begin
        Boolean_gBool := false;
        if Rec.Status = Rec.Status::"Pending for Approval" then
            Boolean_gBool := true;

        IF Rec.Transportation THEN
            EditableBTNVfield := true
        else
            EditableBTNVfield := false;

        RejectButtonShow := False;
        IF (Rec.Status In [Rec.Status::"Pending for Approval", Rec.Status::Approved]) then
            RejectButtonShow := true;

        RejectEditable := true;
        IF Rec.Status = Rec.Status::Approved then
            RejectEditable := false;

    End;

}