page 50652 "Financial AID Pending List"
{

    PageType = List;
    SourceTable = "Financial AID";
    Caption = 'Pending Financial Aid Applications';
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Financial AID";
    SourceTableView = Sorting("Created On") order(Descending) Where(Status = filter("Pending for Approval"), "Type" = filter("Financial Aid"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Caption = 'Application No.';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Application Date';
                }
                field("Student No."; Rec."Student No.")
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

                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    Caption = 'Reason';

                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                    Caption = 'Reason Description';

                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = false;
                }
                field("Approved/Rejected By"; Rec."Approved/Rejected By")
                {
                    ApplicationArea = All;
                    Caption = 'Approved/Rejected By';
                    Editable = False;
                }
                field("Approved/Rejected On"; Rec."Approved/Rejected On")
                {
                    ApplicationArea = All;
                    Caption = 'Approved/Rejected On';
                    Editable = false;
                }
                field("FSA ID"; Rec."FSA ID")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
                field("Entrance Counseling"; Rec."Entrance Counseling")
                {
                    ApplicationArea = All;
                }
                field("Unsubsidized Loan"; Rec."Unsubsidized Loan")
                {
                    ApplicationArea = All;
                }
                field("Direct Graduate plus loan"; Rec."Direct Graduate plus loan")
                {
                    ApplicationArea = All;
                }
                field("Living expenses"; Rec."Living expenses")
                {
                    ApplicationArea = All;
                }
                field("Grad. Plus Transaction Amount"; Rec."Grad. Plus Transaction Amount")
                {
                    ApplicationArea = All;
                }


                field("Unsubsidized Transation Amount"; Rec."Unsubsidized Transation Amount")
                {
                    ApplicationArea = All;
                }

                field("Grad PLUS Denial"; Rec."Grad PLUS Denial")
                {

                    ApplicationArea = All;
                }

                field(Endorse; Rec.Endorse)
                {

                    ApplicationArea = All;
                }

                field("Loan Amount"; Rec."Loan Amount")
                {

                    ApplicationArea = All;
                }
            }
        }
    }

    //SD-SN-17-Dec-2020 +
    trigger OnOpenPage()
    var
        StudentsInfoCSCSLM: codeunit StudentsInfoCSCSLM;

    begin

        Rec.FilterGroup(2);
        Rec.SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        Rec.FilterGroup(0);
    end;
    //SD-SN-17-Dec-2020 -
}
