page 50037 "Student List On Roll-CS"
{
    // version V.001-CS

    // Sr.No  Emp.Id      Date      Trigger                              Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  06-05-19   Card - OnAction()                    Code added for page run.
    // 02.   CSPL-00174  06-05-19   Student Data Upload - OnAction()     Code added for student data upload.
    // 03.   CSPL-00174  06-05-19   Update Student Details - OnAction()  Code added for update student details.
    // 04.   CSPL-00174  06-05-19   Send Data to Portal - OnAction()     Code added for send data to the portal.

    Caption = 'Student List On Roll';
    CardPageID = "Student Detail Card-CS";
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Student Master-CS";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Student No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Student No.';
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Enquiry No."; Rec."Enquiry No.")
                {
                    ApplicationArea = All;
                }
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field("Updated On"; Rec."Updated On")
                {
                    ApplicationArea = All;
                }
                field("Updated By"; Rec."Updated By")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(Group; Rec.Group)
                {
                    ApplicationArea = All;
                }
                field("Customer Exists"; Rec."Customer Exists")
                {
                    ApplicationArea = All;
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                }
                field("Parent Login Password"; Rec."Parent Login Password")
                {
                    ApplicationArea = All;
                }
                field("OLR Completed"; Rec."OLR Completed")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Fee Classification Code"; Rec."Fee Classification Code")
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Fathers Name"; Rec."Fathers Name")
                {
                    ApplicationArea = All;
                }
                field("Resident Status"; Rec."Resident Status")
                {
                    ApplicationArea = All;
                }
                field("Blood Group"; Rec."Blood Group")
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field("Guardian Name"; Rec."Guardian Name")
                {
                    ApplicationArea = All;
                }
                field("Mothers Name"; Rec."Mothers Name")
                {
                    ApplicationArea = All;
                }
                field(Domicile; Rec.Domicile)
                {
                    ApplicationArea = All;
                }
                field("Guardian Annual Income"; Rec."Guardian Annual Income")
                {
                    ApplicationArea = All;
                }
                field(Religion; Rec.Religion)
                {
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = All;
                }
                field(Graduation; Rec.Graduation)
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
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }

                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                }
                field("Admitted Year"; Rec."Admitted Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date of Joining"; Rec."Date of Joining")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(Address1; Rec.Address1)
                {
                    ApplicationArea = All;
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                }
                field(District; Rec.District)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }
                field("Same As Permanent Address"; Rec."Same As Permanent Address")
                {
                    ApplicationArea = All;
                }
                field(Address3; Rec.Address3)
                {
                    ApplicationArea = All;
                    Caption = 'Correspondence Address 1';
                }
                field(Address4; Rec.Address4)
                {
                    ApplicationArea = All;
                    Caption = 'Correspondence Address 2';
                }
                field("Cor City"; Rec."Cor City")
                {
                    ApplicationArea = All;
                    Caption = 'Correspondence City';
                }
                field("Cor State"; Rec."Cor State")
                {
                    ApplicationArea = All;
                    Caption = 'Correspondence State';
                }
                field("Cor Country Code"; Rec."Cor Country Code")
                {
                    ApplicationArea = All;
                    Caption = 'Correspondence Country Code';
                }
                field("Cor Post Code"; Rec."Cor Post Code")
                {
                    ApplicationArea = All;
                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                    ApplicationArea = All;
                }
                field("Emergency Contact No."; Rec."Emergency Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Mother Tongue"; Rec."Mother Tongue")
                {
                    ApplicationArea = All;
                }
                field("Pre Qualification"; Rec."Pre Qualification")
                {
                    ApplicationArea = All;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field(Batch; Rec.Batch)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(NCL; Rec.Disability)
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
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for page run::CSPL-00174::060519: Start
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE(StudentMasterCS."No.", Rec."No.");
                        IF StudentMasterCS.FINDFIRST() THEN
                            PAGE.RUN(Page::"Student Detail Card-CS", StudentMasterCS);
                        //Code added for page run::CSPL-00174::060519: End
                    end;
                }
                action("Student Data Upload")
                {
                    Caption = 'Student Data Upload';
                    Image = Import;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Code added for student data upload::CSPL-00174::060519: Start
                        XMLPORT.RUN(Xmlport::"Student Data Upload-CS", TRUE, TRUE, Rec);
                        //Code added for student data upload::CSPL-00174::060519: End
                    end;
                }
                action("Update Student Details")
                {
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for update student details::CSPL-00174::060519: Start
                        XMLPORT.RUN(Xmlport::"Student Data Modification", TRUE, TRUE, Rec);
                        //Code added for update student details::CSPL-00174::060519: End
                    end;
                }
                /*action("Send Data to Portal")
                {
                     Promoted = true;
                PromotedOnly = true;

                     trigger OnAction()
                    begin
                        //Code added for send data to the portal::CSPL-00174::060519: Start
                        IF ISCLEAR(lADOConnection) THEN CREATE(lADOConnection, FALSE, TRUE);
                        lADOConnection.ConnectionString := 'Driver={SQL Server};Server=172.16.18.154;Database=ManipalUniversity;Uid=sa;Pwd=slmsa#345#';
                        lADOConnection.Open;

                        IF ISCLEAR(lADOCommand) THEN
                            CREATE(lADOCommand, FALSE, TRUE);

                        lvarActiveConnection := lADOConnection;
                        lADOCommand.ActiveConnection := lvarActiveConnection;

                        lADOCommand.CommandText := 'Int_Send_New_Student_Date_To_Portal_And_Send_For_Mail';

                        lADOCommand.CommandType := 4;
                        lADOCommand.CommandTimeout := 0;
                        lADOCommand.Execute;
                        lADOConnection.Close();
                        CLEAR(lADOConnection);
                        CLEAR(lADOParameter);
                        CLEAR(lADOCommand);

                        MESSAGE('Done Successfully');
                        //Code added for Send data to the portal::CSPL-00174::060519: End
                    end;
                } */
                action("Page Customer Ledger Entries")
                {
                    ApplicationArea = All;
                    ToolTip = 'Customer Ledger Entries';
                    Caption = 'Ledger E&ntries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Ledger Entries";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Student Card")
                {
                    Image = Card;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    RunObject = Page "Student Detail Card-CS";
                    // RunPageLink = "No." = FIELD("No.");
                    Visible = false;
                }
                action("Legacy Ledger")
                {
                    Image = Alerts;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedOnly = true;
                    RunObject = Page "Staff Usual Record List -CS";
                    RunPageLink = "Course Code" = FIELD("Enrollment No.");
                }
                action("Student Details Mentors Import")
                {
                    Image = ListPage;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedOnly = true;
                    RunObject = Page "Guardian Teacher List-CS";
                }
                action("Course Section")
                {
                    RunObject = Page "Course Section Detail-CS";
                    ApplicationArea = All;
                }
            }
        }
    }

    var

        /* lADOConnection: Automation;
        lADOCommand: Automation;
        lADOParameter: Automation; Rec.*/
        StudentMasterCS: Record "Student Master-CS";
}