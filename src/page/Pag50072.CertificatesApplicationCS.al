page 50072 "Certificates Application-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                           Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  12-06-19   Rejected - OnAction()            Code added for confirmation message with modify data.
    // 02.   CSPL-00174  12-06-19   Approved/Printed - OnAction()    Code added for Report run and Sending Mail.

    CardPageID = "Certificates Appl Card-CS";
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Certificates Application-CS";
    SourceTableView = sorting("Application Date")
                      order(descending) WHERE(Status = FILTER(Pending));
    Caption = 'Pending Transcript/Degree Request List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field(Certificate; Rec.Certificate)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                Field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                Field("Bursar Hold Exist"; Rec."Bursar Hold Exist")
                {
                    ApplicationArea = All;
                }
                field("Mode of Collection"; Rec."Mode of Collection")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                }

                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
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
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Application Category"; Rec."Application Category")
                {
                    ApplicationArea = All;
                }
                field("Last Date/Time of Application"; Rec."Last Date/Time of Application")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                    Visible = false;
                }
                field("App Category Classification"; Rec."App Category Classification")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                }
                field("Status Date"; Rec."Status Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
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
                    Visible = false;
                }

                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
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
        }
    }

    var

}