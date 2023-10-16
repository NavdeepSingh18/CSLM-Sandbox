page 50846 "Advising Request List"
{
    Editable = false;
    ApplicationArea = All;
    Caption = 'Pending Advising Request List';
    PageType = List;
    SourceTable = "Advising Request";
    UsageCategory = Administration;
    CardPageId = "Advising Request Card";
    SourceTableView = sorting("Request Date") order(descending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Request No"; Rec."Request No")
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    visible = false;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = all;
                }
                field("Student Email"; Rec."Student Email")
                {
                    ApplicationArea = all;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("Student Status"; Rec."Student Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Status field.';
                    Editable = False;
                    visible = NOT Hide_For_PreClinical;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Advisor ID"; Rec."Advisor ID")
                {
                    ApplicationArea = All;
                    visible = false;
                }
                field(AdvisorName; AdvisorName)
                {
                    Caption = 'Advisor Name';
                    ApplicationArea = All;
                }
                field("Request Status"; Rec."Request Status")
                {
                    ApplicationArea = All;
                }
                field("Reason Program Code"; Rec."Reason Program Code")
                {
                    ApplicationArea = All;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                }
                field("Advising Topic Code"; Rec."Advising Topic Code")
                {
                    ApplicationArea = All;
                    Visible = Hide_For_Preclinical;
                }
                field("Advising Topic Description"; Rec."Advising Topic Description")
                {
                    ApplicationArea = All;
                    Visible = (Hide_For_Preclinical);
                }
                field("Meeting Date"; Rec."Meeting Date")
                {
                    ApplicationArea = All;
                }
                field("Meeting Start Time"; Rec."Meeting Start Time 1")
                {
                    ApplicationArea = All;
                }
                field("Meeting End Time"; Rec."Meeting End Time 1")
                {
                    ApplicationArea = All;
                }
                field(Requestor; Rec.Requestor)
                {
                    ApplicationArea = all;
                }
                // field("Requested Meeting Date1";Rec."Requested Meeting Date1")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Requested Meeting Start Time1";Rec."Requested Meeting Start Time 1")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Requested Meeting End Time 1";Rec."Requested Meeting End Time1")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Requested Meeting Date2";Rec."Requested Meeting Date2")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Requested Meeting Start Time2";Rec."Requested Meeting Start Time 2")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Requested Meeting End Time 2";Rec."Requested Meeting End Time2")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Requested Meeting Date3";Rec."Requested Meeting Date3")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Requested Meeting Start Time3";Rec."Requested Meeting Start Time 3")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Requested Meeting End Time 3";Rec."Requested Meeting End Time3")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                field("Meeting Mode"; Rec."Meeting Mode")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Next Advising Request No"; Rec."Next Advising Request No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Previous Advising Request No"; Rec."Previous Advising Request No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                // field("Rescheduled Old Req. No.";Rec."Rescheduled Old Req. No.")
                // {
                //     ApplicationArea = all;
                //     DrillDown = true;
                //     Lookup = true;

                //     trigger OnLookup(Var myText: text): Boolean
                //     var
                //         ApprovedAdReq: page "Rej. Or Comp. Adv. Req. Card";
                //         ConfirmAdReq: Page "App. Or Res. Adv. Req. Card";
                //         PendingAdReq: Page "Advising Request Card";
                //         AdvicingReq: Record "Advising Request";
                //     begin
                //         AdvicingReq.Reset();
                //         AdvicingReq.SetRange("Request No", "Rescheduled Old Req. No.");
                //         if AdvicingReq.FindFirst() then begin
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::" ", AdvicingReq."Request Status"::Pending] then begin
                //                 PendingAdReq.SetTableView(AdvicingReq);
                //                 PendingAdReq.Run();
                //             end;
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::Rescheduled, AdvicingReq."Request Status"::Rejected, AdvicingReq."Request Status"::Completed] then begin
                //                 ApprovedAdReq.SetTableView(AdvicingReq);
                //                 ApprovedAdReq.Run();
                //             end;
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::Approved] then begin
                //                 ConfirmAdReq.SetTableView(AdvicingReq);
                //                 ConfirmAdReq.Run();
                //             end;
                //         end;
                //     end;

                //     trigger OnDrillDown()
                //     var
                //         ApprovedAdReq: page "Rej. Or Comp. Adv. Req. Card";
                //         ConfirmAdReq: Page "App. Or Res. Adv. Req. Card";
                //         PendingAdReq: Page "Advising Request Card";
                //         AdvicingReq: Record "Advising Request";
                //     begin
                //         AdvicingReq.Reset();
                //         AdvicingReq.SetRange("Request No", "Rescheduled Old Req. No.");
                //         if AdvicingReq.FindFirst() then begin
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::" ", AdvicingReq."Request Status"::Pending] then begin
                //                 PendingAdReq.SetTableView(AdvicingReq);
                //                 PendingAdReq.Run();
                //             end;
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::Rescheduled, AdvicingReq."Request Status"::Rejected, AdvicingReq."Request Status"::Completed] then begin
                //                 ApprovedAdReq.SetTableView(AdvicingReq);
                //                 ApprovedAdReq.Run();

                //             end;
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::Approved] then begin
                //                 ConfirmAdReq.SetTableView(AdvicingReq);
                //                 ConfirmAdReq.Run();
                //             end;
                //         end;
                //     end;

                // }
                // field("Rescheduled New Req. No.";Rec."Rescheduled New Req. No.")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     DrillDown = true;
                //     Lookup = true;

                //     trigger OnLookup(Var myText: text): Boolean
                //     var
                //         ApprovedAdReq: page "Rej. Or Comp. Adv. Req. Card";
                //         ConfirmAdReq: Page "App. Or Res. Adv. Req. Card";
                //         PendingAdReq: Page "Advising Request Card";
                //         AdvicingReq: Record "Advising Request";
                //     begin
                //         AdvicingReq.Reset();
                //         AdvicingReq.SetRange("Request No", "Rescheduled New Req. No.");
                //         if AdvicingReq.FindFirst() then begin
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::" ", AdvicingReq."Request Status"::Pending] then begin
                //                 PendingAdReq.SetTableView(AdvicingReq);
                //                 PendingAdReq.Run();
                //             end;
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::Rescheduled, AdvicingReq."Request Status"::Rejected, AdvicingReq."Request Status"::Completed] then begin
                //                 ApprovedAdReq.SetTableView(AdvicingReq);
                //                 ApprovedAdReq.Run();
                //             end;
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::Approved] then begin
                //                 ConfirmAdReq.SetTableView(AdvicingReq);
                //                 ConfirmAdReq.Run();
                //             end;
                //         end;
                //     end;

                //     trigger OnDrillDown()
                //     var
                //         ApprovedAdReq: page "Rej. Or Comp. Adv. Req. Card";
                //         ConfirmAdReq: Page "App. Or Res. Adv. Req. Card";
                //         PendingAdReq: Page "Advising Request Card";
                //         AdvicingReq: Record "Advising Request";
                //     begin
                //         AdvicingReq.Reset();
                //         AdvicingReq.SetRange("Request No", "Rescheduled New Req. No.");
                //         if AdvicingReq.FindFirst() then begin
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::" ", AdvicingReq."Request Status"::Pending] then begin
                //                 PendingAdReq.SetTableView(AdvicingReq);
                //                 PendingAdReq.Run();
                //             end;
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::Rescheduled, AdvicingReq."Request Status"::Rejected, AdvicingReq."Request Status"::Completed] then begin
                //                 ApprovedAdReq.SetTableView(AdvicingReq);
                //                 ApprovedAdReq.Run();
                //             end;
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::Approved] then begin
                //                 ConfirmAdReq.SetTableView(AdvicingReq);
                //                 ConfirmAdReq.Run();
                //             end;
                //         end;
                //     end;

                // }
                // field("Rejected Reason";Rec."Rejected Reason")
                // {
                //     ApplicationArea = All;
                // }
                // field("Rejected Reason Decription";Rec."Rejection Reason Description")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                field("Problem Solution Id"; Rec."Problem Solution Id 1")
                {
                    ApplicationArea = All;
                    caption = 'Problem';
                }
                field("Problem solution description"; Rec."Problem solution description")
                {
                    ApplicationArea = All;
                    Caption = 'Solution';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part("Advising Request Factbox"; "Advising Request Factbox")
            {
                ApplicationArea = All;
                Caption = 'Advising Request Status FactBox';
                SubPageLink = "Request No" = Field("Request No"), "Student No." = Field("Student No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("View/Update Notes")
            {
                ApplicationArea = All;
                Caption = 'View/Update Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    //ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
                    TemplateType: Option " ",Residency,"Clinical Clerkship",Student,Other;
                    GroupType: Option " ","Residency Note","Residency Employement Note","Clinical Clerkship",Student,Other;
                begin
                    Rec.TestField("Student No.");
                    TemplateType := TemplateType::Student;
                    GroupType := GroupType::Student;
                    //ClinicalBaseAppSubscribe.ViewEditStudentNote(Rec."Request No", Rec."Student No.", TemplateType, GroupType);//GMCSCOM
                end;
            }

            action("Add Attachment")
            {
                ApplicationArea = All;
                Caption = 'Add Attachment';
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    StudentMaster: Record "Student Master-CS";
                begin
                    StudentMaster.Reset();
                    StudentMaster.SetRange("No.", Rec."Student No.");
                    //Page.RunModal(Page::"Add Student Attachment", StudentMaster);//GMCSCOM
                end;
            }
            action("Student Card")
            {
                Caption = 'Student Card';
                ApplicationArea = all;
                Image = Employee;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Student: Record "Student Master-CS";
                //StudentCardL: Page "Student Detail Card-CS";

                begin
                    Student.reset();
                    Student.SetRange("No.", Rec."Student No.");
                    if Student.FindFirst() then;
                    // StudentCardL.SetTableView(Student);//GMCSCOM
                    // StudentCardL.Editable(False);
                    // StudentCardL.RunModal();
                    // if Student.FindFirst() then
                    //     Page.RunModal(Page::"Student Detail Card-CS", Student);
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        IntOption: Integer;
        NotAuthLbl: Label 'You are not authorized to access this page.';
    begin
        Rec.FilterGroup(2);
        Rec.Setfilter("Request Status", '%1|%2', Rec."Request Status"::Pending, Rec."Request Status"::" ");
        IntOption := Rec.ChecDocumentAppDepartment();
        case IntOption of
            1:
                begin
                    Rec.SetFilter("Department Type", format(Rec."Department Type"::"EED Pre-Clinical"));
                end;
            2:
                begin
                    Rec.SetFilter("Department Type", format(Rec."Department Type"::"EED Clinical"));
                    Hide_For_Preclinical := true;
                end;
            3:
                begin
                    Rec.SetFilter("Department Type", '%1|%2', Rec."Department Type"::"EED Clinical", Rec."Department Type"::"EED Pre-Clinical");
                    Hide_For_Preclinical := true;
                end;
            4:
                begin
                    Rec.Setfilter("Department Type", '%1|%2|%3', Rec."Department Type"::"EED Clinical", Rec."Department Type"::"EED Pre-Clinical", Rec."Department Type"::" ");
                    Hide_For_Preclinical := true;
                end;
            0:
                begin
                    Error(NotAuthLbl);
                end;
        end;
        Rec.FilterGroup(0);

        Clear(AdvisorName);
        if EmployeeRec.Get(Rec."Advisor ID") then
            AdvisorName := EmployeeRec."First Name" + ' ' + EmployeeRec."Last Name";
    end;

    trigger OnAfterGetRecord()
    begin
        Clear(AdvisorName);
        if EmployeeRec.Get(Rec."Advisor ID") then
            AdvisorName := EmployeeRec."First Name" + ' ' + EmployeeRec."Last Name";
    end;

    var
        EmployeeRec: Record Employee;
        AdvisorName: Text[250];
        Hide_For_Preclinical: Boolean;

}
