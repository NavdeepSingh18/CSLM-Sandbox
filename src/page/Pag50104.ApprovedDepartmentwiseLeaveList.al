page 50104 "Approved Departmentment Leave"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Leaves Approvals";
    Caption = 'Approved Departmentwise Leave List';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    // CardPageId = "Leaves Approval Card";
    SourceTableView = sorting("Application No.", "Line No.") order(descending) where(status = Filter(Approved | Rejected));
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Caption = 'Application No.';

                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Caption = 'Student No.';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Caption = 'Student Name';
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                    Caption = 'Enrollment No.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Caption = 'Semester';
                }
                field("Type of Leaves"; Rec."Type of Leaves")
                {
                    ApplicationArea = All;
                    Caption = 'Type of Leave';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
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
            action("SLOA Bulk Email")
            {
                ApplicationArea = All;
                Visible = Rec."Type of Leaves" = Rec."Type of Leaves"::SLOA;
                trigger OnAction()
                var
                // Page50717: Page 50717;
                begin
                    // Clear(Page50717);
                    // Page50717.SLOABulkMailSend();
                end;
            }

        }
    }

    trigger OnOpenPage()
    var
        WithdrawalDepartmentRec: Record "Withdrawal Department";
        UserSetupRec: Record "User Setup";
        EducationSetupRec: Record "Education Setup-CS";
        PrevDepart: Text;
        // StudentsInfoCSCSLM: codeunit StudentsInfoCSCSLM;
        DepartmentName: Text;
    begin
        UserSetupRec.Get(UserId());
        //CSPL-00307-T1-T1516-CR Starts
        Clear(DepartmentName);
        WithdrawalDepartmentRec.Reset();
        WithdrawalDepartmentRec.SetCurrentKey("Department Code");
        IF Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA then
            WithdrawalDepartmentRec.Setrange("Document Type", WithdrawalDepartmentRec."Document Type"::ELOA);
        IF Rec."Type of Leaves" = Rec."Type of Leaves"::SLOA then
            WithdrawalDepartmentRec.Setrange("Document Type", WithdrawalDepartmentRec."Document Type"::SLOA);
        IF Rec."Type of Leaves" = Rec."Type of Leaves"::CLOA then
            WithdrawalDepartmentRec.Setrange("Document Type", WithdrawalDepartmentRec."Document Type"::CLOA);
        // WithdrawalDepartmentRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        IF WithdrawalDepartmentRec.GetUserGroup() <> '' then
            WithdrawalDepartmentRec.SetFilter("User Name", WithdrawalDepartmentRec.GetUserGroup())
        else
            WithdrawalDepartmentRec.SetFilter("User Name", '%1', '');
        WithdrawalDepartmentRec.SetAscending("Department Code", true);
        IF WithdrawalDepartmentRec.FindSet() then begin
            repeat
                IF PrevDepart <> WithdrawalDepartmentRec."Department Code" then begin
                    PrevDepart := WithdrawalDepartmentRec."Department Code";
                    IF DepartmentName = '' then
                        DepartmentName := WithdrawalDepartmentRec."Department Code"
                    ELSE
                        DepartmentName += '|' + WithdrawalDepartmentRec."Department Code";
                end;
            Until WithdrawalDepartmentRec.Next() = 0;
        end;

        Rec.FILTERGROUP(2);
        IF DepartmentName = '' then
            Rec.SetFilter("Approved for Department", '%1', '')
        else
            Rec.SetFilter("Approved for Department", DepartmentName);
        Rec.FILTERGROUP(0);
        //CSPL-00307-T1-T1516-CR Ends

        //SD-SN-17-Dec-2020 +
        // FilterGroup(3);
        // SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        // FilterGroup(5);
        //SD-SN-17-Dec-2020 -
    end;
}