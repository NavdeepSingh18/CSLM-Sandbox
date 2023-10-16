page 50923 "Student List for Residency"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                                             Remarks
    // 1         CSPL-00092    29-05-2019    <Action1102155025> - OnAction                       Page Run
    // 2         CSPL-00092    29-05-2019    Student Data Upload - OnAction                      XMLPort Run
    // 3         CSPL-00092    29-05-2019    Update Student Details - OnAction                   XMLPort Run
    // 4         CSPL-00092    29-05-2019    Send Data to Portal - OnAction                      Call Sql Procedure to Send data to Portal Database
    // 5         CSPL-00092    29-05-2019    Not Completed Lower Semester(NCL) - OnAction        Find and update Disability False for Student Not Completed Lower Semester(NCL)

    Caption = 'Student List';
    CardPageID = "Student Detail Card-CS";
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate,Admissions,Registrar/Academics,Clinical,Immigration,Bursar/Finance,Financial Aid,EED Pre-Clinical,EED Clinical Science,Graduate Affairs,Feedback';
    SourceTable = "Student Master-CS";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending);
    RefreshOnActivate = true;
    UsageCategory = None;

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
        area(factboxes)
        {

            part("Residency Fact Box"; "Residency Fact Box")
            {
                ApplicationArea = All;
                SubPageLink = "Student No." = FIELD("No.");
            }

        }
    }

    actions
    {
        area(Processing)
        {
            group("360 Degree View")
            {
                Image = ViewDetails;
                Caption = '360 Degree View';

                group("Graduate Affairs")
                {
                    action("Student Residency")
                    {
                        Caption = 'Student Residency List';
                        Image = EntriesList;
                        ApplicationArea = All;
                        Promoted = true;
                        PromotedIsBig = true;
                        PromotedCategory = Process;
                        RunObject = Page "Residency List";
                        RunPageLink = "Student No." = FIELD("No.");
                    }
                    action("USMLE Step 1 Score List")
                    {
                        // RunObject = Page "";
                        Visible = true;
                        ApplicationArea = Basic, Suite;
                    }
                    Action("USMLE Step 2 CK Score List")
                    {
                        // RunObject = Page "";
                        Visible = true;
                        ApplicationArea = Basic, Suite;
                    }
                    action("USMLE Step 2 CS Score List")
                    {
                        // RunObject = Page "";
                        Visible = true;
                        ApplicationArea = Basic, Suite;
                    }
                    Action("Core Rotation Scheduling")
                    {
                        RunObject = Page "Roster Scheduling Subpage";//50441
                                                                     // RunPageView = where();
                        ApplicationArea = Basic, Suite;
                    }
                    action("Core Rotation Evaluation")
                    {
                        RunObject = Page "Subject Student-CS";//50001
                                                              // RunPageView = where();
                        ApplicationArea = Basic, Suite;
                    }
                    action("Elective Rotation Scheduling")
                    {
                        RunObject = Page "Roster Scheduling Subpage";//50441
                                                                     // RunPageView = where();
                        ApplicationArea = Basic, Suite;
                    }
                    action("Elective Rotation Evaluation")
                    {
                        RunObject = page "Subject Student-CS";//50001
                                                              // RunPageView = where();
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Promotion List-2")
                    {
                        Caption = 'Student Promotion List';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Promotion Student List-CS";
                        RunPageLink = "Course" = FIELD("Course Code");
                    }

                }
            }

        }
    }
}