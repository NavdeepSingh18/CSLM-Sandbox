page 50017 "Fee Generation-Student-CS"
{
    // version V.001-CS

    // Sr.No Emp.ID       Date       Trigger                       Remarks
    // ------------------------------------------------------------------------------------------------------------
    // 01.   CSPL-00174   04-04-19   OnOpenPage()                  Code added for academic year wise page filter.
    // 02.   CSPL-00174   04-04-19   Fee Generation - OnAction()   Code added for Fee Generation .
    // 03.   CSPL-00174   04-04-19   Select All - OnAction()       Code added for update data .
    // 04.   CSPL-00174   04-04-19   UnSelect All - OnAction()     Code added for update data .

    DeleteAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Customer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Fees to Generate"; Rec."Fees to Generate")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Net Change"; Rec."Net Change")
                {
                    ApplicationArea = All;
                }
                field("Net Change (LCY)"; Rec."Net Change (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
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
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Convert to Student"; Rec."Convert to Student")
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Parents Income"; Rec."Parents Income")
                {
                    ApplicationArea = All;
                }
                field("Scholarship Source"; Rec."Scholarship Source")
                {
                    ApplicationArea = All;
                }
                field("Internal Rank"; Rec."Internal Rank")
                {
                    ApplicationArea = All;
                }
                field("Entrance Test Rank"; Rec."Entrance Test Rank")
                {
                    ApplicationArea = All;
                }
                field("Admitted Year"; Rec."Admitted Year")
                {
                    ApplicationArea = All;
                }
                field("Check Manually"; Rec."Check Manually")
                {
                    ApplicationArea = All;
                }
                field("Fee Generated"; Rec."Fee Generated")
                {
                    ApplicationArea = All;
                }
                field("Certification Course"; Rec."Certification Course")
                {
                    ApplicationArea = All;
                }
                field("Parent Customer"; Rec."Parent Customer")
                {
                    ApplicationArea = All;
                }
                field("Branch Transfer"; Rec."Branch Transfer")
                {
                    ApplicationArea = All;
                }
                field("Lateral Student"; Rec."Lateral Student")
                {
                    ApplicationArea = All;
                }
                field("Program"; Rec."Program")
                {
                    ApplicationArea = All;
                }
                field("Pending For Registration"; Rec."Pending For Registration")
                {
                    ApplicationArea = All;
                }
                field("Course Completion NOC"; Rec."Course Completion NOC")
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field(Batch; Rec.Batch)
                {
                    ApplicationArea = All;
                }
                field("Roll No."; Rec."Roll No.")
                {
                    ApplicationArea = All;
                }
                field("Student Status"; Rec."Student Status")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(Session; Rec.Session)
                {
                    ApplicationArea = All;
                }
                field("Hostel Accomadation"; Rec."Hostel Accomadation")
                {
                    ApplicationArea = All;
                }
                field("Transport Accomadation"; Rec."Transport Accomadation")
                {
                    ApplicationArea = All;
                }
                field("Student Mother Name"; Rec."Student Mother Name")
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                }
                field("Fee Classification Code"; Rec."Fee Classification Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Student")
            {
                Caption = '&Student';
                // action("Fee Generation")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Fee Generation';
                //     Image = EditLines;
                //     Promoted = true;
                //     PromotedOnly = true;
                //     PromotedCategory = Process;

                //     trigger OnAction()
                //     begin
                //         //Code added for fee generation::CSPL-00174::040419: Start
                //         IF CONFIRM(Text_10001Lbl, FALSE) THEN BEGIN
                //             CustomerRec.Reset();
                //             CustomerRec.SETRANGE("Fees to Generate", TRUE);
                //             IF CustomerRec.FINDSET() THEN
                //                 REPORT.RUN(report::"Fee Generation Tick-CS", FALSE, FALSE, CustomerRec)
                //             ELSE
                //                 ERROR('Please Select Customers To Generate Fees');
                //         END ELSE
                //             EXIT;
                //         //Code added for fee generation::CSPL-00174::040419: End
                //     end;
                // }
                action("Select All")
                {
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for update data::CSPL-00174::040419: Start
                        Rec.MODIFYALL("Fees to Generate", TRUE);
                        //Code added for update data::CSPL-00174::040419: End
                    end;
                }
                action("UnSelect All")
                {
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for update data::CSPL-00174::040419: Start
                        Rec.MODIFYALL("Fees to Generate", FALSE);
                        //Code added for update data::CSPL-00174::040419: End
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Code added for academic year wise page filter::CSPL-00174::040419: Start
        UserSetup.GET(UserId());

        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        IF EducationSetupCS.FINDFIRST() THEN
            Rec.SETFILTER("Academic Year", EducationSetupCS."Academic Year");
        //Code added for academic year wise page filter::CSPL-00174::040419: End
    end;

    var
        EducationSetupCS: Record "Education Setup-CS";
        CustomerRec: Record Customer;
        UserSetup: Record "User Setup";
        Text_10001Lbl: Label 'Do You Want To Generate Students Fee ?';
}

